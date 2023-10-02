---
external help file: Microsoft.PowerShell.PSReadLine2.dll-Help.xml
Locale: en-US
Module Name: PSReadLine
ms.date: 10/02/2023
online version: https://learn.microsoft.com/powershell/module/psreadline/set-psreadlinekeyhandler?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-PSReadLineKeyHandler
---

# Set-PSReadLineKeyHandler

## SYNOPSIS
Binds keys to user-defined or PSReadLine key handler functions.

## SYNTAX

### ScriptBlock

```
Set-PSReadLineKeyHandler [-ScriptBlock] <ScriptBlock> [-BriefDescription <String>]
 [-Description <String>] [-Chord] <String[]> [-ViMode <ViMode>] [<CommonParameters>]
```

### Function

```
Set-PSReadLineKeyHandler [-Chord] <String[]> [-ViMode <ViMode>] [-Function] <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-PSReadLineKeyHandler` cmdlet customizes the result when a key or sequence of keys is
pressed. With user-defined key bindings, you can do almost anything that's possible from within a
PowerShell script.

## EXAMPLES

### Example 1: Bind the arrow key to a function

This command binds the up arrow key to the **HistorySearchBackward** function. This function
searches command history for command lines that start with the current contents of the command line.

```powershell
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
```

### Example 2: Bind a key to a script block

This example shows how a single key can be used to run a command. The command binds the key `Ctrl+b`
to a script block that clears the line, inserts the word "build", and then accepts the line.

```powershell
Set-PSReadLineKeyHandler -Chord Ctrl+b -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('build')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
```

## PARAMETERS

### -BriefDescription

A brief description of the key binding. This description is displayed by the
`Get-PSReadLineKeyHandler` cmdlet.

```yaml
Type: System.String
Parameter Sets: ScriptBlock
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Chord

The key or sequence of keys to be bound to a function or script block. Use a single string to
specify a single binding. If the binding is a sequence of keys, separate the keys by a comma. For
example: `Ctrl+x,Ctrl+l`

Letter key references are defined using lowercase letters. If you want to define a chord that uses
an uppercase letter, the chord must include the **Shift** key. For example, `Ctrl+Shift+x` and
`Ctrl+x` create different bindings.

This parameter accepts an array of strings. Each string is a separate binding, not a sequence of
keys for a single binding.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Key

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Specifies a more detailed description of the key binding that's visible in the output of the
`Get-PSReadLineKeyHandler` cmdlet.

```yaml
Type: System.String
Parameter Sets: ScriptBlock
Aliases: LongDescription

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Function

Specifies the name of an existing key handler provided by PSReadLine. This parameter lets you rebind
existing key bindings, or bind a handler that's currently unbound.

```yaml
Type: System.String
Parameter Sets: Function
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock

Specifies a script block value to run when the chord is entered. PSReadLine passes one or two
parameters to this script block. The first parameter is a **ConsoleKeyInfo** object representing the
key pressed. The second argument can be any object depending on the context.

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: ScriptBlock
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ViMode

Specify which vi mode the binding applies to.

Valid values are:

- `Insert`
- `Command`

```yaml
Type: Microsoft.PowerShell.ViMode
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

[Get-PSReadLineKeyHandler](Get-PSReadLineKeyHandler.md)

[Remove-PSReadLineKeyHandler](Remove-PSReadLineKeyHandler.md)

[Get-PSReadLineOption](Get-PSReadLineOption.md)

[Set-PSReadLineOption](Set-PSReadLineOption.md)
