﻿---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Arrays
---
# About Arrays

## Short Description

Describes arrays, which are data structures designed to store
collections of items.

## Long Description

An array is a data structure that is designed to store a collection of items.
The items can be the same type or different types.

Beginning in Windows PowerShell 3.0, a collection of zero or one object has
some properties of arrays.

## Creating and initializing an array

To create and initialize an array, assign multiple values to a variable. The
values stored in the array are delimited with a comma and separated from the
variable name by the assignment operator (=).

For example, to create an array named $A that contains the seven numeric (int)
values of 22, 5, 10, 8, 12, 9, and 80, type:

```powershell
$A = 22,5,10,8,12,9,80
```

You can also create and initialize an array by using the range operator (..).
For example, to create and initialize an array named "$B" that contains the
values 5 through 8, type:

```powershell
$B = 5..8
```

As a result, $B contains four values: 5, 6, 7, and 8.

When no data type is specified, Windows PowerShell creates each array as an
object array (type: System.Object[]). To determine the data type of an array,
use the GetType() method. For example, to determine the data type of the $a
array, type:

```powershell
$a.GetType()
```

To create a strongly typed array, that is, an array that can contain only
values of a particular type, cast the variable as an array type, such as
string[], long[], or int32[]. To cast an array, precede the variable name with
an array type enclosed in brackets. For example, to create a 32-bit integer
array named $ia containing four integers (1500, 2230, 3350, and 4000), type:

```powershell
[int32[]]$ia = 1500,2230,3350,4000
```

As a result, the $ia array can contain only integers.

You can create arrays that are cast to any supported type in the Microsoft
.NET Framework. For example, the objects that Get-Process retrieves to
represent processes are of the System.Diagnostics.Process type. To create a
strongly typed array of process objects, enter the following command:

```powershell
[Diagnostics.Process[]]$zz = Get-Process
```

## The array sub-expression operator

The array sub-expression operator creates an array, even if it contains zero
or one object.

The syntax of the array operator is as follows:

```syntax
@( ... )
```

You can use the array operator to create an array of zero or one object. For
example:

```powershell
PS> $a = @("Hello World")
PS> $a.Count
1
```

```powershell
PS> $b = @()
PS> $b.Count
0
```

The array operator is particularly useful in scripts when you are getting
objects, but do not know how many objects you will get. For example:

```powershell
$p = @(Get-Process Notepad)
```

For more information about the array sub-expression operator, see
about_Operators.

## Accessing and using array elements

### Reading an array

You can refer to an array by using its variable name. To display all the
elements in the array, type the array name. For example, assuming `$a` is an
array containing integers 0, 1, 2, until 9; typing:

```powershell
$a
```

```output
0
1
2
3
4
5
6
7
8
9
```

You can refer to the elements in an array by using an index, beginning at
position 0. Enclose the index number in brackets. For example, to display the
first element in the `$a` array, type:

```powershell
$a[0]
```

```output
0
```

To display the third element in the `$a` array, type:

```powershell
$a[2]
```

```output
2
```

You can retrieve part of the array using a range operator for the index. For
example, to retrieve the second to fifth elements of the array, you would
type:

```powershell
$a[1..4]
```

```output
1
2
3
4
```

Negative numbers count from the end of the array. For example, "-1" refers to
the last element of the array. To display the last three elements of the
array, in index ascending order, type:

```powershell
$a = 0 .. 9
$a[-3..-1]
```

```output
7
8
9
```

If you type negative indexes in descending order, your output changes.

```powershell
$a = 0 .. 9
$a[-1..-3]
```

```output
9
8
7
```

However, be cautious when using this notation. The notation cycles from the
end boundary to the beginning of the array.

```powershell
$a = 0 .. 9
$a[2..-2]
```

```output
2
1
0
9
8
```

Also, one common mistake is to assume `$a[0..-2]` refers to all the elements
of the array, except for the last one. It refers to the first, last, and
second-to-last elements in the array.

You can use the plus operator (+) to combine a ranges with a list of elements
in an array. For example, to display the elements at index positions 0, 2, and
4 through 6, type:

```powershell
$a = 0 .. 9
$a[0,2+4..6]
```

```output
0
2
4
5
6
```

Also, to list multiple ranges and individual elements you can use the plus
operator. For example, to list elements zero to two, four to six, and the
element at eighth positional type:

```powershell
$a = 0..9
$a[+0..2+4..6+8]
```

```output
0
1
2
4
5
6
8
```

### Iterations over array elements

You can also use looping constructs, such as ForEach, For, and While loops, to
refer to the elements in an array. For example, to use a ForEach loop to
display the elements in the `$a` array, type:

```powershell
$a = 0..9
foreach ($element in $a) {
  $element
}
```

```output
0
1
2
3
4
5
6
7
8
9
```

The Foreach loop iterates through the array and returns each value in the
array until reaching the end of the array.

The For loop is useful when you are incrementing counters while examining the
elements in an array. For example, to use a For loop to return every other
value in an array, type:

```powershell
$a = 0..9
for ($i = 0; $i -le ($a.length - 1); $i += 2) {
  $a[$i]
}
```

