---
ms.date:  06/12/2017
contributor:  JKeithB
keywords:  gallery,powershell,cmdlet,psgallery
title:  Get Started with the PowerShell Gallery
---
# Get Started with the PowerShell Gallery

Downloading items from the PowerShell Gallery to your system requires the
[PowerShellGet](/powershell/module/powershellget) module. You can find the PowerShellGet module in
any of the following. You do not need to sign in to download items from the PowerShell Gallery.

## Discovering items from the PowerShell Gallery

You can find items in the PowerShell Gallery by using the **Search** control on this website, or by
browsing through the Modules and Scripts pages. You can also find items from the PowerShell Gallery
by running the [Find-Module][] and [Find-Script][] cmdlets, depending on the item type, with
`-Repository PSGallery`.

Filtering results from the Gallery can be done by using the following parameters:

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

If you're only interested in discovering specific DSC resources in the Gallery, you can run the
[Find-DscResource] cmdlet. Find-DscResource returns data on DSC resources contained in the Gallery.
Because DSC resources are always delivered as part of a module, you still need to run
[Install-Module][] to install those DSC resources.

## Learning about items in the PowerShell Gallery

Once you've identified an item you're interested in, you may want to learn more about it. You can
do this by examining that item's specific page on the Gallery. On that page, you'll be able to see
all of the metadata uploaded with the item. This metadata for an item is provided by the item's
author, and is not verified by Microsoft. The Owner of the item is strongly tied to the Gallery
account used to publish the item, and is more trustworthy than the Author field.

If you discover an item that you feel is not published in good faith, click **Report Abuse** on
that item's page.

If you're running [Find-Module][] or [Find-Script][], you can view this data in the returned
PSGetModuleInfo object. For example, running
`Find-Module -Name PSReadLine -Repository PSGallery |Get-Member`
returns data on the PSReadLine module in the Gallery.

## Downloading items from the PowerShell Gallery

We encourage the following process when downloading items from the PowerShell Gallery:

### Inspect

To download an item from the Gallery for inspection, run either the [Save-Module][] or
[Save-Script][] cmdlet, depending on the item type. This lets you save the item locally without
installing it, and inspect the item contents. Remember to delete the saved item manually.

Some of these items are authored by Microsoft, and others are authored by the PowerShell community.
Microsoft recommends that you review the contents and code of items on this gallery prior to
installation.

If you discover an item that you feel is not published in good faith, click **Report Abuse** on
that item's page.

### Install

To install an item from the Gallery for use, run either the [Install-Module][] or
[Install-Script][] cmdlet, depending on the item type.

[Install-Module][] installs the module to `$env:ProgramFiles\WindowsPowerShell\Modules` by default.
This requires an administrator account. If you add the `-Scope CurrentUser` parameter, the module
is installed to `$env:USERPROFILE\Documents\WindowsPowerShell\Modules` .

[Install-Script][] installs the script to `$env:ProgramFiles\WindowsPowerShell\Scripts` by default.
This requires an administrator account. If you add the `-Scope CurrentUser` parameter, the script
is installed to `$env:USERPROFILE\Documents\WindowsPowerShell\Scripts` .

By default, [Install-Module][] and [Install-Script][] installs the most current version of an item.
To install an older version of the item, add the `-RequiredVersion` parameter.

### Deploy

To deploy an item from the PowerShell Gallery to Azure Automation, click **Deploy to Azure
Automation** on the item details page. You will be redirected to the Azure Management Portal, where
you sign in by using your Azure account credentials. Note that deploying items with dependencies
will deploy all the dependencies to Azure Automation. The 'Deploy to Azure Automation' button can
be disabled by adding the **AzureAutomationNotSupported** tag to your item metadata.

To learn more about Azure Automation, see the [Azure Automation](/azure/automation) documentation.

## Updating items from the PowerShell Gallery

To update items installed from the PowerShell Gallery, run either the [Update-Module][] or
[Update-Script][] cmdlet. When run without any additional parameters, [Update-Module][] attempts to
update each module installed by running [Install-Module][]. To selectively update modules, add the
`-Name` parameter.

Similarly, when run without any additional parameters, [Update-Script][] also attempts to update
each script installed by running [Install-Script][]. To selectively update scripts, add the `-Name`
parameter.

## List items that you have installed from the PowerShell Gallery

To find out which modules you have installed from the PowerShell Gallery, run the
[Get-InstalledModule][] cmdlet. This command lists all of the modules you have on your system that
were installed directly from the PowerShell Gallery.

Similarly, to find out which scripts you have installed from the PowerShell Gallery, run the
[Get-InstalledScript][] cmdlet. This command lists all of the scripts you have on your system that
were installed directly from the PowerShell Gallery.

[Find-DscResource]: /powershell/module/powershellget/Find-DscResource
[Find-Module]: /powershell/module/powershellget/Find-Module
[Find-Script]: /powershell/module/powershellget/Find-Script
[Get-InstalledModule]: /powershell/module/powershellget/Get-InstalledModule
[Get-InstalledScript]: /powershell/module/powershellget/Get-InstalledScript
[Install-Module]: /powershell/module/powershellget/Install-Module
[Install-Script]: /powershell/module/powershellget/Install-Script
[Publish-Module]: /powershell/module/powershellget/Publish-Module
[Publish-Script]: /powershell/module/powershellget/Publish-Script
[Register-PSRepository]: /powershell/module/powershellget/Register-Repository
[Save-Module]: /powershell/module/powershellget/Save-Module
[Save-Script]: /powershell/module/powershellget/Save-Script