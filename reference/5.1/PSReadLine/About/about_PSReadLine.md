---
description: PSReadLine provides an improved command-line editing experience in the PowerShell console.
Locale: en-US
ms.date: 10/04/2021
online version: https://docs.microsoft.com/powershell/module/psreadline/about/about_psreadline?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about PSReadLine
---
# about_PSReadLine

## Short Description

PSReadLine provides an improved command-line editing experience in the
PowerShell console.

## Long Description

PSReadLine 2.0 provides a powerful command-line editing experience for the
PowerShell console. It provides:

- Syntax coloring of the command line
- A visual indication of syntax errors
- A better multi-line experience (both editing and history)
- Customizable key bindings
- Cmd and Emacs modes
- Many configuration options
- Bash style completion (optional in Cmd mode, default in Emacs mode)
- Emacs yank/kill-ring
- PowerShell token based "word" movement and deletion

PSReadLine requires PowerShell 3.0, or newer, and the console host. It does
not work in PowerShell ISE. It does work in the console of Visual Studio Code.

The following functions are available in the class
**[Microsoft.PowerShell.PSConsoleReadLine]**.

## Basic editing functions

### Abort

Abort current action, for example: incremental history search.

- Emacs: <kbd>Ctrl</kbd>+<kbd>g</kbd>

### AcceptAndGetNext

Attempt to execute the current input. If it can be executed (like AcceptLine),
then recall the next item from history the next time ReadLine is called.

- Emacs: <kbd>Ctrl</kbd>+<kbd>o</kbd>

### AcceptLine

Attempt to execute the current input. If the current input is incomplete (for
example there is a missing closing parenthesis, bracket, or quote) then the
continuation prompt is displayed on the next line and PSReadLine waits for
keys to edit the current input.

- Cmd: <kbd>Enter</kbd>
- Emacs: <kbd>Enter</kbd>
- Vi insert mode: <kbd>Enter</kbd>

### AddLine

The continuation prompt is displayed on the next line and PSReadLine waits for
keys to edit the current input. This is useful to enter multi-line input as a
single command even when a single line is complete input by itself.

- Cmd: <kbd>Shift</kbd>+<kbd>Enter</kbd>
- Emacs: <kbd>Shift</kbd>+<kbd>Enter</kbd>
- Vi insert mode: <kbd>Shift</kbd>+<kbd>Enter</kbd>
- Vi command mode: <kbd>Shift</kbd>+<kbd>Enter</kbd>

### BackwardDeleteChar

Delete the character before the cursor.

- Cmd: <kbd>Backspace</kbd>, <kbd>Ctrl</kbd>+<kbd>h</kbd>
- Emacs: <kbd>Backspace</kbd>, <kbd>Ctrl</kbd>+<kbd>Backspace</kbd>, <kbd>Ctrl+<kbd>h</kbd>
- Vi insert mode: <kbd>Backspace</kbd>
- Vi command mode: <kbd>X</kbd>, <kbd>d</kbd>,<kbd>h</kbd>

### BackwardDeleteLine

Like BackwardKillLine - deletes text from the point to the start of the line,
but does not put the deleted text in the kill-ring.

- Cmd: <kbd>Ctrl</kbd>+<kbd>Home</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>u</kbd>, <kbd>Ctrl</kbd>+<kbd>Home</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>u</kbd>, <kbd>Ctrl</kbd>+<kbd>Home</kbd>, <kbd>d,0</kbd>

### BackwardDeleteWord

Deletes the previous word.

- Vi command mode: <kbd>Ctrl</kbd>+<kbd>w</kbd>, <kbd>d,b</kbd>

### BackwardKillLine

Clear the input from the start of the input to the cursor. The cleared text is
placed in the kill-ring.

- Emacs: <kbd>Ctrl</kbd>+<kbd>u</kbd>, <kbd>Ctrl</kbd>+<kbd>x,Backspace</kbd>

### BackwardKillWord

Clear the input from the start of the current word to the cursor. If the
cursor is between words, the input is cleared from the start of the previous
word to the cursor. The cleared text is placed in the kill-ring.

- Cmd: <kbd>Ctrl</kbd>+<kbd>Backspace</kbd>
- Emacs: <kbd>Alt</kbd>+<kbd>Backspace</kbd>, <kbd>Escape,Backspace</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>Backspace</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>Backspace</kbd>

### CancelLine

Cancel the current input, leaving the input on the screen, but returns back to
the host so the prompt is evaluated again.

- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>c</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>c</kbd>

### Copy

Copy selected region to the system clipboard. If no region is selected, copy
the whole line.

- Cmd: <kbd>Ctrl</kbd>+<kbd>C</kbd>

### CopyOrCancelLine

If text is selected, copy to the clipboard, otherwise cancel the line.

- Cmd: <kbd>Ctrl</kbd>+<kbd>c</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>c</kbd>

### Cut

Delete selected region placing deleted text in the system clipboard.

- Cmd: <kbd>Ctrl</kbd>+<kbd>x</kbd>

### DeleteChar

Delete the character under the cursor.

- Cmd: <kbd>Delete</kbd>
- Emacs: <kbd>Delete</kbd>
- Vi insert mode: <kbd>Delete</kbd>
- Vi command mode: <kbd>Delete</kbd>, <kbd>x</kbd>, <kbd>d</kbd>,<kbd>l</kbd>, <kbd>Space</kbd>

### DeleteCharOrExit

Delete the character under the cursor, or if the line is empty, exit the
process.

- Emacs: <kbd>Ctrl</kbd>+<kbd>d</kbd>

### DeleteEndOfWord

Delete to the end of the word.

- Vi command mode: <kbd>d,e</kbd>

### DeleteLine

Deletes the current line, enabling undo.

- Vi command mode: <kbd>d,d</kbd>

### DeleteLineToFirstChar

Deletes text from the cursor to the first non-blank character of the line.

- Vi command mode: <kbd>d,^</kbd>

### DeleteToEnd

Delete to the end of the line.

- Vi command mode: <kbd>D,d,$</kbd>

### DeleteWord

Delete the next word.

- Vi command mode: <kbd>d,w</kbd>

### ForwardDeleteLine

Like ForwardKillLine - deletes text from the point to the end of the line, but
does not put the deleted text in the kill-ring.

- Cmd: <kbd>Ctrl</kbd>+<kbd>End</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>End</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>End</kbd>

### InsertLineAbove

A new empty line is created above the current line regardless of where the
cursor is on the current line. The cursor moves to the beginning of the new
line.

- Cmd: <kbd>Ctrl</kbd>+<kbd>Enter</kbd>

### InsertLineBelow

A new empty line is created below the current line regardless of where the
cursor is on the current line. The cursor moves to the beginning of the new
line.

- Cmd: <kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>Enter</kbd>

### InvertCase

Invert the case of the current character and move to the next one.

- Vi command mode: <kbd>~</kbd>

### KillLine

Clear the input from the cursor to the end of the input. The cleared text is
placed in the kill-ring.

- Emacs: <kbd>Ctrl</kbd>+<kbd>k</kbd>

### KillRegion

Kill the text between the cursor and the mark.

- Function is unbound.

### KillWord

Clear the input from the cursor to the end of the current word. If the cursor
is between words, the input is cleared from the cursor to the end of the next
word. The cleared text is placed in the kill-ring.

- Cmd: <kbd>Ctrl</kbd>+<kbd>Delete</kbd>
- Emacs: <kbd>Alt</kbd>+<kbd>d</kbd>, <kbd>Escape,d</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>Delete</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>Delete</kbd>

### Paste

Paste text from the system clipboard.

- Cmd: <kbd>Ctrl</kbd>+<kbd>v</kbd>, <kbd>Shift</kbd>+<kbd>Insert</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>v</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>v</kbd>

> [!IMPORTANT]
> When using the **Paste** function, the entire contents of the clipboard
> buffer is pasted into the input buffer of PSReadLine. The input buffer is
> then passed to the PowerShell parser. Input pasted using the console
> application's **right-click** paste method is copied to the input buffer one
> character at a time. The input buffer is passed to the parser when a newline
> character is copied. Therefore, the input is parsed one line at a time. The
> difference between paste methods results in different execution behavior.

### PasteAfter

Paste the clipboard after the cursor, moving the cursor to the end of the
pasted text.

- Vi command mode: <kbd>p</kbd>

### PasteBefore

Paste the clipboard before the cursor, moving the cursor to the end of the
pasted text.

- Vi command mode: <kbd>P</kbd>

### PrependAndAccept

Prepend a '#' and accept the line.

- Vi command mode: <kbd>#</kbd>

### Redo

Undo an undo.

- Cmd: <kbd>Ctrl</kbd>+<kbd>y</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>y</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>y</kbd>

