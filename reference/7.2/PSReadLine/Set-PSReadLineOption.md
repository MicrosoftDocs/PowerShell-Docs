---
external help file: Microsoft.PowerShell.PSReadLine2.dll-Help.xml
Locale: en-US
Module Name: PSReadLine
ms.date: 11/23/2020
online version: https://docs.microsoft.com/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-PSReadLineOption
---

# Set-PSReadLineOption

## Synopsis
Customizes the behavior of command line editing in **PSReadLine**.

## Syntax

```
Set-PSReadLineOption [-EditMode <EditMode>] [-ContinuationPrompt <String>] [-HistoryNoDuplicates]
 [-AddToHistoryHandler <System.Func`2[System.String,System.Object]>]
 [-CommandValidationHandler <System.Action`1[System.Management.Automation.Language.CommandAst]>]
 [-HistorySearchCursorMovesToEnd] [-MaximumHistoryCount <Int32>] [-MaximumKillRingCount <Int32>]
 [-ShowToolTips] [-ExtraPromptLineCount <Int32>] [-DingTone <Int32>] [-DingDuration <Int32>]
 [-BellStyle <BellStyle>] [-CompletionQueryItems <Int32>] [-WordDelimiters <String>]
 [-HistorySearchCaseSensitive] [-HistorySaveStyle <HistorySaveStyle>] [-HistorySavePath <String>]
 [-AnsiEscapeTimeout <Int32>] [-PromptText <String[]>] [-ViModeIndicator <ViModeStyle>]
 [-ViModeChangeHandler <ScriptBlock>] [-PredictionSource <PredictionSource>]
 [-PredictionViewStyle <PredictionViewStyle>] [-Colors <Hashtable>] [<CommonParameters>]
```

## Description

The `Set-PSReadLineOption` cmdlet customizes the behavior of the **PSReadLine** module when you're
editing the command line. To view the **PSReadLine** settings, use `Get-PSReadLineOption`.

## Examples

### Example 1: Set foreground and background colors

This example sets **PSReadLine** to display the **Comment** token with green foreground text on a
gray background. In the escape sequence used in the example, **32** represents the foreground color
and **47** represents the background color.

```powershell
Set-PSReadLineOption -Colors @{ "Comment"="`e[32;47m" }
```

You can choose to set only a foreground text color. For example, a bright green foreground text
color for the **Comment** token: ``"Comment"="`e[92m"``.

### Example 2: Set bell style

In this example, **PSReadLine** will respond to errors or conditions that require user attention.
The **BellStyle** is set to emit an audible beep at 1221 Hz for 60 ms.

```powershell
Set-PSReadLineOption -BellStyle Audible -DingTone 1221 -DingDuration 60
```

> [!NOTE]
> This feature may not work in all hosts on platforms.

### Example 3: Set multiple options

`Set-PSReadLineOption` can set multiple options with a hash table.

```powershell
$PSReadLineOptions = @{
    EditMode = "Emacs"
    HistoryNoDuplicates = $true
    HistorySearchCursorMovesToEnd = $true
    Colors = @{
        "Command" = "#8181f7"
    }
}
Set-PSReadLineOption @PSReadLineOptions
```

The `$PSReadLineOptions` hash table sets the keys and values. `Set-PSReadLineOption` uses the keys
and values with `@PSReadLineOptions` to update the **PSReadLine** options.

You can view the keys and values entering the hash table name, `$PSReadLineOptions` on the
PowerShell command line.

### Example 4: Set multiple color options

This example shows how to set more than one color value in a single command.

```powershell
Set-PSReadLineOption -Colors @{
  Command            = 'Magenta'
  Number             = 'DarkGray'
  Member             = 'DarkGray'
  Operator           = 'DarkGray'
  Type               = 'DarkGray'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
  ContinuationPrompt = 'DarkGray'
  Default            = 'DarkGray'
}
```

### Example 5: Set color values for multiple types

This example shows three different methods for how to set the color of tokens displayed in
**PSReadLine**.

```powershell
Set-PSReadLineOption -Colors @{
 # Use a ConsoleColor enum
 "Error" = [ConsoleColor]::DarkRed

 # 24 bit color escape sequence
 "String" = "$([char]0x1b)[38;5;100m"

 # RGB value
 "Command" = "#8181f7"
}
```

### Example 6: Use ViModeChangeHandler to display Vi mode changes

This example emits a cursor change VT escape in response to a **Vi** mode change.

```powershell
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
```

The **OnViModeChange** function sets the cursor options for the **Vi** modes: insert and command.
**ViModeChangeHandler** uses the `Function:` provider to reference **OnViModeChange** as a script
block object.

For more information, see
[about_Providers](/powershell/module/microsoft.powershell.core/about/about_providers).

## Parameters

### -AddToHistoryHandler

Specifies a **ScriptBlock** that controls which commands get added to **PSReadLine** history.

The **ScriptBlock** receives the command line as input. If the **ScriptBlock** returns `$True`, the
command line is added to the history.

```yaml
Type: System.Func`2[System.String,System.Object]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AnsiEscapeTimeout

This option is specific to Windows when input is redirected, for example, when running under `tmux`
or `screen`.

With redirected input on Windows, many keys are sent as a sequence of characters starting with the
escape character. It's impossible to distinguish between a single escape character followed by
more characters and a valid escape sequence.

The assumption is that the terminal can send the characters faster than a user types. **PSReadLine**
waits for this timeout before concluding that it has received a complete escape sequence.

If you see random or unexpected characters when you type, you can adjust this timeout.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -BellStyle

Specifies how **PSReadLine** responds to various error and ambiguous conditions.

The valid values are as follows:

- **Audible**: A short beep.
- **Visual**: Text flashes briefly.
- **None**: No feedback.

```yaml
Type: Microsoft.PowerShell.BellStyle
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Audible
Accept pipeline input: False
Accept wildcard characters: False
```

### -Colors

The **Colors** parameter specifies various colors used by **PSReadLine**.

The argument is a hash table where the keys specify which element and the values specify the color.
For more information, see [about_Hash_Tables](/powershell/module/microsoft.powershell.core/about/about_hash_tables).

Colors can be either a value from **ConsoleColor**, for example `[ConsoleColor]::Red`, or a valid
ANSI escape sequence. Valid escape sequences depend on your terminal. In PowerShell 5.0, an example
escape sequence for red text is `$([char]0x1b)[91m`. In PowerShell 6 and above, the same escape
sequence is `` `e[91m``. You can specify other escape sequences including the following types:

Two color settings were added to support customization of the `ListView` in PSReadLine 2.2.0:

- **ListPredictionColor** - set color for the leading `>` character and the trailing source name,
  e.g. `[History]`. By default, it uses `DarkYellow` as the foreground color.
- **ListPredictionSelectedColor** - set color for indicating a list item is selected. By default, it
  uses `DarkBlack` as the background color.

- 256 color
- 24-bit color
- Foreground, background, or both
- Inverse, bold

For more information about ANSI color codes, see [ANSI escape code](https://wikipedia.org/wiki/ANSI_escape_code#Colors_) in Wikipedia.

The valid keys include:

- **ContinuationPrompt**: The color of the continuation prompt.
- **Emphasis**: The emphasis color. For example, the matching text when searching history.
- **Error**: The error color. For example, in the prompt.
- **Selection**: The color to highlight the menu selection or selected text.
- **Default**: The default token color.
- **Comment**: The comment token color.
- **Keyword**: The keyword token color.
- **String**: The string token color.
- **Operator**: The operator token color.
- **Variable**: The variable token color.
- **Command**: The command token color.
- **Parameter**: The parameter token color.
- **Type**: The type token color.
- **Number**: The number token color.
- **Member**: The member name token color.
- **InlinePrediction**: The color for the inline view of the predictive suggestion.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommandValidationHandler

Specifies a **ScriptBlock** that is called from **ValidateAndAcceptLine**. If an exception is
thrown, validation fails and the error is reported.

Before throwing an exception, the validation handler can place the cursor at the point of the error
to make it easier to fix. A validation handler can also change the command line, such as to correct
common typographical errors.

**ValidateAndAcceptLine** is used to avoid cluttering your history with commands that can't work.

```yaml
Type: System.Action`1[System.Management.Automation.Language.CommandAst]
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

If the number of items to show is greater than this value, **PSReadLine** prompts **yes/no** before
displaying the completion items.

```yaml
Type: System.Int32
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
entered. The default is double greater-than signs (`>>`). An empty string is valid.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: >>
Accept pipeline input: False
Accept wildcard characters: False
```

### -DingDuration

Specifies the duration of the beep when **BellStyle** is set to **Audible**.

```yaml
Type: System.Int32
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
Type: System.Int32
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

The valid values are as follows:

- **Windows**: Key bindings emulate PowerShell, cmd, and Visual Studio.
- **Emacs**: Key bindings emulate Bash or Emacs.
- **Vi**: Key bindings emulate Vi.

Use `Get-PSReadLineKeyHandler` to see the key bindings for the currently configured **EditMode**.

```yaml
Type: Microsoft.PowerShell.EditMode
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Windows
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtraPromptLineCount

Specifies the number of extra lines.

If your prompt spans more than one line, specify a value for this parameter. Use this option when
you want extra lines to be available when **PSReadLine** displays the prompt after showing some
output. For example, **PSReadLine** returns a list of completions.

This option is needed less than in previous versions of **PSReadLine**, but is useful when the
`InvokePrompt` function is used.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistoryNoDuplicates

This option controls the recall behavior. Duplicate commands are still added to the history file.
When this option is set, only the most recent invocation appears when recalling commands. Repeated
commands are added to history to preserve ordering during recall. However, you typically don't want
to see the command multiple times when recalling or searching the history.

By default, the **HistoryNoDuplicates** property of the global **PSConsoleReadLineOptions** object
is set to `True`. Using this **SwitchParameter** sets the property value to `True`. To change the
property value, you must specify the value of the **SwitchParameter** as follows:
`-HistoryNoDuplicates:$False`.

Using the following command, you can set the property value directly:

`(Get-PSReadLineOption).HistoryNoDuplicates = $False`

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySavePath

Specifies the path to the file where history is saved. Computers running Windows or non-Windows
platforms store the file in different locations. The filename is stored in a variable
`$($host.Name)_history.txt`, for example `ConsoleHost_history.txt`.

If you don't use this parameter, the default path is as follows:

**Windows**

`$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\$($host.Name)_history.txt`

**non-Windows**

`$env:XDG_DATA_HOME/powershell/PSReadLine\$($host.Name)_history.txt`

`$env:HOME/.local/share/powershell/PSReadLine\$($host.Name)_history.txt`

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: A file named $($host.Name)_history.txt in $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine on Windows and $env:XDG_DATA_HOME/powershell/PSReadLine or $env:HOME/.local/share/powershell/PSReadLine on non-Windows platforms
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySaveStyle

Specifies how **PSReadLine** saves history.

Valid values are as follows:

- **SaveIncrementally**: Save history after each command is executed and share across multiple
  instances of PowerShell.
- **SaveAtExit**: Append history file when PowerShell exits.
- **SaveNothing**: Don't use a history file.

```yaml
Type: Microsoft.PowerShell.HistorySaveStyle
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: SaveIncrementally
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySearchCaseSensitive

Specifies that history searching is case-sensitive in functions like **ReverseSearchHistory** or
**HistorySearchBackward**.

By default, the **HistorySearchCaseSensitive** property of the global **PSConsoleReadLineOptions**
object is set to `False`. Using this **SwitchParameter** sets the property value to `True`. To
change the property value back, you must specify the value of the **SwitchParameter** as follows:
`-HistorySearchCaseSensitive:$False`.

Using the following command, you can set the property value directly:

`(Get-PSReadLineOption).HistorySearchCaseSensitive = $False`

```yaml
Type: System.Management.Automation.SwitchParameter
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
When this parameter is set to `$False`, the cursor remains at the position it was when you pressed
the up or down arrows.

By default, the **HistorySearchCursorMovesToEnd** property of the global
**PSConsoleReadLineOptions** object is set to `False`. Using this **SwitchParameter** set the
property value to `True`. To change the property value back, you must specify the value of the
**SwitchParameter** as follows: `-HistorySearchCursorMovesToEnd:$False`.

Using the following command, you can set the property value directly:

`(Get-PSReadLineOption).HistorySearchCursorMovesToEnd = $False`

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumHistoryCount

Specifies the maximum number of commands to save in **PSReadLine** history.

**PSReadLine** history is separate from PowerShell history.

```yaml
Type: System.Int32
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
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -PromptText

When there's a parse error, **PSReadLine** changes a part of the prompt red. **PSReadLine** analyzes
your prompt function to determine how to change only the color of part of your prompt. This analysis
isn't 100% reliable.

Use this option if **PSReadLine** is changing your prompt in unexpected ways. Include any trailing
whitespace.

For example, if your prompt function looked like the following example:

`function prompt { Write-Host -NoNewLine -ForegroundColor Yellow "$pwd"; return "# " }`

Then set:

`Set-PSReadLineOption -PromptText "# "`

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: >
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowToolTips

When displaying possible completions, tooltips are shown in the list of completions.

This option is enabled by default. This option wasn't enabled by default in prior versions of
**PSReadLine**. To disable, set this option to `$False`.

By default, the **ShowToolTips** property of the global **PSConsoleReadLineOptions**
object is set to `True`. Using this **SwitchParameter** sets the property value to `True`. To change
the property value, you must specify the value of the **SwitchParameter** as follows:
`-ShowToolTips:$False`.

Using the following command, you can set the property value directly:

`(Get-PSReadLineOption).ShowToolTips = $False`

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -ViModeChangeHandler

When the **ViModeIndicator** is set to `Script`, the script block provided will be invoked every
time the mode changes. The script block is provided one argument of type `ViMode`.

This parameter was introduced in PowerShell 7.

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ViModeIndicator

This option sets the visual indication for the current **Vi** mode. Either insert mode or command
mode.

The valid values are as follows:

- **None**: There's no indication.
- **Prompt**: The prompt changes color.
- **Cursor**: The cursor changes size.
- **Script**: User-specified text is printed.

```yaml
Type: Microsoft.PowerShell.ViModeStyle
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WordDelimiters

Specifies the characters that delimit words for functions like **ForwardWord** or **KillWord**.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: ;:,.[]{}()/\|^&*-=+'"---
Accept pipeline input: False
Accept wildcard characters: False
```

### -PredictionSource

Specifies the source for PSReadLine to get predictive suggestions.

Valid values are:

- **None** - disable the predictive IntelliSense feature (default).
-`**History** - enable the predictive IntelliSense feature and use the PSReadLine history as the
  only source.
- **Plugin** - enable the predictive IntelliSense feature and use the plugins (`CommandPrediction`)
  as the only source. This value was added in PSReadLine 2.2.0
- **HistoryAndPlugin** - enable the predictive IntelliSense feature and use both history and plugin
  as the sources. This value was added in PSReadLine 2.2.0

```yaml
Type: Microsoft.PowerShell.PredictionSource
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PredictionViewStyle

Sets the style for the display of the predictive text. The default is **InlineView**.

- **InlineView** - the style as existing today, similar as in fish shell and zsh. (default)
- **ListView** - suggestions are rendered in a drop down list, and users can select using
  <kbd>UpArrow</kbd> and <kbd>DownArrow</kbd>.

This parameter was added in PSReadLine 2.2.0

```yaml
Type: Microsoft.PowerShell.PredictionViewStyle
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: InlineView
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

You cannot pipe objects to `Set-PSReadLineOption.`

## Outputs

### None

This cmdlet does not generate any output.

## Notes

## Related links

[about_PSReadLine](./About/about_PSReadLine.md)

[Get-PSReadLineKeyHandler](Get-PSReadLineKeyHandler.md)

[Get-PSReadLineOption](Get-PSReadLineOption.md)

[Remove-PSReadLineKeyHandler](Remove-PSReadLineKeyHandler.md)

[Set-PSReadLineKeyHandler](Set-PSReadLineKeyHandler.md)
