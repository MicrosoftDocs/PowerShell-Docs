---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821716
external help file:  Microsoft.PowerShell.Security.dll-Help.xml
title:  Protect-CmsMessage
---

# Protect-CmsMessage

## SYNOPSIS
Encrypts content by using the Cryptographic Message Syntax format.

## SYNTAX

### ByContent (Default)
```
Protect-CmsMessage [-To] <CmsMessageRecipient[]> [-Content] <PSObject> [[-OutFile] <String>]
 [<CommonParameters>]
```

### ByPath
```
Protect-CmsMessage [-To] <CmsMessageRecipient[]> [-Path] <String> [[-OutFile] <String>] [<CommonParameters>]
```

### ByLiteralPath
```
Protect-CmsMessage [-To] <CmsMessageRecipient[]> [-LiteralPath] <String> [[-OutFile] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Protect-CmsMessage** cmdlet encrypts content by using the Cryptographic Message Syntax (CMS) format.

The CMS cmdlets support encryption and decryption of content using the IETF format as documented by [RFC5652](https://tools.ietf.org/html/rfc5652).

The CMS encryption standard uses public key cryptography, where the keys used to encrypt content (the public key) and the keys used to decrypt content (the private key) are separate.
Your public key can be shared widely, and is not sensitive data.
If any content is encrypted with this public key, only your private key can decrypt it.
For more information, see [Public-key cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography).

Before you can run the **Protect-CmsMessage** cmdlet, you must have an encryption certificate set up.
To be recognized in Windows PowerShell, encryption certificates require a unique extended key usage ([EKU](https://msdn.microsoft.com/library/windows/desktop/aa381990)) ID to identify them as data encryption certificates (such as the IDs for Code Signing and Encrypted Mail).
For an example of a certificate that would work for document encryption, see Example 1 in this topic.

## EXAMPLES

### Example 1: Create a certificate for encrypting content
```
PS C:\> [Version]
Signature = "$Windows NT$"

[Strings]
szOID_ENHANCED_KEY_USAGE = "2.5.29.37"
szOID_DOCUMENT_ENCRYPTION = "1.3.6.1.4.1.311.80.1"

[NewRequest]
Subject = "cn=youralias@emailaddress.com"
MachineKeySet = false
KeyLength = 2048
KeySpec = AT_KEYEXCHANGE
HashAlgorithm = Sha1
Exportable = true
RequestType = Cert
KeyUsage = "CERT_KEY_ENCIPHERMENT_KEY_USAGE | CERT_DATA_ENCIPHERMENT_KEY_USAGE"
ValidityPeriod = "Years"
ValidityPeriodUnits = "1000"

[Extensions]
%szOID_ENHANCED_KEY_USAGE% = "{text}%szOID_DOCUMENT_ENCRYPTION%"

After you have created your certificate file, run the following command to add the certificate file to the certificate store.Now you are ready to encrypt and decrypt content with the next two examples.
PS C:\> Certreq -new DocumentEncryption.inf DocumentEncryption.cer
```

Before you can run the **Protect-CmsMessage** cmdlet, you must create an encryption certificate.
Using the following text, change the name in the Subject line to your name, email, or other identifier, and save the certificate in a file (such as DocumentEncryption.inf, as shown in this example).

### Example 2: Encrypt a message sent by email
```
PS C:\> $Protected = "Hello World" | Protect-CmsMessage -To "*youralias@emailaddress.com*"
```

In the following example, you encrypt a message, Hello World, by saving the message in a variable, and then piping it to the **Protect-CmsMessage** cmdlet.
The *To* parameter uses the value of the Subject line in the certificate.

### Example 3: View document encryption certificates
```
PS C:\> 58 [Cert:\currentuser\my]
>> Get-ChildItem -DocumentEncryptionCert
```

To view document encryption certificates in the certificate provider, you can add the *DocumentEncryptionCert* dynamic parameter of Get-ChildItemhttp://technet.microsoft.com/library/hh847761.aspx, available only when the certificate provider is loaded.

## PARAMETERS

### -Content
Specifies a PSObject that contains content that you want to encrypt.
For example, you can encrypt the content of an event message, and then use the variable containing the message ($Event, in this example) as the value of the *Content* parameter: $event = Get-WinEvent -ProviderName "PowerShell" -MaxEvents 1.
You can also use the Get-Content cmdlet to get the contents of a file, such as a Microsoft Word document, and save the content in a variable that you use as the value of the *Content* parameter.

```yaml
Type: PSObject
Parameter Sets: ByContent
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path to content that you want to encrypt.
Unlike *Path*, the value of *LiteralPath* is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: ByLiteralPath
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile
Specifies the path and file name of a file to which you want to send the encrypted content.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path to content that you want to encrypt.

```yaml
Type: String
Parameter Sets: ByPath
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -To
Specifies one or more CMS message recipients, identified in any of the following formats. 

- An actual certificate (as retrieved from the certificate provider). 
- Path to the file containing the certificate.
- Path to a directory containing the certificate.
- Thumbprint of the certificate (used to look in the certificate store).
- Subject name of the certificate (used to look in the certificate store).

```yaml
Type: CmsMessageRecipient[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

[Get-CmsMessage](Get-CmsMessage.md)

[Unprotect-CmsMessage](Unprotect-CmsMessage.md)

