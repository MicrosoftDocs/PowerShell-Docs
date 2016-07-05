---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/?LinkId=526220
schema: 2.0.0
---

# Set-Clipboard
## SYNOPSIS
Sets the current Windows clipboard entry.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Set-Clipboard [-Append] [-AsHtml] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Set-Clipboard [-Value] <String[]> [-Append] [-AsHtml] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Set-Clipboard [-Append] [-AsHtml] -Path <String[]> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Set-Clipboard [-Append] [-AsHtml] -LiteralPath <String[]> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Set-Clipboard cmdlet sets the current Windows clipboard entry.

## EXAMPLES

### Example 1: Copy text to the clipboard
```
PS C:\>Set-Clipboard -Value "This is a test string"
```

This command copies a string to the clipboard.

### Example 2: Copy the contents of a directory to the clipboard
```
PS C:\>Set-Clipboard -Path "C:\Staging\"
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

### -AsHtml
Indicates that the cmdlet renders the content as HTML to the clipboard.

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

### -LiteralPath
Specifies the path to the item that is copied to the clipboard.
Unlike Path, the value of LiteralPath is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_4
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the path to the item that is copied to the clipboard.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Value
Specifies, as a string array, the content to copy to the clipboard.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByValue,ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String[]

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-Clipboard](2670c8e9-d22b-4968-b488-e91311698cc0)