### RepeatLastCommand

Repeat the last text modification.

- Vi command mode: <kbd>.</kbd>

### RevertLine

Reverts all input to the current input.

- Cmd: <kbd>Escape</kbd>
- Emacs: <kbd>Alt</kbd>+<kbd>r</kbd>, <kbd>Escape,r</kbd>

### ShellBackwardKillWord

Clear the input from the start of the current word to the cursor. If the
cursor is between words, the input is cleared from the start of the previous
word to the cursor. The cleared text is placed in the kill-ring.

Function is unbound.

### ShellKillWord

Clear the input from the cursor to the end of the current word. If the cursor
is between words, the input is cleared from the cursor to the end of the next
word. The cleared text is placed in the kill-ring.

Function is unbound.

### SwapCharacters

Swap the current character and the one before it.

- Emacs: <kbd>Ctrl</kbd>+<kbd>t</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>t</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>t</kbd>

### Undo

Undo a previous edit.

- Cmd: <kbd>Ctrl</kbd>+<kbd>z</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>_</kbd>, <kbd>Ctrl</kbd>+<kbd>x</kbd>,<kbd>Ctrl</kbd>+<kbd>u</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>z</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>z</kbd>, <kbd>u</kbd>

### UndoAll

Undo all previous edits for line.

- Vi command mode: <kbd>U</kbd>

### UnixWordRubout

Clear the input from the start of the current word to the cursor. If the
cursor is between words, the input is cleared from the start of the previous
word to the cursor. The cleared text is placed in the kill-ring.

- Emacs: <kbd>Ctrl</kbd>+<kbd>w</kbd>

### ValidateAndAcceptLine

