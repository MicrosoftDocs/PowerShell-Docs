---
description: >-
  A phased migration guide for moving from Windows PowerShell 5.1 to PowerShell 7
  on Windows, covering assessment, installation, script migration, and validation.
ms.date: 04/15/2026
title: Migrating from Windows PowerShell 5.1 to PowerShell 7
---

# Migrating from Windows PowerShell 5.1 to PowerShell 7

PowerShell 7 is the successor to Windows PowerShell 5.1 and runs side-by-side
with it on Windows. It's built on .NET (rather than .NET Framework), bringing
improved performance, new language features like ternary operators and
`ForEach-Object -Parallel`, SSH-based remoting, and cross-platform support.

This guide walks you through a phased migration from Windows PowerShell 5.1
to PowerShell 7 on Windows 10, Windows 11, and Windows Server 2016 and later.
PowerShell 7 also runs on macOS and Linux. For information about the support
lifecycle, see [PowerShell Support Lifecycle][lifecycle].

For a complete reference of breaking changes and behavioral differences, see
[Differences between Windows PowerShell 5.1 and PowerShell 7.x][differences].

## Phase 1: Assess your environment

Before installing PowerShell 7, audit your existing scripts, modules, and
automation to understand what needs to change.

### Audit your scripts

Scan your `.ps1` and `.psm1` files for patterns that are removed or changed in
PowerShell 7. Common breaking patterns include:

- WMI v1 cmdlets (`Get-WmiObject`, `Invoke-WmiMethod`) replaced by CIM cmdlets
- `*-EventLog` cmdlets replaced by `Get-WinEvent` and `New-WinEvent`
- PowerShell Workflow (`workflow` keyword) removed entirely
- `New-WebServiceProxy` removed (no SOAP client in .NET Core)
- Encoding defaults changed from locale-dependent to UTF-8 without BOM

For a complete list of removed cmdlets and automated scanning instructions, see
[Audit scripts for PowerShell 7 compatibility][script-audit].

### Identify module dependencies

Most Windows PowerShell 5.1 modules work in PowerShell 7. Some require the
Windows PowerShell compatibility layer or have known issues. Test your module
inventory before migrating production scripts.

For module testing strategies and known compatibility issues, see
[Module compatibility strategy for PowerShell 7][module-strategy].

### Catalog encoding-sensitive scripts

If your scripts generate files consumed by other tools, or parse files that
assume a specific encoding or byte order mark (BOM), review the encoding changes
in PowerShell 7. The default output encoding changed from locale-dependent
(often Windows-1252 or UTF-16) to UTF-8 without BOM.

For a complete encoding comparison and migration strategies, see
[Encoding changes in PowerShell 7][encoding-changes].

### Inventory your automation

Catalog all scheduled tasks, CI/CD pipelines, Group Policy scripts, and
remoting endpoints that invoke `powershell.exe`. Each of these needs to be
updated to call `pwsh.exe` with the correct argument syntax.

## Phase 2: Install and configure

PowerShell 7 installs to a separate directory and runs a separate executable.
It doesn't replace Windows PowerShell 5.1.

### Installation methods

| Method | Best for | Requires admin |
| ------ | -------- | -------------- |
| [MSI package][install-msi] | Servers, enterprise deployment via SCCM/Intune | Yes |
| [winget][install-winget] | Developer workstations on Windows 10/11 | No |
| [ZIP package][install-zip] | Side-loading, testing, Nano Server, IoT | No |
| [Microsoft Store][install-store] | Casual exploration (has limitations) | No |

> [!NOTE]
> The MSI package can be deployed and updated with management products such as
> [Microsoft Configuration Manager][sccm]. Download the packages from the
> [GitHub Releases page][gh-releases].

For enterprise-scale deployment guidance including SCCM, Intune, air-gapped
networks, and Group Policy, see
[Deploy PowerShell 7 in enterprise environments][enterprise].

### Side-by-side installation paths

PowerShell 7 and Windows PowerShell 5.1 coexist on the same machine:

| Version | Executable | Install path |
| ------- | ---------- | ------------ |
| Windows PowerShell 5.1 | `powershell.exe` | `$Env:windir\System32\WindowsPowerShell\v1.0` |
| PowerShell 7 | `pwsh.exe` | `$Env:ProgramFiles\PowerShell\7` |

The PowerShell 7 directory is added to your `PATH`. Both executables are
available from any terminal. If you're migrating from PowerShell 6.x,
PowerShell 6 is removed and its `PATH` entry is replaced.

### Separate PSModulePath

Windows PowerShell and PowerShell 7 store modules in different locations.
PowerShell 7 combines both sets of paths in `$Env:PSModulePath`, so it can
load modules from either location:

| Install scope | Windows PowerShell 5.1 | PowerShell 7 |
| ------------- | ---------------------- | ------------ |
| Built-in modules | `$Env:windir\system32\WindowsPowerShell\v1.0\Modules` | `$Env:ProgramFiles\PowerShell\7\Modules` |
| AllUsers | `$Env:ProgramFiles\WindowsPowerShell\Modules` | `$Env:ProgramFiles\PowerShell\Modules` |
| CurrentUser | `$HOME\Documents\WindowsPowerShell\Modules` | `$HOME\Documents\PowerShell\Modules` |

