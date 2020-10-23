---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Setting up a DSC pull client
description: This article is an overview of the information available for setting up the DSC pull client.
---
# Setting up a DSC pull client

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

> [!IMPORTANT]
> The Pull Server (Windows Feature *DSC-Service*) is a supported component of Windows Server however
> there are no plans to offer new features or capabilities. It is recommended to begin transitioning
> managed clients to [Azure Automation DSC](/azure/automation/automation-dsc-getting-started)
> (includes features beyond Pull Server on Windows Server) or one of the community solutions listed
> [here](pullserver.md#community-solutions-for-pull-service).

Each target node has to be told to use pull mode and given the URL or file location where it can
contact the pull server to get configurations and resources, and where it should send report data.

The following topics explain how to set up pull clients:

- [Setting up a pull client using configuration names](pullClientConfigNames.md)
*-[Setting up a pull client using configuration ID](pullClientConfigID.md)

> [!NOTE]
> These topics apply to PowerShell 5.0. To set up a pull client in PowerShell 4.0, see
> [Setting up a pull client using configuration ID in PowerShell 4.0](pullClientConfigID4.md).
