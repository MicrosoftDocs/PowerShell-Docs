---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Get-ChildItem for FileSystem
online version:  http://go.microsoft.com/fwlink/?LinkId=834950
---

# Get-ChildItem for FileSystem
Gets the files and folders in a file system drive.  

## Syntax  

```  
Get-ChildItem [-Attributes <FileAttributes]>] [-Directory] [-File] [-Force] [-Hidden] [-ReadOnly] [-System] [-UseTransaction] [<CommonParameters>]  

```  

## Description  
 In a file system drive, the [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet gets the directories, subdirectories, and files. In a file system directory, it gets subdirectories and files.  

 By default, [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md) gets non-hidden items, but you can use the Directory, File, Hidden, ReadOnly, and System parameters to get only items with these attributes. To create a complex attribute search, use the Attributes parameter. If you use these parameters, [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md) gets only the items that meet all search conditions, as though the parameters were connected by an AND operator.  

 Note: This custom cmdlet help file explains how the [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet works in a file system drive. For information about the [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet in all drives, type "[Get-Help](../../Get-Help.md)[Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md) -Path $null" or see [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md) at http://go.microsoft.com/fwlink/?LinkID=113308.  

## Parameters  

### -Attributes <FileAttributes]>  
 Gets files and folders with the specified attributes. This parameter supports all attributes and lets you specify complex combinations of attributes.  

 For example, to get non-system files (not directories) that are encrypted or compressed, type:  

 [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md) -Attributes !Directory+!System+Encrypted, !Directory+!System+Compressed  

 To find files and folders with commonly used attributes, you can use the Attributes parameter, or the Directory, File, Hidden, ReadOnly, and System switch parameters.  

 The Attributes parameter supports the following attributes: Archive, Compressed, Device, Directory, Encrypted, Hidden, Normal, NotContentIndexed, Offline, ReadOnly, ReparsePoint, SparseFile, System, and Temporary. For a description of these attributes, see the FileAttributes enumeration at http://go.microsoft.com/fwlink/?LinkId=201508.  

 Use the following operators to combine attributes.  

 !    NOT  

 \+    AND  

 ,      OR  

 No spaces are permitted between an operator and its attribute. However, spaces are permitted before commas.  

 You can use the following abbreviations for commonly used attributes:  

 D    Directory  

 H    Hidden  

 R    Read-only  

 S     System  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -Directory  
 Gets directories (folders).  

 To get only directories, use the Directory parameter and omit the File parameter. To exclude directories, use the File parameter and omit the Directory parameter, or use the Attributes parameter.  

 To get directories, use the Directory parameter, its "ad" alias, or the Directory attribute of the Attributes parameter.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|None|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -File  
 Gets files.  

 To get only files, use the File parameter and omit the Directory parameter. To exclude files, use the Directory parameter and omit the File parameter, or use the Attributes parameter.  

 To get files, use the File parameter, its "af" alias, or the File value of the Attributes parameter.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -Hidden  
 Gets only hidden files and directories (folders).  By default, [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md) gets only non-hidden items, but you can use the Force parameter to include hidden items in the results.  

 To get only hidden items, use the Hidden parameter, its "h" or "ah" aliases, or the Hidden value of the Attributes parameter. To exclude hidden items, omit the Hidden parameter or use the Attributes parameter.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -ReadOnly  
 Gets only read-only files and directories (folders).  

 To get only read-only items, use the ReadOnly parameter, its "ar" alias, or the ReadOnly value of the Attributes parameter. To exclude read-only items, use the Attributes parameter.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -System  
 Gets only system files and directories (folders).  

 To get only system files and folders, use the System parameter, its "as" alias, or the System value of the Attributes parameter. To exclude system files and folders, use the Attributes parameter.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -Force  
 Gets hidden files and folders. By default, hidden files and folder are excluded. You can also get hidden files and folders by using the Hidden parameter or the Hidden value of the Attributes parameter.  

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
|Inputs|System.String[]<br /><br /> You can pipe a file system path (in quotation marks) to Get-ChildItem.|  
|Outputs|System.IO.DirectoryInfo, System.IO.FileInfo, System.String|  

## Notes  
 The Attributes, Directory, File, Hidden, ReadOnly, and System parameters were introduced in Windows PowerShell 3.0 and  

 are effective only in file system drives.  

 Get-ChildItem Alias Reference:  

 --------------------------------\-  

 Get-ChildItem     dir  

 Directory         d, ad  

 File              af  

 Hidden            h, ah  

 ReadOnly          ar  

 System            as  

## Example 1  

```  
C:\PS>Get-ChildItem  

Description  
-----------  
This command gets the files and subdirectories in the current directory. If the current directory does not have child items, the command does not return any results.  

```  

## Example 2  

```  
C:\PS>Get-Childitem -System -File -Recurse  

Description  
-----------  
This command gets system files in the current directory and its subdirectories.  

```  

## Example 3  

```  
C:\PS>Get-ChildItem -Attributes !Directory,!Directory+Hidden  

C:\PS> dir -att !d,!d+h  

Description  
-----------  
These command get all files, including hidden files, in the current directory, but exclude subdirectories. The second command uses aliases and abbreviations, but has the same effect as the first.  

```  

## Example 4  

```  
C:\PS>dir -ad  

Description  
-----------  
This command gets the subdirectories in the current directory. It uses the "dir" alias of the Get-ChildItem cmdlet and the "ad" alias of the Directory parameter.  

```  

## Example 5  

```  
C:\PS>Get-ChildItem -File -Attributes !ReadOnly -path C:\ps-test  

Description  
-----------  
This command gets read-write files in the C:\ps-test directory.  

```  

## Example 6  

```  
C:\PS>get-childitem . -include *.txt -recurse -force  

Description  
-----------  
This command gets all of the .txt files in the current directory and its subdirectories.   

The dot (.) represents the current directory. The Include parameter specifies the file name extension. The Recurse parameter directs Windows PowerShell to search for objects recursively, and it indicates that the subject of the command is the specified directory and its contents. The Force parameter adds hidden files to the display.  

```  

## Example 7  

```  
C:\PS>get-childitem c:\windows\logs\* -include *.txt -exclude A*  

Description  
-----------  
This command gets the .txt files in the Logs subdirectory, except for those whose names start with the letter A. It uses the wildcard character (*) to indicate the contents of the Logs subdirectory, not the directory container. Because the command does not include the Recurse parameter, Get-ChildItem does not include the contents of the current directory automatically; you need to specify it.  

```  

## Example 8  

```  
C:\PS>get-childitem -name  

Description  
-----------  
This command retrieves only the names of items in the current directory.  

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

