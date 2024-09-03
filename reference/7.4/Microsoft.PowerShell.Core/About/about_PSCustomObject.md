---
description: Explains the differences between the [psobject] and [pscustomobject] type accelerators.
Locale: en-US
ms.date: 07/02/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pscustomobject?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSCustomObject
---
# about_PSCustomObject

## Short description
Explains the differences between the `[psobject]` and `[pscustomobject]` type
accelerators.

## Long description

The `[pscustomobject]` type accelerator was added in PowerShell 3.0.

Prior to adding this type accelerator, creating an object with member
properties and values was more complicated. Originally, you had to use
`New-Object` to create the object and `Add-Member` to add properties. For
example:

```powershell
PS> $object1 = New-Object -TypeName PSObject
PS> Add-Member -InputObject $object1 -MemberType NoteProperty -Name one -Value 1
PS> Add-Member -InputObject $object1 -MemberType NoteProperty -Name two -Value 2
PS> $object1 | Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
one         NoteProperty int one=1
two         NoteProperty int two=2

PS> $object1

one two
--- ---
  1   2
```

Later, you could use the **Property** parameter of `New-Object` to pass a
**Hashtable** containing the members and values. For example:

```powershell
PS> $object2 = New-Object -TypeName PSObject -Property @{one=1; two=2}
PS> $object2 | Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
one         NoteProperty int one=1
two         NoteProperty int two=2

PS> $object2

one two
--- ---
  1   2
```

Since PowerShell 3.0, casting a **Hashtable** to `[pscustomobject]` achieves
the same result.

```powershell
PS> $object3 = [pscustomobject]@{one=1; two=2}
PS> $object3 | Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
one         NoteProperty int one=1
two         NoteProperty int two=2

PS> $object3

one two
--- ---
  1   2
```

**PSObject** type objects maintain the list of members in the order that the
members were added to the object. Even though **Hashtable** objects don't
guarantee the order of the key-value pairs, casting a literal hashtable to
`[pscustomobject]` maintains the order.

The hashtable must be a literal. If you wrap the hashtable in parentheses or if
you cast a variable containing a hashtable, there is no guarantee that the
order is preserved.

```powershell
$hash = @{
    Name      = "Server30"
    System    = "Server Core"
    PSVersion = "4.0"
}
$Asset = [pscustomobject]$hash
$Asset
```

```output
System      Name     PSVersion
------      ----     ---------
Server Core Server30 4.0
```

## Understanding the type accelerators

`[psobject]` and `[pscustomobject]` are type accelerators.

For more information, see [about_Type_Accelerators][03].

Even though you might think that `[pscustomobject]` should map to
**System.Management.Automation.PSCustomObject**, the types are different.

```powershell
PS> [pscustomobject] -eq [System.Management.Automation.PSCustomObject]
False
```

Both type accelerators are mapped to the same class, **PSObject**:

```powershell
PS> [pscustomobject]

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     PSObject                                 System.Object

PS> [psobject]

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     PSObject                                 System.Object
```

When the `[pscustomobject]` type accelerator was added to PowerShell, it
included extra code to handle conversion of a **Hashtable** to a **PSObject**
type. This extra code is only invoked when a new object is being created.
Therefore, you can't use `[pscustomobject]` for type coercion or type
comparison, because all objects are treated as **PSObject** types.

For example, using the `-is` operator to check that an object returned by a
cmdlet is a `[pscustomobject]` is the same as comparing it to `[psobject]`.

```powershell
PS> (Get-Item /) -is [pscustomobject]
True

PS> (Get-Item /) -is [psobject]
True
```

When you cast any object to `[psobject]` you get the type of the original
object. Therefore, casting anything other than a **Hashtable** to
`[pscustomobject]` results in the same type.

```powershell
PS> ([psobject]@{Property = 'Value'}).GetType().FullName
System.Collections.Hashtable

PS> ([pscustomobject]123).GetType().Name
Int32

PS> ([pscustomobject]@{Property = 'Value'}).GetType().FullName
System.Management.Automation.PSCustomObject
```

While, casting an object to `[psobject]` appears to have no affect on the type,
PowerShell adds an _invisible_ `[psobject]` wrapper around the object. This can
have subtle side effects.

- Wrapped objects match their original type and the `[psobject]` type.

  ```powershell
  PS> 1 -is [Int32]
  True
  PS> 1 -is [psobject]
  False
  PS> ([psobject] 1) -is [Int32]
  True
  PS> ([psobject] 1) -is [psobject]
  True
  ```

- The format operator (`-f`) doesn't recognized an array wrapped by
  `[psobject]`.

  ```powershell
  PS> '{0} {1}' -f (1, 2)
  1 2
  PS> '{0} {1}' -f ([psobject] (1, 2))
  Error formatting a string: Index (zero based) must be greater than or equal
  to zero and less than the size of the argument list..
  ```

## Conversion of hashtables containing similar keys

Case-sensitive dictionaries might contain key names that only differ by case.
When you cast such a dictionary to a `[pscustomobject]`, PowerShell preserves
that case of the keys but isn't case-sensitive. As a result:

- The case of the first duplicate key becomes the name of that key.
- The value of the last case-variant key becomes the property value.

The following example demonstrates this behavior:

```powershell
$Json = '{
  "One": 1,
  "two": 2,
  "Two": 3,
  "three": 3,
  "Three": 4,
  "THREE": 5
}'
$OrderedHashTable = $Json | ConvertFrom-Json -AsHashTable
$OrderedHashTable
```

Notice that the ordered hashtable contains multiple keys that differ only by
case.

```Output
Name                           Value
----                           -----
One                            1
two                            2
Two                            3
three                          3
Three                          4
THREE                          5
```

When that hashtable is cast to a `[pscustomobject]`, the case of the name of
first key is used, but that value of the last matching key name is used.

```powershell
[PSCustomObject]$OrderedHashTable
```

```Output
One two three
--- --- -----
  1   3     5
```

## Notes

In Windows PowerShell, objects created by casting a **Hashtable** to
`[pscustomobject]` don't have the **Length** or **Count** properties.
Attempting to access these members returns `$null`.

For example:

```powershell
PS> $object = [PSCustomObject]@{key = 'value'}
PS> $object

key
---
value

PS> $object.Count
PS> $object.Length
```

Starting in PowerShell 6, objects created by casting a **Hashtable** to
`[pscustomobject]` always have a value of `1` for the **Length** and **Count**
properties.

## See also

- [about_Object_Creation][01]
- [about_Objects][02]
- [System.Management.Automation.PSObject][05]
- [System.Management.Automation.PSCustomObject][04]

<!-- link references -->
[01]: about_Object_Creation.md
[02]: about_Objects.md
[03]: about_type_accelerators.md
[04]: xref:System.Management.Automation.PSCustomObject
[05]: xref:System.Management.Automation.PSObject
