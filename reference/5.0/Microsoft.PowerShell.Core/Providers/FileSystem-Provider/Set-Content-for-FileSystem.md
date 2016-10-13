---
title: Set-Content for FileSystem
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b0ccd75b-ae34-40da-89cf-9fd8b37f81ff
---
# Set-Content for FileSystem
Replaces the contents of a file with contents that you specify.  
  
## Syntax  
  
```  
Set-Content [-Encoding {<Unknown> | <String> | <Unicode> | <Byte> | <BigEndianUnicode> | <UTF8> | <UTF7> | <UTF32> | <Ascii> | <Default> | <Oem>}] [-Force] [-Stream <string>] [-Confirm] [-WhatIf] [-UseTransaction] [<CommonParameters>]  
  
```  
  
## Description  
 In file system drives, the [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) cmdlet overwrites or replaces the content of one or more files with the content that you specify. This cmdlet is not valid on folders.  
  
 Note: This custom cmdlet help file explains how the [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) cmdlet works in a file system drive. For information about the [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) cmdlet in all drives, type "[Get\-Help](assetId:///1f46eeb4-49d7-4bec-bb29-395d9b42f54a)[Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) \-Path $null" or see [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113392.  
  
## Parameters  
  
### \-Encoding \<FileSystemCmdletProviderEncoding\>  
 Specifies the file encoding. The default is ASCII.  
  
 Valid values are:  
  
 \-\- ASCII:  Uses the encoding for the ASCII \(7\-bit\) character set.  
  
 \-\- BigEndianUnicode:  Encodes in UTF\-16 format using the big\-endian byte order.  
  
 \-\- Byte:   Encodes a set of characters into a sequence of bytes.  
  
 \-\- String:  Uses the encoding type for a string.  
  
 \-\- Unicode:  Encodes in UTF\-16 format using the little\-endian byte order.  
  
 \-\- UTF7:   Encodes in UTF\-7 format.  
  
 \-\- UTF8:  Encodes in UTF\-8 format.  
  
 \-\- Unknown:  The encoding type is unknown or invalid. The data can be treated as binary.  
  
 Encoding is a dynamic parameter that the FileSystem provider adds to the [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) cmdlet. This parameter works only in file system drives.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|ASCII|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Force  
 Replaces the contents of a file, even if the file is read\-only. Without this parameter, read\-only files are not changed.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Stream \<string\>  
 Creates or replaces the content in the specified alternate data stream. If the stream does not yet exist, [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) creates it. Enter the stream name. Wildcards are not supported.  
  
 Stream is a dynamic parameter that the FileSystem provider adds to the [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) cmdlet. This parameter works only in file system drives.  
  
 You can use the [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) cmdlet to change the content of the Zone.Identifier alternate data stream. However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the Unblock\-File cmdlet.  
  
 This parameter is introduced in Windows PowerShell 3.0.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Confirm  
 Prompts you for confirmation before executing the command.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-WhatIf  
 Describes what would happen if you executed the command without actually executing the command.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-UseTransaction  
 Includes the command in the active transaction. This parameter is valid only when a transaction is in progress. For more information, see [about\_Transactions](../Topic/about_Transactions.md).  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \<CommonParameters\>  
 This cmdlet supports the common parameters: \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, \-OutVariable,  \-Verbose, \-WarningAction, and \-WarningVariable. For more information, see [about\_CommonParameters](../Topic/about_CommonParameters.md).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|System.Object\[\], System.String\[\], System.Management.Automation.PSCredential<br /><br /> You can pipe a value \(object\), a path, or a credential object to Set\-Content|  
|Outputs|None or System.String<br /><br /> When you use the Passthru parameter, Set\-Content generates a System.String object representing the content. Otherwise, this cmdlet does not generate any output.|  
  
## Example 1  
  
```  
C:\PS>Set-Content -Path C:\Test1\test*.txt -Value "Hello, World"  
  
Description  
-----------  
This command replaces the contents of all files in the Test1 directory that have names beginning with "test" with "Hello, World". This example shows how to specify content by typing it in the command.  
  
```  
  
## Example 2  
  
```  
C:\PS>Get-Date | Set-Content C:\Test1\date.csv  
  
Description  
-----------  
This command creates a comma-separated variable-length (csv) file that contains only the current date and time. It uses the Get-Date cmdlet to get the current system date and time. The pipeline operator passes the result to Set-Content, which creates the file and writes the content.  
  
If the Test1 directory does not exist, the command fails, but if the file does not exist, the command will create it.  
  
```  
  
## Example 3  
  
```  
C:\PS>Get-Content Notice.txt | ForEach-Object {$_ -replace "Warning", "Caution"} | Set-Content Notice.txt  
  
Description  
-----------  
This command replaces all instances of "Warning" with "Caution" in the Notice.txt file.   
  
It uses the Get-Content cmdlet to get the content of Notice.txt. The pipeline operator sends the results to the ForEach-Object cmdlet, which applies the expression to each line of content in Get-Content. The expression uses the "$_" symbol to refer to the current item and the Replace parameter to specify the text to be replaced.   
  
Another pipeline operator sends the changed content to Set-Content which replaces the text in Notice.txt with the new content.  
  
The parentheses around the Get-Content command ensure that the Get operation is complete before the Set operation begins. Without them, the command will fail because the two functions will be trying to access the same file.  
  
```  
  
## Example 4  
  
```  
C:\PS>Get-Content test.xml | Set-Content final.xml -Force -Encoding UTF8  
  
Description  
-----------  
This command replaces the contents of the final.xml file with the contents of the test.xml file.   
  
The command uses the Force parameter so that the command is successful even if the Final.xml file is read-only. It uses the Encoding dynamic parameter to specify an encoding of UTF-8.  
  
```  
  
## See Also  
 [FileSystem Provider](../Topic/FileSystem-Provider.md)   
 [Clear\-Content](assetId:///dee5f65f-eae2-42de-b369-5bed1a38ac21)   
 [Get\-Content](assetId:///4d594e54-2c28-4052-b3f8-1c27ea724561)   
 [Get\-ChildItem](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190)   
 [Get\-Content](assetId:///4d594e54-2c28-4052-b3f8-1c27ea724561)   
 [Get\-Item](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa)   
 [Remove\-Item](assetId:///0fe3ff11-a1f7-43b9-8c85-f92d52641395)   
 [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2)   
 [Test\-Path](assetId:///2e9df935-45e8-44ba-a66a-2de2dd61f3f5)