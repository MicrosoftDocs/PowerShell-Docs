---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Get PSBreakpoint
ms.technology:  powershell
external help file:  PSITPro3_Utility.xml
online version:  http://go.microsoft.com/fwlink/?LinkID=113325
schema:  2.0.0
---


# Get-PSBreakpoint
## SYNOPSIS
Gets the breakpoints that are set in the current session.
## SYNTAX

### Script (Default)
```
Get-PSBreakpoint [[-Script] <String[]>] [<CommonParameters>]
```

### Type
```
Get-PSBreakpoint [[-Script] <String[]>] [-Type] <BreakpointType[]> [<CommonParameters>]
```

### Command
```
Get-PSBreakpoint [[-Script] <String[]>] -Command <String[]> [<CommonParameters>]
```

### Variable
```
Get-PSBreakpoint [[-Script] <String[]>] -Variable <String[]> [<CommonParameters>]
```

### Id
```
Get-PSBreakpoint [-Id] <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
The Get-PSBreakPoint cmdlet gets the breakpoints that are set in the current session.
You can use the cmdlet parameters to get particular breakpoints.

A breakpoint is a point in a command or script where execution stops temporarily so that you can examine the instructions.
Get-PSBreakpoint is one of several cmdlets designed for debugging Windows PowerShell scripts and commands.
For more information about the Windows PowerShell debugger, see about_Debuggers.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
C:\PS>get-psbreakpoint
```

Description

-----------

This command gets all breakpoints set on all scripts and functions in the current session.
### -------------------------- EXAMPLE 2 --------------------------
```
C:\PS>get-psbreakpoint -Id 2

Function   : Increment
Action     :
Enabled    : True
HitCount   : 0
Id         : 2
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1
```

Description

-----------

This command gets the breakpoint with breakpoint ID 2.
### -------------------------- EXAMPLE 3 --------------------------
```
C:\PS>$b = set-psbreakpoint -script sample.ps1 -function increment
PS C:\> $b.Id | get-psbreakpoint
```

Description

-----------

These commands show how to get a breakpoint by piping a breakpoint ID to Get-PSBreakpoint.

The first command uses the Set-PSBreakpoint cmdlet to create a breakpoint on the Increment function in the Sample.ps1 script.
It saves the breakpoint object in the $b variable.

The second command uses the dot operator (.) to get the Id property of the breakpoint object in the $b variable.
It uses a pipeline operator (|) to send the ID to the Get-PSBreakpoint cmdlet.

As a result, Get-PSBreakpoint gets the breakpoint with the specified ID.
### -------------------------- EXAMPLE 4 --------------------------
```
C:\PS>get-psbreakpoint -script Sample.ps1, SupportScript.ps1
```

Description

-----------

This command gets all of the breakpoints in the Sample.ps1 and SupportScript.ps1 files.

This command does not get other breakpointS that might be set in other scripts or on functions in the session.
### -------------------------- EXAMPLE 5 --------------------------
```
C:\PS>get-psbreakpoint -command Read-Host, Write-Host -script Sample.ps1
```

Description

-----------

This command gets all Command breakpoints that are set on Read-Host or Write-Host commands in the Sample.ps1 file.
### -------------------------- EXAMPLE 6 --------------------------
```
C:\PS>get-psbreakpoint -type Command -script Sample.ps1
```

Description

-----------

This command gets all Command breakpoints in the Sample.ps1 file.
### -------------------------- EXAMPLE 7 --------------------------
```
C:\PS>get-psbreakpoint -variable Index, Swap
```

Description

-----------

This command gets breakpoints that are set on the $index and $swap variables in the current session.
### -------------------------- EXAMPLE 8 --------------------------
```
C:\PS>get-psbreakpoint -type line, variable -script Sample.ps1
```

Description

-----------

This command gets all line and variable breakpoints in the Sample.ps1 script.
## PARAMETERS

### -Command
Gets command breakpoints that are set on the specified command names.
Enter the command names, such as the name of a cmdlet or function.

```yaml
Type: String[]
Parameter Sets: Command
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Gets the breakpoints with the specified breakpoint IDs.
Enter the IDs in a comma-separated list.
You can also pipe breakpoint IDs to Get-PSBreakpoint.

```yaml
Type: Int32[]
Parameter Sets: Id
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Script
Gets only the breakpoints in the specified scripts.
Enter the  path (optional) and names of one or more script files.
If you omit the path, the default location is the current directory.

```yaml
Type: String[]
Parameter Sets: Script
Aliases: 

Required: False
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

```yaml
Type: String[]
Parameter Sets: Type, Command, Variable
Aliases: 

Required: False
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Type
Gets only breakpoints of the specified types.
Enter one or more types.
Valid values are Line, Command, and Variable.
You can also pipe breakpoint types to Get-PSBreakpoint.

```yaml
Type: BreakpointType[]
Parameter Sets: Type
Aliases: 

Required: True
Position: 1
Default value: All types
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Variable
Gets variable breakpoints that are set on the specified variable names.
Enter the variable names without dollar signs.

```yaml
Type: String[]
Parameter Sets: Variable
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.Int32, Microsoft.PowerShell.Commands.BreakpointType
You can pipe breakpoint IDs and breakpoint types to Get-PSBreakpoint.
## OUTPUTS

### System.Management.Automation.Breakpoint
Get-PSBreakPoint returns objects that represent the breakpoints in the session.
## NOTES
* You can use Get-PSBreakpoint or its alias, "gbp".
## RELATED LINKS

[Disable-PSBreakpoint](Disable-PSBreakpoint.md)

[Enable-PSBreakpoint](Enable-PSBreakpoint.md)

[Get-PSCallStack](Get-PSCallStack.md)

[Remove-PSBreakpoint](Remove-PSBreakpoint.md)

[Set-PSBreakpoint](Set-PSBreakpoint.md)

[about_Debuggers]()

