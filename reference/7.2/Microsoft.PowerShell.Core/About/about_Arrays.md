---
description: Describes arrays, which are data structures designed to store collections of items.
Locale: en-US
ms.date: 08/26/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Arrays
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
variable name by the assignment operator (`=`).

For example, to create an array named `$A` that contains the seven numeric (int)
values of 22, 5, 10, 8, 12, 9, and 80, type:

```powershell
$A = 22,5,10,8,12,9,80
```

The comma can also be used to initialize a single item array by placing the
comma before the single item.

For example, to create a single item array named `$B` containing the single
value of 7, type:

```powershell
$B = ,7
```

You can also create and initialize an array by using the range operator (`..`).
The following example creates an array containing the values 5 through 8.

```powershell
$C = 5..8
```

As a result, `$C` contains four values: 5, 6, 7, and 8.

When no data type is specified, PowerShell creates each array as an object
array (**System.Object[]**). To determine the data type of an array, use the
**GetType()** method. For example, to determine the data type of the `$A`
array, type:

```powershell
$A.GetType()
```

To create a strongly typed array, that is, an array that can contain only
values of a particular type, cast the variable as an array type, such as
**string[]**, **long[]**, or **int32[]**. To cast an array, precede the
variable name with an array type enclosed in brackets. For example, to create a
32-bit integer array named `$ia` containing four integers (1500, 2230, 3350,
and 4000), type:

```powershell
[int32[]]$ia = 1500,2230,3350,4000
```

As a result, the `$ia` array can contain only integers.

You can create arrays that are cast to any supported type in the Microsoft
.NET Framework. For example, the objects that `Get-Process` retrieves to
represent processes are of the **System.Diagnostics.Process** type. To create a
strongly typed array of process objects, enter the following command:

```powershell
[Diagnostics.Process[]]$zz = Get-Process
```

## The array sub-expression operator

The array sub-expression operator creates an array from the statements inside
it. Whatever the statement inside the operator produces, the operator will
place it in an array. Even if there is zero or one object.

The syntax of the array operator is as follows:

```syntax
@( ... )
```

You can use the array operator to create an array of zero or one object. For
example:

```powershell
$a = @("Hello World")
$a.Count
```

```Output
1
```

```powershell
$b = @()
$b.Count
```

```Output
0
```

The array operator is useful in scripts when you are getting objects, but do
not know how many objects you get. For example:

```powershell
$p = @(Get-Process Notepad)
```

For more information about the array sub-expression operator, see
[about_Operators](about_Operators.md).

## Accessing and using array elements

### Reading an array

You can refer to an array by using its variable name. To display all the
elements in the array, type the array name. For example, assuming `$a` is an
array containing integers 0, 1, 2, until 9; typing:

```powershell
$a
```

```Output
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

```Output
0
```

To display the third element in the `$a` array, type:

```powershell
$a[2]
```

```Output
2
```

You can retrieve part of the array using a range operator for the index. For
example, to retrieve the second to fifth elements of the array, you would
type:

```powershell
$a[1..4]
```

```Output
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

```Output
7
8
9
```

If you type negative indexes in descending order, your output changes.

```powershell
$a = 0 .. 9
$a[-1..-3]
```

```Output
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

```Output
2
1
0
9
8
```

Also, one common mistake is to assume `$a[0..-2]` refers to all the elements
of the array, except for the last one. It refers to the first, last, and
second-to-last elements in the array.

You can use the plus operator (`+`) to combine a ranges with a list of elements
in an array. For example, to display the elements at index positions 0, 2, and
4 through 6, type:

```powershell
$a = 0 .. 9
$a[0,2+4..6]
```

```Output
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

```Output
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

```Output
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

```Output
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

```Output
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

```Output
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

```Output
$a rank: 1
```

The following example shows how to create a truly multidimensional array using
the .Net Framework.

```powershell
[int[,]]$rank2 = [int[,]]::new(5,5)
$rank2.rank
```

```Output
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

