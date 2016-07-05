---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294032
schema: 2.0.0
---

# Write-Verbose
## SYNOPSIS
Writes text to the verbose message stream.

## SYNTAX

```
Write-Verbose [-Message] <String>
```

## DESCRIPTION
The Write-Verbose cmdlet writes text to the verbose message stream in Windows PowerShell.
Typically, the verbose message stream is used to deliver information about command processing that is used for debugging a command.

By default, the verbose message stream is not displayed, but you can display it by changing the value of the $VerbosePreference variable or using the Verbose common parameter in any command.

## EXAMPLES

### Example 1: Write a status message
```
PS C:\>Write-Verbose -Message "Searching the Application Event Log."
PS C:\>Write-Verbose -Message "Searching the Application Event Log." -Verbose
```

These commands use the Write-Verbose cmdlet to display a status message.
By default, the message is not displayed.

The second command uses the Verbose common parameter, which displays any verbose messages, regardless of the value of the $VerbosePreference variable.

### Example 2: Set $VerbosePreference and write a status message
```
PS C:\>$VerbosePreference = "Continue"
PS C:\>Write-Verbose "Copying file $filename"
```

These commands use the Write-Verbose cmdlet to display a status message.
By default, the message is not displayed.

The first command assigns a value of Continue to the $VerbosePreference preference variable.
The default value, SilentlyContinue, suppresses verbose messages.
The second command writes a verbose message.

## PARAMETERS

### -Message
Specifies the message to display.
This parameter is required.
You can also pipe a message string to Write-Verbose.

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
You can pipe a string that contains the message to Write-Verbose.

## OUTPUTS

### None
Write-Verbose writes only to the verbose message stream.

## NOTES
* Verbose messages are returned only when the command uses the Verbose common parameter. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
* In Windows PowerShell background jobs and remote commands, the $VerbosePreference variable in the job session and remote session determine whether the verbose message is displayed by default. For more information about the $VerbosePreference variable, see about_Preference_Variables (http://go.microsoft.com/fwlink/?LinkID=113248).

## RELATED LINKS

[about_Preference_Variables](045a7fe7-cf63-4f89-8835-d01c9579d1c8)

[Write-Debug](fb95cfe7-8a21-4b6a-9e00-0205a6b74c41)

[Write-Error](eedfea70-5aa7-4d20-b87d-f8e1147b1b42)

[Write-EventLog](c93c4cd3-028f-4343-bfe6-b70f8f249290)

[Write-Host](023e670a-cfda-4e8c-af8f-c2b2d9ee5612)

[Write-Information](1d2d8f6a-8ef0-457b-9695-aef946994973)

[Write-Output](72e7f802-c08c-435e-88ad-b2b77faea1a7)

[Write-Progress](3e78a07f-87ae-4bc2-ac28-b0163831fd80)

[Write-Warning](8e53946e-1762-40e6-ab70-5307f6fc2a98)

