---
ms.date:  12/091/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Type_Operators
---
# About Type Operators

## SHORT DESCRIPTION
Describes the operators that work with Microsoft .NET Framework types.

## LONG DESCRIPTION

The Boolean type operators (-is and -isNot) tell whether an object is an
instance of a specified .NET Framework type. The -is operator returns a
value of TRUE if the type matches and a value of FALSE otherwise. The
-isNot operator returns a value of FALSE if the type matches and a value of
TRUE otherwise.

The -as operator tries to convert the input object to the specified .NET
Framework type. If it succeeds, it returns the converted object. It if
fails, it returns \$null. It does not return an error.

The following table lists the type operators in  PowerShell.

|Operator|Description                |Example                          |
|--------|---------------------------|---------------------------------|
|`-is`   |Returns TRUE when the input|`(get-date) -is [DateTime]`      |
|        |is an instance of the      |`True`                           |
|        |specified .NET type.       |                                 |
|`-isNot`|Returns TRUE when the input|`(get-date) -isNot [DateTime]`   |
|        |not an instance of the     |`False`                          |
|        |specified.NET type.        |                                 |
|`-as`   |Converts the input to the  |`"5/7/07" -as [DateTime]`        |
|        |specified .NET type.       |`Monday, May 7, 2007 12:00:00 AM`|

The syntax of the type operators is as follows:

```powershell
<input> <operator> [.NET type]
```

You can also use the following syntax:

```powershell
<input> <operator> ".NET type"
```

To specify the .NET Framework type, enclose the type name in brackets ([ ]),
or enter the type as a string, such as [DateTime] or "DateTime" for
System.DateTime. If the type is not at the root of the system namespace,
specify the full name of the object type. You can omit "System.". For
example, to specify System.Diagnostics.Process, enter
[System.Diagnostics.Process], [Diagnostics.Process], or
"diagnostics.process".

The Boolean type operators (-is and -isNot) always return a Boolean value,
even if the input is a collection of objects. The type operators always
operate on the input object as a whole. That is, if the input object is a
collection, it is the _collection_ type that is tested, not the types of the
collection's _elements_.

If the \<input> is a type that is _derived_ from the \[.NET Type\] `-is`
returns`$True`. If the \<input> is a type that is _derived_ from the \[.NET
Type\] `-as` _passes through_ converts the input to the target type. For
example, `(Get-Item /) -is [System.IO.FileSystemInfo]` returns `$True`,
because the type of the input, `[System.IO.DirectoryInfo]`, is _derived_ from
the `[System.IO.FileSystemInfo]`.

To find the .NET Framework type of an object, use the Get-Member cmdlet.
Or, use the GetType method of all the objects together with the FullName
property of this method. For example, the following statement gets the type
of the return value of a Get-Culture command:

```powershell
PS> (get-culture).gettype().fullname
System.Globalization.CultureInfo
```

## EXAMPLES

The following examples show some uses of the Type operators:

```powershell
PS> 32 -is [Float]
False

PS> 32 -is "int"
True

PS> (get-date) -is [DateTime]
True

PS> "12/31/2007" -is [DateTime]
False

PS> "12/31/2007" -is [String]
True

PS> (get-process PowerShell)[0] -is [System.Diagnostics.Process]
True

PS> (get-command get-member) -is [System.Management.Automation.CmdletInfo]
True
```

The following example shows that when the input is a collection of objects,
the matching type is the .NET Framework type of the collection, not the
type of the individual objects in the collection.

In this example, although both the Get-Culture and Get-UICulture cmdlets
return System.Globalization.CultureInfo objects, a collection of these
objects is a System.Object array.

```powershell
PS> (get-culture) -is [System.Globalization.CultureInfo]
True

PS> (get-uiculture) -is [System.Globalization.CultureInfo]
True

PS> (get-culture), (get-uiculture) -is [System.Globalization.CultureInfo]
False

PS> (get-culture), (get-uiculture) -is [Array]
True

PS> (get-culture), (get-uiculture) | foreach {
  $_ -is [System.Globalization.CultureInfo])
}
True
True

PS> (get-culture), (get-uiculture) -is [Object]
True
```

The following examples show how to use the -as operator.

```powershell
PS> "12/31/07" -is [DateTime]
False

PS> "12/31/07" -as [DateTime]
Monday, December 31, 2007 12:00:00 AM

PS> $date = "12/31/07" -as [DateTime]

C:\PS>$a -is [DateTime]
True

PS> 1031 -as [System.Globalization.CultureInfo]

LCID      Name      DisplayName
----      ----      -----------
1031      de-DE     German (Germany)
```

The following example shows that when the -as operator cannot convert the
input object to the .NET Framework type, it returns nothing.

```powershell
PS> 1031 -as [System.Diagnostic.Process]
PS>
```

## SEE ALSO

[about_Operators](about_Operators.md)