---
title:  Understanding the Windows PowerShell Pipeline
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  6be50926-7943-4ef7-9499-4490d72a63fb
---

# Understanding the Windows PowerShell Pipeline
Piping works virtually everywhere in Windows PowerShell. Although you see text on the screen, Windows PowerShell does not pipe text between commands. Instead, it pipes objects.

The notation used for pipelines is similar to that used in other shells, so at first glance, it may not be apparent that Windows PowerShell introduces something new. For example, if you use the **Out\-Host** cmdlet to force a page\-by\-page display of output from another command, the output looks just like the normal text displayed on the screen, broken up into pages:

```
PS> Get-ChildItem -Path C:\WINDOWS\System32 | Out-Host -Paging

    Directory: Microsoft.Windows PowerShell.Core\FileSystem::C:\WINDOWS\system32

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---        2005-10-22  11:04 PM        315 $winnt$.inf
-a---        2004-08-04   8:00 AM      68608 access.cpl
-a---        2004-08-04   8:00 AM      64512 acctres.dll
-a---        2004-08-04   8:00 AM     183808 accwiz.exe
-a---        2004-08-04   8:00 AM      61952 acelpdec.ax
-a---        2004-08-04   8:00 AM     129536 acledit.dll
-a---        2004-08-04   8:00 AM     114688 aclui.dll
-a---        2004-08-04   8:00 AM     194048 activeds.dll
-a---        2004-08-04   8:00 AM     111104 activeds.tlb
-a---        2004-08-04   8:00 AM       4096 actmovie.exe
-a---        2004-08-04   8:00 AM     101888 actxprxy.dll
-a---        2003-02-21   6:50 PM     143150 admgmt.msc
-a---        2006-01-25   3:35 PM      53760 admparse.dll
<SPACE> next page; <CR> next line; Q quit
...
```

The Out\-Host \-Paging command is a useful pipeline element whenever you have lengthy output that you would like to display slowly. It is especially useful if the operation is very CPU\-intensive. Because processing is transferred to the Out\-Host cmdlet when it has a complete page ready to display, cmdlets that precede it in the pipeline halt operation until the next page of output is available. You can see this if you use the Windows Task Manager to monitor CPU and memory use by Windows PowerShell.

Run the following command: **Get\-ChildItem C:\\Windows \-Recurse**. Compare the CPU and memory usage to this command: **Get\-ChildItem C:\\Windows \-Recurse | Out\-Host \-Paging**. What you see on the screen is text, but that is because it is necessary to represent objects as text in a console window. This is just a representation of what is really going on inside Windows PowerShell. For example, consider the Get\-Location cmdlet. If you type **Get\-Location** while your current location is the root of the C drive, you would see the following output:

```
PS> Get-Location

Path
----
C:\
```

If Windows PowerShell pipelined text, issuing a command such as **Get\-Location | Out\-Host**, would pass from **Get\-Location** to **Out\-Host** a set of characters in the order they are displayed onscreen. In other words, if you were to ignore the heading information, **Out\-Host** would first receive the character '**C'**, then the character '**:'**, then the character '**\\'**. The **Out\-Host** cmdlet could not determine what meaning to associate with the characters output by the **Get\-Location** cmdlet.

Instead of using text to let commands in a pipeline communicate, Windows PowerShell uses objects. From the standpoint of a user, objects package related information into a form that makes it easier to manipulate the information as a unit, and extract specific items that you need.

The **Get\-Location** command does not return text that contains the current path. It returns a package of information called a **PathInfo** object that contains the current path along with some other information. The **Out\-Host** cmdlet then sends this **PathInfo** object to the screen, and Windows PowerShell decides what information to display and how to display it based on its formatting rules.

In fact, the heading information output by the **Get\-Location** cmdlet is added only at the end of the process, as part of the process of formatting the data for onscreen display. What you see onscreen is a summary of information, and not a complete representation of the output object.

Given that there may be more information output from a Windows PowerShell command than what we see displayed in the console window, how can you retrieve the non\-visible elements? How do you view the extra data? And what if you want to view the data in a format different than the one Windows PowerShell normally uses?

The rest of this chapter discusses how you can discover the structure of specific Windows PowerShell objects, selecting specific items and formatting them for easier display, and how to send this information to alternative output locations such as files and printers.

