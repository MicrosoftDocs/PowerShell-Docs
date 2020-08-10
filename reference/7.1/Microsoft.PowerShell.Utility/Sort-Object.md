---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/sort-object?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Sort-Object
---

# Sort-Object

## SYNOPSIS
Sorts objects by property values.

## SYNTAX

### Default (Default)

```
Sort-Object [-Stable] [-Descending] [-Unique] [-InputObject <PSObject>] [[-Property] <Object[]>]
 [-Culture <String>] [-CaseSensitive] [<CommonParameters>]
```

### Top

```
Sort-Object [-Descending] [-Unique] -Top <Int32> [-InputObject <PSObject>] [[-Property] <Object[]>]
 [-Culture <String>] [-CaseSensitive] [<CommonParameters>]
```

### Bottom

```
Sort-Object [-Descending] [-Unique] -Bottom <Int32> [-InputObject <PSObject>] [[-Property] <Object[]>]
 [-Culture <String>] [-CaseSensitive] [<CommonParameters>]
```

## DESCRIPTION

The `Sort-Object` cmdlet sorts objects in ascending or descending order based on object property
values. If sort properties are not included in a command, PowerShell uses default sort properties
of the first input object. If the type of the input object has no default sort properties,
PowerShell attempts to compare the objects themselves. For more information, see the [Notes](#notes)
section.

You can sort objects by a single property or multiple properties. Multiple properties use hash
tables to sort in ascending order, descending order, or a combination of sort orders. Properties are
sorted as case-sensitive or case-insensitive. Use the **Unique** parameter to eliminate duplicates
from the output.

## EXAMPLES

### Example 1: Sort the current directory by name

This example sorts the files and subdirectories in a directory.

```
PS> Get-ChildItem -Path C:\Test | Sort-Object

    Directory: C:\Test

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2/13/2019     08:55             26 anotherfile.txt
-a----        2/13/2019     13:26             20 Bfile.txt
-a----        2/12/2019     15:40         118014 Command.txt
-a----         2/1/2019     08:43            183 CreateTestFile.ps1
d-----        2/25/2019     18:25                Files
d-----        2/25/2019     18:24                Logs
-ar---        2/12/2019     14:31             27 ReadOnlyFile.txt
-a----        2/12/2019     16:24             23 Zsystemlog.log
```

The `Get-ChildItem` cmdlet gets the files and subdirectories from the directory specified by the
**Path** parameter, **C:\Test**. The objects are sent down the pipeline to the `Sort-Object` cmdlet.
`Sort-Object` does not specify a property so the output is sorted by the default sort property,
**Name**.

### Example 2: Sort the current directory by file length

This command displays the files in the current directory by length in ascending order.

```
PS> Get-ChildItem -Path C:\Test -File | Sort-Object -Property Length

    Directory: C:\Test

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2/13/2019     13:26             20 Bfile.txt
-a----        2/12/2019     16:24             23 Zsystemlog.log
-a----        2/13/2019     08:55             26 anotherfile.txt
-ar---        2/12/2019     14:31             27 ReadOnlyFile.txt
-a----         2/1/2019     08:43            183 CreateTestFile.ps1
-a----        2/12/2019     15:40         118014 Command.txt
```

The `Get-ChildItem` cmdlet gets the files from the directory specified by the **Path** parameter.
The **File** parameter specifies that `Get-ChildItem` only gets file objects. The objects are sent
down the pipeline to the `Sort-Object` cmdlet. `Sort-Object` uses the **Length** parameter to sort
the files by length in ascending order.

### Example 3: Sort processes by memory usage

This example displays processes with the highest memory usage based on their working set (WS) size.

```
PS> Get-Process | Sort-Object -Property WS | Select-Object -Last 5

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
    136   193.92     217.11     889.16   87492   8 OUTLOOK
    112   347.73     297.02      95.19  106908   8 Teams
    206   266.54     323.71      37.17   60620   8 MicrosoftEdgeCP
     35   552.19     549.94     131.66    6552   8 Code
      0     1.43     595.12       0.00    2780   0 Memory Compression
```

The `Get-Process` cmdlet gets the list of processes running on the computer. The process objects are
sent down the pipeline to the `Sort-Object` cmdlet. `Sort-Object` uses the **Property** parameter to
sort the objects by **WS**. The objects are sent down the pipeline to the `Select-Object` cmdlet.
`Select-Object` uses the **Last** parameter to specify the last five objects, which are the objects
with the highest **WS** usage.

In PowerShell 6, the `Sort-Object` parameter **Bottom** is an alternative to `Select-Object`. For
example, `Get-Process | Sort-Object -Property WS -Bottom 5`.

### Example 4: Sort HistoryInfo objects by Id

This command sorts the PowerShell session's **HistoryInfo** objects using the **Id** property. Each
PowerShell session has its own command history.

```
PS> Get-History | Sort-Object -Property Id -Descending

  Id CommandLine
  -- -----------
  10 Get-Command Sort-Object -Syntax
   9 $PSVersionTable
   8 Get-Command Sort-Object -Syntax
   7 Get-Command Sort-Object -ShowCommandInfo
   6 Get-ChildItem -Path C:\Test | Sort-Object -Property Length
   5 Get-Help Clear-History -online
   4 Get-Help Clear-History -full
   3 Get-ChildItem | Get-Member
   2 Get-Command Sort-Object -Syntax
   1 Set-Location C:\Test\
```

The `Get-History` cmdlet gets the history objects from the current PowerShell session. The objects
are sent down the pipeline to the `Sort-Object` cmdlet. `Sort-Object` uses the **Property**
parameter to sort the objects by **Id**. The **Descending** parameter sorts the command history from
newest to oldest.

### Example 5: Use a hash table to sort properties in ascending and descending order

This example uses two properties to sort the objects, **Status** and **DisplayName**. **Status** is
sorted in descending order and **DisplayName** is sorted in ascending order.

A hash table is used to specify the **Property** parameter's value. The hash table uses an
expression to specify the property names and sort orders. For more information about hash tables,
see [about_Hash_Tables](../Microsoft.PowerShell.Core/About/about_Hash_Tables.md).

The **Status** property used in the hash table is an enumerated property.
For more information, see [ServiceControllerStatus](/dotnet/api/system.serviceprocess.servicecontrollerstatus).

```
PS C:\> Get-Service | Sort-Object -Property @{Expression = "Status"; Descending = $True}, @{Expression = "DisplayName"; Descending = $False}

Status   Name               DisplayName
------   ----               -----------
Running  Appinfo            Application Information
Running  BthAvctpSvc        AVCTP service
Running  BrokerInfrastru... Background Tasks Infrastructure Ser...
Running  BDESVC             BitLocker Drive Encryption Service
Running  CoreMessagingRe... CoreMessaging
Running  VaultSvc           Credential Manager
Running  DsSvc              Data Sharing Service
Running  Dhcp               DHCP Client
...
Stopped  ALG                Application Layer Gateway Service
Stopped  AppMgmt            Application Management
Stopped  BITS               Background Intelligent Transfer Ser...
Stopped  wbengine           Block Level Backup Engine Service
Stopped  BluetoothUserSe... Bluetooth User Support Service_14fb...
Stopped  COMSysApp          COM+ System Application
Stopped  smstsmgr           ConfigMgr Task Sequence Agent
Stopped  DeviceInstall      Device Install Service
Stopped  MSDTC              Distributed Transaction Coordinator
```

The `Get-Service` cmdlet gets the list of services on the computer. The service objects are sent
down the pipeline to the `Sort-Object` cmdlet. `Sort-Object` uses the **Property** parameter with a
hash table to specify the property names and sort orders. The **Property** parameter is sorted by
two properties, **Status** in descending order and **DisplayName** in ascending order.

**Status** is an enumerated property. **Stopped** has a value of **1** and **Running** has a value
of **4**. The **Descending** parameter is set to `$True` so that **Running** processes are displayed
before **Stopped** processes. **DisplayName** sets the **Descending** parameter to `$False` to sort
the display names in alphabetical order.

### Example 6: Sort text files by time span

This command sorts text files in descending order by the time span between **CreationTime** and
**LastWriteTime**.

```
PS> Get-ChildItem -Path C:\Test\*.txt | Sort-Object -Property @{Expression = {$_.CreationTime - $_.LastWriteTime}; Descending = $False} | Format-Table CreationTime, LastWriteTime, FullName

CreationTime          LastWriteTime        FullName
------------          -------------        --------
11/21/2018 12:39:01   2/26/2019 08:59:36   C:\Test\test2.txt
12/4/2018 08:29:41    2/26/2019 08:57:05   C:\Test\powershell_list.txt
2/20/2019 08:15:59    2/26/2019 12:09:43   C:\Test\CreateTestFile.txt
2/20/2019 08:15:59    2/26/2019 12:07:41   C:\Test\Command.txt
2/20/2019 08:15:59    2/26/2019 08:57:52   C:\Test\ReadOnlyFile.txt
11/29/2018 15:16:50   12/4/2018 16:16:24   C:\Test\LogData.txt
2/25/2019 18:25:11    2/26/2019 12:08:47   C:\Test\Zsystemlog.txt
2/25/2019 18:25:11    2/26/2019 08:55:33   C:\Test\Bfile.txt
2/26/2019 08:46:59    2/26/2019 12:12:19   C:\Test\LogFile3.txt
```

The `Get-ChildItem` cmdlet uses the **Path** parameter to specify the directory **C:\Test** and all
of the `*.txt` files. The objects are sent down the pipeline to the `Sort-Object` cmdlet.
`Sort-Object` uses the **Property** parameter with a hash table to determine each files time span
between **CreationTime** and **LastWriteTime**. The **Descending** parameter is set to `$False` to
sort in the order of longest to shortest time span.

### Example 7: Sort names in a text file

This example shows how to sort a list from a text file. The original file is displayed as an
unsorted list. `Sort-Object` sorts the contents and then sorts the contents with the **Unique**
parameter that removes duplicates.

```
PS> Get-Content -Path C:\Test\ServerNames.txt
localhost
server01
server25
LOCALHOST
Server19
server3
localhost

PS> Get-Content -Path C:\Test\ServerNames.txt | Sort-Object
localhost
LOCALHOST
localhost
server01
Server19
server25
server3

PS> Get-Content -Path C:\Test\ServerNames.txt | Sort-Object -Unique
localhost
server01
Server19
server25
server3
```

The `Get-Content` cmdlet uses the **Path** parameter to specify the directory and file name. The
file **ServerNames.txt** contains an unsorted list of computer names.

The `Get-Content` cmdlet uses the **Path** parameter to specify the directory and file name. The
file **ServerNames.txt** contains an unsorted list of computer names. The objects are sent down the
pipeline to the `Sort-Object` cmdlet. `Sort-Object` sorts the list in the default order, ascending.

The `Get-Content` cmdlet uses the **Path** parameter to specify the directory and file name. The
file **ServerNames.txt** contains an unsorted list of computer names. The objects are sent down the
pipeline to the `Sort-Object` cmdlet. `Sort-Object` uses the **Unique** parameter to remove
duplicate computer names. The list is sorted in the default order, ascending.

### Example 8: Sort a string as an integer

This example shows how to sort a text file that contains string objects as integers. You can send
each command down the pipeline to `Get-Member` and verify that the objects are strings instead of
integers. For these examples, the `ProductId.txt` file contains an unsorted list of product numbers.

In the first example, `Get-Content` gets the contents of the file and pipes lines to the
`Sort-Object` cmdlet. `Sort-Object` sorts the string objects in ascending order.

```
PS> Get-Content -Path C:\Test\ProductId.txt | Sort-Object
0
1
12345
1500
2
2800
3500
4100
500
6200
77
88
99999

PS> Get-Content -Path C:\Test\ProductId.txt | Sort-Object {[int]$_}
0
1
2
77
88
500
1500
2800
3500
4100
6200
12345
99999
```

In the second example, `Get-Content` gets the contents of the file and pipes lines to the
`Sort-Object` cmdlet. `Sort-Object` uses a script block to convert the strings to integers. In the
sample code, `[int]` converts the string to an integer and `$_` represents each string as it comes
down the pipeline. The integer objects are sent down the pipeline to the `Sort-Object` cmdlet.
`Sort-Object` sorts the integer objects in numeric order.

### Example 9: Using stable sorts

When you use the **Top**, **Bottom**, or **Stable** parameters, the sorted objects are delivered in
the order they were received by `Sort-Object` when the sort criteria are equal. In this example, we
are sorting the numbers one through 20 by the their value 'modulo 3'. The modulo value ranges from
zero to two.

```powershell
PS> 1..20 |Sort-Object {$_ % 3}
18
3
15
6
12
9
1
16
13
10
7
4
19
11
8
14
5
17
2
20

PS> 1..20 |Sort-Object {$_ % 3} -Stable
3
6
9
12
15
18
1
4
7
10
13
16
19
2
5
8
11
14
17
20
```

The output from the first sort is correctly grouped by the modulus value but the individual items
are not sorted within the modulus range. The second sort uses the **Stable** option to return a
stable sort.

## PARAMETERS

### -Bottom

Specifies the number of objects to get from the end of a sorted object array. This results in a
stable sort.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Int32
Parameter Sets: Bottom
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CaseSensitive

Indicates that the sort is case-sensitive. By default, sorts are not case-sensitive.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Case-insensitive
Accept pipeline input: False
Accept wildcard characters: False
```

### -Culture

Specifies the cultural configuration to use for sorts. Use `Get-Culture` to display the system's
culture configuration.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Descending

Indicates that `Sort-Object` sorts the objects in descending order. The default is ascending order.

To sort multiple properties with different sort orders, use a hash table. For example, with a hash
table you can sort one property in ascending order and another property in descending order.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Ascending
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

To sort objects, send them down the pipeline to `Sort-Object`. If you use the **InputObject**
parameter to submit a collection of items, `Sort-Object` receives one object that represents the
collection. Because one object cannot be sorted, `Sort-Object` returns the entire collection
unchanged.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Property

Specifies the property names that `Sort-Object` uses to sort the objects. Wildcards are permitted.
Objects are sorted based on the property values. If you do not specify a property, `Sort-Object`
sorts based on default properties for the object type or the objects themselves.

Multiple properties can be sorted in ascending order, descending order, or a combination of sort
orders. When you specify multiple properties, the objects are sorted by the first property. If
multiple objects have the same value for the first property, those objects are sorted by the second
property. This process continues until there are no more specified properties or no groups of
objects.

The **Property** parameter's value can be a calculated property. To create a calculated property,
use a hash table.

Valid keys for a hash table are as follows:

- `expression` - `<string>` or `<script block>`
- `ascending` or `descending` - `<boolean>`

For more information, see
[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md).

```yaml
Type: System.Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: Default properties
Accept pipeline input: False
Accept wildcard characters: True
```

### -Top

Specifies the number of objects to get from the start of a sorted object array. This results in a
stable sort.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Int32
Parameter Sets: Top
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Unique

Indicates that `Sort-Object` eliminates duplicates and returns only the unique members of the
collection. The first instance of a unique value is included in the sorted output.

**Unique** is case-insensitive. Strings that only differ by character case are considered the same.
For example, character and CHARACTER.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: All
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stable

The sorted objects are delivered in the order they were received when the sort criteria are equal.

This parameter was added in PowerShell v6.2.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe the objects to be sorted to `Sort-Object`.

## OUTPUTS

### System.Management.Automation.PSObject

`Sort-Object` returns the sorted objects.

## NOTES

The `Sort-Object` cmdlet sorts objects based on properties specified in the command or the default
sort properties for the object type. Default sort properties are defined using the `PropertySet`
named `DefaultKeyPropertySet` in a `types.ps1xml` file. For more information, see
[about_Types.ps1xml](/powershell/module/Microsoft.PowerShell.Core/About/about_Types.ps1xml).

If an object does not have one of the specified properties, the property value for that object is
interpreted by `Sort-Object` as **Null** and placed at the end of the sort order.

When no sort properties are available, PowerShell attempts to compare the objects themselves.
`Sort-Object` uses the **Compare** method for each property. If a property does not implement
**IComparable**, the cmdlet converts the property value to a string and uses the **Compare** method
for **System.String**. For more information, see
[PSObject.CompareTo(Object) Method](/dotnet/api/system.management.automation.psobject.compareto).

If you sort on an enumerated property such as **Status**, `Sort-Object` sorts by the enumeration
values. For Windows services, **Stopped** has a value of **1** and **Running** has a value of **4**.
**Stopped** is sorted before **Running** because of the enumerated values. For more information,
see [ServiceControllerStatus](/dotnet/api/system.serviceprocess.servicecontrollerstatus).

The performance of the sorting algorithm is slower when doing a stable sort.

## RELATED LINKS

[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md)

[about_Hash_Tables](../Microsoft.PowerShell.Core/About/about_Hash_Tables.md)

[about_Types.ps1xml](../Microsoft.PowerShell.Core/About/about_Types.ps1xml.md)

[Compare-Object](Compare-Object.md)

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Group-Object](Group-Object.md)

[Measure-Object](Measure-Object.md)

[New-Object](New-Object.md)

[Select-Object](Select-Object.md)

[Tee-Object](Tee-Object.md)
