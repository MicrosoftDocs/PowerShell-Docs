---
description: Describes the automatic enumeration of collections when using the member-access operator.
Locale: en-US
ms.date: 01/03/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_member-access_enumeration?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Member-Access_Enumeration
---
# about_Member-Access_Enumeration

## Short description

Describes the automatic enumeration of collections when using the member-access
operator.

## Long description

PowerShell maintains a list of types that are enumerable. Starting in
PowerShell 3.0, the _member-access enumeration_ feature improves the
convenience of using the member-access operator (`.`) on collection objects
that are enumerable.

Member-access enumeration helps you write simpler and shorter code. Instead of
piping a collection object to `ForEach-Object` or using the `ForEach()`
[intrinsic method][04] to access members on each item in the collection, you
can use the member-access operator on the collection object.

The following examples produce the same results. The last example demonstrates
the use of the member-access operator:

```powershell
PS> Get-Service -Name event* | ForEach-Object -Process { $_.DisplayName }
Windows Event Log
COM+ Event System
PS> (Get-Service -Name event*).ForEach({ $_.DisplayName })
Windows Event Log
COM+ Event System
PS> (Get-Service -Name event*).DisplayName
Windows Event Log
COM+ Event System
```

> [!NOTE]
> You can use the member-access operator to get the values of a property on
> items in a collection but you can't use it to set them directly. For more
> information, see [about_Arrays][02]. Member-access enumeration is a
> convenience feature. There can be subtle behavior and performance differences
> between the various enumeration methods.

When you use the member-access operator on an object and the specified member
exists on that object, the member is invoked. When you use the member-access
operator on a collection object that doesn't have the specified member,
PowerShell enumerates the items in that collection and uses the member-access
operator on each enumerated item.

During member-access enumeration for a property, the operator returns the value
of the property for each item that has that property. If no items have the
specified property, the operator returns `$null`.

During member-access enumeration for a method, the operator attempts to call the
method on each item in the collection. If any item in the collection does
not have the specified method, the operator returns the **MethodNotFound**
exception.

> [!WARNING]
> During member-access enumeration for a method, the method is called on each
> item in the collection. If the method you are calling makes changes, the
> changes are made for every item in the collection. If an error occurs during
> enumeration, the method is called only on the items enumerated before the
> error. For additional safety, consider manually enumerating the items and
> explicitly handling any errors.

## Access members of a non-enumerable object

When you use the member-access operator on an object that isn't an enumerable
collection, PowerShell invokes the member to returns the value of the property
or output of the method for that object.

```powershell
PS> $MyString = 'abc'
PS> $MyString.Length
3
PS> $MyString.ToUpper()
ABC
```

When you use the member-access operator on a non-enumerable object that doesn't
have the member, PowerShell returns `$null` for the missing property or a
**MethodNotFound** error for the missing method.

```powershell
PS> $MyString = 'abc'
PS> $null -eq $MyString.DoesNotExist
True
PS> $MyString.DoesNotExist()
InvalidOperation: Method invocation failed because [System.String] does not contain a method named 'DoesNotExist'.

```

## Access members of a collection object

When you use the member-access operator on a collection object that has the
member, it always returns the property value or method result for the
collection object.

### Access members that exist on the collection but not its items

In this example, the specified members exist on the collection but not the
items in it.

```powershell
PS> [System.Collections.Generic.List[string]]$Collection = @('a', 'b')
PS> $Collection.IsReadOnly
False
PS> $Collection.Add('c')
PS> $Collection
a
b
c
```

### Access members that exist on the collection and its items

For this example, the specified members exist on both the collection and the
items in it. Compare the results of the commands using the member-access
operator on the collection to the results from using the member-access operator
on the collection items in `ForEach-Object`. On the collection, the operator
returns the property value or method result for the collection object and not
the items in it.

