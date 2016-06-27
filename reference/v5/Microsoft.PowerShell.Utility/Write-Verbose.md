---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294032
schema: 2.0.0
---

# Write-Verbose
## SYNOPSIS
Writes text to the verbose message stream.

## SYNTAX

```
Write-Verbose [-Message] <String> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
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
Verbose messages are returned only when the command uses the Verbose common parameter.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

In Windows PowerShell background jobs and remote commands, the $VerbosePreference variable in the job session and remote session determine whether the verbose message is displayed by default.
For more information about the $VerbosePreference variable, see about_Preference_Variables (http://go.microsoft.com/fwlink/?LinkID=113248).

## RELATED LINKS

[Write-Error]()

[Write-Warning]()

[about_Preference_Variables]()

