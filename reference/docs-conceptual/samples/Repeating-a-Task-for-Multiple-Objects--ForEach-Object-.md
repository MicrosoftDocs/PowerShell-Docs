---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Repeating a Task for Multiple Objects ForEach Object
ms.assetid:  6697a12d-2470-4ed6-b5bb-c35e5d525eb6
---
# Repeating a Task for Multiple Objects (ForEach-Object)

The **ForEach-Object** cmdlet uses script blocks and the `$_` descriptor for the current pipeline object to let you run a command on each object in the pipeline. This can be used to perform some complicated tasks.

One situation where this can be useful is manipulating data to make it more useful. For example, the Win32_LogicalDisk class from WMI can be used to return free space information for each local disk. The data is returned in terms of bytes, however, which makes it difficult to read:

```
PS> Get-WmiObject -Class Win32_LogicalDisk

DeviceID     : C:
DriveType    : 3
ProviderName :
FreeSpace    : 50665070592
Size         : 203912880128
VolumeName   : Local Disk
```

We can convert the FreeSpace value to megabytes by dividing each value by 1024 twice; after the first division, the data is in kilobytes, and after the second division it is megabytes. You can do that in a ForEach-Object script block by typing:

```
PS> Get-WmiObject -Class Win32_LogicalDisk | ForEach-Object -Process {($_.FreeSpace)/1024.0/1024.0}
48318.01171875
```

Unfortunately, the output is now data with no associated label. Because WMI properties such as this are read-only, you cannot directly convert FreeSpace. If you type this:

```powershell
Get-WmiObject -Class Win32_LogicalDisk | ForEach-Object -Process {$_.FreeSpace = ($_.FreeSpace)/1024.0/1024.0}
```

You get an error message:

```output
"FreeSpace" is a ReadOnly property.
At line:1 char:70
+ Get-WmiObject -Class Win32_LogicalDisk | ForEach-Object -Process {$_.F <<<< r
eeSpace = ($_.FreeSpace)/1024.0/1024.0}
```

You could reorganize the data by using some advanced techniques, but a simpler approach is to create a new object, by using **Select-Object**.