Attempt to execute the current input. If the current input is incomplete (for
example there is a missing closing parenthesis, bracket, or quote, then the
continuation prompt is displayed on the next line and PSReadLine waits for
keys to edit the current input.

- Emacs: <kbd>Ctrl</kbd>+<kbd>m</kbd>

### ViAcceptLine

Accept the line and switch to Insert mode.

- Vi command mode: <kbd>Enter</kbd>

### ViAcceptLineOrExit

Like DeleteCharOrExit in Emacs mode, but accepts the line instead of deleting
a character.

- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>d</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>d</kbd>

### ViAppendLine

A new line is inserted below the current line.

- Vi command mode: <kbd>o</kbd>

### ViBackwardDeleteGlob

Deletes the previous word, using only white space as the word delimiter.

- Vi command mode: <kbd>d,B</kbd>

### ViBackwardGlob

Moves the cursor back to the beginning of the previous word, using only white
space as delimiters.

- Vi command mode: <kbd>B</kbd>

### ViDeleteBrace

Find the matching brace, parenthesis, or square bracket and delete all contents
within, including the brace.

- Vi command mode: <kbd>d,%</kbd>

### ViDeleteEndOfGlob

Delete to the end of the word.

- Vi command mode: <kbd>d,E</kbd>

### ViDeleteGlob

Delete the next glob (white space delimited word).

- Vi command mode: <kbd>d,W</kbd>

### ViDeleteToBeforeChar

Deletes until given character.

- Vi command mode: <kbd>d,t</kbd>

### ViDeleteToBeforeCharBackward

Deletes until given character.

- Vi command mode: <kbd>d,T</kbd>

### ViDeleteToChar

Deletes until given character.

- Vi command mode: <kbd>d,f</kbd>

### ViDeleteToCharBackward

Deletes backwards until given character.

- Vi command mode: <kbd>d,F</kbd>

### ViInsertAtBegining

Switch to Insert mode and position the cursor at the beginning of the line.

- Vi command mode: <kbd>I</kbd>

### ViInsertAtEnd

Switch to Insert mode and position the cursor at the end of the line.

- Vi command mode: <kbd>A</kbd>

### ViInsertLine

A new line is inserted above the current line.

- Vi command mode: <kbd>O</kbd>

### ViInsertWithAppend

Append from the current line position.

- Vi command mode: <kbd>a</kbd>

### ViInsertWithDelete

Delete the current character and switch to Insert mode.

- Vi command mode: <kbd>s</kbd>

### ViJoinLines

Joins the current line and the next line.

- Vi command mode: <kbd>J</kbd>

### ViReplaceLine

Erase the entire command line.

- Vi command mode: <kbd>S</kbd>, <kbd>c,c</kbd>

### ViReplaceToBeforeChar

Replaces until given character.

- Vi command mode: <kbd>c,t</kbd>

### ViReplaceToBeforeCharBackward

Replaces until given character.

- Vi command mode: <kbd>c,T</kbd>

### ViReplaceToChar

Deletes until given character.

- Vi command mode: <kbd>c,f</kbd>

### ViReplaceToCharBackward

Replaces until given character.

- Vi command mode: <kbd>c,F</kbd>

### ViYankBeginningOfLine

Yank from the beginning of the buffer to the cursor.

- Vi command mode: <kbd>y,0</kbd>

### ViYankEndOfGlob

Yank from the cursor to the end of the WORD(s).

- Vi command mode: <kbd>y,E</kbd>

### ViYankEndOfWord

Yank from the cursor to the end of the word(s).

- Vi command mode: <kbd>y,e</kbd>

### ViYankLeft

Yank character(s) to the left of the cursor.

- Vi command mode: <kbd>y,h</kbd>

### ViYankLine

Yank the entire buffer.

- Vi command mode: <kbd>y,y</kbd>

### ViYankNextGlob

Yank from cursor to the start of the next WORD(s).

- Vi command mode: <kbd>y,W</kbd>

### ViYankNextWord

Yank the word(s) after the cursor.

- Vi command mode: <kbd>y,w</kbd>

### ViYankPercent

Yank to/from matching brace.

- Vi command mode: <kbd>y,%</kbd>

### ViYankPreviousGlob

Yank from beginning of the WORD(s) to cursor.

- Vi command mode: <kbd>y,B</kbd>

### ViYankPreviousWord

Yank the word(s) before the cursor.

- Vi command mode: <kbd>y,b</kbd>

### ViYankRight

Yank character(s) under and to the right of the cursor.

- Vi command mode: <kbd>y,l</kbd>, <kbd>y,Space</kbd>

### ViYankToEndOfLine

Yank from the cursor to the end of the buffer.

- Vi command mode: <kbd>y,$</kbd>

### ViYankToFirstChar

Yank from the first non-whitespace character to the cursor.

- Vi command mode: <kbd>y,^</kbd>

### Yank

Add the most recently killed text to the input.

- Emacs: <kbd>Ctrl</kbd>+<kbd>y</kbd>

### YankLastArg

Yank the last argument from the previous history line. With an argument, the
first time it is invoked, behaves just like YankNthArg. If invoked multiple
times, instead it iterates through history and arg sets the direction
(negative reverses the direction.)

- Cmd: <kbd>Alt</kbd>+<kbd>.</kbd>
- Emacs: <kbd>Alt</kbd>+<kbd>.</kbd>, <kbd>Alt</kbd>+<kbd>\_</kbd>, <kbd>Escape,.</kbd>, <kbd>Escape,_</kbd>

### YankNthArg

Yank the first argument (after the command) from the previous history line.
With an argument, yank the nth argument (starting from 0), if the argument is
negative, start from the last argument.

- Emacs: <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>y</kbd>, <kbd>Escape,Ctrl</kbd>+<kbd>y</kbd>

### YankPop

If the previous operation was Yank or YankPop, replace the previously yanked
text with the next killed text from the kill-ring.

- Emacs: <kbd>Alt</kbd>+<kbd>y</kbd>, <kbd>Escape,y</kbd>

## Cursor movement functions

### BackwardChar

Move the cursor one character to the left. This may move the cursor to the
previous line of multi-line input.

- Cmd: <kbd>LeftArrow</kbd>
- Emacs: <kbd>LeftArrow</kbd>, <kbd>Ctrl</kbd>+<kbd>b</kbd>
- Vi insert mode: <kbd>LeftArrow</kbd>
- Vi command mode: <kbd>LeftArrow</kbd>, <kbd>Backspace</kbd>, <kbd>h</kbd>

### BackwardWord

Move the cursor back to the start of the current word, or if between words,
the start of the previous word. Word boundaries are defined by a configurable
set of characters.

- Cmd: <kbd>Ctrl</kbd>+<kbd>LeftArrow</kbd>
- Emacs: <kbd>Alt</kbd>+<kbd>b</kbd>, <kbd>Escape,b</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>LeftArrow</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>LeftArrow</kbd>

### BeginningOfLine

If the input has multiple lines, move to the start of the current line, or if
already at the start of the line, move to the start of the input. If the input
has a single line, move to the start of the input.

- Cmd: <kbd>Home</kbd>
- Emacs: <kbd>Home</kbd>, <kbd>Ctrl</kbd>+<kbd>a</kbd>
- Vi insert mode: <kbd>Home</kbd>
- Vi command mode: <kbd>Home</kbd>

### EndOfLine

If the input has multiple lines, move to the end of the current line, or if
already at the end of the line, move to the end of the input. If the input has
a single line, move to the end of the input.

- Cmd: <kbd>End</kbd>
- Emacs: <kbd>End</kbd>, <kbd>Ctrl</kbd>+<kbd>e</kbd>
- Vi insert mode: <kbd>End</kbd>

### ForwardChar

Move the cursor one character to the right. This may move the cursor to the
next line of multi-line input.

- Cmd: <kbd>RightArrow</kbd>
- Emacs: <kbd>RightArrow</kbd>, <kbd>Ctrl</kbd>+<kbd>f</kbd>
- Vi insert mode: <kbd>RightArrow</kbd>
- Vi command mode: <kbd>RightArrow</kbd>, <kbd>Space</kbd>, <kbd>l</kbd>

### ForwardWord

Move the cursor forward to the end of the current word, or if between words,
to the end of the next word. Word boundaries are defined by a configurable set
of characters.

- Emacs: <kbd>Alt</kbd>+<kbd>f</kbd>, <kbd>Escape,f</kbd>

### GotoBrace

Go to the matching brace, parenthesis, or square bracket.

- Cmd: <kbd>Ctrl</kbd>+<kbd>]</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>]</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>]</kbd>

