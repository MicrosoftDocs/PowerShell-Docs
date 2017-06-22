---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Get-ChildItem for Certificate
online version:  http://go.microsoft.com/fwlink/?LinkId=834969
---

# Get-ChildItem for Certificate
Gets certificate store locations, certificate stores, and certificates in the Windows PowerShell Cert: drive.  

## Syntax  

```  
Get-ChildItem [-CodeSigningCert] [-DnsName <string>] [-EKU <string>] [-ExpiringInDays <int>] [-SSLServerAuthentication] [<CommonParameters>]  

```  

## Description  
 In the Cert: drive, the [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet gets certificate store locations, certificate stores, and certificates. The Windows PowerShell [Certificate Provider](Certificate-Provider.md) adds the Cert: drive to Windows PowerShell.  

 Beginning in Windows PowerShell 3.0, the Certificate provider enhances its support for managing Secure Socket Layer (SSL) certificates for web hosting. New filtering parameters, DnsName, EKU, ,ExpiringInDays, and SSLServerAuthentication have been added to [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) to enable you to search for certificates based on their DNS names and expiration dates, and distinguish client and server authentication certificates by the value of their Enhanced Key Usage (EKU) properties. The new dynamic parameters work in Windows PowerShell 3.0 and newer releases of Windows PowerShell, running on Windows 8, Windows Server 2012 and newer releases of the Windows operating system.  

 Also, new script properties, DnsNameList and EnhancedKeyUsageList, and SendAsTrustedIssuer, have been added to the x509Certificate2 object that represents the certificates to make it easy to search and manage the certificates.  

 To populate the DnsNameList property, the Certificate provider copies the content from the DNSName entry in the SubjectAlternativeName (SAN) extension. If the SAN extension is empty, the property is populated with content from the Subject field of the certificate. To populate the EnhancedKeyUsageList property, the Certificate provider copies the content from the Friendly Name and OID properties of the EnhancedKeyUsage (EKU) field in the certificate.  

 NOTE: The Name parameter of [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) is not supported in the Cert: drive. To indicate items in the Cert: drive, use the Path parameter.  

## Parameters  

### -CodeSigningCert  
 Gets only those certificates with code-signing authority. This parameter gets certificates that have "Code Signing" in their EnhancedKeyUsageList property value.  

 Because certificates that have an empty EnhancedKeyUsageList can be used for all purposes, searches for code signing certificates also return certificates that have an empty EnhancedKeyUsageList property value.  

 This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.  

 This parameter was introduced in Windows PowerShell 1.0.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|False|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -DocumentEncryptionCert  
 Gets those certificates in the certificate provider that are used for document encryption. Document encryption certificates have a value of "{text}%szOID_DOCUMENT_ENCRYPTION%" for the EnhancedKeyUsageList property.  

 This parameter was introduced in Windows PowerShell 5.0.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|False|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -DnsName <string\>  
 Gets certificates that have the specified domain name or name pattern in the DNSNameList property of the certificate.  The value of the DnsName parameter can either be Unicode or ASCII. Punycode values are converted to Unicode. Wildcard characters (*) are permitted.  

 This parameter was introduced in Windows PowerShell 3.0.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|None|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|true|  

### -EKU <string\>  
 Gets certificates that have the specified text or text pattern in the EnhancedKeyUsageList property of the certificate.  Wildcard characters (*) are permitted. The EnhancedKeyUsageList property contains the friendly name and the OID fields of the EKU.  

 Because certificates that have an empty EnhancedKeyUsageList can be used for all purposes, all EKU searches return certificates that have an empty EnhancedKeyUsageList property value.  

 This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.  

 This parameter was introduced in Windows PowerShell 3.0.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|None|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|true|  

### -ExpiringInDays <int\>  
 Gets certificates that are expiring in or before the specified number of days. Enter an integer. A value of 0 (zero) gets certificates that have expired. This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.  

 The ExpiringInDays parameter uses the value of the NotAfter property of the certificate, which stores the expiration date of the certificate. The effective date is stored in the NotBefore property of the certificate.  

 This parameter was introduced in Windows PowerShell 3.0. It runs on Windows 8, Windows Server 2012, and newer releases of the Windows operating system.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|None|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -SSLServerAuthentication  
 Gets only server certificates for SSL web hosting. This parameter gets certificates that have "Server Authentication" in their EnhancedKeyUsageList property value.  

 Because certificates that have an empty EnhancedKeyUsageList can be used for all purposes, SSLServerAuthentication searches also return certificates that have an empty EnhancedKeyUsageList property value.  

 This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.  

 This parameter was introduced in Windows PowerShell 3.0.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|False|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### <CommonParameters\>  
 This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, -OutVariable,  -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../../Microsoft.PowerShell.Core/About/about_CommonParameters.md).  

## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  

|||  
|-|-|  
|Inputs|System.String<br /><br /> In the Cert: drive, you can pipe a path to Get-ChildItem.|  
|Outputs|Microsoft.PowerShell.Commands.X509StoreLocation, System.Security.Cryptography.X509Certificates.X509Store, System.Security.Cryptography.X509Certificates.X509Certificate2,  System.String<br /><br /> In the Cert: drive, Get-ChildItem returns objects that represent certificate store locations, certificate stores, and certificates. When you use the Name parameter, it returns the object name as a string.|  

## Notes  
 -- Beginning in Windows PowerShell 3.0, the Microsoft.PowerShell.Security module that contains the Cert: drive is not imported automatically into every session. To use the Cert: drive, use the [Import-Module](../../Microsoft.PowerShell.Core/Import-Module.md) cmdlet to import the module, or run a command that uses the Cert: drive, such as a "[Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md) Cert:" command.  

 -- The CodeSigningCert, DnsName, EKU, and ExpiringInParameter parameters are valid in all subdirectories of the Certificate provider, but they are effective only on certificates.  

## Example 1  

```  
C:\PS>PS cert:\> Get-ChildItem  

Location   : CurrentUser  
StoreNames : {TrustedPublisher, ClientAuthIssuer, Root, UserDS...}  

Location   : LocalMachine  
StoreNames : {TrustedPublisher, ClientAuthIssuer, Remote Desktop, Root...}  

Description  
-----------  
At the root of the Cert: drive, the Get-ChildItem cmdlet gets certificate store locations.  

```  

## Example 2  

```  
C:\PS>PS cert:\LocalMachine\> Get-ChildItem  

Name : TrustedPublisher  

Name : ClientAuthIssuer  

Name : Remote Desktop  

Name : Root  

Name : KRA  

Name : TrustedDevices  

Name : WebHosting  

Name : CA  

Name : REQUEST  

Name : AuthRoot  

Name : TrustedPeople  

Name : My  

Name : SmartCardRoot  

Name : Trust  

Name : Disallowed  

Description  
-----------  
In a certificate store location in Cert: drive, the Get-ChildItem cmdlet gets certificate stores.  

```  

## Example 3  

```  
C:\PS>PS cert:\LocalMachine\My\> Get-ChildItem  

Thumbprint                                Subject  
----------                                -------  
D259F7B1DA04D41451866A2D464EC4A71BCBEDCD  CN=fabrikam-v6_CA, OU=Microsoft PKI Team  
5B047DCA542A9E46C0EC7BF1AD7889612CADAA2E  CN=fabrikam-V6.dfabrikam-v5.fabrikam.com  
3A37D8CEAA95E4FD099FC87F7E2779813D6BF4CC  CN=fabrikam-V6.dfabrikam-v5.fabrikam.com  
2E0334D695038DFA40C1D982E5C296EFECA893BB  CN=fabrikam-V6.dfabrikam-v5.fabrikam.com  
2C85D4CE7A0FA08FF66A4397B2F410071913D03B  CN=fabrikam-V6.dfabrikam-v5.fabrikam.com  

Description  
-----------  
In a certificate store in Cert: drive, the Get-ChildItem cmdlet gets certificates.  

```  

## Example 4  

