---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821817
external help file:  Microsoft.PowerShell.Utility-help.xml
title:  Import-PowerShellDataFile
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
The **Import-PowerShellDataFile** cmdlet returns a hashtable consisting of the key-value pairs in a .PSD1 file.

## EXAMPLES

### 1: Retrieve values from PSD1
```
PS C:\> $content = Import-PowerShellDataFile .\Configuration.psd1
PS C:\> $content
Name                           Value
----                           -----
key1                           value1
key2                           value2
```
This examples retrieves the key-value pairs stored in the hashtable kept inside the Configuration.psd1 file.
## PARAMETERS

### -LiteralPath
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
```yaml
Type: String[]
Parameter Sets: ByPath
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS