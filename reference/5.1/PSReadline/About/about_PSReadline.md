---
ms.date:  12/08/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell
title:  About PSReadLine
---

# PSReadLine

## about_PSReadLine

## SHORT DESCRIPTION

PSReadLine provides an improved command line editing experience in the
PowerShell console.

## LONG DESCRIPTION

PSReadLine provides a powerful command line editing experience for the
PowerShell console. It provides:

- Syntax coloring of the command line
- A visual indication of syntax errors
- A better multi-line experience (both editing and history)
- Customizable key bindings
- Cmd and Emacs modes
- Many configuration options
- Bash style completion (optional in Cmd mode, default in Emacs mode)
- Emacs yank/kill ring
- PowerShell token based "word" movement and kill

The following functions are available in the class
**[Microsoft.PowerShell.PSConsoleReadLine]**.

## Cursor movement

### EndOfLine

- Cmd: `<End>`
- Emacs: `<End>` or `<Ctrl+E>`

If the input has multiple lines, move to the end of the current line,
or if already at the end of the line, move to the end of the input.
If the input has a single line, move to the end of the input.

### BeginningOfLine

- Cmd: `<Home>`
- Emacs: `<Home>` or `<Ctrl+A>`

If the input has multiple lines, move to the start of the current line,
or if already at the start of the line, move to the start of the input.
If the input has a single line, move to the start of the input.

### NextLine

- Cmd: unbound
- Emacs: unbound

Move the cursor to the next line if the input has multiple lines.

### PreviousLine

- Cmd: unbound
- Emacs: unbound

Move the cursor to the previous line if the input has multiple lines.

### ForwardChar

- Cmd: `<RightArrow>`
- Emacs: `<RightArrow>` or `<Ctrl+F>`

Move the cursor one character to the right. This might move the cursor to the
next line of multi-line input.

### BackwardChar

- Cmd: `<LeftArrow>`
- Emacs: `<LeftArrow>` or `<Ctrl+B>`

Move the cursor one character to the left. This might move the cursor to the
previous line of multi-line input.

### ForwardWord

- Cmd: unbound
- Emacs: `<Alt+F>`

Move the cursor forward to the end of the current word, or if between words,
to the end of the next word. You can set word delimiter characters with:

```powershell
Set-PSReadLineOption -WordDelimiters `<string of delimiter characters>`
```

### NextWord

- Cmd: `<Ctrl+RightArrow>`
- Emacs: unbound

Move the cursor forward to the start of the next word. You can set word
delimiter characters with:

```powershell
Set-PSReadLineOption -WordDelimiters `<string of delimiter characters>`
```

### BackwardWord

- Cmd: `<Ctrl+LeftArrow>`
- Emacs: `<Alt+B>`

Move the cursor back to the start of the current word, or if between words,
the start of the previous word. You can set word delimiter characters with:

```powershell
Set-PSReadLineOption -WordDelimiters `<string of delimiter characters>`
```

### ShellForwardWord

- Cmd: unbound
- Emacs: unbound

Like ForwardWord except word boundaries are defined by PowerShell
token boundaries.

### ShellNextWord

- Cmd: unbound
- Emacs: unbound

Like NextWord except word boundaries are defined by PowerShell
token boundaries.

### ShellBackwardWord

- Cmd: unbound
- Emacs: unbound

Like BackwardWord except word boundaries are defined by PowerShell
token boundaries.

### GotoBrace

- Cmd: `<Ctrl+}>`
- Emacs: unbound

Go to the matching parenthesis, curly brace, or square bracket.

### AddLine

- Cmd: `<Shift-Enter>`
- Emacs: `<Shift-Enter>`

The continuation prompt is displayed on the next line and PSReadLine waits for
keys to edit the current input. This is useful to enter multi-line input as a
single command even when a single line is complete input by itself.

## Basic editing

### CancelLine

- Cmd: unbound
- Emacs: unbound

