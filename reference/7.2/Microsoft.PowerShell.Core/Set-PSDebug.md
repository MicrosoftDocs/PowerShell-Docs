---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 08/22/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/set-psdebug?view=powershell-7.2&WT.mc_id=ps-gethelp
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

The `Set-PSDebug` cmdlet turns script debugging features on and off, sets the trace level, and
toggles strict mode. By default, the PowerShell debug features are off.

When the **Trace** parameter has a value of `1`, each line of script is traced as it runs. When the
parameter has a value of `2`, variable assignments, function calls, and script calls are also
traced. If the **Step** parameter is specified, you're prompted before each line of the script runs.

## EXAMPLES

### Example 1: Set the trace level

This example sets the trace level to `2`, and then runs a script that displays the numbers 1, 2, and
3.

```powershell
Set-PSDebug -Trace 2; foreach ($i in 1..3) {$i}
```

```Output
DEBUG:    1+ Set-PSDebug -Trace 2; foreach ($i in  >>>> 1..3) {$i}
DEBUG:     ! SET $foreach = 'IEnumerator'.
DEBUG:    1+ Set-PSDebug -Trace 2; foreach ( >>>> $i in 1..3) {$i}
DEBUG:     ! SET $i = '1'.
DEBUG:    1+ Set-PSDebug -Trace 2; foreach ($i in 1..3) { >>>> $i}
1
DEBUG:    1+ Set-PSDebug -Trace 2; foreach ( >>>> $i in 1..3) {$i}
DEBUG:     ! SET $i = '2'.
DEBUG:    1+ Set-PSDebug -Trace 2; foreach ($i in 1..3) { >>>> $i}
2
DEBUG:    1+ Set-PSDebug -Trace 2; foreach ( >>>> $i in 1..3) {$i}
DEBUG:     ! SET $i = '3'.
DEBUG:    1+ Set-PSDebug -Trace 2; foreach ($i in 1..3) { >>>> $i}
3
DEBUG:    1+ Set-PSDebug -Trace 2; foreach ( >>>> $i in 1..3) {$i}
DEBUG:     ! SET $foreach = ''.
```

### Example 2: Turn on stepping

This example turns on stepping, and then runs a script that displays the numbers 1, 2, and 3.

```powershell
Set-PSDebug -Step; foreach ($i in 1..3) {$i}
```

```Output
Continue with this operation?
   1+ Set-PSDebug -Step; foreach ($i in  >>>> 1..3) {$i}
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): A
DEBUG:    1+ Set-PSDebug -Step; foreach ($i in  >>>> 1..3) {$i}
1
2
3
```

### Example 3: Use strict mode

This example puts PowerShell in strict mode and attempts to access a variable that doesn't have an
assigned value.

```powershell
Set-PSDebug -Strict; $NewVar
```

```Output
The variable '$NewVar' cannot be retrieved because it has not been set.
At line:1 char:22
+ Set-PSDebug -Strict; $NewVar
```

### Example 4: Turn off debug features

This example turns off all debugging features, and then runs a script that displays the numbers 1,
2, and 3.

```powershell
Set-PSDebug -Off; foreach ($i in 1..3) {$i}
```

```Output
1
2
3
```

## PARAMETERS

### -Off

Turns off all script debugging features.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: off
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Step

Turns on script stepping. Before each line runs, PowerShell prompts you to stop, continue, or enter
a new interpreter level to inspect the state of the script.

Specifying the **Step** parameter automatically sets a trace level of `1`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: on
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Strict

Specifies that variables must be assigned a value before being referenced in a script. If a variable
is referenced before a value is assigned, PowerShell returns an exception error. This is equivalent
to `Set-StrictMode -Version 1`. For more information, see [Set-StrictMode](Set-StrictMode.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: on
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Trace

Specifies the trace level for each line in a script. Each line is traced as it's run.

The acceptable values for this parameter are as follows:

- 0: Turn script tracing off.
- 1: Trace script lines as they run.
- 2: Trace script lines, variable assignments, function calls, and scripts.

```yaml
Type: System.Int32
Parameter Sets: on
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipeline input to this cmdlet.

## OUTPUTS

### None

This cmdlet doesn't return any output.

## NOTES

## RELATED LINKS

[about_Debuggers](./About/about_Debuggers.md)

[Debug-Process](../Microsoft.PowerShell.Management/Debug-Process.md)

[Set-PSBreakpoint](../Microsoft.PowerShell.Utility/Set-PSBreakpoint.md)

[Set-StrictMode](Set-StrictMode.md)

[Write-Debug](../Microsoft.PowerShell.Utility/Write-Debug.md)

