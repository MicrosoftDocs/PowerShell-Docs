---
title:  Sorting Objects
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  8530caa8-3ed4-4c56-aed7-1295dd9ba199
---

# Sorting Objects
We can organize displayed data to make it easier to scan by using the **Sort\-Object** cmdlet. **Sort\-Object** takes the name of one or more properties to sort on, and returns data sorted by the values of those properties.

Consider the problem of listing Win32\_SystemDriver instances. If we want to sort by **State** and then by **Name**, we can do it by typing:

```
Get-WmiObject -Class Win32_SystemDriver | Sort-Object -Property State,Name | Format-Table -Property Name,State,Started,DisplayName -AutoSize -Wrap
```

Although this is a lengthy display, you can see items with the same state grouped together:

```
Name           State   Started DisplayName
----           -----   ------- -----------
ACPI           Running    True Microsoft ACPI Driver
AFD            Running    True AFD
AmdK7          Running    True AMD K7 Processor Driver
AsyncMac       Running    True RAS Asynchronous Media Driver
...
Abiosdsk       Stopped   False Abiosdsk
ACPIEC         Stopped   False ACPIEC
aec            Stopped   False Microsoft Kernel Acoustic Echo Canceller
...
```

You can also sort the objects in reverse order by specifying the **Descending** parameter. This reverses the sort order so that names are sorted in reverse alphabetical order and numbers are sorted by descending size.

```
PS> Get-WmiObject -Class Win32_SystemDriver | Sort-Object -Property State,Name -Descending | Format-Table -Property Name,State,Started,DisplayName -AutoSize -Wrap

Name           State   Started DisplayName
----           -----   ------- -----------
WS2IFSL        Stopped   False Windows Socket 2.0 Non-IFS Service Provider Supp
                               ort Environment
wceusbsh       Stopped   False Windows CE USB Serial Host Driver...
...
wdmaud         Running    True Microsoft WINMM WDM Audio Compatibility Driver
Wanarp         Running    True Remote Access IP ARP Driver
...
```