Cancel all editing to the line, leave the line of input on the screen but
return from PSReadLine without executing the input.

### RevertLine

- Cmd: `<ESC>`
- Emacs: `<Alt+R>`

Reverts all of the input since the last input was accepted and run. This is
equivalent to using the Undo command until there is nothing left to undo.

### BackwardDeleteChar

- Cmd: `<Backspace>`
- Emacs: `<Backspace>` or `<Ctrl+H>`

Delete the character before the cursor.

### DeleteChar

- Cmd: `<Delete>`
- Emacs: `<Delete>`

Delete the character under the cursor.

### DeleteCharOrExit

- Cmd: unbound
- Emacs: `<Ctrl+D>`

Like DeleteChar, unless the line is empty, in which case exit the process.

### AcceptLine

- Cmd: `<Enter>`
- Emacs: `<Enter>` or `<Ctrl+M>`

Attempt to execute the current input. If the current input is incomplete (for
example, there is a missing closing parenthesis, bracket, or quote), then the
continuation prompt is displayed on the next line, and PSReadLine waits for
keys to edit the current input.

### AcceptAndGetNext

- Cmd: unbound
- Emacs: `<Ctrl+O>`

Like AcceptLine, but after the line completes, start editing the next line
from history.

### ValidateAndAcceptLine

- Cmd: unbound
- Emacs: unbound

Like AcceptLine but performs additional validation including:

* Checks for additional parse errors
* Validates that command names are all found
* If you are running PowerShell 4.0 or newer, validates the parameters
  and arguments

If there are any errors, the error message is displayed and not accepted nor
added to the history unless you either correct the command line or execute
AcceptLine or ValidateAndAcceptLine again while the error message is
displayed.

### BackwardDeleteLine

- Cmd: `<Ctrl+Home>`
- Emacs: unbound

Delete the text from the start of the input to the cursor.

### ForwardDeleteLine

- Cmd: `<Ctrl+End>`
- Emacs: unbound

Delete the text from the cursor to the end of the input.

### SelectBackwardChar

- Cmd: `<Shift+LeftArrow>`
- Emacs: `<Shift+LeftArrow>`

Adjust the current selection to include the previous character.

### SelectForwardChar

- Cmd: `<Shift+RightArrow>`
- Emacs: `<Shift+RightArrow>`

Adjust the current selection to include the next character.

### SelectBackwardWord

- Cmd: `<Shift+Ctrl+LeftArrow>`
- Emacs: `<Alt+Shift+B>`

Adjust the current selection to include the previous word.

### SelectForwardWord

- Cmd: unbound
- Emacs: `<Alt+Shift+F>`

Adjust the current selection to include the next word using ForwardWord.

### SelectNextWord

- Cmd: `<Shift+Ctrl+RightArrow>`
- Emacs: unbound

Adjust the current selection to include the next word using NextWord.

### SelectShellForwardWord

- Cmd: unbound
- Emacs: unbound

Adjust the current selection to include the next word using ShellForwardWord.

### SelectShellNextWord

- Cmd: unbound
- Emacs: unbound

Adjust the current selection to include the next word using ShellNextWord.

### SelectShellBackwardWord

- Cmd: unbound
- Emacs: unbound

Adjust the current selection to include the previous word using
ShellBackwardWord.

### SelectBackwardsLine

- Cmd: `<Shift+Home>`
- Emacs: `<Shift+Home>`

Adjust the current selection to include from the cursor to the start of the
line.

### SelectLine

- Cmd: `<Shift+End>`
- Emacs: `<Shift+End>`

Adjust the current selection to include from the cursor to the end of the
line.

### SelectAll

- Cmd: `<Ctrl+A>`
- Emacs: unbound

Select the entire line. Moves the cursor to the end of the line.

### SelfInsert

- Cmd: `<a>`, `<b>`, ...
- Emacs: `<a>`, `<b>`, ...

Insert the key entered.

### Redo

