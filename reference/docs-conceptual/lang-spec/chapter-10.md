---
description: A Hashtable represents a collection of key/value pair objects that supports efficient retrieval of a value when indexed by the key.
ms.date: 05/19/2021
title: Hashtables
---
# 10. Hashtables

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

Syntax:

> [!TIP]
> The `~opt~` notation in the syntax definitions indicates that the lexical entity is optional in
> the syntax.

```Syntax
hash-literal-expression:
    @{ new-lines~opt~ hash-literal-body~opt~ new-lines~opt~ }

hash-literal-body:
    hash-entry
    hash-literal-body statement-terminators hash-entry

hash-entry:
    key-expression = new-lines~opt~ statement

key-expression:
    simple-name
    unary-expression

statement-terminator:
    ;
    new-line-character
```

## 10.1 Introduction

The type Hashtable represents a collection of *key/value pair* objects that supports efficient
retrieval of a value when indexed by the key. Each key/value pair is an *element*, which is stored
in some implementation-defined object type.

An element's key cannot be the null value. There are no restrictions on the type of a key or value.
Duplicate keys are not supported.

Given a key/value pair object, the key and associated value can be obtained by using the instance
properties Key and Value, respectively.

Given one or more keys, the corresponding value(s) can be accessed via the Hashtable subscript
operator `[]` ([§7.1.4.3][§7.1.4.3]).

All Hashtables have type `Hashtable` ([§4.3.3][§4.3.3]).

The order of the keys in the collection returned by Keys is unspecified; however, it is the same
order as the associated values in the collection returned by Values.

Here are some examples involving Hashtables:

```powershell
$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123 }
$h1.FirstName # designates the key FirstName
$h1["LastName"] # designates the associated value for key LastName
$h1.Keys # gets the collection of keys
```

`Hashtable` elements are stored in an object of type **DictionaryEntry**, and the collections
returned by Keys and Values have type **ICollection**.

## 10.2 Hashtable creation

A `Hashtable` is created via a hash literal ([§7.1.9][§7.1.9]) or the
[New-Object](xref:Microsoft.PowerShell.Utility.New-Object) cmdlet. It can be created with zero or
more elements. The Count property returns the current element count.

## 10.3 Adding and removing Hashtable elements

An element can be added to a `Hashtable` by assigning ([§7.11.1][§7.11.1]) a value to a non-existent key
name or to a subscript ([§7.1.4.3][§7.1.4.3]) that uses a non-existent key name. Removal of an element
requires the use of the Remove method. For example,

```powershell
$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123 }
$h1.Dept = "Finance" # adds element Finance
$h1["Salaried"] = $false # adds element Salaried
$h1.Remove("Salaried") # removes element Salaried
```

## 10.4 Hashtable concatenation

Hashtables can be concatenated via the `+` and `+=` operators, both of which result in the creation
of a new `Hashtable`. The existing Hashtables are unchanged. See [§7.7.4][§7.7.4] for more information.

## 10.5 Hashtables as reference types

As `Hashtable` is a reference type, assignment of a `Hashtable` involves a shallow copy; that is,
the variable assigned to refers to the same `Hashtable`; no copy of the `Hashtable` is made. For
example,

```powershell
$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123 }
$h2 = $h1
$h1.FirstName = "John" # change key's value in $h1
$h2.FirstName # change is reflected in $h2
```

## 10.6 Enumerating over a Hashtable

To process every pair in a `Hashtable`, use the **Keys** property to retrieve the list of keys as an
array, and then enumerate over the elements of that array getting the associated value via the
**Value** property or a subscript, as follows

```powershell
$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123}
foreach ($e in $h1.Keys) {
   "Key is " + $e + ", Value is " + $h1[$e]
}
```

<!-- reference links -->
[§4.3.3]: chapter-04.md#433-hashtables
[§7.1.4.3]: chapter-07.md#7143-subscripting-a-hashtable
[§7.1.9]: chapter-07.md#719-hash-literal-expression
[§7.11.1]: chapter-07.md#7111-simple-assignment
[§7.7.4]: chapter-07.md#774-hashtable-concatenation
