---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294033
schema: 2.0.0
---

# Write-Warning
## SYNOPSIS
Writes a warning message.

## SYNTAX

```
Write-Warning [-Message] <String>
```

## DESCRIPTION
The Write-Warning cmdlet writes a warning message to the Windows PowerShell host.
The response to the warning depends on the value of the user's $WarningPreference variable and the use of the WarningAction common parameter.

## EXAMPLES

### Example 1: Write a warning message
```
PS C:\>Write-Warning "This is only a test warning."
```

This command displays the message "WARNING: This is only a test warning."

### Example 2: Pass a string to Write-Warning
```
PS C:\>$w = "This is only a test warning."
PS C:\>$w | Write-Warning
```

This example shows that you can use a pipeline operator (|) to send a string to Write-Warning.
You can save the string in a variable, as shown in this command, or pipe the string directly to Write-Warning.

### Example 3: Set the $WarningPreference variable and write a warning
```
PS C:\>$warningpreference
Continue PS C:\>Write-Warning "This is only a test warning."
This is only a test warning. PS C:\>$warningpreference = "SilentlyContinue"
PS C:\>Write-Warning "This is only a test warning."
PS C:\>
PS C:\>$warningpreference = "Stop"
PS C:\>Write-Warning "This is only a test warning."
WARNING: This is only a test message. 
Write-Warning : Command execution stopped because the shell variable "WarningPreference" is set to Stop. 
At line:1 char:14
     + Write-Warning <<<<  "This is only a test message."
```

This example shows the effect of the value of the $WarningPreference variable on a Write-Warning command.

The first command displays the default value of the $WarningPreference variable, which is Continue.
As a result, when you write a warning, the warning message is displayed and execution continues.

When you change the value of the $WarningPreference variable, the effect of the Write-Warning command changes again.
A value of SilentlyContinue suppresses the warning.
A value of Stop displays the warning and then stops execution of the command.

For more information about the $WarningPreference variable, see about_Preference_Variables.

### Example 4: Set the WarningAction parameter and write a warning
```
PS C:\>Write-Warning "This is only a test warning." -WarningAction Inquire
WARNING: This is only a test warning. 
Confirm
Continue with this operation? 
 [Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help (default is "Y"):
```

This example shows the effect of the WarningAction common parameter on a Write-Warning command.
You can use the WarningAction common parameter with any cmdlet to determine how Windows PowerShell responds to warnings resulting from that command.
The WarningAction common parameter overrides the value of the $WarningPreference only for that particular command.

This command uses the Write-Warning cmdlet to display a warning.
The WarningAction common parameter with a value of Inquire directs the system to prompt the user when the command displays a warning.

For more information about the WarningAction common parameter, see about_CommonParameters.

## PARAMETERS

### -Message
Specifies the warning message.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Msg

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a string that contains the warning to Write-Warning.

## OUTPUTS

### None
Write-Warning writes only to the warning stream.
It does not generate any other output.

## NOTES
* The default value for the $WarningPreference variable is Continue, which displays the warning and then continues executing the command. To determine valid values for a preference variable such as $WarningPreference, set it to a string of random characters, such as "abc". The resulting error message will list the valid values.

*

## RELATED LINKS

[Write-Debug](fb95cfe7-8a21-4b6a-9e00-0205a6b74c41)

[Write-Error](eedfea70-5aa7-4d20-b87d-f8e1147b1b42)

[Write-EventLog](c93c4cd3-028f-4343-bfe6-b70f8f249290)

[Write-Host](023e670a-cfda-4e8c-af8f-c2b2d9ee5612)

[Write-Information](1d2d8f6a-8ef0-457b-9695-aef946994973)

[Write-Output](72e7f802-c08c-435e-88ad-b2b77faea1a7)

[Write-Progress](3e78a07f-87ae-4bc2-ac28-b0163831fd80)

[Write-Verbose](d17c2519-dae0-4142-a506-9acfb79b72e7)

[about_CommonParameters](aa31fbc6-792e-486b-99b1-264630079054)

[about_Preference_Variables](045a7fe7-cf63-4f89-8835-d01c9579d1c8)

