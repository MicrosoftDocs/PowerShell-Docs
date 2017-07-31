---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Hash_Tables
---

# About Hash Tables
## about_Hash_Tables


## SHORT DESCRIPTION
Describes how to create, use, and sort hash tables in Windows PowerShell.


## LONG DESCRIPTION
A hash table, also known as a dictionary or associative array, is a compact data structure that stores one or more key\/value pairs. For example, a hash table might contain a series of IP addresses and computer names, where the IP addresses are the keys and the computer names are the values, or vice versa.

In Windows PowerShell, each hash table is a Hashtable (System.Collections.Hashtable) object.  You can use the properties and methods of Hashtable objects in Windows PowerShell.

Beginning in Windows PowerShell 3.0, you can use the [ordered] attribute to create an ordered dictionary (System.Collections.Specialized.OrderedDictionary) in Windows PowerShell.

Ordered dictionaries differ from hash tables in that the keys always appear in the order in which you list them. The order of keys in a hash table is not determined.

The keys and value in hash tables are also .NET objects. They are most often strings or integers, but they can have any object type. You can also create nested hash tables, in which the value of a key is another hash table.

Hash tables are frequently used because they are very efficient for finding and retrieving data. You can use hash tables to store lists and to create calculated properties in Windows PowerShell. And, Windows PowerShell has a cmdlet, ConvertFrom-StringData, that converts strings to a hash table.


### Syntax
The syntax of a hash table is as follows:


```
@{ <name> = <value>; [<name> = <value> ] ...}
```


The syntax of an ordered dictionary is as follows:


```
[ordered]@{ <name> = <value>; [<name> = <value> ] ...}
```


The [ordered] attribute was introduced in Windows PowerShell 3.0.


### Creating Hash Tables
To create a hash table, follow these guidelines:

- Begin the hash table with an at sign (@).

- Enclose the hash table in braces ({}).

- Enter one or more key\/value pairs for the content of the hash table.

- Use an equal sign (\=) to separate each key from its value.

- Use a semicolon (;) or a line break to separate the key\/value pairs.

- Key that contains spaces must be enclosed in quotation marks. Values must be valid Windows PowerShell expressions. Strings must appear in quotation marks, even if they do not include spaces.

- To manage the hash table, save it in a variable.

- When assigning an ordered hash table to a variable, place the [ordered] attribute before the "@" symbol. If you place it before the variable name, the command fails.

To create an empty hash table in the value of $hash, type:


```
$hash = @{}
```


You can also add keys and values to a hash table when you create it. For example, the following statement creates a hash table with three keys.


```
$hash = @{ Number = 1; Shape = "Square"; Color = "Blue"}
```



### Creating Ordered Dictionaries
You can create an ordered dictionary by adding an object of the OrderedDictionary type, but the easiest way to create an ordered dictionary is use the [Ordered] attribute.

The [ordered] attribute is introduced in Windows PowerShell 3.0.

Place the attribute immediately before the "@" symbol.


```
$hash = [ordered]@{ Number = 1; Shape = "Square"; Color = "Blue"}
```


You can use ordered dictionaries in the same way that you use hash tables. Either type can be used as the value of parameters that take a hash table or dictionary (iDictionary).

You cannot use the [ordered] attribute to convert or cast a hash table. If you place the ordered attribute before the variable name, the command fails with the following error message.


```
PS C:\> [ordered]$hash = @{}  
At line:1 char:1  
+ [ordered]$hash = @{}  
+ [!INCLUDE[]()]  
The ordered attribute can be specified only on a hash literal node.  
+ CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException  
+ FullyQualifiedErrorId : OrderedAttributeOnlyOnHashLiteralNode
```


To correct the expression, move the [ordered] attribute.


```
PS C:\> $hash = [ordered]@{}
```


You can cast an ordered dictionary to a hash table, but you cannot recover the ordered attribute, even if you clear the variable and enter new values. To re-establish the order, you must remove and recreate the variable.


```
PS C:\> [hashtable]$hash = [ordered]@{ Number = 1; Shape = "Square"; Color = "Blue"}  
PS C:\ps-test> $hash  
  
Name                           Value  
----                           -----  
Color                          Blue  
Shape                          Square  
Number                         1
```



### Displaying Hash Tables
To display a hash table that is saved in a variable, type the variable name. By default, a hash tables is displayed as a table with one column for keys and one for values.


