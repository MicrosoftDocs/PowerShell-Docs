---
external help file: Microsoft.PowerShell.Security.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Security
ms.date: 11/02/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.security/test-filecatalog?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Test-FileCatalog
---
# Test-FileCatalog

## SYNOPSIS
`Test-FileCatalog` validates whether the hashes contained in a catalog file (.cat) matches the
hashes of the actual files in order to validate their authenticity.

This cmdlet is only supported on Windows.

## SYNTAX

```
Test-FileCatalog [-Detailed] [-FilesToSkip <String[]>] [-CatalogFilePath] <String> [[-Path] <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

`Test-FileCatalog` validates the authenticity of files by comparing the file hashes of a catalog
file (.cat) with the hashes of actual files on disk. If it detects any mismatches, it returns the
status as ValidationFailed. Users can retrieve all this information by using the -Detailed
parameter. It also displays signing status of catalog in Signature property which is equivalent to
calling `Get-AuthenticodeSignature` cmdlet on the catalog file. Users can also skip any file during
validation by using the -FilesToSkip parameter.

This cmdlet is only supported on Windows.

## EXAMPLES

### Example 1: Create and validate a file catalog

```powershell
New-FileCatalog -Path $PSHOME\Modules\Microsoft.PowerShell.Utility -CatalogFilePath \temp\Microsoft.PowerShell.Utility.cat -CatalogVersion 2.0

Test-FileCatalog -CatalogFilePath \temp\Microsoft.PowerShell.Utility.cat -Path "$PSHome\Modules\Microsoft.PowerShell.Utility\"
```

```Output
Valid
```

### Example 2: Validate a file catalog with detailed output

```powershell
Test-FileCatalog -CatalogFilePath \temp\Microsoft.PowerShell.Utility.cat -Path "$PSHome\Modules\Microsoft.PowerShell.Utility\"
```

```Output
Status        : Valid
HashAlgorithm : SHA256
CatalogItems  : {[Microsoft.PowerShell.Utility.psd1,
                A7028BD54018AE519381CDF5BF91F3B0417BD9345478086089ACBFAD05C899FC], [Microsoft.PowerShell.Utility.psm1,
                1127E8151FB86BCB683F932E8F6538552F7195816ED351A28AE07A753B8F20DE]}
PathItems     : {[Microsoft.PowerShell.Utility.psd1,
                A7028BD54018AE519381CDF5BF91F3B0417BD9345478086089ACBFAD05C899FC], [Microsoft.PowerShell.Utility.psm1,
                1127E8151FB86BCB683F932E8F6538552F7195816ED351A28AE07A753B8F20DE]}
Signature     : System.Management.Automation.Signature
```

## PARAMETERS

### -CatalogFilePath

A path to a catalog file (.cat) that contains the hashes to be used for validation.

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

### -Detailed

Returns more information a more detailed `CatalogInformation` object that contains the files tested,
their expected/actual hashes, and an Authenticode signature of the catalog file if it's signed.

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

### -FilesToSkip

An array of paths that should not be tested as part of the validation.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

A folder or array of files that should be validated against the catalog file.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction,
-InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and
-WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.IO.DirectoryInfo[], System.String[]

The pipeline accepts an array of strings or `DirectoryInfo` objects that represent paths to the
files that need to be validated.

## OUTPUTS

### System.Management.Automation.CatalogValidationStatus

The default return type containing a value of either `Valid` or `ValidationFailed`.

### System.Management.Automation.CatalogInformation

A more detailed object returned when using `-Detailed` which can be used to analyze specific files
that may or may not have passed validation, which hashes were expected vs. found, and the algorithm
used in the catalog.

## NOTES

This cmdlet is only available on Windows platforms.

## RELATED LINKS

[New-FileCatalog](New-FileCatalog.md)

[PowerShellGet](/powershell/module/PowerShellGet)
