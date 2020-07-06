---
external help file: PSDesiredStateConfiguration-help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: PSDesiredStateConfiguration
ms.date: 04/01/2020
online version: https://docs.microsoft.com/powershell/module/psdesiredstateconfiguration/invoke-dscresource?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Invoke-DscResource
---

# Invoke-DscResource

## SYNOPSIS
Runs a method of a specified PowerShell Desired State Configuration (DSC) resource.

## SYNTAX

```
Invoke-DscResource [-Name] <String> [[-ModuleName] <ModuleSpecification>] [-Method] <String>
 [-Property] <Hashtable> [<CommonParameters>]
```

## DESCRIPTION

The `Invoke-DscResource` cmdlet runs a method of a specified PowerShell Desired State Configuration
(DSC) resource.

This cmdlet invokes a DSC resource directly, without creating a configuration document. Using this
cmdlet, configuration management products can manage windows or Linux by using DSC resources. This
cmdlet also enables debugging of resources when the DSC engine is running with debugging enabled.

> [!NOTE]
> `Invoke-DscResource` is an experimental feature in PowerShell 7. To use the cmdlet, you must
> enable it using the following command.
>
> `Enable-ExperimentalFeature PSDesiredStateConfiguration.InvokeDscResource`

## EXAMPLES

### Example 1: Invoke the Set method of a resource by specifying its mandatory properties

This example invokes the **Set** method of a resource named Log and specifies a **Message** property
for it.

```powershell
Invoke-DscResource -Name Log -Method Set -ModuleName PSDesiredStateConfiguration -Property @{
  Message = 'Hello World'
}
```

### Example 2: Invoke the Test method of a resource for a specified module

This example invokes the **Test** method of a resource named **WindowsProcess**, which is in the
module named **PSDesiredStateConfiguration**.

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
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Get, Set, Test

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModuleName

Specifies the name of the module from which this cmdlet invokes the specified resource.

```yaml
Type: Microsoft.PowerShell.Commands.ModuleSpecification
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies the resource property name and its value in a hash table as key and value, respectively.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
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

### Microsoft.PowerShell.Commands.ModuleSpecification

## OUTPUTS

### System.Object

## NOTES

Previously, Windows PowerShell 5.1 resources ran under System context unless specified with user
context using the key **PsDscRunAsCredential**. In PowerShell 7.0, Resources run in the user's
context, and **PsDscRunAsCredential** is no longer supported. Previous configurations using this key
will throw an exception.

## RELATED LINKS

[Windows PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview/dscforengineers)

[Get-DscResource](Get-DscResource.md)
