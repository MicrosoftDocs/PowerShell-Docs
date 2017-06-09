---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Get-Content for FileSystem
---

# Get-Content for FileSystem
Gets the contents of a file.  
  
## Syntax  
  
```  
Get-Content [-Delimiter <string>] [-Encoding {<Unknown> | <String> | <Unicode> | <Byte> | <BigEndianUnicode> | <UTF8> | <UTF7> | <UTF32> | <Ascii> | <Default> | <Oem>}] [-Force] [-Raw <switch>] [-Stream <string>] [-Wait] [-UseTransaction] [<CommonParameters>]  
  
```  
  
## Description  
 In file system drives, you can use the [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) cmdlet to get content that you display at the command line, save in a variable for processing, or write to another file. It is not valid on folders.  
  
 Note: This custom cmdlet help file explains how the [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) cmdlet works in a file system drive. For information about the [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) cmdlet in all drives, type "[Get-Help](../../Get-Help.md)[Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) -Path $null" or see [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) at http://go.microsoft.com/fwlink/?LinkID=113310.  
  
## Parameters  
  
### -Encoding <FileSystemCmdletProviderEncoding\>  
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
  
 Encoding is a dynamic parameter that the FileSystem provider adds to the [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) cmdlet. This parameter works only in file system drives.  
  
 When reading from and writing to binary files, use a value of Byte for the Encoding dynamic parameter and a value of 0 for the ReadCount parameter.  A ReadCount value of 0 reads the entire file in a single read operation and converts it into a single object (PSObject).  The default ReadCount value, 1, reads one byte in each read operation and converts each byte into a separate object, which causes errors when you use the [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) cmdlet to write the bytes to a file. For more information, see the examples.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|ASCII|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Delimiter <string\>  
 Specifies the delimiter that [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) uses to divide the file into objects while it reads.  
  
 The default is "\n", the end-of-line character.  
  
 Therefore, by default, when reading a text file, [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) returns a collection of string objects, each of which ends with an end-of-line character.  
  
 When you enter a delimiter that does not exist in the file, [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) returns the entire file as a single, undelimited object.  
  
 You can use this parameter to split a large file into smaller files by specifying a file separator, such as "End of Example", as the delimiter. The delimiter is preserved (not discarded) and becomes the last item in each file section.  
  
 Delimiter is a dynamic parameter that the FileSystem provider adds to the [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) cmdlet. This parameter works only in file system drives.  
  
 Troubleshooting Note: Currently, when the value of the Delimiter parameter is an empty string, [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) does not return anything. This is a known issue. To force [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) to return the entire file as a single, undelimited string, enter a value that does not exist in the file.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|End-of-line character|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Force  
 Gets the contents of all files, including hidden files. By default, [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) does not get the contents of hidden files unless you specify the hidden file by name.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|False|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Raw <switch\>  
 Ignores newline characters and returns the entire contents of a file in one string. By default, the contents of a file is returned as a array of strings that is delimited by the newline character.  
  
 Raw is a dynamic parameter that the FileSystem provider adds to the [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) cmdlet. This parameter works only in file system drives.  
  
 This parameter is introduced in Windows PowerShell 3.0.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Wait  
 Waits for the cmdlet to get the content before returning the command prompt. While waiting, [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) checks the file once each second until you interrupt it, such as by pressing CTRL+C.  
  
 Wait is a dynamic parameter that the FileSystem provider adds to the [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) cmdlet. This parameter works only in file system drives.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|False|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Stream <string\>  
 Gets the contents of the specified alternate NTFS file stream from the file. Enter the stream name. Wildcards are not supported.  
  
 Stream is a dynamic parameter that the FileSystem provider adds to the [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md) cmdlet. This parameter works only in file system drives.  
  
 This parameter is introduced in Windows PowerShell 3.0.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -UseTransaction  
 Includes the command in the active transaction. This parameter is valid only when a transaction is in progress. For more information, see [about_Transactions](../../About/about_Transactions.md).  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### <CommonParameters\>  
 This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, -OutVariable,  -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../../About/about_CommonParameters.md).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|System.Int64, System.String[], System.Management.Automation.PSCredential<br /><br /> You can pipe the read count, total count, paths, or credentials to Get-Content.|  
|Outputs|System.Object, System.String<br /><br /> Get-Content returns objects that represent the content that it gets. The object type depends on the content type. If you use the Stream parameter, the cmdlet returns the alternate data stream contents as a string.|  
  
## Example 1  
  
```  
C:\PS>Get-Content -Path C:\Chapters\chapter1.txt  
  
Description  
-----------  
This command gets the content of the Chapter1.txt file and displays it in the console. It uses the Path parameter to specify the name of the item.   
  
Get-Content actually passes the content down the pipeline, but because there are no other cmdlets in the pipeline, Windows PowerShell formats the contents and displays it in the console.  
  
```  
  
## Example 2  
  
```  
C:\PS>Get-Content C:\Logs\Log060912.txt -TotalCount 50 | Set-Content Sample.txt  
  
Description  
-----------  
This command gets the first 50 lines of the Log060912.txt file and stores them in the sample.txt file.   
  
The command uses the Get-Content cmdlet to get the text in the file. (The name of Path parameter, which is optional, is omitted.) The TotalCount parameter limits the retrieval to the first 50 lines. The pipeline operator (|) sends the result to Set-Content, which places it in the sample.txt file.  
  
```  
  
