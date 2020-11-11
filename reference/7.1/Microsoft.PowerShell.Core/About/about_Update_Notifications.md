---
description:  Notifies users on startup of PowerShell that a new version of PowerShell has been released. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_update_notifications?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Update_Notifications
---

# About Update Notifications

## SHORT DESCRIPTION

Notifies users on startup of PowerShell that a new version of PowerShell has
been released.

## LONG DESCRIPTION

Beginning with PowerShell 7.0, PowerShell uses update notifications to alert
users to the existence of updates to PowerShell. Once per day, PowerShell
queries an online service to determine if a newer version is available.

> [!NOTE]
> While the update check happens during the first session in a given 24-hour
> period, for performance reasons, the notification will only be shown on the
> start of subsequent sessions. Also for performance reasons, the check will
> not start until at least 3 seconds after the session begins.

By default, PowerShell subscribes to one of two different notification channels
depending on its version/branch. Supported, Generally Available (GA) versions of
PowerShell only return notifications for updated GA releases. Preview and
Release Candidate (RC) releases notify of updates to preview, RC, and GA
releases.

The update notification behavior can be changed using the
`POWERSHELL_UPDATECHECK` environment variable. The following values are
supported:

- `Off` turns off the update notification feature
- `Default` is the same as not defining `POWERSHELL_UPDATECHECK`:
  - GA releases notify of updates to GA releases
  - Preview/RC releases notify of updates to GA and preview releases
- `LTS` only notifies of updates to long-term-servicing (LTS) GA releases

The following endpoints are currently used for determining the latest version of
each channel:

- `LTS`: https://aka.ms/pwsh-buildinfo-lts
- `Stable`: https://aka.ms/pwsh-buildinfo-stable
- `Preview`: https://aka.ms/pwsh-buildinfo-preview

The update notification doesn't provide any way to automatically update
PowerShell. In the future, there may be more instructions or capabilities to
update from within PowerShell, but today, you should use the same install
mechanism you used to install PowerShell to update it.

