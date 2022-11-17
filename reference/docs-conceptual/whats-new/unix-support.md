---
description: This article summarizes the differences between PowerShell on Windows and PowerShell on non-Windows platforms.
ms.date: 11/01/2022
title: PowerShell differences on non-Windows platforms
---
# PowerShell differences on non-Windows platforms

PowerShell strives to provide feature parity across all supported platforms. But, due to differences
in .NET Core and platform-specific differences, some features behave differently or aren't
available. Additional changes have been made to improve interoperability of PowerShell on
non-Windows platforms.

## .NET Framework vs .NET Core

PowerShell on Linux and macOS uses .NET Core, which is a subset of the full .NET Framework on
Microsoft Windows. As a result, scripts that run on Windows may not run on non-Windows platforms
because of the differences in the frameworks.

For more information about changes in .NET Core, see
[Breaking changes for migration from .NET Framework to .NET Core][01].

## General Unix interoperability changes

- Added support for native command globbing on Unix platforms. This means you can
  use wildcards with native commands like `ls *.txt`.
- The `more` functionality respects the Linux `$PAGER` and defaults to `less`.
- Trailing backslash is automatically escaped when dealing with native command arguments.
- Fixed ConsoleHost to honor `NoEcho` on Unix platforms.
- don't add `PATHEXT` environment variable on Unix
- A `powershell` man-page is included in the package

## Execution policy

The `-ExecutionPolicy` parameter is ignored when running PowerShell on non-Windows platforms.
`Get-ExecutionPolicy` returns **Unrestricted** on Linux and macOS. `Set-ExecutionPolicy` does
nothing on Linux and macOS.

## Case-sensitivity in PowerShell

Historically, PowerShell has been uniformly case-insensitive, with few exceptions. On UNIX-like
operating systems, the file system is predominantly case-sensitive and PowerShell adheres to the
standard of the file system.

- When specifying a file in PowerShell, the correct case must be used.
- If a script tries to load a module and the module name isn't cased correctly, then the module load
  fails. This may cause a problem with existing scripts if the name by which the module is
  referenced doesn't match the proper case of the actual filename.
- While names in the filesystem are case-sensitive, tab-completion of filenames isn't
  case-sensitive. Tab-completion cycles through the list of names using case-insensitive matching.
- `Get-Help` supports case-insensitive pattern matching on Unix platforms.
- `Import-Module` is case insensitive when it's using a filename to determine the module's name.

## Filesystem support for Linux and macOS

- Paths given to cmdlets are now slash-agnostic (both / and \ work as directory separator)
- XDG Base Directory Specification is now respected and used by default:
  - The Linux/macOS profile path is located at `~/.config/powershell/profile.ps1`
  - The history save path is located at `~/.local/share/powershell/PSReadline/ConsoleHost_history.txt`
  - The user module path is located at `~/.local/share/powershell/Modules`
- Support for file and folder names containing the colon character on Unix.
- Support for script names or full paths that have commas.
- Detect when `-LiteralPath` is used to suppress wildcard expansion for navigation cmdlets.
- Updated `Get-ChildItem` to work more like the *nix `ls -R` and the Windows `DIR /S` native
  commands. `Get-ChildItem` now returns the symbolic links encountered during a recursive search and
  doesn't search the directories that those links target.

## .PS1 File Extensions

PowerShell scripts must end in `.ps1` for the interpreter to understand how to load and run them in
the current process. Running scripts in the current process is the expected usual behavior for
PowerShell. The `#!` magic number may be added to a script that doesn't have a `.ps1` extension, but
this causes the script to be run in a new PowerShell instance preventing the script from working
properly when interchanging objects. This may be the desirable behavior when executing a PowerShell
script from `bash` or another shell.

## Convenience aliases removed

On Windows, PowerShell provides a set of aliases that map to Linux command names for user
convenience. On Linux and macOS, the "convenience aliases" for the basic commands `ls`, `cp`, `mv`,
`rm`, `cat`, `man`, `mount`, `ps` have been removed to allow the native executable to run without
specifying a path.

