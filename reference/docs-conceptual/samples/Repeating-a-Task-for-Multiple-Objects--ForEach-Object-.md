---
ms.date:  12/23/2019
keywords:  powershell,cmdlet
title:  Repeating a Task for Multiple Objects ForEach Object
description: The ForEach-Object allows you to repeat a set of commands for each object passed through the pipeline.
---
# Repeating a Task for Multiple Objects (ForEach-Object)

The `ForEach-Object` cmdlet uses script blocks and the `$_` descriptor for the current pipeline
object to let you run a command on each object in the pipeline. This can be used to perform some
complicated tasks.

One situation where this can be useful is manipulating data to make it more useful. For example, the
**Win32_LogicalDisk** class from WMI can be used to return free space information for each local
disk. The data is returned in terms of bytes, however, which makes it difficult to read:

```powershell
Get-CimInstance -Class Win32_LogicalDisk
```

```Output
DeviceID DriveType ProviderName VolumeName Size          FreeSpace
-------- --------- ------------ ---------- ----          ---------
C:       3                      Local Disk 203912880128  50665070592
```

We can convert the **FreeSpace** value to megabytes by dividing each value by 1MB. You can do that
in a `ForEach-Object` script block by typing:

```powershell
Get-CimInstance -Class Win32_LogicalDisk |
  ForEach-Object -Process {($_.FreeSpace)/1MB}
```

```Output
48318.01171875
```

Unfortunately, the output is now data with no associated label. Because WMI properties such as this
are read-only, you cannot directly convert **FreeSpace**. If you type this:

```powershell
Get-CimInstance -Class Win32_LogicalDisk |
  ForEach-Object -Process {$_.FreeSpace = ($_.FreeSpace)/1MB}
```

You get an error message:

```Output
"FreeSpace" is a ReadOnly property.
At line:2 char:28
+   ForEach-Object -Process {$_.FreeSpace = ($_.FreeSpace)/1MB}
+                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : NotSpecified: (:) [], SetValueException
+ FullyQualifiedErrorId : ReadOnlyCIMProperty
```

You could reorganize the data by using some advanced techniques, but a simpler approach is to create
a new object, by using `Select-Object`.
