---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821583
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-Content
---

# Get-Content

## SYNOPSIS
Gets the content of an item at a specified location.

## SYNTAX

### Path (Default)
```
Get-Content [-ReadCount <Int64>] [-TotalCount <Int64>] [-Tail <Int32>] [-Path] <String[]> [-Filter <String>]
 [-Include <String[]>] [-Exclude <String[]>] [-Force] [-Credential <PSCredential>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-UseTransaction]
 [-Delimiter <String>] [-Wait] [-Raw] [-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <String>]
 [<CommonParameters>]
```

### LiteralPath
```
Get-Content [-ReadCount <Int64>] [-TotalCount <Int64>] [-Tail <Int32>] -LiteralPath <String[]>
 [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force] [-Credential <PSCredential>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-UseTransaction]
 [-Delimiter <String>] [-Wait] [-Raw] [-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Get-Content** cmdlet gets the content of the item at the location specified by the path, such as the text in a file.
It reads the content one line at a time and returns a collection of objects, each of which represents a line of content.

Beginning in Windows PowerShell 3.0, this cmdlet can also get a specified number of lines from the beginning or end of an item.

## EXAMPLES

### Example 1: Get the content of a text file
```powershell
Get-Content -Path "C:\Chapters\Chapter1.txt"
```

This command gets the content of the Chapter1.txt file.
It uses the `-Path` parameter to specify the name of the item.
`Get-Content` passes the content down the pipeline, but because there are no other pipeline elements, the content is formatted by default and displayed at the command line.

### Example 2: Get the first 50 lines from a text file and store the results in another file
```powershell
Get-Content "C:\Logs\Log060912.txt" -TotalCount 50 | Set-Content "Sample.txt"
```

This command gets the first 50 lines of the `Log060912.txt` file and stores them in the `Sample.txt` file.
The command uses the `Get-Content` cmdlet to get the text in the file.
(Specifying the `-Path` parameter explicitly is optional and omitted here.)
The `-TotalCount` parameter limits the content retrieved to the first 50 lines.
The pipeline operator (`|`) sends the result to the `Set-Content` cmdlet, which places it in the `Sample.txt` file.

### Example 3: Get the fifth line of a text file
```powershell
(Get-Content Cmdlets.txt -TotalCount 5)[-1]
```

This command gets the fifth line of the `Cmdlets.txt` text file.
It uses the `-TotalCount` parameter to get the first five lines and then uses array notation to get the last line (indicated by "-1") of the resulting set.

### Example 4: Get the first and last line of a text file
```powershell
dir .\*.txt | ForEach {Get-Content $_ -Head 1; Get-Content $_ -Tail 1}
```

This command gets the first and last lines of each text file in the current directory.
The command uses the `-Tail` parameter and the `-Head` alias of the `-TotalCount` parameter.

### Example 5: Get the content of an alternate data stream
```
C:\PS>Get-Content .\Copy-Scripts.ps1 -Stream Zone.Identifier

[ZoneTransfer]
ZoneId=3
```

This command uses the `-Stream` parameter to get the content of the `Zone.Identifier` alternate data stream.
The output includes Zone ID value of 3, which represents the internet.

The `-Stream` parameter was introduced in Windows PowerShell 3.0.

### Example 6: Getting a hashtable out of file contents as a hastable 
```
C:\PS>$Manifest = (Get-Module -List PSScheduledJob).Path

C:\PS>$Hash = Invoke-Expression (Get-Content $Manifest -Raw)

C:\PS>$Hash

Name                           Value
----                           -----
Copyright                      © Microsoft Corporation. All rights reserved.
ModuleToProcess                Microsoft.PowerShell.ScheduledJob.dll
FormatsToProcess               PSScheduledJob.Format.ps1xml
PowerShellVersion              3.0
CompanyName                    Microsoft Corporation
GUID                           50cdb55f-5ab7-489f-9e94-4ec21ff51e59
Author                         Microsoft Corporation
CLRVersion                     4.0
CmdletsToExport                {New-JobTrigger, Add-JobTrigger, Remove-JobTrigger, Get-JobTrigger...}
TypesToProcess                 PSScheduledJob.types.ps1xml
HelpInfoURI                    http://go.microsoft.com/fwlink/?LinkID=223911
ModuleVersion                  1.0.0.0

