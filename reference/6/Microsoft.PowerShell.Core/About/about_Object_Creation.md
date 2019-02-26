---
ms.date:  11/30/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Object_Creation
---
# About Object Creation

## SHORT DESCRIPTION
Explains how to create objects in  PowerShell.

## LONG DESCRIPTION

You can create objects in PowerShell and use the objects that you create in
commands and scripts.

There are several ways to create objects:

- `New-Object`: This cmdlet creates an instance of a .NET Framework object or
  COM object.

- Hash tables: Beginning in PowerShell 3.0, you can create objects
  from hash tables of property names and property values.

- `Import-Csv`: This cmdlet creates custom objects (PSCustomObject) from the
  items in a CSV file. Each row is an object instance and each column is an
  object property.

This topic will demonstrate and discuss each of these methods.

## NEW-OBJECT

The `New-Object` cmdlet provides a robust and consistent way to create new
objects. The cmdlet works with almost all types and in all supported versions
of PowerShell.

To create a new object, specify either the type of a .NET Framework class or a
ProgID of a COM object.

For example, the following command creates a Version object.

```powershell
PS C:\> $v = New-Object -TypeName System.Version -ArgumentList 2.0.0.1
PS C:\> $v
```

```Output
Major  Minor  Build  Revision
-----  -----  -----  --------
2      0      0      1
```

```powershell
PS C:\> $v | Get-Member

    TypeName: System.Version
```

For more information, see the help topic for the New-Object cmdlet.

### CREATE OBJECTS FROM HASH TABLES

Beginning in PowerShell 3.0, you can create an object from a hash table of
properties and property values.

The syntax is as follows:

```
[<class-name>]@{
  <property-name>=<property-value>
  <property-name>=<property-value>
}
```

This method works only for classes that have a null constructor, that is, a
constructor that has no parameters. The object properties must be public and
settable.

### CREATE CUSTOM OBJECTS FROM HASH TABLES

Custom objects are very useful and they are very easy to create by using the
hash table method. To create a custom object, use the PSCustomObject class, a
class designed specifically for this purpose.

Custom objects are an excellent way to return customized output from a
function or script; far more useful than returning formatted output that
cannot be reformatted or piped to other commands.

The commands in the `Test-Object function` set some variable values and then
use those values to create a custom object. You can see this object in use in
the example section of the `Update-Help` cmdlet help topic.

```powershell
function Test-Object {
  $ModuleName = "PSScheduledJob"
  $HelpCulture = "en-us"
  $HelpVersion = "3.1.0.0"
  [PSCustomObject]@{
    "ModuleName"=$ModuleName
    "UICulture"=$HelpCulture
    "Version"=$HelpVersion
  }
  $ModuleName = "PSWorkflow"
  $HelpCulture = "en-us"
  $HelpVersion = "3.0.0.0"
  [PSCustomObject]@{
    "ModuleName"=$ModuleName
    "UICulture"=$HelpCulture
    "Version"=$HelpVersion
  }
}
```

The output of this function is a collection of custom objects formatted as a
table by default.

```powershell
PS C:\> Test-Object

ModuleName        UICulture      Version
---------         ---------      -------
PSScheduledJob    en-us          3.1.0.0
PSWorkflow        en-us          3.0.0.0
```

Users can manage the properties of the custom objects just as they do with
standard objects.

```powershell
PS C:\> (Test-Object).ModuleName
 PSScheduledJob
 PSWorkflow
```

#### CREATE NON-CUSTOM OBJECTS FROM HASH TABLES

You can also use hash tables to create objects for non-custom classes. When
you create an object for a non-custom class, the full namespace name is
required unless class is in the System namespace. Use only the properties of
the class.

For example, the following command creates a session option object.

```powershell
[System.Management.Automation.Remoting.PSSessionOption]@{
  IdleTimeout=43200000
  SkipCnCheck=$True
}
```

The requirements of the hash table feature, especially the null constructor
requirement, eliminate many existing classes. However, most PowerShell option
classes are designed to work with this feature, as well as other very useful
classes, such as the ScheduledJobTrigger class.

```powershell
[Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger]@{
  Frequency="Daily"
  At="15:00"
}

Id   Frequency   Time                   DaysOfWeek  Enabled
--   ---------   ----                   ----------  -------
0    Daily       6/6/2012 3:00:00 PM                True
```

You can also use the hash table feature when setting parameter values. For
example, the value of the **SessionOption** parameter of the New-PSSession
cmdlet and the value of the JobTrigger parameter of `Register-ScheduledJob`
can be a hash table.

```powershell
New-PSSession -ComputerName Server01 -SessionOption @{
  IdleTimeout=43200000
  SkipCnCheck=$True
}
Register-ScheduledJob Name Test -FilePath .\Get-Inventory.ps1 -Trigger @{
  Frequency="Daily"
  At="15:00"
}
```

### IMPORT-CSV

You can create custom objects from the items in a CSV file. When you use the
`Import-Csv` cmdlet to import the CSV file, the cmdlet creates a custom object
(PSCustomObject) for each item in the file. The column names are the object
properties.

For example, if you import a CSV file of computer asset data, `Import-CSV`
creates a collection of custom objects from the input.

```
#In Servers.csv
AssetID, Name, OS, Department
003, Server01, Windows Server 2012, IT
103, Server33, Windows 7, Marketing
212, Server35, Windows 8, Finance
```

```powershell
PS C:\> $a = Import-Csv Servers.csv
PS C:\> $a

AssetID        Name           OS                    Department
-------        ----           --                    ----------
003            Server01       Windows Server 2012   IT
103            Server33       Windows 7             Marketing
212            Server35       Windows 8             Finance
```

Use the Get-Member cmdlet to confirm the object type.

```powershell
PS C:\> $a | Get-Member
```

```Output
TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
AssetID     NoteProperty System.String AssetID=003
Department  NoteProperty System.String Department=IT
Name        NoteProperty System.String Name=Server01
OS          NoteProperty System.String OS=Windows Server 2012
```

You can use the custom objects just as you would standard objects.

```powershell
PS C:\> $a | where {$_.OS -eq "Windows 8"}
```

```output
AssetID        Name           OS                    Department
-------        ----           --                    ----------
212            Server35       Windows 8             Finance
```

For more information, see the help topic for the Import-Csv cmdlet.

## SEE ALSO

[about_Objects](about_Objects.md)

[about_Methods](about_Methods.md)

[about_Properties](about_Properties.md)

[about_Pipelines](about_Pipelines.md)

[Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md)

[Import-Csv](../../Microsoft.PowerShell.Utility/Import-Csv.md)

[New-Object](../../Microsoft.PowerShell.Utility/New-Object.md)