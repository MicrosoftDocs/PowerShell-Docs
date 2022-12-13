---
external help file: Microsoft.PowerShell.Operation.Validation-help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Operation.Validation
ms.date: 12/13/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.operation.validation/get-operationvalidation?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-OperationValidation
---

# Get-OperationValidation

## SYNOPSIS
Gets Operation Validation Framework tests.

## SYNTAX

```
Get-OperationValidation [[-ModuleName] <String[]>] [-TestType <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-OperationValidation` cmdlet gets Operation Validation Framework tests for installed
modules.

Modules that include a Diagnostics folder are inspected for Pester tests in the Simple or
Comprehensive subfolder, or both.

## EXAMPLES

### Example 1: Get Operation Validation tests

```powershell
Get-OperationValidation -ModuleName "C:\temp\modules\AddNumbers"
```

```Output
    Type:     Simple
    File:     addnum.tests.ps1
    FilePath: C:\temp\modules\AddNumbers\Diagnostics\Simple\addnum.tests.ps1
    Name:
        Add-Em
        Subtract em
        Add-Numbers
    Type:     Comprehensive
    File:     Comp.Adding.Tests.ps1
    FilePath: C:\temp\modules\AddNumbers\Diagnostics\Comprehensive\Comp.Adding.Tests.ps1
    Name:
        Comprehensive Adding Tests
        Comprehensive Subtracting Tests
        Comprehensive Examples
```

This command gets validation tests from the module named **AddNumbers** in the `C:\temp\modules` folder.

## PARAMETERS

### -ModuleName

Specifies an array of names of modules.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestType

Specifies an array of test types. Valid values are:

- `Simple`
- `Comprehensive`

The default is `Simple,Comprehensive`.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:
Accepted values: Simple, Comprehensive

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSCustomObject

This cmdlet returns a **PSCustomObject** describing the validation.

## NOTES

## RELATED LINKS

[Invoke-OperationValidation](Invoke-OperationValidation.md)
