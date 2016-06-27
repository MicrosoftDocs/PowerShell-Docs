---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294017
schema: 2.0.0
---

# Sort-Object
## SYNOPSIS
Sorts objects by property values.

## SYNTAX

```
Sort-Object [-Descending] [-Unique] [-InputObject <PSObject>] [[-Property] <Object[]>] [-Culture <String>]
 [-CaseSensitive] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Sort-Object cmdlet sorts objects in ascending or descending order based on the values of properties of the object.

You can specify a single property or multiple properties (for a multi-key sort), and you can select a case-sensitive or case-insensitive sort.
You can also direct Sort-Object to display only the objects with a unique value for a particular property.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-childitem | sort-object

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---         9/13/2005   4:24 PM          0 0
-a---          9/6/2005   4:19 PM         12 a.csv
-a---         9/21/2005   3:49 PM        529 a.Ps
-a---         8/22/2005   4:14 PM         22 a.pl
-a---         9/27/2005  10:33 AM         24 a.txt
-a---         9/15/2005  10:31 AM        398 a.vbs
-a---         7/21/2005  12:39 PM      37066 a.xml
-a---         8/28/2005  11:30 PM       5412 a.xslt
-a---        10/25/2005   1:59 PM        125 AdamTravel.txt
-a---         7/21/2005   9:49 AM         59 add2Num.Ps
-a---         8/29/2005   5:42 PM       7111 add-content.xml
-a---         9/21/2005  12:46 PM       8771 aliens.Ps
-a---         8/10/2005   2:10 PM        798 array.xml
-a---          8/4/2004   5:00 AM        110 AUTORUN.INF
-a---          9/6/2005   4:20 PM        245 b.csv
...
```

This command sorts the subdirectories and files in the current directory.
Because no properties are specified, the files and directories are sorted in ascending alphabetical order by their default sort property, Name.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-childitem | sort-object -property length

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---         12/3/2006   5:35 PM          2 pref.txt
-a---          9/6/2006   3:33 PM         15 count.txt
-a---         7/26/2006  10:01 AM         30 filenoext
-a---         8/18/2006   9:02 AM         52 temp.ps1
-a---         8/18/2006   9:02 AM         52 temp.msh
-a---          9/6/2006   3:33 PM         56 fivewords.txt
-a---         7/26/2006   9:28 AM         80 date.csv
-a---         7/29/2006   7:15 PM         84 test2.txt
-a---         7/29/2006   7:15 PM         84 test.ps1
```

This command displays the files in the current directory in ascending order by file length.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-process | sort-object -property WS | select-object -last 5

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
1105      25    44236      18932   197    93.81      2032 iexplore
2526      66    37668      36836   221   393.27       868 svchost
974       19    22844      45928   371    88.39      3952 WINWORD
1371      22    42192      61872   323    75.75      1584 INFOPATH
2145      58    93088      70680   619   396.69      3908 OUTLOOK
```

This command displays the five processes on the computer with the greatest memory use based on the size of their working sets.

The command uses the Get-Process cmdlet to get a list of processes.
It uses a pipeline operator (|) to send the results to the Sort-Object cmdlet, which sorts the objects in working-set order.

Another pipeline operator sends the results to the Select-Object, which displays only the last five items in the list.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-history | sort-object -descending

Id CommandLine
-- -----------
51 get-history | sort -descending
50 get-history | sort -descending
49 get-history | sort -descending
48 get-history | sort -descending
47 get-history | sort -descending
46 get-history | sort -descending
45 get-history | sort -descending
44 cd $pshome
43 get-childitem | sort-object
42 gci *.txt
```

This command sorts HistoryInfo objects using the Id property as the default key.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>get-service | sort-object -property @{Expression="Status";Descending=$true}, @{Expression="DisplayName";Descending=$false}

Status   Name               DisplayName
------   ----               -----------
Running  ALG                Application Layer Gateway Service
Running  Ati HotKey Poller  Ati HotKey Poller
Running  wuauserv           Automatic Updates
Running  BITS               Background Intelligent Transfer Ser...
Running  Client for NFS     Client for NFS
...
Stopped  clr_optimizatio... .NET Runtime Optimization Service v...
Stopped  Alerter            Alerter
Stopped  AppMgmt            Application Management
Stopped  aspnet_state       ASP.NET State Service
Stopped  ATI Smart          ATI Smart
Stopped  ClipSrv            ClipBook
```

This command displays the services on the computer in descending Status order and ascending DisplayName order.

