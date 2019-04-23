---
external help file: Microsoft.PowerShell.Utility-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/23/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821817
schema: 2.0.0
title: Import-PowerShellDataFile
---
# Import-PowerShellDataFile

## SYNOPSIS
Imports values from a .PSD1 file without invoking its contents

## SYNTAX

### ByPath (Default)

```
Import-PowerShellDataFile [[-Path] <String[]>] [<CommonParameters>]
```

### ByLiteralPath

```
Import-PowerShellDataFile [-LiteralPath <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Import-PowerShellDataFile` cmdlet returns a hashtable consisting of the key-value pairs in a
.PSD1 file.

## EXAMPLES

### Example 1: Retrieve values from PSD1

```powershell
$content = Import-PowerShellDataFile .\Configuration.psd1
$content
```

```Output
Name                           Value
----                           -----
key1                           value1
key2                           value2
```

This examples retrieves the key-value pairs stored in the hashtable kept inside the
Configuration.psd1 file.

## PARAMETERS

### -LiteralPath

The path to the file being imported. All characters in the path are treated as literal values.
Wildcard characters are not processed.

```yaml
Type: String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

The path to the file being imported. Wildcards are allowed but only the first matching file is
imported.

```yaml
Type: String[]
Parameter Sets: ByPath
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
