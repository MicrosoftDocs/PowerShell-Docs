---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Move-Item for Certificate
online version:  http://go.microsoft.com/fwlink/?LinkId=834970
---

# Move-Item for Certificate
Moves certificates from one certificate store to another certificate store.  

## Syntax  

```  
Move-Item [-Path] <string[]> [[-Destination] <string>] [-Confirm] [-WhatIf] [<CommonParameters>]  

```  

## Description  
 In the Cert: drive, [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md) moves certificates from one certificate store to another certificate store. The Windows PowerShell [Certificate Provider](Certificate-Provider.md) adds the Cert: drive to Windows PowerShell.  

 Beginning in Windows PowerShell 3.0, the Certificate provider enhances its support for managing Secure Socket Layer (SSL) certificates for web hosting by enabling you to use the [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md) cmdlet to move certificates between certificate stores.  You cannot use this feature to move a certificate to a different certificate store location, such as a move from LocalMachine to CurrentUser, or to move certificate stores. Also, [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md) does not move private keys.  

 NOTE: In the Cert: drive, only the Path, Destination, WhatIf, and Confirm parameters of the [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md) cmdlet are effective. All other parameter and parameter values are ignored.  

## Parameters  

### -Destination <string\>  
 Specifies the path to the location where the items are being moved. The default is the current certificate store. Wildcards  

 are permitted, but the result must specify a single location.  

 To rename the item that is being moved, specify a new name in the value of the Destination parameter.  

|||  
|-|-|  
|Required?|false|  
|Position?|2|  
|Default Value|Current certificate store|  
|Accept Pipeline Input?|true (ByValue, ByPropertyName)|  
|Accept Wildcard Characters?|false|  

### -Path <string[]>  
 Specifies the path to the original location of the certificate.  Wildcards are permitted.  

|||  
|-|-|  
|Required?|true|  
|Position?|1|  
|Default Value|None|  
|Accept Pipeline Input?|true (ByValue, ByPropertyName)|  
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
|Inputs|System.String<br /><br /> You can pipe a certificate path to the Move-Item cmdlet.|  
|Outputs|None<br /><br /> This cmdlet does not generate any output.|  

## Notes  
 -- Beginning in Windows PowerShell 3.0, the Microsoft.PowerShell.Security module that contains the Cert: drive is not imported automatically into every session. To use the Cert: drive, use the [Import-Module](../../Microsoft.PowerShell.Core/Import-Module.md) cmdlet to import the module, or run a command that uses the Cert: drive, such as a "[Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md) Cert:" command.  

## Example 1  

```  
C:\PS>Move-Item -Path cert:\LocalMachine\My\5DDC44652E62BF9AA1116DC41DE44AB47C87BDD0 -Destination cert:\LocalMachine\WebHosting  

Description  
-----------  
This command uses the Move-Item cmdlet to move a certificate from the My store to the WebHosting store.   

Because the command uses absolute paths, you can run it from any Windows PowerShell drive. You can also run it from a Cert: drive path and use relative paths.  

```  

## Example 2  

```  
C:\PS>Get-ChildItem -Path cert:\LocalMachine\My -EKU "Server Authentication" | Move-Item -Destination cert:\LocalMachine\WebHosting  

Description  
-----------  
This command uses the EKU parameter of the Get-ChildItem cmdlet to get SSL server authentication certificates in the MY certificate store.  

It uses a pipeline operator to send the certificates to the Move-Item cmdlet, which moves the certificates to the WebHosting store.  

```  

## See Also  
 [Certificate Provider](Certificate-Provider.md)   
 [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)   
 [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Get-PfxCertificate](../Get-PfxCertificate.md)   
 [Get-PSDrive](../../Microsoft.PowerShell.Management/Get-PSDrive.md)   
 [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)   
 [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)