```Output
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

```Output
0
0
0
```

### ForEach

Allows to iterate over all elements in the array and perform a given operation
for each element of the array.

The ForEach method has several overloads that perform different operations.

```
ForEach(scriptblock expression)
ForEach(scriptblock expression, object[] arguments)
ForEach(type convertToType)
ForEach(string propertyName)
ForEach(string propertyName, object[] newValue)
ForEach(string methodName)
ForEach(string methodName, object[] arguments)
```

#### ForEach(scriptblock expression)

#### ForEach(scriptblock expression, object[] arguments)

This method was added in PowerShell v4.

> [!NOTE]
> The syntax requires the usage of a script block. Parentheses are optional if
> the scriptblock is the only parameter. Also, there must not be a space
> between the method and the opening parenthesis or brace.

The following example shows how use the foreach method. In this case the
intent is to generate the square value of the elements in the array.

```powershell
$a = @(0 .. 3)
$a.ForEach({ $_ * $_})
```

```Output
0
1
4
9
```

Just like the `-ArgumentList` parameter of `ForEach-Object`, the `arguments`
parameter allows the passing of an array of arguments to a script block
configured to accept them.

For more information about the behavior of **ArgumentList**, see
[about_Splatting](about_Splatting.md#splatting-with-arrays).

#### ForEach(type convertToType)

The `ForEach` method can be used to swiftly cast the elements to a different
type; the following example shows how to convert a list of string dates to
`[DateTime]` type.

```powershell
@("1/1/2017", "2/1/2017", "3/1/2017").ForEach([datetime])
```

```Output

Sunday, January 1, 2017 12:00:00 AM
Wednesday, February 1, 2017 12:00:00 AM
Wednesday, March 1, 2017 12:00:00 AM
```

#### ForEach(string propertyName)

#### ForEach(string propertyName, object[] newValue)

The `ForEach` method can also be used to quickly retrieve, or set property
values for every item in the collection.

```powershell
# Set all LastAccessTime properties of files to the current date.
(dir 'C:\Temp').ForEach('LastAccessTime', (Get-Date))
# View the newly set LastAccessTime of all items, and find Unique entries.
(dir 'C:\Temp').ForEach('LastAccessTime') | Get-Unique
```

```Output
Wednesday, June 20, 2018 9:21:57 AM
```

#### ForEach(string methodName)

#### ForEach(string methodName, object[] arguments)

Lastly, `ForEach` methods can be used to execute a method on every item in
the collection.

```powershell
("one", "two", "three").ForEach("ToUpper")
```

```Output
ONE
TWO
THREE
```

Just like the `-ArgumentList` parameter of `ForEach-Object`, the `arguments`
parameter allows the passing of an array of arguments to a script block
configured to accept them.

> [!NOTE]
> Starting in Windows PowerShell 3.0 retrieving properties and executing
> methods for each item in a collection can also be accomplished using "Methods
> of scalar objects and collections" You can read more about that here
> [about_methods](about_methods.md).

### Where

Allows to filter or select the elements of the array. The script must evaluate
to anything different than: zero (0), empty string, `$false` or `$null` for
the element to show after the `Where`

There is one definition for the `Where` method.

```
Where(scriptblock expression[, WhereOperatorSelectionMode mode
                            [, int numberToReturn]])
