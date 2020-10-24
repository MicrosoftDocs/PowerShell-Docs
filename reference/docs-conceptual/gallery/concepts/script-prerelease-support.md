---
ms.date:  10/17/2017
title:  Prerelease versions of scripts
description: The PowerShellGet module provides support for tagging scripts with versions greater than 1.0.0 as a prerelease using semantic versioning.
---
---
# Prerelease versions of scripts

Starting with version 1.6.0, PowerShellGet and the PowerShell Gallery provide support for tagging
versions greater than 1.0.0 as a prerelease. Prior to this feature, prerelease packages were limited
to having a version beginning with 0. The goal of these features is to provide greater support for
[SemVer v1.0.0](http://semver.org/spec/v1.0.0.html) versioning convention without breaking
backwards compatibility with PowerShell versions 3 and above, or existing versions of
PowerShellGet. This topic focuses on the script-specific features. The equivalent features for
modules are in the [Prerelease Module Versions](module-prerelease-support.md) topic. Using these
features, publishers can identify a script as version 2.5.0-alpha, and later release a
production-ready version 2.5.0 that supersedes the prerelease version.

At a high level, the prerelease script features include:

- Adding a PrereleaseString suffix to the version string in the script manifest. When the scripts
  is published to the PowerShell Gallery, this data is extracted from the manifest, and used to
  identify prerelease packages.
- Acquiring prerelease packages requires adding -AllowPrerelease flag to the PowerShellGet commands
  Find-Script, Install-Script, Update-Script, and Save-Script. If the flag is not specified,
  prerelease packages will not be shown.
- Script versions displayed by Find-Script, Get-InstalledScript, and in the PowerShell Gallery will
  be displayed with the PrereleaseString, as in 2.5.0-alpha.

Details for the features are included below.

## Identifying a script version as a prerelease

PowerShellGet support for prerelease versions is easier for scripts than modules. Script versioning
is only supported by PowerShellGet, so there are no compatibility issues caused by adding the
prerelease string. To identify a script in the PowerShell Gallery as a prerelease, add a prerelease
suffix to a properly-formatted version string in the script metadata.

An example section of a script manifest with a prerelease version would look like the following:

```powershell
<#PSScriptInfo

.VERSION 3.2.1-alpha12

.GUID

...

#>
```

To use a prerelease suffix, the version string must meet the following requirements:

- A prerelease suffix may only be specified when the Version is 3 segments for Major.Minor.Build.
  This aligns with SemVer v1.0.0
- The prerelease suffix is a string which begins with a hyphen, and may contain ASCII alphanumerics
  [0-9A-Za-z-]
- Only SemVer v1.0.0 prerelease strings are supported at this time, so the prerelease suffix
  **must not** contain either period or + [.+], which are allowed in SemVer 2.0
- Examples of supported PrereleaseString strings are: -alpha, -alpha1, -BETA, -update20171020

### Prerelease versioning impact on sort order and installation folders

Sort order changes when using a prerelease version, which is important when publishing to the
PowerShell Gallery, and when installing scripts using PowerShellGet commands. If two scripts
versions with the version number exist, the sort order is based on the string portion following the
hyphen. So, version 2.5.0-alpha is less than 2.5.0-beta, which is less than 2.5.0-gamma. If two
scripts have the same version number, and only one has a PrereleaseString, the script **without**
the prerelease suffix is assumed to be the production-ready version and will be sorted as a greater
version than the prerelease version. As an example, when comparing releases 2.5.0 and 2.5.0-beta,
the 2.5.0 version will be considered the greater of the two.

When publishing to the PowerShell Gallery, by default the version of the script being published
must have a greater version than any previously-published version that is in the PowerShell
Gallery. A publisher may update version 2.5.0-alpha with 2.5.0-beta, or with 2.5.0 (with no
prerelease suffix).

## Finding and acquiring prerelease packages using PowerShellGet commands

Dealing with prerelease packages using PowerShellGet Find-Script, Install-Script, Update-Script, and
Save-Script commands requires adding the -AllowPrerelease flag. If -AllowPrerelease is specified,
prerelease packages will be included if they are present. If -AllowPrerelease flag is not specified,
prerelease packages will not be shown.

The only exceptions to this in the PowerShellGet script commands are Get-InstalledScript, and some
cases with Uninstall-Script.

- Get-InstalledScript always will automatically show the prerelease information in the version
  string if it is present.
- Uninstall-Script will by default uninstall the most recent version of a script, if **no version**
  is specified. That behavior has not changed. However, if a prerelease version is specified using
  `-RequiredVersion`, `-AllowPrerelease` will be required.

## Examples

```powershell
# Assume the PowerShell Gallery has TestPackage versions 1.8.0 and 1.9.0-alpha.
# If -AllowPrerelease is not specified, only version 1.8.0 will be returned.
C:\windows\system32> Find-Script TestPackage

Version        Name                                Repository           Description
-------        ----                                ----------           -----------
1.8.0          TestPackage                         PSGallery            Package used to validate changes to the PowerShe...

C:\windows\system32> Find-Script TestPackage -AllowPrerelease

Version        Name                                Repository           Description
-------        ----                                ----------           -----------
1.9.0-alpha    TestPackage                         PSGallery            Package used to validate changes to PowerShe...

# To install a prerelease, you must specify -AllowPrerelease. Specifying a prerelease version string is not sufficient.

C:\windows\system32> Install-Script TestPackage -RequiredVersion 1.9.0-alpha

PackageManagement\Find-Package : No match was found for the specified search criteria and script name 'TestPackage'.
Try Get-PSRepository to see all available registered script repositories.
At C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\1.6.0\PSModule.psm1:1455 char:3
+         PackageManagement\Find-Package @PSBoundParameters | Microsoft ...
+         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Microsoft.Power...ets.FindPackage:FindPackage)[Find-Package], Exception
    + FullyQualifiedErrorId : NoMatchFoundForCriteria,Microsoft.PowerShell.PackageManagement.Cmdlets.FindPackage

# The previous command failed because -AllowPrerelease was not specified.
# Adding -AllowPrerelease will result in success.

C:\windows\system32> Install-Script TestPackage -RequiredVersion 1.9.0-alpha -AllowPrerelease
C:\windows\system32> Get-InstalledScript TestPackage

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.9.0-alpha     TestPackage                         PSGallery            Package used to validate changes to PowerShe...

# Note that Get-InstalledScript shows the prerelease version.
# If -RequiredVersion is not specified, all installed scripts will be displayed by Get-InstalledScript
```

Uninstall-Script will remove the current version of a script when -RequiredVersion is not supplied.
If -RequiredVersion is specified, and is a prerelease, -AllowPrerelease must be added to the command.

``` powershell
C:\windows\system32> Get-InstalledScript TestPackage

Version         Name                                Repository           Description
-------         ----                                ----------           -----------
1.9.0-alpha     TestPackage                         PSGallery            Package used to validate changes to PowerShe...

C:\windows\system32> Uninstall-Script TestPackage -RequiredVersion 1.9.0-alpha
Uninstall-Script: The '-AllowPrerelease' parameter must be specified when using the Prerelease string in
MinimumVersion, MaximumVersion, or RequiredVersion.
At line:1 char:1
+ Uninstall-Script TestPackage -RequiredVersion 1.9.0-beta
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Uninstall-Script], ArgumentException
    + FullyQualifiedErrorId : AllowPrereleaseRequiredToUsePrereleaseStringInVersion,Uninstall-script


C:\windows\system32> Uninstall-Script TestPackage -RequiredVersion 1.9.0-alpha -AllowPrerelease
# Since script versions are not installed side-by-side, the above could be simply "Uninstall-Script TestPackage"

C:\windows\system32> Get-Installedscript TestPackage
PackageManagement\Get-Package : No match was found for the specified search criteria and script names 'testpackage'.
At C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\1.5.0.0\PSModule.psm1:4088 char:9
+         PackageManagement\Get-Package @PSBoundParameters | Microsoft. ...
+         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Microsoft.Power...lets.GetPackage:GetPackage) [Get-Package], Exception
    + FullyQualifiedErrorId : NoMatchFound,Microsoft.PowerShell.PackageManagement.Cmdlets.GetPackage
```

## More details

- [Prerelease Module Versions](module-prerelease-support.md)
- [Find-script](/powershell/module/powershellget/find-script)
- [Install-script](/powershell/module/powershellget/install-script)
- [Save-script](/powershell/module/powershellget/save-script)
- [Update-script](/powershell/module/powershellget/update-script)
- [Get-Installedscript](/powershell/module/powershellget/get-installedscript)
- [UnInstall-script](/powershell/module/powershellget/uninstall-script)
