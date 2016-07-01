---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Get Content
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://technet.microsoft.com/library/hh847788(v=wps.630).aspx
schema:  2.0.0
---


# Get-Content
## SYNOPSIS
Gets the contents of a file.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-Content [-Path] <String[]> [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force]
 [-Include <String[]>] [-ReadCount <Int64>] [-Tail <Int32>] [-TotalCount <Int64>] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Get-Content [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force]
 [-Include <String[]>] [-ReadCount <Int64>] [-Tail <Int32>] [-TotalCount <Int64>] -LiteralPath <String[]>
 [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_3
```
Get-Content [-Delimiter <string>] [-Encoding] [-Force] [-Raw] [-Stream <string>] [-Wait] [-UseTransaction]
```

## DESCRIPTION
The Get-Content cmdlet gets the content of the item at the location specified by the path, such as the text in a file.
It reads the content one line at a time and returns a collection of objects , each of which represents a line of content.

Beginning in Windows PowerShell 3.0, Get-Content can also get a specified number of lines from the beginning or end of an item.

In file system drives, you can use the the Get-Content cmdlet to get content that you display at the command line, save in a variable for processing, or write to another file.
It is not valid on folders.

Note: This custom cmdlet help file explains how the Get-Content cmdlet works in a file system drive.
For information about the Get-Content cmdlet in all drives, type "Get-Help Get-Content -Path $null" or see Get-Content at http://go.microsoft.com/fwlink/?LinkID=113310.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Content -Path C:\Chapters\chapter1.txt
```

Description

-----------

This command gets the content of the Chapter1.txt file and displays it in the console.
It uses the Path parameter to specify the name of the item. 

Get-Content actually passes the content down the pipeline, but because there are no other cmdlets in the pipeline, Windows PowerShell formats the contents and displays it in the console.

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Content C:\Logs\Log060912.txt -TotalCount 50 | Set-Content Sample.txt
```

Description

-----------

This command gets the first 50 lines of the Log060912.txt file and stores them in the sample.txt file. 

The command uses the Get-Content cmdlet to get the text in the file.
(The name of Path parameter, which is optional, is omitted.) The TotalCount parameter limits the retrieval to the first 50 lines.
The pipeline operator (|) sends the result to Set-Content, which places it in the sample.txt file.

### -------------------------- EXAMPLE 3 --------------------------
```
(Get-Content Cmdlets.txt -TotalCount 5)[-1]
```

Description

-----------

This command gets the fifth line of the Cmdlets.txt text file.
It uses the TotalCount parameter to get the first five lines and then uses array notation to get the last line (indicated by "-1") of the resulting set.

### -------------------------- EXAMPLE 4 --------------------------
```
Get-Content .\DataSets\*.csv -Delimiter "*---*" -Force -Encoding UTF8
```

Description

-----------

This command gets the contents of all CSV files in the DataSets subdirectory.
It uses the Force parameter to get all files, including hidden files, and the Encoding parameter to specify the file encoding. 

The command also uses the Delimiter parameter to divide the returned content into sets,  each of which ends at the CSV file row that contains the "*----*" marker.

### -------------------------- EXAMPLE 5 --------------------------
```
Get-Content .\Copy-Scripts.ps1 -Stream Zone.Identifier

[ZoneTransfer]
ZoneId=3
```

Description

-----------

This command uses the Stream parameter to get the content of the Zone.Identifier alternate data stream.
The output includes Zone ID value of 3, which represents the Internet.

The Stream parameter is introduced in Windows PowerShell 3.0.

### -------------------------- EXAMPLE 6 --------------------------
```
$Manifest = (Get-Module -List PSScheduledJob).Path

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

Description

-----------

The commands in this example get the contents of a module manifest file (.psd1) as a hash table.
The manifest file contains a hash table, but if you get the contents without the Raw dynamic parameter, it is returned as an array of newline-delimited strings.

The Raw dynamic parameter is introduced in Windows PowerShell 3.0.

The first command uses the Path property of modules to get the path to the file that contains the module manifest for the PSScheduledJob module.
It saves the path in the $Manifest variable.

The second command uses the Invoke-Expression cmdlet to run a Get-Content command and the Raw dynamic parameter of the Get-Content cmdlet to get the contents of the module manifest file in a single string.
The command saves the hash table in the $Hash variable.

The third command gets the hash table in the Hash variable.
The contents is returned as a collection of name-value pairs.

The fourth command uses the ModuleToProcess property of the hash table to get the value of the ModuleToProcess key in the module manifest.

### -------------------------- EXAMPLE 7 --------------------------
```
$a = Get-Content -Path .\Download.zip -Encoding Byte -ReadCount 0

Set-Content -Path \\Server\Share\Download.zip -Encoding Byte -Value $a


$b = Get-Content -Path .\Download.zip -Encoding Byte
Set-Content -Path \\Server\Share\Download.zip -Encoding Byte -Value $b

Set-Content : Cannot proceed with byte encoding. When using byte encoding the content must be of type byte.
At line:1 char:1
+ Set-Content \\Server\Share\Download.zip -Encoding Byte -Value $b 
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Set-Content], PSArgumentException
    + FullyQualifiedErrorId : Argument,Microsoft.PowerShell.Commands.SetContentCommand
