---
description: >-
  How to audit PowerShell scripts for compatibility with PowerShell 7 when
  migrating from Windows PowerShell 5.1, including removed cmdlets, .NET
  changes, and cross-version patterns.
ms.date: 04/15/2026
title: Audit scripts for PowerShell 7 compatibility
---

# Audit scripts for PowerShell 7 compatibility

Scripts written for Windows PowerShell 5.1 may use cmdlets, .NET types, or
language patterns that changed or were removed in PowerShell 7. Before you
migrate, audit your scripts to find these breaking patterns and fix them.

This article walks through the most common compatibility problems and shows
how to fix each one. For the full technical reference of differences between
editions, see [Differences between Windows PowerShell 5.1 and
PowerShell 7.x][differences].

## Scan scripts with PSScriptAnalyzer

[PSScriptAnalyzer][pssa] is a static analysis tool that checks PowerShell
code against a set of rules. The **PSUseCompatibleCmdlets** rule flags
cmdlets that don't exist in a target PowerShell version.

### Install PSScriptAnalyzer

```powershell
Install-PSResource PSScriptAnalyzer
```

### Run a basic scan

Point the analyzer at your script directory to get a report of all rule
violations:

```powershell
Invoke-ScriptAnalyzer -Path ./scripts -Recurse |
    Format-Table -AutoSize
```

### Create a settings file for PowerShell 7

To enable the compatibility rule and target a specific PowerShell version,
create a settings file:

```powershell
# PSScriptAnalyzerSettings.psd1
@{
    Rules = @{
        PSUseCompatibleCmdlets = @{
            Enable         = $true
            TargetProfiles = @(
                'win-8_x64_10.0.17763.0_7.0.0_x64_3.1.2_core'
            )
        }
    }
}
```

Then run the analyzer with that settings file:

```powershell
Invoke-ScriptAnalyzer -Path ./scripts -Recurse `
    -Settings ./PSScriptAnalyzerSettings.psd1
```

> [!NOTE]
> The profile string names are documented in the
> [PSUseCompatibleCmdlets rule reference][pssa-profiles]. Use the profile
> that matches your target operating system and PowerShell version.

## Removed cmdlets and replacements

PowerShell 7 removed several cmdlet families that depended on
Windows-only .NET Framework APIs. The following sections list each family
and its replacement.

### WMI v1 cmdlets

The WMI v1 cmdlets are not available in PowerShell 7. Use the
**CimCmdlets** module instead.

| Windows PowerShell 5.1 | PowerShell 7 replacement |
| ----------------------- | ------------------------ |
| `Get-WmiObject` | `Get-CimInstance` |
| `Set-WmiInstance` | `Set-CimInstance` |
| `Remove-WmiObject` | `Remove-CimInstance` |
| `Invoke-WmiMethod` | `Invoke-CimMethod` |
| `Register-WmiEvent` | `Register-CimIndicationEvent` |

**Before (Windows PowerShell 5.1)**:

```powershell
Get-WmiObject -Class Win32_OperatingSystem |
    Select-Object Caption, Version
```

**After (PowerShell 7)**:

```powershell
Get-CimInstance -ClassName Win32_OperatingSystem |
    Select-Object Caption, Version
```

The CIM cmdlets use WS-Man (WinRM) by default instead of DCOM. You can
also create a DCOM session option if your environment requires it:

```powershell
$option = New-CimSessionOption -Protocol Dcom
$session = New-CimSession -ComputerName Server01 `
    -SessionOption $option
Get-CimInstance -CimSession $session `
    -ClassName Win32_Service
