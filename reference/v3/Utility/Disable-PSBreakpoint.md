---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Disable-PSBreakpoint
## SYNOPSIS
Disables the breakpoints in the current console.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Disable-PSBreakpoint [-Breakpoint] <Breakpoint[]> [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Disable-PSBreakpoint [-Id] <Int32[]> [-PassThru] [-Confirm] [-WhatIf]
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
It uses a pipeline operator \(|\) to send the breakpoint object in $b to the Disable-PSBreakpoint cmdlet.

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
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: true (ByValue)
Accept wildcard characters: False
```

### -Id
Disables the breakpoints with the specified breakpoint IDs.
Enter the IDs or a variable that contains the IDs.
You cannot pipe IDs to Disable-PSBreakpoint.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: true (ByPropertyName)
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
Default value: False
Accept pipeline input: false
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: false
Accept pipeline input: false
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: false
Accept pipeline input: false
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

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113294)

[Enable-PSBreakpoint](739e1091-3b3f-405f-a428-bec7543e5df0)

[Get-PSBreakpoint](0bf48936-00ab-411c-b5e0-9b10a812a3c6)

[Get-PSCallStack](e91a17dc-db39-4c90-ae0e-6eeed3c0efef)

[Remove-PSBreakpoint](4c877a80-0ea0-4790-9281-88c08ef0ddd6)

[Set-PSBreakpoint](6afd5d2c-a285-4796-8607-3cbf49471420)

[about_Debuggers]()


