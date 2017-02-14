---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Set PSReadlineKeyHandler
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkID=821452
external help file:   Microsoft.PowerShell.PSReadLine.dll-Help.xml
---


# Set-PSReadlineKeyHandler

## SYNOPSIS
Binds keys to user-defined or PSReadline-provided key handlers.

## SYNTAX

### ScriptBlock
```
Set-PSReadlineKeyHandler [-Chord] <String[]> [-ScriptBlock] <ScriptBlock> [-BriefDescription <String>]
 [-Description <String>] [<CommonParameters>]
```

### Function
```
Set-PSReadlineKeyHandler [-Chord] <String[]> [-Function] <String> [<CommonParameters>]
```

## DESCRIPTION
The **Set-PSReadlineKeyHandler** cmdlet customizes the result when a particular key or sequence of keys is pressed while PSReadline is reading input.
By using user-defined key bindings, you can do almost anything that is possible from within a Windows PowerShell script.
Typically, you might modify the command line in a new way, but because the handlers are just Windows PowerShell scripts, you can do interesting things such as change directories or open applications.

## EXAMPLES

### Example 1: Bind the arrow key to a function
```
PS C:\> Set-PSReadlineKeyHandler -Chord UpArrow -Function HistorySearchBackward
```

This command binds the up arrow key to the function HistorySearchBackward, which uses the currently-entered command line as the start of the search string when it is searching through command history.

### Example 2: Bind a key to a script block
```
PS C:\> Set-PSReadlineKeyHandler -Chord Shift+Ctrl+B -ScriptBlock { 
  [PSConsoleUtilities.PSConsoleReadLine]::RevertLine() 
  [PSConsoleUtilities.PSConsoleReadLine]::Insert('build')
      [PSConsoleUtilities.PSConsoleReadLine]::AcceptLine()
}
```

This command binds the key Ctrl+Shift+B to a script block that clears the line, inserts the word build, and then accepts the line.
The example shows how a single key can be used to run a command.

## PARAMETERS

### -BriefDescription
A brief description of the key binding.
You can get this from the output of the Get-PSReadlineKeyHandler cmdlet.

```yaml
Type: String
Parameter Sets: ScriptBlock
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Chord
Specifies an array of keys or sequences of keys to be bound to a function or script block.
Use a single string to specify a single binding.
If the binding is a sequence of keys, separate the keys by a comma, as in the following example: 

"Ctrl+X,Ctrl+L" 

This parameter accepts multiple strings.
Each string is a separate binding, not a sequence of keys for a single binding.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Key

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Specifies a more detailed description of the key binding that is visible in the output of the **Get-PSReadlineKeyHandler** cmdlet.

```yaml
Type: String
Parameter Sets: ScriptBlock
Aliases: LongDescription

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Function
Specifies the name of an existing key handler provided by PSReadline.
This parameter lets you rebind existing key bindings, or bind a handler that is provided by PSReadline and is currently unbound.
By adding the *ScriptBlock* parameter, you can get equivalent functionality by calling the method directly from the script block.
This parameter is the preferred method, however, because the results make it easier to determine which functions are bound and unbound.
To see a complete list of these values, type `Get-Help Set-PSReadlineKeyHandler -Full`.

```yaml
Type: String
Parameter Sets: Function
Aliases: 
Accepted values: Abort, AcceptAndGetNext, AcceptLine, AddLine, BackwardChar, BackwardDeleteChar, BackwardDeleteLine, BackwardKillLine, BackwardKillWord, BackwardWord, BeginningOfHistory, BeginningOfLine, CancelLine, CaptureScreen, CharacterSearch, CharacterSearchBackward, ClearHistory, ClearScreen, Complete, Copy, CopyOrCancelLine, Cut, DeleteChar, DeleteCharOrExit, DigitArgument, EndOfHistory, EndOfLine, ExchangePointAndMark, ForwardChar, ForwardDeleteLine, ForwardSearchHistory, ForwardWord, GotoBrace, HistorySearchBackward, HistorySearchForward, InvokePrompt, KillLine, KillRegion, KillWord, MenuComplete, NextHistory, NextLine, NextWord, Paste, PossibleCompletions, PreviousHistory, PreviousLine, Redo, ReverseSearchHistory, RevertLine, ScrollDisplayDown, ScrollDisplayDownLine, ScrollDisplayToCursor, ScrollDisplayTop, ScrollDisplayUp, ScrollDisplayUpLine, SelectAll, SelectBackwardChar, SelectBackwardsLine, SelectBackwardWord, SelectForwardChar, SelectForwardWord, SelectLine, SelectNextWord, SelectShellBackwardWord, SelectShellForwardWord, SelectShellNextWord, SelfInsert, SetMark, ShellBackwardKillWord, ShellBackwardWord, ShellForwardWord, ShellKillWord, ShellNextWord, ShowKeyBindings, TabCompleteNext, TabCompletePrevious, Undo, UnixWordRubout, ValidateAndAcceptLine, WhatIsKey, Yank, YankLastArg, YankNthArg, YankPop

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock
Specifies a script block value that is called when the chord is entered.
The script block is passed one, or sometimes two, arguments.
The first argument is the key pressed, a **ConsoleKeyInfo** object..
The second argument could be any object depending on the context.

```yaml
Type: ScriptBlock
Parameter Sets: ScriptBlock
Aliases: 

Required: True
Position: 1
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

## NOTES

## RELATED LINKS

[Get-PSReadlineKeyHandler](Get-PSReadlineKeyHandler.md)

[Remove-PSReadlineKeyHandler](Remove-PSReadlineKeyHandler.md)

[Get-PSReadlineOption](Get-PSReadlineOption.md)

[Set-PSReadlineOption](Set-PSReadlineOption.md)