- Cmd: `<Ctrl+Y>`
- Emacs: unbound

Redo an insertion or deletion that was undone by Undo.

### Undo

- Cmd: `<Ctrl+Z>`
- Emacs: `<Ctrl+_>`

Undo a previous insertion or deletion.

## History

### ClearHistory

- Cmd: `<Alt+F7>`
- Emacs: unbound

Clears history in PSReadLine. This does not affect PowerShell
history.

### PreviousHistory

- Cmd: `<UpArrow>`
- Emacs: `<UpArrow>` or `<Ctrl+P>`

Replace the current input with the previous item from PSReadLine history.

### NextHistory

- Cmd: `<DownArrow>`
- Emacs: `<DownArrow>` or `<Ctrl+N>`

Replace the current input with the next item from PSReadLine history.

### ForwardSearchHistory

- Cmd: `<Ctrl+S>`
- Emacs: `<Ctrl+S>`

Search forward from the current history line interactively.

### ReverseSearchHistory

- Cmd: `<Ctrl+R>`
- Emacs: `<Ctrl+R>`

Search backward from the current history line interactively.

### HistorySearchBackward

- Cmd: `<F8>`
- Emacs: unbound

Replace the current input with the previous item from PSReadLine history
that matches the characters between the start and the input and the cursor.

### HistorySearchForward

- Cmd: `<Shift+F8>`
- Emacs: unbound

Replace the current input with the next item from PSReadLine history
that matches the characters between the start and the input and the cursor.

### BeginningOfHistory

- Cmd: unbound
- Emacs: `<Alt+<>`

Replace the current input with the last item from PSReadLine history.

### EndOfHistory

- Cmd: unbound
- Emacs: `<Alt+>>`

Replace the current input with the last item in PSReadLine history, which
is the possibly empty input that was entered before any history commands.

## Tab Completion

### TabCompleteNext

- Cmd: `<Tab>`
- Emacs: unbound

Attempt to complete the text surrounding the cursor with the next
available completion.

### TabCompletePrevious

- Cmd: `<Shift-Tab>`
- Emacs: unbound

Attempt to complete the text surrounding the cursor with the next
previous completion.

### Complete

- Cmd: unbound
- Emacs: `<Tab>`

Attempt to perform completion on the text surrounding the cursor. If there are
multiple possible completions, the longest unambiguous prefix is used for
completion. If you are trying to complete the longest unambiguous completion,
a list of possible completions is displayed.

### MenuComplete

- Cmd: `<Ctrl+Space>`
- Emacs: `<Ctrl+Space>`

Attempt to perform completion on the text surrounding the cursor. If there are
multiple possible completions, a list of possible completions is displayed,
and you can select the correct completion by using the arrow keys, or
Tab/Shift+Tab. Escape and Ctrl+G cancel the menu selection, and revert the
line to the state before invoking MenuComplete.

### PossibleCompletions

- Cmd: unbound
- Emacs: `<Alt+Equals>`

Display the list of possible completions.

### SetMark

- Cmd: unbound
- Emacs: `<Alt+Space>`

Mark the current location of the cursor for use in a subsequent editing
command.

### ExchangePointAndMark

- Cmd: unbound
- Emacs: `<Ctrl+X,Ctrl+X>`

The cursor is placed at the location of the mark and the mark is moved to the
location of the cursor.

## Kill/Yank

Kill and Yank operate on a clipboard in the PSReadLine module. There is a ring
buffer called the kill ring - killed text is added to the kill ring up and
yank will copy text from the most recent kill. YankPop cycles through items in
the kill ring. When the kill ring is full, new items replace the oldest items.
A kill operation that is immediately preceded by another kill operation
appends the previous kill, instead of adding a new item or replacing an item
in the kill ring. This is how you can cut a part of a line, for example, with
multiple KillWord operations, then yank them back elsewhere as a single yank.

### KillLine

- Cmd: unbound
- Emacs: `<Ctrl+K>`

