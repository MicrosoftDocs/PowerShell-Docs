---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Write Host
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821876
external help file:   Microsoft.PowerShell.Commands.Utility.dll-Help.xml
---


# Write-Host

## SYNOPSIS
Writes customized output to a host.

## SYNTAX

```
Write-Host [[-Object] <Object>] [-NoNewline] [-Separator <Object>] [-ForegroundColor <ConsoleColor>]
 [-BackgroundColor <ConsoleColor>] [<CommonParameters>]
```

## DESCRIPTION
The **Write-Host** cmdlet customizes output.
You can specify the color of text by using the *ForegroundColor* parameter, and you can specify the background color by using the *BackgroundColor* parameter.
The *Separator* parameter lets you specify a string to use to separate displayed objects.
The particular result depends on the program that is hosting Windows PowerShell.

## EXAMPLES

### Example 1: Write to the console without adding a new line
```
PS C:\> Write-Host "no newline test " -NoNewline
no newline test PS C:\>
```

This command displays the input to the console, but because of the *NoNewline* parameter, the output is followed directly by the prompt.

### Example 2: Write to the console and include a separator
```
PS C:\> Write-Host (2,4,6,8,10,12) -Separator ", +2= "
2, +2= 4, +2= 6, +2= 8, +2= 10, +2= 12
```

This command displays the even numbers from 2 through 12.
The *Separator* parameter is used to add the string ", +2= (comma, space, +, 2, =, space)".

### Example 3: Write with different text and background colors
```
PS C:\> Write-Host (2,4,6,8,10,12) -Separator ", -> " -ForegroundColor DarkGreen -BackgroundColor white
```

This command displays the even numbers from 2 through 12.
It uses the *ForegroundColor* parameter to output dark green text and the *BackgroundColor* parameter to display a white background.

### Example 4: Write with different text and background colors
```
PS C:\> Write-Host "Red on white text." -ForegroundColor red -BackgroundColor white
Red on white text.
```

This command displays the string "Red on white text." The text is red, as defined by the *ForegroundColor* parameter.
The background is white, as defined by the *BackgroundColor* parameter.

## PARAMETERS

### -BackgroundColor
Specifies the background color.
There is no default.
The acceptable values for this parameter are:

- Black
- DarkBlue
- DarkGreen
- DarkCyan
- DarkRed
- DarkMagenta
- DarkYellow
- Gray
- DarkGray
- Blue
- Green
- Cyan
- Red
- Magenta
- Yellow
- White

```yaml
Type: ConsoleColor
Parameter Sets: (All)
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForegroundColor
Specifies the text color.
There is no default.
The acceptable values for this parameter are:

- Black
- DarkBlue
- DarkGreen
- DarkCyan
- DarkRed
- DarkMagenta
- DarkYellow
- Gray
- DarkGray
- Blue
- Green
- Cyan
- Red
- Magenta
- Yellow
- White

```yaml
Type: ConsoleColor
Parameter Sets: (All)
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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
Accept pipeline input: False
Accept wildcard characters: False
```

### -Object
Specifies objects to display in the console.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Separator
Specifies a separator string to the output between objects displayed on the console.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object
You can pipe objects to be written to the host.

## OUTPUTS

### None
**Write-Host** sends the objects to the host.
It does not return any objects.
However, the host might display the objects that **Write-Host** sends to it.

## NOTES

## RELATED LINKS

[Clear-Host](../Microsoft.PowerShell.Core/Functions/Clear-Host.md)

[Write-Debug](Write-Debug.md)

[Write-Error](Write-Error.md)

[Write-Output](Write-Output.md)

[Write-Progress](Write-Progress.md)

[Write-Verbose](Write-Verbose.md)

[Write-Warning](Write-Warning.md)

