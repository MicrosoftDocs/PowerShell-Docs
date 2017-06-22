---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  New-Item for Security
---

# New-Item for Security
Creates a new item.  
  
## Syntax  
  
```  
New-Item [-URI <Uri>] [-SDDL <string>] [-ExactMatch] [-Confirm] [-WhatIf] [<CommonParameters>]  
  
```  
  
## Description  
 The [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet creates a new item and sets its value. The types of items that can be created depend upon the location of the item. For example, in the file system, [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) is used to create files and folders. In the registry, [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) creates registry keys and entries.  
  
 In the Security directory, you can use the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet to create and configure Plugin security.  
  
## Parameters  
  
### -URI <Uri\>  
 Identifies the URI for which access is authorized based on the value of the Sddl parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -SDDL <string\>  
 Specifies the Security Descriptor Definition Language (SDDL) for the access control entry. This identifies the security settings that are used to authorize access to a specified resource URI.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -ExactMatch  
 Specifies how to use the security settings that are specified in the Sddl parameter. If the ExactMatch parameter is set to True, the security settings in Sddl are used only to authorize access attempts to the URI exactly as specified by the URI.  
  
 If ExactMatch is set to false, the security settings in Sddl are used to authorize access attempts to the URIs that begin with the string specified in the URI.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Confirm  
 Prompts you for confirmation before executing the command.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -WhatIf  
 Describes what would happen if you executed the command without actually executing the command.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### <CommonParameters\>  
 This cmdlet supports the common parameters: -Verbose, -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, and -OutVariable. For more information, see [about_CommonParameters](../../Microsoft.PowerShell.Core/About/about_CommonParameters.md).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|System.Object<br /><br /> You can pipe a value for the new item to the New-Item cmdlet.|  
|Outputs|Any|  
  
## Notes  
 The [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get-PsProvider". For more information, see About_Providers.  
  
## Example 1  
  
```  
C:\PS>New-Item -path WSMan:\localhost\Plugin\TestPlugin\Resources\Resource_5967683\Security -Sddl "O:NSG:BAD:P(A;;GA;;;BA)S:P(AU;FA;GA;;;WD)(AU;SA;GWGX;;;WD)"  
  
This command creates a security entry in the Security directory of Resource_5967683 (a specific resource).  
  
```  
  
## See Also  
 [about_Providers](../../Microsoft.PowerShell.Core/About/about_Providers.md)   
 [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)   
 [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)   
 [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md)   
 [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md)   
 [Rename-Item](../../Microsoft.PowerShell.Management/Rename-Item.md)   
 [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md)   
 [Copy-Item](../../Microsoft.PowerShell.Management/Copy-Item.md)