```output
0
2
4
6
8
```

You can use a While loop to display the elements in an array until a defined
condition is no longer true. For example, to display the elements in the `$a`
array while the array index is less than 4, type:

```powershell
$a = 0..9
$i=0
while($i -lt 4) {
  $a[$i];
  $i++
}
```

```output
0
1
2
3
```

## Properties of arrays

### Count or Length or LongLength

To determine how many items are in an array, use the `Length` property or its
`Count` alias. `Longlength` is useful if the array contains more than
2,147,483,647 elements.

```powershell
$a = 0..9
$a.Count
$a.Length
```

```output
10
10
```

### Rank

Returns the number of dimensions in the array. Most arrays in PowerShell have
one dimension, only. Even when you think you are building a multidimensional
array; like the following example:

```powershell
$a = @(
  @(0,1),
  @("b", "c"),
  @(Get-Process)
)

[int]$r = $a.Rank
"`$a rank: $r"
```

```output
$a rank: 1
```

Building a truly multidimensional array, in PowerShell, requires the
assistance of the *.Net Framework*. Like in the following example:

```powershell
[int[,]]$rank2 = [int[,]]::new(5,5)
$rank2.rank
```

```output
2
```

## Methods of arrays

### Clear

Sets all element values to the _default value_ of the array's element type.
The Clear() method does not reset the size of the array.

In the following example `$a` is an array of objects.

```powershell
$a = 1, 2, 3
$a.Clear()
$a | % { $null -eq $_ }
```

```output
True
True
True
```

In this example, `$intA` is explicitly typed to contain integers.

```powershell
[int[]] $intA = 1, 2, 3
$intA.Clear()
$intA
```

```output
0
0
0
```


### ForEach and Where methods

Beginning in Windows PowerShell 4.0 `ForEach` and `Where` methods can be run
using `.` notation from any collection.

## Get the members of an array

To get the properties and methods of an array, such as the Length property and
the SetValue method, use the InputObject parameter of the Get-Member cmdlet.

When you pipe an array to `Get-Member`, Windows PowerShell sends the items one
at a time and Get-Member returns the type of each item in the array (ignoring
duplicates).

When you use the *-InputObject* parameter, `Get-Member` returns the members of
the array.

For example, the following command gets the members of the `$a` array
variable.

```powershell
Get-Member -InputObject $a
```

You can also get the members of an array by typing a comma (,) before the
value that is piped to the Get-Member cmdlet. The comma makes the array the
second item in an array of arrays. Windows PowerShell pipes the arrays one at
a time and Get-Member returns the members of the array. Like the next two
examples.

```powershell
,$a | Get-Member

,(1,2,3) | Get-Member
```

## Manipulating an array

You can change the elements in an array, add an element to an array, and
combine the values from two arrays into a third array.

To change the value of a particular element in an array, specify the array
name and the index of the element that you want to change, and then use the
assignment operator (=) to specify a new value for the element. For example,
to change the value of the second item in the `$a` array (index position 1) to
10, type:

```powershell
$a[1] = 10
```

You can also use the SetValue method of an array to change a value. The
following example changes the second value (index position 1) of the `$a` array
to 500:

```powershell
$a.SetValue(500,1)
```

You can use the += operator to add an element to an array. The following
example shows how to add an element to the `$a` array.

```powershell
$a = @(0..4)
$a += 5
```

> [!NOTE]
> When you use the `+=` operator, PowerShell actually creates a new array
> with the values of the original array and the added value. This might
> cause performance issues if the operation is repeated several times or
> the size of the array is too big.

It is not easy to delete elements from an array, but you can create a new
array that contains only selected elements of an existing array. For example,
to create the `$t` array with all the elements in the `$a` array except for the
value at index position 2, type:

```powershell
$t = $a[0,1 + 3..($a.length - 1)]
```

To combine two arrays into a single array, use the plus operator (+). The
following example creates two arrays, combines them, and then displays the
resulting combined array.

```powershell
$x = 1,3
$y = 5,9
$z = $x + $y
```

As a result, the `$z` array contains 1, 3, 5, and 9.

To delete an array, assign a value of $null to the array. The following
command deletes the array in the `$a` variable.

`$a = $null`

You can also use the `Remove-Item` cmdlet, but assigning a value of `$null` is
faster, especially for large arrays.

## Arrays of zero or one

Beginning in Windows PowerShell 3.0, a collection of zero or one object has
the Count and Length property. Also, you can index into an array of one
object. This feature helps you to avoid scripting errors that occur when a
command that expects a collection gets fewer than two items.

The following examples demonstrate this feature.

## Zero objects

```powershell
$a = $null
$a.Count
$a.Length
```

```output
0
0
```

## One object

```powershell
$a = 4
$a.Count
$a.Length
$a[0]
$a[-1]
```

```output
1
1
4
4
```

## See also

- [about_Assignment_Operators](about_Assignment_Operators.md)
- [about_Hash_Tables](about_Hash_Tables.md)
- [about_Operators](about_Operators.md)
- [about_For](about_For.md)
- [about_Foreach](about_Foreach.md)
- [about_While](about_While.md)