## Example 3  
  
```  
C:\PS>(Get-Content Cmdlets.txt -TotalCount 5)[-1]  
  
Description  
-----------  
This command gets the fifth line of the Cmdlets.txt text file. It uses the TotalCount parameter to get the first five lines and then uses array notation to get the last line (indicated by "-1") of the resulting set.  
  
```  
  
## Example 4  
  
```  
C:\PS>Get-Content .\DataSets\*.csv -Delimiter "*---*" -Force -Encoding UTF8  
  
Description  
-----------  
This command gets the contents of all CSV files in the DataSets subdirectory. It uses the Force parameter to get all files, including hidden files, and the Encoding parameter to specify the file encoding.   
  
The command also uses the Delimiter parameter to divide the returned content into sets,  each of which ends at the CSV file row that contains the "*----*" marker.  
  
```  
  
## Example 5  
  
```  
C:\PS>Get-Content .\Copy-Scripts.ps1 -Stream Zone.Identifier  
  
[ZoneTransfer]  
ZoneId=3  
  
Description  
-----------  
This command uses the Stream parameter to get the content of the Zone.Identifier alternate data stream. The output includes Zone ID value of 3, which represents the Internet.  
  
The Stream parameter is introduced in Windows PowerShell 3.0.  
  
```  
  
## Example 6  
  
```  
C:\PS>$Manifest = (Get-Module -List PSScheduledJob).Path  
  
C:\PS>$Hash = Invoke-Expression (Get-Content $Manifest -Raw)  
  
C:\PS>$Hash  
  
Name                           Value  
----                           -----  
Copyright                      ? Microsoft Corporation. All rights reserved.  
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
  
Description  
-----------  
The commands in this example get the contents of a module manifest file (.psd1) as a hash table. The manifest file contains a hash table, but if you get the contents without the Raw dynamic parameter, it is returned as an array of newline-delimited strings.  
  
The Raw dynamic parameter is introduced in Windows PowerShell 3.0.  
  
The first command uses the Path property of modules to get the path to the file that contains the module manifest for the PSScheduledJob module. It saves the path in the $Manifest variable.  
  
The second command uses the Invoke-Expression cmdlet to run a Get-Content command and the Raw dynamic parameter of the Get-Content cmdlet to get the contents of the module manifest file in a single string. The command saves the hash table in the $Hash variable.  
  
The third command gets the hash table in the Hash variable. The contents is returned as a collection of name-value pairs.  
  
The fourth command uses the ModuleToProcess property of the hash table to get the value of the ModuleToProcess key in the module manifest.  
  
```  
  
## Example 7  
  
```  
C:\PS>$a = Get-Content -Path .\Download.zip -Encoding Byte -ReadCount 0  
  
Set-Content -Path \\Server\Share\Download.zip -Encoding Byte -Value $a  
  
$b = Get-Content -Path .\Download.zip -Encoding Byte  
Set-Content -Path \\Server\Share\Download.zip -Encoding Byte -Value $b  
  
Set-Content : Cannot proceed with byte encoding. When using byte encoding the content must be of type byte.  
At line:1 char:1  
+ Set-Content \\Server\Share\Download.zip -Encoding Byte -Value $b   
+ [!INCLUDE[]()][!INCLUDE[]()][!INCLUDE[]()]~~~~~  
    + CategoryInfo          : InvalidArgument: (:) [Set-Content], PSArgumentException  
    + FullyQualifiedErrorId : Argument,Microsoft.PowerShell.Commands.SetContentCommand  
  
Description  
-----------  
This example shows how to use the ReadCount parameter of the Get-Content cmdlet with a value of 0 to avoid byte-related errors when using the Set-Content cmdlet to write the bytes to a file.  
  
When getting the content of a file in bytes, Get-Content creates an object (PSObject) for the bytes in each read operation. If you read the bytes one at a time, which is the default, Get-Content creates an object for each byte. The objects cause errors when you use the Set-Content cmdlet to write the bytes to a file.  
  
The first command uses the Get-Content cmdlet to get the contents of the Download.zip file and save it in the $a variable. The command uses the Encoding dynamic parameter with a value of Byte. It also uses the ReadCount parameter with a value of 0, which directs Get-Content to get the file contents in a single read operation. The default value of the ReadCount parameter, 1, gets one byte at a time.  
  
The second command uses the Set-Content cmdlet to write the bytes in the $a variable to the Download.zip file on a file share. The command succeeds.  
  
The third and fourth commands show the same sequence without the ReadCount parameter.   
  
The third command uses the Encoding dynamic parameter of the Get-Content cmdlet to get the contents of the Download.zip file and save it in the $b variable. Because the command omits the ReadCount parameter, it uses the default value of 1.  
  
The fourth command uses the Set-Content cmdlet to write the bytes in the $b variable to the Download.zip file on a file share. Because the content is a collection of objects, rather than a single object that contains a byte array, the command fails.  
  
```  
  
## See Also  
 [FileSystem Provider](../FileSystem-Provider.md)   
 [Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md)   
 [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md)   
 [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md)   
 [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md)   
 [Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md)   
 [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md)   
 [Test-Path](../../../Microsoft.PowerShell.Management/Test-Path.md)