```
C:\PS> $hash  
  
Name                           Value  
----                           -----  
Shape                          Square  
Color                          Blue  
Number                         1
```


Hash tables have Keys and Values properties. Use dot notation to display all of the keys or all of the values.


```
C:\PS> $hash.keys  
Number  
Shape  
Color  
  
C:\PS> $hash.values  
1  
Square  
Blue
```


Each key name is also a property of the hash table, and its value is the value of the key-name property. Use the following format to display the property values.


```
$hashtable.<key>  
<value>
```


For example:


```
C:\PS> $hash.Number  
1  
  
C:\PS> $hash.Color  
Blue
```


Hash tables have a Count property that indicates the number of key-value pairs in the hash table.


```
C:\PS> $hash.count  
3
```


Hash table tables are not arrays, so you cannot use an integer as an index into the hash table, but you can use a key name to index into the hash table. If the key is a string value, enclose the key name in quotation marks.

For example:


```
C:\PS> $hash["Number"]  
1
```



### Adding and Removing Keys and Values
To add keys and values to a hash table, use the following command format.


```
$hash["<key>"] = "<value>"
```


For example, to add a "Time" key with a value of "Now" to the hash table, use the following statement format.


```
$hash["Time"] = "Now"
```


You can also add keys and values to a hash table by using the Add method of the System.Collections.Hashtable object. The Add method has the following syntax:


```
Add(Key, Value)
```


For example, to add a "Time" key with a value of "Now" to the hash table, use the following statement format.


```
$hash = $hash.Add("Time", "Now")
```


And, you can add keys and values to a hash table by using the addition operator (\+) to add a hash table to an existing hash table. For example, the following statement adds a "Time" key with a value of "Now" to the hash table in the $hash variable.


```
$hash = $hash + @{Time="Now"}
```


You can also add values that are stored in variables.


```
$t = "Today"  
$now = (Get-Date)  
  
$hash.Add($t, $now)
```


You cannot use a subtraction operator to remove a key\/value pair from a hash table, but you can use the Remove method of the Hashtable object. The Remove method takes the key as its value.

The Remove method has the following syntax:


```
Remove(Key)
```


For example, to remove the Time\=Now key\/value pair from the hash table in the value of the $hash variable, type:


```
$hash.$Remove("Time")
```


