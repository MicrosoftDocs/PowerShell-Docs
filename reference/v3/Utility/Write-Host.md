---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Write-Host
## SYNOPSIS
Writes customized output to a host.

## SYNTAX

```
Write-Host [[-Object] <Object>] [-BackgroundColor <ConsoleColor>] [-ForegroundColor <ConsoleColor>]
 [-NoNewline] [-Separator <Object>]
```

## DESCRIPTION
The Write-Host cmdlet customizes output.
You can specify the color of text by using the ForegroundColor parameter, and you can specify the background color by using the BackgroundColor parameter.
The Separator parameter lets you specify a string to use to separate displayed objects.
The particular result depends on the program that is hosting Windows PowerShell.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>write-host "no newline test " -nonewline
no newline test PS C:\>
```

This command displays the input to the console, but because of the NoNewline parameter, the output is followed directly by the prompt.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>write-host (2,4,6,8,10,12) -Separator ", +2= "
2, +2= 4, +2= 6, +2= 8, +2= 10, +2= 12
```

This command displays the even numbers from 2 through 12.
The Separator parameter is used to add the string , +2= \(comma, space, +, 2, =, space\).

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>write-host (2,4,6,8,10,12) -Separator ", -> " -foregroundcolor DarkGreen -backgroundcolor white
```

This command displays the even numbers from 2 through 12.
It uses the ForegroundColor parameter to output dark green text and the BackgroundColor parameter to display a white background.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>write-host "Red on white text." -ForegroundColor red -BackgroundColor white
Red on white text.
```

This command displays the string "Red on white text." The text is red, as defined by the ForegroundColor parameter.
The background is white, as defined by the BackgroundColor parameter.

## PARAMETERS

### -BackgroundColor
Specifies the background color.
There is no default.

```yaml
Type: ConsoleColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: false
Accept wildcard characters: False
```

### -ForegroundColor
Specifies the text color.
There is no default.

```yaml
Type: ConsoleColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: false
Accept wildcard characters: False
```

### -NoNewline
Specifies that the content displayed in the console does not end with a newline character.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: false
Accept wildcard characters: False
```

### -Object
Objects to display in the console.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: true (ByValue)
Accept wildcard characters: False
```

### -Separator
String to the output between objects displayed on the console.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### System.Object
You can pipe objects to be written to the host.

## OUTPUTS

### None
Write-Host sends the objects to the host.
It does not return any objects.
However, the host might display the objects that Write-Host sends to it.

## NOTES

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113426)

[Clear-Host](http://go.microsoft.com/fwlink/?LinkID=225747)

[Out-Host](00000000-0000-0000-0000-000000000000)

[Write-Debug](fb95cfe7-8a21-4b6a-9e00-0205a6b74c41)

[Write-Error](eedfea70-5aa7-4d20-b87d-f8e1147b1b42)

[Write-Output](72e7f802-c08c-435e-88ad-b2b77faea1a7)

[Write-Progress](3e78a07f-87ae-4bc2-ac28-b0163831fd80)

[Write-Verbose](d17c2519-dae0-4142-a506-9acfb79b72e7)

[Write-Warning](8e53946e-1762-40e6-ab70-5307f6fc2a98)


