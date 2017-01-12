---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Set PSReadlineOption
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821453
external help file:   Microsoft.PowerShell.PSReadLine.dll-Help.xml
---


# Set-PSReadlineOption

## SYNOPSIS
Customizes the behavior of command line editing in PSReadline.

## SYNTAX

### OptionsSet
```
Set-PSReadlineOption [-EditMode <EditMode>] [-ContinuationPrompt <String>]
 [-ContinuationPromptForegroundColor <ConsoleColor>] [-ContinuationPromptBackgroundColor <ConsoleColor>]
 [-EmphasisForegroundColor <ConsoleColor>] [-EmphasisBackgroundColor <ConsoleColor>]
 [-ErrorForegroundColor <ConsoleColor>] [-ErrorBackgroundColor <ConsoleColor>] [-HistoryNoDuplicates]
 [-AddToHistoryHandler <System.Func`2[System.String,System.Boolean]>]
 [-CommandValidationHandler <System.Action`1[System.Management.Automation.Language.CommandAst]>]
 [-HistorySearchCursorMovesToEnd] [-MaximumHistoryCount <Int32>] [-MaximumKillRingCount <Int32>]
 [-ResetTokenColors] [-ShowToolTips] [-ExtraPromptLineCount <Int32>] [-DingTone <Int32>]
 [-DingDuration <Int32>] [-BellStyle <BellStyle>] [-CompletionQueryItems <Int32>] [-WordDelimiters <String>]
 [-HistorySearchCaseSensitive] [-HistorySaveStyle <HistorySaveStyle>] [-HistorySavePath <String>]
 [-ViModeIndicator <ViModeStyle>] [<CommonParameters>]
```

### ColorSet
```
Set-PSReadlineOption [-TokenKind] <TokenClassification> [[-ForegroundColor] <ConsoleColor>]
 [[-BackgroundColor] <ConsoleColor>] [<CommonParameters>]
```

## DESCRIPTION
The **Set-PSReadlineOption** cmdlet customizes the behavior of the PSReadline module when you are editing the command line.

## EXAMPLES

### Example 1: Set values for Comment type
```
PS C:\> Set-PSReadlineOption -TokenKind Comment -ForegroundColor Green -BackgroundColor Gray
```

This command sets tokens of the type Comment to be displayed in PSReadline in green text on a gray background.

### Example 2: Set bell style
```
PS C:\> Set-PSReadlineOption -BellStyle Audible -DingTone 1221 -DingDuration 60
```

This cmdlet instructs PSReadline to respond to errors and other conditions that require user input by emitting an audible beep or sound at 1221 Hz for 60 ms.

## PARAMETERS

### -AddToHistoryHandler
Specifies a **ScriptBlock** that controls which commands get added to PSReadline history.

```yaml
Type: System.Func`2[System.String,System.Boolean]
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackgroundColor
Specifies the background color for the token kind that is specified by the *TokenKind* parameter.

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
Parameter Sets: ColorSet
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BellStyle
Specifies how PSReadLine responds to various error conditions or user prompts.
If you do not specify this parameter, the default response is Audible.
The acceptable values for this parameter are:

- None.
No feedback. 
- Visual.
Text flashes briefly. 
- Audible.
A short beep.

```yaml
Type: BellStyle
Parameter Sets: OptionsSet
Aliases: 
Accepted values: None, Visual, Audible

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommandValidationHandler
Specifies a **ScriptBlock** that is called from **ValidateAndAcceptLine**.
If an exception is thrown, validation fails and the error is reported.
Before throwing an exception, the validation handler can place the cursor at the point of the error to make it easier to fix.
A validation handler can also change the command line, such as to correct common typographical errors.

```yaml
Type: System.Action`1[System.Management.Automation.Language.CommandAst]
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompletionQueryItems
Specifies the maximum number of completion items that are shown without prompting.
If the number of items to show is greater than this value, PSReadline prompts you to specify yes or no (y/n) before it displays the completion items.
The default maximum number is 100.

```yaml
Type: Int32
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContinuationPrompt
Specifies the string displayed at the start of the second and subsequent lines when multi-line input is being entered.
The default value is '\>\>\>'.
The empty string is valid.

```yaml
Type: String
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContinuationPromptBackgroundColor
Specifies the background color of the continuation prompt.

The acceptable values for this parameter are: the same values as for the *BackgroundColor* parameter.

```yaml
Type: ConsoleColor
Parameter Sets: OptionsSet
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContinuationPromptForegroundColor
Specifies the foreground color of the continuation prompt.

The acceptable values for this parameter are: the same values as for *BackgroundColor*.

```yaml
Type: ConsoleColor
Parameter Sets: OptionsSet
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DingDuration
Specifies the duration of the beep, in milliseconds (ms), if the *BellStyle* parameter has a value of Audible.
If you do not specify this parameter, and *BellStyle* is set to Audible, the default duration is 50 ms.

```yaml
Type: Int32
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DingTone
Specifies the tone of the beep, in hertz (Hz), if the *BellStyle* parameter is set to Audible.
The acceptable values for this parameter are: integers in the range 37 to 32767 Hz.
If you do not specify this parameter, and *Bellstyle* is Audible, the default tone is 1221 Hz.

```yaml
Type: Int32
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EditMode
Specifies the command line editing mode.
The *EditMode* parameter resets any key bindings that you have set by running Set-PSReadlineKeyHandler.

```yaml
Type: EditMode
Parameter Sets: OptionsSet
Aliases: 
Accepted values: Windows, Emacs, Vi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmphasisBackgroundColor
Specifies the background color that is used for emphasis, such as to highlight search text.

The acceptable values for this parameter are: the same values as for *BackgroundColor*.

```yaml
Type: ConsoleColor
Parameter Sets: OptionsSet
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmphasisForegroundColor
Specifies the foreground color that is used for emphasis, such as to highlight search text.

The acceptable values for this parameter are: the same values as for *BackgroundColor*.

```yaml
Type: ConsoleColor
Parameter Sets: OptionsSet
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorBackgroundColor
Specifies the background color that is used for errors.

The acceptable values for this parameter are: the same values as for *BackgroundColor*.

```yaml
Type: ConsoleColor
Parameter Sets: OptionsSet
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorForegroundColor
Specifies the foreground color that is used for errors.

The acceptable values for this parameter are: the same values as for *BackgroundColor*.

```yaml
Type: ConsoleColor
Parameter Sets: OptionsSet
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtraPromptLineCount
Specifies the number of extra lines.
Specify a value for this parameter if your prompt spans more than one line, and you want extra lines to be available when PSReadline displays the prompt after showing some output, such as when PSReadline returns a list of completions.

```yaml
Type: Int32
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForegroundColor
Specifies the foreground color for the token kind that is specified by the *TokenKind* parameter.

The acceptable values for this parameter are: the same values as for *BackgroundColor*.

```yaml
Type: ConsoleColor
Parameter Sets: ColorSet
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistoryNoDuplicates
Specifies that duplicate commands not added to PSReadline history.

```yaml
Type: SwitchParameter
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySavePath
Specifies a path of the history file.
If you do not add this parameter, the default path is ~\AppData\Roaming\PSReadline\$($host.Name)_history.txt.

```yaml
Type: String
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySaveStyle
Specifies how PSReadLine saves history.
To avoid unexpected behavior with command history, if you do not want to use the default value, SaveIncrementally, then set this option before you run the first command line in a session.

```yaml
Type: HistorySaveStyle
Parameter Sets: OptionsSet
Aliases: 
Accepted values: SaveIncrementally, SaveAtExit, SaveNothing

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySearchCaseSensitive
Indicates that the searching history is case sensitive in functions such as ReverseSearchHistory or HistorySearchBackward.

```yaml
Type: SwitchParameter
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySearchCursorMovesToEnd
Indicates that the cursor moves to the end of commands that you load from history by using a search.
You can search the command history by typing one or more of the characters at the start of the command, and then pressing the up or down arrows, or any other keys that you have mapped to cycling through the command history.
If you do not specify this parameter, the cursor remains at the position it was when you pressed the up or down arrows.

To turn off this option, you can run either of the following commands:

`Set-PSReadlineOption -HistorySearchCursorMovesToEnd:$False`

`(Get-PSReadlineOption).HistorySearchCursorMovesToEnd = $False`

```yaml
Type: SwitchParameter
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumHistoryCount
Specifies the maximum number of commands to save in PSReadline history.
PSReadline history not the same thing as Windows PowerShell history.

```yaml
Type: Int32
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumKillRingCount
Specifies the maximum number of items stored in the kill ring.

```yaml
Type: Int32
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResetTokenColors
Indicates that this cmdlet restores token colors to default settings.

```yaml
Type: SwitchParameter
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowToolTips
Indicates that when you are displaying possible completions tooltips are shown in the list of completions.

```yaml
Type: SwitchParameter
Parameter Sets: OptionsSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TokenKind
Specifies the kind of token when you are setting token coloring options with the *ForegroundColor* and *BackgroundColor* parameters.
The acceptable values for this parameter are:

- None 
- Comment 
- Keyword 
- String 
- Operator 
- Variable 
- Command 
- Parameter 
- Type 
- Number 
- Member

```yaml
Type: TokenClassification
Parameter Sets: ColorSet
Aliases: 
Accepted values: None, Comment, Keyword, String, Operator, Variable, Command, Parameter, Type, Number, Member

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ViModeIndicator
{{Fill ViModeIndicator Description}}

```yaml
Type: ViModeStyle
Parameter Sets: OptionsSet
Aliases: 
Accepted values: None, Prompt, Cursor

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WordDelimiters
Specifies the characters that delimit words for functions like ForwardWord or KillWord.
The default value is the following list of characters: \>;:,.\[\]{}()/\|^&*-=+

```yaml
Type: String
Parameter Sets: OptionsSet
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

###  
You cannot pipe objects to this cmdlet.

## OUTPUTS

###  
This cmdlet does not generate output.

## NOTES

## RELATED LINKS

[Get-PSReadlineKeyHandler](Get-PSReadlineKeyHandler.md)

[Remove-PSReadlineKeyHandler](Remove-PSReadlineKeyHandler.md)

[Get-PSReadlineOption](Get-PSReadlineOption.md)

[Set-PSReadlineKeyHandler](Set-PSReadlineKeyHandler.md)