Clear the input from the cursor to the end of the line. The cleared text is
placed in the kill ring.

### BackwardKillLine

- Cmd: unbound
- Emacs: `<Ctrl+U>` or `<Ctrl+X,Backspace>`

Clear the input from the start of the input to the cursor. The cleared text is
placed in the kill ring.

### KillWord

- Cmd: unbound
- Emacs: `<Alt+D>`

Clear the input from the cursor to the end of the current word. If the cursor
is between words, the input is cleared from the cursor to the end of the next
word. The cleared text is placed in the kill ring.

### BackwardKillWord

- Cmd: unbound
- Emacs: `<Alt+Backspace>`

Clear the input from the start of the current word to the cursor. If the
cursor is between words, the input is cleared from the start of the previous
word to the cursor. The cleared text is placed in the kill ring.

### ShellKillWord

- Cmd: unbound
- Emacs: unbound

Like KillWord, except word boundaries are defined by PowerShell
token boundaries.

### ShellBackwardKillWord

- Cmd: unbound
- Emacs: unbound

Like BackwardKillWord, except word boundaries are defined by PowerShell token
boundaries.

### UnixWordRubout

- Cmd: unbound
- Emacs: `<Ctrl+W>`

Like BackwardKillWord, except word boundaries are defined by white space.

### KillRegion

- Cmd: unbound
- Emacs: unbound

Kill the text between the cursor and the mark.

### Copy

- Cmd: `<Ctrl+Shift+C>`
- Emacs: unbound

Copy selected region to the system clipboard. If no region is selected, copy
the whole line.

### CopyOrCancelLine

- Cmd: `<Ctrl+C>`
- Emacs: `<Ctrl+C>`

Either copy selected text to the clipboard, or if no text is selected, cancel
editing the line with CancelLine.

### Cut

- Cmd: `<Ctrl+X>`
- Emacs: unbound

Delete selected region placing deleted text in the system clipboard.

### Yank

- Cmd: unbound
- Emacs: `<Ctrl+Y>`

Add the most-recently killed text to the input.

### YankPop

- Cmd: unbound
- Emacs: `<Alt+Y>`

If the previous operation was Yank or YankPop, replace the previously-yanked
text with the next killed text from the kill ring.

### ClearKillRing

- Cmd: unbound
- Emacs: unbound

The contents of the kill ring are cleared.

### Paste

- Cmd: `<Ctrl+V>`
- Emacs: unbound

This is similar to Yank, but uses the system clipboard instead of the kill
ring.

### YankLastArg

- Cmd: `<Alt+.>`
- Emacs: `<Alt+.>`, `<Alt+_>`

Insert the last argument from the previous command in history. Repeated
operations replace the last inserted argument with the last argument from the
previous command (so Alt+. Alt+. will insert the last argument of the second
to last history line).

With an argument, the first time YankLastArg behaves like YankNthArg. A
negative argument on subsequent YankLastArg calls changes the direction while
going through history. For example, if you press Alt+. one too many times, you
can type Alt+- Alt+. to reverse the direction.

Arguments are based on PowerShell tokens.

### YankNthArg

- Cmd: unbound
- Emacs: `<Alt+Ctrl+Y>`

Insert the first argument (not the command name) of the previous command in
history.

With an argument, insert the nth argument where 0 is typically the command.
Negative arguments start from the end.

Arguments are based on PowerShell tokens.

## Miscellaneous

### Abort

- Cmd: unbound
- Emacs: `<Ctrl+G>`

Abort the current action; for example, stop interactive history search.
Does not cancel input like CancelLine.

CharacterSearch

- Cmd: `<F3>`
- Emacs: `<Ctrl+]>`

Read a key and search forwards for that character. With an argument, search
forwards for the nth occurrence of that argument. With a negative argument,
searches backwards.

### CharacterSearchBackward

- Cmd: `<Shift+F3>`
- Emacs: `<Alt+Ctrl+]>`

