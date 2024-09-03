---
description: Describes the automatic enumeration of list collection items when using the member-access operator.
Locale: en-US
ms.date: 07/18/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_member-access_enumeration?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Member-Access_Enumeration
---
# about_Member-Access_Enumeration

## Short description

Describes the automatic enumeration of list collection items when using the
member-access operator.

## Long description

Starting in PowerShell 3.0, the _member-access enumeration_ feature improves the
convenience of using the member-access operator (`.`) on list collection
objects. When you use the member-access operator to access a member that does
not exist on a collection, PowerShell automatically enumerates the items in the
collection and attempts to access the specified member on each item.

Member-access enumeration helps you write simpler and shorter code. Instead of
piping a collection object to `ForEach-Object` or using the `ForEach()`
[intrinsic method](about_Intrinsic_Members.md#methods) to access members on
each item in the collection, you can use the member-access operator on the
collection object.

These commands are functionally identical with the last one demonstrating use of
the member-access operator:

```powershell
Get-Service -Name event* | ForEach-Object -Process { $_.DisplayName }
(Get-Service -Name event*).ForEach({ $_.DisplayName })
(Get-Service -Name event*).DisplayName
```

```Output
Windows Event Log
COM+ Event System

Windows Event Log
COM+ Event System

Windows Event Log
COM+ Event System
```

> [!NOTE]
> You can use the member-access operator to get the values of a property on
> items in a collection but you can't use it to set them directly. For more
> information, see [about_Arrays](about_Arrays.md#member-access-enumeration).

When you use the member-access operator on any object and the specified member
exists on that object, the member is invoked. For property members, the operator
returns the value of that property. For method members, the operator calls that
method on the object.

When you use the member-access operator on a list collection object that doesn't
have the specified member, PowerShell automatically enumerates the items in
that collection and uses the member-access operator on each enumerated item.

You can check if an object is a list collection by seeing whether its type
implements the **IList** interface:

```powershell
$List = @('a', 'b')
$Hash = @{ a = 'b' }
$List.GetType().ImplementedInterfaces.Name -contains 'IList'
$Hash.GetType().ImplementedInterfaces.Name -contains 'IList'
```

```Output
True

False
```

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

The following examples detail the behavior of the member-access operator under
all possible scenarios.

## Accessing members of a non-list object

When you use the member-access operator on an object that is not a list collection
and that has the member, the command returns the value of the property or
output of the method for that object.

```powershell
$MyString = 'abc'
$MyString.Length
$MyString.ToUpper()
```

```Output
3

ABC
```

When you use the member-access operator on a non-list object that does not have
the member, the command returns `$null` if you specify a property or a
**MethodNotFound** error if you specify a method.

```powershell
$MyString = 'abc'
$null -eq $MyString.DoesNotExist
$MyString.DoesNotExist()
```

```Output
True

Method invocation failed because [System.String] does not contain a method
named 'DoesNotExist'.
At line:1 char:1
+ $MyString.DoesNotExist()
+ ~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [], RuntimeException
    + FullyQualifiedErrorId : MethodNotFound
```

## Accessing members of a list collection object

When you use the member-access operator on a collection object that has the
member, it always returns the property value or method result for the
collection object.

### Accessing members that exist on the collection but not its items

In this example, the specified members exist on the collection but not the
items in it.

```powershell
[System.Collections.Generic.List[string]]$Collection = @('a', 'b')
$Collection.IsReadOnly
$Collection.Add('c')
$Collection
```

```Output
False

a
b
c
```

### Accessing members that exist on the collection and its items

For this example, the specified members exist on both the collection and the
items in it. Compare the results of the commands using the member-access
operator on the collection to the results from using the member-access operator
on the collection items in `ForEach-Object`. On the collection, the operator
returns the property value or method result for the collection object and not
the items in it.

```powershell
[System.Collections.Generic.List[string]]$Collection = @('a', 'b', 'c')
$Collection.Count
$Collection | ForEach-Object -Process { $_.Count }
$Collection.ToString()
$Collection | ForEach-Object -Process { $_.ToString() }
```

```Output
3

1
1
1

System.Collections.Generic.List`1[System.String]

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
> [intrinsic member](about_Intrinsic_Members.md). For example, if the key name
> is `keys` and you want to return the collection of the **HashTable** keys, use
> this syntax:
>
> ```powershell
> $hashtable.PSBase.Keys
> ```

### Accessing members that exist on all items in a collection but not itself

When you use the member-access operator on a collection object that does not
have the member but the items in it do, PowerShell enumerates the items in the
collection and returns the property value or method result for each item.

```powershell
[System.Collections.Generic.List[string]]$Collection = @('a', 'b', 'c')
$Collection.Length
$Collection.ToUpper()
```

```Output
1
1
1

A
B
C
```

### Accessing members that exist on neither the collection nor its items

When you use the member-access operator on a collection object that does not
have the member and neither do the items in it, the command returns `$null` if
you specify a property or a `MethodNotFound` error if you specify a method.

```powershell
[System.Collections.Generic.List[string]]$Collection = @('a', 'b', 'c')
$null -eq $Collection.DoesNotExist
$Collection.DoesNotExist()
```

```Output
True

Method invocation failed because [System.String] does not contain a method
named 'DoesNotExist'.
At line:1 char:1
+ $Collection.DoesNotExist()
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [], RuntimeException
    + FullyQualifiedErrorId : MethodNotFound
```

Because the collection object does not have the member, PowerShell enumerated
the items in the collection. Notice that the **MethodNotFound** error specifies
that **System.String** does not contain the method instead of
**System.Collections.Generic.List**.

### Accessing methods that exist only on some items in a collection

When you use the member-access operator to access a method on a collection
object that does not have the method and only some of the items in the
collection have it, the command returns a `MethodNotFound` error for the first
item in the collection that does not have the method. Even though the method
gets called on some items, the command only returns the error.

```powershell
@('a', 1, 'c').ToUpper()
```

```Output
Method invocation failed because [System.Int32] does not contain a method
named 'ToUpper'.
At line:1 char:1
+ @('a', 1, 'c').ToUpper()
+ ~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [], RuntimeException
    + FullyQualifiedErrorId : MethodNotFound
```

### Accessing properties that exist only on some items in a collection

When you use the member-access operator to access a property on a collection
object that does not have the property and only some of the items in the
collection have it, the command returns the property value for each item in the
collection that has the property.

```powershell
$CapitalizedProperty = @{
    MemberType = 'ScriptProperty'
    Name       = 'Capitalized'
    Value      = { $this.ToUpper() }
    PassThru   = $true
}
[System.Collections.Generic.List[object]]$MixedCollection = @(
    'a'
    ('b' | Add-Member @CapitalizedProperty)
    ('c' | Add-Member @CapitalizedProperty)
    'd'
)
$MixedCollection.Capitalized
```

```Output
B
C
```

## See Also

- [about_Arrays](about_Arrays.md)
- [about_Intrinsic_Members](about_Intrinsic_Members.md)
- [about_Methods](about_Methods.md)
- [about_Operators](about_Operators.md)
- [about_Properties](about_Properties.md)