### GotoColumn

Move to the column indicated by arg.

- Vi command mode: <kbd>|</kbd>

### GotoFirstNonBlankOfLine

Move the cursor to the first non-blank character in the line.

- Vi command mode: <kbd>^</kbd>

### MoveToEndOfLine

Move the cursor to the end of the input.

- Vi command mode: <kbd>End</kbd>, <kbd>$</kbd>

### NextLine

Move the cursor to the next line.

- Function is unbound.

### NextWord

Move the cursor forward to the start of the next word. Word boundaries are
defined by a configurable set of characters.

- Cmd: <kbd>Ctrl</kbd>+<kbd>RightArrow</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>RightArrow</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>RightArrow</kbd>

### NextWordEnd

Move the cursor forward to the end of the current word, or if between words,
to the end of the next word. Word boundaries are defined by a configurable set
of characters.

- Vi command mode: <kbd>e</kbd>

### PreviousLine

Move the cursor to the previous line.

- Function is unbound.

### ShellBackwardWord

Move the cursor back to the start of the current word, or if between words,
the start of the previous word. Word boundaries are defined by PowerShell
tokens.

- Function is unbound.

### ShellForwardWord

Move the cursor forward to the start of the next word. Word boundaries are
defined by PowerShell tokens.

- Function is unbound.

### ShellNextWord

Move the cursor forward to the end of the current word, or if between words,
to the end of the next word. Word boundaries are defined by PowerShell tokens.

- Function is unbound.

### ViBackwardWord

Move the cursor back to the start of the current word, or if between words,
the start of the previous word. Word boundaries are defined by a configurable
set of characters.

- Vi command mode: <kbd>b</kbd>

### ViEndOfGlob

Moves the cursor to the end of the word, using only white space as delimiters.

- Vi command mode: <kbd>E</kbd>

### ViEndOfPreviousGlob

Moves to the end of the previous word, using only white space as a word
delimiter.

- Function is unbound.

### ViGotoBrace

Similar to GotoBrace, but is character based instead of token based.

- Vi command mode: <kbd>%</kbd>

### ViNextGlob

Moves to the next word, using only white space as a word delimiter.

- Vi command mode: <kbd>W</kbd>

### ViNextWord

Move the cursor forward to the start of the next word. Word boundaries are
defined by a configurable set of characters.

- Vi command mode: <kbd>w</kbd>

## History functions

### BeginningOfHistory

Move to the first item in the history.

- Emacs: <kbd>Alt</kbd>+<kbd><</kbd>

### ClearHistory

Clears history in PSReadLine. This does not affect PowerShell history.

- Cmd: <kbd>Alt</kbd>+<kbd>F7</kbd>

### EndOfHistory

Move to the last item (the current input) in the history.

- Emacs: <kbd>Alt</kbd>+<kbd>></kbd>

### ForwardSearchHistory

Perform an incremental forward search through history.