```

### EventLog cmdlets

The classic EventLog cmdlets are not available in PowerShell 7. Use the
cmdlets that query Event Tracing for Windows (ETW) logs.

| Windows PowerShell 5.1 | PowerShell 7 replacement |
| ----------------------- | ------------------------ |
| `Get-EventLog` | `Get-WinEvent` |
| `Write-EventLog` | `New-WinEvent` |
| `Clear-EventLog` | `wevtutil cl <LogName>` |
| `Limit-EventLog` | `wevtutil sl <LogName> /ms:<bytes>` |
| `New-EventLog` | `New-WinEvent` or `wevtutil` |

**Before (Windows PowerShell 5.1)**:

```powershell
Get-EventLog -LogName Application -Newest 10
```

**After (PowerShell 7)**:

```powershell
Get-WinEvent -LogName Application -MaxEvents 10
```

### PowerShell Workflow

The `workflow` keyword and all Workflow-related cmdlets were removed in
PowerShell 7. There is no direct replacement. Consider these alternatives
depending on what the workflow did:

- **Parallel execution**: Use `ForEach-Object -Parallel` (PowerShell 7.1
  and later) or `Start-ThreadJob` from the **ThreadJob** module.
- **Checkpointing and suspend-resume**: Use durable orchestration
  frameworks such as Azure Durable Functions.
- **Remote fan-out**: Use `Invoke-Command` with multiple computer names.

```powershell
# Replace a simple parallel workflow
$servers = 'Srv01', 'Srv02', 'Srv03'
$servers | ForEach-Object -Parallel {
    Invoke-Command -ComputerName $_ -ScriptBlock {
        Get-Service -Name wuauserv
    }
} -ThrottleLimit 5
```

### PSScheduledJob cmdlets

The `PSScheduledJob` module (`Register-ScheduledJob`, `Get-ScheduledJob`,
and related cmdlets) is not available in PowerShell 7. Use the
**ScheduledTasks** module to create a task that runs `pwsh.exe`.

For a detailed walkthrough, see
[Migrate scheduled tasks and automation to PowerShell 7][scheduled-tasks].

### Web service proxy

`New-WebServiceProxy` depended on the Windows Communication Foundation
(WCF), which is not available in .NET Core. If the remote service offers
a REST API, use `Invoke-RestMethod` instead:

**Before (Windows PowerShell 5.1)**:

```powershell
$proxy = New-WebServiceProxy -Uri $wsdlUrl
$result = $proxy.GetWeather('Seattle')
```

**After (PowerShell 7)**:

```powershell
$response = Invoke-RestMethod -Uri $restUrl
$response.weather
```

If you must consume a SOAP service, consider the
[System.ServiceModel][servicemodel] compatibility package on NuGet.

### Other removed cmdlets

The following cmdlets were removed because they depend on .NET Framework
APIs or Windows-only features not ported to .NET Core:

| Removed cmdlet | Alternative |
| -------------- | ----------- |
| `Add-Computer` | Use the compatibility layer or `netdom join` |
| `Remove-Computer` | `netdom remove` or the compatibility layer |
| `Checkpoint-Computer` | System Restore via `vssadmin` or manual snapshots |
| `Restore-Computer` | System Restore control panel or `rstrui.exe` |
| `Get-PSSnapin` / `Add-PSSnapin` | Use modules instead (`Import-Module`) |
| `*-Transaction` | No replacement (transactions were rarely used) |
| `Export-Console` | No replacement (console files are obsolete) |

## .NET method and type changes

PowerShell 7 runs on .NET Core (and later .NET 5+), which introduced
breaking changes in some .NET APIs that PowerShell scripts may call
directly.

### String.Split overload resolution

In Windows PowerShell 5.1, calling `Split()` with a string argument
treated each character as a separate delimiter because the only matching
overload accepted `char[]`. In .NET Core, a new `Split(String)` overload
was added, so the string is treated as a single delimiter.

```powershell
# Windows PowerShell 5.1: splits on 'a' and 'b' separately
'ca]b[d'.Split('ab')
# Output: c, ], [, d

