---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293953
schema: 2.0.0
---

# Disable-PSBreakpoint
## SYNOPSIS
Disables the breakpoints in the current console.

## SYNTAX

### Breakpoint (Default)
```
Disable-PSBreakpoint [-PassThru] [-Breakpoint] <Breakpoint[]> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### Id
```
Disable-PSBreakpoint [-PassThru] [-Id] <Int32[]> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Disable-PSBreakpoint cmdlet disables breakpoints, which assures that they are not hit when the script runs.
You can use it to disable all breakpoints, or you can specify breakpoints by submitting breakpoint objects or breakpoint IDs.

Technically, this cmdlet changes the value of the Enabled property of a breakpoint object to False.
To re-enable a breakpoint, use the Enable-PSBreakpoint cmdlet.
Breakpoints are enabled by default when you create them by using the Set-PSBreakpoint cmdlet.

A breakpoint is a point in a script where execution stops temporarily so that you can examine the instructions in the script.
Disable-PSBreakpoint is one of several cmdlets designed for debugging Windows PowerShell scripts.
For more information about the Windows PowerShell debugger, see about_Debuggers.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>$b = set-psbreakpoint -script sample.ps1 -variable name
PS C:\>$b | disable-psbreakpoint
```

These commands disable a newly-created breakpoint.

The first command uses the Set-PSBreakpoint cmdlet to create a breakpoint on the Name variable in the Sample.ps1 script.
Then, it saves the breakpoint object in the $b variable.

The second command uses the Disable-PSBreakpoint cmdlet to disable the new breakpoint.
It uses a pipeline operator (|) to send the breakpoint object in $b to the Disable-PSBreakpoint cmdlet.

As a result of this command, the value of the Enabled property of the breakpoint object in $b is False.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>disable-psbreakpoint -id 0
```

This command disables the breakpoint with breakpoint ID 0.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>disable-psbreakpoint -breakpoint ($b = set-psbreakpoint -script sample.ps1 -line 5)
PS C:\>$b
```

This command creates a new breakpoint that is disabled until you enable it.

It uses the Disable-PSBreakpoint cmdlet to disable the breakpoint.
The value of the Breakpoint parameter is a Set-PSBreakpoint command that sets a new breakpoint, generates a breakpoint object, and saves the object in the $b variable.

Cmdlet parameters that take objects as their values can accept a variable that contains the object or a command that gets or generates the object.
In this case, because Set-PSBreakpoint generates a breakpoint object, it can be used as the value of the Breakpoint parameter.

The second command displays the breakpoint object in the value of the $b variable.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-psbreakpoint | disable-psbreakpoint
```

This command disables all breakpoints in the current console.
You can abbreviate this command as: "gbp | dbp".

## PARAMETERS

### -Breakpoint
Specifies the breakpoints to disable.
Enter a variable that contains breakpoint objects or a command that gets breakpoint objects, such as a Get-PSBreakpoint command.
You can also pipe breakpoint objects to the Disable-PSBreakpoint cmdlet.

```yaml
Type: Breakpoint[]
Parameter Sets: Breakpoint
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
Disables the breakpoints with the specified breakpoint IDs.
Enter the IDs or a variable that contains the IDs.
You cannot pipe IDs to Disable-PSBreakpoint.

```yaml
Type: Int32[]
Parameter Sets: Id
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the enabled breakpoints.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.Breakpoint
You can pipe a breakpoint object to Disable-PSBreakpoint.

## OUTPUTS

### None or System.Management.Automation.Breakpoint
When you use the PassThru parameter, Disable-PSBreakpoint returns an object that represents the disabled breakpoint.
Otherwise, this cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Enable-PSBreakpoint]()

[Get-PSBreakpoint]()

[Get-PSCallStack]()

[Remove-PSBreakpoint]()

[Set-PSBreakpoint]()

[about_Debuggers]()

