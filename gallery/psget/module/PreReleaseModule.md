---
ms.date:  2017-09-26
contributor:  keithb
ms.topic:  reference
keywords:  gallery,powershell,cmdlet,psget
title:  PreReleaseModule
---

# Pre-Release Module Versions
Starting with version 1.5.0, PowerShellGet and the PowerShell Gallery provide support for tagging versions greater than 1.0.0 as a pre-release. The goal of these features is to provide greater support for [SemVer v1.0.0](http://semver.org/spec/v1.0.0.html) versioning convention without breaking backwards compatibility with PowerShell versions 3 and above, or existing versions of PowerShellGet. This topic focuses on the module-specific features. The equivalent features for scripts are in the [Pre-Release Script Versions](../script/PreReleaseScript) topic. Using these features, publishers can identify a module or script as version 2.5.0-alpha, and later release a production-ready version 2.5.0 that supersedes the pre-release version. 

At a high level, the pre-release module features include:

* Adding a ModuleVersionSuffix string to the PSData section of the module manifest identifies the module as a pre-release version. 
When the module is published to the PowerShell Gallery, this data is extracted from the manifest, and used to identify pre-release items.
* Acquiring pre-release items requires adding -AllowPreRelease flag to the PowerShellGet commands Find-Module, Install-Module, Update-Module, and Save-Module. 
If the flag is not specified, pre-release items will not be shown.  
* Module versions displayed by Find-Module, Get-InstalledModule, and in the PowerShellGallery will be displayed as a single string with the ModuleVersionSuffix appended, as in 2.5.0-alpha. 

Details for the features are included below. 

These changes do not affect the module version support that is built into PowerShell, and are compatible with PowerShell 3.0, 4.0, and 5. 

## Identifying a module version as a pre-release 

PowerShellGet support for pre-release versions requires the use of two fields within the Module Manifest:

* The ModuleVersion included in the module manifest must be a 3-part version if a pre-release version is used, and must comply with existing PowerShell versioning. The version format would be A.B.C, where A, B, and C are all integers. 
* The ModuleVersionsuffix is specified in the module manifest, in the PSData section of PrivateData. 
ModuleVersionSuffix is a string which should begin with a hyphen, and may contain ASCII alphanumerics and hyphen [0-9A-Za-z-]. Detailed requirements on the ModuleVersionSuffix string are below. 

An example section of a module manifest that defines a module as a pre-release would look like the following:
```powershell
@{
    ModuleVersion = '3.2.1'
    #---
    PrivateData = @{
        PSData = @{
            ModuleVersionSuffix = '-alpha'
        }
    }
}
```

The detailed requirements for ModuleVersionsuffix string are: 

* It should begin with a hyphen. If a hyphen is not the first character in the string, it will be added in displays and filtering, and must be specified in search strings.
* The ModuleVersionSuffix may contain contain only ASCII alphanumerics [0-9A-Za-z-] and hyphen [-]. It is recommended to begin the ModuleVersionSuffix with an alpha character, as it will be easier to identify that this is a pre-release version when scanning a list of items. 
* Only SemVer v1.0.0 pre-release strings are supported at this time. ModuleVersionSuffix __must not__ contain either period or + [.+], which are allowed in SemVer 2.0. 
* Examples of supported ModuleVersionSuffix strings are: -alpha, -alpha.1, -BETA, -alpha.1.2.3

__Pre-release versioning impact on sort order and installation folders__

Sort order changes when using a pre-release version, which is important when publishing to the PowerShell Gallery, and when installing modules using PowerShellGet commands. 
If the ModuleVersionSuffix is specified for two modules, the sort order is based on the string portion following the hyphen. So, version 2.5.0-alpha is less than 2.5.0-beta, which is less than 2.5.0-gamma. 
If two modules have the same ModuleVersion, and only one has a ModuleVersionSuffix, the module without the ModuleVersionSuffix is assumed to be the production-ready version and will be sorted as a greater version than the pre-release version (which includes the ModuleVersionSuffix). 
As an example, when comparing releases 2.5.0 and 2.5.0-beta, the 2.5.0 version will be considered the greater of the two. 

When publishing to the PowerShell Gallery, the version of the module being published must have a greater version than any previously-published version that is in the PowerShell Gallery. 

## Finding and acquiring pre-release items using PowerShellGet commands

Dealing with pre-release items using PowerShellGet Find-Module, Install-Module, Update-Module, and Save-Module commands requires adding the -AllowPreRelease flag. 
If -AllowPreRelease is specified, pre-release items will be included if they are present.
If -AllowPreRelease flag is not specified, pre-release items will not be shown. 

The only exceptions to this in the PowerShellGet module commands are Get-InstalledModule, and some cases with Uninstall-Module. 

* Get-InstalledModule always will automatically show the pre-release information in the version string for modules. 
* Uninstall-Module will by default uninstall the most recent version of a module, if no version is specified. That behavior has not changed. However, if a pre-release version is specified using -RequiredVersion, -AllowPreRelease will be required. 

## Examples
```powershell
# Assume the PowerShell Gallery has PowerShellGet module versions 1.8.0 and 1.9.0-alpha. If -AllowPreRelease is not specified, only version 1.8.0 will be returned.
C:\windows\system32> find-module PowerShellGet 

Version        Name                                Repository           Description
-------        ----                                ----------           -----------
1.8.0          MainModule                          PSGallery            PowerShell module with commands for discovering,...

C:\windows\system32> find-module PowerShellGet -AllowPrerelease

Version        Name                                Repository           Description
-------        ----                                ----------           -----------
1.9.0-alpha    PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...

# To install a pre-release, always specify -AllowPreRelease. Specifying a pre-release version string is not sufficient. 

C:\windows\system32> Install-module PowerShellGet -RequiredVersion 1.9.0-alpha
PackageManagement\Find-Package : No match was found for the specified search criteria and module name 'PowerShellGet'.
Try Get-PSRepository to see all available registered module repositories.
At C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\1.6.0\PSModule.psm1:1455 char:3
+         PackageManagement\Find-Package @PSBoundParameters | Microsoft ...
+         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Microsoft.Power...ets.FindPackage:FindPackage) [Find-Package], Exceptio
   n
    + FullyQualifiedErrorId : NoMatchFoundForCriteria,Microsoft.PowerShell.PackageManagement.Cmdlets.FindPackage

# The previous command failed because -AllowPreRelease was not specified.
# Adding -AllowPreRelease will result in success.

C:\windows\system32> Install-module PowerShellGet -RequiredVersion 1.9.0-alpha -AllowPreRelease
C:\windows\system32> Get-InstalledModule PowerShellGet

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.9.0-alpha     PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...

```

Side-by-side installation of versions of a module that differ only due to the pre-release specified is not supported. 
When installing a module using PowerShellGet, different versions of the same module are installed side-by-side by creating a folder name using the ModuleVersion. 
The ModuleVersion, without the pre-release string, is used for the folder name. 
If a user installs MyModule version 2.5.0-alpha, it will be installed to MyModule\2.5.0. 
If the user then installs 2.5.0-beta, the 2.5.0-beta version will __over-write__ the contents of the folder MyModule\2.5.0. 
One advantage to this approach is that there is no need to un-install the pre-release version after installing the production-ready version. 
The example below shows what to expect:


``` powershell
C:\windows\system32> Get-InstalledModule powershellget -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.9.0-alpha     PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.8.0           PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.1.3.2         PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...

C:\windows\system32> find-module PowerShellGet -AllowPrerelease

Version        Name                                Repository           Description
-------        ----                                ----------           -----------
1.9.0-beta     PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...

C:\windows\system32> Update-Module PowerShellGet -AllowPreRelease
C:\windows\system32> Get-InstalledModule powershellget -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.9.0-beta      PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.8.0           PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.1.3.2         PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...

```

Uninstall-Module will remove the latest version of a module when -RequiredVersion is not supplied. 
If -RequiredVersion is specified, and is a pre-release, -AllowPreRelease must be added to the command. 

``` powershell
C:\windows\system32> Get-InstalledModule powershellget -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
2.0.0-alpha1    PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.9.0-beta      PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.8.0           PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.1.3.2         PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...

C:\windows\system32> Uninstall-Module PowerShellGet -RequiredVersion 1.9.0-beta
PackageManagement\Uninstall-Package : No match was found for the specified search criteria and module names
'PowerShellGet'.
At C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\1.6.0\PSModule.psm1:2252 char:21
+ ...        $null = PackageManagement\Uninstall-Package @PSBoundParameters
+                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Microsoft.Power...ninstallPackage:UninstallPackage) [Uninstall-Package]
   , Exception
    + FullyQualifiedErrorId : NoMatchFound,Microsoft.PowerShell.PackageManagement.Cmdlets.UninstallPackage

C:\windows\system32> Uninstall-Module PowerShellGet -RequiredVersion 1.9.0-beta -AllowPreRelease
C:\windows\system32> Get-InstalledModule powershellget -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
2.0.0-alpha1    PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.8.0           PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.1.3.2         PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...

C:\windows\system32> Uninstall-Module PowerShellGet
C:\windows\system32> Get-InstalledModule powershellget -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.8.0           PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...
1.1.3.2         PowerShellGet                       PSGallery            PowerShell module with commands for discovering,...


```



## More details
### [Pre-Release Script Versions](../script/PreReleaseScript)
### [Find-Module](./psget_find-module.md)
### [Install-Module](./psget_install-module.md)
### [Save-Module](./psget_save-module.md)
### [Update-Module](./psget_update-module.md)
### [Get-InstalledModule](./psget_get-installedmodule.md)
### [UnInstall-Module](./psget_uninstall-module.md)
