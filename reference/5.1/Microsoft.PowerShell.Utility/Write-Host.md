---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 11/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821876
schema: 2.0.0
title: Write-Host
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

The `Write-Host` cmdlet customizes output.
You can specify the color of text by using the `ForegroundColor` parameter, and you can specify the background color by using the `BackgroundColor` parameter.
The Separator parameter lets you specify a string to use to separate displayed objects.
The particular result depends on the program that is hosting PowerShell.

> [!NOTE]
> Starting in Windows PowerShell 5.0, `Write-Host` is a wrapper for `Write-Information`
> This allows you to use `Write-Host` to emit output to the information stream.
> This enables the **capture** or **suppression** of data written using `Write-Host` while preserving backwards compatibility.
>
> The `$InformationPreference` preference variable and `InformationAction` common parameter do not affect `Write-Host` messages.
> The exception to this rule is `-InformationAction Ignore`, which effectively suppresses `Write-Host` output. (see "Example 5")

## EXAMPLES

### Example 1: Write to the console without adding a new line

```powershell
Write-Host "no newline test " -NoNewline
Write-Host "second string"
```

```output
no newline test second string
```

This command displays the string 'no newline test' with the `NoNewline` parameter.

A second string is written, but it ends up on the same line as the first due to the absence of a newline separating the strings.

### Example 2: Write to the console and include a separator

```powershell
Write-Host (2,4,6,8,10,12) -Separator ", +2= "
```

```output
2, +2= 4, +2= 6, +2= 8, +2= 10, +2= 12
```

This command displays the even numbers from two through twelve.
The Separator parameter is used to add the string `, +2= (comma, space, +, 2, =, space)`.

### Example 3: Write with different text and background colors

```powershell
Write-Host (2,4,6,8,10,12) -Separator ", -> " -ForegroundColor DarkGreen -BackgroundColor White
```

```output
2, -> 4, -> 6, -> 8, -> 10, -> 12
```

This command displays the even numbers from two through twelve.
It uses the `ForegroundColor` parameter to output 'dark green' text and the `BackgroundColor` parameter to display a 'white' background.

### Example 4: Write with different text and background colors

```powershell
Write-Host "Red on white text." -ForegroundColor red -BackgroundColor white
```

```output
Red on white text.
```

This command displays the string "Red on white text." The text is 'red', as defined by the `ForegroundColor` parameter.
The background is 'white', as defined by the `BackgroundColor` parameter.

### Example 5: Suppress output from Write-Host

```powershell
# The following two statements can be used to effectively suppress output from Write-Host
Write-Host "I won't print" -InformationAction Ignore
Write-Host "I won't print" 6>$null
```

```output

```

This command displays the string "Red on white text." The text is 'red', as defined by the `ForegroundColor` parameter.
The background is 'white', as defined by the `BackgroundColor` parameter.

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

The string representations of the input objects are concatenated to form the output.
No spaces or newlines are inserted between the output strings.
No newline is added after the last output string.

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

Objects to display in the host.

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

Specifies a separator string to insert between objects displayed by the host.

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

`Write-Host` sends the objects to the host.
It does not return any objects.
However, the host might display the objects that `Write-Host` sends to it.

## NOTES

## RELATED LINKS

[Clear-Host](../Microsoft.PowerShell.Core/Functions/Clear-Host.md)

[Out-Host](../Microsoft.PowerShell.Core/Out-Host.md)

[Write-Debug](Write-Debug.md)

[Write-Error](Write-Error.md)

[Write-Output](Write-Output.md)

[Write-Progress](Write-Progress.md)

[Write-Verbose](Write-Verbose.md)

[Write-Warning](Write-Warning.md)