You can use all of the properties and methods of Hashtable objects in Windows PowerShell, including Contains, Clear, Clone, and CopyTo. For more information about Hashtable objects, see [System.Collections.Hashtable](http://msdn.microsoft.com/en-us/library/system.collections.hashtable\(v=vs.110\).aspx) on MSDN.


### Object Types in HashTables
The keys and values in a hash table can have any .NET object type, and a single hash table can have keys and values of multiple types.

The following statement creates a hash table of process name strings and process object values and saves it in the $p variable.


```
$p = @{"PowerShell" = (get-process PowerShell);   
"Notepad" = (get-process notepad)}
```


You can display the hash table in $p and use the key-name properties to display the values.


```
C:\PS> $p  
  
Name                           Value  
----                           -----  
PowerShell                     System.Diagnostics.Process (PowerShell)  
Notepad                        System.Diagnostics.Process (notepad)  
  
C:\PS> $p.PowerShell          
  
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName  
-------  ------    -----      ----- -----   ------     -- -----------  
    441      24    54196      54012   571     5.10   1788 PowerShell  
  
C:\PS> $p.keys | foreach {$p.$_.handles}  
441  
251
```


The keys in a hash table can also be any .NET type. The following statement adds a key\/value pair to the hash table in the $p variable. The key is a Service object that represents the WinRM service, and the value is the current status of the service.


```
C:\PS> $p = $p + @{(Get-Service WinRM) = ((Get-Service WinRM).Status)}
```


You can display and access the new key\/value pair by using the same methods that you use for other pairs in the hash table.


```
C:\PS> $p  
  
Name                           Value  
----                           -----  
PowerShell                     System.Diagnostics.Process (PowerShell)  
Notepad                        System.Diagnostics.Process (notepad)  
System.ServiceProcess.Servi... Running  
  
C:\PS> $p.keys  
PowerShell  
Notepad  
  
Status   Name               DisplayName  
------   ----               -----------  
Running  winrm              Windows Remote Management (WS-Manag...  
  
C:\PS> $p.keys | foreach {$_.name}  
winrm
```


The keys and values in a hash table can also be Hashtable objects. The following statement adds key\/value pair to the hash table in the $p variable in which the key is a string, Hash2, and the value is a hash table with three key\/value pairs.


```
C:\PS> $p = $p + @{"Hash2"= @{a=1; b=2; c=3}}
```


You can display and access the new values by using the same methods.


```
C:\PS> $p  
  
Name                           Value  
----                           -----  
PowerShell                     System.Diagnostics.Process (PowerShell)  
Notepad                        System.Diagnostics.Process (notepad)  
System.ServiceProcess.Servi... Running  
Hash2                          {a, b, c}  
  
C:\PS> $p.Hash2  
  
Name                           Value  
----                           -----  
a                              1  
b                              2  
c                              3  
  
C:\PS> $p.Hash2.b  
2
```



### Sorting Keys and Values
The items in a hash table are intrinsically unordered. The key\/value pairs might appear in a different order each time that you display them.

Although you cannot sort a hash table, you can use the GetEnumerator method of hash tables to enumerate the keys and values, and then use the Sort-Object cmdlet to sort the enumerated values for display.

For example, the following commands enumerate the keys and values in the hash table in the $p variable and then sort the keys in alphabetical order.


```
C:\PS> $p.GetEnumerator() | Sort-Object -Property key  
  
Name                           Value  
----                           -----  
Notepad                        System.Diagnostics.Process (notepad)  
PowerShell                     System.Diagnostics.Process (PowerShell)  
System.ServiceProcess.Servi... Running
```


The following command uses the same procedure to sort the hash values in descending order.


```
C:\PS> $p.getenumerator() | Sort-Object -Property Value -Descending  
  
Name                           Value  
----                           -----  
PowerShell                     System.Diagnostics.Process (PowerShell)  
Notepad                        System.Diagnostics.Process (notepad)  
System.ServiceProcess.Servi... Running
```



### Creating Objects from Hash Tables
Beginning in Windows PowerShell 3.0, you can create an object from a hash table of properties and property values.

The syntax is as follows:


```
[<class-name>]@{<property-name>=<property-value>;<property-name>=<property-value>}
```


This method works only for classes that have a null constructor, that is, a constructor that has no parameters. The object properties must be public and settable.

For more information, see [about_Object_Creation](about_Object_Creation.md).


### ConvertFrom-StringData
The ConvertFrom-StringData cmdlet converts a string or a here-string of key\/value pairs into a hash table. You can use the ConvertFrom-StringData cmdlet safely in the Data section of a script, and you can use it with the Import-LocalizedData cmdlet to display user messages in the user-interface (UI) culture of the current user.

Here-strings are especially useful when the values in the hash table include quotation marks. (For more information about here-strings, see [about_Quoting_Rules](about_Quoting_Rules.md).)

The following example shows how to create a here-string of the user messages in the previous example and how to use ConvertFrom-StringData to convert them from a string into a hash table.

The following command creates a here-string of the key\/value pairs and then saves it in the $string variable.


```
C:\PS> $string = @"  
Msg1 = Type "Windows".  
Msg2 = She said, "Hello, World."  
Msg3 = Enter an alias (or "nickname").  
"@
```


This command uses the ConvertFrom-StringData cmdlet to convert the here-string into a hash table.


```
C:\PS> ConvertFrom-StringData $string  
  
Name                           Value  
----                           -----  
Msg3                           Enter an alias (or "nickname").  
Msg2                           She said, "Hello, World."  
Msg1                           Type "Windows".
```


For more information about here-strings, see [about_Quoting_Rules](about_Quoting_Rules.md).


## SEE ALSO

[about_Arrays](about_Arrays.md)

[about_Object_Creation](about_Object_Creation.md)

[about_Quoting_Rules](about_Quoting_Rules.md)

[about_Script_Internationalization](about_Script_Internationalization.md)

[ConvertFrom-StringData](../../Microsoft.PowerShell.Utility/ConvertFrom-StringData.md)

[Import-LocalizedData](../../Microsoft.PowerShell.Utility/Import-LocalizedData.md)

[System.Collections.Hashtable](http://msdn.microsoft.com/en-us/library/system.collections.hashtable\(v=vs.110\).aspx) on MSDN

