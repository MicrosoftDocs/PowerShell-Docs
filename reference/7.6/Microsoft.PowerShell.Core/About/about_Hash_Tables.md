---
description: Describes how to create, use, and sort hashtables in PowerShell.
Locale: en-US
ms.date: 01/19/2025
no-loc: [iDictionary, Hashtable, OrderedDictionary, System.Collections.IDictionary, System.Collections.Hashtable]
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Hash_Tables
---
# about_Hash_Tables

## Short description
Describes how to create, use, and sort hashtables in PowerShell.

## Long description

A hashtable, also known as a dictionary or associative array, is a compact data
structure that stores one or more key-value pairs. For example, a hash table
might contain a series of IP addresses and computer names, where the IP
addresses are the keys and the computer names are the values, or vice versa.

In PowerShell, each hashtable is a `[System.Collections.Hashtable]` object. You
can use the properties and methods of **Hashtable** objects in PowerShell.

Beginning in PowerShell 3.0, you can use the `[ordered]` type accelerator to
create an `[System.Collections.Specialized.OrderedDictionary]` object in
PowerShell.

Ordered dictionaries differ from hashtables in that the keys always appear in
the order in which you list them. The order of keys in a hashtable isn't
deterministic.

The keys and value in hashtables are also .NET objects. They're most often
strings or integers, but they can have any object type. You can also create
nested hashtables, in which the value of a key is another hashtable.

Hashtables are frequently used because they're efficient for finding and
retrieving data. You can use hashtables to store lists and to create calculated
properties in PowerShell. And, the `ConvertFrom-StringData` cmdlet converts
structured string data to a hashtable.

## Syntax

The syntax of a hashtable is as follows:

```powershell
@{ <name> = <value>; [<name> = <value> ] ...}
```

The syntax of an ordered dictionary is as follows:

```powershell
[ordered]@{ <name> = <value>; [<name> = <value> ] ...}
```

The `[ordered]` type accelerator was introduced in PowerShell 3.0.

To create a hashtable, follow these guidelines:

- Begin the hashtable with an at sign (`@`).
- Enclose the hashtable in braces (`{}`).
- Enter one or more key-value pairs for the content of the hashtable.
- Use an equal sign (`=`) to separate each key from its value.
- Use a semicolon (`;`) or a line break to separate the key-value pairs.
- Keys that contain spaces must be enclosed in quotation marks. Values must be
  valid PowerShell expressions. Strings must appear in quotation marks, even if
  they don't include spaces.
- To manage the hashtable, save it in a variable.
- When assigning an ordered hashtable to a variable, place the `[ordered]` type
  before the `@` symbol. If you place it before the variable name, the command
  fails.

You can use ordered dictionaries in the same way that you use hashtables.
Either type can be used as the value of parameters that take a hashtable or
dictionary (**iDictionary**) type objects.

## Creating hashtables and ordered dictionaries

Consider the following hashtable and ordered dictionary examples:

```powershell
$hash = @{
    1       = 'one'
    2       = 'two'
    'three' = 3
}
$hash
```

```Output
Name                           Value
----                           -----
three                          3
2                              two
1                              one
```

As you can see, the key-value pairs in a hashtable aren't presented in the
order that they were defined.

The easiest way to create an ordered dictionary is to use the `[ordered]`
attribute. Place the attribute immediately before the `@` symbol.

```powershell
$dictionary = [ordered]@{
    1       = 'one'
    2       = 'two'
    'three' = 3
}
$dictionary
```

```Output
Name                           Value
----                           -----
1                              one
2                              two
three                          3
```

Unlike hashtables, ordered dictionaries maintain the order of the key-value.

### Converting hashtables and ordered dictionaries

You can't use the `[ordered]` type accelerator to convert or cast a hashtable.
If you place the ordered attribute before the variable name, the command fails
with the following error message.

```powershell
[ordered]$orderedhash = @{}
ParserError:
Line |
   1 |  [ordered]$orderedhash = @{}
     |  ~~~~~~~~~~~~~~
     | The ordered attribute can be specified only on a hash literal node.
```

To correct the expression, move the [ordered] attribute.

```powershell
$orderedhash = [ordered]@{}
```

You can cast an ordered dictionary to a hashtable, but you can't guarantee the
order of the members.

```powershell
[hashtable]$newhash = [ordered]@{
    Number = 1
    Shape = "Square"
    Color = "Blue"
}
$newhash
```

