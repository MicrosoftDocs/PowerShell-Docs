---
ms.date:  06/09/2017
title:  Package manifest values that impact the PowerShell Gallery UI
description: This article documents the values in the module manifest that are used by the PowerShell Gallery.
---
# Package manifest values that impact the PowerShell Gallery UI

This topic provides publishers with summary information on how to modify the manifest for their
PowerShell Gallery publications so that features of PowerShellGet cmdlets and the PowerShell
Gallery UI will be affected. This content is organized by where the change will appear, starting
with the center section, then the navigation area on the left. There is a detail section covering
tags, which identifies important tags, as well as some of the more commonly used tags. There are
two topics that provide manifest examples:

- For modules, see [Update Module Manifest](/powershell/module/powershellget/Update-ModuleManifest)
- For scripts, see [Create Script File with Metadata](/powershell/module/powershellget/New-ScriptFileInfo)

## PowerShell Gallery Feature Elements Controlled by the Manifest

The table below shows the elements of the PowerShell Gallery package page UI that are controlled by
the publisher. Each item indicates if it may be controlled by the module or script manifest.

| UI Element | Description | Module | Script |
| --- | --- | --- | --- |
| **Title** | This is the name of the package that is published to the Gallery  | No | No |
| **Version** | The version displayed is the version string in the metadata, and a prerelease if is specified. The primary portion of the version in a Module manifest is the ModuleVersion. For a script, it is identified as .VERSION. If a prerelease version string is specified, it will be appended to the ModuleVersion for modules, or specified as part of .VERSION for scripts. There is documentation for specifying prerelease strings in [modules](module-prerelease-support.md), and in [scripts](script-prerelease-support.md) | Yes | Yes |
| **Description** | This is the Description in the module manifest, and in a script file manifest it is .DESCRIPTION | Yes | Yes |
| **Require license acceptance** | A module can require that the user accept a license, by modifying the module manifest with RequireLicenseAcceptance = $true, supplying a LicenseURI, and providing a license.txt file in the root of the module folder. Additional information is available in the [Require License Acceptance](../how-to/working-with-packages/packages-that-require-license-acceptance.md) topic. | Yes | No |
| **Release notes** | For modules, this information is drawn from the ReleaseNotes section, under PSData\PrivateData. In script manifests, it is the .RELEASENOTES element. | Yes | Yes |
| **Owners** | Owners are the list of users in the PowerShell Gallery who can update a package. The owner list is not included in the package manifest. Additional documentation describes how to [manage item owners](../how-to/publishing-packages/managing-package-owners.md). | No | No |
| **Author** | This is included in the module manifest as the Author, and in a script manifest as .AUTHOR. The Author field is often used to specify a company or organization associated with a package. | Yes | Yes |
| **Copyright** | This is the Copyright field in the module manifest, and .COPYRIGHT in a script manifest. | Yes | Yes |
| **FileList** | The file list is drawn from the package when it is published to the PowerShell Gallery. It is not controllable by the manifest information. Note: there is an additional .nuspec file listed with each package in the PowerShell Gallery that is not present after installing the package on a system. This is the Nuget package manifest for the package, and may be ignored. | No | No |
| **Tags** | For modules, Tags are included under PSData\PrivateData. For scripts, the section is labelled .TAGS. Note that tags cannot contain spaces, even when they are in quotes. Tags have additional requirements and meanings, which are described later in this topic in the Tag Details section. | Yes | Yes |
| **Cmdlets** | This is provided in the module manifest using CmdletsToExport. Note that the best practice is to explicitly list the items, rather than using the wildcard "*", as that will improve the load-module performance for users. | Yes | No |
| **Functions** | This is provided in the module manifest using FunctionsToExport. Note that the best practice is to explicitly list the items, rather than using the wildcard "*", as that will improve the load-module performance for users. | Yes | No |
| **DSC Resources** | For modules that will be used on PowerShell version 5.0 and above, this is provided in the manifest using DscResourcesToExport. If the module is to be used in PowerShell 4, the DSCResourcesToExport should not be used as it is not a supported manifest key. (DSC was not available prior to PowerShell 4.) | Yes | No |
| **Workflows** | Workflows are published to the PowerShell Gallery as scripts, and identified as workflows (see [Connect-AzureVM](https://www.powershellgallery.com/packages/Connect-AzureVM/1.0/Content/Connect-AzureVM.ps1) for an example) in the code. This is not controlled by the manifest. | No | No |
| **Role capabilities** | This will be listed when the module published to the PowerShell Gallery contains one or more role capability (.psrc) files, which are used by JEA. See the JEA documentation for more details on [role capabilities](/powershell/scripting/learn/remoting/jea/role-capabilities). | Yes | No |
| **PowerShell Editions** | This is specified in a script or module manifest. For modules designed to be used with PowerShell 5.0 and below, this is controlled using Tags. For Desktop, use the tag PSEdition_Desktop, and for core, use the tag PSEdition_Core. For modules that will be used only on PowerShell 5.1 and above, there is a CompatiblePSEditions key in the main manifest. For additional detail, review the PS Edition feature in [the PowerShell Get documentation](module-psedition-support.md). | Yes | Yes |
| **Dependencies** | Dependencies are the modules in the PowerShell Gallery that are declared in either the module as RequiredModules, or in the script manifest as #Requires –Module (name). | Yes | Yes |
| **Minimum PowerShell version** | This can be specified in a module manifest as PowerShellVersion | Yes | No |
| **Version History** | The version history reflects the updates made to a module in the PowerShell Gallery. If a version of a package is hidden using the Delete feature, it will not be displayed in the version history, except to the package owners. | No | No |
| **Project Site** | The project site is provided for modules in the Privatedata\PSData section of the module manifest by specifying a ProjectURI. In the script manifest, it is controlled by specifying .PROJECTURI. | Yes | Yes |
| **License** | A license link is provided for modules in the Privatedata\PSData section of the module manifest by specifying a LicenseURI. In the script manifest, it is controlled by specifying .LICENSEURI. It is important to note that if a license is not provided via the LicenseURI, or within a module, then the terms of use for the PowerShell Gallery specify the terms of use for the package. See the terms of use for details. | Yes | Yes |
| **Icon** | An icon can be specified for any package in the PowerShell Gallery by supplying the IconURI flag in the script manifest, or in the Privatedata-PSData section of the module manifest. The IconURI should point to a 85x85 image with transparency background. The URI **must** be a direct image URL and **must not** go to a web page containing the image, or a file in the PowerShell Gallery package. | Yes | Yes |

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

This approach is not generally recommended, except when needed to correct what is displayed for an
older version of a module. Users who acquire the module will see the metadata does not match what
is displayed in the PowerShell Gallery, which raises concerns about the package. This will frequently
result in inquiries going to the package owners to confirm the change. It is strongly recommended
that any time this approach is used, a new version of the package should be published with the same
changes.

## Tag Details

Tags are simple strings consumers use to find packages. Tags are most valuable when they are used
consistently across many packages related to the same topic. Using multiple flavors of the same word
(for example database and databases, or test and testing) typically provides little benefit. Tags
are single-word case-insensitive strings and cannot include blanks. If there is a phrase you
believe users will search for, add that to the package description and it will be found in the search
results. Use Pascal casing, hyphen, underscore, or period if you are trying to improve readability.
Be cautious about creating long, complex, and unusual tags, as they are often misspelled.

There are tags that are important to note, as the PowerShell Gallery and PowerShellGet cmdlets
treat them uniquely. PSEdition_Desktop and PSEdition_Core are the specific examples, and are
described above.

As noted above, tags provide the most value when they are specific, and used consistently across
many packages. As a publisher trying to locate the best tags to use, the easiest approach is to search
the PowerShell Gallery for tags you are considering. Ideally, there will be many packages returned,
and the package descriptions will align with your use of that key word.

For reference, here are some most commonly used tags as of 12/14/2017. In some cases, there are
similar but perhaps less ideal options listed beside the tag. It is a best practice to use the
Preferred Tag, as that will result in less noise, and better search results for consumers.

| Preferred tag | Alternatives and notes |
| --- | --- |
| Azure |  |
| DSC | DesiredStateConfiguration is less desirable, it's too long |
| ResourceManager | ARM is used to describe group of processors, and should not be used for Azure Resource Manager |
| DSCResourceKit |  |
| SQL |  |
| AWS |  |
| DSCResource |  |
| Automation |  |
| REST |  |
| ActiveDirectory | AD is not currently used by itself  |
| SQLServer |  |
| DBA |  |
| Security | Defense is less precise |
| Database | Databases (plural) is less desirable |
| DevOps |  |
| Windows |  |
| Build |  |
| Deployment | Deploy is used somewhat less often |
| Cloud |  |
| GIT |  |
| Test | Testing is less desirable |
| VersionControl | Version is less precise, although used more frequently  |
| Logging | Preferred use of logging as an action |
| Log | Preferred use of Log as a thing |
| Backup |  |
| IaaS |  |
| Linux |  |
| IIS |  |
| AzureAutomation |  |
| Storage |  |
| GitHub |  |
| Json |  |
| Exchange |  |
| Network | Networking is similar, less often used |
| SharePoint |  |
| Reporting | Reporting is an action, report is a thing |
| Report | Report is a thing |
| WinRM |  |
| Monitoring |  |
| VSTS |  |
| Excel |  |
| Google |  |
| Color |  |
| DNS |  |
| Office365 | Spelling out Office is preferable. O365 is less commonly used, although shorter |
| Gitlab |  |
| Pester |  |
| AzureAD |  |
| HTML |  |
| Hyper-V | HyperV is less common as a tag |
| Configuration |  |
| ChatOps |  |
| PackageManagement |  |
| WMI |  |
| Firewall |  |
| Docker |  |
| Appveyor |  |
| AzureRm | Used primarily for the AzureRM modules |
| Zip |  |
| MSI |  |
| MacOS |  |
| PoshBot |  |
