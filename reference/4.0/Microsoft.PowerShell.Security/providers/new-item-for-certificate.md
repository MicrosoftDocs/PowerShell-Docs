---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  New-Item for Certificate
---

# New-Item for Certificate
Creates new certificate stores in the LocalMachine store location.  
  
## Syntax  
  
```  
New-Item [-Path] <string[]> [-Name <string>] [-Confirm] [-WhatIf] [<CommonParameters>]  
  
New-Item [-Path] <string[]> [-Confirm] [-WhatIf] [<CommonParameters>]  
  
```  
  
## Description  
 In the Cert: drive, the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet creates new certificate stores in the LocalMachine certificate store location. The Windows PowerShell [Certificate Provider](Certificate-Provider.md) adds the Cert: drive to Windows PowerShell.  
  
 Beginning in Windows PowerShell 3.0, the Certificate provider enables you to use the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet to create new certificate stores. You can also use the [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md) cmdlet to delete the certificate stores that you create.  You cannot use the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet to create certificates or certificate store locations, or to create certificate stores in the CurrentUser certficate store location.  
  
 Note:  In the Cert: drive, only the Name, Path, WhatIf, and Confirm parameters of [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) are effective. All other parameter and parameter values are ignored.  
  
## Parameters  
  
### -Name <string\>  
 Specifies the name the new certificate store. You can use the Name parameter or include the name in the value of the Path parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|true (ByPropertyName)|  
|Accept Wildcard Characters?|false|  
  
### -Path <string[]>  
 Specifies the full or relative path to the new certificate store. You can include the name of the certificate store in the path or use the Name parameter to specify the name.  
  
|||  
|-|-|  
|Required?|true|  
|Position?|1|  
|Default Value||  
|Accept Pipeline Input?|true (ByPropertyName)|  
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
 This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, -OutVariable,  -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../../Microsoft.PowerShell.Core/About/about_CommonParameters.md).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs||  
|Outputs|System.Security.Cryptography.X509Certificates.X509Store<br /><br /> New-Item returns an X509Store object that represents the new certificate store.|  
  
## Notes  
 -- Beginning in Windows PowerShell 3.0, the Microsoft.PowerShell.Security module that contains the Cert: drive is not imported automatically into every session. To use the Cert: drive, use the [Import-Module](../../Microsoft.PowerShell.Core/Import-Module.md) cmdlet to import the module, or run a command that uses the Cert: drive, such as a "[Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md) Cert:" command.  
  
 -- In the Cert: drive, the ItemType parameter is ignored. You do not need to specify an item type to create a certificate store.  
  
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
 [Certificate Provider](Certificate-Provider.md)   
 [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)   
 [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Get-PSDrive](../../Microsoft.PowerShell.Management/Get-PSDrive.md)   
 [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md)   
 [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)

