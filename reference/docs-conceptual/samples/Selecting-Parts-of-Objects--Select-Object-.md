---
ms.date:  12/23/2019
keywords:  powershell,cmdlet
title:  Selecting Parts of Objects Select Object
description: You can use the `Select-Object` cmdlet to create new, custom PowerShell objects that contain properties selected from the objects on the pipeline.
---
# Selecting Parts of Objects (Select-Object)

You can use the `Select-Object` cmdlet to create new, custom PowerShell objects that contain
properties selected from the objects you use to create them. Type the following command to create a
new object that includes only the **Name** and **FreeSpace** properties of the **Win32_LogicalDisk**
WMI class:

```powershell
Get-CimInstance -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace
```

```Output
Name      FreeSpace
----      ---------
C:      50664845312
```

With `Select-Object` you can create calculated properties. So you can display **FreeSpace** in
gigabytes rather than bytes.

```powershell
Get-CimInstance -Class Win32_LogicalDisk |
  Select-Object -Property Name, @{
    label='FreeSpace'
    expression={($_.FreeSpace/1GB).ToString('F2')}
  }
```

```Output
Name    FreeSpace
----    ---------
C:      47.18
```
