---
description: Remoting in PowerShell using WSMan
ms.date: 12/09/2025
title: Using WS-Management (WSMan) Remoting in PowerShell
---
# Using WS-Management (WSMan) Remoting in PowerShell

## Enabling PowerShell remoting

To enable PowerShell remoting, run the `Enable-PSRemoting` cmdlet in an elevated PowerShell session.
Running `Enable-PSRemoting` configures a remoting endpoint for the specific installation version
that you're running the cmdlet in. For example, when you run `Enable-PSRemoting` while running
PowerShell 7.4, PowerShell creates a remoting endpoint runs PowerShell 7.4. If you run
`Enable-PSRemoting` while running PowerShell 7-preview, PowerShell creates a remoting endpoint that
runs PowerShell 7-preview. You can create multiple remoting endpoints for different versions of that
run side-by-side.

Running `Enable-PSRemoting` creates two endpoints for that version.

- One has a simple name corresponding to the PowerShell major version. that hosts the session. For
  example, **PowerShell.7.4**.
- The other configuration name contains the full version number. For example, **PowerShell.7.4.7**.

You can connect to the latest version of PowerShell 7 host version using the simple name,
**PowerShell.7.4**. You can connect to a specific version of PowerShell using the longer,
version-specific name.

Use the **ConfigurationName** parameter with the `New-PSSession` and `Enter-PSSession` cmdlets to
connect to a named configuration.

## Remoting to older versions of Windows

The following prerequisites must be met to enable PowerShell remoting over WSMan on older versions
of Windows.

- Install the Windows Management Framework (WMF) 5.1 (as necessary). For more information about WMF,
  see [WMF Overview][01].
- Install the [Universal C Runtime][03] on Windows versions predating Windows 10. It's available via
  direct download or Windows Update. Fully patched systems already have this package installed.

## WSMan remoting isn't supported on non-Windows platforms

Since the release of PowerShell 6, support for remoting over WS-Management (WSMan) on non-Windows
platforms is only available to a limited set of Linux distributions. On non-Windows, WSMan relied on
the [Open Management Infrastructure (OMI)][02] project. The OMI WSMan client depends on **OpenSSL
1.0**. All Linux distributions use **OpenSSL 2.0**, which isn't backward-compatible. There are no
supported distributions that have the dependencies needed for the OMI WSMan client to work.

WSMan-based remoting is still supported between Windows systems. Remoting over SSH is supported for
all platforms. For more information, see [PowerShell remoting over SSH][05].

## Further reading

- [Enable-PSRemoting][06]
- [Enter-PSSession][07]
- [New-PSSession][08]

<!-- link references -->
[01]: ../../windows-powershell/wmf-overview.md
[02]: https://github.com/Microsoft/omi
[03]: https://www.microsoft.com/download/details.aspx?id=50410
[04]: https://www.powershellgallery.com/packages/PSWSMan
[05]: SSH-Remoting-in-PowerShell.md
[06]: xref:Microsoft.PowerShell.Core.Enable-PSRemoting
[07]: xref:Microsoft.PowerShell.Core.Enter-PSSession
[08]: xref:Microsoft.PowerShell.Core.New-PSSession
