---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 12/12/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/get-psbreakpoint?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-PSBreakpoint
---

# Get-PSBreakpoint

## SYNOPSIS
Gets the breakpoints that are set in the current session.

## SYNTAX

### Script (Default)

```
Get-PSBreakpoint [-Script <String[]>] [<CommonParameters>]
```

### Variable

```
Get-PSBreakpoint [-Script <String[]>] -Variable <String[]> [<CommonParameters>]
```

### Command

```
Get-PSBreakpoint [-Script <String[]>] -Command <String[]> [<CommonParameters>]
```

### Type

```
Get-PSBreakpoint [-Script <String[]>] [-Type] <BreakpointType[]> [<CommonParameters>]
```

### Id

```
Get-PSBreakpoint [-Id] <Int32[]> [<CommonParameters>]
```

## DESCRIPTION

The `Get-PSBreakPoint` cmdlet gets the breakpoints that are set in the current session. You can use
the cmdlet parameters to get particular breakpoints.

A breakpoint is a point in a command or script where execution stops temporarily so that you can
examine the instructions. `Get-PSBreakpoint` is one of several cmdlets designed for debugging
PowerShell scripts and commands. For more information about the PowerShell debugger, see
[about_Debuggers](../microsoft.powershell.core/about/about_debuggers.md).

## EXAMPLES

### Example 1: Get all breakpoints for all scripts and functions

This command gets all breakpoints set on all scripts and functions in the current session.

```powershell
Get-PSBreakpoint
```

### Example 2: Get breakpoints by ID

This command gets the breakpoint with breakpoint ID 2.

```powershell
Get-PSBreakpoint -Id 2
```

```Output
Function         :
IncrementAction  :
Enabled          :
TrueHitCount     : 0
Id               : 2
Script           : C:\ps-test\sample.ps1
ScriptName       : C:\ps-test\sample.ps1
```

### Example 3: Pipe an ID to `Get-PSBreakpoint`

These commands show how to get a breakpoint by piping a breakpoint ID to `Get-PSBreakpoint`.

```powershell
$B = `Set-PSBreakpoint` -Script "sample.ps1" -Command "Increment"
$B.Id | Get-PSBreakpoint
```

The `Set-PSBreakpoint` cmdlet creates a breakpoint on the Increment function in the `Sample.ps1`
script and saves the breakpoint object in the `$B` variable. The **Id** property of the breakpoint
object in the `$B` variable is piped to the `Get-PSBreakpoint` cmdlet to display the breakpoint
information.

### Example 4: Get breakpoints in specified script files

This command gets all of the breakpoints in the `Sample.ps1` and `SupportScript.ps1` files.

```powershell
Get-PSBreakpoint -Script "Sample.ps1, SupportScript.ps1"
```

This command does not get other breakpoints that might be set in other scripts or on functions in
the session.

### Example 5: Get breakpoints in specified cmdlets

This command gets all Command breakpoints that are set on `Read-Host` or `Write-Host` commands in
the `Sample.ps1` file.

```powershell
Get-PSBreakpoint -Command "Read-Host, Write-Host" -Script "Sample.ps1"
```

### Example 6: Get Command breakpoints in a specified file

```powershell
Get-PSBreakpoint -Type Command -Script "Sample.ps1"
```

This command gets all Command breakpoints in the Sample.ps1 file.

### Example 7: Get breakpoints by variable

This command gets breakpoints that are set on the `$Index` and `$Swap` variables in the current
session.

```powershell
Get-PSBreakpoint -Variable "Index, Swap"
```

### Example 8: Get all Line and Variable breakpoints in a file

This command gets all line and variable breakpoints in the `Sample.ps1` script.

```powershell
Get-PSBreakpoint -Type Line, Variable -Script "Sample.ps1"
```

## PARAMETERS

### -Command

Specifies an array of command breakpoints that are set on the specified command names. Enter the
command names, such as the name of a cmdlet or function.

```yaml
Type: System.String[]
Parameter Sets: Command
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies the breakpoint IDs that this cmdlet gets. Enter the IDs in a comma-separated list. You can
also pipe breakpoint IDs to `Get-PSBreakpoint`.

```yaml
Type: System.Int32[]
Parameter Sets: Id
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Script

Specifies an array of scripts that contain the breakpoints. Enter the path (optional) and names of
one or more script files. If you omit the path, the default location is the current directory.

```yaml
Type: System.String[]
Parameter Sets: Script, Variable, Command, Type
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Type

Specifies an array of breakpoint types that this cmdlet gets. Enter one or more types. The
acceptable values for this parameter are:

- Line
- Command
- Variable

You can also pipe breakpoint types to `Get-PSBreakPoint`.

```yaml
Type: Microsoft.PowerShell.Commands.BreakpointType[]
Parameter Sets: Type
Aliases:
Accepted values: Line, Variable, Command

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Variable

Specifies an array of variable breakpoints that are set on the specified variable names. Enter the
variable names without dollar signs.

```yaml
Type: System.String[]
Parameter Sets: Variable
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

You can pipe breakpoint IDs to this cmdlet.

### Microsoft.PowerShell.Commands.BreakpointType

You can pipe breakpoint types to this cmdlet.

## OUTPUTS

### System.Management.Automation.CommandBreakpoint

### System.Management.Automation.LineBreakpoint

### System.Management.Automation.VariableBreakpoint

### System.Management.Automation.Breakpoint

This cmdlet returns objects that represent the breakpoints in the session.

## NOTES

Windows PowerShell includes the following aliases for `Get-PSBreakpoint`:

- `gbp`

## RELATED LINKS

[Disable-PSBreakpoint](Disable-PSBreakpoint.md)

[Enable-PSBreakpoint](Enable-PSBreakpoint.md)

[Get-PSCallStack](Get-PSCallStack.md)

[Remove-PSBreakpoint](Remove-PSBreakpoint.md)

[Set-PSBreakpoint](Set-PSBreakpoint.md)
