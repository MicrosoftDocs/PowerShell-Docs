---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/14/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/write-debug?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Write-Debug
---
# Write-Debug

## SYNOPSIS
Writes a debug message to the console.

## SYNTAX

```
Write-Debug [-Message] <String> [<CommonParameters>]
```

## DESCRIPTION

The `Write-Debug` cmdlet writes debug messages to the host from a script or command.

By default, debug messages are not displayed in the console, but you can display them by using the
**Debug** parameter or the `$DebugPreference` variable.

## EXAMPLES

### Example 1: Understand $DebugPreference

This example writes a debug message.

```powershell
Write-Debug "Cannot open file."
```

The default value of `$DebugPreference` is **SilentlyContinue**. Therefore, the message is not
displayed in the console.

### Example 2: Change the value of $DebugPreference

This example shows the effect of changing the value of the `$DebugPreference` variable. First, we
display the current value of `$DebugPreference` and attempt to write a debug message. Then we change
the value of `$DebugPreference` to **Continue**, which allows debug messages to be displayed.

```
PS> $DebugPreference
SilentlyContinue
PS> Write-Debug "Cannot open file."
PS>
PS> $DebugPreference = "Continue"
PS> Write-Debug "Cannot open file."
DEBUG: Cannot open file.
```

For more information about `$DebugPreference`, see
[about_Preference_Variables](/powershell/module/Microsoft.PowerShell.Core/About/about_Preference_Variables).

### Example 3: Use the Debug parameter to override $DebugPreference

The `Test-Debug` function writes the value of the `$DebugPreference` variable to the PowerShell host
and to the Debug stream. In this example, we use the **Debug** parameter to override the
`$DebugPreference` value.

```powershell
function Test-Debug {
    [CmdletBinding()]
    param()
    Write-Debug ('$DebugPreference is ' + $DebugPreference)
    Write-Host ('$DebugPreference is ' + $DebugPreference)
}
```

```
PS> Test-Debug
$DebugPreference is SilentlyContinue

PS> Test-Debug -Debug
DEBUG: $DebugPreference is Continue
$DebugPreference is Continue
PS> $DebugPreference
SilentlyContinue
```

Notice that the value of `$DebugPreference` changes when you use the **Debug** parameter. This
change only affects the scope of the function. The value is not affected outside the function.

For more information about the **Debug** common parameter, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## PARAMETERS

### -Message

Specifies the debug message to send to the console.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Msg

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a debug message to `Write-Debug`.

## OUTPUTS

### None

`Write-Debug` only writes to the debug stream. It does not write any objects to the pipeline.

## NOTES

## RELATED LINKS

[about_Output_Streams](../Microsoft.PowerShell.Core/About/about_Output_Streams.md)

[about_Redirection](../Microsoft.PowerShell.Core/About/about_Redirection.md)

[Write-Error](Write-Error.md)

[Write-Host](Write-Host.md)

[Write-Output](Write-Output.md)

[Write-Progress](Write-Progress.md)

[Write-Verbose](Write-Verbose.md)

[Write-Warning](Write-Warning.md)
