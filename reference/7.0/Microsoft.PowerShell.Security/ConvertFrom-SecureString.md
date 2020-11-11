---
external help file: Microsoft.PowerShell.Security.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Security
ms.date: 07/27/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.security/convertfrom-securestring?view=powershell-7&WT.mc_id=ps-gethelp
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

### AsPlainText

```
ConvertFrom-SecureString [-SecureString] <SecureString> [-AsPlainText] [<CommonParameters>]
```

### Open

```
ConvertFrom-SecureString [-SecureString] <SecureString> [-Key <Byte[]>] [<CommonParameters>]
```

## DESCRIPTION

The **ConvertFrom-SecureString** cmdlet converts a secure string (**System.Security.SecureString**)
into an encrypted standard string (**System.String**). Unlike a secure string, an encrypted standard
string can be saved in a file for later use. The encrypted standard string can be converted back to
its secure string format by using the `ConvertTo-SecureString` cmdlet.

If an encryption key is specified by using the **Key** or **SecureKey** parameters, the Advanced
Encryption Standard (AES) encryption algorithm is used. The specified key must have a length of 128,
192, or 256 bits because those are the key lengths supported by the AES encryption algorithm. If no
key is specified, the Windows Data Protection API (DPAPI) is used to encrypt the standard string
representation.

> [!NOTE]
> Note that per [DotNet](/dotnet/api/system.security.securestring?view=netcore-2.1#remarks), the
> contents of a SecureString are not encrypted on non-Windows systems.

## EXAMPLES

### Example 1: Create a secure string

```powershell
$SecureString = Read-Host -AsSecureString
```

This command creates a secure string from characters that you type at the command prompt. After
entering the command, type the string you want to store as a secure string. An asterisk (`*`) is
displayed to represent each character that you type.

### Example 2: Convert a secure string to an encrypted standard string

```powershell
$StandardString = ConvertFrom-SecureString $SecureString
```

This command converts the secure string in the `$SecureString` variable to an encrypted standard
string. The resulting encrypted standard string is stored in the `$StandardString` variable.

### Example 3: Convert a secure string to an encrypted standard string with a 192-bit key

```powershell
$Key = (3,4,2,3,56,34,254,222,1,1,2,23,42,54,33,233,1,34,2,7,6,5,35,43)
$StandardString = ConvertFrom-SecureString $SecureString -Key $Key
```

These commands use the Advanced Encryption Standard (AES) algorithm to convert the secure string
stored in the `$SecureString` variable to an encrypted standard string with a 192-bit key. The
resulting encrypted standard string is stored in the `$StandardString` variable.

The first command stores a key in the `$Key` variable. The key is an array of 24 decimal numerals,
each of which must be less than 256 to fit within a single unsigned byte.

Because each decimal numeral represents a single byte (8 bits), the key has 24 digits for a total of
192 bits (8 x 24). This is a valid key length for the AES algorithm.

The second command uses the key in the `$Key` variable to convert the secure string to an encrypted
standard string.

### Example 4: Convert a secure string directly to a plaintext string

```powershell
$secureString = ConvertTo-SecureString -String 'Example' -AsPlainText
$secureString # 'System.Security.SecureString'
ConvertFrom-SecureString -SecureString $secureString -AsPlainText # 'Example'
```

## PARAMETERS

### -AsPlainText

When set, `ConvertFrom-SecureString` will convert secure strings to the decrypted plaintext string
as output.

This paramater was added in PowerShell 7.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: AsPlainText
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key

Specifies the encryption key as a byte array.

```yaml
Type: System.Byte[]
Parameter Sets: Open
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecureKey

Specifies the encryption key as a secure string. The secure string value is converted to a byte
array before being used as the key.

```yaml
Type: System.Security.SecureString
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
Type: System.Security.SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters:
`-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`,`-InformationVariable`,
`-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`.
For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Security.SecureString

You can pipe a **SecureString** object to ConvertFrom-SecureString.

## OUTPUTS

### System.String

ConvertFrom-SecureString returns a standard string object.

## NOTES

- To create a secure string from characters that are typed at the command prompt, use the
  **AsSecureString** parameter of the `Read-Host` cmdlet.
- When you use the **Key** or **SecureKey** parameters to specify a key, the key length must be
  correct. For example, a key of 128 bits can be specified as a byte array of 16 decimal numerals.
  Similarly, 192-bit and 256-bit keys correspond to byte arrays of 24 and 32 decimal numerals,
  respectively.
- Some characters, such as emoticons, correspond to several code points in the string that contains
  them. Avoid using these characters because they may cause problems and misunderstandings when used
  in a password.

## RELATED LINKS

[ConvertTo-SecureString](ConvertTo-SecureString.md)

[Read-Host](../Microsoft.PowerShell.Utility/Read-Host.md)
