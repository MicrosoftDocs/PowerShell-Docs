---
description: This article documents the package metadata values that are used by the PowerShell Gallery.
ms.date: 11/16/2022
title: Package metadata values that impact the PowerShell Gallery UI
---
# Package metadata values that impact the PowerShell Gallery UI

This article explains how the metadata in your packages is used by the PowerShell Gallery. For
modules, the metadata is stored in the module manifest. For scripts, the metadata is store using
comment-based keywords. The following cmdlets are use to create or update this metadata:

- [New-ModuleManifest][1]
- [Update-ModuleManifest][2]
- [New-ScriptFileInfo][3]
- [Update-ScriptFileInfo][4]

## PowerShell Gallery feature elements controlled by the module manifest

The following list shows the elements of the PowerShell Gallery package page UI that are controlled
by the module manifest.

- **Title** - The name of the package published to the Gallery.

- **Version** - The version displayed is the version string in the metadata, and a prerelease label
  if is specified. The specified prerelease string is appended to the **ModuleVersion**. For
  information about prerelease strings in modules, see [Prerelease Module Versions][5].

- **Description** - This is the **Description** in the module manifest.

- **Require license acceptance** - A module can require that the user accept a license, by setting
  `RequireLicenseAcceptance = $true`, supplying a **LicenseURI**, and providing a `license.txt` file
  in the root of the module folder. For more information, see [Require License Acceptance][6].

- **Release notes** - This information is comes from the **ReleaseNotes** section, under
  `PSData\PrivateData`.

- **Owners** - Owners are the list of users in the PowerShell Gallery who can update a package. The
  owner list isn't included in the package manifest. Additional documentation describes how to
  [manage item owners][7].

- **Author** - This is included in the module manifest as the **Author**. The Author field is often
  used to specify a company or organization associated with a package.

- **Copyright** - This is the **Copyright** field in the module manifest.

- **FileList** - The file list is created when the package is published to the PowerShell Gallery.
  It's not controllable by the manifest information. The PowerShell Gallery creates `.nuspec` file
  that appears in the file list of each package. This file isn't installed with the package on a
  system. This is the NuGet package manifest for the package and can be ignored.

- **Tags** - **Tags** are included under `PrivateData\PSData` in the module manifest. Tags have
  specific requirements and meanings that are described in the [Tag Details][8] section.

- **Cmdlets** - This is provided in the module manifest using **CmdletsToExport**. It's a best
  practice to explicitly list the cmdlet names rather than using the wildcard `*`. Having a list
  improves the load-module performance.

- **Functions** - This is provided in the module manifest using **FunctionsToExport**. It's a best
  practice to explicitly list the cmdlet names rather than using the wildcard `*`. Having a list
  improves the load-module performance.

- **DSC Resources** - This is provided in the manifest using **DscResourcesToExport**. This value is
  only supported for modules in PowerShell 5.0 and higher.

- **Role capabilities** - Roles are listed when the module has one or more role capability (`.psrc`)
  files. These files are used by JEA. For more information, see [role capabilities][9].

- **PowerShell Editions** - For modules designed for PowerShell 5.0 and lower, this is controlled
  using **Tags**. For Desktop, use the tag PSEdition_Desktop, and for core, use the tag
  PSEdition_Core. For modules designed for PowerShell 5.1 and higher, there is a
  **CompatiblePSEditions** key in the manifest. For more information, see
  [PSEdition support for modules][10].

- **Dependencies** - This is provided in the manifest using **RequiredModules**.

- **Minimum PowerShell version** - This is provided in the manifest using **PowerShellVersion**.

- **Version History** - Shows a list of versions of the module that have been published to the
  Gallery. Packages hidden using the **Delete** feature aren't displayed in the version history
  unless you are a package owner.

- **Project Site** - The project site is provided for modules in the `PrivateData\PSData` section of
  the module manifest by specifying a **ProjectURI**.

- **License** - A license link is provided for modules in the `PrivateData\PSData` section of the
  module manifest by specifying a **LicenseURI**.

  > [!IMPORTANT]
  > If a license isn't provided via the **LicenseURI** or within the package then the Terms of Use
  > for the PowerShell Gallery apply to the package. For more information, see the
  > [Terms of Use][11].

