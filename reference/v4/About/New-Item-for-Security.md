---
title: New-Item for Security
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac8b67d5-2728-4ada-8b4d-6190cf2c9092
---
# New-Item for Security
Creates a new item.  
  
## Syntax  
  
```  
New-Item [-URI <Uri>] [-SDDL <string>] [-ExactMatch] [-Confirm] [-WhatIf] [<CommonParameters>]  
  
```  
  
## Description  
 The [New-Item](New-Item.md) cmdlet creates a new item and sets its value. The types of items that can be created depend upon the location of the item. For example, in the file system, [New-Item](New-Item.md) is used to create files and folders. In the registry, [New-Item](New-Item.md) creates registry keys and entries.  
  
 In the Security directory, you can use the [New-Item](New-Item.md) cmdlet to create and configure Plugin security.  
  
## Parameters  
  
### \-URI \<Uri\>  
 Identifies the URI for which access is authorized based on the value of the Sddl parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-SDDL \<string\>  
 Specifies the Security Descriptor Definition Language \(SDDL\) for the access control entry. This identifies the security settings that are used to authorize access to a specified resource URI.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-ExactMatch  
 Specifies how to use the security settings that are specified in the Sddl parameter. If the ExactMatch parameter is set to True, the security settings in Sddl are used only to authorize access attempts to the URI exactly as specified by the URI.  
  
 If ExactMatch is set to false, the security settings in Sddl are used to authorize access attempts to the URIs that begin with the string specified in the URI.  
  
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
 This cmdlet supports the common parameters: \-Verbose, \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, and \-OutVariable. For more information, see [about\_CommonParameters](assetId:///cd121ee6-f6a8-4aa6-8f89-94edcedb6780).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|System.Object<br /><br /> You can pipe a value for the new item to the New\-Item cmdlet.|  
|Outputs|Any|  
  
## Notes  
 The [New-Item](New-Item.md) cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get\-PsProvider". For more information, see About\_Providers.  
  
## Example 1  
  
```  
C:\PS>New-Item -path WSMan:\localhost\Plugin\TestPlugin\Resources\Resource_5967683\Security -Sddl "O:NSG:BAD:P(A;;GA;;;BA)S:P(AU;FA;GA;;;WD)(AU;SA;GWGX;;;WD)"  
  
This command creates a security entry in the Security directory of Resource_5967683 (a specific resource).  
  
```  
  
## See Also  
 [about\_Providers](assetId:///55e2974f-3314-48d2-8b1b-abdea6b303cb)   
 [Get-Item](Get-Item.md)   
 [Set-Item](Set-Item.md)   
 [Remove-Item](Remove-Item.md)   
 [Clear-Item](Clear-Item.md)   
 [Invoke-Item](Invoke-Item.md)   
 [Rename-Item](Rename-Item.md)   
 [Move-Item](Move-Item.md)   
 [Copy-Item](Copy-Item.md)