## Logging

On macOS, PowerShell uses the native `os_log` APIs to log to Apple's [unified logging system][08].
On Linux, PowerShell uses [Syslog][09], a ubiquitous logging solution.

## Job Control

There is no Unix-style job-control support in PowerShell on Linux or macOS. The `fg` and `bg`
commands aren't available. You can use [PowerShell jobs][02] that do work across all platforms.

Putting `&` at the end of a pipeline causes the pipeline to be run as a PowerShell job. When a
pipeline is backgrounded, a job object is returned. Once the pipeline is running as a job, all
`*-Job` cmdlets can be used to manage the job. Variables (ignoring process-specific variables) used
in the pipeline are automatically copied to the job so `Copy-Item $foo $bar &` just works. The job
is also run in the current directory instead of the user's home directory.

## Remoting Support

PowerShell Remoting (PSRP) using WinRM on Unix platforms requires NTLM/Negotiate or Basic Auth over
HTTPS. PSRP on macOS only supports Basic Auth over HTTPS. Kerberos-based authentication isn't
supported.

PowerShell supports PowerShell Remoting (PSRP) over SSH on all platforms (Windows, macOS, and
Linux). For more information, see [SSH remoting in PowerShell][04].

## Just-Enough-Administration (JEA) Support

The ability to create constrained administration (JEA) remoting endpoints isn't available in
PowerShell on Linux or macOS.

## `sudo`, `exec`, and PowerShell

Because PowerShell runs most commands in memory (like Python or Ruby), you can't use sudo directly
with PowerShell built-ins. You can run `pwsh` from sudo. If it's necessary to run a PowerShell
cmdlet from within PowerShell with sudo, for example, `sudo Set-Date 8/18/2016`, then you would do
`sudo pwsh Set-Date 8/18/2016`.

## Missing Cmdlets

A large number of the commands (cmdlets) normally available in PowerShell aren't available on Linux
or macOS. In many cases, these commands make no sense on these platforms (e.g. Windows-specific
features like the registry). Other commands like the service control commands are present, but not
functional. Future releases may correct these problems by fixing the broken cmdlets and adding new
ones over time.

For a comprehensive list of modules and cmdlets and the platforms they support, see
[Release history of modules and cmdlets][05].

## Modules no longer shipped with PowerShell

For various compatibility reasons, the following modules are no longer included in PowerShell.

- ISE
- Microsoft.PowerShell.LocalAccounts
- Microsoft.PowerShell.ODataUtils
- Microsoft.PowerShell.Operation.Validation
- PSScheduledJob
- PSWorkflow
- PSWorkflowUtility

The following Windows-specific modules aren't included in PowerShell for Linux or macOS.

- CimCmdlets
- Microsoft.PowerShell.Diagnostics
- Microsoft.WSMan.Management
- PSDiagnostics

## Cmdlets not available on non-Windows platforms

For non-Windows platforms, PowerShell includes the following modules:

- Microsoft.PowerShell.Archive
- Microsoft.PowerShell.Core
- Microsoft.PowerShell.Host
- Microsoft.PowerShell.Management
- Microsoft.PowerShell.Security
- Microsoft.PowerShell.Utility
- PackageManagement
- PowerShellGet
- PSDesiredStateConfiguration
- PSReadLine
- ThreadJob

However, some cmdlets have been removed from PowerShell, and others aren't available or may work
differently on non-Windows platforms. For a comprehensive list of cmdlets removed from PowerShell,
see [Cmdlets removed from PowerShell][06].

### Microsoft.PowerShell.Core

The **ShowWindow** parameter of `Get-Help` isn't available for non-Windows platforms.

### Microsoft.PowerShell.Security cmdlets

The following cmdlets aren't available on Linux or macOS:

- `Get-Acl`
- `Set-Acl`
- `Get-AuthenticodeSignature`
- `Set-AuthenticodeSignature`
- `New-FileCatalog`
- `Test-FileCatalog`

These cmdlets are only available beginning in PowerShell 7.1.

- `Get-CmsMessage`
- `Protect-CmsMessage`
- `Unprotect-CmsMessage`

### Microsoft.PowerShell.Management cmdlets

The following cmdlets aren't available on Linux and macOS:

- `Clear-RecycleBin`
- `Get-HotFix`

The following cmdlets are available with limitations:

`Get-Clipboard` - available on Linux but not supported on macOS
`Set-Clipboard` - available in PowerShell 7.0+
`Restart-Computer` - available for Linux and macOS in PowerShell 7.1+
`Stop-Computer` - available for Linux and macOS in PowerShell 7.1+

### Microsoft.PowerShell.Utility cmdlets

The following cmdlets aren't available on Linux and macOS:

- `Convert-String`
- `ConvertFrom-String`
- `Out-GridView`
- `Out-Printer`
- `Show-Command`

## Aliases not available on Linux or macOS

The following table lists the aliases available for Windows that aren't available on non-Windows
platforms. These aliases aren't available because the target cmdlet isn't available or the alias
conflicts with a native command on those platforms.

|   Alias   |         Cmdlet         |
| --------- | ---------------------- |
| `ac`      | `Add-Content`          |
| `cat`     | `Get-Content`          |
| `clear`   | `Clear-Host`           |
| `cnsn`    | `Connect-PSSession`    |
| `compare` | `Compare-Object`       |
| `cp`      | `Copy-Item`            |
| `cpp`     | `Copy-ItemProperty`    |
| `diff`    | `Compare-Object`       |
| `dnsn`    | `Disconnect-PSSession` |
| `gsv`     | `Get-Service`          |
| `kill`    | `Stop-Process`         |
| `ls`      | `Get-ChildItem`        |
| `man`     | `help`                 |
| `mount`   | `New-PSDrive`          |
| `mv`      | `Move-Item`            |
| `ogv`     | `Out-GridView`         |
| `ps`      | `Get-Process`          |
| `rm`      | `Remove-Item`          |
| `rmdir`   | `Remove-Item`          |
| `sasv`    | `Start-Service`        |
| `shcm`    | `Show-Command`         |
| `sleep`   | `Start-Sleep`          |
| `sort`    | `Sort-Object`          |
| `spsv`    | `Stop-Service`         |
| `start`   | `Start-Process`        |
| `tee`     | `Tee-Object`           |
| `write`   | `Write-Output`         |

## PowerShell Desired State Configuration (DSC)

Many cmdlets were removed from the PSDesiredStateConfiguration module beginning in PowerShell 6.0.
Support for DSC on non-Windows platforms is limited and mostly experimental. The
`Invoke-DscResource` cmdlet was restored as an experimental feature in PowerShell 7.0.

DSC isn't supported on macOS.

For more information about using DSC on Linux, see [Get started with DSC for Linux][03].

Beginning with PowerShell 7.2, the **PSDesiredStateConfiguration** module has been removed from
PowerShell and is published to the PowerShell Gallery. For more information, see the
[announcement][07] in the PowerShell Team blog.

<!-- link references -->
[01]: /dotnet/core/compatibility/fx-core
[02]: /powershell/module/microsoft.powershell.core/about/about_jobs
[03]: /powershell/scripting/dsc/getting-started/lnxgettingstarted
[04]: /powershell/scripting/learn/remoting/SSH-Remoting-in-PowerShell-Core
[05]: cmdlet-versions.md
[06]: differences-from-windows-powershell.md#cmdlets-removed-from-powershell
[07]: https://devblogs.microsoft.com/powershell/announcing-psdesiredstateconfiguration-on-powershell-gallery/
[08]: https://developer.apple.com/documentation/os/logging
[09]: https://en.wikipedia.org/wiki/Syslog
