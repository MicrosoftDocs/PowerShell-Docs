---
description: Information about the Certificate provider.
Locale: en-US
ms.date: 05/31/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.security/about/about_certificate_provider?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Certificate_Provider
---
# about_Certificate_Provider

## Provider name

Certificate

## Drives

`Cert:`

## Capabilities

**ShouldProcess**

## Short description

Provides access to X.509 certificate stores and certificates in PowerShell.

## Detailed description

> This information only applies to PowerShell running on Windows.

The PowerShell **Certificate** provider lets you get, add, change, clear, and
delete certificates and certificate stores in PowerShell.

The **Certificate** drive is a hierarchical namespace containing the
certificate stores and certificates on your computer.

The **Certificate** provider supports the following cmdlets.

- [Get-Location][09]
- [Set-Location][15]
- [Get-Item][07]
- [Get-ChildItem][06]
- [Invoke-Item][10]
- [Move-Item][11]
- [New-Item][12]
- [Remove-Item][13]
- [Get-ItemProperty][08]
- [Set-ItemProperty][14]
- [Clear-ItemProperty][14]
- [Get-AuthenticodeSignature][16]
- [Set-AuthenticodeSignature][18]

## Types exposed by this provider

The Certificate drive exposes the following types.

- **Microsoft.PowerShell.Commands.X509StoreLocation**, which are high-level
  containers that group the certificates for the current user and for all
  users. Each system has a `CurrentUser` and `LocalMachine` (all users) store
  location.
- **System.Security.Cryptography.X509Certificates.X509Store**, which are
  physical stores where certificates are saved and managed.
- **System.Security.Cryptography.X509Certificates.X509Certificate2**, each
  representing an X.509 certificate on the computer. Certificates are
  identified by their thumbprints.

## Navigating the Certificate drive

