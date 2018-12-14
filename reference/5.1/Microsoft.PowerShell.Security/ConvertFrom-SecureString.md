---
external help file: Microsoft.PowerShell.Security.dll-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Security
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821708
schema: 2.0.0
title: ConvertFrom-SecureString
---

# ConvertFrom-SecureString

## SYNOPSIS
Converts a secure string to an encrypted standard string.

## SYNTAX

### Secure (Default)
```
ConvertFrom-SecureString [-SecureString] <SecureString> [[-SecureKey] <SecureString>] [<CommonParameters>]
```

### Open
```
ConvertFrom-SecureString [-SecureString] <SecureString> [-Key <Byte[]>] [<CommonParameters>]
```

## DESCRIPTION
The **ConvertFrom-SecureString** cmdlet converts a secure string (**System.Security.SecureString**) to an encrypted standard string (**System.String**).
Unlike a secure string, an encrypted standard string can be saved in a file for later use.
The encrypted standard string can be converted back to a secure string by using the ConvertTo-SecureString cmdlet.

If an encryption key is specified by using the *Key* or *SecureKey* parameters, the Advanced Encryption Standard (AES) encryption algorithm is used.
The specified key must have a length of 128, 192, or 256 bits, because those are the key lengths supported by the AES encryption algorithm.
If no key is specified, the Windows Data Protection API (DPAPI) is used to encrypt the standard string representation.

## EXAMPLES

### Example 1: Create a secure string
```
PS C:\> $SecureString = Read-Host -AsSecureString
```

This command creates a secure string from characters that you type at the command prompt.
After entering the command, type the string you want to store as a secure string.
An asterisk (*) is displayed to represent each character that you type.

### Example 2: Convert a secure string to an encrypted standard string
```
PS C:\> $StandardString = ConvertFrom-SecureString $SecureString
```

This command converts the secure string in the $SecureString variable to an encrypted standard string.
The resulting encrypted standard string is stored in the $StandardString variable.

### Example 3: Convert a secure string to an encrypted standard string with a 192-bit key
```
PS C:\> $Key = (3,4,2,3,56,34,254,222,1,1,2,23,42,54,33,233,1,34,2,7,6,5,35,43)
PS C:\> $StandardString = ConvertFrom-SecureString $SecureString -Key $Key
```

These commands use the AES algorithm to convert the secure string stored in the $SecureString variable to an encrypted standard string with a 192-bit key.
The resulting encrypted standard string is stored in the $StandardString variable.

The first command stores a key in the $Key variable.
The key is an array of 24 digits, all of which are less than 256.

Because each digit represents a byte (8 bits), the key has 24 digits for a total of 192 bits (8 x 24).
This is a valid key length for the AES algorithm.
Each individual value is less than 256, which is the maximum value that can be stored in an unsigned byte.

The second command uses the key in the $Key variable to convert the secure string to an encrypted standard string.

## PARAMETERS

### -Key
Specifies the encryption key as a byte array.

```yaml
Type: Byte[]
Parameter Sets: Open
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecureKey
Specifies the encryption key as a secure string.
The secure string value is converted to a byte array before being used as the key.

```yaml
Type: SecureString
Parameter Sets: Secure
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecureString
Specifies the secure string to convert to an encrypted standard string.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Security.SecureString
You can pipe a **SecureString** object to **ConvertFrom-SecureString**.

## OUTPUTS

### System.String
**ConvertFrom-SecureString** returns a standard string object.

## NOTES
* To create a secure string from characters that are typed at the command prompt, use the *AsSecureString* parameter of the Read-Host cmdlet.

  When you use the *Key* or *SecureKey* parameters to specify a key, the key length must be correct.
For example, a key of 128 bits can be specified as a byte array of 16 digits.
Similarly, 192-bit and 256-bit keys correspond to byte arrays of 24 and 32 digits, respectively.

*

## RELATED LINKS

[ConvertTo-SecureString](ConvertTo-SecureString.md)