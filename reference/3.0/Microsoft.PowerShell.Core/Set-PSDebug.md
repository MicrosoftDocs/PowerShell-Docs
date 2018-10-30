---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113398
external help file:  System.Management.Automation.dll-Help.xml
title:  Set-PSDebug
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

The Set-PSDebug cmdlet turns script debugging features on and off, sets the trace level, and toggles strict mode.

When the Trace parameter is set to 1, each line of script is traced as it is executed.
When the parameter is set to 2, variable assignments, function calls, and script calls are also traced.
If the Step parameter is specified, you are prompted before each line of the script is executed.

## EXAMPLES

### Example 1

```
PS> set-psdebug -trace 2; foreach ($i in 1..3) {$i}

DEBUG:    1+ Set-PsDebug -trace 2; foreach ($i in 1..3) {$i}
DEBUG:    1+ Set-PsDebug -trace 2; foreach ($i in 1..3) {$i}
1
DEBUG:    1+ Set-PsDebug -trace 2; foreach ($i in 1..3) {$i}
2
DEBUG:    1+ Set-PsDebug -trace 2; foreach ($i in 1..3) {$i}
3
```

This command sets the trace level to 2, and then runs a script that displays the numbers 1, 2, and 3.

### Example 2

```
PS> set-psdebug -step; foreach ($i in 1..3) {$i}

DEBUG:    1+ Set-PsDebug -step; foreach ($i in 1..3) {$i}
Continue with this operation?
1+ Set-PsDebug -step; foreach ($i in 1..3) {$i}
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):a
DEBUG:    1+ Set-PsDebug -step; foreach ($i in 1..3) {$i}
1
2
3
```

This command turns on stepping and then

runs a script that displays the numbers 1, 2, and 3.

### Example 3

```
PS> set-psdebug -off; foreach ($i in 1..3) {$i}
1
2
3
```

This command turns off all debugging features, and then runs a script that displays the numbers 1, 2, and 3.

### Example 4

```
PS> set-psdebug -strict; $NewVar
The variable $NewVar cannot be retrieved because it has not been set yet.
At line:1 char:28
+ Set-PsDebug -strict;$NewVar <<<<
```

This command puts the interpreter in strict mode, and attempts to access a variable that has not yet been set.

## PARAMETERS

### -Off

Turns off all script debugging features.

Note: A "set-strictmode -off" command disables the verification set by a "set-psdebug -strict" command.
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

Turns on script stepping.
Before each line is run, the user is prompted to stop, continue, or enter a new interpreter level to inspect the state of the script.

Note: Specifying the Step parameter automatically sets a Trace level of 1.

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

Specifies that the interpreter should throw an exception if a variable is referenced before a value is assigned to the variable.

Note: A "set-strictmode -off" command disables the verification set by a "set-psdebug -strict" command.
For more information, see Set-StrictMode.

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

Specifies the trace level:

0 - Turn script tracing off

1 - Trace script lines as they are executed

2 - Trace script lines, variable assignments, function calls, and scripts.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

## RELATED LINKS

[Debug-Process](../Microsoft.PowerShell.Management/Debug-Process.md)

[Set-PSBreakpoint](../microsoft.powershell.utility/set-psbreakpoint.md)

[Set-StrictMode](Set-StrictMode.md)

[Write-Debug](../microsoft.powershell.utility/write-debug.md)

[about_Debuggers](About/about_Debuggers.md)