---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293980
schema: 2.0.0
---

# Group-Object
## SYNOPSIS
Groups objects that contain the same value for specified properties.

## SYNTAX

```
Group-Object [-NoElement] [-AsHashTable] [-AsString] [-InputObject <PSObject>] [[-Property] <Object[]>]
 [-Culture <String>] [-CaseSensitive] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Group-Object cmdlet displays objects in groups based on the value of a specified property.
Group-Object returns a table with one row for each property value and a column that displays the number of items with that value.

If you specify more than one property, Group-Object first groups them by the values of the first property, and then, within each property group, it groups by the value of the next property.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-childitem *.doc | group-object -property length
```

This command gets the files in the current location that have a .doc extension and groups them by size.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-childitem | sort-object -property extension | group-object -property extension
```

This command gets the files in the current location, sorts them by file name extension, and then groups them by file name extension.
Note that the files are sorted before they are grouped.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>1..35 | group-object -property {$_ % 2},{$_ % 3}
```

This example shows how to use script blocks as the value of the Property parameter.

This command displays the integers from 1 to 35, grouped by the remainder left when they are divided by 2 or 3.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>$events = get-eventlog -logname system -newest 1000
PS C:\>$events | group-object -property eventID

Count Name                      Group
----- ----                      -----
44 Information               {System.Diagnostics.EventLogEntry,
5 Error                     {System.Diagnostics.EventLogEntry,
1 Warning                   {System.Diagnostics.EventLogEntry}
```

These commands display the 1,000 most recent entries in the System event log, grouped by Event ID.

The first command uses the Get-EventLog cmdlet to retrieve the events and the assignment operator (=) to save them in the $events variable.

The second command uses a pipeline operator (|) to send the events in the $events variable to the Group-Object cmdlet.
The command uses the Property parameter to specify that the events should be grouped according to the value of their EventID property.

In the output, the Count column represents the number of entries in each group, the Name column represents the EventID values that define a group, and the Group column represents the objects in each group.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>get-process | group-object -property priorityclass

Count Name                Group
----- ----                -----
55 Normal              {System.Diagnostics.Process (AdtAgent), System.Diagnostics.Process (alg), System.Dia...
1                     {System.Diagnostics.Process (Idle)}
3 High                {System.Diagnostics.Process (Newproc), System.Diagnostics.Process (winlogon), System.D...
2 BelowNormal         {System.Diagnostics.Process (winperf),

PS C:\>get-process | group-object -property company -noelement

Count Name
----- ----
55 Normal
1
3 High
2 BelowNormal
```

This example demonstrates the effect of the NoElement parameter.
These commands group the processes on the computer by priority class.

The first command uses the Get-Process cmdlet to get the processes on the computer.
It uses a pipeline operator (|) to send the results to Group-Object, which groups the objects by the value of the PriorityClass property of the process.

The second command is identical to the first, except that it uses the NoElement parameter to eliminate the members of the group from the output.
The result is a table with only the count and property value name.

The results are shown in the following sample output.

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>get-eventlog -logname system -newest 1000 | group-object -property {$_.TimeWritten - $_.TimeGenerated}
```

This command demonstrates how to provide the value of the Property parameter as a script block.

This command displays the most recent 1,000 entries from the system event log, grouped according to the time between when they were generated and when they were written to the log.

The command uses the Get-EventLog cmdlet to get the event log entries.
It uses a pipeline operator (|) to send the entries to the Group-Object cmdlet.
The value of the Property parameter is specified as a script block (an expression in braces).
The result of evaluating the script block is the time between when the log entry was generated and when it was written to the log.
That value is used to group the 1,000 most recent events.

### -------------------------- EXAMPLE 7 --------------------------
```
PS C:\>get-childitem | group-object extension -noelement

Count Name
----- ----
21
82 .txt
9 .cmd
5 .log
12 .xml
5 .htm
36 .ps1
1 .psc1
3 .exe
6 .csv
1 .psd1
2 .bat
```

This command groups the items in the current directory by file name extension.
It uses the NoElement parameter to omit the members of the group.

The results are shown in the following sample output.

### -------------------------- EXAMPLE 8 --------------------------
```
PS C:\>"a", "b", "c", "c", "d" | get-unique
a
b
c
d

PS C:\>"a", "b", "c", "c", "d" | group-object -noelement | where {$_.Count -gt 1}

Count Name
----- ----
2 c

PS C:\>get-process | group-object -property Name -noelement | where {$_.count -gt 1}

Count Name
----- ----
2 csrss
5 svchost
2 winlogon
2 wmiprvse
```

This example shows how to find the unique and non-unique (repeated) property values in a collection.

The first command gets the unique elements of an array by piping the array to the Get-Unique cmdlet.

The second command gets the non-unique elements of an array.
It pipes the array to the Group-Object cmdlet, which groups the objects by value.
The resulting groups are piped to the Where-Object cmdlet, which selects objects with groups with more than one member.

The third command shows a practical use for this technique.
It uses the same method to find processes on the computer that have the same process name.

The results are shown in the following sample output.

### -------------------------- EXAMPLE 9 --------------------------
```
PS C:\>$a = get-command get-*, set-* -type cmdlet | group-object -property verb -ashashtable -asstring
PS C:\>$a

Name    Value
----    -----
Get     {Get-PSCallStack, Get-PSBreakpoint, Get-PSDrive, Get-PSSession...}
Set     {Set-Service, Set-StrictMode, Set-PSDebug, Set-PSSessionConfiguration...}

PS C:\>$a.get

CommandType     Name                 Definition
-----------     ----                 ----------
Cmdlet          Get-PSCallStack      Get-PSCallStack [-Verbose] [-Debug] [-ErrorAction <ActionPrefer...
Cmdlet          Get-PSBreakpoint     Get-PSBreakpoint [[-Id] <Int32[]>] [-Verbose] [-Debug] [-ErrorA...
Cmdlet          Get-PSDrive          Get-PSDrive [[-Name] <String[]>] [-Scope <String>] [-PSProvider...
...
```

This example uses the AsHashTable and AsString parameters to return the groups in a hash table, that is, as a collection of key-value pairs.

In the resulting hash table, each property value is a key, and the group elements are the values.
Because each key is a property of the hash table object, you can use dot notation to display the values.

The first command gets the Get and Set cmdlets in the session, groups them by verb, returns the groups as a hash table, and saves the hash table in the $a variable.

The second command displays the hash table in $a.
There are two key-value pairs, one for the Get cmdlets and one for the Set cmdlets.

The third command uses dot notation to display the values of the Get key in $a.
The values are CmdletInfo object.
The AsString parameter does not convert the objects in the groups to strings.

## PARAMETERS

### -AsHashTable
Returns the group as a hash table. 
The keys of the hash table are the property values by which the objects are grouped.
The values of the hash table are the objects that have that property value.

By itself, the AsHashTable parameter returns each hash table in which each key is an instance of the grouped object.
When used with the  AsString parameter, the keys in the hash table are strings.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: AHT

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsString
Converts the hash table keys to strings.
By default, the hash table keys are instances of the grouped object.
This parameter is valid only when used with the AsHashTable parameter.

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

### -CaseSensitive
Makes the grouping case-sensitive.
Without this parameter, the property values of objects in a group might have different cases.

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
Specifies the culture to use when comparing strings.

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

### -InformationAction
By itself, the AsHashTable parameter returns each hash table in which each key is an instance of the grouped object.
When used with the  AsString parameter, the keys in the hash table are strings.

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
By itself, the AsHashTable parameter returns each hash table in which each key is an instance of the grouped object.
When used with the  AsString parameter, the keys in the hash table are strings.

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
Specifies the objects to group.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

When you use the InputObject parameter to submit a collection of objects to Group-Object, Group-Object receives one object that represents the collection.
As a result, it creates a single group with that object as its member.

To group the objects in a collection, pipe the objects to Group-Object.

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

### -NoElement
Omits the members of a group from the results.

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

### -Property
Specifies the properties for grouping.
The objects are arranged into groups based on the value of the specified property.

The value of the Property parameter can be a new calculated property.
To create a calculated, property, create a hash table with an Expression key that specifies a string or script block value.

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

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to Group-Object

## OUTPUTS

### Microsoft.PowerShell.Commands.GroupInfo or System.Collections.Hashtable
When you use the AsHashTable parameter, Group-Object returns a hash table.
Otherwise, it returns a GroupInfo object.

## NOTES
You can also use the GroupBy parameter of the formatting cmdlets (such as Format-Table \[m2\] and Format-List \[m2\]) to group objects.
Unlike Group-Object, which creates a single table with a row for each property value, the GroupBy parameters create a table for each property value with a row for each item that has the property value.

Group-Object does not require that the objects being grouped be of the same Microsoft .NET Framework type.
When grouping objects of different .NET Framework types, Group-Object uses the following rules:

-- Same Property Names and Types: If the objects have a property with the specified name, and the property values have the same .NET Framework type, the property values are grouped by using the same rules that would be used for objects of the same type.
-- Same Property Names, Different Types: If the objects have a property with the specified name, but the property values have a different .NET Framework type in different objects, Group-Object uses the .NET Framework type of the first occurrence of the property as the .NET Framework type for that property group. When an object has a property with a different type, the property value is converted to the type for that group. If the type conversion fails, the object is not included in the group.
-- Missing Properties: Objects that do not have a specified property are considered ungroupable. Ungroupable objects appear in the final GroupInfo object output in a group named AutomationNull.Value.

## RELATED LINKS

