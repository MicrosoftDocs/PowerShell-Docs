---
external help file: Microsoft.PowerShell.Security.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkId=394374
schema: 2.0.0
---

# Unprotect-CmsMessage
## SYNOPSIS
Decrypts content that has been encrypted by using the Cryptographic Message Syntax format.

## SYNTAX

### ByWinEvent (Default)
```
Unprotect-CmsMessage [-EventLogRecord] <PSObject> [-IncludeContext] [[-To] <CmsMessageRecipient[]>]
```

### ByContent
```
Unprotect-CmsMessage [-Content] <String> [-IncludeContext] [[-To] <CmsMessageRecipient[]>]
```

### ByPath
```
Unprotect-CmsMessage [-Path] <String> [-IncludeContext] [[-To] <CmsMessageRecipient[]>]
```

### ByLiteralPath
```
Unprotect-CmsMessage [-LiteralPath] <String> [-IncludeContext] [[-To] <CmsMessageRecipient[]>]
```

## DESCRIPTION
The Cryptographic Message Syntax cmdlets support encryption and decryption of content using the IETF standard format for cryptographically protecting messages, as documented by RFC5652.

The CMS encryption standard uses public key cryptography, where the keys used to encrypt content (the public key) and the keys used to decrypt content (the private key) are separate.
Your public key can be shared widely, and is not sensitive data.
If any content is encrypted with this public key, only your private key can decrypt it.
For more information about Public Key Cryptography, see http://en.wikipedia.org/wiki/Public-key_cryptography.

Unprotect-CmsMessage decrypts content that has been encrypted in CMS format.
You can run this cmdlet to decrypt content that you have encrypted by running the Protect-CmsMessage cmdlet.
You can specify content that you want to decrypt as a string, by the encryption event log record ID number, or by path to the encrypted content.
The Unprotect-CmsMessage cmdlet returns the decrypted content.

## EXAMPLES

### Example 1: Decrypt a message
```
PS C:\>C:\Users\gabyk\Documents\PowerShell_ISEUnprotect-CmsMessage -LiteralPath 'C:\Users\Test\Documents\PowerShell ISE\Future_Plans.txt' -To '‎0f 8j b1 ab e0 ce 35 1d 67 d2 f2 6f a2 d2 00 cl 22 z9 m9 85'
Try the new Break All command
```

In the following example, you decrypt content that is located at the literal path C:\Users\Test\Documents\PowerShell ISE.
For the value of the required To parameter, this example uses the thumbprint of the certificate that was used to perform the encryption.
The decrypted message, "Try the new Break All command," is the result.

## PARAMETERS

### -Content
Specifies an encrypted string, or a variable containing an encrypted string.

```yaml
Type: String
Parameter Sets: ByContent
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -EventLogRecord
Specifies an event log record ID that represents a CMS encryption operation.

```yaml
Type: PSObject
Parameter Sets: ByWinEvent
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -IncludeContext
@{Text=}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path to encrypted content that you want to decrypt.
Unlike Path, the value of LiteralPath is used exactly as it is typed.
No characters are interpreted as wildcard characters.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: ByLiteralPath
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path to encrypted content that you want to decrypt.

```yaml
Type: String
Parameter Sets: ByPath
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -To
Specifies one or more CMS message recipients, identified in any of the following formats.

-- An actual certificate (as retrieved from the certificate provider)
-- Path to the a file containing the certificate
-- Path to a directory containing the certificate
-- Thumbprint of the certificate (used to look in the certificate store)
-- Subject name of the certificate (used to look in the certificate store)

```yaml
Type: CmsMessageRecipient[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### 
You can pipe an object containing encrypted content to Unprotect-CmsMessage.

## OUTPUTS

## NOTES

## RELATED LINKS

[about_Providers]()

[Get-CmsMessage]()

[Protect-CmsMessage]()