Like CharacterSearch, but searches backwards. With a negative argument,
searches forwards.

### ClearScreen

- Cmd: `<Ctrl+L>`
- Emacs: `<Ctrl+L>`

Clears the screen and displays the current prompt and input at the top of the
screen.

### DigitArgument

- Cmd: unbound
- Emacs: `<Alt+[0..9]>`,`<any char>`,`<Alt+->`

Used to pass numeric arguments to functions like CharacterSearch or
YankNthArg. Alt+- toggles the argument to be negative/non-negative. To enter
80 '\*' characters, you could type Alt+8 Alt+0 \*.

CaptureScreen

- Cmd: unbound
- Emacs: unbound

Copies selected lines to the clipboard in both text and RTF formats. Use
up/down arrow keys to the first line to select, then
Shift+UpArrow/Shift+DownArrow to select multiple lines. After selecting, press
Enter to copy the text. Escape/Ctrl+C/Ctrl+G cancel the operation, so nothing
is copied to the clipboard.

### InvokePrompt

- Cmd: unbound
- Emacs: unbound

Erases the current prompt and calls the prompt function to redisplay the
prompt. Useful for custom key handlers that change state, such as changing the
current directory.

### WhatIsKey

- Cmd: `<Alt+?>`
- Emacs: `<Alt+?>`

Read a key or chord and display the key binding.

### ShowKeyBindings

- Cmd: `<Ctrl+Alt+?>`
- Emacs: `<Ctrl+Alt+?>`

Show all of the currently-bound keys.

### ScrollDisplayUp

- Cmd: `<PageUp>`
- Emacs: `<PageUp>`

Scroll the display up one screen.

### ScrollDisplayUpLine

- Cmd: `<Ctrl+PageUp>`
- Emacs: `<Ctrl+PageUp>`

Scroll the display up one line.

### ScrollDisplayDown

- Cmd: `<PageDown>`
- Emacs: `<PageDown>`

Scroll the display down one screen.

### ScrollDisplayDownLine

- Cmd: `<Ctrl+PageDown>`
- Emacs: `<Ctrl+PageDown>`

Scroll the display down one line.

### ScrollDisplayTop

- Cmd: unbound
- Emacs: `<Ctrl+Home>`

Scroll the display to the top.

### ScrollDisplayToCursor

- Cmd: unbound
- Emacs: `<Ctrl+End>`

Scroll the display to the cursor.

## Custom Key Bindings

PSReadLine supports custom key bindings using the cmdlet
`Set-PSReadLineKeyHandler`. Most custom key bindings call one of the above
functions, for example

```powershell
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
```

You can bind a ScriptBlock to a key. The ScriptBlock can do pretty much
anything you want. Some useful examples include

- edit the command line
- opening a new window (e.g. help)
- change directories without changing the command line

The ScriptBlock receives two arguments:

- `$key` - A **[ConsoleKeyInfo]** object that is the key that triggered the
  custom binding. If you bind the same ScriptBlock to multiple keys and need
  to perform different actions depending on the key, you can check $key. Many
  custom bindings ignore this argument.

- `$arg` - An arbitrary argument. Most often, this would be an integer
  argument that the user passes from the key bindings DigitArgument. If your
  binding doesn't accept arguments, it's reasonable to ignore this argument.

Let's take a look at an example that adds a command line to history without
executing it. This is useful when you realize you forgot to do something, but
don't want to re-enter the command line you've already entered.

```powershell
$parameters = @{
    Key = 'Alt+w'
    BriefDescription = 'SaveInHistory'
    LongDescription = 'Save current line in history but do not execute'
    ScriptBlock = {
      param($key, $arg)   # The arguments are ignored in this example

      # GetBufferState gives us the command line (with the cursor position)
      $line = $null
      $cursor = $null
      [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line,
        [ref]$cursor)

      # AddToHistory saves the line in history, but does not execute it.
      [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)

      # RevertLine is like pressing Escape.
      [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  }
}
Set-PSReadLineKeyHandler @parameters
```

