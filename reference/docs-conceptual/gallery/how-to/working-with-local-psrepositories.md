---
ms.date:  11/06/2018
title:  Working with local PSRepositories
description: The PowerShellGet module support repositories other than the PowerShell Gallery. This article describes how to set up a local PowerShell repository.
---

# Working with Private PowerShellGet Repositories

The PowerShellGet module support repositories other than the PowerShell Gallery.
These cmdlets enable the following scenarios:

- Support a trusted, pre-validated set of PowerShell modules for use in your environment
- Testing a CI/CD pipeline that builds PowerShell modules or scripts
- Deliver PowerShell scripts and modules to systems that can't access the internet
- Deliver PowerShell scripts and modules only available to your organization

This article describes how to set up a local PowerShell repository. The article also covers the
[OfflinePowerShellGetDeploy][] module available from the PowerShell Gallery. This module contains
cmdlets to install the latest version of PowerShellGet into your local repository.

## Local repository types

There are two ways to create a local PSRepository: NuGet server or file share. Each type has
advantages and disadvantages:

### NuGet Server

| Advantages| Disadvantages |
| --- | --- |
| Closely mimics PowerShellGallery functionality | Multi-tier app requires operations planning & support |
| NuGet integrates with Visual Studio, other tools | Authentication model and NuGet accounts management needed |
| NuGet supports metadata in `.Nupkg` packages | Publishing requires API Key management & maintenance |
| Provides search, package administration, etc. | |

### File Share

| Advantages| Disadvantages |
| --- | --- |
| Easy to set up, back up, and maintain | Metadata used by PowerShellGet isn't available |
| Simple security model - user permissions on the share | No UI beyond basic file share |
| No constraints such as replacing existing items | Limited security and no recording of who updates what |

PowerShellGet works with either type and supports locating versions and dependency installation.
However, some features that work for the PowerShell Gallery aren't available for base NuGet
servers or file shares.

- Everything is a package - no differentiation of scripts, modules, DSC resources, or role
  capabilities.
- File share servers can't see package metadata, including tags.

## Creating a local repository

The following article lists the steps for setting up your own NuGet Server.

- [NuGet.Server][]

