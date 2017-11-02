---
ms.date:  2017-09-26
contributor:  keithb
ms.topic:  reference
keywords:  gallery,powershell,cmdlet,psget
title:  PrereleaseModule
---

# Prerelease Module Versions
Starting with version 1.5.0, PowerShellGet and the PowerShell Gallery provide support for tagging versions greater than 1.0.0 as a prerelease. The goal of these features is to provide greater support for [SemVer v1.0.0](http://semver.org/spec/v1.0.0.html) versioning convention without breaking backwards compatibility with PowerShell versions 3 and above, or existing versions of PowerShellGet. This topic focuses on the module-specific features. The equivalent features for scripts are in the [Prerelease Versions of Scripts](../script/PrereleaseScript) topic. Using these features, publishers can identify a module or script as version 2.5.0-alpha, and later release a production-ready version 2.5.0 that supersedes the prerelease version. 

At a high level, the prerelease module features include:

* Adding a PrereleaseString string to the PSData section of the module manifest identifies the module as a prerelease version. 
When the module is published to the PowerShell Gallery, this data is extracted from the manifest, and used to identify prerelease items.
* Acquiring prerelease items requires adding -AllowPrerelease flag to the PowerShellGet commands Find-Module, Install-Module, Update-Module, and Save-Module. 
If the flag is not specified, prerelease items will not be shown.  
* Module versions displayed by Find-Module, Get-InstalledModule, and in the PowerShell Gallery will be displayed as a single string with the PrereleaseString appended, as in 2.5.0-alpha. 

Details for the features are included below. 

These changes do not affect the module version support that is built into PowerShell, and are compatible with PowerShell 3.0, 4.0, and 5. 

## Identifying a module version as a prerelease 

PowerShellGet support for prerelease versions requires the use of two fields within the Module Manifest:

* The ModuleVersion included in the module manifest must be a 3-part version if a prerelease version is used, and must comply with existing PowerShell versioning. The version format would be A.B.C, where A, B, and C are all integers. 
* The PrereleaseString is specified in the module manifest, in the PSData section of PrivateData. 
PrereleaseString is a string which may contain ASCII alphanumerics and hyphen [0-9A-Za-z-]. Detailed requirements on the PrereleaseString string are below. 

An example section of a module manifest that defines a module as a prerelease would look like the following:
```powershell
@{
    ModuleVersion = '2.5.0'
    #---
    PrivateData = @{
        PSData = @{
            PrereleaseString = 'alpha'
        }
    }
}
```

The detailed requirements for PrereleaseString string are: 

* PrereleaseString may only be specified when the ModuleVersion is 3 segments for Major.Minor.Build. This aligns with SemVer v1.0.0.
* A hyphen is the delimiter between the Build number and the PrereleaseString. A hyphen may be included in the Prerelease string as the first character.
* The PrereleaseString may contain only ASCII alphanumerics [0-9A-Za-z-] and hyphen [-]. It is recommended to begin the PrereleaseString with an alpha character, as it will be easier to identify that this is a prerelease version when scanning a list of items. 
* Only SemVer v1.0.0 prerelease strings are supported at this time. PrereleaseString __must not__ contain either period or + [.+], which are allowed in SemVer 2.0. 
* Examples of supported PrereleaseString strings are: -alpha, -alpha1, -BETA, -update20171020

__Prerelease versioning impact on sort order and installation folders__

Sort order changes when using a prerelease version, which is important when publishing to the PowerShell Gallery, and when installing modules using PowerShellGet commands. 
If the PrereleaseString is specified for two modules, the sort order is based on the string portion following the hyphen. So, version 2.5.0-alpha is less than 2.5.0-beta, which is less than 2.5.0-gamma. 
If two modules have the same ModuleVersion, and only one has a PrereleaseString, the module without the PrereleaseString is assumed to be the production-ready version and will be sorted as a greater version than the prerelease version (which includes the PrereleaseString). 
As an example, when comparing releases 2.5.0 and 2.5.0-beta, the 2.5.0 version will be considered the greater of the two. 

When publishing to the PowerShell Gallery, by default the version of the module being published must have a greater version than any previously-published version that is in the PowerShell Gallery. 

## Finding and acquiring prerelease items using PowerShellGet commands

Dealing with prerelease items using PowerShellGet Find-Module, Install-Module, Update-Module, and Save-Module commands requires adding the -AllowPrerelease flag. 
If -AllowPrerelease is specified, prerelease items will be included if they are present.
If -AllowPrerelease flag is not specified, prerelease items will not be shown. 

The only exceptions to this in the PowerShellGet module commands are Get-InstalledModule, and some cases with Uninstall-Module. 

* Get-InstalledModule always will automatically show the prerelease information in the version string for modules. 
* Uninstall-Module will by default uninstall the most recent version of a module, if __no version__ is specified. That behavior has not changed. However, if a prerelease version is specified using -RequiredVersion, -AllowPrerelease will be required. 

## Examples
```powershell
# Assume the PowerShell Gallery has TestPackage module versions 1.8.0 and 1.9.0-alpha. If -AllowPrerelease is not specified, only version 1.8.0 will be returned.
C:\windows\system32> find-module TestPackage 

Version        Name                                Repository           Description
-------        ----                                ----------           -----------
1.8.0          TestPackage                         PSGallery            Package used to validate changes to the PowerShe...

C:\windows\system32> find-module TestPackage -AllowPrerelease

Version        Name                                Repository           Description
-------        ----                                ----------           -----------
1.9.0-alpha    TestPackage                         PSGallery            Package used to validate changes to the PowerShe...

# To install a prerelease, always specify -AllowPrerelease. Specifying a prerelease version string is not sufficient. 

C:\windows\system32> Install-module TestPackage -RequiredVersion 1.9.0-alpha
PackageManagement\Find-Package : No match was found for the specified search criteria and module name 'TestPackage'.
Try Get-PSRepository to see all available registered module repositories.
At C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\1.6.0\PSModule.psm1:1455 char:3
+         PackageManagement\Find-Package @PSBoundParameters | Microsoft ...
+         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Microsoft.Power...ets.FindPackage:FindPackage) [Find-Package], Exceptio
   n
    + FullyQualifiedErrorId : NoMatchFoundForCriteria,Microsoft.PowerShell.PackageManagement.Cmdlets.FindPackage

# The previous command failed because -AllowPrerelease was not specified.
# Adding -AllowPrerelease will result in success.

C:\windows\system32> Install-module TestPackage -RequiredVersion 1.9.0-alpha -AllowPrerelease
C:\windows\system32> Get-InstalledModule TestPackage

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.9.0-alpha     TestPackage                         PSGallery            Package used to validate changes to the PowerShe...

```

Side-by-side installation of versions of a module that differ only due to the prerelease specified is not supported. 
When installing a module using PowerShellGet, different versions of the same module are installed side-by-side by creating a folder name using the ModuleVersion. 
The ModuleVersion, without the prerelease string, is used for the folder name. 
If a user installs MyModule version 2.5.0-alpha, it will be installed to the MyModule\2.5.0 folder. 
If the user then installs 2.5.0-beta, the 2.5.0-beta version will __over-write__ the contents of the folder MyModule\2.5.0. 
One advantage to this approach is that there is no need to un-install the prerelease version after installing the production-ready version. 
The example below shows what to expect:


``` powershell
C:\windows\system32> Get-InstalledModule TestPackage -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.9.0-alpha     TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.8.0           TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.1.3.2         TestPackage                         PSGallery            Package used to validate changes to the PowerShe...

C:\windows\system32> find-module TestPackage -AllowPrerelease

Version        Name                                Repository           Description
-------        ----                                ----------           -----------
1.9.0-beta     TestPackage                         PSGallery            Package used to validate changes to the PowerShe...

C:\windows\system32> Update-Module TestPackage -AllowPrerelease
C:\windows\system32> Get-InstalledModule TestPackage -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.9.0-beta      TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.8.0           TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.1.3.2         TestPackage                         PSGallery            Package used to validate changes to the PowerShe...

```

Uninstall-Module will remove the latest version of a module when -RequiredVersion is not supplied. 
If -RequiredVersion is specified, and is a prerelease, -AllowPrerelease must be added to the command. 

``` powershell
C:\windows\system32> Get-InstalledModule TestPackage -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
2.0.0-alpha1    TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.9.0-beta      TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.8.0           TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.1.3.2         TestPackage                         PSGallery            Package used to validate changes to the PowerShe...

C:\windows\system32> Uninstall-Module TestPackage -RequiredVersion 1.9.0-beta
Uninstall-Module : The '-AllowPrerelease' parameter must be specified when using the Prerelease string in
MinimumVersion, MaximumVersion, or RequiredVersion.
At line:1 char:1
+ Unnstall-Module TestPackage -RequiredVersion 1.9.0-beta
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Uninstall-Module], ArgumentException
    + FullyQualifiedErrorId : AllowPrereleaseRequiredToUsePrereleaseStringInVersion,Uninnstall-Module



C:\windows\system32> Uninstall-Module TestPackage -RequiredVersion 1.9.0-beta -AllowPrerelease
C:\windows\system32> Get-InstalledModule TestPackage -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
2.0.0-alpha1    TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.8.0           TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.1.3.2         TestPackage                         PSGallery            Package used to validate changes to the PowerShe...

C:\windows\system32> Uninstall-Module TestPackage
C:\windows\system32> Get-InstalledModule TestPackage -AllVersions

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.8.0           TestPackage                         PSGallery            Package used to validate changes to the PowerShe...
1.1.3.2         TestPackage                         PSGallery            Package used to validate changes to the PowerShe...


```



## More details
### [Prerelease Script Versions](../script/PrereleaseScript)
### [Find-Module](./psget_find-module.md)
### [Install-Module](./psget_install-module.md)
### [Save-Module](./psget_save-module.md)
### [Update-Module](./psget_update-module.md)
### [Get-InstalledModule](./psget_get-installedmodule.md)
### [UnInstall-Module](./psget_uninstall-module.md)
