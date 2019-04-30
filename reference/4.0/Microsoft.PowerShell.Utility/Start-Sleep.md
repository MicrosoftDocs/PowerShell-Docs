---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 3/13/2019
online version: http://go.microsoft.com/fwlink/p/?linkid=294018
schema: 2.0.0
title: Start-Sleep
---
# Start-Sleep

## SYNOPSIS
Suspends the activity in a script or session for the specified period of time.

## SYNTAX

### Seconds (Default)

```
Start-Sleep [-Seconds] <Int32> [<CommonParameters>]
```

### Milliseconds

```
Start-Sleep -Milliseconds <Int32> [<CommonParameters>]
```

## DESCRIPTION

The `Start-Sleep` cmdlet suspends the activity in a script or session for the specified period of
time.
You can use it for many tasks, such as waiting for an operation to complete or pausing before
repeating an operation.

## EXAMPLES

### Example 1: Sleep all commands for 15 seconds

```powershell
Start-Sleep -s 15
```

This command makes all commands in the session sleep for 15 seconds.

### Example 2: Sleep all commands

```powershell
Start-Sleep -m 500
```

This command makes all the commands in the session sleep for one-half of a second (500
milliseconds).

## PARAMETERS

### -Milliseconds

Specifies how long the resource sleeps in milliseconds.
The parameter can be abbreviated as **m**.

```yaml
Type: Int32
Parameter Sets: Milliseconds
Aliases: ms

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Seconds

Specifies how long the resource sleeps in seconds.
You can omit the parameter name (**Seconds**), or you can abbreviate it as **s**.

```yaml
Type: Int32
Parameter Sets: Seconds
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Int32

You can pipe the number of seconds to `Start-Sleep`.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

- You can also refer to `Start-Sleep` by its built-in alias, `sleep`. For more information, see
  [about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).
- `Ctrl+C` breaks out of `Start-Sleep`.
  - `Ctrl+C` does not break out of `[Threading.Thread]::Sleep`. For more information, see
    [Thread.Sleep Method](/dotnet/api/system.threading.thread.sleep).

## RELATED LINKS