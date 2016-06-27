---
title: Get-Item for FileSystem
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f6c1a5f-b0ee-4d6c-9c04-fbfd470aa7c1
---
# Get-Item for FileSystem
Gets files and folders.  
  
## Syntax  
  
```  
Get-Item [-Stream <string>] [<CommonParameters>]  
  
```  
  
## Description  
 In the file system, the [Get\-Item&#91;PSITPro3\_Management&#93;](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa) cmdlet gets files and folders.  
  
 Note: This custom cmdlet help file explains how the [Get\-Item&#91;PSITPro3\_Management&#93;](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa) cmdlet works in a file system drive. For information about the [Get\-Item&#91;PSITPro3\_Management&#93;](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa) cmdlet in all drives, type "[Get\-Help&#91;PSITPro3\_Core&#93;](assetId:///1f46eeb4-49d7-4bec-bb29-395d9b42f54a)[Get\-Item&#91;PSITPro3\_Management&#93;](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa) \-Path $null" or see [Get\-Item&#91;PSITPro3\_Management&#93;](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa) at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113319.  
  
## Parameters  
  
### \-Stream \<string\>  
 Gets the specified alternate NTFS file stream from the file. Enter the stream name. Wildcards are supported. To get all streams, use an asterisk \(\*\). This parameter is not valid on folders.  
  
 Stream is a dynamic parameter that the FileSystem provider adds to the [Get\-Item&#91;PSITPro3\_Management&#93;](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa) cmdlet. This parameter works only in file system drives.  
  
 This parameter is introduced in Windows PowerShell 3.0.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|No alternate file streams|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \<CommonParameters\>  
 This cmdlet supports the common parameters: \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, \-OutVariable,  \-Verbose, \-WarningAction, and \-WarningVariable. For more information, see [about\_CommonParameters](../Topic/about_CommonParameters.md).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|System.String\[ \]<br /><br /> You can pipe a path to the Get\-Item cmdlet.|  
|Outputs|System.IO.FileInfo, System.IO.DirectoryInfo, Microsoft.PowerShell.Commands.AlternateStreamData<br /><br /> In the file system, Get\-Item returns files and folders. If you use the Stream parameter, it returns AlternateStreamData objects.|  
  
## Example 1  
  
```  
C:\PS>Get-Item C:\Users\User01\Downloads\InternetFile.docx -Stream *  
  
   FileName: C:\Users\User01\Downloads\InternetFile.docx  
  
Stream                   Length  
------                   ------  
:$DATA                    45056  
Zone.Identifier              26  
  
Description  
-----------  
This command gets all stream data from a file that was downloaded from the Internet. The Zone.Identifier stream identifies a file that originated on the Internet. The $DATA stream is the default.  
  
The Stream parameter is introduced in Windows PowerShell 3.0.  
  
```  
  
## Example 2  
  
```  
C:\PS>Get-Item C:\ps-test\* -Stream Zone.Identifier -ErrorAction SilentlyContinue  
  
   FileName: C:\ps-test\Copy-Script.ps1  
  
Stream                   Length  
------                   ------  
Zone.Identifier              26  
  
   FileName: C:\ps-test\Start-ActivityTracker.ps1  
  
Stream                   Length  
------                   ------  
Zone.Identifier              26  
  
Description  
-----------  
This command gets Zone.Identifier stream data from all files in the C:\ps-test directory. The command uses the Stream parameter to specify the alternate stream and he ErrorAction parameter with a value of SilentlyContinue to suppress non-terminating errors that are generated when a file has no alternate data streams.   
  
The Stream parameter is introduced in Windows PowerShell 3.0.  
  
```  
  
## Example 3  
  
```  
C:\PS>Get-Item .  
  
Directory: C:\  
  
Mode                LastWriteTime     Length Name  
----                -------------     ------ ----  
d----         7/26/2006  10:01 AM            ps-test  
  
Description  
-----------  
This command gets the current directory. The dot (.) represents the item at the current location (not its contents).  
  
```  
  
## Example 4  
  
```  
C:\PS>Get-Item *  
  
Directory: C:\ps-test  
  
Mode                LastWriteTime     Length Name  
----                -------------     ------ ----  
d----         7/26/2006   9:29 AM            Logs  
d----         7/26/2006   9:26 AM            Recs  
-a---         7/26/2006   9:28 AM         80 date.csv  
-a---         7/26/2006  10:01 AM         30 filenoext  
-a---         7/26/2006   9:30 AM      11472 process.doc  
-a---         7/14/2006  10:47 AM         30 test.txt  
  
Description  
-----------  
This command gets the current directory of the C: drive. The object that is retrieved represents only the directory, not its contents.  
  
```  
  
## Example 5  
  
```  
C:\PS>Get-Item C:\  
  
Description  
-----------  
This command gets the items in the C: drive. The wildcard character (*) represents all the items in the container, not just the container.  
  
In Windows PowerShell, use a single asterisk (*) to get contents, instead of the traditional "*.*". The format is interpreted literally, so "*.*" would not retrieve directories or file names without a dot.  
  
```  
  
## Example 6  
  
```  
C:\PS>(Get-Item C:\Windows).LastAccessTime  
  
Description  
-----------  
This command gets the LastAccessTime property of the C:\Windows directory. LastAccessTime is just one property of file system directories. To see all of the properties of a directory, type "(Get-Item <directory-name>) | Get-Member".  
  
```  
  
## Example 7  
  
```  
C:\PS>Get-Item C:\Windows\*.* -Exclude w*  
  
Description  
-----------  
This command gets items in the Windows directory with names that include a dot (.), but do not begin with w*. This command works only when the path includes a wildcard character (*) to specify the contents of the item.  
  
```  
  
## See Also  
 [FileSystem Provider](../Topic/FileSystem-Provider.md)   
 [Add\-Content&#91;PSITPro3\_Management&#93;](assetId:///fcff151c-88d1-4b84-a9a9-8e3b1a155413)   
 [Clear\-Content&#91;PSITPro3\_Management&#93;](assetId:///dee5f65f-eae2-42de-b369-5bed1a38ac21)   
 [Get\-Content&#91;PSITPro3\_Management&#93;](assetId:///4d594e54-2c28-4052-b3f8-1c27ea724561)   
 [Get\-ChildItem&#91;PSITPro3\_Management&#93;](assetId:///75cf79bb-4db6-4a67-8c36-3d20754e2190)   
 [Get\-Content&#91;PSITPro3\_Management&#93;](assetId:///4d594e54-2c28-4052-b3f8-1c27ea724561)   
 [Get\-Item&#91;PSITPro3\_Management&#93;](assetId:///4ed2b1e1-fde4-4425-90a0-87774477fefa)   
 [Remove\-Item&#91;PSITPro3\_Management&#93;](assetId:///0fe3ff11-a1f7-43b9-8c85-f92d52641395)   
 [Set\-Content&#91;PSITPro3\_Management&#93;](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2)   
 [Test\-Path&#91;PSITPro3\_Management&#93;](assetId:///2e9df935-45e8-44ba-a66a-2de2dd61f3f5)