PowerShell 7's `$Env:PSModulePath` includes _both_ the PowerShell 7 paths and
the Windows PowerShell paths:

```powershell
$Env:PSModulePath -split (';')
```

```Output
C:\Users\<user>\Documents\PowerShell\Modules
C:\Program Files\PowerShell\Modules
C:\Program Files\PowerShell\7\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules
```

> [!NOTE]
> Additional paths may exist if you changed the **PSModulePath** environment
> variable or installed custom modules or applications. For more information,
> see [about_PSModulePath][about-psmodulepath].

## Phase 3: Migrate profiles and scripts

### Migrate your profiles

PowerShell profiles execute when a session starts and customize your
environment with aliases, functions, variables, and module imports. The profile
location changed in PowerShell 7:

| Scope | Windows PowerShell 5.1 | PowerShell 7 |
| ----- | ---------------------- | ------------ |
| CurrentUser, CurrentHost | `$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` | `$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` |
| CurrentUser, AllHosts | `$HOME\Documents\WindowsPowerShell\profile.ps1` | `$HOME\Documents\PowerShell\profile.ps1` |
| AllUsers, CurrentHost | `$PSHOME\Microsoft.PowerShell_profile.ps1` | `$Env:ProgramFiles\PowerShell\7\Microsoft.PowerShell_profile.ps1` |
| AllUsers, AllHosts | `$PSHOME\profile.ps1` | `$Env:ProgramFiles\PowerShell\7\profile.ps1` |

You can verify the profile paths in any session:

```powershell
$PROFILE | Select-Object *Host* | Format-List
```

For strategies on sharing profiles between editions, handling OneDrive document
redirection, and avoiding common pitfalls, see
[Migrate PowerShell profiles][profile-migration].

### Fix incompatible scripts

Update scripts to replace removed cmdlets and handle behavioral differences.
The most common changes are:

| Windows PowerShell 5.1 pattern | PowerShell 7 replacement |
| ------------------------------ | ------------------------ |
| `Get-WmiObject Win32_Process` | `Get-CimInstance Win32_Process` |
| `Get-EventLog -LogName Application` | `Get-WinEvent -LogName Application` |
| `Invoke-WmiMethod` | `Invoke-CimMethod` |
| `New-WebServiceProxy` | Use `Invoke-RestMethod` or a .NET HTTP client |
| `powershell.exe -Command "..."` | `pwsh.exe -Command "..."` |

For the complete cmdlet replacement map, `.NET` method changes, and automated
scanning instructions, see
[Audit scripts for PowerShell 7 compatibility][script-audit].

### Use the Windows PowerShell compatibility layer

For modules that don't work natively in PowerShell 7, use the
**UseWindowsPowerShell** switch on `Import-Module`. This creates a hidden
remoting session to Windows PowerShell 5.1 and proxies module commands into
your PowerShell 7 session.

```powershell
Import-Module ActiveDirectory -UseWindowsPowerShell
```

For more information, see
[about_Windows_PowerShell_Compatibility][about-compat].

> [!IMPORTANT]
> The compatibility layer has known limitations including performance overhead
> and temp file accumulation in long-running sessions. For details, see
> [Module compatibility strategy for PowerShell 7][module-strategy].

### Handle encoding changes

PowerShell 7 defaults to UTF-8 without BOM for all file output. If your
scripts generate files consumed by tools that expect a different encoding,
you need to specify the encoding explicitly or update the consuming tools.

For a full comparison of encoding defaults and migration strategies, see
[Encoding changes in PowerShell 7][encoding-changes].

## Phase 4: Migrate infrastructure

### Update remoting endpoints

Windows PowerShell 5.1 and PowerShell 7 use separate WinRM endpoints. By
default, PowerShell 7 connects to the existing Windows PowerShell 5.1 endpoint
named `Microsoft.PowerShell`. To create a PowerShell 7 endpoint, run:

```powershell
Enable-PSRemoting
```

To connect to the PowerShell 7 endpoint from a remote machine:

```powershell
Enter-PSSession -ComputerName Server01 -ConfigurationName PowerShell.7
```

For more information about WS-Management remoting, see
[WS-Management Remoting in PowerShell][wsman-remoting]. For information about
remote requirements, see [About Remote Requirements][about-remote-req].

#### SSH-based remoting

SSH remoting was added in PowerShell 6.x and is the recommended approach for
cross-platform scenarios. It creates a PowerShell host process on the target
as an SSH subsystem.

```powershell
Enter-PSSession -HostName Server01 -UserName admin
```

> [!NOTE]
> The [Microsoft.PowerShell.RemotingTools][remoting-tools] module from the
> PowerShell Gallery includes the `Enable-SSH` cmdlet to help configure
> SSH-based remoting.

For details and examples, see
[PowerShell remoting over SSH][ssh-remoting].

