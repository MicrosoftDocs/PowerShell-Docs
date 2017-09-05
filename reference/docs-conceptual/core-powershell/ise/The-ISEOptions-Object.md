---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  The ISEOptions Object
ms.assetid:  75e2a76f-f3d1-490b-ad5d-e3829946aabb
---

# The ISEOptions Object
  The **ISEOptions** object represents various settings for Windows PowerShell ISE. It is an instance of the **Microsoft.PowerShell.Host.ISE.ISEOptions** class.

 The **ISEOptions** object provides the following methods and properties.

## Methods

### RestoreDefaultConsoleTokenColors\(\)
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Restores the default values of the token colors in the Console pane.

```
# Changes the color of the commands in the Console pane to red and then restores it to its default value.
$psISE.Options.ConsoleTokenColors["Command"] = "red"
$psISE.Options.RestoreDefaultConsoleTokenColors()
```

### RestoreDefaults\(\)
  Supported in Windows PowerShell ISE 2.0 and later.

 Restores the default values of all options settings in the Console pane. It also resets the behavior of various warning messages that provide the standard check box to prevent the message from being shown again.

```
# Changes the background color in the Console pane and then restores it to its default value.
$psISE.Options.ConsolePaneBackgroundColor = "orange"
$psISE.Options.RestoreDefaults()
```

### RestoreDefaultTokenColors\(\)
  Supported in Windows PowerShell ISE 2.0 and later.

 Restores the default values of the token colors in the Script pane.

```
# Changes the color of the comments in the Script pane to red and then restores it to its default value.
$psISE.Options.TokenColors["Comment"]="red"
$psISE.Options.RestoreDefaultTokenColors()
```

