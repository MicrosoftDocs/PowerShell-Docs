---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Set-Content for FileSystem
---

# Set-Content for FileSystem
Replaces the contents of a file with contents that you specify.  
  
## Syntax  
  
```  
Set-Content [-Encoding {<Unknown> | <String> | <Unicode> | <Byte> | <BigEndianUnicode> | <UTF8> | <UTF7> | <UTF32> | <Ascii> | <Default> | <Oem>}] [-Force] [-Stream <string>] [-Confirm] [-WhatIf] [-UseTransaction] [<CommonParameters>]  
  
```  
  
## Description  
 In file system drives, the [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) cmdlet overwrites or replaces the content of one or more files with the content that you specify. This cmdlet is not valid on folders.  
  
 Note: This custom cmdlet help file explains how the [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) cmdlet works in a file system drive. For information about the [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) cmdlet in all drives, type "[Get-Help](../../Get-Help.md)[Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) -Path $null" or see [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) at http://go.microsoft.com/fwlink/?LinkID=113392.  
  
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
  
 Encoding is a dynamic parameter that the FileSystem provider adds to the [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) cmdlet. This parameter works only in file system drives.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|ASCII|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Force  
 Replaces the contents of a file, even if the file is read-only. Without this parameter, read-only files are not changed.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Stream <string\>  
 Creates or replaces the content in the specified alternate data stream. If the stream does not yet exist, [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) creates it. Enter the stream name. Wildcards are not supported.  
  
 Stream is a dynamic parameter that the FileSystem provider adds to the [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) cmdlet. This parameter works only in file system drives.  
  
 You can use the [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) cmdlet to change the content of the Zone.Identifier alternate data stream. However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the Unblock-File cmdlet.  
  
 This parameter is introduced in Windows PowerShell 3.0.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Confirm  
 Prompts you for confirmation before executing the command.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -WhatIf  
 Describes what would happen if you executed the command without actually executing the command.  
  
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
|Inputs|System.Object[], System.String[], System.Management.Automation.PSCredential<br /><br /> You can pipe a value (object), a path, or a credential object to Set-Content|  
|Outputs|None or System.String<br /><br /> When you use the Passthru parameter, Set-Content generates a System.String object representing the content. Otherwise, this cmdlet does not generate any output.|  
  
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
 [FileSystem Provider](../FileSystem-Provider.md)   
 [Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md)   
 [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md)   
 [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md)   
 [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md)   
 [Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md)   
 [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md)   
 [Test-Path](../../../Microsoft.PowerShell.Management/Test-Path.md)

