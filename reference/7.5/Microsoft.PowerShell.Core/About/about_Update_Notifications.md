---
description: Notifies users on startup of PowerShell that a new version of PowerShell has been released.
Locale: en-US
ms.date: 12/02/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_update_notifications?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Update_Notifications
---

# about_Update_Notifications

## Short description

Notifies users on startup of PowerShell that a new version of PowerShell has
been released.

## Long description

Beginning with PowerShell 7.0, PowerShell uses update notifications to alert
users to the existence of updates to PowerShell. Once per day, PowerShell
queries an online service to determine if a newer version is available.

> [!NOTE]
> While the update check happens during the first session in a given 24-hour
> period, for performance reasons, PowerShell shows the notification on the
> start of subsequent sessions. Also for performance reasons, the check for
> updates starts 3 seconds after the session begins.

By default, PowerShell subscribes to different notification channels depending
on its version and branch. Generally Available (GA) versions of PowerShell only
return notifications for updated GA releases. Preview and Release Candidate
(RC) versions notify of updates to preview, RC, and GA releases.

## Manage notification behavior

You can change the behavior of the update notification by setting the
`POWERSHELL_UPDATECHECK` environment variable. The following values are
supported:

- `Off` turns off the update notification feature
- `Default` is the same as not defining `POWERSHELL_UPDATECHECK`:
  - GA releases notify of updates to GA releases
  - Preview/RC releases notify of updates to GA and preview releases
- `LTS` only notifies of updates to long-term-servicing (LTS) GA releases

You must set this environment variable before PowerShell starts. For more
information about setting environment variables, see
[about_Environment_Variables][01].

## Notification endpoints

PowerShell uses the following endpoints for determining the latest version
available for each channel:

- `LTS`: <https://aka.ms/pwsh-buildinfo-lts>
- `Stable`: <https://aka.ms/pwsh-buildinfo-stable>
- `Preview`: <https://aka.ms/pwsh-buildinfo-preview>

The update notification doesn't provide any way to automatically update
PowerShell. In the future, there may be more instructions or capabilities to
update from within PowerShell, but today, you should use the same install
mechanism you used to install PowerShell to update it.

<!-- link references -->
[01]: ../about/about_Environment_Variables.md
