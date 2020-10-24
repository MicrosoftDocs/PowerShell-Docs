---
ms.date:  06/12/2017
title:  Bootstrapping NuGet
description: This article explains how to install the NuGet components required to support working with the PowerShell Gallery.
---
# Bootstrap the NuGet provider and NuGet.exe

NuGet.exe is not included in the latest NuGet provider. For publish operations of either a module
or script, PowerShellGet requires the binary executable **NuGet.exe**. Only the NuGet provider is
required for all other operations, including **find**, **install**, **save**, and **uninstall**.
PowerShellGet includes logic to handle either a combined bootstrap of the NuGet provider and
NuGet.exe, or bootstrap of only the NuGet provider. In either case, only a single prompt message
should occur. If the machine is not connected to the Internet, the user or an administrator must
copy a trusted instance of the NuGet provider and/or the NuGet.exe file to the disconnected
machine.

> [!NOTE]
> Starting with version 6, the NuGet provider is included in the installation of PowerShell.

## Resolving error when the NuGet provider has not been installed on a machine that is Internet connected

```powershell
Find-Module -Repository PSGallery -Verbose -Name Contoso
```

```Output
NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based
repositories. The NuGet provider must be available in 'C:\Program Files\PackageManagement\ProviderAssemblies' or
'C:\Users\user1\AppData\Local\PackageManagement\ProviderAssemblies'. You can also install the NuGet
provider by running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you
want PowerShellGet to install and import the NuGet provider now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): n
Find-Module : NuGet provider is required to interact with NuGet-based repositories. Please ensure
that '2.8.5.201' or newer version of NuGet provider is installed.
At line:1 char:1
+ Find-Module -Repository PSGallery -Verbose -Name Contoso
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [Find-Module], InvalidOperationException
   + FullyQualifiedErrorId : CouldNotInstallNuGetProvider,Find-Module
```

```powershell
Find-Module -Repository PSGallery -Verbose -Name Contoso
```

```Output
NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based
repositories. The NuGet provider must be available in 'C:\Program Files\PackageManagement\ProviderAssemblies' or
'C:\Users\user1\AppData\Local\PackageManagement\ProviderAssemblies'. You can also install the NuGet
provider by running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you
want PowerShellGet to install and import the NuGet provider now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): Y
VERBOSE: Installing NuGet provider.

Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.5        Contoso                             Module     PSGallery        Contoso module
```

## Resolving error when the NuGet provider is available and NuGet.exe is not available during the publish operation on a machine that is Internet connected

```powershell
Publish-Module -Name Contoso -Repository PSGallery -Verbose
```

```Output
NuGet.exe is required to continue
PowerShellGet requires NuGet.exe to publish an item to the NuGet-based repositories. NuGet.exe must
be available under one of the paths specified in PATH environment variable value. Do you want
PowerShellGet to install NuGet.exe now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): N
Publish-Module : NuGet.exe is required to interact with NuGet-based repositories. Please ensure
that NuGet.exe is available under one of the paths specified in PATH environment variable value.
At line:1 char:1
+ Publish-Module -Name Contoso -Repository PSGallery -Verbose
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [Publish-Module], InvalidOperationException
    + FullyQualifiedErrorId : CouldNotInstallNuGetExe,Publish-Module
```

```powershell
Publish-Module -Name Contoso -Repository PSGallery -Verbose
```

```Output
NuGet.exe is required to continue
PowerShellGet requires NuGet.exe to publish an item to the NuGet-based repositories. NuGet.exe must
be available under one of the paths specified in PATH environment variable value. Do you want
PowerShellGet to install NuGet.exe now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): Y
VERBOSE: Installing NuGet.exe.
VERBOSE: Successfully published module 'Contoso' to the module publish location 'https://www.powershellgallery.com/api/v2/'.
Please allow few minutes for 'Contoso' to show up in the search results.
```

## Resolving error when both NuGet provider and NuGet.exe are not available during the publish operation on a machine that is Internet connected

```powershell
Publish-Module -Name Contoso -Repository PSGallery -Verbose
```

