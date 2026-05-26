---
description: Notifies users on startup of PowerShell that a new version of PowerShell has been released.
Locale: en-US
ms.date: 05/26/2026
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
users to the existence of updates to PowerShell. Every time PowerShell starts,
PowerShell waits 3 seconds before it checks for updated versions. Since
PowerShell waits 3 seconds before checking for updates, you might not see the
update notification until the next time you start PowerShell.

If update notification is enabled, it checks to see if it has been more than 24
hours since the last check for updates. If it has been more than 24 hours, it
checks the appropriate endpoint for the latest version of PowerShell.
PowerShell only displays the update notification when the release date of the
the newer version is more than 7 days old. This delay allows time for the
publication of the various package types to become available before you are
notified of the update.

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

- `LTS`: [https://aka.ms/pwsh-buildinfo-lts][02]
- `Stable`: [https://aka.ms/pwsh-buildinfo-stable][03]
- `Preview`: [https://aka.ms/pwsh-buildinfo-preview][04]

The update notification doesn't provide any way to automatically update
PowerShell. In the future, there may be more instructions or capabilities to
update from within PowerShell, but today, you should use the same install
mechanism you used to install PowerShell to update it.

<!-- link references -->
[01]: ../about/about_Environment_Variables.md
[02]: https://aka.ms/pwsh-buildinfo-lts
[03]: https://aka.ms/pwsh-buildinfo-stable
[04]: https://aka.ms/pwsh-buildinfo-preview
