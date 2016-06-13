---
external help file: PSITPro3_Utility.xml
online version: http://go.microsoft.com/fwlink/?LinkID=113375
schema: 2.0.0
---

# Remove-PSBreakpoint
## SYNOPSIS
Deletes breakpoints from the current console.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-PSBreakpoint [-Breakpoint] <Breakpoint[]> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-PSBreakpoint [-Id] <Int32[]> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Remove-PSBreakpoint cmdlet deletes a breakpoint.
Enter a breakpoint object or a breakpoint ID.

When you remove a breakpoint, the breakpoint object is no longer available or functional.
If you have saved a breakpoint object in a variable, the reference still exists, but the breakpoint does not function.

Remove-PSBreakpoint is one of several cmdlets designed for debugging Windows PowerShell scripts.
For more information about the Windows PowerShell debugger, see about_Debuggers.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-breakpoint | remove-breakpoint
```

This command deletes all of the breakpoints in the current console.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$b = set-psbreakpoint -script sample.ps1 -variable Name
PS C:\>$b | remove-psbreakpoint
```

This command deletes a breakpoint.

The first command uses the Set-PSBreakpoint cmdlet to create a breakpoint on the Name variable in the Sample.ps1 script.
Then, it saves the breakpoint object in the $b variable.

The second command uses the Remove-PSBreakpoint cmdlet to delete the new breakpoint.
It uses a pipeline operator (|) to send the breakpoint object in the $b variable to the Remove-PSBreakpoint cmdlet.

As a result of this command, if you run the script, it runs to completion without stopping.
Also, the Get-PSBreakpoint cmdlet does not return this breakpoint.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>remove-psbreakpoint -id 2
```

This command deletes the breakpoint with breakpoint ID 2.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>function del-psb { get-psbreakpoint | remove-psbreakpoint }
```

This simple function deletes all of the breakpoints in the current console.
It uses the Get-PSBreakpoint cmdlet to get the breakpoints.
Then, it uses a pipeline operator (|) to send the breakpoints to the Remove-PSBreakpoint cmdlet, which deletes them.

As a result, you can type "del-psb" instead of the longer command.

To save the function, add it to your Windows PowerShell profile.

## PARAMETERS

### -Breakpoint
Specifies the breakpoints to delete.
Enter a variable that contains breakpoint objects or a command that gets breakpoint objects, such as a Get-PSBreakpoint command.
You can also pipe breakpoint objects to Remove-PSBreakpoint.

```yaml
Type: Breakpoint[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
Deletes breakpoints with the specified breakpoint IDs.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.Breakpoint
You can pipe breakpoint objects to Remove-PSBreakpoint.

## OUTPUTS

### None
The cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Disable-PSBreakpoint](d4974e9b-0aaa-4e20-b87f-f599a413e4e8)

[Enable-PSBreakpoint](739e1091-3b3f-405f-a428-bec7543e5df0)

[Get-PSBreakpoint](0bf48936-00ab-411c-b5e0-9b10a812a3c6)

[Get-PSCallStack](e91a17dc-db39-4c90-ae0e-6eeed3c0efef)

[Set-PSBreakpoint](6afd5d2c-a285-4796-8607-3cbf49471420)

[about_Debuggers]()

