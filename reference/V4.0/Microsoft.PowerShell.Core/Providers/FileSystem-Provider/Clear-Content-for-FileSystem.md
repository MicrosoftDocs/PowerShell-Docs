---
title: Clear-Content for FileSystem
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9ad3020a-e472-41ec-b1e2-c57711bdb87c
---
# Clear-Content for FileSystem
Deletes the contents of an item, but does not delete the item.  
  
## Syntax  
  
```  
Clear-Content [-Stream <string>] [<CommonParameters>]  
  
```  
  
## Description  
 In the file system, [Clear\-Content](assetId:///dee5f65f-eae2-42de-b369-5bed1a38ac21) clears the content in a file, but does not delete the file. It has no effect on folders.  
  
 Note: This custom cmdlet help file explains how the [Clear\-Content](assetId:///dee5f65f-eae2-42de-b369-5bed1a38ac21) cmdlet works in a file system drive. For information about the [Clear\-Content](assetId:///dee5f65f-eae2-42de-b369-5bed1a38ac21) cmdlet in all drives, type "[Get\-Help](assetId:///1f46eeb4-49d7-4bec-bb29-395d9b42f54a)[Clear\-Content](assetId:///dee5f65f-eae2-42de-b369-5bed1a38ac21) \-Path $null" or see [Clear\-Content](assetId:///dee5f65f-eae2-42de-b369-5bed1a38ac21) at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113282.  
  
## Parameters  
  
### \-Stream \<string\>  
 Deletes the content in the specified alternate data stream, but does not delete the alternate data stream. Enter the stream name. Wildcards are not supported.  
  
 Stream is a dynamic parameter that the FileSystem provider adds to the [Set\-Content](assetId:///a8b56d7e-cebd-4049-9184-62926ef448e2) cmdlet. This parameter works only in file system drives.  
  
 You can use the [Clear\-Content](assetId:///dee5f65f-eae2-42de-b369-5bed1a38ac21) cmdlet to clear the content of an alternate data stream. However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the Unblock\-File cmdlet.  
  
 This parameter is introduced in Windows PowerShell 3.0.  
  
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
|Inputs||  
|Outputs||  
  
## Example 1  
  
```  
C:\PS>Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier  
  
[ZoneTransfer]  
ZoneId=3  
  
C:\PS>Clear-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier  
  
C:\PS>Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier  
C:\PS>  
  
Description  
-----------  
This example shows how the Clear-Content cmdlet clears the content from an alternate data stream while leaving the stream intact.  
  
The first command uses the Get-Content cmdlet to get the content of the Zone.Identifier stream in the Copy-Script.ps1 file, which was downloaded from the Internet.  
  
The second command uses the Clear-Content cmdlet to clear the content.   
  
The third command repeats the first command. It verifies that the content is cleared, but the stream remains. If the stream were deleted, the command would generate an error.  
  
You can use a method like this one to clear the content of an alternate data stream. However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the Unblock-File cmdlet.  
  
```  
  
## Example 2  
  
```  
C:\PS>Clear-Content ..\SmpUsers\*\init.txt  
  
Description  
-----------  
This command deletes all of the content from the "init.txt" files in all subdirectories of the SmpUsers directory. The files are not deleted, but they are empty.  
  
```  
  
## Example 3  
  
```  
C:\PS>Clear-Content -Path * -Filter *.log -Force  
  
Description  
-----------  
This command deletes the contents of all files in the current directory with the ".log" file name extension, including files with the read-only attribute. The asterisk (*) in the path represents all items in the current directory. The Force parameter makes the command effective on read-only files. Using a filter to restrict the command to files with the ".log" file name extension instead of specifying "*.log" in the path makes the operation faster.  
  
```  
  
## Example 4  
  
```  
C:\PS>Clear-Content c:\Temp\* -Include Smp* -Exclude *2* -WhatIf  
  
Description  
-----------  
This command requests a prediction of what would happen if you submitted the command: "clear-content c:\temp\* -include smp* -exclude *2*". The result lists the files that would be cleared; in this case, files in the Temp directory whose names begin with "Smp", unless the file names include a "2". To execute the command, run it again without the Whatif parameter.  
  
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