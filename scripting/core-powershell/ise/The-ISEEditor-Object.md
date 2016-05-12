---
title:  The ISEEditor Object
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  0101daf8-4e31-4e4c-ab89-01d95dcb8f46
---

# The ISEEditor Object
  An **ISEEditor** object is an instance of the Microsoft.PowerShell.Host.ISE.ISEEditor class. The Console pane is an **ISEEditor** object. Each [ISEFile](The-ISEFile-Object.md) object has an associated **ISEEditor** object. The following sections list the methods and properties of an **ISEEditor** object.

## Methods

### Clear\(\)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Clears the text in the editor.

```
# Clears the text in the Console pane.
$psIse.CurrentPowerShellTab.ConsolePane.Clear()

```

### EnsureVisible\(int lineNumber\)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Scrolls the editor so that the line that corresponds to the specified **lineNumber** parameter value is visible. It throws an exception if the specified line number is outside the range of 1,last line number, which defines the valid line numbers.

 **lineNumber**
 The number of the line that is to be made visible.

```
# Scrolls the text in the Script pane so that the fifth line is in view. 
$psIse.CurrentFile.Editor.EnsureVisible(5)

```

### Focus\(\)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Sets the focus to the editor.

```
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

```
# Gets the length of the first line in the text of the Command pane. 
$psIse.CurrentPowerShellTab.ConsolePane.GetLineLength(1)
```

### GoToMatch\(\)
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 Moves the caret to the matching character if the **CanGoToMatch** property of the editor object is **$true**, which occurs when the caret is immediately before an opening parenthesis, bracket, or brace \- \(,\[,{ \- or immediately after a closing parenthesis, bracket, or brace \- \),\],}.  The caret is placed before an opening character or after a closing character. If the **CanGoToMatch** property is **$false**, then this method does nothing. See [CanGoToMatch](#cangotomatch).

```
# Test to see if the caret is next to a parenthesis, bracket, or brace.
```

### InsertText\( text \)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Replaces the selection with text or inserts text at the current caret position.

 **text** \- String
 The text to insert.

 See the [Scripting Example](#example) later in this topic.

### Select\( startLine, startColumn, endLine, endColumn \)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Selects the text from the **startLine**, **startColumn**, **endLine**, and **endColumn** parameters.

 **startLine** \- Integer
 The line where the selection starts.

 **startColumn** \- Integer
 The column within the start line where the selection starts.

 **endLine** \- Integer
 The line where the selection ends.

 **endColumn** \- Integer
 The column within the end line where the selection ends.

 See the  [Scripting Example](#example) later in this topic.

### SelectCaretLine\(\)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Selects the entire line of text that currently contains the caret.

```
# First, set the caret position on line 5.
$psIse.CurrentFile.Editor.SetCaretPosition(5,1) 
# Now select that entire line of text
$psIse.CurrentFile.Editor.SelectCaretLine()

```

### SetCaretPosition\( lineNumber, columnNumber \)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Sets the caret position at the line number and the column number. It throws an exception if either the caret line number  or the caret column number  are out of their respective valid ranges.

 **lineNumber** \- Integer
 The caret line number.

 **columnNumber** \- Integer
 The caret column number.

```
# Set the CaretPosition.
$psIse.CurrentFile.Editor.SetCaretPosition(5,1)
```

### ToggleOutliningExpansion\(\)
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 Causes all the outline sections to expand or collapse.

```
# Toggle the outlining expansion
$psIse.CurrentFile.Editor.ToggleOutliningExpansion()

```

## Properties

###  <a name="CanGoToMatch"></a> CanGoToMatch
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 The read\-only Boolean property to indicate whether the caret is next to a parenthesis, bracket, or brace – \(\), \[\], {}. If the caret is immediately before the opening character or immediately after the closing character of a pair, then this property value is **$true**. Otherwise, it is **$false**.

```
# Test to see if the caret is next to a parenthesis, bracket, or brace
$psIse.CurrentFile.Editor.CanGoToMatch

```

###  <a name="CaretColumn"></a> CaretColumn
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\-only property that gets the column number that corresponds to the position of the caret.

```
# Get the CaretColumn.
$psIse.CurrentFile.Editor.CaretColumn

```

###  <a name="CaretLine"></a> CaretLine
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\-only property that gets the number of the line that contains the caret.

```
# Get the CaretLine.
$psIse.CurrentFile.Editor.CaretLine

```

###  <a name="caretlinetext"></a> CaretLineText
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\-only property that gets the complete line of text that contains the caret.

```
# Get all of the text on the line that contains the caret.
$psIse.CurrentFile.Editor.CaretLineText

```

###  <a name="LineCount"></a> LineCount
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\-only property that gets the line count from the editor.

```
# Get the LineCount.
$psIse.CurrentFile.Editor.LineCount

```

###  <a name="SelectedText"></a> SelectedText
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\-only property that gets the selected text from the editor.

 See the  [Scripting Example](#example) later in this topic.

###  <a name="Text"></a> Text
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\/write property that gets or sets the text in the editor.

 See the [Scripting Example](#example) later in this topic.

##  <a name="example"></a> Scripting Example

```

# This illustrates how you can use the length of a line to
# select the entire line and shows how you can make it lowercase. 
# You must run this in the Console pane. It will not run in the Script pane.
# Begin by getting a variable that points to the editor.
$myEditor=$psIse.CurrentFile.Editor
# Clear the text in the current file editor.
$myEditor.Clear()

# Make sure the file has five lines of text.
$myEditor.InsertText("LINE1 `n")
$myEditor.InsertText("LINE2 `n")
$myEditor.InsertText("LINE3 `n")
$myEditor.InsertText("LINE4 `n")
$myEditor.InsertText("LINE5 `n")

# Use the GetLineLength method to get the length of the third line. 
$endColumn= $myEditor.GetLineLength(3)
# Select the text in the first three lines.
$myEditor.Select(1,1,3,$endColumn + 1)
$selection = $myEditor.SelectedText
# Clear all the text in the editor.
$myEditor.Clear()
# Add the selected text back, but in lower case.
$myEditor.InsertText($selection.ToLower())
```

## See Also
 [The ISEFile Object](The-ISEFile-Object.md) 
 [The PowerShellTab Object](The-PowerShellTab-Object.md) 
 [The Windows PowerShell ISE Scripting Object Model](The-Windows-PowerShell-ISE-Scripting-Object-Model.md) 
 [Windows PowerShell ISE Object Model Reference](Windows-PowerShell-ISE-Object-Model-Reference.md) 
 [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)

  
