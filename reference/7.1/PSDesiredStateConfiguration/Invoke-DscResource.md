---
external help file: Microsoft.Windows.DSC.CoreConfProviders.dll-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSDesiredStateConfiguration
ms.date: 01/10/2020
online version: https://docs.microsoft.com/powershell/module/psdesiredstateconfiguration/invoke-dscresource?view=powershell-7.x&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Invoke-DscResource
---

# Invoke-DscResource

## SYNOPSIS
Runs a method of a specified PowerShell Desired State Configuration (DSC) resource.

## SYNTAX

```
Invoke-DscResource [-Name] <String> [-Method] <String> -ModuleName <ModuleSpecification> -Property <Hashtable>
 [<CommonParameters>]
```

## DESCRIPTION

The `Invoke-DscResource` cmdlet runs a method of a specified PowerShell Desired State Configuration
(DSC) resource.

This cmdlet invokes a DSC resource directly, without creating a configuration document.
Using this cmdlet, configuration management products can manage windows or Linux by using DSC resources.
This cmdlet also enables debugging of resources when the DSC engine is running with debugging enabled.

## EXAMPLES

### Example 1: Invoke the Set method of a resource by specifying its mandatory properties

This command invokes the **Set** method of a resource named Log and specifies a **Message** property
for it.

```powershell
Invoke-DscResource -Name Log -Method Set -ModuleName PSDesiredStateConfiguration -Property @{
  Message = 'Hello World'
}
```

### Example 2: Invoke the Test method of a resource for a specified module

This command invokes the **Test** method of a resource named WindowsProcess, which is in the module
named **PSDesiredStateConfiguration**.

```powershell
$SplatParam = @{
  Name = 'WindowsProcess'
  ModuleName = 'PSDesiredStateConfiguration'
  Property = @{Path = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'; Arguments = ''}
  Method = Test
}

Invoke-DscResource @SplatParam
```

## PARAMETERS

### -Method

Specifies the method of the resource that this cmdlet invokes. The acceptable values for this
parameter are: **Get**, **Set**, and **Test**.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Get, Set, Test

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ModuleName

Specifies the name of the module from which this cmdlet invokes the specified resource.

```yaml
Type: ModuleSpecification
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies the name of the DSC resource to start.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Property

Specifies the resource property name and its value in a hash table as key and value, respectively.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Management.Infrastructure.CimInstance, System.Boolean

## NOTES

Previously, Windows PowerShell 5.1 resources ran under System context unless specified
with user context using the key **PsDscRunAsCredential**. In PowerShell 7.0, Resources run in the
user's context, and **PsDscRunAsCredential** is no longer supported. Previous configurations using
this key will throw an exception.

## RELATED LINKS

[Windows PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview/dscforengineers)

[Get-DscConfiguration](Get-DscConfiguration.md)

[Get-DscConfigurationStatus](Get-DscConfigurationStatus.md)

[Get-DscResource](Get-DscResource.md)

[Restore-DscConfiguration](Restore-DscConfiguration.md)

[Set-DscLocalConfigurationManager](Set-DscLocalConfigurationManager.md)

[Start-DscConfiguration](Start-DscConfiguration.md)

[Test-DscConfiguration](Test-DscConfiguration.md)
