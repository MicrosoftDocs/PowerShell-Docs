---
description: PowerShell supports arrays of one or more dimensions with each dimension having zero or more elements.
ms.date: 12/09/2022
title: Arrays
---
# 9. Arrays

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

## 9.1 Introduction

PowerShell supports arrays of one or more dimensions with each dimension having zero or more
*elements*. Within a dimension, elements are numbered in ascending integer order starting at zero.
Any individual element can be accessed via the array subscript operator `[]` ([§7.1.4][§7.1.4]). The
number of dimensions in an array is called its *rank*.

An element can contain a value of any type including an array type. An array having one or more
elements whose values are of any array type is called a *jagged array*. A *multidimensional array*
has multiple dimensions, in which case, the number of elements in each row of a dimension is the
same. An element of a jagged array may contain a multidimensional array, and vice versa.

Multidimensional arrays are stored in row-major order. The number of elements in an array is called
that array's *length*, which is fixed when the array is created. As such, the elements in a
1-dimensional array *A* having length *N* can be accessed (i.e., *subscripted*) using the
expressions `A[0], A[1], ..., A[N-1]`. The elements in a 2-dimensional array *B* having *M* rows,
with each row having *N* columns, can be accessed using the expressions
`B[0,0], B[0,1], ..., B[0,N-1], B[1,0], B[1,1], ..., B[1,N-1], ..., B[M-1,0], B[M-1,1], ..., B[M-1,N-1]`.
And so on for arrays with three or more dimensions.

By default, an array is *polymorphic*; i.e., its elements do not need to all have the same type. For
example,

```powershell
$items = 10,"blue",12.54e3,16.30D # 1-D array of length 4
$items[1] = -2.345
$items[2] = "green"

$a = New-Object 'object[,]' 2,2 # 2-D array of length 4
$a[0,0] = 10
$a[0,1] = $false
$a[1,0] = "red"
$a[1,1] = $null
```

A 1-dimensional array has type `type[]`, a 2-dimensional array has type `type[,]`, a 3-dimensional
array has type `type[,,]`, and so on, where *type* is object for an unconstrained type array, or the
constrained type for a constrained array ([§9.4][§9.4]).

All array types are derived from the type Array ([§4.3.2][§4.3.2]).

## 9.2 Array creation

An array is created via an *array creation expression*, which has the following forms: unary comma
operator ([§7.2.1][§7.2.1]) ,*array-expression* ([§7.1.7][§7.1.7]), binary comma operator ([§7.3][§7.3]), range
operator ([§7.4][§7.4]), or [New-Object](xref:Microsoft.PowerShell.Utility.New-Object) cmdlet.

Here are some examples of array creation and usage:

```powershell
$values = 10, 20, 30
for ($i = 0; $i -lt $values.Length; ++$i) {
    "`$values[$i] = $($values[$i])"
}

$x = , 10                         # x refers to an array of length 1
$x = @(10)                        # x refers to an array of length 1
$x = @()                          # x refers to an array of length 0

$a = New-Object 'object[,]' 2, 2  # create a 2x2 array of anything
$a[0, 0] = 10                     # set to an int value
$a[0, 1] = $false                 # set to a boolean value
$a[1, 0] = "red"                  # set to a string value
$a[1, 1] = 10.50D                 # set to a decimal value
foreach ($e in $a) {              # enumerate over the whole array
    $e
}
```

The following is written to the pipeline:

```Output
$values[0] = 10
$values[1] = 20
$values[2] = 30

10
False
red
10.50
```

The default initial value of any element not explicitly initialized is the default value for that
element's type (that is, `$false`, zero, or `$null`).

## 9.3 Array concatenation

Arrays of arbitrary type and length can be concatenated via the `+` and `+=` operators, both of
which result in the creation of a new unconstrained 1-dimensional array. The existing arrays are
unchanged. See [§7.7.3][§7.7.3] for more information, and [§9.4][§9.4] for a discussion of adding to an array
of constrained type.

## 9.4 Constraining element types

A 1-dimensional array can be created so that it is type-constrained by prefixing the array-creation
expression with an array type cast. For example,

```powershell
$a = [int[]](1,2,3,4)   # constrained to int
$a[1] = "abc"           # implementation-defined behavior
$a += 1.23              # new array is unconstrained
```

The syntax for creating a multidimensional array requires the specification of a type, and that type
becomes the constraint type for that array. However, by specifying type `object[]`, there really is
no constraint as a value of any type can be assigned to an element of an array of that type.

Concatenating two arrays ([§7.7.3][§7.7.3]) always results in a new array that is unconstrained even if
both arrays are constrained by the same type. For example,

```powershell
$a = [int[]](1,2,3)    # constrained to int
$b = [int[]](10,20)    # constrained to int
$c = $a + $b           # constraint not preserved
$c = [int[]]($a + $b)  # result explicitly constrained to int
```

## 9.5 Arrays as reference types

As array types are reference types, a variable designating an array can be made to refer to any
array of any rank, length, and element type. For example,

```powershell
$a = 10,20                     # $a refers to an array of length 2
$a = 10,20,30                  # $a refers to a different array, of length 3
$a = "red",10.6                # $a refers to a different array, of length 2
$a = New-Object 'int[,]' 2,3   # $a refers to an array of rank 2
```

Assignment of an array involves a shallow copy; that is, the variable assigned to refers to the same
array, no copy of the array is made. For example,

```powershell
$a = 10,20,30
">$a<"
$b = $a         # make $b refer to the same array as $a
">$b<"

