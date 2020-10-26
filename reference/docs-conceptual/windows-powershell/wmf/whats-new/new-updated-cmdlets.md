---
ms.date:  06/12/2017
title: New and updated cmdlets
description: Windows PowerShell 5.1 includes many new or updated cmdlets.
---
# New and updated cmdlets

We have added new and updated existing cmdlets based on feedback from the community.

## Archive cmdlets

Two new cmdlets, `Compress-Archive` and `Expand-Archive`, let you compress and expand ZIP files.

For more information, see the
[Microsoft.Powershell.Archive](/powershell/module/microsoft.powershell.archive/) module
documentation.

## Catalog Cmdlets

Two new cmdlets have been added in the Microsoft.PowerShell.Security module.

- [New-FileCatalog](/powershell/module/microsoft.powershell.security/New-FileCatalog)
- [Test-FileCatalog](/powershell/module/microsoft.powershell.security/Test-FileCatalog)

These generate and validate Windows catalog files.

## Clipboard cmdlets

`Get-Clipboard` and `Set-Clipboard` make it easier for you to transfer content to and from a
Windows PowerShell session. The Clipboard cmdlets support images, audio files, file lists, and text.

For more information, see:

- [Get-Clipboard](/powershell/module/Microsoft.PowerShell.Management/Get-Clipboard)
- [Set-Clipboard](/powershell/module/Microsoft.PowerShell.Management/Set-Clipboard)

## Cryptographic Message Syntax (CMS) cmdlets

