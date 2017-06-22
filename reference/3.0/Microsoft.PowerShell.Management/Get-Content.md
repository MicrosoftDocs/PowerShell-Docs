---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113310
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-Content
---

# Get-Content
## SYNOPSIS
Gets the content of the item at the specified location.
## SYNTAX

### Path (Default)
```
Get-Content [-ReadCount <Int64>] [-TotalCount <Int64>] [-Tail <Int32>] [-Path] <String[]> [-Filter <String>]
 [-Include <String[]>] [-Exclude <String[]>] [-Force] [-Credential <PSCredential>] [-UseTransaction]
 [-Delimiter <String>] [-Wait] [-Raw] [-Encoding <FileSystemCmdletProviderEncoding>] [-Stream <String>]
 [<CommonParameters>]
```

### LiteralPath
```
Get-Content [-ReadCount <Int64>] [-TotalCount <Int64>] [-Tail <Int32>] -LiteralPath <String[]>
 [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force] [-Credential <PSCredential>]
 [-UseTransaction] [-Delimiter <String>] [-Wait] [-Raw] [-Encoding <FileSystemCmdletProviderEncoding>]
 [-Stream <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-Content** cmdlet gets the content of the item at the location specified by the path, such as the text in a file.
It reads the content one line at a time and returns a collection of objects , each of which represents a line of content.

Beginning in Windows PowerShell 3.0, **Get-Content** can also get a specified number of lines from the beginning or end of an item.
## EXAMPLES

### Example 1
```
PS C:\> Get-Content -Path C:\Chapters\Chapter1.txt
```

This command gets the content of the Chapter1.txt file.
It uses the **Path** parameter to specify the name of the item.
**Get-Content** actually passes the content down the pipeline, but because there are no other pipeline elements, the content is formatted by default and displayed at the command line.
### Example 2
```
PS C:\> Get-Content c:\Logs\Log060912.txt -TotalCount 50 | Set-Content Sample.txt
```

This command gets the first 50 lines of the Log060912.txt file and stores them in the Sample.txt file.
The command uses the **Get-Content** cmdlet to get the text in the file.
(The name of **Path** parameter, which is optional, is omitted.) The **TotalCount** parameter limits the content retrieved to the first 50 lines.
The pipeline operator (|) sends the result to the Set-Content cmdlet, which places it in the Sample.txt file.
### Example 3
```
PS C:\> (Get-Content Cmdlets.txt -TotalCount 5)[-1]
```

This command gets the fifth line of the Cmdlets.txt text file.
It uses the **TotalCount** parameter to get the first five lines and then uses array notation to get the last line (indicated by "-1") of the resulting set.
### Example 4
```
PS C:\> dir .\*.txt | ForEach {Get-Content $_ -Head 1; Get-Content $_ -Tail 1}
```

This command gets the first and last lines of each text file in the current directory.
The command uses the **Tail** parameter and the **Head** alias of the **TotalCount** parameter
## PARAMETERS

### -Encoding
Specifies the file encoding. The default is ASCII.

Valid values are:

-- ASCII:  Uses the encoding for the ASCII (7-bit) character set.
-- BigEndianUnicode:  Encodes in UTF-16 format using the big-endian byte order.
-- Byte:   Encodes a set of characters into a sequence of bytes.
-- String:  Uses the encoding type for a string.
-- Unicode:  Encodes in UTF-16 format using the little-endian byte order.
-- UTF7:   Encodes in UTF-7 format.
-- UTF8:  Encodes in UTF-8 format.
-- Unknown:  The encoding type is unknown or invalid. The data can be treated as binary.

Encoding is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet. This parameter works only in file system drives.

When reading from and writing to binary files, use a value of Byte for the Encoding dynamic parameter and a value of 0 for the ReadCount parameter.  A ReadCount value of 0 reads the entire file in a single read operation and converts it into a single object (PSObject).  The default ReadCount value, 1, reads one byte in each read operation and converts each byte into a separate object, which causes errors when you use the Set-Content cmdlet to write the bytes to a file. For more information, see the examples.```yaml
Type: FileSystemCmdletProviderEncoding
Parameter Sets: (All)
Aliases: 
Accepted values: Unknown, String, Unicode, Byte, BigEndianUnicode, UTF8, UTF7, UTF32, Ascii, Default, Oem

Required: False
Position: Named
Default value: ASCII
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delimiter
Specifies the delimiter that Get-Content uses to divide the file into objects while it reads. 

The default is "\n", the end-of-line character. 

Therefore, by default, when reading a text file, Get-Content returns a collection of string objects, each of which ends with an end-of-line character. 

When you enter a delimiter that does not exist in the file, Get-Content returns the entire file as a single, undelimited object.

You can use this parameter to split a large file into smaller files by specifying a file separator, such as "End of Example", as the delimiter. The delimiter is preserved (not discarded) and becomes the last item in each file section.

Delimiter is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet. This parameter works only in file system drives.

Troubleshooting Note: Currently, when the value of the Delimiter parameter is an empty string, Get-Content does not return anything. This is a known issue. To force Get-Content to return the entire file as a single, undelimited string, enter a value that does not exist in the file.```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: End-of-line character
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Overrides restrictions that prevent the command from succeeding, just so the changes do not compromise security.
For example, **Force** will override the read-only attribute or create directories to complete a file path, but it will not attempt to change file permissions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw
Ignores newline characters and returns the entire contents of a file in one string. By default, the contents of a file is returned as a array of strings that is delimited by the newline character.

Raw is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet. This parameter works only in file system drives.

This parameter is introduced in Windows PowerShell 3.0.```yaml
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
Waits for the cmdlet to get the content before returning the command prompt. While waiting, Get-Content checks the file once each second until you interrupt it, such as by pressing CTRL+C.

Wait is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet. This parameter works only in file system drives.```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream
Gets the contents of the specified alternate NTFS file stream from the file. Enter the stream name. Wildcards are not supported. 

Stream is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet. This parameter works only in file system drives.

This parameter is introduced in Windows PowerShell 3.0.```yaml
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

Type a user name, such as "User01" or "Domain01\User01", or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

This parameter is not supported by any providers that are installed with Windows PowerShell.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude
Omits the specified items.
The value of this parameter qualifies the **Path** parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter
Specifies a filter in the provider's format or language.
The value of this parameter qualifies the Path parameter.
The syntax of the filter, including the use of wildcards, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when getting the objects, rather than having Windows PowerShell filter the objects after they are retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include
Gets only the specified items.
The value of this parameter qualifies the **Path** parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath
Specifies the path to an item.
Unlike **Path**, the value of **LiteralPath** is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

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
**Get-Content** gets the content of the item.
Wildcards are permitted.
The parameter name ("Path" or "FilePath") is optional.

```yaml
Type: String[]
Parameter Sets: Path
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -ReadCount
Specifies how many lines of content are sent through the pipeline at a time.
The default value is 1.
A value of 0 (zero) sends all of the content at one time.

This parameter does not change the content displayed, but it does affect the time it takes to display the content.
As the value of **ReadCount** increases, the time it takes to return the first line increases, but the total time for the operation decreases.
This can make a perceptible difference in very large items.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TotalCount
Gets the specified number of lines from the beginning of a file or other item.
The default is -1 (all lines).

You can use the "TotalCount" parameter name or its aliases, "First" or "Head".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: First, Head

Required: False
Position: Named
Default value: -1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tail
Gets the specified number of lines from the end of a file or other item.

This parameter is introduced in Windows PowerShell 3.0.

You can use the "Tail" parameter name or its alias, "Last".

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

### None
You cannot pipe input to **Get-Content**.
## OUTPUTS

### System.Byte, System.String
**Get-Content** returns strings or bytes.
The output type depends upon the content that it gets.
## NOTES
* The **Get-Content** cmdlet is designed to work with the data exposed by any provider. To get the providers in your session, use the **Get-PsProvider** cmdlet. For more information, see about_Providers (http://go.microsoft.com/fwlink/?LinkID=113250).

*
## RELATED LINKS

[Add-Content](Add-Content.md)

[Clear-Content](Clear-Content.md)

[Set-Content](Set-Content.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)