### RestoreDefaultXmlTokenColors\(\)
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Restores the default values of the token colors for XML elements that are displayed in Windows PowerShell ISE. Also see [XmlTokenColors](#xmltokencolors).

```
# Changes the color of the comments in XML data to red and then restores it to its default value.
$psISE.Options.XmlTokenColors["Comment"]="red"
$psISE.Options.RestoreDefaultXmlTokenColors()
```

## Properties

### AutoSaveMinuteInterval
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies the number of minutes between automatic save operations of your files by Windows PowerShell ISE. The default value is 2 minutes. The value is an integer.

```
# Changes the number of minutes between automatic save operations to every 3 minutes.
$psISE.Options.AutoSaveMinuteInterval = 3
```

### CommandPaneBackgroundColor
  This feature is present in Windows PowerShell ISE 2.0, but was removed or renamed in later versions of the ISE.  For later versions, see [ConsolePaneBackgroundColor](#consolepanebackgroundcolor).

 Specifies the background color for the Command pane. It is an instance of the **System.Windows.Media.Color** class.

```
# Changes the background color of the Command pane to orange.
$psISE.Options.CommandPaneBackgroundColor = "orange"
```

### CommandPaneUp
  This feature is present in Windows PowerShell ISE 2.0, but was removed or renamed in later versions of the ISE.

 Specifies whether the Command pane is located above the Output pane.

```
# Moves the Command pane to the top of the screen.
$psISE.Options.CommandPaneUp  = $true

```

### ConsolePaneBackgroundColor
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies the background color for the Console pane. It is an instance of the **System.Windows.Media.Color** class.

```
# Changes the background color of the Console pane to red.
$psISE.Options.ConsolePaneBackgroundColor = "red"
```

### ConsolePaneForegroundColor
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies the foreground color of the text in the Console pane.

```
# Changes the foreground color of the text in the Console pane to yellow.
$psISE.Options.ConsolePaneForegroundColor  = "yellow"

```

### ConsolePaneTextBackgroundColor
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies the background color of the text in the Console pane.

```
# Changes the background color of the Console pane text to pink.
$psISE.Options.ConsolePaneTextBackgroundColor = "pink"
```

### ConsoleTokenColors
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies the colors of the IntelliSense tokens in the Windows PowerShell ISE Console pane. This property is a dictionary object that contains name/value pairs of token types and colors for the Console pane. To change the colors of the IntelliSense tokens in the Script pane, see [TokenColors](#tokencolors). To reset the colors to the default values, see [RestoreDefaultConsoleTokenColors](#restoredefaultconsoletokencolors). Token colors can be set for the following: Attribute, Command, CommandArgument, CommandParameter, Comment, GroupEnd, GroupStart, Keyword, LineContinuation, LoopLabel, Member, NewLine, Number, Operator, Position, StatementSeparator, String, Type, Unknown, Variable.

```
# Sets the color of commands to green.
$psISE.Options.ConsoleTokenColors["Command"] = "green"
# Sets the color of keywords to magenta.
$psISE.Options.ConsoleTokenColors["Keyword"] = "magenta"

```

### DebugBackgroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the background color for the debug text that appears in the Console pane. It is an instance of the **System.Windows.Media.Color** class.

```
# Changes the background color for the debug text that appears in the Console pane to blue.
$psISE.Options.DebugBackgroundColor ='#0000FF'
```

### DebugForegroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the foreground color for the debug text that appears in the Console pane. It is an instance of the **System.Windows.Media.Color** class.

```
# Changes the foreground color for the debug text that appears in the Console pane to yellow.
$psISE.Options.DebugForegroundColor ="yellow"
```

### DefaultOptions
  Supported in Windows PowerShell ISE 2.0 and later.

 A collection of properties that specify the default values to be used when the Reset methods are used.

```
# Displays the name of the default options. This example is from ISE 4.0.
$psISE.Options.DefaultOptions

SelectedScriptPaneState                   : Top
ShowDefaultSnippets                       : True
ShowToolBar                               : True
ShowOutlining                             : True
ShowLineNumbers                           : True
TokenColors                               : {[Attribute, #FF00BFFF], [Command, #FF0000FF], [CommandArgument, #FF8A2BE2], [CommandParameter, #FF000080]...}
ConsoleTokenColors                        : {[Attribute, #FFB0C4DE], [Command, #FFE0FFFF], [CommandArgument, #FFEE82EE], [CommandParameter, #FFFFE4B5]...}
XmlTokenColors                            : {[Comment, #FF006400], [CommentDelimiter, #FF008000], [ElementName, #FF8B0000], [MarkupExtension, #FFFF8C00]...}
DefaultOptions                            : Microsoft.PowerShell.Host.ISE.ISEOptions
FontSize                                  : 9
Zoom                                      : 100
FontName                                  : Lucida Console
ErrorForegroundColor                      : #FFFF0000
ErrorBackgroundColor                      : #00FFFFFF
WarningForegroundColor                    : #FFFF8C00
WarningBackgroundColor                    : #00FFFFFF
VerboseForegroundColor                    : #FF00FFFF
VerboseBackgroundColor                    : #00FFFFFF
DebugForegroundColor                      : #FF00FFFF
DebugBackgroundColor                      : #00FFFFFF
ConsolePaneBackgroundColor                : #FF012456
ConsolePaneTextBackgroundColor            : #FF012456
ConsolePaneForegroundColor                : #FFF5F5F5
ScriptPaneBackgroundColor                 : #FFFFFFFF
ScriptPaneForegroundColor                 : #FF000000
ShowWarningForDuplicateFiles              : True
ShowWarningBeforeSavingOnRun              : True
UseLocalHelp                              : True
AutoSaveMinuteInterval                    : 2
MruCount                                  : 10
ShowIntellisenseInConsolePane             : True
ShowIntellisenseInScriptPane              : True
UseEnterToSelectInConsolePaneIntellisense : True
UseEnterToSelectInScriptPaneIntellisense  : True
IntellisenseTimeoutInSeconds              : 3

```

### ErrorBackgroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the background color for error text that appears in the Console pane. It is an instance of the **System.Windows.Media.Color** class.

```
# Changes the background color for the error text that appears in the Console pane to black.
$psISE.Options.ErrorBackgroundColor="black"
```

### ErrorForegroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the foreground color for error text that appears in the Console pane. It is an instance of the **System.Windows.Media.Color** class.

```
# Changes the foreground color for the error text that appears in the console pane to green.
$psISE.Options.ErrorForegroundColor ="green"
```

### FontName
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the font name currently in use in both the Script pane and the Console pane.

```
# Changes the font used in both panes.
$psISE.Options.FontName = "courier new"
```

### FontSize
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the font size as an integer. It is used in the Script pane, the Command pane, and the Output pane. The valid range of values is 8 through 32.

```
# Changes the font size in all panes.
$psISE.Options.FontSize = 20

```

### IntellisenseTimeoutInSeconds
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies the number of seconds that IntelliSense uses to try to resolve the currently typed text. After this number of seconds, IntelliSense times out and enables you to continue typing. The default value is 3 seconds. The value is an integer.

```
# Changes the number of seconds for IntelliSense syntax recognition to 5.
$psISE.Options.IntellisenseTimeoutInSeconds = 5
```

### MruCount
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies the number of recently opened files that Windows PowerShell ISE tracks and displays at the bottom of the **File Open** menu. The default value is 10. The value is an integer.

```
# Changes the number of recently used files that appear at the bottom of the File Open menu to 5.
$psISE.Options.MruCount = 5
```

### OutputPaneBackgroundColor
  This feature is present in Windows PowerShell ISE 2.0, but was removed or renamed in later versions of the ISE.  For later versions, see [ConsolePaneBackgroundColor](#consolepanebackgroundcolor).

 The read/write property that gets or sets the background color for the Output pane itself. It is an instance of the **System.Windows.Media.Color** class.

```
# Changes the background color of the Output pane to gold.
$psISE.Options.OutputPaneForegroundColor = "gold"

```

### OutputPaneTextForegroundColor
  This feature is present in Windows PowerShell ISE 2.0, but was removed or renamed in later versions of the ISE.  For later versions, see [ConsolePaneForegroundColor](#consolepaneforegroundcolor).

 The read/write property that changes the foreground color of the text in the Output pane in Windows PowerShell ISE 2.0.

```
# Changes the foreground color of the text in the Output Pane to blue.
$psISE.Options.OutputPaneTextForegroundColor  = "blue"

```

### OutputPaneTextBackgroundColor
  This feature is present in Windows PowerShell ISE 2.0, but was removed or renamed in later versions of the ISE.  For later versions, see [ConsolePaneTextBackgroundColor](#consolepanetextbackgroundcolor).

 The read/write property that changes the background color of the text in the Output pane.

```
# Changes the background color of the Output pane text to pink.
$psISE.Options.OutputPaneTextBackgroundColor = "pink"
```

### ScriptPaneBackgroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 The read/write property that gets or sets the background color for files. It is an instance of the **System.Windows.Media.Color** class.

```

# Sets the color of the script pane background to yellow.
$psISE.Options.ScriptPaneBackgroundColor = 'yellow'

```

### ScriptPaneForegroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 The read/write property that gets or sets the foreground color for non-script files in the Script pane.
To set the foreground color for script files, use the [TokenColors](#tokencolors).

```
# Sets the foreground to color of non-script files in the script pane to green.
$psISE.Options.ScriptPaneBackgroundColor = "green"

```

### SelectedScriptPaneState
  Supported in Windows PowerShell ISE 2.0 and later.

 The read/write property that gets or sets the position of the Script pane on the display. The string can be either "Maximized", "Top", or "Right".

```
# Moves the Script Pane to the top.
$psISE.Options.SelectedScriptPaneState = "Top"
# Moves the Script Pane to the right.
$psISE.Options.SelectedScriptPaneState = "Right"
# Maximizes the Script Pane
$psISE.Options.SelectedScriptPaneState = "Maximized"

```

### ShowDefaultSnippets
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies whether the **CTRL+J** list of snippets includes the starter set that is included in Windows PowerShell. When set to **$false**, only user-defined snippets appear in the **CTRL+J** list. The default value is **$true**.

```
# Hide the default snippets from the CTRL+J list.
$psISe.Options.ShowDefaultSnippets = $false
```

### ShowIntellisenseInConsolePane
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies whether IntelliSense offers syntax, parameter, and value suggestions in the Console pane. The default value is **$true**.

```
# Turn off IntelliSense in the console pane.
$psISe.Options.ShowIntellisenseInConsolePane = $false
```

### ShowIntellisenseInScriptPane
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies whether IntelliSense offers syntax, parameter, and value suggestions in the Script pane. The default value is **$true**.

```
# Turn off IntelliSense in the Script pane.
$psISe.Options.ShowIntellisenseInScriptPane = $false
```

### ShowLineNumbers
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies whether the Script pane displays line numbers in the left margin. The default value is **$true**.

```
# Turn off line numbers in the Script pane.
$psISe.Options.ShowLineNumbers = $false
```

### ShowOutlining
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies whether the Script pane displays expandable and collapsible brackets next to sections of code in the left margin. When they are displayed, you can click the minus \(-\) icons next to a block of text to collapse it or click the plus \(+\) icon to expand a block of text. The default value is **$true**.

```
# Turn off outlining in the Script pane.
$psISe.Options.ShowOutlining = $false
```

### ShowToolBar
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies whether the ISE toolbar appears at the top of the Windows PowerShell ISE window. The default value is **$true**.

```
# Show the toolbar.
$psISe.Options.ShowToolBar = $true
```

### ShowWarningBeforeSavingOnRun
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies whether a warning message appears when a script is saved automatically before it is run. The default value is **$true**.

```
# Enable the warning message when an attempt
# is made to run a script without saving it first.
$psISE.Options.ShowWarningBeforeSavingOnRun=$true

```

### ShowWarningForDuplicateFiles
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies whether a warning message appears when the same file is opened in different PowerShell tabs. If set to **$true**, to open the same file in multiple tabs displays this message: "A copy of this file is open in another Windows PowerShell tab. Changes made to this file will affect all open copies." The default value is **$true**.

```
# Enable the warning message when a file is
# opened in multiple PowerShell tabs.
$psISE.Options.ShowWarningForDuplicateFiles = $true

```

### TokenColors
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the colors of the IntelliSense tokens in the Windows PowerShell ISE Script pane. This property is a dictionary object that contains name/value pairs of token types and colors for the Script pane. To change the colors of the IntelliSense tokens in the Console pane, see [ConsoleTokenColors](#consoletokencolors). To reset the colors to the default values, see [RestoreDefaultTokenColors](#restoredefaulttokencolors). Token colors can be set for the following: Attribute, Command, CommandArgument, CommandParameter, Comment, GroupEnd, GroupStart, Keyword, LineContinuation, LoopLabel, Member, NewLine, Number, Operator, Position, StatementSeparator, String, Type, Unknown, Variable.

```
# Sets the color of commands to green.
$psISE.Options.TokenColors["Command"] = "green"
# Sets the color of keywords to magenta.
$psISE.Options.TokenColors["Keyword"] = "magenta"

```

### UseEnterToSelectInConsolePaneIntellisense
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies whether you can use the Enter key to select an IntelliSense provided option in the Console pane. The default value is **$true**.

```
# Turn off using the ENTER key to select an IntelliSense provided option in the Console pane.
$psISE.Options.UseEnterToSelectInConsolePaneIntellisense=$false

```

### UseEnterToSelectInScriptPaneIntellisense
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies whether you can use the Enter key to select an IntelliSense-provided option in the Script pane. The default value is **$true**.

```
# Turn on using the Enter key to select an IntelliSense provided option in the Console pane.
$psISE.Options.UseEnterToSelectInConsolePaneIntellisense=$true

```

### UseLocalHelp
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies whether the locally installed Help or the online TechNet Library Help appears when you press F1 with the cursor positioned in a keyword. If set to **$true**, then a pop-up window shows content from the locally installed Help. You can install the Help files by running the `Update-Help` command. If set to **$false**, then your browser opens to a page in the TechNet Library.

```
# Sets the option for the online help to be displayed.
$psISE.Options.UseLocalHelp=$false
# Sets the option for the local Help to be displayed.
$psISE.Options.UseLocalHelp=$true

```

### VerboseBackgroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the background color for verbose text that appears in the Console pane. It is a **System.Windows.Media.Color** object.

```
# Changes the background color for verbose text to blue.
$psISE.Options.VerboseBackgroundColor ='#0000FF'
```

### VerboseForegroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the foreground color for verbose text that appears in the Console pane. It is a **System.Windows.Media.Color** object.

```
# Changes the foreground color for verbose text to yellow.
$psISE.Options.VerboseForegroundColor ='yellow'
```

### WarningBackgroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the background color for warning text that appears in the Console pane. It is a **System.Windows.Media.Color** object.

```
# Changes the background color for warning text to blue.
$psISE.Options.WarningBackgroundColor ='#0000FF'
```

### WarningForegroundColor
  Supported in Windows PowerShell ISE 2.0 and later.

 Specifies the foreground color for warning text that appears in the Output pane. It is a **System.Windows.Media.Color** object.

```
# Changes the foreground color for warning text to yellow.
$psISE.Options.WarningForegroundColor ='yellow'
```

### XmlTokenColors
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies a dictionary object that contains name/value pairs of token types and colors for XML content that is displayed in Windows PowerShell ISE. Token colors can be set for the following: Attribute, Command, CommandArgument, CommandParameter, Comment, GroupEnd, GroupStart, Keyword, LineContinuation, LoopLabel, Member, NewLine, Number, Operator, Position, StatementSeparator, String, Type, Unknown, Variable. Also see [RestoreDefaultXmlTokenColors](#restoredefaultxmltokencolors).

```
# Sets the color of XML element names to green.
$psISE.Options.XmlTokenColors["ElementName"] = "green"
# Sets the color of XML comments to magenta.
$psISE.Options.XmlTokenColors["Comment"] = "magenta"

```

### Zoom
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

 Specifies the relative size of text in both the Console and Script panes. The default value is 100. Smaller values cause the text in Windows PowerShell ISE to appear smaller while larger numbers cause text to appear larger. The value is an integer that ranges from 20 to 400.

```
# Changes the text in the Windows PowerShell ISE to be double its normal size.
$psISE.Options.Zoom = 200
```

## See Also
- [The Windows PowerShell ISE Scripting Object Model](The-Windows-PowerShell-ISE-Scripting-Object-Model.md)
- [Windows PowerShell ISE Object Model Reference](Windows-PowerShell-ISE-Object-Model-Reference.md)