### Update scheduled tasks and automation

Every scheduled task, CI/CD pipeline, or script that calls `powershell.exe`
must be updated to call `pwsh.exe`. The first positional parameter also
changed from `-Command` to `-File` in PowerShell 7. If your scheduled tasks
use positional arguments, add `-Command` explicitly.

For step-by-step task migration instructions and audit scripts, see
[Migrate scheduled tasks and automation to PowerShell 7][scheduled-tasks].

### Configure Group Policy

PowerShell 7 includes its own Group Policy templates, separate from Windows
PowerShell 5.1. Supported settings include:

- Console session configuration
- Module Logging
- Script Block Logging
- Script Execution (execution policy)
- Transcription
- Default source path for `Update-Help`

PowerShell 7 ships `.admx` and `.adml` templates in `$PSHOME`. Install them
with the included script:

```powershell
& "$PSHOME\InstallPSCorePolicyDefinitions.ps1"
```

For more information, see [about_Group_Policy_Settings][about-gpo].

### Separate event logs

Windows PowerShell and PowerShell 7 log events to separate event logs. Update
any monitoring or SIEM rules that reference PowerShell event logs:

```powershell
Get-WinEvent -ListLog *PowerShell*
```

For more information, see [about_Logging_Windows][about-logging].

## Phase 5: Validate and roll back

### Test your migration

Run your scripts and modules in PowerShell 7 and compare behavior against
Windows PowerShell 5.1. Key areas to validate:

- Module loading and cmdlet behavior
- File output encoding
- Remoting endpoint connectivity
- Scheduled task execution
- Error handling and `$ErrorActionPreference` behavior

For a validation checklist, cross-edition test matrix, and rollback procedures,
see [Test and validate your PowerShell 7 migration][testing-rollback].

### Plan for rollback

PowerShell 7 doesn't replace Windows PowerShell 5.1. If you encounter
issues, you can revert automation pointers from `pwsh.exe` back to
`powershell.exe` without uninstalling PowerShell 7. Plan for a
parallel-run period where both editions handle production workloads.

### Editing experience

[Visual Studio Code][vscode] with the [PowerShell Extension][ps-ext] is the
recommended editor for PowerShell 7. The Windows PowerShell ISE only supports
Windows PowerShell and is no longer being updated with new features.

The PowerShell extension includes:

- ISE compatibility mode
- PSReadLine in the Integrated Console with syntax highlighting and multi-line
  editing
- CodeLens integration
- Improved path autocompletion

To switch to an ISE-style layout, press
<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>, type `PowerShell`, and select
**PowerShell: Enable ISE Mode**.

## Next steps

- [Audit scripts for PowerShell 7 compatibility][script-audit]
- [Module compatibility strategy for PowerShell 7][module-strategy]
- [Encoding changes in PowerShell 7][encoding-changes]
- [Migrate PowerShell profiles][profile-migration]
- [Deploy PowerShell 7 in enterprise environments][enterprise]
- [Migrate scheduled tasks and automation][scheduled-tasks]
- [Test and validate your migration][testing-rollback]
- [Differences between Windows PowerShell 5.1 and PowerShell 7.x][differences]

<!-- link references -->
[about-compat]: /powershell/module/Microsoft.PowerShell.Core/About/about_windows_powershell_compatibility
[about-gpo]: /powershell/module/microsoft.powershell.core/about/about_group_policy_settings
[about-logging]: /powershell/module/microsoft.powershell.core/about/about_logging_windows
[about-psmodulepath]: /powershell/module/microsoft.powershell.core/about/about_psmodulepath
[about-remote-req]: /powershell/module/microsoft.powershell.core/about/about_remote_requirements
[differences]: ./differences-from-windows-powershell.md
[encoding-changes]: ./migration/encoding-changes.md
[enterprise]: ./migration/enterprise-deployment.md
[gh-releases]: https://github.com/PowerShell/PowerShell/releases
[install-msi]: ../install/installing-powershell-on-windows.md#msi
[install-store]: ../install/installing-powershell-on-windows.md#msix
[install-winget]: ../install/installing-powershell-on-windows.md#winget
[install-zip]: ../install/installing-powershell-on-windows.md#zip
[lifecycle]: ../install/powershell-support-lifecycle.md
[module-strategy]: ./migration/module-compatibility-strategy.md
[profile-migration]: ./migration/profile-migration.md
[ps-ext]: https://code.visualstudio.com/docs/languages/powershell
[remoting-tools]: https://www.powershellgallery.com/packages/Microsoft.PowerShell.RemotingTools
[sccm]: /configmgr/apps/
[scheduled-tasks]: ./migration/scheduled-tasks-automation.md
[script-audit]: ./migration/script-compatibility-audit.md
[ssh-remoting]: ../security/remoting/ssh-remoting-in-powershell.md
[testing-rollback]: ./migration/testing-and-rollback.md
[vscode]: https://code.visualstudio.com/
[wsman-remoting]: ../security/remoting/wsman-remoting-in-powershell.md
