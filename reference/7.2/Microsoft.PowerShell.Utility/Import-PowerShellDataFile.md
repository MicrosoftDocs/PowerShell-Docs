---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/25/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/import-powershelldatafile?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Import-PowerShellDataFile
---
# Import-PowerShellDataFile

## SYNOPSIS
Imports values from a `.PSD1` file without invoking its contents.

## SYNTAX

### ByPath (Default)

```
Import-PowerShellDataFile [-Path] <String[]> [<CommonParameters>]
```

### ByLiteralPath

```
Import-PowerShellDataFile [-LiteralPath] <String[]> [<CommonParameters>]
```

## DESCRIPTION

The `Import-PowerShellDataFile` cmdlet safely imports key-value pairs from hashtables defined in a
`.PSD1` file. The values could be imported using `Invoke-Expression` on the contents of the file.
However, `Invoke-Expression` runs any code contained in the file. This could produce unwanted
results or execute unsafe code. `Import-PowerShellDataFile` imports the data without invoking the
code.

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
Wildcard characters are not processed.

```yaml
Type: System.String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath, LP

Required: True
Position: 0
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

## OUTPUTS

### System.Collections.Hashtable

## NOTES

## RELATED LINKS

[Invoke-Expression](Invoke-Expression.md)

[Import-LocalizedData](Import-LocalizedData.md)