- **Icon** - A link is provided for modules in the `PrivateData\PSData` section of the module
  manifest by specifying an **IconURI**. The URI should point to an 85x85 image with transparency
  background. The URI **must** be a direct link to the image file and **must not** go to a web page
  or a file in the PowerShell Gallery package.

## PowerShell Gallery feature elements controlled by the script metadata

The following list shows the elements of the PowerShell Gallery package page UI that are controlled
by the comment-based metadata in a script file.

- **Title** - This is the name of the package that is published to the Gallery

- **Version** - The version displayed is the version string in the metadata, and a prerelease label
  if is specified. The value comes from the `.VERSION` keyword in the metadata comment block. When
  publishing prerelease script, append the prerelease string to the version. For information about
  specifying prerelease strings in modules, see [Prerelease versions of scripts][12].

- **Description** - This information comes from the `.DESCRIPTION` keyword in the comment-based help
  of a script file.

- **Require license acceptance** - License Acceptance is not supported for scripts. However, the
  scenario where a script depends on a module that requires license acceptance is supported. For
  more information, see [Requiring license acceptance for scripts][13].

- **Release notes** - This information comes from the `.RELEASENOTES` keyword in the comment-based
  metadata of a script file.

- **Owners** - Owners are the list of users in the PowerShell Gallery who can update a package. The
  owner list isn't included in the package manifest. For more information, see
  [manage item owners][7].

- **Author** - This information comes from the `.AUTHOR` keyword in the comment-based metadata of a
  script file. The Author field is often used to specify a company or organization associated with a
  package.

- **Copyright** - This information comes from the `.COPYRIGHT` keyword in the comment-based metadata
  of a script file.

- **FileList** - The file list is created when the package is published to the PowerShell Gallery.
  It's not controllable by the manifest information. The PowerShell Gallery creates `.nuspec` file
  that appears in the file list of each package. This file isn't installed with the package on a
  system. This is the NuGet package manifest for the package and can be ignored.

- **Tags** - *This information comes from the `.TAGS` keyword in the comment-based metadata of a
  script file. Tags have specific requirements and meanings that are described in the
  [Tag Details][8] section.

- **PowerShell Editions** - For modules designed for PowerShell 5.0 and lower, this is controlled
  using **Tags**. For Desktop, use the tag PSEdition_Desktop, and for core, use the tag
  PSEdition_Core. For modules designed for PowerShell 5.1 and higher, there is a
  **CompatiblePSEditions** key in the manifest. For more information, see
  [PSEdition support for modules][10].

- **Version History** - Shows a list of versions of the module that have been published to the
  Gallery. Packages hidden using the **Delete** feature aren't displayed in the version history
  unless you are a package owner.

- **Project Site** - This information comes from the `.PROJECTURI` keyword in the comment-based
  metadata of a script file.

- **License** - This information comes from the `.LICENSEURI` keyword in the comment-based metadata
  of a script file.

  > [!IMPORTANT]
  > If a license isn't provided via the `.LICENSEURI` or within the package then the Terms of Use
  > for the PowerShell Gallery apply to the package. For more information, see the
  > [Terms of Use][11].

- **Icon** - This information comes from the `.ICONURI` keyword in the comment-based metadata of a
  script file. The URI should point to an 85x85 image with transparency background. The URI **must**
  be a direct link to the image file and **must not** go to a web page or a file in the PowerShell
  Gallery package.

## Editing package details

The PowerShell Gallery Edit package page allows publishers to change several of the fields displayed
for a package, specifically:

- Title
- Description
- Summary
- Icon URL
- Project home page URL
- Authors
- Copyright
- Tags
- Release notes
- Require license

You should only edit this information in the Gallery to correct what's displayed for an older
version of a module. Users that download the package will see the metadata doesn't match the
PowerShell Gallery. Any time you change information in the Gallery, you should publish a new version
of the package with the same changes.

## Tag details

Tags are simple strings consumers use to find packages. Tags are most valuable when they're used
consistently across related packages. Using variations of the same word, for example database and
databases or test and testing, provides little benefit. Tags are single-word case-insensitive
strings and can't include blanks. If there is a phrase that you believe users will search for, add
that to the package description so that it can be found in the search results. Use Pascal casing,
hyphens, underscores, or periods to improve readability. Be cautious about creating long, complex,
and unusual tags that are easily misspelled.

