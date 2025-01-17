---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/08/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/start-sleep?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Start-Sleep
---

# Start-Sleep

## SYNOPSIS
Suspends the activity in a script or session for the specified period of time.

## SYNTAX

### Seconds (Default)

```
Start-Sleep [-Seconds] <Double> [<CommonParameters>]
```

### Milliseconds

```
Start-Sleep -Milliseconds <Int32> [<CommonParameters>]
```

### FromTimeSpan

```
Start-Sleep -Duration <TimeSpan> [<CommonParameters>]
```

## DESCRIPTION

The `Start-Sleep` cmdlet suspends the activity in a script or session for the specified period of
time. You can use it for many tasks, such as waiting for an operation to complete or pausing before
repeating an operation.

## EXAMPLES

### Example 1: Pause execution for 1.5 seconds

In this example, the execution of commands pauses for one and one-half seconds.

```powershell
Start-Sleep -Seconds 1.5
```

### Example 2: Pause execution at the command line

This example shows that execution is paused for 5 seconds when run from the command line.

```powershell
PS> Get-Date; Start-Sleep -Seconds 5; Get-Date

Friday, May 13, 2022 9:38:15 AM
Friday, May 13, 2022 9:38:20 AM
```

PowerShell cannot execute the second `Get-Date` command until the sleep timer expires.

### Example 3: Sleep commands using a **TimeSpan**

This example makes all the commands in the session sleep for 30 seconds.

```powershell
Start-Sleep -Duration (New-TimeSpan -Seconds 30)
```

## PARAMETERS

### -Duration

Uses a **TimeSpan** object to specify how long the resource sleeps in milliseconds. The value must
not be a negative **TimeSpan** and must not exceed `[int]::MaxValue` milliseconds.

This parameter was added in PowerShell 7.3.

```yaml
Type: System.TimeSpan
Parameter Sets: FromTimeSpan
Aliases: ts

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Milliseconds

Specifies how long the resource sleeps in milliseconds. The parameter can be abbreviated as **m**.

```yaml
Type: System.Int32
Parameter Sets: Milliseconds
Aliases: ms

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Seconds

Specifies how long the resource sleeps in seconds. You can omit the parameter name or you can
abbreviate it as **s**. Beginning in PowerShell 6.2.0, this parameter now accepts fractional values.

```yaml
Type: System.Double
Parameter Sets: Seconds
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Int32

You can pipe the number of seconds to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

PowerShell includes the following aliases for `Start-Sleep`:

- Windows:
  - `sleep`

- `Ctrl+C` breaks out of `Start-Sleep`.
- `Ctrl+C` does not break out of `[Threading.Thread]::Sleep`. For more information, see
  [Thread.Sleep Method](/dotnet/api/system.threading.thread.sleep).

## RELATED LINKS
