---
description: Remoting in PowerShell using WSMan
ms.date: 10/03/2023
title: Using WS-Management (WSMan) Remoting in PowerShell
---
# Using WS-Management (WSMan) Remoting in PowerShell

## Enabling PowerShell remoting

To enable PowerShell remoting run the `Enable-PSRemoting` cmdlet in an elevated PowerShell session.
Running `Enable-PSRemoting` configures a remoting endpoint for the specific installation version
that you are running the cmdlet in. For example, when you run `Enable-PSRemoting` while running
PowerShell 7.3, PowerShell creates a remoting endpoint runs PowerShell 7.3. If you run
`Enable-PSRemoting` while running PowerShell 7-preview, PowerShell creates a remoting endpoint that
runs PowerShell 7-preview. You can create multiple remoting endpoints for different versions of that
run side-by-side.

Running `Enable-PSRemoting` creates two endpoints for that version.

- One has a simple name corresponding to the PowerShell major version. that hosts the session. For
  example, **PowerShell.7.3**.
- The other configuration name contains the full version number. For example, **PowerShell.7.3.7**.

You can connect to the latest version of PowerShell 7 host version using the simple name,
**PowerShell.7.3**. You can connect to a specific version of PowerShell using the longer,
version-specific name.

Use the **ConfigurationName** parameter with the `New-PSSession` and `Enter-PSSession` cmdlets to
connect to a named configuration.

## WSMan remoting isn't supported on non-Windows platforms

Since the release of PowerShell 6, support for remoting over WS-Management (WSMan) on non-Windows
platforms has only been available to a limited set of Linux distributions. All versions of those
distributions that supported WSMan are no longer supported by the Linux vendors that created them.

On non-Windows, WSMan relied on the [Open Management Infrastructure (OMI)][01] project, which no
longer supports PowerShell remoting. The OMI WSMan client is dependent on **OpenSSL 1.0**. Most
Linux distributions have moved to **OpenSSL 2.0**, which isn't backward-compatible. At this time,
there is no supported distribution that has the dependencies needed for the OMI WSMan client to
work.

The outdated libraries and supporting code have been removed for non-Windows platforms. WSMan-based
remoting is still supported between Windows systems. Remoting over SSH is supported for all
platforms. For more information, see [PowerShell remoting over SSH][03].

> [!NOTE]
> Users may be able to get WSMan remoting to work using the [PSWSMan][02] module. This module isn't
> supported or maintained by Microsoft.

## Further reading

- [Enable-PSRemoting][04]
- [Enter-PSSession][05]
- [New-PSSession][06]

<!-- link references -->
[01]: https://github.com/Microsoft/omi
[02]: https://www.powershellgallery.com/packages/PSWSMan
[03]: SSH-Remoting-in-PowerShell.md
[04]: xref:Microsoft.PowerShell.Core.Enable-PSRemoting
[05]: xref:Microsoft.PowerShell.Core.Enter-PSSession
[06]: xref:Microsoft.PowerShell.Core.New-PSSession