$a[0] = 6       # change value of [0] via $a
">$a<"
">$b<"          # change is reflected in $b

$b += 40        # make $b refer to a new array
$a[0] = 8       # change value of [0] via $a
">$a<"
">$b<"          # change is not reflected in $b
```

The following is written to the pipeline:

```Output
>10 20 30<
>10 20 30<
>6 20 30<
>6 20 30<
>8 20 30<
>6 20 30 40<
```

## 9.6 Arrays as array elements

Any element of an array can itself be an array. For example,

```powershell
$colors = "red", "blue", "green"
$list = $colors, (,7), (1.2, "yes") # parens in (,7) are redundant; they
                                    # are intended to aid readability
"`$list refers to an array of length $($list.Length)"
">$($list[1][0])<"
">$($list[2][1])<"
```

The following is written to the pipeline:

```Output
$list refers to an array of length 3
>7<
>yes<
```

`$list[1]` refers to an array of 1 element, the integer 7, which is accessed via `$list[1][0]`, as
shown. Compare this with the following subtly different case:

```powershell
$list = $colors, 7, (1.2, "yes") # 7 has no prefix comma
">$($list[1])<"
```

Here, `$list[1]` refers to a scalar, the integer 7, which is accessed via `$list[1]`.

Consider the following example,

```powershell
$x = [string[]]("red","green")
$y = 12.5, $true, "blue"
$a = New-Object 'object[,]' 2,2
$a[0,0] = $x               # element is an array of 2 strings
$a[0,1] = 20               # element is an int
$a[1,0] = $y               # element is an array of 3 objects
$a[1,1] = [int[]](92,93)   # element is an array of 2 ints
```

## 9.7 Negative subscripting

This is discussed in [§7.1.4.1][§7.1.4.1].

## 9.8 Bounds checking

This is discussed in [§7.1.4.1][§7.1.4.1].

## 9.9 Array slices

An *array slice* is an unconstrained 1-dimensional array whose elements are copies of zero or more
elements from a collection. An array slice is created via the subscript operator `[]`
([§7.1.4.5][§7.1.4.5]).

## 9.10 Copying an array

A contiguous set of elements can be copied from one array to another using the method
`[Array]::Copy`. For example,

```powershell
$a = [int[]](10,20,30)
$b = [int[]](0,1,2,3,4,5)
[Array]::Copy($a, $b, 2)        # $a[0]->$b[0],
$a[1]->$b[1]
[Array]::Copy($a, 1, $b, 3, 2)  # $a[1]->$b[3],
$a[2]->$b[4]
```

## 9.11 Enumerating over an array

Although it is possible to loop through an array accessing each of its elements via the subscript
operator, we can enumerate over that array's elements using the foreach statement. For a
multidimensional array, the elements are processed in row-major order. For example,

```powershell
$a = 10, 53, 16, -43
foreach ($elem in $a) {
    # do something with element via $elem
}

foreach ($elem in -5..5) {
    # do something with element via $elem
}

$a = New-Object 'int[,]' 3, 2
foreach ($elem in $a) {
    # do something with element via $elem
}
```

## 9.12 Multidimensional array flattening

Some operations on a multidimensional array (such as replication ([§7.6.3][§7.6.3]) and concatenation
([§7.7.3][§7.7.3])) require that array to be *flattened*; that is, to be turned into a 1-dimensional array
of unconstrained type. The resulting array takes on all the elements in row-major order.

Consider the following example:

```powershell
$a = "red",$true
$b = (New-Object 'int[,]' 2,2)
$b[0,0] = 10
$b[0,1] = 20
$b[1,0] = 30
$b[1,1] = 40
$c = $a + $b
```

The array designated by `$c` contains the elements "red", `$true`, 10, 20, 30, and 40.

<!-- reference links -->
[§4.3.2]: chapter-04.md#432-arrays
[§7.1.4.1]: chapter-07.md#7141-subscripting-an-array
[§7.1.4.5]: chapter-07.md#7145-generating-array-slices
[§7.1.4]: chapter-07.md#714-element-access
[§7.1.7]: chapter-07.md#717--operator
[§7.2.1]: chapter-07.md#721-unary-comma-operator
[§7.3]: chapter-07.md#73-binary-comma-operator
[§7.4]: chapter-07.md#74-range-operator
[§7.6.3]: chapter-07.md#763-array-replication
[§7.7.3]: chapter-07.md#773-array-concatenation
[§9.4]: chapter-09.md#94-constraining-element-types
