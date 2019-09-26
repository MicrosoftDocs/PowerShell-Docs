---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=293933
external help file:  Microsoft.PowerShell.Security.dll-Help.xml
title:  ConvertTo-SecureString
---

# ConvertTo-SecureString

## SYNOPSIS
Converts encrypted standard strings to secure strings.
It can also convert plain text to secure strings.
It is used with ConvertFrom-SecureString and Read-Host.

## SYNTAX

### Secure (Default)
```
ConvertTo-SecureString [-String] <String> [[-SecureKey] <SecureString>] [<CommonParameters>]
```

### PlainText
```
ConvertTo-SecureString [-String] <String> [-AsPlainText] [-Force] [<CommonParameters>]
```

### Open
```
ConvertTo-SecureString [-String] <String> [-Key <Byte[]>] [<CommonParameters>]
```

## DESCRIPTION
The ConvertTo-SecureString cmdlet converts encrypted standard strings into secure strings.
It can also convert plain text to secure strings.
It is used with ConvertFrom-SecureString and Read-Host.
The secure string created by the cmdlet can be used with cmdlets or functions that require a parameter of type SecureString.
The secure string can be converted back to an encrypted, standard string using the ConvertFrom-SecureString cmdlet.
This enables it to be stored in a file for later use.

If the standard string being converted was encrypted with ConvertFrom-SecureString using a specified key, that same key must be provided as the value of the Key or SecureKey parameter of the ConvertTo-SecureString cmdlet.

## EXAMPLES

### Example 1
```
PS C:\> $secure = read-host -assecurestring
PS C:\> $secure
System.Security.SecureString
PS C:\> $encrypted = convertfrom-securestring -securestring $secure
PS C:\> $encrypted

01000000d08c9ddf0115d1118c7a00c04fc297eb010000001a114d45b8dd3f4aa11ad7c0abdae9800000000002000000000003660000a8000000100000005df63cea84bfb7d70bd6842e7
efa79820000000004800000a000000010000000f10cd0f4a99a8d5814d94e0687d7430b100000008bf11f1960158405b2779613e9352c6d14000000e6b7bf46a9d485ff211b9b2a2df3bd
6eb67aae41

PS C:\> $secure2 = convertto-securestring -string $encrypted
PS C:\> $secure2

System.Security.SecureString
```

This example shows how to create a secure string from user input, convert the secure string to an encrypted standard string, and then convert the encrypted standard string back to a secure string.

The first command uses the AsSecureString parameter of the Read-Host cmdlet to create a secure string.
After you enter the command, any characters that you type are converted into a secure string and then saved in the $secure variable.

The second command displays the contents of the $secure variable.
Because the $secure variable contains a secure string, Windows PowerShell displays only the System.Security.SecureString type.

The third command uses the ConvertFrom-SecureString cmdlet to convert the secure string in the $secure variable into an encrypted standard string.
It saves the result in the $encrypted variable.
The fourth command displays the encrypted string in the value of the $encrypted variable.

The fifth command uses the ConvertTo-SecureString cmdlet to convert the encrypted standard string in the $encrypted variable back into a secure string.
It saves the result in the $secure2 variable.
The sixth command displays the value of the $secure2 variable.
The SecureString type indicates that the command was successful.

### Example 2
```
PS C:\> $secure = read-host -assecurestring
PS C:\> $encrypted = convertfrom-securestring -secureString $secure -key (1..16)
PS C:\> $encrypted | set-content encrypted.txt
PS C:\> $secure2 = get-content encrypted.txt | convertto-securestring -key (1..16)
```

This example shows how to create a secure string from an encrypted standard string that is saved in a file.

The first command uses the AsSecureString parameter of the Read-Host cmdlet to create a secure string.
After you enter the command, any characters that you type are converted into a secure string and then saved in the $secure variable.

The second command uses the ConvertFrom-SecureString cmdlet to convert the secure string in the $secure variable into an encrypted standard string by using the specified key.
The contents are saved in the $encrypted variable.

The third command uses a pipeline operator (|) to send the value of the $encrypted variable to the Set-Content cmdlet, which saves the value in the Encrypted.txt file.

The fourth command uses the Get-Content cmdlet to get the encrypted standard string in the Encrypted.txt file.
The command uses a pipeline operator to send the encrypted string to the ConvertTo-SecureString cmdlet, which converts it to a secure string by using the specified key.
The results are saved in the $secure2 variable.

### Example 3
```
PS C:\> $secure_string_pwd = convertto-securestring "P@ssW0rD!" -asplaintext -force
```

This command converts the plain text string "P@ssW0rD!" into a secure string and stores the result in the $secure_string_pwd variable.
To use the AsPlainText parameter, the Force parameter must also be included in the command.

## PARAMETERS

### -AsPlainText
Specifies a plain text string to convert to a secure string.
The secure string cmdlets help protect confidential text.
The text is encrypted for privacy and is deleted from computer memory after it is used.
If you use this parameter to provide plain text as input, the system cannot protect that input in this manner.
To use this parameter, you must also specify the Force parameter.

```yaml
Type: SwitchParameter
Parameter Sets: PlainText
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Confirms that you understand the implications of using the AsPlainText parameter and still want to use it.

```yaml
Type: SwitchParameter
Parameter Sets: PlainText
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key
Specifies the encryption key to use when converting a secure string into an encrypted standard string.
Valid key lengths are 16, 24, and 32 bytes.

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
Specifies the encryption key to use when converting a secure string into an encrypted standard string.
The key must be provided in the format of a secure string.
The secure string is converted to a byte array before being used as the key.
Valid key lengths are 16, 24, and 32 bytes.

```yaml
Type: SecureString
Parameter Sets: Secure
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -String
Specifies the string to convert to a secure string.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a standard encrypted string to ConvertTo-SecureString.

## OUTPUTS

### System.Security.SecureString
ConvertTo-SecureString returns a SecureString object.

## NOTES

## RELATED LINKS

[ConvertFrom-SecureString](ConvertFrom-SecureString.md)

[Read-Host](../Microsoft.PowerShell.Utility/Read-Host.md)


