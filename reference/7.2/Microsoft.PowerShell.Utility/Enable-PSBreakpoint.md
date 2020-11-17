---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/09/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/enable-psbreakpoint?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Enable-PSBreakpoint
---

# Enable-PSBreakpoint

## SYNOPSIS
Enables the breakpoints in the current console.

## SYNTAX

### Id (Default)

```
Enable-PSBreakpoint [-PassThru] [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Breakpoint

```
Enable-PSBreakpoint [-PassThru] [-Breakpoint] <Breakpoint[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Enable-PSBreakpoint` cmdlet re-enables disabled breakpoints. You can use it to enable all
breakpoints, or specific breakpoints by providing breakpoint objects or IDs.

A breakpoint is a point in a script where execution stops temporarily so that you can examine the
state of the script. Newly created breakpoints are automatically enabled, but can be disabled using
`Disable-PSBreakpoint`.

Technically, this cmdlet changes the value of the **Enabled** property of a breakpoint object to
**True**.

`Enable-PSBreakpoint` is one of several cmdlets designed for debugging PowerShell scripts. For more
information about the PowerShell debugger, see [about_Debuggers](../Microsoft.PowerShell.Core/About/about_Debuggers.md).

## EXAMPLES

### Example 1: Enable all breakpoints

This example enables all breakpoints in the current session.

```powershell
Get-PSBreakpoint | Enable-PSBreakpoint
```

Using aliases, this example can be abbreviated as `gbp | ebp`.

### Example 2: Enable breakpoints by ID

This example enables multiple breakpoints using their breakpoint IDs.

```powershell
Enable-PSBreakpoint -Id 0, 1, 5
```

### Example 3: Enable a disabled breakpoint

This example re-enables a breakpoint that has been disabled.

```powershell
$B = Set-PSBreakpoint -Script "sample.ps1" -Variable Name -PassThru
$B | Enable-PSBreakpoint -PassThru
```

```Output
AccessMode : Write
Variable   : Name
Action     :
Enabled    : False
HitCount   : 0
Id         : 0
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1

AccessMode : Write
Variable   : Name
Action     :
Enabled    : True
HitCount   : 0
Id         : 0
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1
```

`Set-PSBreakpoint` creates a breakpoint on the **Name** variable in the `Sample.ps1` script saving
the breakpoint object in the `$B` variable. The **PassThru** parameter displays the value of the
**Enabled** property of the breakpoint is **False**.

`Enable-PSBreakpoint` re-enables the breakpoint. Again, using the **PassThru** parameter we see that
the value of the **Enabled** property is **True**.

### Example 4: Enable breakpoints using a variable

This example enables a set of breakpoints using the breakpoint objects.

```powershell
$B = Get-PSBreakpoint -Id 3, 5
Enable-PSBreakpoint -Breakpoint $B
```

`Get-PSBreakpoint` gets the breakpoints and saves them in the `$B` variable. Using the
**Breakpoint** parameter, `Enable-PSBreakpoint` enables the breakpoints.

This example is equivalent to running `Enable-PSBreakpoint -Id 3, 5`.

## PARAMETERS

### -Breakpoint

Specifies the breakpoints to enable. Provide a variable containing breakpoints or a command that
gets breakpoint objects, such as `Get-PSBreakpoint`. You can also pipe breakpoint objects to
`Enable-PSBreakpoint`.

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

Specifies the **Id** numbers of the breakpoints to enable. The default value is all breakpoints.
Provide the **Id** by number or in a variable. You can't pipe **Id** numbers to
`Enable-PSBreakpoint`. To find the **Id** of a breakpoint, use the `Get-PSBreakpoint` cmdlet.

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

Returns an object representing the breakpoint being enabled. By default, this cmdlet doesn't
generate any output.

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

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Breakpoint

You can pipe a breakpoint object to `Enable-PSBreakpoint`.

## OUTPUTS

### None or System.Management.Automation.Breakpoint

When you use the **PassThru** parameter, `Enable-PSBreakpoint` returns a breakpoint object that represents that breakpoint that was enabled. Otherwise, this cmdlet doesn't generate any output.

## NOTES

- The `Enable-PSBreakpoint` cmdlet doesn't generate an error if you try to enable a breakpoint that
  is already enabled. As such, you can enable all breakpoints without error, even when only a few
  are disabled.

- Breakpoints are enabled when you create them by using the `Set-PSBreakpoint` cmdlet. You don't
  need to enable newly created breakpoints.

## RELATED LINKS

[Disable-PSBreakpoint](Disable-PSBreakpoint.md)

[Get-PSBreakpoint](Get-PSBreakpoint.md)

[Get-PSCallStack](Get-PSCallStack.md)

[Remove-PSBreakpoint](Remove-PSBreakpoint.md)

[Set-PSBreakpoint](Set-PSBreakpoint.md)

