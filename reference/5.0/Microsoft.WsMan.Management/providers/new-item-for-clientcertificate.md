---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  New-Item for ClientCertificate
online version:  http://go.microsoft.com/fwlink/?LinkId=834973
---

# New-Item for ClientCertificate
Creates a new item. In this location, the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) command creates a new client certificate.  

## Syntax  

```  
New-Item -Issuer <string> -Subject <string> -ResourceURI <Uri> -Credential <PSCredential> [-Confirm] [-WhatIf] [<CommonParameters>]  

```  

## Description  
 The [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet creates a new item and sets its value. The types of items that can be created depend upon the location of the item.  

 In the ClientCertificate directory, you can use the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet to create and configure a client certificate. A client certificate is used when the WS-Management client is configured to use certificate authentication.  

## Parameters  

### -Issuer <string\>  
 Specifies the name of the certification authority that issued the certificate.  

|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -Subject <string\>  
 Specifies the entity that is identified by the certificate.  

|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -ResourceURI <Uri\>  
 Specifies the Uniform Resource Identifier (URI) that identifies a specific type of resource, such as a disk or a process, on a computer.  

 A URI consists of a prefix and a path to a resource. For example:  

 http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk  

 http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_NumericSensor  

|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -Credential <PSCredential\>  
 Specifies the credentials for a local or a domain account. It cannot be NULL.  

 The client computer can specify the credentials to use when creating  a shell on a computer. The user name must be specified in the domain\user_name form for a domain user. The user name must be specified in the server_name\user_name format for a local user on a server computer.  

 If you use this structure, then it should have both the user name and password fields specified. It can be used with Basic, Digest, Negotiate, or Kerberos authentication. The client must explicitly specify the credentials when either Basic or Digest authentication is used.  

|||  
|-|-|  
|Required?|true|  
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
C:\PS>$cred = Get-Credential  
C:\PS>New-Item -Path WSMan:\localhost\ClientCertificate -Issuer 1b3fd224d66c6413fe20d21e38b304226d192dfe -URI wmicimv2/* -Credential $cred;  

This command creates ClientCertificate entry that can be used by the WS-Management client. The new ClientCertificate will show up under the ClientCertificate directory as ClientCertificate_1234567890. All of the parameters are mandatory. The Issuer needs to be thumbprint of the issuers certificate.  

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

