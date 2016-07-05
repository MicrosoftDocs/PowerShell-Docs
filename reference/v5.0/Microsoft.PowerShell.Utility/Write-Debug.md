---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294027
schema: 2.0.0
---

# Write-Debug
## SYNOPSIS
Writes a debug message to the console.

## SYNTAX

```
Write-Debug [-Message] <String>
```

## DESCRIPTION
The Write-Debug cmdlet writes debug messages to the console from a script or command.

By default, debug messages are not displayed in the console, but you can display them by using the Debug parameter or the $DebugPreference variable.

## EXAMPLES

### Example 1: Understand $DebugPreference
```
PS C:\> Write-Debug "Cannot open file."
```

This command writes a debug message.
Because the value of $DebugPreference is SilentlyContinue, the message is not displayed in the console.

### Example 2: Use the Debug parameter to override $DebugPreference
```
PS C:\> $DebugPreference
SilentlyContinue PS C:\> Write-Debug "Cannot open file."
PS C:\>
PS C:\> Write-Debug "Cannot open file." -Debug
DEBUG: Cannot open file.
```

This example shows how to use the Debug common parameter to override the value of the $DebugPreference variable for a particular command.

The first command displays the value of the $DebugPreference variable, which is SilentlyContinue, the default.

The second command writes a debug message but, because of the value of $DebugPreference, the message does not appear.

The third command writes a debug message.
It uses the Debug common parameter to override the value of $DebugPreference and to display the debug messages resulting from this command.

As a result, even though the value of $DebugPreference is SilentlyContinue, the debug message appears.

For more information about the Debug common parameter, see about_CommonParameters.

### Example 3: Change the value of $DebugPreference
```
PS C:\>$DebugPreference
SilentlyContinue PS C:\> Write-Debug "Cannot open file." 
PS C:\>
PS C:\> $DebugPreference = "Continue"
PS C:\> Write-Debug "Cannot open file."
DEBUG: Cannot open file.
```

This command shows the effect of changing the value of the $DebugPreference variable on the display of debug messages.

The first command displays the value of the $DebugPreference variable, which is SilentlyContinue, the default.

The second command writes a debug message but, because of the value of $DebugPreference, the message does not appear.

The third command assigns a value of Continue to the $DebugPreference variable.

The fourth command writes a debug message, which appears on the console.

For more information about $DebugPreference, see about_Preference_Variables.

## PARAMETERS

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

[Write-Error](eedfea70-5aa7-4d20-b87d-f8e1147b1b42)

[Write-Host](023e670a-cfda-4e8c-af8f-c2b2d9ee5612)

[Write-Output](72e7f802-c08c-435e-88ad-b2b77faea1a7)

[Write-Progress](3e78a07f-87ae-4bc2-ac28-b0163831fd80)

[Write-Verbose](d17c2519-dae0-4142-a506-9acfb79b72e7)

[Write-Warning](8e53946e-1762-40e6-ab70-5307f6fc2a98)