```Output
Name                           Value
----                           -----
Color                          Blue
Shape                          Square
Number                         1
```

## Hashtable and dictionary properties

Hashtables and ordered dictionaries share several properties. Consider the
`$hash` and `$dictionary` variables defined in the previous examples.

```powershell
$hash | Get-Member -MemberType Properties, ParameterizedProperty
```

```Output
   TypeName: System.Collections.Hashtable

Name           MemberType            Definition
----           ----------            ----------
Item           ParameterizedProperty System.Object Item(System.Object key) {get;set;}
Count          Property              int Count {get;}
IsFixedSize    Property              bool IsFixedSize {get;}
IsReadOnly     Property              bool IsReadOnly {get;}
IsSynchronized Property              bool IsSynchronized {get;}
Keys           Property              System.Collections.ICollection Keys {get;}
SyncRoot       Property              System.Object SyncRoot {get;}
Values         Property              System.Collections.ICollection Values {get;}
```

```powershell
$dictionary | Get-Member -MemberType Properties, ParameterizedProperty
```

```Output
   TypeName: System.Collections.Specialized.OrderedDictionary

Name           MemberType            Definition
----           ----------            ----------
Item           ParameterizedProperty System.Object Item(int index) {get;set;},
                                     System.Object Item(System.Object key) {get;set;}
Count          Property              int Count {get;}
IsFixedSize    Property              bool IsFixedSize {get;}
IsReadOnly     Property              bool IsReadOnly {get;}
IsSynchronized Property              bool IsSynchronized {get;}
Keys           Property              System.Collections.ICollection Keys {get;}
SyncRoot       Property              System.Object SyncRoot {get;}
Values         Property              System.Collections.ICollection Values {get;}
```

The most-used properties are **Count**, **Keys**, **Values**, and **Item**.

- The **Count** property that indicates the number of key-value pairs in the
  object.

- The **Keys** property is a collection of the key names in the hashtable or
  dictionary.

  ```powershell
  PS> $hash.Keys
  three
  2
  1

  PS> $dictionary.Keys
  1
  2
  three
  ```

- The **Values** property is a collection of the values in the hashtable or
  dictionary.

  ```powershell
  PS> $hash.Values
  3
  two
  one

  PS> $dictionary.Values
  one
  two
  3
  ```

- The **Item** property is a parameterized property that returns the value of
  the item that you specify. Hashtables use the key as the parameter to the
  parameterized property, while dictionaries use the index by default. This
  difference affects how you access the values for each type.

## Accessing values

There are two common ways to access the values in a hashtable or dictionary:
member notation or array index notation.

- **Member notation** - Values can be accessed by using the key name as a
  member property of the object. For example:

  ```powershell
  PS> $hash.1
  one

  PS> $dictionary.2
  two
  ```

- **Array index notation** - Values can be accessed by using index notation.
  PowerShell converts that notation into a call to **Item** parameterized
  property of the object.

  When you use index notation with hashtables, the value inside of the brackets
  is the key name. If the key is a string value, enclose the key name in
  quotes. For example:

  ```powershell
  PS> $hash['three']
  3

  PS> $hash[2]
  two
  ```

  In this example, the key value `2` isn't an index into the collection of
  values. It's the value of the key in the key-value pair. You can prove this
  by indexing into the collection of values.

  ```powershell
  PS> ([array]$hash.Values)[2]
  one
  ```

  When you use index notation with dictionaries, the value inside of the
  brackets is interpreted based on its type. If the value is an integer, it's
  treated as an index into the collection of values. If the value isn't an
  integer, it's treated as the key name. For example:

  ```powershell
  PS> $dictionary[1]
  two
  PS> ([array]$dictionary.Values)[1]
  two
  PS> $dictionary[[object]1]
  one
  PS> $dictionary['three']
  3
  ```

  In this example, the array value `[1]` is an index into the collection of
  values using the `Item(int index)` parameterized property overload. The array
  value `[[object]1]` isn't an index but a key value using the
  `Item(System.Object key)` overload.

  > [!NOTE]
  > This behavior can be confusing when the key value is an integer. When
  > possible, you should avoid using integer key values in dictionaries.

### Handling property name collisions

If the key name collides with one of the property names of the **HashTable**
type, you can use the **psbase** [intrinsic member](about_Intrinsic_Members.md)
to access those properties. For example, if the key name is `keys` and you want
to return the collection of the **HashTable** keys, use this syntax:

```powershell
$hashtable.psbase.Keys
```

