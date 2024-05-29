---
external help file: Microsoft.PowerShell.Security.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Security
ms.date: 05/29/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.security/new-filecatalog?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-FileCatalog
---

# New-FileCatalog

## SYNOPSIS
Creates a Windows catalog file containing cryptographic hashes for files and folders in the
specified paths.

## SYNTAX

```
New-FileCatalog [-CatalogVersion <Int32>] [-CatalogFilePath] <String> [[-Path] <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

`New-FileCatalog` creates a [Windows catalog file](/windows-hardware/drivers/install/catalog-files)
for a set of folders and files. This catalog file contains hashes for all files in the provided
paths. Users can then distribute the catalog with their files so that users can validate whether any
changes have been made to the folders since catalog creation time.

Catalog versions 1 and 2 are supported. Version 1 uses the (deprecated) SHA1 hashing algorithm to
create file hashes, and version 2 uses SHA256.

## EXAMPLES

### Example 1: Create a file catalog for `Microsoft.PowerShell.Utility`

```powershell
$newFileCatalogSplat = @{
    Path = "$PSHOME\Modules\Microsoft.PowerShell.Utility"
    CatalogFilePath = '\temp\Microsoft.PowerShell.Utility.cat'
    CatalogVersion = 2.0
}
New-FileCatalog @newFileCatalogSplat
```

```Output
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         11/2/2018 11:58 AM            950 Microsoft.PowerShell.Utility.cat
```

## PARAMETERS

### -CatalogFilePath

The location and name of the catalog file (`.cat`) you are creating. If you specify only a folder
path, the command creates a file named `catalog.cat` in that location.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -CatalogVersion

Accepts `1.0` or `2.0` as possible values for specifying the catalog version. `1.0` should be
avoided whenever possible because it uses the insecure SHA-1 hash algorithm. Version `2.0` uses the
secure SHA-256 algorithm.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Accepts a path or array of paths to files or folders that should be included in the catalog file. If
a folder is specified, the command includes all files in the folder.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that's used as the catalog filename to this cmdlet.

## OUTPUTS

### System.IO.FileInfo

This cmdlet returns a **FileInfo** object representing the created catalog.

## NOTES

## RELATED LINKS

[Test-FileCatalog](Test-FileCatalog.md)

[PowerShellGet](/powerShell/module/powershellget)
