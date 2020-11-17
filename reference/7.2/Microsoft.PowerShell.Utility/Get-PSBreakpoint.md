---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 05/15/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-psbreakpoint?view=powershell-7.2&WT.mc_id=ps-gethelp
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

The **Get-PSBreakPoint** cmdlet gets the breakpoints that are set in the current session.
You can use the cmdlet parameters to get particular breakpoints.

A breakpoint is a point in a command or script where execution stops temporarily so that you can
examine the instructions.
**Get-PSBreakpoint** is one of several cmdlets designed for debugging PowerShell scripts and
commands. For more information about the PowerShell debugger, see about_Debuggers.

## EXAMPLES

### Example 1: Get all breakpoints for all scripts and functions

```
PS C:\> Get-PSBreakpoint
```

This command gets all breakpoints set on all scripts and functions in the current session.

### Example 2: Get breakpoints by ID

```
PS C:\> Get-PSBreakpoint -Id 2
Function   :
IncrementAction     :
Enabled    :
TrueHitCount   : 0
Id         : 2
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1
```

This command gets the breakpoint with breakpoint ID 2.

### Example 3: Pipe an ID to Get-PSBreakpoint

```
PS C:\> $B = Set-PSBreakpoint -Script "sample.ps1" -Command "Increment"
PS C:\> $B.Id | Get-PSBreakpoint
```

These commands show how to get a breakpoint by piping a breakpoint ID to **Get-PSBreakpoint**.

The first command uses the Set-PSBreakpoint cmdlet to create a breakpoint on the Increment function
in the Sample.ps1 script. It saves the breakpoint object in the $B variable.

The second command uses the dot operator (.) to get the Id property of the breakpoint object in the
$B variable. It uses a pipeline operator (|) to send the ID to the **Get-PSBreakpoint** cmdlet.

As a result, **Get-PSBreakpoint** gets the breakpoint with the specified ID.

### Example 4: Get breakpoints in specified script files

```
PS C:\> Get-PSBreakpoint -Script "Sample.ps1, SupportScript.ps1"
```

This command gets all of the breakpoints in the Sample.ps1 and SupportScript.ps1 files.

This command does not get other breakpoints that might be set in other scripts or on functions in
the session.

### Example 5: Get breakpoints in specified cmdlets

```
PS C:\> Get-PSBreakpoint -Command "Read-Host, Write-Host" -Script "Sample.ps1"
```

This command gets all Command breakpoints that are set on Read-Host or Write-Host commands in the
Sample.ps1 file.

### Example 6: Get Command breakpoints in a specified file

```
PS C:\> Get-PSBreakpoint -Type Command -Script "Sample.ps1"
```

This command gets all Command breakpoints in the Sample.ps1 file.

### Example 7: Get breakpoints by variable

```
PS C:\> Get-PSBreakpoint -Variable "Index, Swap"
```

This command gets breakpoints that are set on the $Index and $Swap variables in the current session.

### Example 8: Get all Line and Variable breakpoints in a file

```
PS C:\> Get-PSBreakpoint -Type Line, Variable -Script "Sample.ps1"
```

This command gets all line and variable breakpoints in the Sample.ps1 script.

## PARAMETERS

### -Command

Specifies an array of command breakpoints that are set on the specified command names.
Enter the command names, such as the name of a cmdlet or function.

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

Specifies the breakpoint IDs that this cmdlet gets.
Enter the IDs in a comma-separated list.
You can also pipe breakpoint IDs to **Get-PSBreakpoint**.

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

Specifies an array of scripts that contain the breakpoints.
Enter the path (optional) and names of one or more script files.
If you omit the path, the default location is the current directory.

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

Specifies an array of breakpoint types that this cmdlet gets.
Enter one or more types.
The acceptable values for this parameter are:

- Line
- Command
- Variable

You can also pipe breakpoint types to **Get-PSBreakPoint**.

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

Specifies an array of variable breakpoints that are set on the specified variable names.
Enter the variable names without dollar signs.

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
-WarningAction, and -WarningVariable. For more information, see about_CommonParameters
(https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32, Microsoft.PowerShell.Commands.BreakpointType

You can pipe breakpoint IDs and breakpoint types to **Get-PSBreakPoint**.

## OUTPUTS

### System.Management.Automation.Breakpoint

**Get-PSBreakPoint** returns objects that represent the breakpoints in the session.

## NOTES

* You can use **Get-PSBreakpoint** or its alias, "gbp".

## RELATED LINKS

[Disable-PSBreakpoint](Disable-PSBreakpoint.md)

[Enable-PSBreakpoint](Enable-PSBreakpoint.md)

[Get-PSCallStack](Get-PSCallStack.md)

[Remove-PSBreakpoint](Remove-PSBreakpoint.md)

[Set-PSBreakpoint](Set-PSBreakpoint.md)

