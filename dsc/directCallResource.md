---
ms.date:  2017-06-12
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Calling DSC resource methods directly
---

# Calling DSC resource methods directly

>Applies To: Windows PowerShell 5.0

You can use the [Invoke-DscResource](https://technet.microsoft.com/library/mt517869.aspx) cmdlet to directly call the functions or methods of a DSC resource (The **Get-TargetResource**,
**Set-TargetResource**, and **Test-TargetResource** functions of a MOF-based resource, or the **Get**, **Set**, and **Test** methods of a class-based resource). 
This can be used by third-parties that want to use DSC resources, or as a helpful tool while developing resources. 

This cmdlet is typically used in combination with a metaconfiguration property `refreshMode = 'Disabled'`, but it can be used no matter what **refreshMode** is set to.

When calling the **Invoke-DscResource** cmdlet, you specify which method or function to call by using the **Method** parameter. You specify the properties of the resource by passing a 
hashtable as the value of the **Property** parameter.

The following are examples of directly calling resource methods:

## Ensure a file is present

```powershell
$result = Invoke-DscResource -Name File -Method Set -Property @{
							DestinationPath = "$env:SystemDrive\\DirectAccess.txt";
							Contents = 'This file is create by Invoke-DscResource'} -Verbose
$result | fl
```

## Test that a file is present

```powershell
$result = Invoke-DscResource -Name File -Method Test -Property @{
							DestinationPath="$env:SystemDrive\\DirectAccess.txt";
							Contents='This file is create by Invoke-DscResource'} -Verbose
$result | fl
```

## Get the contents of file

```powershell
$result = Invoke-DscResource -Name File -Method Get -Property @{
							DestinationPath="$env:SystemDrive\\DirectAccess.txt";
							Contents='This file is create by Invoke-DscResource'} -Verbose
$result.ItemValue | fl
```

>**Note:** Directly calling composite resource methods is not supported. Instead, call the methods of the underlying resources that make up the composite resource.

## See Also
- [Writing a custom DSC resource with MOF](authoringResourceMOF.md) 
- [Writing a custom DSC resource with PowerShell classes](authoringResourceClass.md)
- [Debugging DSC resources](debugResource.md)

