---
description: >-
  Migrate scheduled tasks, PSScheduledJob scripts, and automation from
  Windows PowerShell 5.1 to PowerShell 7.
ms.date: 04/15/2026
title: Migrate scheduled tasks and automation to PowerShell 7
---

# Migrate scheduled tasks and automation to PowerShell 7

Many organizations run PowerShell scripts through Windows Task Scheduler,
`PSScheduledJob`, or automation platforms. This article covers how to update
these configurations for PowerShell 7.

## PSScheduledJob removal

The `PSScheduledJob` module (`Register-ScheduledJob`, `Get-ScheduledJob`,
`Set-ScheduledJob`, and related cmdlets) was removed in PowerShell 7. This
module depended on PowerShell Workflow, which isn't available in .NET Core.

### Replacement: ScheduledTasks module

Use the `ScheduledTasks` module with `pwsh.exe` as the executable. The
`ScheduledTasks` module works in both Windows PowerShell 5.1 and
PowerShell 7.

**Before (Windows PowerShell 5.1)**:

```powershell
Register-ScheduledJob -Name 'DailyCleanup' `
    -ScriptBlock { Remove-Item "$env:TEMP\*.tmp" -Force } `
    -Trigger (New-JobTrigger -Daily -At '3:00 AM')
```

**After (PowerShell 7)**:

```powershell
$action = New-ScheduledTaskAction `
    -Execute "$Env:ProgramFiles\PowerShell\7\pwsh.exe" `
    -Argument '-NoProfile -File "C:\Scripts\DailyCleanup.ps1"'

$trigger = New-ScheduledTaskTrigger -Daily -At '3:00 AM'

Register-ScheduledTask -TaskName 'DailyCleanup' `
    -Action $action `
    -Trigger $trigger `
    -RunLevel Highest `
    -User 'SYSTEM'
```

> [!IMPORTANT]
> Always use the full path to `pwsh.exe` in scheduled task actions. Relying
> on `PATH` resolution can break when the system `PATH` changes during
> updates.

## Task Scheduler with PowerShell 7

### Correct executable path

Use the full path to the PowerShell 7 executable:

```
C:\Program Files\PowerShell\7\pwsh.exe
```

### Argument format

In PowerShell 7, the first positional parameter is `-File` (not `-Command`
as in Windows PowerShell 5.1). This affects how you specify arguments in
Task Scheduler:

| Scenario | Argument string |
| -------- | --------------- |
| Run a script file | `-NoProfile -File "C:\Scripts\task.ps1"` |
| Run an inline command | `-NoProfile -Command "Get-Process \| Export-Csv C:\logs\procs.csv"` |
| Run a script with parameters | `-NoProfile -File "C:\Scripts\task.ps1" -Param1 Value1` |

> [!NOTE]
> If your existing tasks use `powershell.exe "Get-Date"` (relying on the
> default `-Command` positional parameter), you must add `-Command`
> explicitly when switching to `pwsh.exe`. Without it, PowerShell 7 treats
> the argument as a file path.

### Exit code handling

PowerShell 7 passes the script's exit code to Task Scheduler. Use
`exit $code` in your scripts to return meaningful exit codes. Task Scheduler
shows the **Last Run Result** as the process exit code.

## Audit existing scheduled tasks

Use the following script to find all scheduled tasks that reference
`powershell.exe`:

```powershell
Get-ScheduledTask | ForEach-Object {
    $actions = $_.Actions | Where-Object {
        $_.Execute -match 'powershell\.exe'
    }
    if ($actions) {
        [PSCustomObject]@{
            TaskName = $_.TaskName
            TaskPath = $_.TaskPath
            Execute  = ($actions.Execute -join '; ')
            Arguments = ($actions.Arguments -join '; ')
            State    = $_.State
        }
    }
} | Format-Table -AutoSize
```

This lists every task that needs to be updated to use `pwsh.exe`.

## Update tasks in bulk

After auditing, update tasks programmatically. The following script creates
a backup of each task's XML definition, then updates the executable path:

```powershell
$backupDir = 'C:\TaskBackups'
New-Item -Path $backupDir -ItemType Directory -Force

$tasks = Get-ScheduledTask | Where-Object {
    $_.Actions.Execute -match 'powershell\.exe'
}

foreach ($task in $tasks) {
    # Export backup
    $exportPath = Join-Path $backupDir "$($task.TaskName).xml"
    Export-ScheduledTask -TaskName $task.TaskName `
        -TaskPath $task.TaskPath |
        Set-Content -Path $exportPath

    # Update each action
    foreach ($action in $task.Actions) {
        if ($action.Execute -match 'powershell\.exe') {
            $action.Execute = `
                "$Env:ProgramFiles\PowerShell\7\pwsh.exe"
            # Add -Command if arguments don't start with
            # a flag
            if ($action.Arguments -and
                $action.Arguments -notmatch '^\s*-') {
                $action.Arguments =
                    "-Command $($action.Arguments)"
            }
        }
    }

    Set-ScheduledTask -InputObject $task
    Write-Host "Updated: $($task.TaskPath)$($task.TaskName)"
}
```

> [!IMPORTANT]
> Test in a non-production environment before running bulk updates. Always
> back up task definitions first so you can roll back if scripts behave
> differently under PowerShell 7.

## Rollback to Windows PowerShell

If a task fails under PowerShell 7, restore it from the XML backup:

```powershell
Register-ScheduledTask -TaskName 'DailyCleanup' `
    -Xml (Get-Content 'C:\TaskBackups\DailyCleanup.xml' -Raw) `
    -Force
```

## Azure Automation

Azure Automation supports PowerShell 7 runbooks. When creating or updating
a runbook:

1. Set the **Runtime version** to **7.2** or later in the runbook properties
1. Update any `Get-WmiObject` calls to `Get-CimInstance`
1. Test the runbook in the Azure portal before publishing

> [!NOTE]
> Hybrid Runbook Workers use the locally installed PowerShell version. If
> you need PowerShell 7 on hybrid workers, install it on the worker machines
> and update the worker configuration to use `pwsh.exe`.

## Other automation platforms

### System Center Orchestrator

Orchestrator runbook activities that call `powershell.exe` can be updated
to call `pwsh.exe`. Update the program path in the **Run .NET Script** or
**Run Program** activity properties.

### Jenkins

In Jenkins pipeline scripts, specify the PowerShell 7 executable:

```groovy
bat '"C:\\Program Files\\PowerShell\\7\\pwsh.exe" -NoProfile -File script.ps1'
```

Or use the PowerShell plugin configured to use `pwsh.exe` as the
executable.

## Next steps

- [Migrating from Windows PowerShell 5.1 to PowerShell 7][migration-guide]
- [Deploy PowerShell 7 in enterprise environments][enterprise]
- [Test and validate your PowerShell 7 migration][testing-rollback]
- [Audit scripts for PowerShell 7 compatibility][script-audit]

<!-- link references -->
[enterprise]: ./enterprise-deployment.md
[migration-guide]: ../Migrating-from-Windows-PowerShell-51-to-PowerShell-7.md
[script-audit]: ./script-compatibility-audit.md
[testing-rollback]: ./testing-and-rollback.md