C:\PS>$Hash.ModuleToProcess
Microsoft.PowerShell.ScheduledJob.dll
```

The commands in this example get the contents of a module manifest file (.psd1) as a hash table.
The manifest file contains a hash table, but if you get the contents without the `-Raw` dynamic parameter, it is returned as an array of newline-delimited strings.

The `-Raw` dynamic parameter was introduced in Windows PowerShell 3.0.

The first command uses the `-Path` property of modules to get the path to the file that contains the module manifest for the `PSScheduledJob` module.
It saves the path in the `$Manifest` variable.

The second command uses the `Invoke-Expression` cmdlet to run a `Get-Content` command and the `-Raw` dynamic parameter of the `Get-Content` cmdlet to get the contents of the module manifest file in a single string.
The command saves the hash table in the `$Hash` variable.

The third command gets the hash table in the `$Hash` variable.
The contents is returned as a collection of name-value pairs.

The fourth command uses the `ModuleToProcess` property of the hash table to get the value of the `ModuleToProcess` key in the module manifest.

## PARAMETERS

### -Encoding
Specifies the encoding that this cmdlet applies to the content.

The acceptable values for this parameter are:

- Unknown: The encoding type is unknown or invalid. The data can be treated as binary.
- String: Uses the encoding type for a string.
- Unicode: Encodes in UTF-16 format using the little-endian byte order.
- Byte: Encodes a set of characters into a sequence of bytes.
- BigEndianUnicode: Encodes in UTF-16 format using the little-endian byte order.
- UTF8: Encodes in UTF-8 format.
- UTF7: Encodes in UTF-7 format.
- UTF32: Encodes in UTF-32 format.
- Ascii: Uses the encoding for the ASCII (7-bit) character set.
- Default: Uses the default encoding defined by the underlying .NET system.
- Oem
- BigEndianUTF32: Encodes in UTF-16 format using the big-endian byte order.

Encoding is a dynamic parameter that the FileSystem provider adds to `Get-Content` cmdlet.
This parameter works only in filesystem drives.

When reading from and writing to binary files, use a value of `Byte` for the `-Encoding` parameter and a value of 0 for the `-ReadCount` parameter.
A `ReadCount` value of 0 reads the entire file in a single read operation and converts it into a single object (`PSObject`).
The default `ReadCount` value, 1, reads one byte in each read operation and converts each byte into a separate object, which causes errors when you use the [Set-Content](Set-Content.md) cmdlet to write the bytes to a file.
For more information, see the examples.

```yaml
Type: FileSystemCmdletProviderEncoding
Parameter Sets: (All)
Aliases: 
Accepted values: Unknown, String, Unicode, Byte, BigEndianUnicode, UTF8, UTF7, UTF32, Ascii, Default, Oem, BigEndianUTF32

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delimiter
Specifies the delimiter that `Get-Content` uses to divide the file into objects while it reads.

The default is "\n", the end-of-line character.

Therefore, by default, when reading a text file, `Get-Content` returns a collection of string objects, each of which ends with an end-of-line character.

When you enter a delimiter that does not exist in the file, `Get-Content` returns the entire file as a single, undelimited object.

You can use this parameter to split a large file into smaller files by specifying a file separator, such as "End of Example", as the delimiter.
The delimiter is preserved (not discarded) and becomes the last item in each file section.

`-Delimiter` is a dynamic parameter that the FileSystem provider adds to the `Get-Content` cmdlet.
This parameter works only in filesystem drives.

Note: When the value of the `-Delimiter` parameter is an empty string, `Get-Content` does not return anything.
To force `Get-Content` to return the entire file as a single, undelimited string, use the `-Raw` parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Gets the contents of all files, including hidden files. By default, `Get-Content` does not get the contents of hidden files unless you specify the hidden file by name.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw
Ignores newline characters and returns the entire contents of a file in one string.
By default, the contents of a file is returned as a array of strings that is delimited by the newline character.

Raw is a dynamic parameter that the FileSystem provider adds to the `Get-Content` cmdlet. This parameter works only in filesystem drives.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait
Waits for the cmdlet to get the content before returning the command prompt.
While waiting, `Get-Content` checks the file once each second until you interrupt it, such as by pressing CTRL+C.

`-Wait` is a dynamic parameter that the FileSystem provider adds to the `Get-Content` cmdlet.
This parameter works only in filesystem drives.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream
Gets the contents of the specified alternate NTFS file stream from the file.
Enter the stream name. Wildcards are not supported.

`-Stream` is a dynamic parameter that the FileSystem provider adds to the `Get-Content` cmdlet.
This parameter works only in filesystem drives.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see about_Transactions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: usetx

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

This parameter is not supported by any providers that are installed with Windows PowerShell.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude
Specifies, as a string array, the item or items that this cmdlet omits when performing the operation.
The value of this parameter qualifies the `-Path` parameter.
Enter a path element or pattern, such as `*.txt`.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Specifies a filter in the provider's format or language.
The value of this parameter qualifies the `-Path` parameter.
The syntax of the filter, including the use of wildcards, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when this cmdlet gets the objects, rather than having PowerShell filter the objects after they are retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Specifies, as a string array, the item or items that this cmdlet includes in the operation.
The value of this parameter qualifies the `-Path` parameter.
Enter a path element or pattern, such as `*.txt`.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path to an item.
Unlike the `-Path` parameter, the value of `-LiteralPath` is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the path to an item.
`Get-Content` gets the content of the item.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: Path
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ReadCount
Specifies how many lines of content are sent through the pipeline at a time.
The default value is 1.
A value of 0 (zero) sends all of the content at one time.

This parameter does not change the content displayed, but it does affect the time it takes to display the content.
As the value of `-ReadCount` increases, the time it takes to return the first line increases, but the total time for the operation decreases.
This can make a perceptible difference in very large items.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TotalCount
Specifies the number of lines from the beginning of a file or other item.
The default is -1 (all lines).

You can use the `-TotalCount` parameter name or its aliases, `-First` or `-Head`.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: First, Head

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tail
Specifies the number of lines from the end of a file or other item.

This parameter was introduced in Windows PowerShell 3.0.

You can use the `-Tail` parameter name or its alias, `-Last`.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Last

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int64, System.String[], System.Management.Automation.PSCredential
You can pipe the read count, total count, paths, or credentials to Get-Content.

## OUTPUTS

### System.Byte, System.String
`Get-Content` returns objects that represent that content that it gets.
The output type depends upon the content that it gets.
If you use the `-Stream` parameter, the cmdlet returns the alternate stream contents as a string.

## NOTES
This cmdlet is designed to work with the data exposed by any provider.
To get the providers in your session, use the `Get-PSProvider` cmdlet. For more information, see about_Providers(http://go.microsoft.com/fwlink/?LinkID=113250).

## RELATED LINKS

[Add-Content](Add-Content.md)

[Clear-Content](Clear-Content.md)

[Set-Content](Set-Content.md)

[Get-PSProvider](Get-PSProvider.md)