```  
C:\PS>PS cert:\LocalMachine\My\> Get-ChildItem -Path D259F7B1DA04D41451866A2D464EC4A71BCBEDCD | Format-List -Property *  

PSPath               : Certificate::LocalMachine\my\5B047DCA542A9E46C0EC7BF1AD7889612CADAA2E  
PSParentPath         : Certificate::LocalMachine\my  
PSChildName          : 5B047DCA542A9E46C0EC7BF1AD7889612CADAA2E  
PSDrive              : cert  
PSProvider           : Certificate  
PSIsContainer        : False  
EnhancedKeyUsageList : {Client Authentication (1.3.6.1.5.5.7.3.2), Server Authentication (1.3.6.1.5.5.7.3.1)}  
DnsNameList          : {fabrikam-V6.dfabrikam-v5.fabrikam.com}  
Archived             : False  
Extensions           : {System.Security.Cryptography.Oid, System.Security.Cryptography.Oid,  
                       System.Security.Cryptography.Oid, System.Security.Cryptography.Oid...}  
FriendlyName         :  
IssuerName           : System.Security.Cryptography.X509Certificates.X500DistinguishedName  
NotAfter             : 4/21/2012 10:08:18 AM  
NotBefore            : 4/22/2011 10:08:18 AM  
HasPrivateKey        : True  
PrivateKey           :  
PublicKey            : System.Security.Cryptography.X509Certificates.PublicKey  
RawData              : {48, 130, 6, 124...}  
SerialNumber         : 220000000485E38FCF54250BCD000000000004  
SubjectName          : System.Security.Cryptography.X509Certificates.X500DistinguishedName  
SignatureAlgorithm   : System.Security.Cryptography.Oid  
Thumbprint           : 5B047DCA542A9E46C0EC7BF1AD7889612CADAA2E  
Version              : 3  
Handle               : 545160087216  
Issuer               : CN=fabrikam-v6_CA, OU=Microsoft PKI Team  
Subject              : CN=fabrikam-V6.dfabrikam-v5.fabrikam.com  

Description  
-----------  
This command displays all of the properties and property values of a certificate in a list. It uses the Get-ChildItem cmdlet to get the certificate and the Format-List cmdlet to display the properties.  

If the value of a property is an object name, use dot notation to display the object value. For example, "(Get-ChildItem -Path D259F7B1DA04D41451866A2D464EC4A71BCBEDCD).IssuerName".  

```  

## Example 5  

```  
C:\PS>Get-ChildItem -Path cert: -CodeSigningCert -Recurse  

Description  
-----------  
This command uses the CodeSigningCert and Recurse parameters of the Get-ChildItem cmdlet to get all of the certificates on the computer that have code-signing authority. Because the full path is specified, this command can be run in any Windows PowerShell drive.  

```  

## Example 6  

```  
C:\PS>Get-ChildItem -Path cert:\LocalMachine\WebHosting -DNSName "*fabrikam*"  

Description  
-----------  
This command uses the DNSName parameter of the Get-ChildItem cmdlet to get all of the certificates in the WebHosting store whose domain names contain "Fabrikam".  

```  

## Example 7  

```  
C:\PS>Get-ChildItem -Path cert:\LocalMachine\WebHosting -ExpiringInDays 30  

Description  
-----------  
This command uses the ExpiringInDays parameter of the Get-ChildItem cmdlet to get certificates that will expire within the next 30 days.  

```  

## Example 8  

```  
C:\PS>Invoke-Command -ComputerName Srv01, Srv02 -ScriptBlock {Get-ChildItem -Path cert:\* -Recurse -ExpiringInDays 0}  

Description  
-----------  
This command uses the Invoke-Command cmdlet to run a Get-ChildItem command on the Srv01 and Srv02 computers. A value of zero (0) in the ExpiringInDays parameter gets all certificates on the Srv01 and Srv02 computers that have expired.  

```  

## Example 9  

```  
C:\PS>Get-ChildItem -Path cert:\LocalMachine\My, cert:\LocalMachine\WebHosting -EKU "Server Authentication"  

Description  
-----------  
This command uses the EKU parameter of the Get-ChildItem cmdlet to get all Server SSL Certificates in the My and WebHosting stores.  

```  

## Example 10  

```  
C:\PS>Get-ChildItem -Path cert:\* -Recurse  -DNSName "*fabrikam*" -EKU "*Server*" | Where-Object {$_.SendAsTrustedIssuer -and $_.NotAfter -gt (get-date).AddDays.(30)}  

Description  
-----------  
This command gets all certificates in the LocalMachine store location that have "fabrikam" in their DNS name, "Server" in their EKU, a value of $true for the SendAsTrustedIssuer property, and do not expire within the next 30 days. The NotAfter property stores the certificate expiration date.  

```  

## See Also  
 [Certificate Provider](Certificate-Provider.md)   
 [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Get-PfxCertificate](../Get-PfxCertificate.md)   
 [Get-PSDrive](../../Microsoft.PowerShell.Management/Get-PSDrive.md)   
 [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md)   
 [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)   
 [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)

