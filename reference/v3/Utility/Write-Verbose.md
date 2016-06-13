---
external help file: PSITPro3_Utility.xml
online version: http://go.microsoft.com/fwlink/?LinkID=113429
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

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Write-Verbose -Message "Searching the Application Event Log."
PS C:\>Write-Verbose -Message "Searching the Application Event Log." -verbose
```

These commands use the Write-Verbose cmdlet to display a status message.
By default, the message is not displayed.

The second command uses the Verbose common parameter, which displays any verbose messages, regardless of the value of the $VerbosePreference variable.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$VerbosePreference = "Continue"
PS C:\>Write-Verbose "Copying file $filename"
```

These commands use the Write-Verbose cmdlet to display a status message.
By default, the message is not displayed.

The first command assigns a value of "Continue" to the $VerbosePreference preference variable.
The default value, "SilentlyContinue", suppresses verbose messages.
The second command writes a verbose message.

## PARAMETERS

### -Message
Specifies the message to display.
This parameter is required.
You can also pipe a message string to Write-Verbose.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
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
Verbose messages are returned only when the command uses the Verbose common parameter.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

In Windows PowerShell background jobs and remote commands, the $VerbosePreference variable in the job session and remote session determine whether the verbose message is displayed by default.
For more information about the $VerbosePreference variable, see about_Preference_Variables (http://go.microsoft.com/fwlink/?LinkID=113248).

## RELATED LINKS

[Write-Error](eedfea70-5aa7-4d20-b87d-f8e1147b1b42)

[Write-Warning](8e53946e-1762-40e6-ab70-5307f6fc2a98)

[about_Preference_Variables](045a7fe7-cf63-4f89-8835-d01c9579d1c8)