```Output
NuGet.exe and NuGet provider are required to continue
PowerShellGet requires NuGet.exe and NuGet provider version '2.8.5.201' or newer to interact with
the NuGet-based repositories. Do you want PowerShellGet to install both NuGet.exe and NuGet provider
now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): N
Publish-Module : PowerShellGet requires NuGet.exe and NuGet provider version '2.8.5.201' or newer
to interact with the NuGet-based repositories. Please ensure that '2.8.5.201' or newer version of
NuGet provider is installed and NuGet.exe is available under one of the paths specified in PATH
environment variable value.
At line:1 char:1
+ Publish-Module -Name Contoso -Repository PSGallery -Verbose
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [Publish-Module], InvalidOperationException
    + FullyQualifiedErrorId : CouldNotInstallNuGetBinaries,Publish-Module
```

```powershell
Publish-Module -Name Contoso -Repository PSGallery -Verbose
```

```Output
NuGet.exe and NuGet provider are required to continue
PowerShellGet requires NuGet.exe and NuGet provider version '2.8.5.201' or newer to interact with
the NuGet-based repositories. Do you want PowerShellGet to install both NuGet.exe and NuGet provider
now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): Y
VERBOSE: Installing NuGet provider.
VERBOSE: Installing NuGet.exe.
VERBOSE: Successfully published module 'Contoso' to the module publish location 'https://www.powershellgallery.com/api/v2/'.
 Please allow few minutes for 'Contoso' to show up in the search results.
```

## Manually bootstrapping the NuGet provider on a machine that is not connected to the Internet

The processes demonstrated above assume the machine is connected to the Internet and can download
files from a public location. If that is not possible, the only option is to bootstrap a machine
using the processes given above, and manually copy the provider to the isolated node through an
offline trusted process. The most common use case for this scenario is when a private gallery is
available to support an isolated environment.

After following the process above to bootstrap an Internet connected machine, you will find
provider files in the location:

`C:\Program Files\PackageManagement\ProviderAssemblies\`

The folder/file structure of the NuGet provider will be (possibly with a different version number):

```
NuGet
--2.8.5.208
----Microsoft.PackageManagement.NuGetProvider.dll
```

Copy these folders and file using a trusted process to the offline machines. To use the provider on
the offline machine, it must be imported. Run the following command on the offline machine:

```powershell
Import-PackageProvider -Name NuGet
```

## Manually bootstrapping NuGet.exe to support publish operations on a machine that is not connected to the Internet

In addition to the process to manually bootstrap the NuGet provider, if the machine will be used to
publish modules or scripts to a private gallery using the `Publish-Module` or `Publish-Script`
cmdlets, the NuGet.exe binary executable file will be required.

The most common use case for this scenario is when a private gallery is available to support an
isolated environment. There are two options to obtain the NuGet.exe file.

One option is to bootstrap a machine that is Internet connected and copy the files to the offline
machines using a trusted process. After bootstrapping the Internet connected machine, the NuGet.exe
binary will be located in one of two folders:

- If the `Publish-Module` or `Publish-Script` cmdlets were executed with elevated permissions (As
   an Administrator):

   ```powershell
   $env:ProgramData\Microsoft\Windows\PowerShell\PowerShellGet
   ```

- If the cmdlets were executed as a user without elevated permissions:

  ```powershell
  $env:userprofile\AppData\Local\Microsoft\Windows\PowerShell\PowerShellGet\
  ```

A second option is to download NuGet.exe from the NuGet.Org website:
[https://dist.nuget.org/index.html](https://www.nuget.org/downloads) When selecting a NugGet
version for production machines, make sure it is later than 2.8.5.208, and identify the version
that has been labeled "recommended". Remember to unblock the file if it was downloaded using a
browser. This can be performed by using the `Unblock-File` cmdlet.

In either case, the NuGet.exe file can be copied to any location in `$env:path`, but the standard
locations are:

- To make the executable available so that all users can use `Publish-Module` and `Publish-Script`
  cmdlets:

  ```powershell
  $env:ProgramData\Microsoft\Windows\PowerShell\PowerShellGet
  ```

- To make the executable available to only a specific user, copy to the location within only that
  user's profile:

  ```powershell
  $env:userprofile\AppData\Local\Microsoft\Windows\PowerShell\PowerShellGet\
  ```
