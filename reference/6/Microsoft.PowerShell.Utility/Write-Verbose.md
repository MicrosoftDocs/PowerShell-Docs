---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821880
schema: 2.0.0
title: Write-Verbose
---

# Write-Verbose

## SYNOPSIS
Writes text to the verbose message stream.

## SYNTAX

```
Write-Verbose [-Message] <String> [<CommonParameters>]
```

## DESCRIPTION
The **Write-Verbose** cmdlet writes text to the verbose message stream in PowerShell.
Typically, the verbose message stream is used to deliver information about command processing that is used for debugging a command.

By default, the verbose message stream is not displayed, but you can display it by changing the value of the **$VerbosePreference** variable or using the **Verbose** common parameter in any command.

## EXAMPLES

### Example 1: Write a status message
```
PS C:\> Write-Verbose -Message "Searching the Application Event Log."
PS C:\> Write-Verbose -Message "Searching the Application Event Log." -Verbose
```

These commands use the **Write-Verbose** cmdlet to display a status message.
By default, the message is not displayed.

The second command uses the *Verbose* common parameter, which displays any verbose messages, regardless of the value of the **$VerbosePreference** variable.

### Example 2: Set $VerbosePreference and write a status message
```
PS C:\> $VerbosePreference = "Continue"
PS C:\> Write-Verbose "Copying file $filename"
```

These commands use the **Write-Verbose** cmdlet to display a status message.
By default, the message is not displayed.

The first command assigns a value of Continue to the $VerbosePreference preference variable.
The default value, SilentlyContinue, suppresses verbose messages.
The second command writes a verbose message.

## PARAMETERS

### -Message
Specifies the message to display.
This parameter is required.
You can also pipe a message string to **Write-Verbose**.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Msg

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.String
You can pipe a string that contains the message to **Write-Verbose**.

## OUTPUTS

### None
**Write-Verbose** writes only to the verbose message stream.

## NOTES
* Verbose messages are returned only when the command uses the **Verbose** common parameter. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).
* In PowerShell background jobs and remote commands, the **$VerbosePreference** variable in the job session and remote session determine whether the verbose message is displayed by default. For more information about the **$VerbosePreference** variable, see [about_Preference_Variables](../Microsoft.PowerShell.Core/About/about_Preference_Variables.md).

## RELATED LINKS

[Write-Debug](Write-Debug.md)

[Write-Error](Write-Error.md)

[Write-Host](Write-Host.md)

[Write-Information](Write-Information.md)

[Write-Output](Write-Output.md)

[Write-Progress](Write-Progress.md)

[Write-Warning](Write-Warning.md)
