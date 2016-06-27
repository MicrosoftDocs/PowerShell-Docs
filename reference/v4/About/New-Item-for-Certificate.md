---
title: New-Item for Certificate
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2eba8487-1d71-49e2-bcc3-e885d2a06438
---
# New-Item for Certificate
Creates new certificate stores in the LocalMachine store location.  
  
## Syntax  
  
```  
New-Item [-Path] <string[]> [-Name <string>] [-Confirm] [-WhatIf] [<CommonParameters>]  
  
New-Item [-Path] <string[]> [-Confirm] [-WhatIf] [<CommonParameters>]  
  
```  
  
## Description  
 In the Cert: drive, the [New\-Item&#91;PSITPro4\_Management&#93;](assetId:///67038d02-6598-49c6-b5bd-77b59d445abe) cmdlet creates new certificate stores in the LocalMachine certificate store location. The Windows PowerShell [Certificate Provider](../Topic/Certificate-Provider.md) adds the Cert: drive to Windows PowerShell.  
  
 Beginning in Windows PowerShell 3.0, the Certificate provider enables you to use the [New\-Item&#91;PSITPro4\_Management&#93;](assetId:///67038d02-6598-49c6-b5bd-77b59d445abe) cmdlet to create new certificate stores. You can also use the [Remove\-Item&#91;PSITPro4\_Management&#93;](assetId:///0fe3ff11-a1f7-43b9-8c85-f92d52641395) cmdlet to delete the certificate stores that you create.  You cannot use the [New\-Item&#91;PSITPro4\_Management&#93;](assetId:///67038d02-6598-49c6-b5bd-77b59d445abe) cmdlet to create certificates or certificate store locations, or to create certificate stores in the CurrentUser certficate store location.  
  
 Note:  In the Cert: drive, only the Name, Path, WhatIf, and Confirm parameters of [New\-Item&#91;PSITPro4\_Management&#93;](assetId:///67038d02-6598-49c6-b5bd-77b59d445abe) are effective. All other parameter and parameter values are ignored.  
  
## Parameters  
  
### \-Name \<string\>  
 Specifies the name the new certificate store. You can use the Name parameter or include the name in the value of the Path parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|true \(ByPropertyName\)|  
|Accept Wildcard Characters?|false|  
  
### \-Path \<string\[\]\>  
 Specifies the full or relative path to the new certificate store. You can include the name of the certificate store in the path or use the Name parameter to specify the name.  
  
|||  
|-|-|  
|Required?|true|  
|Position?|1|  
|Default Value||  
|Accept Pipeline Input?|true \(ByPropertyName\)|  
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
 This cmdlet supports the common parameters: \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, \-OutVariable,  \-Verbose, \-WarningAction, and \-WarningVariable. For more information, see [about\_CommonParameters](../Topic/about_CommonParameters.md).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs||  
|Outputs|System.Security.Cryptography.X509Certificates.X509Store<br /><br /> New\-Item returns an X509Store object that represents the new certificate store.|  
  
## Notes  
 \-\- Beginning in Windows PowerShell 3.0, the Microsoft.PowerShell.Security module that contains the Cert: drive is not imported automatically into every session. To use the Cert: drive, use the [Import\-Module&#91;PSITPro4\_Core&#93;](assetId:///af616c24-e122-4098-930e-1e3ea2080ade) cmdlet to import the module, or run a command that uses the Cert: drive, such as a "[Set\-Location&#91;PSITPro4\_Management&#93;](assetId:///d7f353cd-ebd7-462a-bd57-1498dc8b88a6) Cert:" command.  
  
 \-\- In the Cert: drive, the ItemType parameter is ignored. You do not need to specify an item type to create a certificate store.  
  
## Example 1  
  
```  
C:\PS>New-Item -Path Cert:\LocalMachine\TestStore  
  
Name : TestStore  
  
Description  
-----------  
This command uses the New-Item cmdlet to create the "TestStore" certificate store in the LocalMachine store location.   
  
The command returns a System.Security.Cryptography.X509Certificates.X509Store that represents the new certificate store.  
  
```  
  
## Example 2  
  
```  
C:\PS>New-Item -Path Cert:\LocalMachine -Name TestStore  
  
Name : TestStore  
  
Description  
-----------  
This command uses the New-Item cmdlet to create the "TestStore" certificate store in the LocalMachine store location. It is identical to the previous command, but it uses the Name parameter to specify the store name, instead of the Path parameter. The effect is identical.  
  
```  
  
## Example 3  
  
```  
C:\PS>Invoke-Command -ComputerName Server01 { New-Item -Path Cert:\LocalMachine\TestStore }  
  
Description  
-----------  
This command creates the TestStore certificate store on the Server01 remote computer. It uses the Invoke-Command cmdlet to run the New-Item command remotely.  
  
```  
  
## See Also  
 [Certificate Provider](../Topic/Certificate-Provider.md)   
 [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190)   
 [Get\-Item&#91;PSITPro4\_Management&#93;](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa)   
 [Get\-PSDrive&#91;PSITPro4\_Management&#93;](assetId:///6c176030-de74-40f3-8f48-7b4d871c3238)   
 [Move\-Item&#91;PSITPro4\_Management&#93;](assetId:///de1b4217-de99-45cd-a12c-35e87b0c8466)   
 [Remove\-Item&#91;PSITPro4\_Management&#93;](assetId:///0fe3ff11-a1f7-43b9-8c85-f92d52641395)