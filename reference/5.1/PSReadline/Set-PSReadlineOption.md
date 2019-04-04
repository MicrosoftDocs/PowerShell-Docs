---
external help file: Microsoft.PowerShell.PSReadLine.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSReadLine
ms.date: 12/07/2018
online version: http://go.microsoft.com/fwlink/?LinkId=821453
schema: 2.0.0
title: Set-PSReadLineOption
---

# Set-PSReadLineOption

## SYNOPSIS
Customizes the behavior of command line editing in PSReadLine.

## SYNTAX

### OptionsSet

```
Set-PSReadLineOption
 [-EditMode <EditMode>]
 [-ContinuationPrompt <String>]
 [-ContinuationPromptForegroundColor <ConsoleColor>]
 [-ContinuationPromptBackgroundColor <ConsoleColor>]
 [-EmphasisForegroundColor <ConsoleColor>]
 [-EmphasisBackgroundColor <ConsoleColor>]
 [-ErrorForegroundColor <ConsoleColor>]
 [-ErrorBackgroundColor <ConsoleColor>]
 [-HistoryNoDuplicates]
 [-AddToHistoryHandler <System.Func`2[System.String,System.Boolean]>]
 [-CommandValidationHandler <System.Action`1[System.Management.Automation.Language.CommandAst]>]
 [-HistorySearchCursorMovesToEnd]
 [-MaximumHistoryCount <Int32>]
 [-MaximumKillRingCount <Int32>]
 [-ResetTokenColors]
 [-ShowToolTips]
 [-ExtraPromptLineCount <Int32>]
 [-DingTone <Int32>]
 [-DingDuration <Int32>]
 [-BellStyle <BellStyle>]
 [-CompletionQueryItems <Int32>]
 [-WordDelimiters <String>]
 [-HistorySearchCaseSensitive]
 [-HistorySaveStyle <HistorySaveStyle>]
 [-HistorySavePath <String>]
 [-ViModeIndicator <ViModeStyle>] [<CommonParameters>]
```

### ColorSet

```
Set-PSReadLineOption [-TokenKind] <TokenClassification> [[-ForegroundColor] <ConsoleColor>]
 [[-BackgroundColor] <ConsoleColor>] [<CommonParameters>]
```

## DESCRIPTION

The **Set-PSReadLineOption** cmdlet customizes the behavior of the PSReadLine module when you are editing the command line.

## EXAMPLES

### Example 1: Set values for Comment type

This command sets tokens of the type Comment to be displayed in PSReadLine in green text on a gray background.

```powershell
Set-PSReadLineOption -TokenKind Comment -ForegroundColor Green -BackgroundColor Gray
```

### Example 2: Set bell style

This cmdlet instructs PSReadLine to respond to errors or conditions that require user attention
by emitting an audible beep at 1221 Hz for 60 ms.

```powershell
Set-PSReadLineOption -BellStyle Audible -DingTone 1221 -DingDuration 60
```

## PARAMETERS

### -AddToHistoryHandler

Specifies a **ScriptBlock** that controls which commands get added to PSReadLine history.

The **ScriptBlock** receives the command line as input. If the ScriptBlock returns `$true`, the
command line is added to the history.

```yaml
Type: Func[String, Boolean]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackgroundColor

Specifies the background color for the token kind that is specified by the **TokenKind** parameter.

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

Specifies how PSReadLine responds to various error and ambiguous conditions.

Valid values are:

- Audible: A short beep
- Visual: Text flashes briefly
- None: No feedback

```yaml
Type: BellStyle
Parameter Sets: (All)
Aliases:
Accepted values: None, Visual, Audible

Required: False
Position: Named
Default value: Audible
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommandValidationHandler

Specifies a **ScriptBlock** that is called from **ValidateAndAcceptLine**. If an exception is
thrown, validation fails and the error is reported.

Before throwing an exception, the validation handler can place the cursor at the point of the error to make it easier to fix.
A validation handler can also change the command line, such as to correct common typographical errors.

**ValidateAndAcceptLine** is used to avoid cluttering your history with commands that can't work.

```yaml
Type: Action[CommandAst]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompletionQueryItems

Specifies the maximum number of completion items that are shown without prompting.

If the number of items to show is greater than this value, PSReadLine prompts "y/n" before
displaying the completion items.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContinuationPrompt

Specifies the string displayed at the beginning of the subsequent lines when multi-line input is
entered. Defaults to `>>`. The empty string is valid.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: >>
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContinuationPromptBackgroundColor

Specifies the background color of the continuation prompt.

The acceptable values for this parameter are: the same values as for the **BackgroundColor** parameter.

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

The acceptable values for this parameter are: the same values as for **BackgroundColor**.

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

Specifies the duration of the beep when **BellStyle** is set to **Audible**.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 50ms
Accept pipeline input: False
Accept wildcard characters: False
```

### -DingTone

Specifies the tone in Hertz (Hz) of the beep when **BellStyle** is set to **Audible**.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1221
Accept pipeline input: False
Accept wildcard characters: False
```

### -EditMode

Specifies the command line editing mode. Using this parameter resets any key bindings set by
`Set-PSReadLineKeyHandler`.

Valid values are:

- Windows: Key bindings emulate PowerShell, cmd, and Visual Studio.
- Emacs: Key bindings emulate Bash or Emacs.
- Vi: Key bindings emulate Vi.

```yaml
Type: EditMode
Parameter Sets: (All)
Aliases:
Accepted values: Windows, Emacs, Vi

Required: False
Position: Named
Default value: Windows
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmphasisBackgroundColor

Specifies the background color that is used for emphasis, such as to highlight search text.

The acceptable values for this parameter are: the same values as for **BackgroundColor**.

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

The acceptable values for this parameter are: the same values as for **BackgroundColor**.

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

The acceptable values for this parameter are: the same values as for **BackgroundColor**.

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

The acceptable values for this parameter are: the same values as for **BackgroundColor**.

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
Specify a value for this parameter if your prompt spans more than one line, and you want extra lines to be available when PSReadLine displays the prompt after showing some output, such as when PSReadLine returns a list of completions.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForegroundColor

Specifies the foreground color for the token kind that is specified by the **TokenKind** parameter.

The acceptable values for this parameter are: the same values as for **BackgroundColor**.

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

This option controls the recall behavior. Duplicate commands are still added to the history file.
When this option is set, only the most recent invocation appears when recalling commands.

Repeated commands are added to history to preserve ordering during recall. However, you
typically don't want to see the command multiple times when recalling or searching the history.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySavePath

Specifies the path to the file where history is saved.
If you do not add this parameter, the default path is ~\AppData\Roaming\PSReadLine\$($host.Name)_history.txt.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: ~\AppData\Roaming\PSReadLine\$($host.Name)_history.txt
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySaveStyle

Specifies how PSReadLine saves history.

Valid values are:

- SaveIncrementally: Save history after each command is executed and share across multiple
  instances of PowerShell
- SaveAtExit: Append history file when PowerShell exits
- SaveNothing: Don't use a history file

```yaml
Type: HistorySaveStyle
Parameter Sets: (All)
Aliases:
Accepted values: SaveIncrementally, SaveAtExit, SaveNothing

Required: False
Position: Named
Default value: SaveIncrementally
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySearchCaseSensitive

Specifies that history searching is case-sensitive in functions like **ReverseSearchHistory** or
**HistorySearchBackward**.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySearchCursorMovesToEnd

Indicates that the cursor moves to the end of commands that you load from history by using a search.
When this parameter is set to `$false`, the cursor remains at the position it was when you pressed
the up or down arrows.

To turn off this option, you can run either of the following commands:

`Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$False`

`(Get-PSReadLineOption).HistorySearchCursorMovesToEnd = $False`

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumHistoryCount

Specifies the maximum number of commands to save in PSReadLine history.

PSReadLine history is separate from PowerShell history.

```yaml
Type: Int32
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 10
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

When displaying possible completions,  tooltips are shown in the list of completions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

This option sets the visual indication for the current mode in Vi mode; either insert mode or
command mode.

Valid values are:

- None - there is no indication
- Prompt - the prompt changes color
- Cursor - the cursor changes size

```yaml
Type: ViModeStyle
Parameter Sets: (All)
Aliases:
Accepted values: None, Prompt, Cursor

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WordDelimiters

Specifies the characters that delimit words for functions like **ForwardWord** or **KillWord**.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: ;:,.[]{}()/\|^&*-=+'"
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate output.

## NOTES

## RELATED LINKS

[Get-PSReadLineKeyHandler](Get-PSReadLineKeyHandler.md)

[Remove-PSReadLineKeyHandler](Remove-PSReadLineKeyHandler.md)

[Get-PSReadLineOption](Get-PSReadLineOption.md)

[Set-PSReadLineKeyHandler](Set-PSReadLineKeyHandler.md)