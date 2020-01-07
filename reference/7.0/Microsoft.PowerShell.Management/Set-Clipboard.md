---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Management
ms.date: 08/09/2019
online version: https://go.microsoft.com/fwlink/?linkid=526220
schema: 2.0.0
title: Set-Clipboard
---
# Set-Clipboard

## SYNOPSIS
Sets the contents of the clipboard.

## SYNTAX

```
Set-Clipboard [-Value] <string[]> [-Append] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Set-Clipboard` cmdlet sets the contents of the clipboard.

[!NOTE]
> On Linux, this cmdlet requires the `xclip` utility to be in the path.

## EXAMPLES

### Example 1: Copy text to the clipboard

```powershell
Set-Clipboard -Value "This is a test string"
```

## PARAMETERS

### -Append

Indicates that the cmdlet does not clear the clipboard and appends content to it.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-Clipboard](Get-Clipboard.md)
