---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/14/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/write-warning?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Write-Warning
---

# Write-Warning

## SYNOPSIS
Writes a warning message.

## SYNTAX

```
Write-Warning [-Message] <String> [<CommonParameters>]
```

## DESCRIPTION

The `Write-Warning` cmdlet writes a warning message to the PowerShell host. The response to the
warning depends on the value of the user's `$WarningPreference` variable and the use of the
**WarningAction** common parameter.

## EXAMPLES

### Example 1: Write a warning message

This command displays the message "WARNING: This is only a test warning."

```powershell
Write-Warning "This is only a test warning."
```

### Example 2: Pass a string to Write-Warning

This command shows that you can use a pipeline operator (`|`) to send a string to `Write-Warning`.
You can save the string in a variable, as shown in this command, or pipe the string directly to
`Write-Warning`.

```powershell
$w = "This is only a test warning."
$w | Write-Warning
```

### Example 3: Set the $WarningPreference variable and write a warning

This example shows the effect of the value of the `$WarningPreference` variable on a `Write-Warning`
command.

```powershell
PS> $WarningPreference
Continue
PS> Write-Warning "This is only a test warning."
This is only a test warning.
PS> $WarningPreference = "SilentlyContinue"
PS> Write-Warning "This is only a test warning."
PS> $WarningPreference = "Stop"
PS> Write-Warning "This is only a test warning."
WARNING: This is only a test message.
Write-Warning : Command execution stopped because the shell variable "WarningPreference" is set to Stop.
At line:1 char:14
     + Write-Warning <<<<  "This is only a test message."
```

The first command displays the default value of the `$WarningPreference` variable, which is
`Continue`. As a result, when you write a warning, the warning message is displayed and execution
continues.

When you change the value of the `$WarningPreference` variable, the effect of the `Write-Warning`
command changes again. A value of `SilentlyContinue` suppresses the warning. A value of `Stop`
displays the warning and then stops execution of the command.

For more information about the `$WarningPreference` variable, see
[about_Preference_Variables](../Microsoft.Powershell.Core/About/about_Preference_Variables.md).

### Example 4: Set the WarningAction parameter and write a warning

This example shows the effect of the **WarningAction** common parameter on a `Write-Warning`
command. You can use the **WarningAction** common parameter with any cmdlet to determine how
PowerShell responds to warnings resulting from that command. The **WarningAction** common parameter
overrides the value of the `$WarningPreference` only for that particular command.

```powershell
PS> Write-Warning "This is only a test warning." -WarningAction Inquire
WARNING: This is only a test warning.
Confirm
Continue with this operation?
 [Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help (default is "Y"):
```

This command uses the `Write-Warning` cmdlet to display a warning. The **WarningAction** common
parameter with a value of Inquire directs the system to prompt the user when the command displays a
warning.

For more information about the **WarningAction** common parameter, see
[about_CommonParameters](../Microsoft.Powershell.Core/About/about_CommonParameters.md).

## PARAMETERS

### -Message
Specifies the warning message.

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

You can pipe a string that contains the warning to `Write-Warning`.

## OUTPUTS

### None

`Write-Warning` writes only to the warning stream. It does not generate any other output.

## NOTES

The default value for the `$WarningPreference` variable is `Continue`, which displays the warning
and then continues executing the command. To determine valid values for a preference variable such
as `$WarningPreference`, set it to a string of random characters, such as "abc". The resulting error
message lists the valid values.

## RELATED LINKS

[about_Output_Streams](../Microsoft.PowerShell.Core/About/about_Output_Streams.md)

[about_Redirection](../Microsoft.PowerShell.Core/About/about_Redirection.md)

[Write-Debug](Write-Debug.md)

[Write-Error](Write-Error.md)

[Write-Host](Write-Host.md)

[Write-Information](Write-Information.md)

[Write-Output](Write-Output.md)

[Write-Progress](Write-Progress.md)

[Write-Verbose](Write-Verbose.md)
