﻿---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Certificate Provider
online version:  http://go.microsoft.com/fwlink/?LinkId=834968
---
# Certificate Provider

## Provider name

Certificate

## Drives

Cert:

## Short description

Provides access to X.509 certificate stores and certificates in PowerShell.

## Detailed description

The PowerShell Certificate provider lets you navigate the certificate namespace and view the certificate stores and certificates. It also lets you open the Certificates snap-in for the Microsoft Management Console (MMC).

> [!NOTE]
> Beginning in Windows PowerShell 3.0, the Microsoft.PowerShell.Security module that contains the [Certificate Provider](Certificate-Provider.md) is not imported automatically into every session. To use the Cert: > drive, use the [Import-Module](../../Microsoft.PowerShell.Core/Import-Module.md) cmdlet to import the module, or run a command that uses the Cert: drive, such as a `Set-Location Cert:` command.

Beginning in Windows PowerShell 3.0, the Certificate provider enhances its support for managing Secure Socket Layer (SSL) certificates for web hosting by adding support for cmdlets and new dynamic parameters that create and delete certificate stores in the LocalMachine certificate store location, and find, move, and delete certificates.

New dynamic parameters, `DnsName`, `EKU`, `SSLServerAuthentication`, and `ExpiringInDays` have been added to the [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet in the Cert: drive. Also, a `DeleteKey` dynamic parameter has been added to [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md) in the Cert: drive. The new dynamic parameters are available in the Windows PowerShell 3.0 and newer Windows PowerShell releases, and work with IIS 8.0, available on Windows Server 2012 and later releases of the Windows Server operating system.

New script properties, `DnsNameList`, `EnhancedKeyUsageList`, and `SendAsTrustedIssuer`, have been added to the x509Certificate2 object that represents the certificates to make it easy to search and manage the certificates.

These new features let you search for certificates based on their DNS names and expiration dates, and distinguish client and server authentication certificates by the value of their Enhanced Key Usage (EKU) properties.

These enhancements are designed to support the WebHosting certificate store created by IIS. This certificate store is optimized to scale for efficient, automated management of the thousands of certificates that are required for dynamic shared hosting. The WebHosting certificate store is available starting in IIS 8.0, available with Web Server (IIS) on Windows Server 2012 and later releases of the Windows Server operating system.

To populate the `DnsNameList` property, the Certificate provider copies the content from the DNSName entry in the SubjectAlternativeName (SAN) extension. If the SAN extension is empty, the property is populated with content from the Subject field of the certificate.

To populate the `EnhancedKeyUsageList` property, the Certificate provider copies the OID properties of the EnhancedKeyUsage (EKU) field in the certificate and creates a friendly name for it..

The Certificate provider exposes the certificate namespace as the Cert: drive in PowerShell. The Cert: drive has the following three levels:

- Store locations (Microsoft.PowerShell.Commands.X509StoreLocation), which are high-level containers that group the certificates for the current user and for all users. Each system has a CurrentUser and LocalMachine (all users) store location.

- Certificates stores (System.Security.Cryptography.X509Certificates.X509Store), which are physical stores in which certificates are saved and managed.

- X.509 certificates (System.Security.Cryptography.X509Certificates.X509Certificate2), each of which represent an X.509 certificate on the computer. Certificates are identified by their thumbprints.

In Windows PowerShell 3.0, the Certificate provider supports the [Get-Location](../../Microsoft.PowerShell.Management/Get-Location.md), [Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md), [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md), [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md), [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md), [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md), [New-Item](../../Microsoft.PowerShell.Management/New-Item.md), and [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md) cmdlets.

In Windows PowerShell 2.0, the Certificate provider supports the [Get-Location](../../Microsoft.PowerShell.Management/Get-Location.md), [Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md), [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md), [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md), and [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md) cmdlets.

In addition, PowerShell Security module (Microsoft.PowerShell.Security), which includes the Certificate provider, also includes cmdlets to get and set Authenticode signatures and to get certificates. For a list of cmdlets in the Security module, type `Get-Command  -Module *security`.

## CAPABILITIES

ShouldProcess

## EXAMPLES

### Navigating the Cert: Drive

#### Example 1: Navigating to the root of the Cert: Drive

This command uses the `Set-Location` command to change the current location to the Root certificate store in the LocalMachine store location. Use a backslash (\\) or a forward slash (/) to indicate a level of the Cert: drive.

```powershell
Set-Location -Path LocalMachine\Root

```

If you are not in the Cert: drive, begin the path with the drive name.

### Displaying the contents of the cert: drive

#### Example 1: Displaying the Contents of the cert: drive

This command uses the `Get-ChildItem` cmdlet to display the certificate stores in the CurrentUser certificate store location.

```powershell
Get-ChildItem -Path cert:\CurrentUser

```

If you are in the Cert: drive, you can omit the drive name.

### Example 2: Displaying certificate properties within the cert: drive

This command gets a certificate and displays all of its properties. It uses the `Get-ChildItem` cmdlet to get the certificate and the Property parameter of `Format-List` with a wildcard character (*) to display all of the properties of the certificate.

The certificate is identified by its thumbprint.

```powershell
Get-ChildItem -Path cert:\LocalMachine\my\6B8223358119BB08840DEE50FD8AF9EA776CE66B | Format-List -Property *

```

#### Example 3: Use the Recurse parameter with Format-Table to view all certificate properties

This command displays the web hosting properties of all certificates in the LocalMachine certificate store location.

It uses the Recurse parameter of the `Get-ChildItem` cmdlet to get all certificates in all stores of the LocalMachine store location. A pipeline operator sends the certificates to the `Format-Table` command, which displays the selected properties of each certificate in a table.

```powershell
Get-ChildItem -Path cert:\LocalMachine -Recurse | Format-Table -Property DnsNameList, EnhancedKeyUsageList, NotAfter, SendAsTrustedIssuer

```

### Opening the certificates MMC snap-in

#### Example 1: Opening the Certificates MMC Snap-in

This command opens the Certificates MMC snap-in to manage the specified certificate.

```powershell
Invoke-Item cert:\CurrentUser\my\6B8223358119BB08840DEE50FD8AF9EA776CE66B

```

### Getting Selected certificates

#### Example 1: Find all CodeSigning certificates using the CodeSigning cert parameter

This command uses the CodeSigningCert and Recurse parameters of the `Get-ChildItem` cmdlet to get all of the certificates on the computer that have code-signing authority.

```powershell
Get-ChildItem -Path cert: -CodeSigningCert -Recurse

```

#### Example 2: Find expired certificates

This command uses the ExpiringInDays parameter of the `Get-ChildItem` cmdlet to get certificates that will expire within the next 30 days.

```powershell
Get-ChildItem -Path cert:\LocalMachine\WebHosting -ExpiringInDays 30

```

#### Example 3: Find Server SSL Certificates using the SSLServerAuthentication parameter

This command uses the SSLServerAuthentication parameter of the `Get-ChildItem` cmdlet to get all

Server SSL Certificates in the My and WebHosting stores.

```powershell
Get-ChildItem -Path cert:\LocalMachine\My, cert:\LocalMachine\WebHosting -SSLServerAuthentication

```

#### Example 4: Find expired certificates on remote computers

This command uses the `Invoke-Command` cmdlet to run a `Get-ChildItem` command on the Srv01 and Srv02 computers. A value of zero (0) in the ExpiringInDays parameter gets certificates on the Srv01 and Srv02 computers that have expired.

```powershell
Invoke-Command -ComputerName Srv01, Srv02 {Get-ChildItem -Path cert:\* -Recurse -ExpiringInDays 0}

```

#### Example 5: Combining filters to find a specific set of certificates

This command gets all certificates in the LocalMachine store location that have "fabrikam" in their DNS name, "Client Authentication" in their EKU, a value of `$true` for the SendAsTrustedIssuer property, and do not expire within the next 30 days.

```powershell
Get-ChildItem -Path cert:\* -Recurse  -DNSName "*fabrikam*" -EKU "*Client Authentication*" | Where-Object {$_.SendAsTrustedIssuer -and $_.NotAfter -gt (get-date).AddDays.(30)}

```

The NotAfter property stores the certificate expiration date.

### Moving certificates

#### Example 1: Move all SSL Server authentication certs to the WebHosting store

This command uses the `Move-Item` cmdlet to move a certificate from the My store to the WebHosting store.

`Move-Item` will not move certificate stores and it will not move certificates to a different store location, such as moving a certificate from LocalMachine to CurrentUser. Also, `Move-Item` moves certificates, but it does not move private keys.

```powershell
Move-Item -Path cert:\LocalMachine\My\5DDC44652E62BF9AA1116DC41DE44AB47C87BDD0 -Destination cert:\LocalMachine\WebHosting

```

### Deleting certificates and private Keys

#### Example 1: Delete a certificate from the CA store

This command uses the SSLServerAuthentication parameter of the `Get-ChildItem` cmdlet to get SSL server authentication certificates in the MY certificate store.

It uses a pipeline operator to send the certificates to the `Move-Item` cmdlet, which moves the certificates to the WebHosting store.

```powershell
Get-ChildItem -Path cert:\LocalMachine\My -SSLServerAuthentication | Move-Item -Destination cert:\LocalMachine\WebHosting

```

#### Example 2: Delete a certificate from a remote computer

This command deletes a certificate from the CA certificate store, but leaves the associated private key intact.

In the Cert: drive, the `Remove-Item` cmdlet supports only the DeleteKey, Path, WhatIf, and Confirm parameters. All other parameters are ignored.

```powershell
Remove-Item -Path cert:\LocalMachine\CA\5DDC44652E62BF9AA1116DC41DE44AB47C87BDD0

```

#### Example 3: Delete private keys from a remote computer using credential delegation

This series of commands enables delegation and then deletes the certificate and associated private key on a remote computer. To delete a private key on a remote computer, you must use delegated credentials.

```powershell
# Use the Enagle-WSManCredSSP cmdlet to enable Credential Security Service Provider (CredSSP) authentication on a client on the S1 remote computer.
# CredSSP permits delegated authentication.
Enable-WSManCredSSP -Role Client -DelegateComputer S1
# Use the Connect-WSMan cmdlet to connect the S1 computer to the WinRM service on the local computer.
# When this command completes, the S1 computer appears in the local WSMan: drive in PowerShell.
Connect-WSMan -ComputerName S1 -Credential Domain01\Admin01
# Now, you can use the Set-Item cmdlet in the WSMan: drive to enable the CredSSP attribute for the WinRM service.
Set-Item -Path WSMan:\S1\Service\Auth\CredSSP -Value $true
# Start a remote session on the s1 computer using the New-PSSession cmdlet, and specify CredSSP authentication.
# Saves the session in the $s variable.
$s  = New-PSSession S1 -Authentication CredSSP -Credential Domain01\Admin01
# Finally, use the Invoke-Command cmdlet to run a Remove-Item command in the session in the $s variable.
# The Remove-Item command uses the DeleteKey parameter to remove the private key along with the specified certificate.
Invoke-Command -Session $s { Remove-Item cert:\LocalMachine\My\D2D38EBA60CAA1C12055A2E1C83B15AD450110C2 -DeleteKey  }
```

#### Example 4: Delete certs using wildcards in a DNS name

This command uses the ExpiringInDays parameter of the `Get-ChildItem` cmdlet with a value of 0 to get certificates in the WebHosting store that have expired.

It uses a pipeline operator to pass the certificates to the `Remove-Item` cmdlet, which deletes them. The command uses the DeleteKey parameter to delete the private key along with the certificate.

```powershell
Get-ChildItem -Path cert:\LocalMachine\WebHosting -ExpiringInDays 0 | Remove-Item -DeleteKey

```

### Creating certificate stores

#### Example 1: Create a new certificate store

This command creates a new certificate store named "CustomStore" in the LocalMachine store location.

In the Cert: drive, the `New-Item` cmdlet creates certificate stores in the LocalMachine store location. It supports the Name, Path, WhatIf, and Confirm parameters. All other parameters are ignored.

```powershell
New-Item -Path cert:\LocalMachine\CustomStore

```

The command returns a System.Security.Cryptography.X509Certificates.X509Store that represents the new certificate store.

#### Example 2: Create a new certificate store on a remote computer

This command creates a new certificate store named "HostingStore" in the LocalMachine store location on the Server01 computer.

The command uses the `Invoke-Command` cmdlet to run a `New-Item` command on the Server01 computer.

```powershell
Invoke-Command -ComputerName Server01 { New-Item -Path cert:\LocalMachine\CustomStore }

```

The command returns a System.Security.Cryptography.X509Certificates.X509Store that represents the new certificate store.

### Deleting certificate stores

#### Example 1: Delete a certificate store and all contained certificates, from a remote computer

This command uses the `Invoke-Command` cmdlet to run a `Remove-Item` command on the S1 and S2 computers. The `Remove-Item` command includes the Recurse parameter, which deletes the certificates in the store before it deletes the store.

```powershell
Invoke-Command -ComputerName S1, S2 { Remove-Item -Path cert:\LocalMachine\TestStore  -Recurse}

```

## Dynamic parameters

Dynamic parameters are cmdlet parameters that are added by a PowerShell provider and are available only when the cmdlet is being used in the provider-enabled drive.

### CodeSigningCert <System.Management.Automation.SwitchParameter>

Gets only those certificates with code-signing authority.

This parameter gets certificates that have "Code Signing" in their EnhancedKeyUsageList property value. Because certificates that have an empty EnhancedKeyUsageList can be used for all purposes, searches for code signing certificates also return certificates that have an empty `EnhancedKeyUsageList` property value.

This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.

#### Cmdlets supported

- [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### DnsName <Microsoft.PowerShell.Commands.DnsNameRepresentation>

Gets certificates that have the specified domain name or name pattern in the `DNSNameList` property of the certificate.

The value of this parameter can either be Unicode or ASCII. Punycode values are converted to Unicode. Wildcard characters (*) are permitted. This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.

This parameter was introduced in Windows PowerShell 3.0.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### EKU <System.String>

Gets certificates that have the specified text or text pattern in the `EnhancedKeyUsageList` property of the certificate. Wildcard characters (*) are permitted. The `EnhancedKeyUsageList` property contains the friendly name and the OID fields of the EKU.

Because certificates that have an empty EnhancedKeyUsageList can be used for all purposes, all EKU searches return certificates that have an empty `EnhancedKeyUsageList` property value. This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.

This parameter was introduced in Windows PowerShell 3.0.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### ExpiringInDays <System.Int32>

Gets certificates that are expiring in or before the specified number of days. Enter an integer. A value of 0 (zero) gets certificates that have expired. This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.

This parameter was introduced in Windows PowerShell 3.0.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### SSLServerAuthentication <System.Management.Automation.SwitchParameter>

Gets only server certificates for SSL web hosting. This parameter gets certificates that have "Server Authentication" in their `EnhancedKeyUsageList` property value. Because certificates that have an empty EnhancedKeyUsageList can be used for all purposes, SSLServerAuthentication searches also return certificates that have an empty `EnhancedKeyUsageList` property value.

This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.

This parameter was introduced in Windows PowerShell 3.0.

#### Cmdlets supported

- [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)

### DeleteKey <System.Management.Automation.SwitchParameter>

Deletes the associated private key when it deletes the certificate.

To delete a private key that is associated with a user certificate in the Cert:\CurrentUser store on a remote computer, you must use delegated credentials. When using the [Invoke-Command](../../Microsoft.PowerShell.Core/Invoke-Command.md) cmdlet to run a [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md) command remotely, after considering the security risks, use the CredSSP parameter to enable delegation.

This parameter is valid in all subdirectories of the Certificate provider, but it is effective only on certificates.

This parameter was introduced in Windows PowerShell 3.0.

#### Cmdlets supported

- [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)

## See also

[about_Providers](../../Microsoft.PowerShell.Core/About/about_Providers.md)

[about_Signing](../../Microsoft.PowerShell.Core/About/about_Signing.md)

[Get-AuthenticodeSignature](../Get-AuthenticodeSignature.md)

[Set-AuthenticodeSignature](../Set-AuthenticodeSignature.md)

[Get-PfxCertificate](../Get-PfxCertificate.md)