---
description: >-
  Validate your PowerShell 7 migration with cross-edition testing, a
  verification checklist, and rollback procedures.
ms.date: 04/15/2026
title: Test and validate your PowerShell 7 migration
---

# Test and validate your PowerShell 7 migration

After migrating scripts, modules, and automation from Windows PowerShell 5.1
to PowerShell 7, validate that everything works correctly before
decommissioning your Windows PowerShell dependencies. This article provides a
testing strategy, validation checklist, and rollback procedures.

## Testing strategy

### Run scripts in both editions

PowerShell 7 runs side-by-side with Windows PowerShell 5.1. Use this to
compare behavior by running the same script in both editions:

```powershell
# Run in Windows PowerShell 5.1
powershell.exe -NoProfile -File .\script.ps1 > output-51.txt

# Run in PowerShell 7
pwsh.exe -NoProfile -File .\script.ps1 > output-7.txt

# Compare output
Compare-Object (Get-Content output-51.txt) (Get-Content output-7.txt)
```

### Pester test compatibility

If your scripts have [Pester][pester] tests, run them in PowerShell 7.
Pester 5.x ships with PowerShell 7 and has significant changes from
Pester 3.x (which shipped with Windows PowerShell 5.1):

| Feature | Pester 3.x (WinPS 5.1) | Pester 5.x (PS 7) |
| ------- | ----------------------- | ------------------ |
| Test structure | `Describe` / `It` | `Describe` / `It` (same syntax) |
| Assertions | `Should Be`, `Should Throw` | `Should -Be`, `Should -Throw` |
| Mocking | `Mock` (global scope) | `Mock` (scoped to `Describe` / `Context`) |
| Test discovery | Implicit | Explicit with `Run` configuration |
| Output | Text-based | `TestResult` object |

If your tests use Pester 3.x syntax, the most common update is changing
`Should Be` to `Should -Be` (with a hyphen before the operator).

### Cross-edition test matrix

For critical scripts, test across a matrix of scenarios:

| Scenario | What to verify |
| -------- | -------------- |
| Module loading | All modules import without errors |
| File output | Encoding matches expectations (see [Encoding changes][encoding]) |
| Remoting | Sessions connect to the correct endpoint |
| Scheduled tasks | Tasks run and return expected exit codes |
| Error handling | `try`/`catch` blocks catch the same exceptions |
| Native commands | Command output parses correctly |
| COM objects | Excel, Word, or other COM automation still works |

## Validation checklist

Use this checklist after completing your migration. Run each check in
PowerShell 7 and verify the result.

### Module loading

```powershell
# List modules that fail to import
Get-Module -ListAvailable | ForEach-Object {
    try {
        Import-Module $_.Name -ErrorAction Stop -Force
    }
    catch {
        [PSCustomObject]@{
            Module = $_.Name
            Error  = $_.Exception.Message
        }
    }
} | Where-Object { $_.Error }
```

### Encoding verification

```powershell
# Generate a test file and check its encoding
'Test output' | Out-File test-encoding.txt
$bytes = [System.IO.File]::ReadAllBytes(
    (Resolve-Path test-encoding.txt)
)
if ($bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB) {
    Write-Host 'UTF-8 with BOM'
}
elseif ($bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE) {
    Write-Host 'UTF-16 LE'
}
else {
    Write-Host 'UTF-8 without BOM (PowerShell 7 default)'
}
Remove-Item test-encoding.txt
```

### Remoting endpoints

```powershell
# Verify PowerShell 7 endpoint exists
Get-PSSessionConfiguration | Where-Object {
    $_.Name -match 'PowerShell\.\d'
} | Select-Object Name, PSVersion
```

### Scheduled task status

```powershell
# Check for tasks still using powershell.exe
Get-ScheduledTask | Where-Object {
    $_.Actions.Execute -match 'powershell\.exe'
} | Select-Object TaskName, TaskPath, State
```

### Profile loading

```powershell
# Verify profile loads without errors
pwsh -NoProfile -Command {
    try {
        . $PROFILE -ErrorAction Stop
        Write-Host 'Profile loaded successfully'
    }
    catch {
        Write-Warning "Profile error: $_"
    }
}
```

## Rollback procedures

PowerShell 7 doesn't replace Windows PowerShell 5.1. Rolling back means
reverting your automation pointers, not uninstalling PowerShell 7.

### Roll back scheduled tasks

If you backed up task definitions before migrating (see
[Migrate scheduled tasks][scheduled-tasks]), restore from XML:

```powershell
Get-ChildItem 'C:\TaskBackups\*.xml' | ForEach-Object {
    $xml = Get-Content $_.FullName -Raw
    $taskName = $_.BaseName
    Register-ScheduledTask -TaskName $taskName -Xml $xml -Force
    Write-Host "Restored: $taskName"
}
```

### Roll back remoting endpoints

If you configured PowerShell 7 as the default SSH shell, revert the
registry setting:

```powershell
Set-ItemProperty -Path 'HKLM:\SOFTWARE\OpenSSH' `
    -Name DefaultShell `
    -Value "$Env:windir\System32\WindowsPowerShell\v1.0\powershell.exe"
```

For WinRM, remote sessions default to the Windows PowerShell endpoint
unless the caller specifies `-ConfigurationName PowerShell.7`, so no
rollback is needed for WinRM.

### Roll back profiles

If you symlinked profiles, remove the symbolic link and create a
PowerShell 7-specific profile:

```powershell
$ps7Profile = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
if ((Get-Item $ps7Profile).LinkType -eq 'SymbolicLink') {
    Remove-Item $ps7Profile
    # Optionally create a minimal PS7 profile
    Set-Content -Path $ps7Profile -Value '# PowerShell 7 profile'
}
```

## Coexistence timeline

Plan for a period where both editions run production workloads. A
recommended approach:

| Phase | Duration | What to do |
| ----- | -------- | ---------- |
| Parallel testing | 2 weeks | Run scripts in both editions, compare results |
| Gradual migration | 4 weeks | Move non-critical tasks to PowerShell 7 first |
| Monitoring | 2 weeks | Watch for errors in migrated tasks |
| Full cutover | 1 day | Move remaining tasks, update default shells |
| Post-cutover | Ongoing | Keep Windows PowerShell available as a fallback |

### Cutover criteria

Before fully cutting over to PowerShell 7, verify:

- All scheduled tasks run successfully for at least two scheduled cycles
- Remoting endpoints respond correctly
- No encoding-related errors in log files
- Module imports succeed without falling back to the compatibility layer
- CI/CD pipelines pass with `pwsh` tasks
- Monitoring and alerting rules updated for PowerShell 7 event logs

### Keeping Windows PowerShell available

Windows PowerShell 5.1 ships with Windows and can't be uninstalled. Even
after cutting over to PowerShell 7, keep it available as a fallback for
scripts that can't be migrated and modules that require the .NET Framework.

## Next steps

- [Migrating from Windows PowerShell 5.1 to PowerShell 7][migration-guide]
- [Audit scripts for PowerShell 7 compatibility][script-audit]
- [Module compatibility strategy for PowerShell 7][module-strategy]
- [Encoding changes in PowerShell 7][encoding]
- [Migrate scheduled tasks and automation][scheduled-tasks]

<!-- link references -->
[encoding]: ./encoding-changes.md
[migration-guide]: ../Migrating-from-Windows-PowerShell-51-to-PowerShell-7.md
[module-strategy]: ./module-compatibility-strategy.md
[pester]: https://pester.dev/
[scheduled-tasks]: ./scheduled-tasks-automation.md
[script-audit]: ./script-compatibility-audit.md
