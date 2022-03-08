---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 05/16/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-FileHash
---
# Get-FileHash

## SYNOPSIS
Computes the hash value for a file by using a specified hash algorithm.

## SYNTAX

### Path (Default)

```
Get-FileHash [-Path] <String[]> [[-Algorithm] <String>] [<CommonParameters>]
```

### LiteralPath

```
Get-FileHash [-LiteralPath] <String[]> [[-Algorithm] <String>] [<CommonParameters>]
```

### StreamParameterSet

```
Get-FileHash [-InputStream] <Stream> [[-Algorithm] <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-FileHash` cmdlet computes the hash value for a file by using a specified hash algorithm.
A hash value is a unique value that corresponds to the content of the file. Rather than identifying
the contents of a file by its file name, extension, or other designation, a hash assigns a unique
value to the contents of a file. File names and extensions can be changed without altering the
content of the file, and without changing the hash value. Similarly, the file's content can be
changed without changing the name or extension. However, changing even a single character in the
contents of a file changes the hash value of the file.

The purpose of hash values is to provide a cryptographically-secure way to verify that the contents
of a file have not been changed. While some hash algorithms, including MD5 and SHA1, are no longer
considered secure against attack, the goal of a secure hash algorithm is to render it impossible to
change the contents of a file -- either by accident, or by malicious or unauthorized attempt -- and
maintain the same hash value. You can also use hash values to determine if two different files have
exactly the same content. If the hash values of two files are identical, the contents of the files
are also identical.

By default, the `Get-FileHash` cmdlet uses the SHA256 algorithm, although any hash algorithm that
is supported by the target operating system can be used.

## EXAMPLES

### Example 1: Compute the hash value for a file

This example uses the `Get-FileHash` cmdlet to compute the hash value for the
`/etc/apt/sources.list` file. The hash algorithm used is the default, **SHA256**. The output is
piped to the `Format-List` cmdlet to format the output as a list.

```powershell
Get-FileHash /etc/apt/sources.list | Format-List
```

```Output
Algorithm : SHA256
Hash      : 3CBCFDDEC145E3382D592266BE193E5BE53443138EE6AB6CA09FF20DF609E268
Path      : /etc/apt/sources.list
```

### Example 2: Compute the hash value for an ISO file

This example uses the `Get-FileHash` cmdlet and the **SHA384** algorithm to compute the hash value
for an ISO file that an administrator has downloaded from the internet. The output is piped to the
`Format-List` cmdlet to format the output as a list.

```powershell
Get-FileHash C:\Users\user1\Downloads\Contoso8_1_ENT.iso -Algorithm SHA384 | Format-List
```

```Output
Algorithm : SHA384
Hash      : 20AB1C2EE19FC96A7C66E33917D191A24E3CE9DAC99DB7C786ACCE31E559144FEAFC695C58E508E2EBBC9D3C96F21FA3
Path      : C:\Users\user1\Downloads\Contoso8_1_ENT.iso
```

### Example 3: Compute the hash value of a stream

For this example, we get are using **System.Net.WebClient** to download a package from the
[Powershell release page](https://github.com/PowerShell/PowerShell/releases/tag/v6.2.4). The release
page also documents the SHA256 hash of each package file. We can compare the published hash value
with the one we calculate with `Get-FileHash`.

```powershell
$wc = [System.Net.WebClient]::new()
$pkgurl = 'https://github.com/PowerShell/PowerShell/releases/download/v6.2.4/powershell_6.2.4-1.debian.9_amd64.deb'
$publishedHash = '8E28E54D601F0751922DE24632C1E716B4684876255CF82304A9B19E89A9CCAC'
$FileHash = Get-FileHash -InputStream ($wc.OpenRead($pkgurl))
$FileHash.Hash -eq $publishedHash
```

```Output
True
```

### Example 4: Compute the hash of a string

PowerShell does not provide a cmdlet to compute the hash of a string. However, you can write a
string to a stream and use the **InputStream** parameter of `Get-FileHash` to get the hash value.

```powershell
$stringAsStream = [System.IO.MemoryStream]::new()
$writer = [System.IO.StreamWriter]::new($stringAsStream)
$writer.write("Hello world")
$writer.Flush()
$stringAsStream.Position = 0
Get-FileHash -InputStream $stringAsStream | Select-Object Hash
```

```Output
Hash
----
64EC88CA00B268E5BA1A35678A1B5316D212F4F366B2477232534A8AECA37F3C
```

## PARAMETERS

### -Algorithm

Specifies the cryptographic hash function to use for computing the hash value of the contents of the
specified file or stream. A cryptographic hash function has the property that it is infeasible to
find two different files with the same hash value. Hash functions are commonly used with digital
signatures and for data integrity. The acceptable values for this parameter are:

- SHA1
- SHA256
- SHA384
- SHA512
- MD5

If no value is specified, or if the parameter is omitted, the default value is SHA256.

For security reasons, MD5 and SHA1, which are no longer considered secure, should only be used for
simple change validation, and should not be used to generate hash values for files that require
protection from attack or tampering.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: SHA1, SHA256, SHA384, SHA512, MD5

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputStream

Specifies the input stream.

```yaml
Type: System.IO.Stream
Parameter Sets: StreamParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to a file. Unlike the **Path** parameter, the value of the **LiteralPath**
parameter is used exactly as it is typed. No characters are interpreted as wildcard characters. If
the path includes escape characters, enclose the path in single quotation marks. Single quotation
marks instruct PowerShell not to interpret characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath, LP

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the path to one or more files as an array. Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string to the `Get-FileHash` cmdlet that contains a path to one or more files.

## OUTPUTS

### Microsoft.Powershell.Utility.FileHash

`Get-FileHash` returns an object that represents the path to the specified file, the value of the
computed hash, and the algorithm used to compute the hash.

## NOTES

## RELATED LINKS

[Format-List](Format-List.md)