```powershell
PS> [System.Collections.Generic.List[string]]$Collection = @('a', 'b', 'c')
PS> $Collection.Count
3
PS> $Collection | ForEach-Object -Process { $_.Count }
1
1
1
PS> $Collection.ToString()
System.Collections.Generic.List`1[System.String]
PS> $Collection | ForEach-Object -Process { $_.ToString() }
a
b
c
```

> [!NOTE]
> Collections that implement the **System.Collections.IDictionary** interface,
> such as **HashTable** and **OrderedDictionary**, have a different behavior.
> When you use the member-access operator on a dictionary that has a key with
> the same name as a property, it returns the key's value instead of the
> property's.
>
> You can access the dictionary object's property value with the **psbase**
> [intrinsic member][03]. For example, if the key name is `keys` and you want
> to return the collection of the **HashTable** keys, use this syntax:
>
> ```powershell
> $hashtable.psbase.Keys
> ```

### Access members that exist on all items in a collection but not itself

When you use the member-access operator on a collection object that doesn't
have the member but the items in it do, PowerShell enumerates the items in the
collection and returns the property value or method result for each item.

```powershell
PS> [System.Collections.Generic.List[string]]$Collection = @('a', 'b', 'c')
PS> $Collection.Length
1
1
1
PS> $Collection.ToUpper()
A
B
C
```

### Access members that don't exist on collection or its items

When you use the member-access operator on a collection object that doesn't
have the member and neither do the items in it, the command returns `$null` if
you specify a property or a `MethodNotFound` error if you specify a method.

```powershell
PS> [System.Collections.Generic.List[string]]$Collection = @('a', 'b', 'c')
PS> $null -eq $Collection.DoesNotExist
True
PS> $Collection.DoesNotExist()
InvalidOperation: Method invocation failed because [System.String] does not
contain a method named 'DoesNotExist'.
```

Because the collection object doesn't have the member, PowerShell enumerated
the items in the collection. Notice that the **MethodNotFound** error specifies
that **System.String** doesn't contain the method instead of
**System.Collections.Generic.List**.

### Access methods that exist only on some items in a collection

When you use the member-access operator to access a method on a collection
object that doesn't have the method and only some items in the collection have
it, the command returns a `MethodNotFound` error for the first item in the
collection that doesn't have the method. Even though the method gets called on
some items, the command only returns the error.

```powershell
PS> @('a', 1, 'c').ToUpper()
InvalidOperation: Method invocation failed because [System.Int32] does not
contain a method named 'ToUpper'.
```

### Access properties that exist only on some items in a collection

When you use the member-access operator to access a property on a collection
object that doesn't have the property and only some items in the collection
have it, the command returns the property value for each item in the collection
that has the property.

```powershell
PS> $CapitalizedProperty = @{
    MemberType = 'ScriptProperty'
    Name       = 'Capitalized'
    Value      = { $this.ToUpper() }
    PassThru   = $true
}
PS> [System.Collections.Generic.List[object]]$MixedCollection = @(
    'a'
    ('b' | Add-Member @CapitalizedProperty)
    ('c' | Add-Member @CapitalizedProperty)
    'd'
)
PS> $MixedCollection.Capitalized
B
C
```

### Access members of a nested collection

When an enumerable collection contains a nested collection, member-access
enumeration is applied to each nested collection.

For example, `$a` is an array containing two elements: a nested array of
strings and a single string.

```powershell
# Get the count of items in the array.
PS> $a.Count
2
# Get the count of items in each nested item.
PS> $a.GetEnumerator().Count
2
1
# Call the ToUpper() method on all items in the nested array.
PS> $a = @(, ('bar', 'baz'), 'foo')
PS> $a.ToUpper()
BAR
BAZ
FOO
```

When you use the member-access operator, PowerShell enumerates the items in
`$a` and calls the `ToUpper()` method on all items.

## Notes

As previously stated, there can be subtle behavior and performance differences
between the various enumeration methods.

### Errors result in lost output

When member-access enumeration is terminated by an error, output from prior
successful method calls isn't returned. Terminating error conditions include:

- the enumerated object lacks the accessed method
- the accessed method raises a terminating error

Consider the following example:

```powershell
class Class1 { [object] Foo() { return 'Bar' } }
class Class2 { [void] Foo() { throw 'Error' } }
class Class3 {}

$example1 = ([Class1]::new(), [Class1]::new())
$example2 = ([Class1]::new(), [Class2]::new())
$example3 = ([Class1]::new(), [Class3]::new())
```

Both items in `$example1` have the `Foo()` method, so the method call succeeds.

```powershell
PS> $example1.Foo()
Bar
Bar
```

The `Foo()` method on second item in `$example2` throws an error, so the
enumeration fails.

```powershell
PS> $example2.Foo()
Exception:
Line |
   2 |  class Class2 { [void] Foo() { throw 'Error' } }
     |                                ~~~~~~~~~~~~~
     | Error
```

The second item in `$example2` doesn't have the `Foo()` method, so the
enumeration fails.

```powershell
PS> $example3.Foo()
InvalidOperation: Method invocation failed because [Class3] does not contain
a method named 'Foo'.
```

Compare this to enumeration using `ForEach-Object`

```powershell
PS> $example2 | ForEach-Object -MemberName Foo
Bar
ForEach-Object: Exception calling "Foo" with "0" argument(s): "Error"
PS> $example3 | ForEach-Object -MemberName Foo
Bar
```

Notice that the output show the successful call to `Foo()` on the first item
in the array.

### Collections containing PSCustomObject instances

If the collection of objects contains instances of **PSCustomObject** items,
PowerShell unexpectedly retruns `$null` values when the accessed property is
missing.

In the following examples at least one object has the referenced property.

```powershell
PS> $foo = [pscustomobject]@{ Foo = 'Foo' }
PS> $bar = [pscustomobject]@{ Bar = 'Bar' }
PS> $baz = [pscustomobject]@{ Baz = 'Baz' }
PS> ConvertTo-Json ($foo, $bar, $baz).Foo
[
  "Foo",
  null,
  null
]
PS> ConvertTo-Json ((Get-Process -Id $PID), $foo).Name
[
  "pwsh",
  null
]
```

You would expect PowerShell to return a single object for the item that has the
property specified. Instead, PowerShell also returns a `$null` value for each
item that doesn't have the property.

For more information on this behavior, see PowerShell Issue [#13752][13752].

## See Also

- [about_Arrays][01]
- [about_Intrinsic_Members][03]
- [about_Methods][05]
- [about_Operators][06]
- [about_Properties][07]

<!-- link references -->
[01]: about_Arrays.md
[02]: about_Arrays.md#member-access-enumeration
[03]: about_Intrinsic_Members.md
[04]: about_Intrinsic_Members.md#methods
[05]: about_Methods.md
[06]: about_Operators.md
[07]: about_Properties.md
[13752]: https://github.com/PowerShell/PowerShell/issues/13752