The command uses the Get-Service cmdlet to get the services on the computer.
It uses a pipeline operator (|) to send services to the Sort-Object cmdlet.

To sort one property in ascending order and another property in descending order, the command uses a hash table for the value of the Property parameter.
The hash table uses an Expression key to specify the property name and an Ascending or Descending key to specify the sort order.

The resulting display, which sorts the Status values in descending order, lists properties with a Status value of "Running" before those with a Status value of "Stopped".
When sorted in ascending order, "Stopped" appears before "Running", because Status is an enumerated property in which the value of "Stopped" (1) is less than the value of "Running" (4).

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>get-childitem *.txt | sort-object -property @{Expression={$_.LastWriteTime - $_.CreationTime}; Ascending=$false} | Format-Table LastWriteTime, CreationTime

LastWriteTime                           CreationTime
-------------                           ------------
2/21/2006 10:22:20 AM                   10/3/2005 4:19:40 PM
2/27/2006 8:14:24 AM                    2/23/2006 10:41:08 PM
2/24/2006 1:26:19 PM                    2/23/2006 11:23:36 PM
1/5/2006 12:01:35 PM                    1/5/2006 11:35:30 AM
2/24/2006 9:25:40 AM                    2/24/2006 9:22:24 AM
2/24/2006 9:40:01 AM                    2/24/2006 9:39:41 AM
2/21/2006 10:21:30 AM                   2/21/2006 10:21:30 AM
```

This command sorts text files in descending order by the time span between CreationTime and LastWriteTime.

### -------------------------- EXAMPLE 7 --------------------------
```
PS C:\>get-content servers.txt

localhost
test01
server01
server02
localhost
server01

PS C:\>get-content servers.txt | sort-object -unique

localhost
server01
server02
test01
```

These commands sort the names of servers in a text file.
The second command uses the Sort-Object cmdlet with the Unique parameter to return a sorted list without duplicates.

## PARAMETERS

### -CaseSensitive
Indicates that the sort should be case sensitive.
By default, sorting is not case sensitive.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Culture
Specifies the cultural configuration to use when sorting.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Descending
Sorts the objects in descending order.
The default is ascending order.

The Descending parameter applies to all properties.
To sort by some properties in

ascending order and others in descending order, you must specify their property values by using a hash table.
For details, see the examples.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to be sorted.

When you use the InputObject parameter to submit a collection of items, Sort-Object receives one object that represents the collection.
Because one object cannot be sorted, Sort-Object returns the entire collection unchanged.

To sort objects, pipe them to Sort-Object.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Property
Specifies the properties to use when sorting.
Objects are sorted based on the values of these properties.
Enter the names of the properties.
Wildcards are permitted.

If you specify multiple properties, the objects are first sorted by the first property.
If more than one object has the same value for the first property, those objects are sorted by the second property.
This process continues until there are no more specified properties or no groups of objects.

If you do not specify properties, the cmdlet sorts based on default properties for the object type.

The value of the Property parameter can be a calculated property.
To create a calculated, property, use a hash table.
Valid keys are:

-- Expression \<string\> or \<script block\>
-- Ascending \<Boolean\>
-- Descending \<Boolean\>

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Unique
Eliminates duplicates and returns only the unique members of the collection.
You can use this parameter instead of using the Get-Unique cmdlet.

This parameter is case-insensitive.
As a result, strings that differ only in character casing are considered to be the same (not unique).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe the objects to be sorted to Sort-Object.

## OUTPUTS

### System.Management.Automation.PSObject
Sort-Object returns the sorted objects.

## NOTES
Sort-Object sorts objects based on the properties that you specify or the default sort properties for objects of that type.

If an object does not have one of the specified properties, the property value for that object is interpreted by the cmdlet as NULL and is placed at the end of the sort order.

When sorting objects, Sort-Object uses the Compare method for each property.
If a property does not implement IComparable, the cmdlet converts the property value to a string and uses the Compare method for System.String

The Sort-Object cmdlet sorts objects in ascending or descending order based on the values of properties of the object.

If you sort on a property whose value is an enumeration, Sort-Object sorts the enumeration values in numeric order; it does not sort the enumeration member names.
For example, if you sort services by status, services with a status of "Stopped" appear before services with a status of "Running", because the value of Status is a ServiceControllerStatus enumeration, in which "Stopped" has a value of 1 and "Running" has a value of 4.

## RELATED LINKS

[Group-Object]()