The Cryptographic Message Syntax cmdlets support encryption and decryption of content using the IETF
standard format for cryptographically protecting messages as documented by
[RFC5652](https://tools.ietf.org/html/rfc5652.html).

The CMS encryption standard implements public key cryptography, where the key used to encrypt
content (the *public key*) and the key used to decrypt content (the *private key*) are separate.

Your public key can be shared widely and is not sensitive data. Any content encrypted with the
public key can only be decrypted using the private key. For more information, see
[Public-key cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography).

For more information see:

- [Get-CmsMessage](/powershell/module/Microsoft.PowerShell.Security/Get-CmsMessage)
- [Protect-CmsMessage](/powershell/module/Microsoft.PowerShell.Security/Protect-CmsMessage)
- [Unprotect-CmsMessage](/powershell/module/Microsoft.PowerShell.Security/unprotect-CmsMessage)

Certificates require a unique key usage identifier (EKU), such as 'Code Signing' or 'Encrypted
Mail', to identify them as data encryption certificates in PowerShell. To view document encryption
certificates in the certificate provider, you can use the **DocumentEncryptionCert** dynamic
parameter of `Get-ChildItem`:

```powershell
Get-ChildItem Cert:\CurrentUser -DocumentEncryptionCert -Recurse
```

## Extract and parse structured objects from string content

### ConvertFrom-String

The new `ConvertFrom-String` cmdlet supports two modes:

- Basic delimited parsing
- Auto generated example-driven parsing

Delimited parsing, by default, splits the input at white space, and assigns property names to the
resulting groups.

The **UpdateTemplate** parameter saves the results of the learning algorithm into a comment in the
template file. This makes the learning process (the slowest stage) a one-time cost. Running
`ConvertFrom-String` with a template that contains the encoded learning algorithm is now nearly
instantaneous.

For more information, see [ConvertFrom-String](/powershell/module/Microsoft.PowerShell.Utility/ConvertFrom-String).

### Convert-String

`Convert-String` allows you to provide before and after examples of how you want text to look. The
cmdlet formats your text automatically.

For more information, see [Convert-String](/powershell/module/Microsoft.PowerShell.Utility/Convert-String).

## Updates to FileInfo object

File version information can be misleading, especially in cases where the file was patched. WMF 5.0
adds new **FileVersionRaw** and **ProductVersionRaw** script properties to **FileInfo** objects.
Here are the properties as displayed for powershell.exe (assuming $pid is the ID of the PowerShell
process):

```powershell
Get-Process -Id $pid -FileVersionInfo | Format-List *version*
```

```Output
FileVersionRaw    : 10.0.17763.1
ProductVersionRaw : 10.0.17763.1
FileVersion       : 10.0.17763.1 (WinBuild.160101.0800)
ProductVersion    : 10.0.17763.1
```

## Format-Hex

`Format-Hex` lets you view text or binary data in hexadecimal format.

For more information, see [Format-Hex](/powershell/module/microsoft.powershell.utility/format-hex).

## Get-ChildItem has -Depth parameter

`Get-ChildItem` now has a **Depth** parameter for use with **Recurse** to limit the recursion:

## Modules support for declaring version ranges (1.*, etc)

You can now combine **MinimumVersion** and **MaximumVersion** to import module
within specific range. The parameters also support wildcards.

```powershell
Import-Module psreadline -Verbose -MinimumVersion 1.0 -MaximumVersion 1.2.*
```

```Output
VERBOSE: Loading module from path 'C:\Program Files\WindowsPowerShell\Modules\psreadline\1.1\psreadline.psd1'.
VERBOSE: Importing cmdlet 'Get-PSReadlineKeyHandler'.
VERBOSE: Importing cmdlet 'Get-PSReadlineOption'.
VERBOSE: Importing cmdlet 'Remove-PSReadlineKeyHandler'.
VERBOSE: Importing cmdlet 'Set-PSReadlineKeyHandler'.
VERBOSE: Importing cmdlet 'Set-PSReadlineOption'.
VERBOSE: Importing function 'PSConsoleHostReadline'.
```

## New-Guid

There are many scenarios where youneed for unique identifier. The `New-GUID` cmdlet provides a
simple way to create a new GUID.

```powershell
New-Guid
```

```Output
Guid
----
e19d6ea5-3cc2-4db9-8095-0cdaed5a703d
```

## NoNewLine parameter

`Out-File`, `Add-Content`, and `Set-Content` now have a new **NoNewline** switch which omits a new
line after the output. For example:

```powershell
"This is " | Out-File -FilePath Example.txt -NoNewline
"a single " | Add-Content -Path Example.txt -NoNewline
"sentence." | Add-Content -Path Example.txt -NoNewline
Get-Content .\Example.txt
```

```Output
This is a single sentence.
```

Without **NoNewline** specified, each fragment would be on a separate line:

```powershell
"This is " | Out-File -FilePath Example.txt
"a single " | Add-Content -Path Example.txt
"sentence." | Add-Content -Path Example.txt
Get-Content .\Example.txt
```

```Output
This is
a single
sentence.
```

## Interact with Symbolic links using improved Item cmdlets

The Item cmdlet and a few related cmdlets have been extended to support symbolic links.

### Symbolic link files

In this example, we create a new symbolic link file named MySymLinkFile.txt in C:\Temp which links
to $pshome\profile.ps1. All three examples produce the same result.

```powershell
New-Item -ItemType SymbolicLink -Path C:\Temp -Name MySymLinkFile.txt -Value $pshome\profile.ps1
New-Item -ItemType SymbolicLink -Path C:\Temp\MySymLinkFile.txt -Value $pshome\profile.ps1
New-Item -ItemType SymbolicLink -Name C:\Temp\MySymLinkFile.txt -Value $pshome\profile.ps1
```

### Symbolic link directories

In this example, we create a new symbolic link directory named MySymLinkDir in C:\Temp which links
to the $pshome folder. All three examples produce the same result.

```powershell
New-Item -ItemType SymbolicLink -Path C:\Temp -Name MySymLinkDir -Value $pshome
New-Item -ItemType SymbolicLink -Path C:\Temp\MySymLinkDir -Value $pshome
New-Item -ItemType SymbolicLink -Name C:\Temp\MySymLinkDir -Value $pshome
```

### Hard links

The same combinations of **Path** and **Name** allowed as described above.

```powershell
New-Item -ItemType HardLink -Path C:\Temp -Name MyHardLinkFile.txt -Value $pshome\profile.ps1
```

### Directory junctions

The same combinations of **Path** and **Name** allowed as described above.

```powershell
New-Item -ItemType Junction -Path C:\Temp\MyJunctionDir -Value $pshome
```

### Get-ChildItem

`Get-ChildItem` now displays an 'l' in the **Mode** property to indicate a symbolic link file or
directory.

```powershell
Get-ChildItem C:\Temp | sort LastWriteTime -Descending

Directory: C:\Temp

Mode       LastWriteTime Length Name
----       ------------- ------ ----
-a---- 6/13/2014 3:00 PM     16 File.txt
d----- 6/13/2014 3:00 PM        Directory
-a---l 6/13/2014 3:21 PM      0 MySymLinkFile.txt
d----l 6/13/2014 3:22 PM        MySymLinkDir
-a---l 6/13/2014 3:23 PM  23304 MyHardLinkFile.txt
d----l 6/13/2014 3:24 PM        MyJunctionDir
```

### Remove-Item

Removing symbolic links works like removing any other item type.

```powershell
Remove-Item C:\Temp\MySymLinkFile.txt
Remove-Item C:\Temp\MySymLinkDir
```

Use the **Force** parameter to remove the files in the target directory and the symbolic link.

```powershell
Remove-Item C:\Temp\MySymLinkDir -Force
```

## New-TemporaryFile

Sometimes in your scripts, you must create a temporary file. You can now do this with the
`New-TemporaryFile` cmdlet:

```powershell
$tempFile = New-TemporaryFile
$tempFile.FullName
```

```Output
C:\Users\user1\AppData\Local\Temp\tmp375.tmp
```

## Network Switch Management with PowerShell

The Network Switch cmdlets, introduced in WMF 5.0, enable you to apply switch, virtual LAN (VLAN),
and basic Layer 2 network switch port configuration to Windows Server 2012 R2 logo-certified network
switches. Using these cmdlets you can perform:

- Global switch configuration, such as:
  - Set host name
  - Set switch banner
  - Persist configuration
  - Enable or disable feature

- VLAN configuration:
  - Create or remove VLAN
  - Enable or disable VLAN
  - Enumerate VLAN
  - Set friendly name to a VLAN

- Layer 2 port configuration:
  - Enumerate ports
  - Enable or disable ports
  - Set port modes and properties
  - Add or associate VLAN to Trunk or Access on the port

For more information, see the [NetworkSwitchManager](/powershell/module/networkswitchmanager/)
documentation.

## Generate PowerShell cmdlets based on an OData endpoint with ODataUtils

The ODataUtils module allows generation of PowerShell cmdlets from REST endpoints that support
OData. The Microsoft.PowerShell.ODataUtils module includes the following features:

- Channel additional information from server-side endpoint to client side.
- Client-side paging support
- Server-side filtering by using the -Select parameter
- Support for web request headers

The proxy cmdlets generated by the `Export-ODataEndPointProxy` cmdlet provide additional information
from the server-side OData endpoint on the **Information** stream.

```powershell
Import-Module Microsoft.PowerShell.ODataUtils -Force
$generatedProxyModuleDir = Join-Path -Path $env:SystemDrive -ChildPath 'ODataDemoProxy'
$uri = "http://services.odata.org/V3/(S(fhleiief23wrm5a5nhf542q5))/OData/OData.svc/"
Export-ODataEndpointProxy -Uri $uri -OutputModule $generatedProxyModuleDir -Force -AllowUnSecureConnection -Verbose -AllowClobber
```

In the following example, we are retrieving top product and capturing the output in the
`$infoStream` variable.

By specifying **IncludeTotalResponseCount** parameter, we get the total count of all the **Product**
records available on the server.

```powershell
Import-Module $generatedProxyModuleDir -Force
$product = Get-Product -Top 1 -AllowUnsecureConnection -AllowAdditionalData -IncludeTotalResponseCount -InformationVariable infoStream
$additionalInfo = $infoStream.GetEnumerator() | % MessageData
$additionalInfo['odata.count']
```

You can get the records from the server in batches using client-side paging support. This is useful
when you must get a large amount of data from the server over the network.

```powershell
$skipCount = 0
$batchSize = 3
while($skipCount -le $additionalInfo['odata.count'])
{
  Get-Product -AllowUnsecureConnection -AllowAdditionalData -Top $batchSize -Skip $skipCount
  $skipCount += $batchSize
}
```

The generated proxy cmdlets support the **Select** parameter that is used as a filter to receive
only the record properties that the client needs. The filtering occurs on the server, which reduces
the amount of data that is transferred over the network.

```powershell
Get-Product -Top 2 -AllowUnsecureConnection -AllowAdditionalData -Select Name
```

The `Export-ODataEndpointProxy` cmdlet, and the proxy cmdlets generated by it, now support the
**Headers** parameter. The header can be used to channel additional information expected by the
OData endpoint.

In the following example, a hash table containing a Subscription key is provided to the **Headers**
parameter. This is a typical example for services that are expecting a Subscription key for
authentication.

```powershell
Export-ODataEndpointProxy -Uri $endPointUri -OutputModule $generatedProxyModuleDir -Force -AllowUnSecureConnection -Verbose -Headers @{'subscription-key'='XXXX'}
```
