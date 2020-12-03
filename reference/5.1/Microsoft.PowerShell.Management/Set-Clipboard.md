---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 12/03/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/set-clipboard?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-Clipboard
---
# Set-Clipboard

## SYNOPSIS
Sets the current Windows clipboard entry.

## SYNTAX

### String (Default)

```
Set-Clipboard [-Append] [-AsHtml] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Value

```
Set-Clipboard [-Value] <String[]> [-Append] [-AsHtml] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Path

```
Set-Clipboard [-Append] -Path <String[]> [-AsHtml] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPath

```
Set-Clipboard [-Append] -LiteralPath <String[]> [-AsHtml] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Set-Clipboard` cmdlet sets the current Windows clipboard entry.

## EXAMPLES

### Example 1: Copy text to the clipboard

```powershell
Set-Clipboard -Value "This is a test string"
```

### Example 2: Copy the contents of a directory to the clipboard

This example copies the content of the specified folder to the clipboard.

```powershell
Set-Clipboard -Path "C:\Staging\"
```

### Example 3: Copy the contents of a file to the clipboard

This example pipes the contents of a file to the clipboard. In this example, we are getting a public
ssh key so that it can be pasted into another application, like GitHub.

```powershell
Get-Content C:\Users\user1\.ssh\id_ed25519.pub | Set-Clipboard
```

## PARAMETERS

### -Append

Indicates that the cmdlet does not clear the clipboard and appends content to it.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsHtml

Indicates that the cmdlet renders the content as HTML to the clipboard.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to the item that is copied to the clipboard. Unlike **Path**, the value of
**LiteralPath** is used exactly as it is typed. No characters are interpreted as wildcards. If the
path includes escape characters, enclose it in single quotation marks. Single quotation marks tell
Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the path to the item that is copied to the clipboard. Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Value

Specifies, as a string array, the content to copy to the clipboard.

```yaml
Type: System.String[]
Parameter Sets: Value
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

## NOTES

In rare cases when using `Set-Clipboard` with a high number of values in rapid succession, like in a
loop, you might sporadically get a blank value from the clipboard. This can be fixed by using
`Start-Sleep -Milliseconds 1` in the loop.

## RELATED LINKS

[Get-Clipboard](Get-Clipboard.md)
