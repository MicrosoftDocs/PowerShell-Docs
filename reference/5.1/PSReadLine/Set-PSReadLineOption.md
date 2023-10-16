---
external help file: Microsoft.PowerShell.PSReadLine2.dll-Help.xml
Locale: en-US
Module Name: PSReadLine
ms.date: 10/02/2023
online version: https://learn.microsoft.com/powershell/module/psreadline/set-psreadlineoption?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-PSReadLineOption
---

# Set-PSReadLineOption

## SYNOPSIS
Customizes the behavior of command line editing in **PSReadLine**.

## SYNTAX

```
Set-PSReadLineOption [-EditMode <EditMode>] [-ContinuationPrompt <String>] [-HistoryNoDuplicates]
 [-AddToHistoryHandler <System.Func[System.String,System.Object]>]
 [-CommandValidationHandler <System.Action[System.Management.Automation.Language.CommandAst]>]
 [-HistorySearchCursorMovesToEnd] [-MaximumHistoryCount <Int32>] [-MaximumKillRingCount <Int32>]
 [-ShowToolTips] [-ExtraPromptLineCount <Int32>] [-DingTone <Int32>] [-DingDuration <Int32>]
 [-BellStyle <BellStyle>] [-CompletionQueryItems <Int32>] [-WordDelimiters <String>]
 [-HistorySearchCaseSensitive] [-HistorySaveStyle <HistorySaveStyle>] [-HistorySavePath <String>]
 [-AnsiEscapeTimeout <Int32>] [-PromptText <String[]>] [-ViModeIndicator <ViModeStyle>]
 [-ViModeChangeHandler <ScriptBlock>] [-Colors <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION

The `Set-PSReadLineOption` cmdlet customizes the behavior of the **PSReadLine** module when you're
editing the command line. To view the **PSReadLine** settings, use `Get-PSReadLineOption`.

The options set by this command only apply to the current session. To persist any options, add them
to a profile script. For more information, see
[about_Profiles](../Microsoft.PowerShell.Core/About/about_Profiles.md) and
[Customizing your shell environment](/powershell/scripting/learn/shell/creating-profiles).

## EXAMPLES

### Example 1: Set foreground and background colors

This example sets **PSReadLine** to display the **Comment** token with green foreground text on a
gray background. In the escape sequence used in the example, **32** represents the foreground color
and **47** represents the background color.

```powershell
Set-PSReadLineOption -Colors @{ "Comment"="$([char]0x1b)[32;47m" }
```

You can choose to set only a foreground text color. For example, a bright green foreground text
color for the **Comment** token: `"Comment"="$([char]0x1b)[92m"`.

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
        Write-Host -NoNewLine "$([char]0x1b)[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "$([char]0x1b)[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
```

The **OnViModeChange** function sets the cursor options for the **Vi** modes: insert and command.
**ViModeChangeHandler** uses the `Function:` provider to reference **OnViModeChange** as a script
block object.

For more information, see
[about_Providers](/powershell/module/microsoft.powershell.core/about/about_providers).

### Example 7: Use HistoryHandler to filter commands added to history

The following example shows how to use the `AddToHistoryHandler` to prevent saving any git commands
to history.

```powershell
$ScriptBlock = {
    Param([string]$line)

    if ($line -match "^git") {
        return $false
    } else {
        return $true
    }
}

Set-PSReadLineOption -AddToHistoryHandler $ScriptBlock
```

The scriptblock returns `$false` if the command started with `git`. This has the same effect as
returning the `SkipAdding` **AddToHistory** enum. If the command doesn't start with `git`, the
handler returns `$true` and PSReadLine saves the command in history.

### Example 8: Use CommandValidationHandler to validate a command before its executed

This example shows how to use the **CommandValidationHandler** parameter to run a validate a command
before it's executed. The example specifically checks for the command `git` with the sub command
`cmt` and replaces that with the full name `commit`. This way you can create shorthand aliases for
subcommands.

```powershell
# Load the namespace so you can use the [CommandAst] object type
using namespace System.Management.Automation.Language

Set-PSReadLineOption -CommandValidationHandler {
    param([CommandAst]$CommandAst)

    switch ($CommandAst.GetCommandName()) {
        'git' {
            $gitCmd = $CommandAst.CommandElements[1].Extent
            switch ($gitCmd.Text) {
                'cmt' {
                    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
                        $gitCmd.StartOffset, $gitCmd.EndOffset - $gitCmd.StartOffset, 'commit')
                }
            }
        }
    }
}
# This checks the validation script when you hit enter
Set-PSReadLineKeyHandler -Chord Enter -Function ValidateAndAcceptLine
```

### Example 9: Using the PromptText parameter