You can see many more examples in the file `SamplePSReadLineProfile.ps1` which
is installed in the PSReadLine module folder.

Most key bindings use some helper functions for editing the command line.
Those APIs are documented in the next section.

## Custom Key Binding Support APIs

The following functions are public in Microsoft.PowerShell.PSConsoleReadLine,
but cannot be directly bound to a key. Most are useful in custom key bindings.

```csharp
void AddToHistory(string command)
```

Add a command line to history without executing it.

```csharp
void ClearKillRing()
```

Clear the kill ring.  This is mostly used for testing.

```csharp
void Delete(int start, int length)
```

Delete length characters from start.  This operation supports undo/redo.

```csharp
void Ding()
```

Perform the Ding action based on the users preference.

```csharp
void GetBufferState([ref] string input, [ref] int cursor)
void GetBufferState([ref] Ast ast, [ref] Token[] tokens,
  [ref] ParseError[] parseErrors, [ref] int cursor)
```

These two functions retrieve useful information about the current state of
the input buffer.  The first is more commonly used for simple cases.  The
second is used if your binding is doing something more advanced with the Ast.

```csharp
IEnumerable[Microsoft.PowerShell.KeyHandler]
  GetKeyHandlers(bool includeBound, bool includeUnbound)

```

This function is used by Get-PSReadLineKeyHandler and probably isn't useful in
a custom key binding.

```csharp
Microsoft.PowerShell.PSConsoleReadLineOptions GetOptions()
```

This function is used by Get-PSReadLineOption and probably isn't too useful in
a custom key binding.

```csharp
void GetSelectionState([ref] int start, [ref] int length)
```

If there is no selection on the command line, -1 will be returned in both
start and length. If there is a selection on the command line, the start and
length of the selection are returned.

```csharp
void Insert(char c)
void Insert(string s)
```

Insert a character or string at the cursor.  This operation supports undo/redo.

```csharp
string ReadLine(runspace remoteRunspace,
  System.Management.Automation.EngineIntrinsics engineIntrinsics)
```

This is the main entry point to PSReadLine. It does not support recursion, so
is not useful in a custom key binding.

```csharp
void RemoveKeyHandler(string[] key)
```

This function is used by Remove-PSReadLineKeyHandler and probably isn't too
useful in a custom key binding.

```csharp
void Replace(int start, int length, string replacement)
```

Replace some of the input. This operation supports undo/redo. This is
preferred over Delete followed by Insert because it is treated as a single
action for undo.

```csharp
void SetCursorPosition(int cursor)
```

Move the cursor to the given offset. Cursor movement is not tracked for undo.

```csharp
void SetOptions(Microsoft.PowerShell.SetPSReadLineOption options)
```

This function is a helper method used by the cmdlet Set-PSReadLineOption, but
might be useful to a custom key binding that wants to temporarily change a
setting.

```csharp
bool TryGetArgAsInt(System.Object arg, [ref] int numericArg,
  int defaultNumericArg)
```

This helper method is used for custom bindings that honor DigitArgument. A
typical call looks like

```powershell
[int]$numericArg = 0
[Microsoft.PowerShell.PSConsoleReadLine]::TryGetArgAsInt($arg,
  [ref]$numericArg, 1)
```

## NOTE

### POWERSHELL COMPATIBILITY

PSReadLine requires PowerShell 3.0, or newer, and the console host. It does
not work in PowerShell ISE. It does work in the console of Visual Studio Code.

### FEEDBACK & CONTRIBUTING TO PSREADLINE

[PSReadLine on GitHub](https://github.com/lzybkr/PSReadLine)

Feel free to submit a pull request or submit feedback on the GitHub page.

## SEE ALSO

PSReadLine is heavily influenced by the GNU
[readline](https://tiswww.case.edu/php/chet/readline/rltop.html) library.