---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Add-Content for FileSystem
---

# Add-Content for FileSystem
Appends content, such as words or data, to a file.  
  
## Syntax  
  
```  
Add-Content [-Encoding {<Unknown> | <String> | <Unicode> | <Byte> | <BigEndianUnicode> | <UTF8> | <UTF7> | <UTF32> | <Ascii> | <Default> | <Oem>}] [-Force] [-Stream <string>] [-Confirm] [-WhatIf] [-UseTransaction] [<CommonParameters>]  
  
```  
  
## Description  
 In file system drives, the [Add-Content](../../../Microsoft.PowerShell.Management/Add-Content.md) cmdlet appends the content you specify to the end of a file. This cmdlet is not valid on folders.  
  
 Note: This custom cmdlet help file explains how the [Add-Content](../../../Microsoft.PowerShell.Management/Add-Content.md) cmdlet works in a file system drive. For information about the [Add-Content](../../../Microsoft.PowerShell.Management/Add-Content.md) cmdlet in all drives, type "[Get-Help](../../Get-Help.md)[Add-Content](../../../Microsoft.PowerShell.Management/Add-Content.md) -Path $null" or see [Add-Content](../../../Microsoft.PowerShell.Management/Add-Content.md) at http://go.microsoft.com/fwlink/?LinkID=113278.  
  
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
  
 Encoding is a dynamic parameter that the FileSystem provider adds to the [Add-Content](../../../Microsoft.PowerShell.Management/Add-Content.md) cmdlet. This parameter works only in file system drives.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|ASCII|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Force  
 Adds contents to files even if they are read-only. Without this parameter, read-only files are not affected.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|False|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### -Stream <string\>  
 Adds the content to the specified alternate data stream. If the stream does not yet, exist, [Add-Content](../../../Microsoft.PowerShell.Management/Add-Content.md) creates it. Enter the stream name. Wildcards are not supported.  
  
 Stream is a dynamic parameter that the FileSystem provider adds to the [Add-Content](../../../Microsoft.PowerShell.Management/Add-Content.md) cmdlet. This parameter works only in file system drives.  
  
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
|Inputs|Sytem.Object[], System.String[], System.Management.Automation.PSCredential<br /><br /> You can pipe the value (object), a path, or a credential object to Add-Contnet.|  
|Outputs|None or System.String<br /><br /> When you use the Passthru parameter, Add-Content generates a System.String object representing the content. Otherwise, this cmdlet does not generate any output.|  
  
## Example 1  
  
```  
C:\PS>Add-Content -Path *.txt -Exclude help* -Value "END"  
  
Description  
-----------  
This command adds "END" to all text files in the current directory, except for those with file names that begin with "help."  
  
```  
  
## Example 2  
  
```  
C:\PS>Add-Content -Path file1.log, file2.log -Value (get-date) -PassThru  
  
Description  
-----------  
This command adds the date to the end of the File1.log and File2.log files and then displays the date at the command line.   
  
The command uses the Get-Date cmdlet to get the date, and it uses the Value parameter to pass the date to Add-Content. The PassThru parameter sends the added content through the pipeline. Because there is no other cmdlet to receive the passed content, it is displayed at the command line.  
  
```  
  
## Example 3  
  
```  
C:\PS>Add-Content -Path monthly.txt -Value (Get-Content c:\rec1\weekly.txt)  
  
Description  
-----------  
This command adds the contents of the Weekly.txt file to the end of the Monthly.txt file. It uses the Get-Content cmdlet to get the contents of the Weekly.txt file, and it uses the Value parameter to pass the content of weekly.txt to Add-Content. The parentheses ensure that the Get-Content command is complete before the Add-Content command begins.  
  
You can also copy the content of Weekly.txt to a variable, such as $w, and then use the Value parameter to pass the variable to Add-Content. In that case, the command would be "add-content -path monthly.txt -value $w".  
  
```  
  
## Example 4  
  
```  
C:\PS>Add-Content -Value (Get-Content test.log) -Path C:\tests\test134\logs\test134.log  
  
Description  
-----------  
This command creates a new directory and file and copies the content of an existing file to the newly created file.  
  
This command uses the Add-Content cmdlet to add the content. The value of the Value parameter is a Get-Content command that gets content from an existing file, Test.log.   
  
The value of the path parameter is a path that does not exist when the command runs. In this example, only the C:\Tests directories exist. The command creates the remaining directories and the Test134.log file.  
  
The Force parameter is not required for this command. Add-Content creates directories to complete a path even without the Force parameter.  
  
```  
  
## Example 5  
  
```  
C:\PS>Get-Content test.xml | Add-Content final.xml -Force -Encoding UTF8  
  
Description  
-----------  
This command appends the contents of the final.xml file to the contents of the test.xml file.   
  
The command uses the Force parameter so that the command is successful even if the Final.xml file is read-only. It uses the Encoding parameter to specify an encoding of UTF-8.  
  
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

