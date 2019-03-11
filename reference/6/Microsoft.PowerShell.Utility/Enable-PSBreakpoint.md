---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821764
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
Enable-PSBreakpoint [-PassThru] [-Breakpoint] <Breakpoint[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **Enable-PSBreakpoint** cmdlet re-enables disabled breakpoints.
You can use it to enable all breakpoints, or you can specify breakpoints by submitting breakpoint objects or breakpoint IDs.

A breakpoint is a point in a script where execution stops temporarily so that you can examine the instructions in the script.
Newly created breakpoints are automatically enabled, but you can disable them by using the Disable-PSBreakpoint cmdlet.

Technically, this cmdlet changes the value of the Enabled property of a breakpoint object to True.

**Enable-PSBreakpoint** is one of several cmdlets designed for debugging PowerShell scripts.
For more information about the PowerShell debugger, see about_Debuggers.

## EXAMPLES

### Example 1: Enable all breakpoints

```
PS C:\> Get-PSBreakpoint | Enable-PSBreakpoint
```

This command enables all breakpoints in the current console.
You can abbreviate the command as `gbp | ebp`.

### Example 2: Enable breakpoints by ID

```
PS C:\> Enable-PSBreakpoint -Id 0, 1, 5
```

This command enables breakpoints with breakpoint IDs 0, 1, and 5.

### Example 3: Enable a disabled breakpoint

```
PS C:\> $B = Set-PSBreakpoint -Script "sample.ps1" -Variable Name
PS C:\> $B | Disable-PSBreakpoint -PassThru
AccessMode : Write
Variable   : Name
Action     :
Enabled    : False
HitCount   : 0
Id         : 0
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1 PS C:\> $B | Enable-PSBreakpoint -PassThru
AccessMode : Write
Variable   : Name
Action     :
Enabled    : True
HitCount   : 0
Id         : 0
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1
```

These commands re-enable a breakpoint that has been disabled.

The first command uses the Set-PSBreakpoint cmdlet to create a breakpoint on the Name variable in the Sample.ps1 script.
Then, it saves the breakpoint object in the $B variable.

The second command uses the Disable-PSBreakpoint cmdlet to disable the new breakpoint.
It uses a pipeline operator (|) to send the breakpoint object in $B to the **Disable-PSBreakpoint** cmdlet, and it uses the *PassThru* parameter of **Disable-PSBreakpoint** to display the disabled breakpoint object.
This lets you verify that the value of the Enabled property of the breakpoint object is False.

The third command uses the **Enable-PSBreakpoint** cmdlet to re-enable the breakpoint.
It uses a pipeline operator (|) to send the breakpoint object in $B to the **Enable-PSBreakpoint** cmdlet, and it uses the *PassThru* parameter of **Enable-PSBreakpoint** to display the breakpoint object.
This lets you verify that the value of the Enabled property of the breakpoint object is True.

The results are shown in the following sample output.

### Example 4: Enable breakpoints using a variable

```
PS C:\> $B = Get-PSBreakpoint -Id 3, 5
PS C:\> Enable-PSBreakpoint -Breakpoint $B
```

These commands enable a set of breakpoints by specifying their breakpoint objects.

The first command uses the Get-PSBreakpoint cmdlet to get the breakpoints and saves them in the $B variable.

The second command uses the **Enable-PSBreakpoint** cmdlet and its *Breakpoint* parameter to enable the breakpoints.

This command is the equivalent of `Enable-PSBreakpoint -Id 3, 5`.

## PARAMETERS

### -Breakpoint

Specifies the breakpoints to enable.
Enter a variable that contains breakpoint objects or a command that gets breakpoint objects, such as a Get-PSBreakpoint command.
You can also pipe breakpoint objects to **Enable-PSBreakpoint**.

```yaml
Type: Breakpoint[]
Parameter Sets: Breakpoint
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id

Specifies breakpoint IDs that this cmdlet enables.
The default value is all breakpoints.
Enter the IDs or a variable that contains the IDs.
You cannot use the pipeline to send IDs to **Enable-PSBreakpoint**.
To find the ID of a breakpoint, use the Get-PSBreakpoint cmdlet.

```yaml
Type: Int32[]
Parameter Sets: Id
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the item with which you are working.
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

Prompts you for confirmation before running the cmdlet.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Breakpoint

You can pipe a breakpoint object to **Enable-PSBreakpoint**.

## OUTPUTS

### None or System.Management.Automation.Breakpoint

When you use the *PassThru* parameter, **Enable-PSBreakpoint** returns a breakpoint object that represent that breakpoint that was enabled.
Otherwise, this cmdlet does not generate any output.

## NOTES

* The **Enable-PSBreakpoint** cmdlet does not generate an error if you try to enable a breakpoint that is already enabled. As such, you can enable all breakpoints without error, even when only a few are disabled.

  Breakpoints are enabled when you create them by using the Set-PSBreakpoint cmdlet.
You do not need to enable newly created breakpoints.

*

## RELATED LINKS

[Disable-PSBreakpoint](Disable-PSBreakpoint.md)

[Get-PSBreakpoint](Get-PSBreakpoint.md)

[Get-PSCallStack](Get-PSCallStack.md)

[Remove-PSBreakpoint](Remove-PSBreakpoint.md)

[Set-PSBreakpoint](Set-PSBreakpoint.md)