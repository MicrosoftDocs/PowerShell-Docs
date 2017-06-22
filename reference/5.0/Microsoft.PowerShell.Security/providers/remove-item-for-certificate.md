---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Remove-Item for Certificate
online version:  http://go.microsoft.com/fwlink/?LinkId=834972
---

# Remove-Item for Certificate
Deletes certificate stores, certificates, and private keys.  

## Syntax  

```  
Remove-Item [-Path] <string[]> [-DeleteKey] [-Confirm] [-WhatIf] [<CommonParameters>]  

```  

## Description  
 In the Cert: drive, the Remove-Item cmdlet deletes certificates and their associated private keys. It also deletes certificate stores in the LocalMachine certificate store location that you create by using the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet. The Windows PowerShell [Certificate Provider](Certificate-Provider.md) adds the Cert: drive to Windows PowerShell.  

 Beginning in Windows PowerShell 3.0, the Certificate provider enhances its support for managing Secure Socket Layer (SSL) certificates for web hosting by enabling you to use the Remove-Item cmdlet to delete certificates and private keys, and to delete user-created certificate stores in the LocalMachine certificate store location. However, you cannot use this feature to delete certificate store locations, such as CurrentUser or LocalMachine, or certificate stores that Windows creates.  

 Note:  In the Cert: drive, only the DeleteKey, Path, WhatIf, and Confirm parameters of Remove-Item are effective. All other parameter and parameter values are ignored.  

## Parameters  

### -DeleteKey  
 Deletes the associated private key when it deletes the certificate.  

 To delete a private key that is associated with a user certificate in the Cert:\CurrentUser store location on a remote computer, you must use delegated credentials. When using the [Invoke-Command](../../Microsoft.PowerShell.Core/Invoke-Command.md) cmdlet to run a Remove-Item command remotely, after considering the security risks, use the CredSSP parameter to enable delegation. This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.  

 This parameter was introduced in Windows PowerShell 3.0.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|False|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -Path <string[]>  
 Specifies the path to the certificates and certificate stores that are being deleted. Wildcards are permitted. The parameter name ("-Path") is optional.  

|||  
|-|-|  
|Required?|true|  
|Position?|1|  
|Default Value||  
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
|Inputs|System.String<br /><br /> You can pipe a path to the Remove-Item cmdlet in the Cert: drive.|  
|Outputs|None<br /><br /> This cmdlet does not generate any output.|  

## Notes  
 -- Beginning in Windows PowerShell 3.0, the Microsoft.PowerShell.Security module that contains the Cert: drive is not imported automatically into every session. To use the Cert: drive, use the [Import-Module](../../Microsoft.PowerShell.Core/Import-Module.md) cmdlet to import the module, or run a command that uses the Cert: drive, such as a "[Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md) Cert:" command.  

## Example 1  

```  
C:\PS>Remove-Item -Path cert:\LocalMachine\CA\5DDC44652E62BF9AA1116DC41DE44AB47C87BDD0  

Description  
-----------  
This command deletes a certificate from the CA certificate store, but leaves the associated private key intact.  

```  

## Example 2  

```  
C:\PS># Delete a certificate and private key on a remote computer  

Description  
-----------  
This series of commands enables delegation and then deletes the certificate and associated private key on a remote computer. To delete a private key on a remote computer, you must use delegated credentials.   

The first command uses the Enable-WSManCredSSP cmdlet to enable Credential Security Service Provider (CredSSP) authentication on a client on the S1 remote computer. CredSSP permits delegated authentication.  

PS C:\> Enable-WSManCredSSP -Role Client -DelegateComputer S1  

The second command uses the Connect-WSMan cmdlet to connect the S1 computer to the WinRM service on the local computer. When this command completes, the S1 computer appears in the local WSMan: drive in Windows PowerShell.  

PS C:\> Connect-WSMan -ComputerName S1 -Credential Domain01\Admin01  

The third command uses the Set-Item cmdlet in the WSMan: drive to enable the CredSSP attribute for the WinRM service.  

PS C:\> Set-Item -Path WSMan:\S1\Service\Auth\CredSSP -Value $true  

The fourth command uses the New-PSSession cmdlet to start a remote session on the S1 computer with CredSSP authentication. It saves the session in the $s variable.  

PS C:\> $s  = New-PSSession S1 -Authentication CredSSP -Credential Domain01\Admin01  

The fifth command uses the Invoke-Command cmdlet to run a Remove-Item command in the session in the $s variable. The Remove-Item command uses the DeleteKey parameter to remove the private key along with the specified certificate.   

PS C:\> Invoke-Command -Session $s { Remove-Item cert:\LocalMachine\My\D2D38EBA60CAA1C12055A2E1C83B15AD450110C2 -DeleteKey  }  

```  

## Example 3  

```  
C:\PS>Get-ChildItem -Path cert:\LocalMachine\WebHosting -ExpiringInDays 0 | Remove-Item -DeleteKey  

Description  
-----------  
This command uses the ExpiringInDays parameter of the Get-ChildItem cmdlet with a value of 0 to get certificates in the WebHosting store that have expired.  

It uses a pipeline operator to pass the certificates to the Remove-Item cmdlet, which deletes them. The command uses the DeleteKey parameter to delete the private key along with the certificate.  

```  

## Example 4  

```  
C:\PS>Get-ChildItem -Path cert:\LocalMachine -DnsName *Fabrikam* | Remove-Item  

Description  
-----------  
This command deletes all certificates that have a DNS name that contains "Fabrikam". It uses the DNSName parameter of the Get-ChildItem cmdlet to get the certificates and the Remove-Item cmdlet to delete them.  

```  

## See Also  
 [Certificate Provider](Certificate-Provider.md)   
 [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)   
 [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Get-PfxCertificate](../Get-PfxCertificate.md)   
 [Get-PSDrive](../../Microsoft.PowerShell.Management/Get-PSDrive.md)   
 [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md)   
 [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)

