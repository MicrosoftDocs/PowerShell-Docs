---
ms.date:  2017-06-12
contributor:  JKeithB
ms.topic:  conceptual
keywords:  gallery,powershell,cmdlet,psgallery
title:  psgallery_gettingstarted
---

# Get Started with the PowerShell Gallery

## What is the PowerShell Gallery?

The PowerShell Gallery is the central repository for PowerShell content.
In it, you can find useful PowerShell modules containing PowerShell
commands and Desired State Configuration (DSC) resources. You can also
find PowerShell scripts, some of which may contain PowerShell workflows,
and which outline a set of tasks and provide sequencing for those tasks.
Some of these items are authored by Microsoft, and others are authored
by the PowerShell community.

## Requirements

Downloading items from the PowerShell Gallery to your system requires
the
[PowerShellGet](http://go.microsoft.com/fwlink/?LinkID=760387&clcid=0x409)
module. You can find the
PowerShellGet
module in any of the following. You do not need to sign in to download
items from the PowerShell Gallery.

-   [Windows
    10](http://go.microsoft.com/fwlink/?LinkID=624830&clcid=0x409)
-   [Windows Management Framework
    5.0](http://go.microsoft.com/fwlink/?LinkId=398175)
-   [MSI Installer (for PowerShell 3
    and 4)](http://go.microsoft.com/fwlink/?LinkID=746217&clcid=0x409)

PowerShellGet also requires the [NuGet
provider](http://go.microsoft.com/fwlink/?LinkId=722208) to work with
the PowerShell Gallery. You will be prompted to install the NuGet
provider automatically upon first use of PowerShellGet if the NuGet
provider is not in one of the following locations:

- `$env:ProgramFiles\PackageManagement\ProviderAssemblies`
- `$env:LOCALAPPDATA\PackageManagement\ProviderAssemblies`

Or, you can run `Install-PackageProvider -Name NuGet -Force` to
automate the download and installation of the NuGet provider.

  
If you have a version older than 2.8.5.201 of NuGet, you will need to call the following
PowerShell cmdlets to install and switch to the latest version of NuGet.

1.  `Install-PackageProvider NuGet -MinimumVersion '2.8.5.201' -Force`
2.  `Import-PackageProvider NuGet -MinimumVersion '2.8.5.201' -Force`
3.  Delete the older version of NuGet from the above installed location.

For more information, see <http://oneget.org/> .

  
Note: Due to changes in packaging formats, we recommend you update to
the latest version of PowerShellGet and PackageManagement to install
items that have been updated recently. PowerShellGet is included in
Windows 10, which you can learn more about
[here](http://go.microsoft.com/fwlink/?LinkID=624830&clcid=0x409).
PowerShellGet is also part of the Windows Management Framework (WMF)
5.0, which you can download
[here](http://go.microsoft.com/fwlink/?LinkId=398175).

## Discovering items from the PowerShell Gallery

You can find items in the PowerShell Gallery by using the **Search**
control on this website, or by browsing through the Modules and Scripts
pages. You can also find items from the PowerShell Gallery by running
the
[Find-Module](https://go.microsoft.com/fwlink/?LinkId=821658)
and
[Find-Script](https://go.microsoft.com/fwlink/?LinkId=822322)
cmdlets, depending on the item type, with `-Repository PSGallery`.

Filtering results from the Gallery can be done by using the following
parameters of
[Find-Module](https://go.microsoft.com/fwlink/?LinkId=821658)
and
[Find-Script](https://go.microsoft.com/fwlink/?LinkId=822322)

- Name
- AllVersions
- MinimumVersion
- RequiredVersion
- Tag
- Includes
- DscResource
- RoleCapability
- Command
- Filter

If you're only interested in discovering specific DSC resources in the
Gallery, you can run the
[Find-DscResource](https://go.microsoft.com/fwlink/?LinkId=517196)
cmdlet.
[Find-DscResource](https://go.microsoft.com/fwlink/?LinkId=517196)
returns data on DSC resources contained in the Gallery. Because DSC
resources are always delivered as part of a module, you still need to
run
[Install-Module](https://go.microsoft.com/fwlink/?LinkId=821663)
to install those DSC resources.

## Learning about items in the PowerShell Gallery

Once you've identified an item you're interested in, you may want to
learn more about it. You can do this by examining that item's specific
page on the Gallery. On that page, you'll be able to see all of the
metadata uploaded with the item. This metadata for an item is provided
by the item's author, and is not verified by Microsoft. The Owner of the
item is strongly tied to the Gallery account used to publish the item,
and is more trustworthy than the Author field.

If you discover an item that you feel is not published in good faith,
click **Report Abuse** on that item's page.

If you're running
[Find-Module](https://go.microsoft.com/fwlink/?LinkId=821658)
or
[Find-Script](https://go.microsoft.com/fwlink/?LinkId=822322),
you can view this data in the returned PSGetModuleInfo object.
For example, running
`Find-Module -Name PSReadLine -Repository PSGallery | Get-Member`
returns data on the PSReadLine module in the Gallery.

## Downloading items from the PowerShell Gallery

We encourage the following process when downloading items from the
PowerShell Gallery:

### Inspect

To download an item from the Gallery for inspection, run either the
[Save-Module](https://go.microsoft.com/fwlink/?LinkId=821669)
or
[Save-Script](https://go.microsoft.com/fwlink/?LinkId=822334)
cmdlet, depending on the item type. This lets you save the item locally
without installing it, and inspect the item contents. Remember to delete
the saved item manually.

Some of these items are authored by Microsoft, and others are authored
by the PowerShell community. Microsoft recommends that you review the
contents and code of items on this gallery prior to installation.

If you discover an item that you feel is not published in good faith,
click **Report Abuse** on that item's page.

### Install

To install an item from the Gallery for use, run either the
[Install-Module](https://go.microsoft.com/fwlink/?LinkId=821663)
or
[Install-Script](https://go.microsoft.com/fwlink/?LinkId=822327)
cmdlet, depending on the item type.

[Install-Module](https://go.microsoft.com/fwlink/?LinkId=821663)
installs the module to `$env:ProgramFiles\WindowsPowerShell\Modules` by
default. This requires an administrator account. If you add the `-Scope
CurrentUser` parameter, the module is installed to
`$env:USERPROFILE\Documents\WindowsPowerShell\Modules` .

[Install-Script](https://go.microsoft.com/fwlink/?LinkId=822327)
installs the script to `$env:ProgramFiles\WindowsPowerShell\Scripts` by
default. This requires an administrator account. If you add the `-Scope
CurrentUser` parameter, the script is installed to
`$env:USERPROFILE\Documents\WindowsPowerShell\Scripts` .

By default,
[Install-Module](https://go.microsoft.com/fwlink/?LinkId=821663)
and
[Install-Script](https://go.microsoft.com/fwlink/?LinkId=822327)
installs the most current version of an item. To install an older
version of the item, add the `-RequiredVersion` parameter.

### Deploy

To deploy an item from the PowerShell Gallery to Azure Automation, click
**Deploy to Azure Automation** on the item details page. You will be
redirected to the Azure Management Portal, where you sign in by using
your Azure account credentials. Note that deploying items with
dependencies will deploy all the dependencies to Azure Automation. The
'Deploy to Azure Automation' button can be disabled by adding the
**AzureAutomationNotSupported** tag to your item metadata.

To learn more about Azure Automation, see the [Azure Automation
website](http://azure.microsoft.com/en-us/services/automation/).

## Updating items from the PowerShell Gallery

To update items installed from the PowerShell Gallery, run either the
[Update-Module](https://go.microsoft.com/fwlink/?LinkID=398576)
or
[Update-Script](http://go.microsoft.com/fwlink/?LinkId=619787)
cmdlet. When run without any additional parameters,
[Update-Module](https://go.microsoft.com/fwlink/?LinkID=398576)
attempts to update each module installed by running
[Install-Module](https://go.microsoft.com/fwlink/?LinkId=821663).
To selectively update modules, add the `-Name` parameter.

Similarly, when run without any additional parameters,
[Update-Script](http://go.microsoft.com/fwlink/?LinkId=619787)
also attempts to update each script installed by running
[Install-Script](https://go.microsoft.com/fwlink/?LinkId=822327).
To selectively update scripts, add the `-Name` parameter.

## List items that you have installed from the PowerShell Gallery

To find out which modules you have installed from the PowerShell
Gallery, run the
[Get-InstalledModule](https://go.microsoft.com/fwlink/?LinkId=526863)
cmdlet. This command lists all of the modules you have on your system
that were installed directly from the PowerShell Gallery.

Similarly, to find out which scripts you have installed from the
PowerShell Gallery, run the
[Get-InstalledScript](https://go.microsoft.com/fwlink/?LinkId=619790)
cmdlet. This command lists all of the scripts you have on your system
that were installed directly from the PowerShell Gallery.

