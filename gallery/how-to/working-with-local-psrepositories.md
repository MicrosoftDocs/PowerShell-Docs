---
ms.date:  10/04/2018
contributor:  JKeithB
keywords:  gallery,powershell,cmdlet,psgallery,psget
title:  Working with local PSRepositories
---
# Working with local PowerShellGet Repositories

The cmdlets in the PowerShellGet module support repositories other than the PowerShell Gallery.
This supports the following scenarios:

- Support a trusted, pre-validated set of PowerShell modules for use in your environment
- Testing a CI/CD pipeline that builds PowerShell modules or scripts
- Deliver PowerShell scripts and modules to systems that can't access the internet

This article describes how to set up a local PowerShell repository. The article also covers the
[OfflinePowerShellGetDeploy][] module available from the PowerShell Gallery. This module contains
cmdlets to install the latest version of PowerShellGet into your local repository.

## Local repository types

There are two ways to create a local PSRepository: NuGet server or file share. Each type has
advantages and disadvantages:

NuGet Server

| Advantages| Disadvantages |
| --- | --- |
| Closely mimics PowerShellGallery functionality | Multi-tier app requires operations planning & support |
| NuGet integrates with Visual Studio, other tools | Authentication model and NuGet accounts management needed |
| NuGet supports metadata in `.Nupkg` packages | Publishing requires API Key management & maintenance |
| Provides search, package administration, etc. | |

File Share

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

For more information about NuGet, take a look at the following links:

- [Hosting your own NuGet feeds](/nuget/hosting-packages/overview)
- [Setting up a local feed](/nuget/hosting-packages/local-feeds)
- [Installing NuGet.Server](/nuget/hosting-packages/nuget-server)
- [NuGet server download package](https://www.nuget.org/packages/NuGet.Server/)
- [Deploying NuGet to Azure](https://github.com/NuGet/NuGetGallery/blob/master/docs/Deploying/README.md)

## Creating a local repository

Add a new repository for use by PowerShellGet with the `Register-PSRepository` command. In the
examples below, the **InstallationPolicy** is set to *Trusted*, on the assumption that you trust
your own repository. Take note of the difference between how the two commands handle
**ScriptSourceLocation**. For a file share-based repositories, the **SourceLocation** and
**ScriptSourceLocation** must match. For a web-based repository, they must be different, so in this
example a trailing "/" is added to the **SourceLocation**.

```powershell
# Register a NuGet-based server
Register-PSRepository -Name LocalPSRepo -SourceLocation http://MyLocalNuget/Api/V2/ -ScriptSourceLocation http://MyLocalNuget/Api/V2 -InstallationPolicy Trusted

# Register a file share on my local machine
Register-PSRepository -Name LocalPSRepo -SourceLocation '\\localhost\PSRepoLocal\' -ScriptSourceLocation '\\localhost\PSRepoLocal\' -InstallationPolicy Trusted

```

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

Once you've registered the local PSRepository, you can use `Publish-Module` and `Publish-Script`
the same way you do for the PowerShell Gallery.

- Specify the location for your code
- Supply an API key
- Specify the repository name. For example, `-PSRepository LocalPSRepo`

> [!NOTE]
> You must create an account in the NuGet server, then sign in to generate and save the API key.
> For a file share, use any non-blank string for the NuGetApiKey value.

Example commands are:

```powershell
# Publish to a NuGet Server repository using my NuGetAPI key
Publish-Module -Path 'c:\projects\MyModule' -Repository LocalPsRepo -NuGetApiKey 'oy2bi4avlkjolp6bme6azdyssn6ps3iu7ib2qpiudrtbji'

# Publish to a file share repo - the NuGet API key must be a non-blank string
Publish-Module -Path 'c:\projects\MyModule' -Repository LocalPsRepo -NuGetApiKey 'AnyStringWillDo'
```

> [!IMPORTANT]
> To ensure security, API keys should not be hard-coded in scripts. Use a secure key management
> system.

## Installing PowerShellGet on a disconnected system

Deploying PowerShellGet is difficult in environments that require systems to be disconnected from
the internet. PowerShellGet has a bootstrap process that installs the latest version the first
time it's used. The OfflinePowerShellGetDeploy module in the PowerShell Gallery provides cmdlets
that support this bootstrap process for your local repository.

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
# Download the OfflinePowerShellGetDeploy to a location that can be accessed
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

After running these commands, you are ready to run `Register-PSRepository` and use
PowerShellGet with your local repository.

[OfflinePowerShellGetDeploy]: https://www.powershellgallery.com/packages/OfflinePowerShellGetDeploy/0.1.0-alpha01