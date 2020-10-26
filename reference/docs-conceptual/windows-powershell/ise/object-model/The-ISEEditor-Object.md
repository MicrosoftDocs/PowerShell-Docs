---
ms.date:  12/31/2019
title:  The ISEEditor Object
description: An ISEEditor object is an instance of the Microsoft.PowerShell.Host.ISE.ISEEditor class. The Console pane is an ISEEditor object.
---

# The ISEEditor Object

An **ISEEditor** object is an instance of the Microsoft.PowerShell.Host.ISE.ISEEditor class. The
Console pane is an **ISEEditor** object. Each [ISEFile](The-ISEFile-Object.md) object has an
associated **ISEEditor** object. The following sections list the methods and properties of an
**ISEEditor** object.

## Methods

### Clear\(\)

Supported in Windows PowerShell ISE 2.0 and later.

Clears the text in the editor.

```powershell
# Clears the text in the Console pane.
$psISE.CurrentPowerShellTab.ConsolePane.Clear()
```

### EnsureVisible\(int lineNumber\)

Supported in Windows PowerShell ISE 2.0 and later.

Scrolls the editor so that the line that corresponds to the specified **lineNumber** parameter value
is visible. It throws an exception if the specified line number is outside the range of 1,last line
number, which defines the valid line numbers.

**lineNumber**
The number of the line that is to be made visible.

```powershell
# Scrolls the text in the Script pane so that the fifth line is in view.
$psISE.CurrentFile.Editor.EnsureVisible(5)
```

### Focus\(\)

Supported in Windows PowerShell ISE 2.0 and later.

Sets the focus to the editor.

```powershell
# Sets focus to the Console pane.
$psISE.CurrentPowerShellTab.ConsolePane.Focus()
```

### GetLineLength\(int lineNumber \)

Supported in Windows PowerShell ISE 2.0 and later.

Gets the line length as an integer for the line that is specified by the line number.

**lineNumber**
The number of the line of which to get the length.

**Returns**
The line length for the line at the specified line number.

```powershell
# Gets the length of the first line in the text of the Command pane.
$psISE.CurrentPowerShellTab.ConsolePane.GetLineLength(1)
```

### GoToMatch\(\)

Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

Moves the caret to the matching character if the **CanGoToMatch** property of the editor object is
`$true`, which occurs when the caret is immediately before an opening parenthesis, bracket, or
brace - `(`,`[`,`{` - or immediately after a closing parenthesis, bracket, or brace - `)`,`]`,`}`. The caret
is placed before an opening character or after a closing character. If the **CanGoToMatch** property
is `$false`, then this method does nothing.

```powershell
# Goes to the matching character if CanGoToMatch() is $true
$psISE.CurrentPowerShellTab.ConsolePane.GoToMatch()
```

### InsertText\( text \)

Supported in Windows PowerShell ISE 2.0 and later.

Replaces the selection with text or inserts text at the current caret position.

**text** - String
The text to insert.

See the [Scripting Example](#scripting-example) later in this topic.

### Select\( startLine, startColumn, endLine, endColumn \)

Supported in Windows PowerShell ISE 2.0 and later.

Selects the text from the **startLine**, **startColumn**, **endLine**, and **endColumn** parameters.

**startLine** - Integer
The line where the selection starts.

**startColumn** - Integer
The column within the start line where the selection starts.

**endLine** - Integer
The line where the selection ends.

**endColumn** - Integer
The column within the end line where the selection ends.

See the  [Scripting Example](#scripting-example) later in this topic.

### SelectCaretLine\(\)

Supported in Windows PowerShell ISE 2.0 and later.

Selects the entire line of text that currently contains the caret.

```powershell
# First, set the caret position on line 5.
$psISE.CurrentFile.Editor.SetCaretPosition(5,1)
# Now select that entire line of text
$psISE.CurrentFile.Editor.SelectCaretLine()
```

### SetCaretPosition\( lineNumber, columnNumber \)

Supported in Windows PowerShell ISE 2.0 and later.

Sets the caret position at the line number and the column number. It throws an exception if either
the caret line number or the caret column number are out of their respective valid ranges.

**lineNumber** - Integer
The caret line number.

**columnNumber** - Integer
The caret column number.

```powershell
# Set the CaretPosition.
$psISE.CurrentFile.Editor.SetCaretPosition(5,1)
```

### ToggleOutliningExpansion\(\)

Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

Causes all the outline sections to expand or collapse.

```powershell
# Toggle the outlining expansion
$psISE.CurrentFile.Editor.ToggleOutliningExpansion()
```

## Properties

### CanGoToMatch

Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

The read-only Boolean property to indicate whether the caret is next to a parenthesis, bracket, or
brace - `()`, `[]`, `{}`. If the caret is immediately before the opening character or immediately
after the closing character of a pair, then this property value is `$true`. Otherwise, it is
`$false`.

```powershell
# Test to see if the caret is next to a parenthesis, bracket, or brace
$psISE.CurrentFile.Editor.CanGoToMatch
```

### CaretColumn

Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the column number that corresponds to the position of the caret.

```powershell
# Get the CaretColumn.
$psISE.CurrentFile.Editor.CaretColumn
```

### CaretLine

Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the number of the line that contains the caret.

```powershell
# Get the CaretLine.
$psISE.CurrentFile.Editor.CaretLine
```

### CaretLineText

Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the complete line of text that contains the caret.

```powershell
# Get all of the text on the line that contains the caret.
$psISE.CurrentFile.Editor.CaretLineText
```

### LineCount

Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the line count from the editor.

```powershell
# Get the LineCount.
$psISE.CurrentFile.Editor.LineCount
```

### SelectedText

Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the selected text from the editor.

See the  [Scripting Example](#scripting-example) later in this topic.

### Text

Supported in Windows PowerShell ISE 2.0 and later.

The read/write property that gets or sets the text in the editor.

See the [Scripting Example](#scripting-example) later in this topic.

## Scripting Example

```powershell
# This illustrates how you can use the length of a line to
# select the entire line and shows how you can make it lowercase.
# You must run this in the Console pane. It will not run in the Script pane.
# Begin by getting a variable that points to the editor.
$myEditor = $psISE.CurrentFile.Editor
# Clear the text in the current file editor.
$myEditor.Clear()

# Make sure the file has five lines of text.
$myEditor.InsertText("LINE1 `n")
$myEditor.InsertText("LINE2 `n")
$myEditor.InsertText("LINE3 `n")
$myEditor.InsertText("LINE4 `n")
$myEditor.InsertText("LINE5 `n")

# Use the GetLineLength method to get the length of the third line.
$endColumn = $myEditor.GetLineLength(3)
# Select the text in the first three lines.
$myEditor.Select(1, 1, 3, $endColumn + 1)
$selection = $myEditor.SelectedText
# Clear all the text in the editor.
$myEditor.Clear()
# Add the selected text back, but in lower case.
$myEditor.InsertText($selection.ToLower())
```

## See Also

- [The ISEFile Object](The-ISEFile-Object.md)
- [The PowerShellTab Object](The-PowerShellTab-Object.md)
- [Purpose of the Windows PowerShell ISE Scripting Object Model](Purpose-of-the-Windows-PowerShell-ISE-Scripting-Object-Model.md)
- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)