Follow the steps up to the point of adding packages. The steps for
[publishing a package](#publishing-to-a-local-repository) are covered later in this article.

For a file share-based repository, make sure that your users have permissions to access the file
share.

## Registering a local repository

Before a repository can be used, it must be registered using the `Register-PSRepository` command.
In the examples below, the **InstallationPolicy** is set to *Trusted*, on the assumption that you
trust your own repository.

```powershell
# Register a NuGet-based server
Register-PSRepository -Name LocalPSRepo -SourceLocation http://MyLocalNuget/Api/V2/ -ScriptSourceLocation http://MyLocalNuget/Api/V2 -InstallationPolicy Trusted

# Register a file share on my local machine
Register-PSRepository -Name LocalPSRepo -SourceLocation '\\localhost\PSRepoLocal\' -ScriptSourceLocation '\\localhost\PSRepoLocal\' -InstallationPolicy Trusted
```

Take note of the difference between how the two commands handle **ScriptSourceLocation**. For a
file share-based repositories, the **SourceLocation** and **ScriptSourceLocation** must match. For
a web-based repository, they must be different, so in this example a trailing "/" is added to the
**SourceLocation**.

If you want the newly created PSRepository to be the default repository, you must unregister all
other PSRepositories. For example:

```powershell
Unregister-PSRepository -Name PSGallery
```

> [!NOTE]
> The repository name 'PSGallery' is reserved for use by the PowerShell Gallery. You can
> unregister PSGallery, but you cannot reuse the name PSGallery for any other repository.

If you need to restore the PSGallery, run the following command:

```powershell
Register-PSRepository -Default
```

## Publishing to a local repository

Once you've registered the local PSRepository, you can publish to your local PSRepository. There
are two main publishing scenarios: publishing your own module and publishing a module from the
PSGallery.

### Publishing a module you authored

Use `Publish-Module` and `Publish-Script` to publish your module to your local PSRepository the
same way you do for the PowerShell Gallery.

- Specify the location for your code
- Supply an API key
- Specify the repository name. For example, `-PSRepository LocalPSRepo`

> [!NOTE]
> You must create an account in the NuGet server, then sign in to generate and save the API key.
> For a file share, use any non-blank string for the NuGetApiKey value.

Examples:

```powershell
# Publish to a NuGet Server repository using my NuGetAPI key
Publish-Module -Path 'c:\projects\MyModule' -Repository LocalPsRepo -NuGetApiKey $nuGetApiKey
```

> [!IMPORTANT]
> To ensure security, API keys should not be hard-coded in scripts. Use a secure key management
> system. When executing a command manually, API keys should not be passed as plain-text to avoid it being logged, the `Read-Host` cmdlet can be used to safely pass the value of the API key.

```powershell
# Publish to a file share repo - the NuGet API key must be a non-blank string
Publish-Module -Path 'c:\projects\MyModule' -Repository LocalPsRepo -NuGetApiKey 'AnyStringWillDo'
```

### Publishing a module from the PSGallery

To publish a module from the PSGallery to your local PSRepository, you can use the 'Save-Package' cmdlet.

- Specify the Name of the Package
- Specify 'NuGet' as the Provider
- Specify the PSGallery location as the source (https://www.powershellgallery.com/api/v2)
- Specify the path to your local Repository

Example:

```powershell
# Publish from the PSGallery to your local Repository
Save-Package -Name 'PackageName' -Provider NuGet -Source https://www.powershellgallery.com/api/v2 -Path '\\localhost\PSRepoLocal\'
```

If your local PSRepository is web-based, it requires an additional step that uses nuget.exe to publish.

See the documentation for using [nuget.exe][].

## Installing PowerShellGet on a disconnected system

Deploying PowerShellGet is difficult in environments that require systems to be disconnected from
the internet. PowerShellGet has a bootstrap process that installs the latest version the first time
it's used. The OfflinePowerShellGetDeploy module in the PowerShell Gallery provides cmdlets that
support this bootstrap process.

To bootstrap an offline deployment, you need to:

- Download and install the OfflinePowerShellGetDeploy your internet-connected system and your
  disconnected systems
- Download PowerShellGet and its dependencies on the internet-connected system using the
  `Save-PowerShellGetForOffline` cmdlet
- Copy PowerShellGet and its dependencies from the internet-connected system to the disconnected
  system
- Use the `Install-PowerShellGetOffline` on the disconnected system to place PowerShellGet and its
  dependencies into the proper folders

The following commands use `Save-PowerShellGetForOffline` to put all the components into a folder
`f:\OfflinePowerShellGet`

```powershell
# Requires -RunAsAdministrator
#Download the OfflinePowerShellGetDeploy to a location that can be accessed
# by both the connected and disconnected systems.
Save-Module -Name OfflinePowerShellGetDeploy -Path 'F:\' -Repository PSGallery
Import-Module F:\OfflinePowerShellGetDeploy

# Put PowerShellGet somewhere locally
Save-PowerShellGetForOffline -LocalFolder 'F:\OfflinePowerShellGet'
```

At this point, you must make the contents of `F:\OfflinePowerShellGet` available to your
disconnected systems. Run the `Install-PowerShellGetOffline` cmdlet to install PowerShellGet on the
disconnected system.

> [!NOTE]
> It is important that you do not run PowerShellGet in the PowerShell session before running these
> commands. Once PowerShellGet is loaded into the session, the components cannot be updated. If you
> do start PowerShellGet by mistake, exit and restart PowerShell.

```powershell
Import-Module F:\OfflinePowerShellGetDeploy

Install-PowerShellGetOffline -LocalFolder 'F:\OfflinePowerShellGet'
```

After running these commands, you are ready to publish PowerShellGet to your local repository.

```powershell
# Publish to a NuGet Server repository using my NuGetAPI key
Publish-Module -Path 'F:\OfflinePowershellGet' -Repository LocalPsRepo -NuGetApiKey $nuGetApiKey
```

> [!IMPORTANT]
> To ensure security, API keys should not be hard-coded in scripts. Use a secure key management
> system. When executing a command manually, API keys should not be passed as plain-text to avoid it being logged, the `Read-Host` cmdlet can be used to safely pass the value of the API key.

```powershell
# Publish to a file share repo - the NuGet API key must be a non-blank string
Publish-Module -Path 'F:\OfflinePowerShellGet' -Repository LocalPsRepo -NuGetApiKey 'AnyStringWillDo'
```

## Use Packaging solutions to host PowerShellGet repositories

You can also use packaging solutions like Azure Artifacts to host a private or public PowerShellGet
repository. For more information and instructions, see the [Azure Artifacts documentation](/azure/devops/artifacts/tutorials/private-powershell-library).

<!-- external links -->
[OfflinePowerShellGetDeploy]: https://www.powershellgallery.com/packages/OfflinePowerShellGetDeploy/0.1.1
[Nuget.Server]: /nuget/hosting-packages/nuget-server
[nuget.exe]: /nuget/tools/nuget-exe-cli-reference