- Cmd: <kbd>Ctrl</kbd>+<kbd>s</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>s</kbd>

### HistorySearchBackward

Replace the current input with the 'previous' item from PSReadLine history
that matches the characters between the start and the input and the cursor.

- Cmd: <kbd>F8</kbd>

### HistorySearchForward

Replace the current input with the 'next' item from PSReadLine history that
matches the characters between the start and the input and the cursor.

- Cmd: <kbd>Shift</kbd>+<kbd>F8</kbd>

### NextHistory

Replace the current input with the 'next' item from PSReadLine history.

- Cmd: `<DownArrow>`
- Emacs: `<DownArrow>`, `<Ctrl+n>`
- Vi insert mode: `<DownArrow>`
- Vi command mode: `<DownArrow>`, `<j>`, `<+>`

### PreviousHistory

Replace the current input with the 'previous' item from PSReadLine history.

- Cmd: <kbd>UpArrow</kbd>
- Emacs: <kbd>UpArrow</kbd>, <kbd>Ctrl</kbd>+<kbd>p</kbd>
- Vi insert mode: <kbd>UpArrow</kbd>
- Vi command mode: <kbd>UpArrow</kbd>, <kbd>k</kbd>, <kbd>-</kbd>

### ReverseSearchHistory

Perform an incremental backward search through history.

- Cmd: <kbd>Ctrl</kbd>+<kbd>r</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>r</kbd>

### ViSearchHistoryBackward

Prompts for a search string and initiates search upon AcceptLine.

- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>r</kbd>
- Vi command mode: <kbd>/</kbd>, <kbd>Ctrl</kbd>+<kbd>r</kbd>

## Completion functions

### Complete

Attempt to perform completion on the text surrounding the cursor. If there are
multiple possible completions, the longest unambiguous prefix is used for
completion. If trying to complete the longest unambiguous completion, a list
of possible completions is displayed.

- Emacs: <kbd>Tab</kbd>

### MenuComplete

Attempt to perform completion on the text surrounding the cursor. If there are
multiple possible completions, the longest unambiguous prefix is used for
completion. If trying to complete the longest unambiguous completion, a list
of possible completions is displayed.

- Cmd: <kbd>Ctrl</kbd>+<kbd>Space</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>Space</kbd>

### PossibleCompletions

Display the list of possible completions.

- Emacs: <kbd>Alt</kbd>+<kbd>=</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>Space</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>Space</kbd>

### TabCompleteNext

Attempt to complete the text surrounding the cursor with the next available
completion.

- Cmd: <kbd>Tab</kbd>
- Vi command mode: <kbd>Tab</kbd>

### TabCompletePrevious

Attempt to complete the text surrounding the cursor with the previous
available completion.

- Cmd: <kbd>Shift</kbd>+<kbd>Tab</kbd>
- Vi command mode: <kbd>Shift</kbd>+<kbd>Tab</kbd>

### ViTabCompleteNext

Ends the current edit group, if needed, and invokes TabCompleteNext.

- Vi insert mode: <kbd>Tab</kbd>

### ViTabCompletePrevious

Ends the current edit group, if needed, and invokes TabCompletePrevious.

- Vi insert mode: <kbd>Shift</kbd>+<kbd>Tab</kbd>

## Miscellaneous functions

### CaptureScreen

Start interactive screen capture - up/down arrows select lines, enter copies
selected text to clipboard as text and HTML.

- Function is unbound.

### ClearScreen

Clear the screen and draw the current line at the top of the screen.

- Cmd: <kbd>Ctrl</kbd>+<kbd>l</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>l</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>l</kbd>
- Vi command mode: <kbd>Ctrl</kbd>+<kbd>l</kbd>

### DigitArgument

Start a new digit argument to pass to other functions.

- Cmd: <kbd>Alt</kbd>+<kbd>0</kbd>, <kbd>Alt</kbd>+<kbd>1</kbd>, <kbd>Alt</kbd>+<kbd>2</kbd>, <kbd>Alt</kbd>+<kbd>3</kbd>, <kbd>Alt</kbd>+<kbd>4</kbd>, <kbd>Alt</kbd>+<kbd>5</kbd>,
  <kbd>Alt</kbd>+<kbd>6</kbd>, <kbd>Alt</kbd>+<kbd>7</kbd>, <kbd>Alt</kbd>+<kbd>8</kbd>, <kbd>Alt</kbd>+<kbd>9</kbd>, <kbd>Alt</kbd>+<kbd>-</kbd>
