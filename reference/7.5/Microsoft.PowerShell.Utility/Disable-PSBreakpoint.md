---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 01/20/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/disable-psbreakpoint?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-PSBreakpoint
---

# Disable-PSBreakpoint

## SYNOPSIS
Disables the breakpoints in the current console.

## SYNTAX

### Breakpoint (Default)

```
Disable-PSBreakpoint [-PassThru] [-Breakpoint] <Breakpoint[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Id

```
Disable-PSBreakpoint [-PassThru] [-Id] <Int32[]> [-Runspace <Runspace>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Disable-PSBreakpoint` cmdlet disables breakpoints, which assures that they are not hit when the
script runs. You can use it to disable all breakpoints, or you can specify breakpoints by submitting
breakpoint objects or breakpoint IDs.

Technically, this cmdlet changes the value of the Enabled property of a breakpoint object to False.
To re-enable a breakpoint, use the `Enable-PSBreakpoint` cmdlet. Breakpoints are enabled by default
when you create them using the `Set-PSBreakpoint` cmdlet.

A breakpoint is a point in a script where execution stops temporarily so that you can examine the
instructions in the script. `Disable-PSBreakpoint` is one of several cmdlets designed for debugging
PowerShell scripts. For more information about the PowerShell debugger, see
[about_Debuggers](../microsoft.powershell.core/about/about_debuggers.md).

## EXAMPLES

### Example 1: Set a breakpoint and disable it

These commands disable a newly-created breakpoint.

```powershell
$B = Set-PSBreakpoint -Script "sample.ps1" -Variable "name"
$B | Disable-PSBreakpoint
```

The `Set-PSBreakpoint` cmdlet creates a breakpoint on the `$Name` variable in the `Sample.ps1`
script and saves the breakpoint object in the `$B` variable. The `Disable-PSBreakpoint` cmdlet
disables the new breakpoint. It uses a pipeline operator (`|`) to send the breakpoint object in `$B`
to the `Disable-PSBreakpoint` cmdlet.

As a result of this command, the value of the **Enabled** property of the breakpoint object in `$B`
is **False**.

### Example 2: Disable a breakpoint

This command disables the breakpoint with breakpoint ID 0.

```powershell
Disable-PSBreakpoint -Id 0
```

### Example 3: Create a disabled breakpoint

This command creates a new breakpoint that is disabled until you enable it.

```powershell
Disable-PSBreakpoint -Breakpoint ($B = Set-PSBreakpoint -Script "sample.ps1" -Line 5)
```

It uses the `Disable-PSBreakpoint` cmdlet to disable the breakpoint. The value of the **Breakpoint**
parameter is a `Set-PSBreakpoint` command that sets a new breakpoint, generates a breakpoint object,
and saves the object in the `$B` variable.

Cmdlet parameters that take objects as their values can accept a variable that contains the object
or a command that gets or generates the object. In this case, because `Set-PSBreakpoint` generates a
breakpoint object, it can be used as the value of the **Breakpoint** parameter.

### Example 4: Disable all breakpoints in the current console

This command disables all breakpoints in the current console.

```powershell
`Get-PSBreakpoint` | Disable-PSBreakpoint
```

### Example 5: Disable a breakpoint in a runspace

In this example, a job is started and a breakpoint is set to break when the `Set-PSBreakPoint` is
run. The runspace is stored in a variable and passed to the `Get-PSBreakPoint` command with the
**Runspace** parameter. The output of `Get-PSBreakPoint` is piped to `Disable-PSBreakpoint` to
disable the breakpoint in the runspace.

```powershell
Start-Job -ScriptBlock {
    Set-PSBreakpoint -Command Start-Sleep
    Start-Sleep -Seconds 10
}

$runspace = Get-Runspace -Id 1

Get-PSBreakPoint -Runspace $runspace | Disable-Breakpoint -Runspace $runspace
```

## PARAMETERS

### -Breakpoint

Specifies the breakpoints to disable. Enter a variable that contains breakpoint objects or a command
that gets breakpoint objects, such as a `Get-PSBreakpoint` command. You can also pipe breakpoint
objects to the `Disable-PSBreakpoint` cmdlet.

```yaml
Type: System.Management.Automation.Breakpoint[]
Parameter Sets: Breakpoint
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id

Disables the breakpoints with the specified breakpoint IDs. Enter the IDs or a variable that
contains the IDs. You cannot pipe IDs to `Disable-PSBreakpoint`.

```yaml
Type: System.Int32[]
Parameter Sets: Id
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the enabled breakpoints. By default, this cmdlet does not generate
any output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Runspace

Specifies the Id of a **Runspace** object so you can interact with breakpoints in the specified
runspace.

This parameter was added in PowerShell 7.2.

```yaml
Type: Runspace
Parameter Sets: Id
Aliases: RunspaceId

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Breakpoint

You can pipe a breakpoint object to this cmdlet.

## OUTPUTS

### None

By default, this cmdlet returns no output.

### System.Management.Automation.Breakpoint

When you use the **PassThru** parameter, this cmdlet returns a breakpoint object representing the
disabled breakpoint.

## NOTES

PowerShell includes the following aliases for `Disable-PSBreakpoint`:

- All platforms:
  - `dbp`

## RELATED LINKS

[Enable-PSBreakpoint](Enable-PSBreakpoint.md)

[Get-PSBreakpoint](Get-PSBreakpoint.md)

[Get-PSCallStack](Get-PSCallStack.md)

[Remove-PSBreakpoint](Remove-PSBreakpoint.md)

[Set-PSBreakpoint](Set-PSBreakpoint.md)
