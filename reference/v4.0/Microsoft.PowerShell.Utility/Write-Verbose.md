---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Write Verbose
ms.technology:  powershell
external help file:  PSITPro4_Utility.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=294032
schema:  2.0.0
---


# Write-Verbose
## SYNOPSIS
Writes text to the verbose message stream.
## SYNTAX

```
Write-Verbose [-Message] <String> [<CommonParameters>]
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
Aliases: Msg

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
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

[Write-Error](Write-Error.md)

[Write-Warning](Write-Warning.md)

[about_Preference_Variables](../About/about_Preference_Variables.md)