When there's a parse error, **PSReadLine** changes a part of the prompt red. The **PromptText**
parameter tells **PSReadLine** the part of the prompt string to make red.

For example, the following example creates a prompt that contains the current path followed by the
greater-than character (`>`) and a space.

```powershell
function prompt { "PS $pwd> " }`
Set-PSReadLineOption -PromptText '> ' # change the '>' character red
Set-PSReadLineOption -PromptText '> ', 'X ' # replace the '>' character with a red 'X'
```

The first string is the portion of your prompt string that you want to make red when there is a
parse error. The second string is an alternate string to use for when there is a parse error.

## PARAMETERS

### -AddToHistoryHandler

Specifies a **ScriptBlock** that controls how commands get added to **PSReadLine** history.

The **ScriptBlock** receives the command line as input.

The  **ScripBlock** should return a member of the **AddToHistoryOption** enum, the string name of
one of those members, or a boolean value. The list below describes the possible values and their
effects.

- `MemoryAndFile` - Add the command to the history file and the current session.
- `MemoryOnly` - Add the command to history for the current session only.
- `SkipAdding` - Don't add the command to the history file for current session.
- `$false` - Same as if the value was `SkipAdding`.
- `$true` - Same as if the value was `MemoryAndFile`.

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

The argument is a hash table where the keys specify the elements and the values specify the color.
For more information, see
[about_Hash_Tables](/powershell/module/microsoft.powershell.core/about/about_hash_tables).

Colors can be either a value from **ConsoleColor**, for example `[ConsoleColor]::Red`, or a valid
ANSI escape sequence. Valid escape sequences depend on your terminal. In PowerShell 5.0, an example
escape sequence for red text is `$([char]0x1b)[91m`. In PowerShell 6 and newer, the same escape
sequence is `` `e[91m``. You can specify other escape sequences including the following types:

- 256 color
- 24-bit color
- Foreground, background, or both
- Inverse, bold

For more information about ANSI color codes, see the Wikipedia article
[ANSI escape code](https://wikipedia.org/wiki/ANSI_escape_code#Colors_).

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
to make it easier to fix. A validation handler can also change the command line to correct common
typographical errors.

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
is set to `True`. To change the property value, you must specify the value of the 
**SwitchParameter** as follows: `-HistoryNoDuplicates:$False`. You can set back to `True` by using
just the **SwitchParameter**, `-HistoryNoDuplicates`.

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
`$($Host.Name)_history.txt`, for example `ConsoleHost_history.txt`.

If you don't use this parameter, the default path is:

`$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\$($Host.Name)_history.txt`

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: A file named $($Host.Name)_history.txt in $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine on Windows and $env:XDG_DATA_HOME/powershell/PSReadLine or $HOME/.local/share/powershell/PSReadLine on non-Windows platforms
Accept pipeline input: False
Accept wildcard characters: False
```

### -HistorySaveStyle

Specifies how **PSReadLine** saves history.

Valid values are as follows:

- `SaveIncrementally`: Save history after each command is executed and share across multiple
  instances of PowerShell.
- `SaveAtExit`: Append history file when PowerShell exits.
- `SaveNothing`: Don't use a history file.

> [!NOTE]
> If you set **HistorySaveStyle** to `SaveNothing` and then set it to `SaveIncrementally` later in
> the same session, PSReadLine saves all the commands previously run in the session.

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

This parameter sets the value of the **PromptText** property. The default value is `"> "`.

**PSReadLine** analyzes your prompt function to determine how to change only the color of part of
your prompt. This analysis isn't 100% reliable. Use this option if **PSReadLine** is changing your
prompt in unexpected ways. Include any trailing whitespace.

The value of this parameter can be a single string or an array of two strings. The first string is
the portion of your prompt string that you want to be changed to red when there is a parse error.
The second string is an alternate string to use for when there is a parse error.

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

By default, the **ShowToolTips** property of the global **PSConsoleReadLineOptions** object is set
to `True`. Using this **SwitchParameter** sets the property value to `True`. To change the property
value, you must specify the value of the **SwitchParameter** as follows: `-ShowToolTips:$False`.

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

This option sets the visual indicator for the current **Vi** mode. Either insert mode or command
mode.

The valid values are as follows:

- **None**: There's no indicator.
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

## RELATED LINKS

[about_PSReadLine](./About/about_PSReadLine.md)

[Get-PSReadLineKeyHandler](Get-PSReadLineKeyHandler.md)

[Get-PSReadLineOption](Get-PSReadLineOption.md)

[Remove-PSReadLineKeyHandler](Remove-PSReadLineKeyHandler.md)

[Set-PSReadLineKeyHandler](Set-PSReadLineKeyHandler.md)