- Emacs: <kbd>Alt</kbd>+<kbd>0</kbd>, <kbd>Alt</kbd>+<kbd>1</kbd>, <kbd>Alt</kbd>+<kbd>2</kbd>, <kbd>Alt</kbd>+<kbd>3</kbd>, <kbd>Alt</kbd>+<kbd>4</kbd>, <kbd>Alt</kbd>+<kbd>5</kbd>,
  <kbd>Alt</kbd>+<kbd>6</kbd>, <kbd>Alt</kbd>+<kbd>7</kbd>, <kbd>Alt</kbd>+<kbd>8</kbd>, <kbd>Alt</kbd>+<kbd>9</kbd>, <kbd>Alt</kbd>+<kbd>-</kbd>
- Vi command mode: <kbd>0</kbd>, <kbd>1</kbd>, <kbd>2</kbd>, <kbd>3</kbd>, <kbd>4</kbd>, <kbd>5</kbd>, <kbd>6</kbd>, <kbd>7</kbd>,
  <kbd>8</kbd>, <kbd>9</kbd>

### InvokePrompt

Erases the current prompt and calls the prompt function to redisplay the
prompt. Useful for custom key handlers that change state, e.g. change the
current directory.

- Function is unbound.

### ScrollDisplayDown

Scroll the display down one screen.

- Cmd: <kbd>PageDown</kbd>
- Emacs: <kbd>PageDown</kbd>

### ScrollDisplayDownLine

Scroll the display down one line.

- Cmd: <kbd>Ctrl</kbd>+<kbd>PageDown</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>PageDown</kbd>

### ScrollDisplayToCursor

Scroll the display to the cursor.

- Emacs: <kbd>Ctrl</kbd>+<kbd>End</kbd>

### ScrollDisplayTop

Scroll the display to the top.

- Emacs: <kbd>Ctrl</kbd>+<kbd>Home</kbd>

### ScrollDisplayUp

Scroll the display up one screen.

- Cmd: <kbd>PageUp</kbd>
- Emacs: <kbd>PageUp</kbd>

### ScrollDisplayUpLine

Scroll the display up one line.

- Cmd: <kbd>Ctrl</kbd>+<kbd>PageUp</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>PageUp</kbd>

### SelfInsert

Insert the key.

- Function is unbound.

### ShowKeyBindings

Show all bound keys.

- Cmd: <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>?</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>?</kbd>
- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>?</kbd>

### ViCommandMode

Switch the current operating mode from Vi-Insert to Vi-Command.

- Vi insert mode: <kbd>Escape</kbd>

### ViDigitArgumentInChord

Start a new digit argument to pass to other functions while in one of vi's
chords.

- Function is unbound.

### ViEditVisually

Edit the command line in a text editor specified by $env:EDITOR or
$env:VISUAL.

- Emacs: <kbd>Ctrl</kbd>+<kbd>x,Ctrl</kbd>+<kbd>e</kbd>
- Vi command mode: <kbd>v</kbd>

### ViExit

Exits the shell.

- Function is unbound.

### ViInsertMode

Switch to Insert mode.

- Vi command mode: <kbd>i</kbd>

### WhatIsKey

Read a key and tell me what the key is bound to.

- Cmd: <kbd>Alt</kbd>+<kbd>?</kbd>
- Emacs: <kbd>Alt</kbd>+<kbd>?</kbd>

## Selection functions

### ExchangePointAndMark

The cursor is placed at the location of the mark and the mark is moved to the
location of the cursor.

- Emacs: <kbd>Ctrl</kbd>+<kbd>x,Ctrl</kbd>+<kbd>x</kbd>

### SelectAll

Select the entire line.

- Cmd: <kbd>Ctrl</kbd>+<kbd>a</kbd>

### SelectBackwardChar

Adjust the current selection to include the previous character.

- Cmd: <kbd>Shift</kbd>+<kbd>LeftArrow</kbd>
- Emacs: <kbd>Shift</kbd>+<kbd>LeftArrow</kbd>

### SelectBackwardsLine

Adjust the current selection to include from the cursor to the start of the
line.

- Cmd: <kbd>Shift</kbd>+<kbd>Home</kbd>
- Emacs: <kbd>Shift</kbd>+<kbd>Home</kbd>

### SelectBackwardWord

Adjust the current selection to include the previous word.

