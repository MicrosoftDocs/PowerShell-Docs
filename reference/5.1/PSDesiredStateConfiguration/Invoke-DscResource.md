---
external help file: Microsoft.Windows.DSC.CoreConfProviders.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: PSDesiredStateConfiguration
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psdesiredstateconfiguration/invoke-dscresource?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Invoke-DscResource
---

# Invoke-DscResource

## SYNOPSIS
Runs a method of a specified DSC resource.

## SYNTAX

```
Invoke-DscResource [-Name] <String> [-Method] <String> -ModuleName <ModuleSpecification> -Property <Hashtable>
 [<CommonParameters>]
```

## DESCRIPTION
The **Invoke-DscResource** cmdlet runs a method of a specified Windows PowerShell Desired State Configuration (DSC) resource.
Before you run this cmdlet, set the refresh mode of the Local Configuration Manager (LCM) to Disabled.

This cmdlet invokes a DSC resource directly, without creating a configuration document.
Using this cmdlet, configuration management products can manage windows by using DSC resources.
This cmdlet also enables debugging of resources when the DSC engine or LCM is running with debugging enabled.

## EXAMPLES

### Example 1: Invoke the Set method of a resource by specifying its mandatory properties

```
PS C:\> Invoke-DscResource -Name Log -Method Set -Property @{Message = 'Hello World'} -ModuleName PSDesiredStateConfiguration
```

This command invokes the **Set** method of a resource named Log and specifies a **Message** property for it.

### Example 2: Invoke the Test method of a resource for a specified module

```
PS C:\> Invoke-DscResource -Name WindowsProcess -Method Test -Property @{Path = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'; Arguments = ''} -ModuleName PSDesiredStateConfiguration
```

This command invokes the **Test** method of a resource named WindowsProcess, which is in the module named PSDesiredStateConfiguration.

## PARAMETERS

### -Method
Specifies the method of the resource that this cmdlet invokes. The acceptable values for this parameter are: Get, Set, and Test.

```yaml
Type: System.String
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
Type: Microsoft.PowerShell.Commands.ModuleSpecification
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
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Property
Specifies the resource property name and its value in a hash table as key and value, respectively. Use the **Get-DscResource** cmdlet to discover resource properties and their types.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Management.Infrastructure.CimInstance, System.Boolean

## NOTES

## RELATED LINKS

[Windows PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview/dscforengineers)

[Get-DscConfiguration](Get-DscConfiguration.md)

[Get-DscConfigurationStatus](Get-DscConfigurationStatus.md)

[Get-DscResource](Get-DscResource.md)

[Restore-DscConfiguration](Restore-DscConfiguration.md)

[Set-DscLocalConfigurationManager](Set-DscLocalConfigurationManager.md)

[Start-DscConfiguration](Start-DscConfiguration.md)

[Test-DscConfiguration](Test-DscConfiguration.md)
