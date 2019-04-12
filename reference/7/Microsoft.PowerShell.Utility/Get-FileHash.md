---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=822413
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

The **Get-FileHash** cmdlet computes the hash value for a file by using a specified hash algorithm.
A hash value is a unique value that corresponds to the content of the file.
Rather than identifying the contents of a file by its file name, extension, or other designation, a hash assigns a unique value to the contents of a file.
File names and extensions can be changed without altering the content of the file, and without changing the hash value.
Similarly, the file's content can be changed without changing the name or extension.
However, changing even a single character in the contents of a file changes the hash value of the file.

The purpose of hash values is to provide a cryptographically-secure way to verify that the contents of a file have not been changed.
While some hash algorithms, including MD5 and SHA1, are no longer considered secure against attack, the goal of a secure hash algorithm is to render it impossible to change the contents of a file-either by accident, or by malicious or unauthorized attempt-and maintain the same hash value.
You can also use hash values to determine if two different files have exactly the same content.
If the hash values of two files are identical, the contents of the files are also identical.

By default, the **Get-FileHash** cmdlet uses the SHA256 algorithm, although any hash algorithm that is supported by the target operating system can be used.

## EXAMPLES

### Example 1: Compute the hash value for a PowerShell.exe file

```
PS C:\> Get-FileHash $pshome\powershell.exe | Format-List
Algorithm : SHA256
Hash      : 6A785ADC0263238DAB3EB37F4C185C8FBA7FEB5D425D034CA9864F1BE1C1B473
Path      : C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
```

This command uses the **Get-FileHash** cmdlet to compute the hash value for the Powershell.exe file.
The hash algorithm used is the default, SHA256.
The output is piped to the Format-List cmdlet to format the output as a list.

### Example 2: Compute the hash value for an ISO file

```
PS C:\> Get-FileHash C:\Users\Andris\Downloads\Contoso8_1_ENT.iso -Algorithm SHA384 | Format-List

Algorithm : SHA384
Hash      : 20AB1C2EE19FC96A7C66E33917D191A24E3CE9DAC99DB7C786ACCE31E559144FEAFC695C58E508E2EBBC9D3C96F21FA3
Path      : C:\Users\Andris\Downloads\Contoso8_1_ENT.iso
```

This command uses the **Get-FileHash** cmdlet and the SHA384 algorithm to compute the hash value for an ISO file that an administrator has downloaded from the Internet.
The output is piped to the Format-List cmdlet to format the output as a list.

### Example 3: Compute the hash value of a stream and compare the procedure with getting the hash from the file directly

```powershell
# Path of Microsoft.PowerShell.Utility.psd1
$file = (Get-Module Microsoft.PowerShell.Utility).Path

$hashFromFile = Get-FileHash -Path $file -Algorithm MD5

# Open $file as a stream
$stream = [System.IO.File]::OpenRead($file)
$hashFromStream = Get-FileHash -InputStream $stream -Algorithm MD5
$stream.Close()

Write-Host '### Hash from File ###' -NoNewline
$hashFromFile | Format-List
Write-Host '### Hash from Stream ###' -NoNewline
$hashFromStream | Format-List

# Check both hashes are the same
if ($hashFromFile.Hash -eq $hashFromStream.Hash) {
	Write-Host 'Get-FileHash results are consistent' -ForegroundColor Green
} else {
	Write-Host 'Get-FileHash results are inconsistent!!' -ForegroundColor Red
}
```

```output
### Hash from File ###

Algorithm : MD5
Hash      : 593D6592BD9B7F9174711AB136F5E751
Path      : C:\Program Files\PowerShell\6.0.0\Modules\Microsoft.Powe
            rShell.Utility\Microsoft.PowerShell.Utility.psd1

### Hash from Stream ###

Algorithm : MD5
Hash      : 593D6592BD9B7F9174711AB136F5E751
Path      :

Get-FileHash results are consistent
```

## PARAMETERS

### -Algorithm

Specifies the cryptographic hash function to use for computing the hash value of the contents of the specified file.
A cryptographic hash function includes the property that it is not possible to find two distinct inputs that generate the same hash values.
Hash functions are commonly used with digital signatures and for data integrity.
The acceptable values for this parameter are:

- SHA1
- SHA256
- SHA384
- SHA512
- MD5

If no value is specified, or if the parameter is omitted, the default value is SHA256.

For security reasons, MD5 and SHA1, which are no longer considered secure, should only be used for simple change validation, and should not be used to generate hash values for files that require protection from attack or tampering.

```yaml
Type: String
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
Type: Stream
Parameter Sets: StreamParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to a file.
Unlike the *Path* parameter, the value of the *LiteralPath* parameter is used exactly as it is typed.
No characters are interpreted as wildcard characters.
If the path includes escape characters, enclose the path in single quotation marks.
Single quotation marks instruct PowerShell not to interpret characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the path to one or more files as an array.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string to the **Get-FileHash** cmdlet that contains a path to one or more files.

## OUTPUTS

### Microsoft.Powershell.Utility.FileHash

**Get-FileHash** returns an object that represents the path to the specified file, the value of the computed hash, and the algorithm used to compute the hash.

## NOTES

## RELATED LINKS

[Format-List](Format-List.md)