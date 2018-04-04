---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Selecting Parts of Objects Select Object
ms.assetid:  72e64b1a-d351-4500-9da3-24d8a71d7a92
---
# Selecting Parts of Objects (Select-Object)

You can use the **Select-Object** cmdlet to create new, custom Windows PowerShell objects that contain properties selected from the objects you use to create them. Type the following command to create a new object that includes only the Name and FreeSpace properties of the Win32_LogicalDisk WMI class:

```
PS> Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace

Name                                    FreeSpace
----                                    ---------
C:                                      50664845312
```

You cannot see the type of data after issuing that command, but if you pipe the result to Get-Member after the Select-Object, you can tell that you have a new type of object, a PSCustomObject:

```
PS> Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace| Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       System.Boolean Equals(Object obj)
GetHashCode Method       System.Int32 GetHashCode()
GetType     Method       System.Type GetType()
ToString    Method       System.String ToString()
FreeSpace   NoteProperty  FreeSpace=...
Name        NoteProperty System.String Name=C:
```

Select-Object has many uses. One of them is replicating data that you can then modify. We can now handle the problem we ran across in the previous section. We can update the value of FreeSpace in our newly-created objects and the output will include the descriptive label:

```
Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace | ForEach-Object -Process {$_.FreeSpace = ($_.FreeSpace)/1024.0/1024.0; $_}
Name                                                                  FreeSpace
----                                                                  ---------
C:                                                                48317.7265625
```