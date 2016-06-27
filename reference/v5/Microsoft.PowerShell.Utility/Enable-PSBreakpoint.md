---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293954
schema: 2.0.0
---

# Enable-PSBreakpoint
## SYNOPSIS
Enables the breakpoints in the current console.

## SYNTAX

### Id (Default)
```
Enable-PSBreakpoint [-PassThru] [-Id] <Int32[]> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### Breakpoint
```
Enable-PSBreakpoint [-PassThru] [-Breakpoint] <Breakpoint[]> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Enable-PSBreakpoint cmdlet re-enables disabled breakpoints.
You can use it to enable all breakpoints, or you can specify breakpoints by submitting breakpoint objects or breakpoint IDs.

A breakpoint is a point in a script where execution stops temporarily so that you can examine the instructions in the script.
Newly created breakpoints are automatically enabled, but you can disable them by using the Disable-PSBreakpoint cmdlet.

Technically, this cmdlet changes the value of the Enabled property of a breakpoint object to True.

Enable-PSBreakpoint is one of several cmdlets designed for debugging Windows PowerShell scripts.
For more information about the Windows PowerShell debugger, see about_Debuggers.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-psbreakpoint | enable-psbreakpoint
```

This command enables all breakpoints in the current console.
You can abbreviate the command as "gbp | ebp".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>enable-psbreakpoint -id 0, 1, 5
```

This command enables breakpoints with breakpoint IDs 0, 1, and 5.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$b = set-psbreakpoint -script sample.ps1 -variable Name
PS C:\>$b | disable-psbreakpoint -passthru

AccessMode : Write
Variable   : Name
Action     :
Enabled    : False
HitCount   : 0
Id         : 0
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1

PS C:\>$b | enable-psbreakpoint -passthru

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

The first command uses the Set-PSBreakpoint cmdlet to create a breakpoint on the "Name" variable in the Sample.ps1 script.
Then, it saves the breakpoint object in the $b variable.

The second command uses the Disable-PSBreakpoint cmdlet to disable the new breakpoint.
It uses a pipeline operator (|) to send the breakpoint object in $b to the Disable-PSBreakpoint cmdlet, and it uses the PassThru parameter of Disable-PSBreakpoint to display the disabled breakpoint object.
This lets you verify that the value of the Enabled property of the breakpoint object is False.

The third command uses the Enable-PSBreakpoint cmdlet to re-enable the breakpoint.
It uses a pipeline operator (|) to send the breakpoint object in $b to the Enable-PSBreakpoint cmdlet, and it uses the PassThru parameter of Enable-PSBreakpoint to display the breakpoint object.
This lets you verify that the value of the Enabled property of the breakpoint object is True.

The results are shown in the following sample output.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>$b = get-psbreakpoint -id 3, 5
PS C:\>enable-psbreakpoint -breakpoint $b
```

These commands enable a set of breakpoints by specifying their breakpoint objects.

The first command uses the Get-PSBreakpoint cmdlet to get the breakpoints and saves them in the $b variable.

The second command uses the Enable-PSBreakpoint cmdlet and its Breakpoint parameter to enable the breakpoints.

This command is the equivalent of "enable-psbreakpoint -id 3, 5".

## PARAMETERS

### -Breakpoint
Specifies the breakpoints to enable.
Enter a variable that contains breakpoint objects or a command that gets breakpoint objects, such as a Get-PSBreakpoint command.
You can also pipe breakpoint objects to Enable-PSBreakpoint.

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
Enables breakpoints that have the specified breakpoint IDs.
The default value is all breakpoints.
Enter the IDs or a variable that contains the IDs.
(You cannot pipe IDs to Enable-PSBreakpoint.) To find the ID of a breakpoint, use the Get-PSBreakpoint cmdlet.

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
Returns an object representing the enabled breakpoint.
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
{{Fill Confirm Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
{{Fill WhatIf Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.Breakpoint
You can pipe a breakpoint object to Enable-PSBreakpoint.

## OUTPUTS

### None or System.Management.Automation.Breakpoint
When you use the PassThru parameter, Enable-PSBreakpoint returns a breakpoint object that represent that breakpoint that was enabled.
Otherwise, this cmdlet does not generate any output.

## NOTES
The Enable-PSBreakpoint cmdlet does not generate an error if you try to enable a breakpoint that is already enabled.
As such, you can enable all breakpoints without error, even when only a few are disabled.

Breakpoints are enabled when you create them by using the Set-PSBreakpoint cmdlet.
You do not need to enable newly created breakpoints.

## RELATED LINKS

[Disable-PSBreakpoint]()

[Get-PSBreakpoint]()

[Get-PSCallStack]()

[Remove-PSBreakpoint]()

[Set-PSBreakpoint]()

[about_Debuggers]()