The **Certificate** provider exposes the certificate namespace as the `Cert:`
drive in PowerShell. This command uses the `Set-Location` command to change the
current location to the `Root` certificate store in the `LocalMachine` store
location. Use a backslash (`\`) or a forward slash (`/`) to indicate a level of
the `Cert:` drive.

```powershell
Set-Location Cert:
```

You can also work with the certificate provider from any other PowerShell
drive. To reference an alias from another location, use the `Cert:` drive name
in the path.

```powershell
PS Cert:\> Set-Location -Path LocalMachine\Root
```

To return to a file system drive, type the drive name. For example, type:

```powershell
Set-Location C:
```

> [!NOTE]
> PowerShell uses aliases to allow you a familiar way to work with provider
> paths. Commands such as `dir` and `ls` are now aliases for
> [Get-ChildItem][06], `cd` is an alias for [Set-Location][15], and `pwd` is an
> alias for [Get-Location][09].

## Displaying the Contents of the Cert: drive

This command uses the `Get-ChildItem` cmdlet to display the certificate stores
in the `CurrentUser` certificate store location.

If you aren't in the `Cert:` drive, use an absolute path.

```powershell
PS Cert:\CurrentUser\> Get-ChildItem
```

### Displaying certificate properties within the Cert: drive

This example gets a certificate with `Get-Item` and stores it in a variable.
The example shows the new certificate script properties (**DnsNameList**,
**EnhancedKeyUsageList**, **SendAsTrustedIssuer**) using `Select-Object`.

```powershell
$c = Get-Item cert:\LocalMachine\My\52A149D0393CE8A8D4AF0B172ED667A9E3A1F44E
$c | Format-List DnsNameList, EnhancedKeyUsageList, SendAsTrustedIssuer
```

```Output
DnsNameList          : {SERVER01.contoso.com}
EnhancedKeyUsageList : {WiFi-Machine (1.3.6.1.4.1.311.42.2.6),
                       Client Authentication (1.3.6.1.5.5.7.3.2)}
SendAsTrustedIssuer  : False
```

### Find all CodeSigning certificates

This command uses the **CodeSigningCert** and **Recurse** parameters of the
`Get-ChildItem` cmdlet to get all the certificates on the computer that have
code-signing authority.

```powershell
Get-ChildItem -Path cert: -CodeSigningCert -Recurse
```

### Find expired certificates

This command uses the **ExpiringInDays** parameter of the `Get-ChildItem`
cmdlet to get certificates that expire within the next 30 days.

```powershell
Get-ChildItem -Path cert:\LocalMachine\WebHosting -ExpiringInDays 30
```

### Find Server SSL Certificates

This command uses the **SSLServerAuthentication** parameter of the
`Get-ChildItem` cmdlet to get all Server SSL Certificates in the `My` and
`WebHosting` stores.

```powershell
$getChildItemSplat = @{
    Path = 'cert:\LocalMachine\My', 'cert:\LocalMachine\WebHosting'
    SSLServerAuthentication = $true
}
Get-ChildItem @getChildItemSplat
```

### Find expired certificates on remote computers

This command uses the `Invoke-Command` cmdlet to run a `Get-ChildItem` command
on the Srv01 and Srv02 computers. A value of zero (`0`) in the
**ExpiringInDays** parameter gets certificates on the Srv01 and Srv02 computers
that have expired.

```powershell
$invokeCommandSplat = @{
    ComputerName = 'Srv01', 'Srv02'
    ScriptBlock = {
        Get-ChildItem -Path cert:\* -Recurse -ExpiringInDays 0
    }
}
Invoke-Command @invokeCommandSplat
```

### Combining filters to find a specific set of certificates

This command gets all certificates in the `LocalMachine` store location that
have the following attributes:

- `fabrikam` in their DNS name
- `Client Authentication` in their EKU
- a value of `$true` for the **SendAsTrustedIssuer** property
- don't expire within the next 30 days.

The **NotAfter** property stores the certificate expiration date.

```powershell
[DateTime] $ValidThrough = (Get-Date) + (New-TimeSpan -Days 30)
$getChildItemSplat = @{
    Path = 'cert:\*'
    Recurse = $true
    DnsName = "*fabrikam*"
    Eku = "*Client Authentication*"
}
Get-ChildItem @getChildItemSplat |
    Where-Object {$_.SendAsTrustedIssuer -and $_.NotAfter -gt $ValidThrough }
```

## Opening the Certificates MMC Snap-in

The `Invoke-Item` cmdlet uses the default application to open a path you
specify. For certificates, the default application is the Certificates MMC
snap-in.

This command opens the Certificates MMC snap-in to manage the specified
certificate.

```powershell
Invoke-Item cert:\CurrentUser\my\6B8223358119BB08840DEE50FD8AF9EA776CE66B
```

## Copying Certificates

Copying certificates isn't supported by the **Certificate** provider. When you
attempt to copy a certificate, you see this error.

```powershell
$path = "Cert:\LocalMachine\Root\E2C0F6662D3C569705B4B31FE2CBF3434094B254"
PS Cert:\LocalMachine\> Copy-Item -Path $path -Destination .\CA\
```

```Output
Copy-Item : Provider operation stopped because the provider doesn't support
this operation.
At line:1 char:1
+ Copy-Item -Path $path -Destination .\CA\
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotImplemented: (:) [Copy-Item],
                              PSNotSupportedException
    + FullyQualifiedErrorId : NotSupported,
                              Microsoft.PowerShell.Commands.CopyItemCommand
```

## Moving Certificates

### Move all SSL Server authentication certs to the WebHosting store

This command uses the `Move-Item` cmdlet to move a certificate from the `My`
store to the `WebHosting` store.

`Move-Item` can't move certificate stores and it can't move certificates to a
different store location, such as moving a certificate from `LocalMachine` to
`CurrentUser`. The `Move-Item` cmdlet can move certificates within a store, but
it doesn't move private keys.

This command uses the **SSLServerAuthentication** parameter of the
`Get-ChildItem` cmdlet to get SSL server authentication certificates in the
`My` certificate store.

The returned certificates are piped to the `Move-Item` cmdlet, which moves the
certificates to the `WebHosting` store.

```powershell
Get-ChildItem cert:\LocalMachine\My -SSLServerAuthentication |
    Move-Item -Destination cert:\LocalMachine\WebHosting
```

## Deleting Certificates and Private Keys

The `Remove-Item` cmdlet deletes certificates that you specify. The
**DeleteKey** dynamic parameter deletes the private key.

### Delete a Certificate from the CA store

This command deletes a certificate from the CA certificate store, but leaves
the associated private key intact.

In the `Cert:` drive, the `Remove-Item` cmdlet supports only the **DeleteKey**,
**Path**, **WhatIf**, and **Confirm** parameters. All other parameters are
ignored.

```powershell
Remove-Item cert:\LocalMachine\CA\5DDC44652E62BF9AA1116DC41DE44AB47C87BDD0
```

### Delete a Certificate using a wildcards in the DNS name

This command deletes all certificates that have a DNS name that contains
`Fabrikam`. It uses the **DNSName** parameter of the `Get-ChildItem` cmdlet to
get the certificates and the `Remove-Item` cmdlet to delete them.

```powershell
Get-ChildItem -Path cert:\LocalMachine -DnsName *Fabrikam* | Remove-Item
```

### Delete private keys from a remote computer

This series of commands enables delegation and then deletes the certificate and
associated private key on a remote computer. To delete a private key on a
remote computer, you must use delegated credentials.

Use the `Enable-WSManCredSSP` cmdlet to enable Credential Security Service
Provider (CredSSP) authentication on a client on the S1 remote computer.
CredSSP permits delegated authentication.

```powershell
Enable-WSManCredSSP -Role Client -DelegateComputer S1
```

Use the `Connect-WSMan` cmdlet to connect the S1 computer to the WinRM service
on the local computer. When this command completes, the S1 computer appears in
the local `WSMan:` drive in PowerShell.

```powershell
Connect-WSMan -ComputerName S1 -Credential Domain01\Admin01
```

Now, you can use the `Set-Item` cmdlet in the `WSMan:` drive to enable the
CredSSP attribute for the WinRM service.

```powershell
Set-Item -Path WSMan:\S1\Service\Auth\CredSSP -Value $true
```

Start a remote session on the S1 computer using the `New-PSSession` cmdlet, and
specify CredSSP authentication. Saves the session in the `$s` variable.

```powershell
$s  = New-PSSession S1 -Authentication CredSSP -Credential Domain01\Admin01
```

Finally, use the `Invoke-Command` cmdlet to run a `Remove-Item` command in the
session in the `$s` variable. The `Remove-Item` command uses the **DeleteKey**
parameter to remove the private key along with the specified certificate.

```powershell
Invoke-Command -Session $s {
    $removeItemSplat = @{
        Path = 'cert:\LocalMachine\My\D2D38EBA60CAA1C12055A2E1C83B15AD450110C2'
        DeleteKey = $true
    }
    Remove-Item @removeItemSplat
}
```

### Delete expired Certificates

This command uses the **ExpiringInDays** parameter of the `Get-ChildItem`
cmdlet with a value of `0` to get certificates in the `WebHosting` store that
have expired.

The variable containing the returned certificates is piped to the `Remove-Item`
cmdlet, which deletes them. The command uses the **DeleteKey** parameter to
delete the private key along with the certificate.

```powershell
$expired = Get-ChildItem cert:\LocalMachine\WebHosting -ExpiringInDays 0
$expired | Remove-Item -DeleteKey
```

## Creating Certificates

The `New-Item` cmdlet doesn't create new certificates in the **Certificate**
provider. Use the [New-SelfSignedCertificate][03] cmdlet to create a
certificate for testing purposes.

## Creating Certificate Stores

In the `Cert:` drive, the `New-Item` cmdlet creates certificate stores in the
`LocalMachine` store location. It supports the **Name**, **Path**, **WhatIf**,
and **Confirm** parameters. All other parameters are ignored. The command
returns a **System.Security.Cryptography.X509Certificates.X509Store** that
represents the new certificate store.

This command creates a new certificate store named `CustomStore` in the
`LocalMachine` store location.

```powershell
New-Item -Path cert:\LocalMachine\CustomStore
```

### Create a new certificate store on a remote computer

This command creates a new certificate store named `HostingStore` in the
`LocalMachine` store location on the Server01 computer.

The command uses the `Invoke-Command` cmdlet to run a `New-Item` command on the
Server01 computer. The command returns a
**System.Security.Cryptography.X509Certificates.X509Store** that represents the
new certificate store.

```powershell
Invoke-Command -ComputerName Server01 -ScriptBlock {
    New-Item -Path cert:\LocalMachine\CustomStore
}
```

## Creating Client Certificates for WS-Man

This command creates **ClientCertificate** entry that can be used by the
**WS-Management** client. The new **ClientCertificate** shows up under the
**ClientCertificate** directory as `ClientCertificate_1234567890`. All the
parameters are mandatory. The **Issuer** needs to be thumbprint of the issuer's
certificate.

```powershell
$newItemSplat = @{
    Path = 'WSMan:\localhost\ClientCertificate'
    Credential = Get-Credential
    Issuer = '1b3fd224d66c6413fe20d21e38b304226d192dfe'
    URI = 'wmicimv2/*'
}
New-Item @newItemSplat
```

## Deleting Certificate Stores

### Delete a certificate store from a remote computer

This command uses the `Invoke-Command` cmdlet to run a `Remove-Item` command on
the S1 and S2 computers. The `Remove-Item` command includes the **Recurse**
parameter, which deletes the certificates in the store before it deletes the
store.

```powershell
Invoke-Command -ComputerName S1, S2 -ScriptBlock {
    Remove-Item -Path cert:\LocalMachine\TestStore -Recurse
}
```

## Dynamic parameters

Dynamic parameters are cmdlet parameters that are added by a PowerShell
provider and are available only when the cmdlet is being used in the
provider-enabled drive. These parameters are valid in all subdirectories of the
**Certificate** provider, but are effective only on certificates.

> [!NOTE]
> Parameters that perform filtering against the **EnhancedKeyUsageList**
> property also return items with an empty **EnhancedKeyUsageList** property
> value. Certificates that have an empty **EnhancedKeyUsageList** can be used
> for all purposes.

The following Certificate provider parameters were reintroduced in PowerShell
7.1.

- **DNSName**
- **DocumentEncryptionCert**
- **EKU**
- **ExpiringInDays**
- **SSLServerAuthentication**

### CodeSigningCert <System.Management.Automation.SwitchParameter>

#### Cmdlets supported

- [Get-Item][07]
- [Get-ChildItem][06]

This parameter gets certificates that have `Code Signing` in their
**EnhancedKeyUsageList** property value.

### DeleteKey <System.Management.Automation.SwitchParameter>

#### Cmdlets supported

- [Remove-Item][13]

This parameter deletes the associated private key when it deletes the
certificate.

> [!IMPORTANT]
> To delete a private key that's associated with a user certificate in the
> `Cert:\CurrentUser` store on a remote computer, you must use delegated
> credentials. The `Invoke-Command` cmdlet supports credential delegation using
> the **CredSSP** parameter. You should consider any security risks before
> using `Remove-Item` with `Invoke-Command` and credential delegation.

This parameter was reintroduced in PowerShell 7.1

### DnsName <Microsoft.PowerShell.Commands.DnsNameRepresentation>

#### Cmdlets supported

- [Get-ChildItem][06]

This parameter gets certificates that have the specified domain name or name
pattern in the **DNSNameList** property of the certificate. The value of this
parameter can either be `Unicode` or `ASCII`. Punycode values are converted to
Unicode. Wildcard characters (`*`) are permitted.

This parameter was reintroduced in PowerShell 7.1

### DocumentEncryptionCert <System.Management.Automation.SwitchParameter>

#### Cmdlets supported

- [Get-Item][07]
- [Get-ChildItem][06]

This parameter gets certificates that have `Document Encryption` in their
**EnhancedKeyUsageList** property value.

### EKU <System.String>

#### Cmdlets supported

- [Get-ChildItem][06]

This parameter gets certificates that have the specified text or text pattern
in the **EnhancedKeyUsageList** property of the certificate. Wildcard
characters (`*`) are permitted. The **EnhancedKeyUsageList** property contains
the friendly name and the OID fields of the EKU.

This parameter was reintroduced in PowerShell 7.1

### ExpiringInDays <System.Int32>

#### Cmdlets supported

- [Get-ChildItem][06]

This parameter gets certificates that are expiring in or before the specified
number of days. A value of zero (0) gets certificates that have expired.

This parameter was reintroduced in PowerShell 7.1

### ItemType <System.String>

This parameter is used to specify the type of item created by `New-Item`. The
`New-Item` cmdlet only supports the value `Store`. `New-Item` cmdlet can't
create new certificates.

#### Cmdlets Supported

- [New-Item][12]

### SSLServerAuthentication <System.Management.Automation.SwitchParameter>

#### Cmdlets supported

- [Get-ChildItem][06]

Gets only server certificates for SSL web hosting. This parameter gets
certificates that have `Server Authentication` in their
**EnhancedKeyUsageList** property value.

This parameter was reintroduced in PowerShell 7.1

## Script properties

New script properties have been added to the **x509Certificate2** object that
represents the certificates to make it easy to search and manage the
certificates.

- **DnsNameList**: To populate the **DnsNameList** property, the Certificate
  provider copies the content from the DNSName entry in the
  SubjectAlternativeName (SAN) extension. If the SAN extension is empty, the
  property is populated with content from the Subject field of the certificate.
- **EnhancedKeyUsageList**: To populate the **EnhancedKeyUsageList** property,
  the Certificate provider copies the OID properties of the EnhancedKeyUsage
  (EKU) field in the certificate and creates a friendly name for it.
- **SendAsTrustedIssuer**: To populate the **SendAsTrustedIssuer** property,
  the Certificate provider copies the **SendAsTrustedIssuer** property from the
  certificate. For more information see
  [Management of trusted issuers for client authentication][04].

These new features let you search for certificates based on their DNS names and
expiration dates, and distinguish client and server authentication certificates
by the value of their Enhanced Key Usage (EKU) properties.

## Using the pipeline

Provider cmdlets accept pipeline input. You can use the pipeline to simplify
tasks by sending provider data from one cmdlet to another provider cmdlet. To
read more about how to use the pipeline with provider cmdlets, see the cmdlet
references provided throughout this article.

## Getting help

Beginning in PowerShell 3.0, you can get customized help topics for provider
cmdlets that explain how those cmdlets behave in a file system drive.

To get the help topics that are customized for the file system drive, run a
[Get-Help][05] command in a file system drive or use the `-Path` parameter of
`Get-Help` to specify a file system drive.

```powershell
Get-Help Get-ChildItem
```

```powershell
Get-Help Get-ChildItem -Path cert:
```

## See also

- [about_Providers][01]
- [about_Signing][02]
- [Get-AuthenticodeSignature][16]
- [Set-AuthenticodeSignature][18]
- [Get-PfxCertificate][17]

<!-- link references -->
[01]: ../../Microsoft.PowerShell.Core/About/about_Providers.md
[02]: ../../Microsoft.PowerShell.Core/About/about_Signing.md
[03]: /powershell/module/pki/new-selfsignedcertificate
[04]: /windows-server/security/tls/what-s-new-in-tls-ssl-schannel-ssp-overview#BKMK_TrustedIssuers
[05]: xref:Microsoft.PowerShell.Core.Get-Help
[06]: xref:Microsoft.PowerShell.Management.Get-ChildItem
[07]: xref:Microsoft.PowerShell.Management.Get-Item
[08]: xref:Microsoft.PowerShell.Management.Get-ItemProperty
[09]: xref:Microsoft.PowerShell.Management.Get-Location
[10]: xref:Microsoft.PowerShell.Management.Invoke-Item
[11]: xref:Microsoft.PowerShell.Management.Move-Item
[12]: xref:Microsoft.PowerShell.Management.New-Item
[13]: xref:Microsoft.PowerShell.Management.Remove-Item
[14]: xref:Microsoft.PowerShell.Management.Set-ItemProperty
[15]: xref:Microsoft.PowerShell.Management.Set-Location
[16]: xref:Microsoft.PowerShell.Security.Get-AuthenticodeSignature
[17]: xref:Microsoft.PowerShell.Security.Get-PfxCertificate
[18]: xref:Microsoft.PowerShell.Security.Set-AuthenticodeSignature
