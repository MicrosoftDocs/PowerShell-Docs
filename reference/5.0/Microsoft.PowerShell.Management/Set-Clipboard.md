---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=526220
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Set-Clipboard
---

# Set-Clipboard

## SYNOPSIS
Sets the current Windows clipboard entry.

## SYNTAX

### String (Default)
```
Set-Clipboard [-Append] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Value
```
Set-Clipboard [-Value] <String[]> [-Append] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Path
```
Set-Clipboard [-Append] -Path <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPath
```
Set-Clipboard [-Append] -LiteralPath <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Set-Clipboard** cmdlet sets the current Windows clipboard entry.

## EXAMPLES

### Example 1: Copy text to the clipboard
```
PS C:\> Set-Clipboard -Value "This is a test string"
```

This command copies a string to the clipboard.

### Example 2: Copy the contents of a directory to the clipboard
```
PS C:\> Set-Clipboard -Path "C:\Staging\"
```

This command copies the content of the specified folder to the clipboard.

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

### -LiteralPath
Specifies the path to the item that is copied to the clipboard.
Unlike *Path*, the value of *LiteralPath* is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the path to the item that is copied to the clipboard.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Value
Specifies, as a string array, the content to copy to the clipboard.

```yaml
Type: String[]
Parameter Sets: Value
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-Clipboard](Get-Clipboard.md)