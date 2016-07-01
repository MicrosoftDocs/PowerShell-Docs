---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Locations
ms.technology:  powershell
ms.assetid:  5af9602c-598d-4740-83ba-b299ea89be96
---

# about_Locations
## TOPIC  
 about\_Locations  
  
## SHORT DESCRIPTION  
 Describes how to access items from the working location in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 The current working location is the default location to which commands point. In other words, this is the location that [!INCLUDE[wps_2]()] uses if you do not supply an explicit path to the item or location that is affected by the command. In most cases, the current working location is a drive accessed through the [!INCLUDE[wps_2]()] FileSystem provider and, in some cases, a directory on that drive. For example, you might set your current working location to the following location:  
  
```  
C:\Program Files\Windows PowerShell  
```  
  
 As a result, all commands are processed from this location unless another path is explicitly provided.  
  
 [!INCLUDE[wps_2]()] maintains the current working location for each drive even when the drive is not the current drive. This allows you to access items from the current working location by referring only to the drive of another location. For example, suppose that your current working location is C:\\Windows. Now, suppose you use the following command to change your current working location to the HKLM: drive:  
  
```  
Set-Location HKLM:  
```  
  
 Although your current location is now the registry drive, you can still access items in the C:\\Windows directory simply by using the C: drive, as shown in the following example:  
  
```  
Get-ChildItem C:  
```  
  
 [!INCLUDE[wps_2]()] remembers that your current working location for that drive is the Windows directory, so it retrieves items from that directory. The results would be the same if you ran the following command:  
  
```  
Get-ChildItem C:\Windows  
```  
  
 In [!INCLUDE[wps_2]()], you can use the Get\-Location command to determine the current working location, and you can use the Set\-Location command to set the current working location. For example, the following command sets the current working location to the Windows directory of the C: drive:  
  
```  
Set-Location c:\windows  
```  
  
 After you set the current working location, you can still access items from other drives simply by including the drive name \(followed by a colon\) in the command, as shown in the following example:  
  
```  
Get-ChildItem HKLM :\software  
```  
  
 The example command retrieves a list of items in the Software container of the HKEY Local Machine hive in the registry.  
  
 [!INCLUDE[wps_2]()] also allows you to use special characters to represent the current working location and its parent location. To represent the current working location, use a single period. To represent the parent of the current working location, use two periods. For example, the following specifies the System subdirectory in the current working location:  
  
```  
Get-ChildItem .\system  
```  
  
 If the current working location is C:\\Windows, this command returns a list of all the items in C:\\Windows\\System. However, if you use two periods, the parent directory of the current working directory is used, as shown in the following example:  
  
```  
Get-ChildItem ..\"program files"  
```  
  
 In this case, [!INCLUDE[wps_2]()] treats the two periods as the C: drive, so the command retrieves all the items in the C:\\Program Files directory.  
  
 A path beginning with a slash identifies a path from the root of the current drive. For example, if your current working location is C:\\Program Files\\[!INCLUDE[wps_2]()], the root of your drive is C. Therefore, the following command lists all items in the C:\\Windows directory:  
  
```  
Get-ChildItem \windows  
```  
  
 If you do not specify a path beginning with a drive name, slash, or period when supplying the name of a container or item, the container or item is assumed to be located in the current working location. For example, if your current working location is C:\\Windows, the following command returns all the items in the C:\\Windows\\System directory:  
  
```  
Get-ChildItem system  
```  
  
 If you specify a file name rather than a directory name, [!INCLUDE[wps_2]()] returns details about that file \(assuming that file is located in the current working location\).  
  
## SEE ALSO  
 Set\-Location  
  
 about\_Providers  
  
 about\_Path\_Syntax