- Cmd: <kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>LeftArrow</kbd>
- Emacs: <kbd>Alt</kbd>+<kbd>B</kbd>

### SelectForwardChar

Adjust the current selection to include the next character.

- Cmd: <kbd>Shift</kbd>+<kbd>RightArrow</kbd>
- Emacs: <kbd>Shift</kbd>+<kbd>RightArrow</kbd>

### SelectForwardWord

Adjust the current selection to include the next word using ForwardWord.

- Emacs: <kbd>Alt</kbd>+<kbd>F</kbd>

### SelectLine

Adjust the current selection to include from the cursor to the end of the line.

- Cmd: <kbd>Shift</kbd>+<kbd>End</kbd>
- Emacs: <kbd>Shift</kbd>+<kbd>End</kbd>

### SelectNextWord

Adjust the current selection to include the next word.

- Cmd: <kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>RightArrow</kbd>

### SelectShellBackwardWord

Adjust the current selection to include the previous word using
ShellBackwardWord.

- Function is unbound.

### SelectShellForwardWord

Adjust the current selection to include the next word using ShellForwardWord.

- Function is unbound.

### SelectShellNextWord

Adjust the current selection to include the next word using ShellNextWord.

- Function is unbound.

### SetMark

Mark the current location of the cursor for use in a subsequent editing
command.

- Emacs: <kbd>Ctrl</kbd>+<kbd><kbd>/kbd>

## Search functions

### CharacterSearch

Read a character and search forward for the next occurrence of that character.
If an argument is specified, search forward (or backward if negative) for the
nth occurrence.

- Cmd: <kbd>F3</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>]</kbd>
- Vi insert mode: <kbd>F3</kbd>
- Vi command mode: <kbd>F3</kbd>

### CharacterSearchBackward

Read a character and search backward for the next occurrence of that character. If an
argument is specified, search backward (or forward if negative) for the nth
occurrence.

- Cmd: <kbd>Shift</kbd>+<kbd>F3</kbd>
- Emacs: <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>]</kbd>
- Vi insert mode: <kbd>Shift</kbd>+<kbd>F3</kbd>
- Vi command mode: <kbd>Shift</kbd>+<kbd>F3</kbd>

### RepeatLastCharSearch

Repeat the last recorded character search.

- Vi command mode: <kbd>;</kbd>

### RepeatLastCharSearchBackwards

Repeat the last recorded character search, but in the opposite direction.

- Vi command mode: <kbd>,</kbd>

### RepeatSearch

Repeat the last search in the same direction as before.

- Vi command mode: <kbd>n</kbd>

### RepeatSearchBackward

Repeat the last search in the same direction as before.

- Vi command mode: <kbd>N</kbd>

### SearchChar

Read the next character and then find it, going forward, and then back off a
character. This is for 't' functionality.

- Vi command mode: <kbd>f</kbd>

### SearchCharBackward

Read the next character and then find it, going backward, and then back off a
character. This is for 'T' functionality.

- Vi command mode: <kbd>F</kbd>

### SearchCharBackwardWithBackoff

Read the next character and then find it, going backward, and then back off a
character. This is for 'T' functionality.

- Vi command mode: <kbd>T</kbd>

### SearchCharWithBackoff

Read the next character and then find it, going forward, and then back off a
character. This is for 't' functionality.

- Vi command mode: <kbd>t</kbd>

### SearchForward

Prompts for a search string and initiates search upon AcceptLine.

- Vi insert mode: <kbd>Ctrl</kbd>+<kbd>s</kbd>
- Vi command mode: <kbd>?</kbd>, <kbd>Ctrl</kbd>+<kbd>s</kbd>

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
- opening a new window (for example, help)
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

Clear the kill-ring.  This is mostly used for testing.

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

## Notes

### Command History

PSReadLine maintains a history file containing all the commands and data you have entered from the
command line. This may contain sensitive data including passwords. For example, if you use the
`ConvertTo-SecureString` cmdlet the password is logged in the history file as plain text. The
history files is a file named `$($host.Name)_history.txt`. On Windows systems the history file is
stored at `$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine`.

### Feedback & Contributing To PSReadLine

[PSReadLine on GitHub](https://github.com/PowerShell/PSReadLine)

Feel free to submit a pull request or submit feedback on the GitHub page.

## See Also

PSReadLine is heavily influenced by the GNU
[readline](https://tiswww.case.edu/php/chet/readline/rltop.html) library.