# PowerShell 7: splits on the literal string 'ab'
'ca]b[d'.Split('ab')
# Output: ca]b[d  (no match, returns original)
```

**Fix:** Cast to `[char[]]` to get the Windows PowerShell behavior:

```powershell
'ca]b[d'.Split([char[]]'ab')
```

### BinaryFormatter serialization

.NET 8 and later disabled `BinaryFormatter` by default for security
reasons. This change affects:

- `Export-Clixml` and `Import-Clixml` when serializing types that rely on
  `BinaryFormatter` internally
- PowerShell remoting of complex custom objects
- Third-party modules that use binary serialization

> [!IMPORTANT]
> Do not re-enable `BinaryFormatter` in production. Switch to JSON-based
> serialization with `ConvertTo-Json` and `ConvertFrom-Json`, or use
> `Export-Clixml` with types that support the PowerShell Extended Type
> System (ETS) serialization natively.

### String comparison behavior

Starting with .NET 5, culture-aware string comparisons using
`CurrentCulture` or `InvariantCulture` ignore certain control characters
(such as the soft hyphen `\u00AD`). This can cause `-eq`, `-match`, and
`Sort-Object` to produce different results on strings containing invisible
Unicode characters.

**Fix:** Use `[StringComparison]::Ordinal` for byte-exact comparisons:

```powershell
[string]::Compare(
    $a, $b, [StringComparison]::Ordinal
)
```

## Executable and argument changes

### Executable rename

PowerShell 7 uses `pwsh.exe` instead of `powershell.exe`. Update every
reference in:

- Scheduled tasks and Task Scheduler XML
- CI/CD pipeline definitions
- Batch files and shell scripts
- Windows shortcuts and registry entries

Find references in your script files:

```powershell
Get-ChildItem -Path ./scripts -Recurse -Include *.ps1 |
    Select-String -Pattern 'powershell\.exe'
```

### Default positional parameter

The default positional parameter changed between editions:

| Edition | First positional parameter |
| ------- | ------------------------- |
| Windows PowerShell 5.1 | `-Command` |
| PowerShell 7 | `-File` |

This means `pwsh "Get-Date"` tries to find a _file_ named `Get-Date`.
Always specify the parameter explicitly:

```powershell
# Run a command string
pwsh -Command "Get-Date"

# Run a script file
pwsh -File ./deploy.ps1
```

> [!IMPORTANT]
> Scheduled tasks and CI/CD steps that relied on
> `powershell "Some-Command"` without an explicit `-Command` flag break
> when you switch to `pwsh`. Always add `-Command` or `-File` explicitly.

### Native command argument passing

PowerShell 7.3 and later changed how arguments are passed to native
executables. The `$PSNativeCommandArgumentPassing` preference variable
controls the behavior. The new default mode (`Windows` on Windows,
`Standard` on other platforms) preserves quotes and special characters
more faithfully.

If your scripts relied on legacy quoting workarounds, test them after
migration. For details, see [about_Parsing][about-parsing].

## Cross-version compatible patterns

When you need a single script that runs in _both_ Windows PowerShell 5.1
and PowerShell 7, use these patterns.

### Branch on edition

The `$PSVersionTable.PSEdition` property returns `Desktop` for Windows
PowerShell and `Core` for PowerShell 7:

```powershell
if ($PSVersionTable.PSEdition -eq 'Desktop') {
    $os = Get-WmiObject -Class Win32_OperatingSystem
}
else {
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
}
$os | Select-Object Caption, Version
```

### Require a minimum version

Use the `#Requires` statement to prevent a script from running on an
unsupported version:

```powershell
#Requires -Version 7.0
# This script uses ForEach-Object -Parallel
```

### Guard module imports

If a module is only available in one edition, guard the import:

```powershell
if (Get-Module -ListAvailable -Name PSScheduledJob) {
    Import-Module PSScheduledJob
}
else {
    Write-Warning 'PSScheduledJob is not available.'
}
```

## Next steps

- [Module compatibility strategy for PowerShell 7][module-strategy]
- [Encoding changes in PowerShell 7][encoding-changes]
- [Migrating from Windows PowerShell 5.1 to PowerShell 7][migration-guide]
- [Differences between Windows PowerShell 5.1 and PowerShell 7.x][differences]

<!-- link references -->
[about-parsing]: /powershell/module/microsoft.powershell.core/about/about_parsing
[differences]: ../differences-from-windows-powershell.md
[encoding-changes]: ./encoding-changes.md
[migration-guide]: ../Migrating-from-Windows-PowerShell-51-to-PowerShell-7.md
[module-strategy]: ./module-compatibility-strategy.md
[pssa]: /powershell/utility-modules/psscriptanalyzer/overview
[pssa-profiles]: /powershell/utility-modules/psscriptanalyzer/rules/usecompatiblecmdlets
[scheduled-tasks]: ./scheduled-tasks-automation.md
[servicemodel]: https://www.nuget.org/packages/System.ServiceModel.Http
