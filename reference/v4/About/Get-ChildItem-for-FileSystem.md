---
title: Get-ChildItem for FileSystem
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e41726fc-44e6-445f-a47a-8201f1affc6e
---
# Get-ChildItem for FileSystem
Gets the files and folders in a file system drive.  
  
## Syntax  
  
```  
Get-ChildItem [-Attributes <FileAttributes]>] [-Directory] [-File] [-Force] [-Hidden] [-ReadOnly] [-System] [-UseTransaction] [<CommonParameters>]  
  
```  
  
## Description  
 In a file system drive, the [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190) cmdlet gets the directories, subdirectories, and files. In a file system directory, it gets subdirectories and files.  
  
 By [default](../Topic/default.md), [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190) gets non\-hidden items, but you can use the Directory, File, Hidden, ReadOnly, and System parameters to get only items with these attributes. To create a complex attribute search, use the Attributes parameter. If you use these parameters, [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190) gets only the items that meet all search conditions, as though the parameters were connected by an AND operator.  
  
 Note: This custom cmdlet help file explains how the [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190) cmdlet works in a file system drive. For information about the [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190) cmdlet in all drives, type "[Get\-Help&#91;PSITPro4\_Core&#93;](assetId:///1f46eeb4-49d7-4bec-bb29-395d9b42f54a)[Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190) \-Path $null" or see [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190) at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113308.  
  
## Parameters  
  
### \-Attributes \<FileAttributes\]\>  
 Gets files and folders with the specified attributes. This parameter supports all attributes and lets you specify complex combinations of attributes.  
  
 For example, to get non\-system files \(not directories\) that are encrypted or compressed, type:  
  
 [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190) \-Attributes \!Directory\+\!System\+Encrypted, \!Directory\+\!System\+Compressed  
  
 To find files and folders with commonly used attributes, you can use the Attributes parameter, or the Directory, File, Hidden, ReadOnly, and System switch parameters.  
  
 The Attributes parameter supports the following attributes: Archive, Compressed, Device, Directory, Encrypted, Hidden, Normal, NotContentIndexed, Offline, ReadOnly, ReparsePoint, SparseFile, System, and Temporary. For a description of these attributes, see the FileAttributes enumeration at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=201508.  
  
 Use the following operators to combine attributes.  
  
 \!    NOT  
  
 \+    AND  
  
 ,      OR  
  
 No spaces are permitted between an operator and its attribute. However, spaces are permitted before commas.  
  
 You can use the following abbreviations for commonly used attributes:  
  
 D    Directory  
  
 H    Hidden  
  
 R    Read\-only  
  
 S     System  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Directory  
 Gets directories \(folders\).  
  
 To get only directories, use the Directory parameter and omit the File parameter. To exclude directories, use the File parameter and omit the Directory parameter, or use the Attributes parameter.  
  
 To get directories, use the Directory parameter, its "ad" alias, or the Directory attribute of the Attributes parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|None|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-File  
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
  
### \-Hidden  
 Gets only hidden files and directories \(folders\).  By [default](../Topic/default.md), [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190) gets only non\-hidden items, but you can use the Force parameter to include hidden items in the results.  
  
 To get only hidden items, use the Hidden parameter, its "h" or "ah" aliases, or the Hidden value of the Attributes parameter. To exclude hidden items, omit the Hidden parameter or use the Attributes parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-ReadOnly  
 Gets only read\-only files and directories \(folders\).  
  
 To get only read\-only items, use the ReadOnly parameter, its "ar" alias, or the ReadOnly value of the Attributes parameter. To exclude read\-only items, use the Attributes parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-System  
 Gets only system files and directories \(folders\).  
  
 To get only system files and folders, use the System parameter, its "as" alias, or the System value of the Attributes parameter. To exclude system files and folders, use the Attributes parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Force  
 Gets hidden files and folders. By [default](../Topic/default.md), hidden files and folder are excluded. You can also get hidden files and folders by using the Hidden parameter or the Hidden value of the Attributes parameter.  
  
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
|Inputs|System.String\[\]<br /><br /> You can pipe a file system path \(in quotation marks\) to Get\-ChildItem.|  
|Outputs|System.IO.DirectoryInfo, System.IO.FileInfo, System.String|  
  
## Notes  
 The Attributes, Directory, File, Hidden, ReadOnly, and System parameters were introduced in Windows PowerShell 3.0 and  
  
 are effective only in file system drives.  
  
 Get\-ChildItem Alias Reference:  
  
 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
  
 Get\-ChildItem     dir  
  
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
 [FileSystem Provider](../Topic/FileSystem-Provider.md)   
 [Clear\-Content&#91;PSITPro4\_Management&#93;](assetId:///dee5f65f-eae2-42de-b369-5bed1a38ac21)   
 [Get\-Content&#91;PSITPro4\_Management&#93;](assetId:///4d594e54-2c28-4052-b3f8-1c27ea724561)   
 [Get\-ChildItem&#91;PSITPro4\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190)   
 [Get\-Content&#91;PSITPro4\_Management&#93;](assetId:///4d594e54-2c28-4052-b3f8-1c27ea724561)   
 [Get\-Item&#91;PSITPro4\_Management&#93;](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa)   
 [Remove\-Item&#91;PSITPro4\_Management&#93;](assetId:///0fe3ff11-a1f7-43b9-8c85-f92d52641395)   
 [Set\-Content&#91;PSITPro4\_Management&#93;](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2)   
 [Test\-Path&#91;PSITPro4\_Management&#93;](assetId:///2e9df935-45e8-44ba-a66a-2de2dd61f3f5)