---
ms.date:  06/12/2017
title:  Get Started with the PowerShell Gallery
description: This article explains how to get started using the PowerShell Gallery and the PowerShellGet cmdlets
---
# Getting Started with the PowerShell Gallery

The PowerShell Gallery is a package repository containing scripts, modules, and DSC resources you
can download and leverage. You use the cmdlets in the
[PowerShellGet](/powershell/module/powershellget) module to install packages from the PowerShell
Gallery. You do not need to sign in to download items from the PowerShell Gallery.

> [!NOTE]
> It is possible to download a package from the PowerShell Gallery directly, but this is not a
> recommended approach. For more details, see
> [Manual Package Download](how-to/working-with-packages/manual-download.md).

## Discovering packages from the PowerShell Gallery

You can find packages in the PowerShell Gallery by using the **Search** control on the PowerShell
Gallery's [home page](https://www.powershellgallery.com), or by browsing through the Modules and
Scripts from the [Packages page](https://www.powershellgallery.com/packages). You can also find
packages from the PowerShell Gallery by running the [Find-Module][], [Find-DscResource], and
[Find-Script][] cmdlets, depending on the package type, with `-Repository PSGallery`.

You can filter results from the Gallery by using the following parameters:

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
[Find-DscResource][] cmdlet. Find-DscResource returns data on DSC resources contained in the
Gallery. Because DSC resources are always delivered as part of a module, you still need to run
[Install-Module][] to install those DSC resources.

## Learning about packages in the PowerShell Gallery

Once you've identified a package that you're interested in, you may want to learn more about it. You
can do this by examining that package's specific page on the Gallery. On that page, you'll be able
to see all of the metadata uploaded with the package. This metadata is provided by the package's
author, and is not verified by Microsoft. The Owner of the package is strongly tied to the Gallery
account used to publish the package, and is more trustworthy than the Author field.

If you discover a package that you feel is not published in good faith, click **Report Abuse** on
that package's page.

If you're running [Find-Module][] or [Find-Script][], you can view this data in the returned
PSGetModuleInfo object. For example, running
`Find-Module -Name PSReadLine -Repository PSGallery |Get-Member` returns data on the PSReadLine
module in the Gallery.

## Downloading packages from the PowerShell Gallery

We encourage the following process when downloading packages from the PowerShell Gallery:

### Inspect

To download a package from the Gallery for inspection, run either the [Save-Module][] or
[Save-Script][] cmdlet, depending on the package type. This lets you save the package locally
without installing it, and inspect the package contents. Remember to delete the saved package
manually.

Some of these packages are authored by Microsoft, and others are authored by the PowerShell
community. Microsoft recommends that you review the contents and code of packages on this gallery
prior to installation.

If you discover a package that you feel is not published in good faith, click **Report Abuse** on
that package's page.

### Install

To install a package from the Gallery for use, run either the [Install-Module][] or
[Install-Script][] cmdlet, depending on the package type.

[Install-Module][] installs the module to `$env:ProgramFiles\WindowsPowerShell\Modules` by default.
This requires an administrator account. If you add the `-Scope CurrentUser` parameter, the module is
installed to `$env:USERPROFILE\Documents\WindowsPowerShell\Modules` .

[Install-Script][] installs the script to `$env:ProgramFiles\WindowsPowerShell\Scripts` by default.
This requires an administrator account. If you add the `-Scope CurrentUser` parameter, the script is
installed to `$env:USERPROFILE\Documents\WindowsPowerShell\Scripts` .

By default, [Install-Module][] and [Install-Script][] installs the most current version of a
package. To install an older version of the package, add the `-RequiredVersion` parameter.

### Deploy

To deploy a package from the PowerShell Gallery to Azure Automation, click **Azure Automation**,
then click **Deploy to Azure Automation** on the package details page. You are redirected to the
Azure Management Portal where you sign in by using your Azure account credentials. Note that
deploying packages with dependencies deploys all the dependencies to Azure Automation. The 'Deploy
to Azure Automation' button can be disabled by adding the **AzureAutomationNotSupported** tag to
your package metadata.

To learn more about Azure Automation, see the [Azure Automation](/azure/automation) documentation.

## Updating packages from the PowerShell Gallery

To update packages installed from the PowerShell Gallery, run either the [Update-Module][] or
[Update-Script][] cmdlet. When run without any additional parameters, [Update-Module][] attempts to
update all modules installed by running [Install-Module][]. To selectively update modules, add the
`-Name` parameter.

Similarly, when run without any additional parameters, [Update-Script][] also attempts to update all
scripts installed by running [Install-Script][]. To selectively update scripts, add the `-Name`
parameter.

## List packages that you have installed from the PowerShell Gallery

To find out which modules you have installed from the PowerShell Gallery, run the
[Get-InstalledModule][] cmdlet. This command lists all of the modules you have on your system that
were installed directly from the PowerShell Gallery.

Similarly, to find out which scripts you have installed from the PowerShell Gallery, run the
[Get-InstalledScript][] cmdlet. This command lists all the scripts you have on your system that were
installed directly from the PowerShell Gallery.

## Network access to the PowerShell Gallery

The PowerShell Gallery uses the following hostnames.

- `psg-prod-eastus.azureedge.net` - CDN hostname
- `az818661.vo.msecnd.net` - CDN hostname
- `devopsgallerystorage.blob.core.windows.net` - storage account hostname
- `*.powershellgallery.com` - website
- `go.microsoft.com` - redirection service

These hostnames should be added to the allow lists that control access from your network.

[!INCLUDE [TLS 1.2 Requirement](../../includes/tls-gallery.md)]

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
[Update-Module]: /powershell/module/powershellget/Update-Module
[Update-Script]: /powershell/module/powershellget/Update-Script