This requirement applies for other types that implement the
**System.Collections.IDictionary** interface, like **OrderedDictionary**.

## Iterating over keys and values

You can iterate over the keys in a hashtable to process the values in several
ways. Each of the examples in this section has identical output. They iterate
over the `$hash` variable defined here:

```powershell
$hash = [ordered]@{ Number = 1; Shape = "Square"; Color = "Blue"}
```

> [!NOTE]
> In these examples, `$hash` is defined as an ordered dictionary to ensure the
> output is always in the same order. These examples work the same for standard
> hashtables, but the order of the output isn't predictable.

Each example returns a message for every key and its value:

```output
The value of 'Number' is: 1
The value of 'Shape' is: Square
The value of 'Color' is: Blue
```

This example uses a `foreach` block to iterate over the keys.

```powershell
foreach ($Key in $hash.Keys) {
    "The value of '$Key' is: $($hash[$Key])"
}
```

This example uses `ForEach-Object` to iterate over the keys.

```powershell
$hash.Keys | ForEach-Object {
    "The value of '$_' is: $($hash[$_])"
}
```

This example uses the `GetEnumerator()` method to send each key-value pair
through the pipeline to `ForEach-Object`.

```powershell
$hash.GetEnumerator() | ForEach-Object {
    "The value of '$($_.Key)' is: $($_.Value)"
}
```

This example uses the `GetEnumerator()` and `ForEach()` methods to iterate over
each key-value pair.

```powershell
$hash.GetEnumerator().ForEach({"The value of '$($_.Key)' is: $($_.Value)"})
```

## Adding and Removing Keys and Values

Typically, when you create a hashtable you include the key-value pairs in the
definition. However, you can add and remove key-value pairs from a hashtable at
any time. The following example creates an empty hashtable.

```powershell
$hash = @{}
```

You can add key-value pairs using array notation. For example, the following
example adds a `Time` key with a value of `Now` to the hashtable.

```powershell
$hash["Time"] = "Now"
```

You can also add keys and values to a hashtable using the `Add()` method of the
**System.Collections.Hashtable** object. The `Add()` method has the following
syntax:

```powershell
Add(Key, Value)
```

For example, to add a `Time` key with a value of `Now` to the hashtable, use
the following statement format.

```powershell
$hash.Add("Time", "Now")
```

And, you can add keys and values to a hashtable using the addition operator
(`+`) to add a hashtable to an existing hashtable. For example, the following
statement adds a `Time` key with a value of `Now` to the hashtable in the
`$hash` variable.

```powershell
$hash = $hash + @{Time="Now"}
```

You can also add values that are stored in variables.

```powershell
$t = "Today"
$now = (Get-Date)

$hash.Add($t, $now)
```

You can't use a subtraction operator to remove a key-value pair from a hash
table, but you can use the `Remove()` method of the hashtable object. The
`Remove` method has the following syntax:

```
$object.Remove(<key>)
```

The following example removes the `Time` key-value pair from `$hash`.

```powershell
$hash.Remove("Time")
```

## Object Types in HashTables

The keys and values in a hashtable can have any .NET object type, and a single
hashtable can have keys and values of multiple types.

The following statement creates a hashtable of process name strings and process
object values and saves it in the `$p` variable.

```powershell
$p = @{
    "PowerShell" = (Get-Process PowerShell)
    "Notepad" = (Get-Process notepad)
}
```

You can display the hashtable in `$p` and use the key-name properties to
display the values.

```powershell
PS> $p

Name                           Value
----                           -----
PowerShell                     System.Diagnostics.Process (PowerShell)
Notepad                        System.Diagnostics.Process (notepad)

PS> $p.PowerShell

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    441      24    54196      54012   571     5.10   1788 PowerShell

PS> $p.keys | ForEach-Object {$p.$_.handles}
441
251
```

The keys in a hashtable can be any .NET type. The following statement adds a
key-value pair to the hashtable in the `$p` variable. The key is a **Service**
object that represents the WinRM service, and the value is the current status
of the service.

```powershell
$p = $p + @{
    (Get-Service WinRM) = ((Get-Service WinRM).Status)
}
```

You can display and access the new key-value pair using the same methods that
you use for other pairs in the hashtable.

```powershell
PS> $p

Name                           Value
----                           -----
PowerShell                     System.Diagnostics.Process (PowerShell)
Notepad                        System.Diagnostics.Process (notepad)
System.ServiceProcess.Servi... Running

PS> $p.keys
PowerShell
Notepad

Status   Name               DisplayName
------   ----               -----------
Running  winrm              Windows Remote Management (WS-Manag...

PS> $p.keys | ForEach-Object {$_.name}
WinRM
```

