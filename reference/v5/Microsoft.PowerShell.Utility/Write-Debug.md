---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294027
schema: 2.0.0
---

# Write-Debug
## SYNOPSIS
Writes a debug message to the console.

## SYNTAX

```
Write-Debug [-Message] <String> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Write-Debug cmdlet writes debug messages to the console from a script or command.

By default, debug messages are not displayed in the console, but you can display them by using the Debug parameter or the $DebugPreference variable.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Write-Debug "Cannot open file."
```

This command writes a debug message.
Because the value of $DebugPreference is "SilentlyContinue", the message is not displayed in the console.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$DebugPreference
SilentlyContinue
PS C:\>Write-Debug "Cannot open file."
PS C:\>
PS C:\>Write-Debug "Cannot open file." -debug
DEBUG: Cannot open file.
```

This example shows how to use the Debug common parameter to override the value of the $DebugPreference variable for a particular command.

The first command displays the value of the $DebugPreference variable, which is "SilentlyContinue", the default.

The second command writes a debug message but, because of the value of $DebugPreference, the message does not appear.

The third command writes a debug message.
It uses the Debug common parameter to override the value of $DebugPreference and to display the debug messages resulting from this command.

As a result, even though the value of $DebugPreference is "SilentlyContinue", the debug message appears.

For more information about the Debug common parameter, see about_CommonParameters.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$DebugPreference
SilentlyContinue
PS C:\>Write-Debug "Cannot open file."
PS C:\>
PS C:\>$DebugPreference = "Continue"
PS C:\>Write-Debug "Cannot open file."
DEBUG: Cannot open file.
```

This command shows the effect of changing the value of the $DebugPreference variable on the display of debug messages.

The first command displays the value of the $DebugPreference variable, which is "SilentlyContinue", the default.

The second command writes a debug message but, because of the value of $DebugPreference, the message does not appear.

The third command assigns a value of "Continue" to the $DebugPreference variable.

The fourth command writes a debug message, which appears on the console.

For more information about $DebugPreference, see about_Preference_Variables.

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
Specifies the debug message to send to the console.

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
You can pipe a string that contains a debug message to Write-Debug.

## OUTPUTS

### None
Write-Debug writes only to the debug stream.
It does not return any output.

## NOTES

## RELATED LINKS

[Write-Error]()

[Write-Host]()

[Write-Output]()

[Write-Progress]()

[Write-Verbose]()

[Write-Warning]()