The PowerShell Gallery and PowerShellGet cmdlets have special meanings for the `PSEdition_Desktop`
and `PSEdition_Core` tags. See the preceding discussion of **PowerShell Editions**.

As noted previously, tags provide the most value when they're specific, and used consistently across
many packages. As a publisher trying to locate the best tags to use, the easiest approach is to
search the PowerShell Gallery for tags you are considering. Ideally, the packages returned align
with your use of that keyword.

The following table shows some of the most commonly used tags. The preferred tag should return the
best search results.

|   Preferred tag   |                                     Alternatives and notes                                      |
| ----------------- | ----------------------------------------------------------------------------------------------- |
| ActiveDirectory   | AD isn't currently used by itself                                                               |
| Appveyor          |                                                                                                 |
| Automation        |                                                                                                 |
| AWS               |                                                                                                 |
| Azure             |                                                                                                 |
| AzureAD           |                                                                                                 |
| AzureAutomation   |                                                                                                 |
| AzureRm           | Used primarily for the AzureRM modules                                                          |
| Backup            |                                                                                                 |
| Build             |                                                                                                 |
| ChatOps           |                                                                                                 |
| Cloud             |                                                                                                 |
| Color             |                                                                                                 |
| Configuration     |                                                                                                 |
| CrescendoBuilt    | This tag is added automatically by Crescendo when you export the module                         |
| Database          | Databases (plural) is less desirable                                                            |
| DBA               |                                                                                                 |
| Deployment        | Deploy is used somewhat less often                                                              |
| DevOps            |                                                                                                 |
| DNS               |                                                                                                 |
| Docker            |                                                                                                 |
| DSC               | DesiredStateConfiguration is less desirable, it's too long                                      |
| DSCResource       |                                                                                                 |
| DSCResourceKit    |                                                                                                 |
| Excel             |                                                                                                 |
| Exchange          |                                                                                                 |
| Firewall          |                                                                                                 |
| GIT               |                                                                                                 |
| GitHub            |                                                                                                 |
| Gitlab            |                                                                                                 |
| Google            |                                                                                                 |
| HTML              |                                                                                                 |
| Hyper-V           | HyperV is less common as a tag                                                                  |
| IaaS              |                                                                                                 |
| IIS               |                                                                                                 |
| Json              |                                                                                                 |
| Linux             |                                                                                                 |
| Log               | Preferred use of Log as a thing                                                                 |
| Logging           | Preferred use of logging as an action                                                           |
| MacOS             |                                                                                                 |
| Monitoring        |                                                                                                 |
| MSI               |                                                                                                 |
| Network           | Networking is similar, less often used                                                          |
| Office365         | Spelling out Office is preferable. O365 is less commonly used, although shorter                 |
| PackageManagement |                                                                                                 |
| Pester            |                                                                                                 |
| PoshBot           |                                                                                                 |
| Report            | Report is a thing                                                                               |
| Reporting         | Reporting is an action, report is a thing                                                       |
| ResourceManager   | "Arm" is used to describe group of processors, and shouldn't be used for Azure Resource Manager |
| REST              |                                                                                                 |
| Security          | Defense is less precise                                                                         |
| SharePoint        |                                                                                                 |
| SQL               |                                                                                                 |
| SQLServer         |                                                                                                 |
| Storage           |                                                                                                 |
| Test              | Testing is less desirable                                                                       |
| VersionControl    | Version is less precise, although used more frequently                                          |
| VSTS              |                                                                                                 |
| Windows           |                                                                                                 |
| WinRM             |                                                                                                 |
| WMI               |                                                                                                 |
| Zip               |                                                                                                 |

<!-- link references -->
[1]: xref:Microsoft.PowerShell.Core.New-ModuleManifest
[2]: xref:PowerShellGet.Update-ModuleManifest
[3]: xref:PowerShellGet.New-ScriptFileInfo
[4]: xref:PowerShellGet.Update-ScriptFileInfo
[5]: module-prerelease-support.md
[6]: ../how-to/working-with-packages/packages-that-require-license-acceptance.md
[7]: ../how-to/publishing-packages/managing-package-owners.md
[8]: #tag-details
[9]: /powershell/scripting/learn/remoting/jea/role-capabilities
[10]: module-psedition-support.md
[11]: https://www.powershellgallery.com/policies/Terms
[12]: script-prerelease-support.md
[13]: script-license-acceptance.md
