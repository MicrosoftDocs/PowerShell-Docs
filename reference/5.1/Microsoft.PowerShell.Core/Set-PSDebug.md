---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821515
schema: 2.0.0
title: Set-PSDebug
---

# Set-PSDebug

## SYNOPSIS
Turns script debugging features on and off, sets the trace level, and toggles strict mode.

## SYNTAX

### on
```
Set-PSDebug [-Trace <Int32>] [-Step] [-Strict] [<CommonParameters>]
```

### off
```
Set-PSDebug [-Off] [<CommonParameters>]
```

## DESCRIPTION
The **Set-PSDebug** cmdlet turns script debugging features on and off, sets the trace level, and toggles strict mode.

When the *Trace* parameter has a value of 1, each line of script is traced as it runs.
When the parameter has a value of 2, variable assignments, function calls, and script calls are also traced.
If the *Step* parameter is specified, you are prompted before each line of the script runs.

## EXAMPLES

### Example 1: Set the trace level to 2
```
PS C:\> Set-PSDebug -Trace 2; foreach ($i in 1..3) {$i}

DEBUG:    1+ Set-PsDebug -Trace 2; foreach ($i in 1..3) {$i}
DEBUG:    1+ Set-PsDebug -Trace 2; foreach ($i in 1..3) {$i}
1
DEBUG:    1+ Set-PsDebug -Trace 2; foreach ($i in 1..3) {$i}
2
DEBUG:    1+ Set-PsDebug -Trace 2; foreach ($i in 1..3) {$i}
3
```

This command sets the trace level to 2, and then runs a script that displays the numbers 1, 2, and 3.

### Example 2: Turn on stepping
```
PS C:\> Set-PSDebug -Step; foreach ($i in 1..3) {$i}

DEBUG:    1+ Set-PsDebug -Step; foreach ($i in 1..3) {$i}
Continue with this operation?
1+ Set-PsDebug -Step; foreach ($i in 1..3) {$i}
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):a
DEBUG:    1+ Set-PsDebug -Step; foreach ($i in 1..3) {$i}
1
2
3
```

This command turns on stepping, and then runs a script that displays the numbers 1, 2, and 3.

### Example 3: Turn off debug features
```
PS C:\> Set-PSDebug -Off; foreach ($i in 1..3) {$i}
1
2
3
```

This command turns off all debugging features, and then runs a script that displays the numbers 1, 2, and 3.

### Example 4: Use strict mode
```
PS C:\> set-psdebug -Strict; $NewVar
The variable $NewVar cannot be retrieved because it has not been set yet.
At line:1 char:28
+ Set-PsDebug -strict;$NewVar <<<<
```

This command puts Windows PowerShell in strict mode, and then attempts to access a variable that has not yet been set.

## PARAMETERS

### -Off
Indicates that this cmdlet turns off all script debugging features.

A `Set-StrictMode -Off` command disables the verification set by a `Set-PSDebug -Strict` command.
For more information, see Set-StrictMode.

```yaml
Type: SwitchParameter
Parameter Sets: off
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Step
Indicates that this cmdlet turns on script stepping.
Before each line runs, Windows PowerShell prompts you to stop, continue, or enter a new interpreter level to inspect the state of the script.

Specifying the *Step* parameter automatically sets a trace level of 1.

```yaml
Type: SwitchParameter
Parameter Sets: on
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Strict
Indicates that Windows PowerShell returns an exception if a variable is referenced before a value is assigned to the variable.

A `Set-StrictMode -Off` command disables the verification set by a `Set-PSDebug -Strict` command.
For more information, see **Set-StrictMode**.

```yaml
Type: SwitchParameter
Parameter Sets: on
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Trace
Specifies the trace level.
The acceptable values for this parameter are:

- 1: Trace script lines as they run.
- 0: Turn script tracing off.
- 2: Trace script lines, variable assignments, function calls, and scripts.

```yaml
Type: Int32
Parameter Sets: on
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES

## RELATED LINKS

[Set-StrictMode](Set-StrictMode.md)