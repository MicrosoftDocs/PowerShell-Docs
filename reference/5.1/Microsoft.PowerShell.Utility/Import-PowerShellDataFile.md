---
external help file: Microsoft.PowerShell.Utility-help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 01/19/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/import-powershelldatafile?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Import-PowerShellDataFile
---

# Import-PowerShellDataFile

## SYNOPSIS
Imports values from a `.PSD1` file without invoking its contents.

## SYNTAX

### ByPath (Default)

```
Import-PowerShellDataFile [[-Path] <string[]>] [<CommonParameters>]
```

### ByLiteralPath

```
Import-PowerShellDataFile [-LiteralPath <string[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Import-PowerShellDataFile` cmdlet safely imports key-value pairs from hashtables defined in a
`.PSD1` file. The values could be imported using `Invoke-Expression` on the contents of the file.
However, `Invoke-Expression` runs any code contained in the file. This could produce unwanted
results or execute unsafe code. `Import-PowerShellDataFile` imports the data without invoking the
code.

> [!NOTE]
> You can only import the first 500 key-value pairs.

## EXAMPLES

### Example 1: Retrieve values from PSD1

This example retrieves the key-value pairs stored in the hashtable kept inside the
`Configuration.psd1` file. `Get-Content` is used to show the contents of the `Configuration.psd1`
file.

```powershell
Get-Content .\Configuration.psd1
$config = Import-PowerShellDataFile .\Configuration.psd1
$config.AllNodes
```

```Output
@{
    AllNodes = @(
        @{
            NodeName = 'DSC-01'
        }
        @{
            NodeName = 'DSC-02'
        }
    )
}

Name                           Value
----                           -----
NodeName                       DSC-01
NodeName                       DSC-02
```

## PARAMETERS

### -LiteralPath

The path to the file being imported. All characters in the path are treated as literal values.

```yaml
Type: System.String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

The path to the file being imported. Wildcards are allowed but only the first matching file is
imported.

```yaml
Type: System.String[]
Parameter Sets: ByPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Collections.Hashtable

This cmdlet returns the data from the file as a hash table.

## NOTES

## RELATED LINKS

[Invoke-Expression](Invoke-Expression.md)

[Import-LocalizedData](Import-LocalizedData.md)

[about_Data_Files](../Microsoft.PowerShell.Core/About/about_Data_Files.md)