```

Description

-----------

This example shows how to use the ReadCount parameter of the Get-Content cmdlet with a value of 0 to avoid byte-related errors when using the Set-Content cmdlet to write the bytes to a file.

When getting the content of a file in bytes, Get-Content creates an object (PSObject) for the bytes in each read operation.
If you read the bytes one at a time, which is the default, Get-Content creates an object for each byte.
The objects cause errors when you use the Set-Content cmdlet to write the bytes to a file.

The first command uses the Get-Content cmdlet to get the contents of the Download.zip file and save it in the $a variable.
The command uses the Encoding dynamic parameter with a value of Byte.
It also uses the ReadCount parameter with a value of 0, which directs Get-Content to get the file contents in a single read operation.
The default value of the ReadCount parameter, 1, gets one byte at a time.

The second command uses the Set-Content cmdlet to write the bytes in the $a variable to the Download.zip file on a file share.
The command succeeds.

The third and fourth commands show the same sequence without the ReadCount parameter. 

The third command uses the Encoding dynamic parameter of the Get-Content cmdlet to get the contents of the Download.zip file and save it in the $b variable.
Because the command omits the ReadCount parameter, it uses the default value of 1.

The fourth command uses the Set-Content cmdlet to write the bytes in the $b variable to the Download.zip file on a file share.
Because the content is a collection of objects, rather than a single object that contains a byte array, the command fails.

## PARAMETERS

### -Encoding
Specifies the file encoding.
The default is ASCII.

Valid values are:

-- ASCII:  Uses the encoding for the ASCII (7-bit) character set.
-- BigEndianUnicode:  Encodes in UTF-16 format using the big-endian byte order.
-- Byte:   Encodes a set of characters into a sequence of bytes.
-- String:  Uses the encoding type for a string.
-- Unicode:  Encodes in UTF-16 format using the little-endian byte order.
-- UTF7:   Encodes in UTF-7 format.
-- UTF8:  Encodes in UTF-8 format.
-- Unknown:  The encoding type is unknown or invalid.
The data can be treated as binary.

Encoding is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet.
This parameter works only in file system drives.

When reading from and writing to binary files, use a value of Byte for the Encoding dynamic parameter and a value of 0 for the ReadCount parameter. 
A ReadCount value of 0 reads the entire file in a single read operation and converts it into a single object (PSObject). 
The default ReadCount value, 1, reads one byte in each read operation and converts each byte into a separate object, which causes errors when you use the Set-Content cmdlet to write the bytes to a file.
For more information, see the examples.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
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

You can use this parameter to split a large file into smaller files by specifying a file separator, such as "End of Example", as the delimiter.
The delimiter is preserved (not discarded) and becomes the last item in each file section.

Delimiter is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet.
This parameter works only in file system drives.

Troubleshooting Note: Currently, when the value of the Delimiter parameter is an empty string, Get-Content does not return anything.
This is a known issue.
To force Get-Content to return the entire file as a single, undelimited string, enter a value that does not exist in the file.

```yaml
Type: string
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: End-of-line character
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Gets the contents of all files, including hidden files.
By default, Get-Content does not get the contents of hidden files unless you specify the hidden file by name.

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
Ignores newline characters and returns the entire contents of a file in one string.
By default, the contents of a file is returned as a array of strings that is delimited by the newline character.

Raw is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet.
This parameter works only in file system drives.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: switch
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait
Waits for the cmdlet to get the content before returning the command prompt.
While waiting, Get-Content checks the file once each second until you interrupt it, such as by pressing CTRL+C.

Wait is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet.
This parameter works only in file system drives.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream
Gets the contents of the specified alternate NTFS file stream from the file.
Enter the stream name.
Wildcards are not supported. 

Stream is a dynamic parameter that the FileSystem provider adds to the Get-Content cmdlet.
This parameter works only in file system drives.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: string
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: 
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
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

This parameter is not supported by any providers that are installed with Windows PowerShell.

```yaml
Type: PSCredential
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude
Omits the specified items.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: 
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include
Gets only the specified items.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath
Specifies the path to an item.
Unlike Path, the value of LiteralPath is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the path to an item.
Get-Content gets the content of the item.
Wildcards are permitted.
The parameter name ("Path" or "FilePath") is optional.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -ReadCount
Specifies how many lines of content are sent through the pipeline at a time.
The default value is 1.
A value of 0 (zero) sends all of the content at one time.

This parameter does not change the content displayed, but it does affect the time it takes to display the content.
As the value of ReadCount increases, the time it takes to return the first line increases, but the total time for the operation decreases.
This can make a perceptible difference in very large items.

```yaml
Type: Int64
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: Last

Required: False
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### System.Int64, System.String[], System.Management.Automation.PSCredential
You can pipe the read count, total count, paths, or credentials to Get-Content.

## OUTPUTS

### System.Object, System.String
Get-Content returns objects that represent the content that it gets.
The object type depends on the content type.
If you use the Stream parameter, the cmdlet returns the alternate data stream contents as a string.

## NOTES
* The Get-Content cmdlet is designed to work with the data exposed by any provider. To get the providers in your session, use the Get-PsProvider cmdlet. For more information, see about_Providers (http://go.microsoft.com/fwlink/?LinkID=113250).

*

## RELATED LINKS

[Get-Content (generic); http://go.microsoft.com/fwlink/?LinkID=113310]()

[FileSystem Provider]()

[Clear-Content]()

[Get-Content]()

[Get-ChildItem]()

[Get-Content]()

[Get-Item]()

[Remove-Item]()

[Set-Content]()

[Test-Path]()

