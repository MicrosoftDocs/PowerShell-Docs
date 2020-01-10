---
keywords: powershell,cmdlet
locale: en-us
ms.date: 01/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_update_notifications?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Update_Notifications
---
# About Update Notifications

## SHORT DESCRIPTION
Notifies users on startup of PowerShell that a new version of PowerShell has
been released.

## LONG DESCRIPTION

Unless users are monitoring PowerShell release channels, it can be difficult for
them to know if a new version is available for update. This feature checks an
online service once per day to determine if a newer version of PowerShell is
available.

> [!NOTE]
> While the update check happens during the first session in a given 24-hour
> period, for performance reasons, the notification will only be shown on the
> start of subsequent sessions. Also for performance reasons, the check will
> not start until at least 3 seconds after the session begins.

By default, PowerShell subscribes to one of two different notification channels
depending on its version/branch, GA and Preview. Supported, Generally Available
(GA) versions of PowerShell only return notifications for updated GA releases,
and preview and Release Candidate (RC) releases notify of updates to preview,
RC, and GA releases.

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

The update notification does not provide any way to automatically update.
In the future, we may have more instructions or capabilities for updating from
within PowerShell, but today, you should use the same install mechanism you used
to originally install PowerShell in order to update.