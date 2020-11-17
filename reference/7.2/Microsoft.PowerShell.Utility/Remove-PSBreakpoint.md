---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/remove-psbreakpoint?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-PSBreakpoint
---

# Remove-PSBreakpoint

## SYNOPSIS
Deletes breakpoints from the current console.

## SYNTAX

### Breakpoint (Default)

```
Remove-PSBreakpoint [-Breakpoint] <Breakpoint[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Id

```
Remove-PSBreakpoint [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Remove-PSBreakpoint** cmdlet deletes a breakpoint.
Enter a breakpoint object or a breakpoint ID.

When you remove a breakpoint, the breakpoint object is no longer available or functional.
If you have saved a breakpoint object in a variable, the reference still exists, but the breakpoint does not function.

**Remove-PSBreakpoint** is one of several cmdlets designed for debugging PowerShell scripts.
For more information about the PowerShell debugger, see about_Debuggers.

## EXAMPLES

### Example 1: Remove all breakpoints

```
PS C:\> Get-PSBreakpoint | Remove-PSBreakpoint
```

This command deletes all of the breakpoints in the current console.

### Example 2: Remove a specified breakpoint

```
PS C:\> $B = Set-PSBreakpoint -Script "sample.ps1" -Variable "Name"
PS C:\> $B | Remove-PSBreakpoint
```

This command deletes a breakpoint.

The first command uses the Set-PSBreakpoint cmdlet to create a breakpoint on the Name variable in the Sample.ps1 script.
Then, it saves the breakpoint object in the $B variable.

The second command uses the **Remove-PSBreakpoint** cmdlet to delete the new breakpoint.
It uses a pipeline operator (|) to send the breakpoint object in the $B variable to the **Remove-PSBreakpoint** cmdlet.

As a result of this command, if you run the script, it runs to completion without stopping.
Also, the **Get-PSBreakpoint** cmdlet does not return this breakpoint.

### Example 3: Remove a breakpoint by ID

```
PS C:\> Remove-PSBreakpoint -Id 2
```

This command deletes the breakpoint with breakpoint ID 2.

### Example 4: Use a function to remove all breakpoints

```
PS C:\> function del-psb { get-psbreakpoint | remove-psbreakpoint }
```

This simple function deletes all of the breakpoints in the current console.
It uses the Get-PSBreakpoint cmdlet to get the breakpoints.
Then, it uses a pipeline operator (|) to send the breakpoints to the **Remove-PSBreakpoint** cmdlet, which deletes them.

As a result, you can type `del-psb` instead of the longer command.

To save the function, add it to your PowerShell profile.

## PARAMETERS

### -Breakpoint
Specifies the breakpoints to delete.
Enter a variable that contains breakpoint objects or a command that gets breakpoint objects, such as a **Get-PSBreakpoint** command.
You can also pipe breakpoint objects to **Remove-PSBreakpoint**.

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
Specifies breakpoint IDs for which this cmdlet deletes breakpoints.

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
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Breakpoint
You can pipe breakpoint objects to **Remove-PSBreakpoint**.

## OUTPUTS

### None
The cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Disable-PSBreakpoint](Disable-PSBreakpoint.md)

[Enable-PSBreakpoint](Enable-PSBreakpoint.md)

[Get-PSBreakpoint](Get-PSBreakpoint.md)

[Get-PSCallStack](Get-PSCallStack.md)

[Set-PSBreakpoint](Set-PSBreakpoint.md)

