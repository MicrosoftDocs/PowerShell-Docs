---
title: Windows PowerShell Navigation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 846f5233-43be-496a-9ca1-e3e34207cb49
---
# Windows PowerShell Navigation
Folders are a familiar organizational feature of the File Explorer interface, Cmd.exe, and UNIX tools such as BASH. Folders, or directories as they are more commonly known, are a useful concept for organizing files and other directories. UNIX\-family operating systems extend this by treating everything possible as a file; specific hardware and network connections appear as files within particular folders. This approach does not ensure that the content is readable or usable by particular applications, but it does make it simpler to find specific items. Tools that enumerate or search through files and folders work with these devices as well. You can also address a specific item by using the path to the file that represents it.

Analogously, the Windows PowerShell infrastructure supports exposing virtually anything that can be navigated like a standard Microsoft Windows disk drive or a UNIX filesystem as a Windows PowerShell Drive. A Windows PowerShell Drive does not necessarily represent a real drive, either locally or on the network. This chapter primarily discusses navigation for file systems, but the concepts apply to Windows PowerShell Drives that are not associated with file systems.

