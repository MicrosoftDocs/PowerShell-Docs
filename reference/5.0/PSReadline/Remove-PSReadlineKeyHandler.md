---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Remove PSReadlineKeyHandler
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821451
external help file:   Microsoft.PowerShell.PSReadLine.dll-Help.xml
---


# Remove-PSReadlineKeyHandler

## SYNOPSIS
Removes a key binding.

## SYNTAX

```
Remove-PSReadlineKeyHandler [-Chord] <String[]> [<CommonParameters>]
```

## DESCRIPTION
The **Remove-PSReadlineKeyHandler** cmdlet removes a specified key binding.
Create a key binding by running the Set-PSReadlineKeyHandler cmdlet.

## EXAMPLES

### Example 1: Remove a binding
```
PS C:\> Remove-PSReadlineKeyHandler -Chord "Shift+Ctrl+B"
```

This command removes the binding from the key combination, or chord, Ctrl+Shift+B.
The Ctrl+Shift+B chord is created in the Set-PSReadlineKeyHandler topic.

## PARAMETERS

### -Chord
Specifies an array of  keys or sequences of keys to be removed.
A single binding is specified by using a single string.
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

###  
You cannot pipe objects to this cmdlet.

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-PSReadlineKeyHandler](Get-PSReadlineKeyHandler.md)

[Get-PSReadlineOption](Get-PSReadlineOption.md)

[Set-PSReadlineOption](Set-PSReadlineOption.md)

[Set-PSReadlineKeyHandler](Set-PSReadlineKeyHandler.md)

