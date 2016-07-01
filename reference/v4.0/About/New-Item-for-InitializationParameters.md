---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  New Item for InitializationParameters
ms.technology:  powershell
ms.assetid:  92f03160-ae7d-420f-ae66-bfa33215af48
---

# New-Item for InitializationParameters
Creates a new item.  
  
## Syntax  
  
```  
New-Item [-ParamName <string>] [-ParamValue <string>] [-Confirm] [-WhatIf] [<CommonParameters>]  
  
```  
  
## Description  
 The [New-Item](../Microsoft.Powershell.Management/New-Item.md) cmdlet creates a new item and sets its value. The types of items that can be created depend upon the location of the item. For example, in the file system, [New-Item](../Microsoft.Powershell.Management/New-Item.md) is used to create files and folders. In the registry, [New-Item](../Microsoft.Powershell.Management/New-Item.md) creates registry keys and entries.  
  
 In the InitializationParameters directory, you can use the [New-Item](../Microsoft.Powershell.Management/New-Item.md) cmdlet to create and configure Plugin initialization parameters.  
  
## Parameters  
  
### \-ParamName \<string\>  
 Specifies the display name to use for the initialization parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-ParamValue \<string\>  
 Specifies the value of an initialization parameter, which is a plug\-in\-specific value that is used to specify configuration options.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Confirm  
 Prompts you for confirmation before executing the command.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-WhatIf  
 Describes what would happen if you executed the command without actually executing the command.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \<CommonParameters\>  
 This cmdlet supports the common parameters: \-Verbose, \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, and \-OutVariable. For more information, see [about_CommonParameters](about_CommonParameters.md).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|System.Object<br /><br /> You can pipe a value for the new item to the New\-Item cmdlet.|  
|Outputs|Any|  
  
## Notes  
 The [New-Item](../Microsoft.Powershell.Management/New-Item.md) cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get\-PsProvider". For more information, see About\_Providers.  
  
## Example 1  
  
```  
C:\PS>New-Item -Path WSMan:\localhost\Plugin\TestPlugin\InitializationParameters -ParamName testparametername -ParamValue testparametervalue  
  
This command creates an Initialization parameter named testparametername in the InitializationParameters directory.  
  
```  
  
## See Also  
 [about_Providers](about_Providers.md)   
 [Get-Item](../Microsoft.Powershell.Management/Get-Item.md)   
 [Set-Item](../Microsoft.Powershell.Management/Set-Item.md)   
 [Remove-Item](../Microsoft.Powershell.Management/Remove-Item.md)   
 [Clear-Item](../Microsoft.Powershell.Management/Clear-Item.md)   
 [Invoke-Item](../Microsoft.Powershell.Management/Invoke-Item.md)   
 [Rename-Item](../Microsoft.Powershell.Management/Rename-Item.md)   
 [Move-Item](../Microsoft.Powershell.Management/Move-Item.md)   
 [Copy-Item](../Microsoft.Powershell.Management/Copy-Item.md)