The keys and values in a hashtable can also be Hashtable objects. The following
statement adds key-value pair to the hashtable in the `$p` variable in which
the key is a string, Hash2, and the value is a hashtable with three key-value
pairs.

```powershell
$p = $p + @{
    "Hash2"= @{a=1; b=2; c=3}
}
```

You can display and access the new values using the same methods.

```powershell
PS> $p

Name                           Value
----                           -----
PowerShell                     System.Diagnostics.Process (pwsh)
Hash2                          {[a, 1], [b, 2], [c, 3]}
Notepad                        System.Diagnostics.Process (Notepad)
WinRM                          Running

PS> $p.Hash2

Name                           Value
----                           -----
a                              1
b                              2
c                              3

PS> $p.Hash2.b
2
```

## Sorting Keys and Values

The items in a hashtable are intrinsically unordered. The key-value pairs might
appear in a different order each time that you display them.

Although you can't sort a hashtable, you can use the `GetEnumerator()` method
of hashtables to enumerate the keys and values, and then use the `Sort-Object`
cmdlet to sort the enumerated values for display.

For example, the following commands enumerate the keys and values in the hash
table in the `$p` variable and then sort the keys in alphabetical order.

```powershell
PS> $p.GetEnumerator() | Sort-Object -Property key

Name                           Value
----                           -----
Hash2                          {[a, 1], [b, 2], [c, 3]}
Notepad                        System.Diagnostics.Process (Notepad)
PowerShell                     System.Diagnostics.Process (pwsh)
WinRM                          Running
```

The following command uses the same procedure to sort the hash values in
descending order.

```powershell
PS> $p.GetEnumerator() | Sort-Object -Property Value -Descending

Name                           Value
----                           -----
PowerShell                     System.Diagnostics.Process (pwsh)
Notepad                        System.Diagnostics.Process (Notepad)
Hash2                          {[a, 1], [b, 2], [c, 3]}
WinRM                          Running
```

## Creating Objects from hashtables

Beginning in PowerShell 3.0, you can create an object from a hashtable of
properties and property values.

The syntax is as follows:

```powershell
[<class-name>]@{
  <property-name>=<property-value>
  <property-name>=<property-value>
}
```

This method works only for classes that have a constructor that has no
parameters. The object properties must be public and settable.

For more information, see [about_Object_Creation](about_Object_Creation.md).

## ConvertFrom-StringData

The `ConvertFrom-StringData` cmdlet converts a string or a here-string of
key-value pairs into a hashtable. You can use the `ConvertFrom-StringData`
cmdlet safely in the Data section of a script, and you can use it with the
`Import-LocalizedData` cmdlet to display user messages in the user-interface
(UI) culture of the current user.

Here-strings are especially useful when the values in the hashtable include
quotation marks. For more information about here-strings, see
[about_Quoting_Rules](about_Quoting_Rules.md).

The following example shows how to create a here-string of the user messages in
the previous example and how to use `ConvertFrom-StringData` to convert them
from a string into a hashtable.

The following command creates a here-string of the key-value pairs and then
saves it in the `$string` variable.

```powershell
$string = @"
Msg1 = Type "Windows".
Msg2 = She said, "Hello, World."
Msg3 = Enter an alias (or "nickname").
"@
```

This command uses the `ConvertFrom-StringData` cmdlet to convert the
here-string into a hashtable.

```powershell
ConvertFrom-StringData $string

Name                           Value
----                           -----
Msg3                           Enter an alias (or "nickname").
Msg2                           She said, "Hello, World."
Msg1                           Type "Windows".
```

For more information about here-strings, see
[about_Quoting_Rules](about_Quoting_Rules.md).

## See also

- [about_Arrays](about_Arrays.md)
- [about_Intrinsic_Members](about_Intrinsic_Members.md)
- [about_Object_Creation](about_Object_Creation.md)
- [about_Quoting_Rules](about_Quoting_Rules.md)
- [about_Script_Internationalization](about_Script_Internationalization.md)
- [Import-LocalizedData](xref:Microsoft.PowerShell.Utility.Import-LocalizedData)
- [ConvertFrom-StringData](xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData)
- [System.Collections.Hashtable](/dotnet/api/system.collections.hashtable)