```

> [!NOTE]
> The syntax requires the usage of a script block. Parentheses are optional if
> the scriptblock is the only parameter. Also, there must not be a space
> between the method and the opening parenthesis or brace.

The `Expression` is scriptblock that is required for filtering, the `mode`
optional argument allows additional selection capabilities, and the
`numberToReturn` optional argument allows the ability to limit how many items
are returned from the filter.

The acceptable values for `mode` are:

- Default (0) - Return all items
- First (1) - Return the first item
- Last (2) - Return the last item
- SkipUntil (3) - Skip items until condition is true, the return the remaining
  items
- Until (4) - Return all items until condition is true
- Split (5) - Return an array of two elements
  - The first element contains matching items
  - The second element contains the remaining items

The following example shows how to select all odd numbers from the array.

```powershell
(0..9).Where{ $_ % 2 }
```

```Output
1
3
5
7
9
```

This example show how to select the strings that are not empty.

```powershell
('hi', '', 'there').Where({$_.Length})
```

```Output
hi
there
```

#### Default

The `Default` mode filters items using the `Expression` scriptblock.

If a `numberToReturn` is provided, it specifies the maximum number of items
to return.

```powershell
# Get the zip files in the current users profile, sorted by LastAccessTime.
$Zips = dir $env:userprofile -Recurse '*.zip' | Sort-Object LastAccessTime
# Get the least accessed file over 100MB
$Zips.Where({$_.Length -gt 100MB}, 'Default', 1)
```

> [!NOTE]
> Both the `Default` mode and `First` mode return the first
> (`numberToReturn`) items, and can be used interchangeably.

#### Last

```powershell
$h = (Get-Date).AddHours(-1)
$logs = dir 'C:\' -Recurse '*.log' | Sort-Object CreationTime
# Find the last 5 log files created in the past hour.
$logs.Where({$_.CreationTime -gt $h}, 'Last', 5)
```

#### SkipUntil

The `SkipUntil` mode skips all objects in a collection until an object passes
the script block expression filter. It then returns **ALL** remaining collection
items without testing them. _Only one passing item is tested_.

This means the returned collection contains both _passing_ and
_non-passing_ items that have NOT been tested.

The number of items returned can be limited by passing a value to the
`numberToReturn` argument.

```powershell
$computers = "Server01", "Server02", "Server03", "localhost", "Server04"
# Find the first available online server.
$computers.Where({ Test-Connection $_ }, 'SkipUntil', 1)
```

```Output
localhost
```

#### Until

The `Until` mode inverts the `SkipUntil` mode.  It returns **ALL** items in a
collection until an item passes the script block expression. Once an item
_passes_ the scriptblock expression, the `Where` method stops processing items.

This means that you receive the first set of _non-passing_ items from the
`Where` method. _After_ one item passes, the rest are NOT tested or returned.

The number of items returned can be limited by passing a value to the
`numberToReturn` argument.

```powershell
# Retrieve the first set of numbers less than or equal to 10.
(1..50).Where({$_ -gt 10}, 'Until')
# This would perform the same operation.
(1..50).Where({$_ -le 10})
```

```Output
1
2
3
4
5
6
7
8
9
10
```

> [!NOTE]
> Both `Until` and `SkipUntil` operate under the premise of NOT testing a batch
> of items.
>
> `Until` returns the items **BEFORE** the first _pass_.
>
> `SkipUntil` returns all the items **AFTER** the first _pass_, including the
> first passing item.

#### Split

The `Split` mode splits, or groups collection items into two separate
collections. Those that pass the scriptblock expression, and those that do not.

If a `numberToReturn` is specified, the first collection, contains the
_passing_ items, not to exceed the value specified.

The remaining objects, even those that **PASS** the expression filter, are
returned in the second collection.

```powershell
$running, $stopped = (Get-Service).Where({$_.Status -eq 'Running'}, 'Split')
$running
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  Appinfo            Application Information
Running  AudioEndpointBu... Windows Audio Endpoint Builder
Running  Audiosrv           Windows Audio
...
```

```powershell
$stopped
```

```Output
Status   Name               DisplayName
------   ----               -----------
Stopped  AJRouter           AllJoyn Router Service
Stopped  ALG                Application Layer Gateway Service
Stopped  AppIDSvc           Application Identity
...
```

## Get the members of an array

To get the properties and methods of an array, such as the Length property and
the **SetValue** method, use the **InputObject** parameter of the `Get-Member`
cmdlet.

When you pipe an array to `Get-Member`, PowerShell sends the items one
at a time and `Get-Member` returns the type of each item in the array (ignoring
duplicates).

When you use the **InputObject** parameter, `Get-Member` returns the members of
the array.

For example, the following command gets the members of the `$a` array
variable.

```powershell
Get-Member -InputObject $a
```

You can also get the members of an array by typing a comma (,) before the
value that is piped to the `Get-Member` cmdlet. The comma makes the array the
second item in an array of arrays. PowerShell pipes the arrays one at
a time and `Get-Member` returns the members of the array. Like the next two
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
assignment operator (`=`) to specify a new value for the element. For example,
to change the value of the second item in the `$a` array (index position 1) to
10, type:

```powershell
$a[1] = 10
```

You can also use the **SetValue** method of an array to change a value. The
following example changes the second value (index position 1) of the `$a` array
to 500:

```powershell
$a.SetValue(500,1)
```

You can use the `+=` operator to add an element to an array. The following
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

To combine two arrays into a single array, use the plus operator (`+`). The
following example creates two arrays, combines them, and then displays the
resulting combined array.

```powershell
$x = 1,3
$y = 5,9
$z = $x + $y
```

As a result, the `$z` array contains 1, 3, 5, and 9.

To delete an array, assign a value of `$null` to the array. The following
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

### Zero objects

```powershell
$a = $null
$a.Count
$a.Length
```

```Output
0
0
```

### One object

```powershell
$a = 4
$a.Count
$a.Length
$a[0]
$a[-1]
```

```Output
1
1
4
4
```

## Indexing support for System.Tuple objects

PowerShell 6.1 added the support for indexed access of **Tuple** objects, similar to arrays.
For example:

```powershell
PS> $tuple = [Tuple]::Create(1, 'test')
PS> $tuple[0]
1
PS> $tuple[1]
test
PS> $tuple[0..1]
1
test
PS> $tuple[-1]
test
```

Unlike arrays and other collection objects, **Tuple** objects are treated as a
single object when passed through the pipeline or by parameters that support
arrays of objects.

For more information, see [System.Tuple](/dotnet/api/system.tuple).

## See also

- [about_Assignment_Operators](about_Assignment_Operators.md)
- [about_Hash_Tables](about_Hash_Tables.md)
- [about_Operators](about_Operators.md)
- [about_For](about_For.md)
- [about_Foreach](about_Foreach.md)
- [about_While](about_While.md)

