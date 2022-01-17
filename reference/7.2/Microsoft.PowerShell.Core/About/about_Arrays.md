---
description: Describes arrays, which are data structures designed to store collections of items.
Locale: en-US
ms.date: 06/25/2021
no-loc: [Count, Length, LongLength, Rank, ForEach, Clear, Default, First, Last, SkipUntil, Until, Split, Tuple]
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Arrays
---
# about_Arrays

## Short description
Describes arrays, which are data structures designed to store collections of
items.

## Long description

An array is a data structure that is designed to store a collection of items.
The items can be the same type or different types.

Beginning in Windows PowerShell 3.0, non-collection objects (and `$null`) have
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

Note that empty items are permitted but ignored. Thus
```powershell
$A = 22,,10,,12,,80
```
produces a four item array containing 22, 10, 12, and 80. This can be used to
initialize a single item array by placing a comma before the single item. This would
be an array of two items but the empty first item is ignored leaving only the "second"
item to form the one item array. Note, however, that trailing commas are not permitted.

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

##### Caution
Due to the way PowerShell parses a command line, spaces before a single comma prefix are
ignored. This means that if a single item array parameter is used in a command then
PowerShell will treat it as the remainder of an array that began with the preceding
parameter, if this is syntactically valid. For example,
```powershell
$ascii_ctls = New-Object string ,[char[]](0..31) # want a string of first 32 ASCII values
# Expect to invoke New-Object [-TypeName] <string> [[-ArgumentList] <Object[]>] as best match.
# This New-Object expects 2nd parameter (-ArgumentList) to be an array of constructor parameters
# but the intended [string] constructor wants one parameter which is itself an array of characters.
```
But PowerShell will treat this as
```powershell
$ascii_ctls = New-Object string,[char[]](0..31)
# invalid, expect -TypeName/-ComObject parameter (position 0) to be a string value not an array
```
To avoid this, shield the parameter with parentheses
```powershell
$ascii_ctls = New-Object string (,[char[]](0..31)) # gives desired result
```
Note that shielding is still necessary even when explicitly specifying the
parameters by name because a prepended comma is not syntactically valid when
parsing in argument mode, see [about_Parsing](about_Parsing.md#argument-mode)

## Array element type

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

As a result, the `$ia` array can contain only integers. In fact, any appended
elements will be converted to integers, if possible.

```powershell
$ia += 6502
$ia.GetType().Name
$ia += 5.3
$ia.GetType().Name
$ia += '4711'
$ia.GetType().Name
$ia[-2,-1]
```

```Output
Int32[]
Int32[]
Int32[]
5
4711
```

You can create arrays that are cast to any type supported by .NET. For
example, the objects that `Get-Process` retrieves to represent processes are of
the **System.Diagnostics.Process** type. To create a strongly typed array of
process objects, enter the following command:

```powershell
[Diagnostics.Process[]]$zz = Get-Process
```

Note the difference between a strongly typed array variable and a variable containing
a strongly typed array. The latter does not remain strongly typed when manipulated,
even when appending values of the same type as the current elements.

```powershell
$ia = [int32[]](1500,2230,3350,4000)
$ia.GetType().Name
$ia += 6502
$ia.GetType().Name
```

```Output
Int32[]
Object[]
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

However, be cautious when using this notation. The index value list proceeds
from the starting index numerical value towards the ending index numerical
value, looping between the array's beginning and end, if necessary.

```powershell
$a = 0 .. 9
$a[2..-2]
''
$a[-2..2]
```

```Output
2
1
0
9
8

8
9
0
1
2
```

Also, one common mistake is to assume `$a[0..-2]` refers to all the elements
of the array, except for the last one, i.e. `$a[0,1,2,...,-2]`. However, using
the description above it can be seen that this actually refers to the first,
last, and second-to-last elements in the array, `$a[0,-1,-2]`.

You can use the plus operator (`+`) to combine ranges, lists or individual
elements in an array. For example, to display the elements at
index positions 0, 2, and 4 through 6 in order, type:

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

Or to list elements zero to two, four to six, and the
element at position eight, type:

```powershell
$a = 0..9
$a[0..2+4..6+8]
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

Note that the index list expression must start with an array value
(list or range) so that the plus operator performs array appending
instead of attempting numerical addition of a value with an array.

### Iterations over array elements

You can also use looping constructs, such as `ForEach`, `For`, and `While`
loops, to refer to the elements in an array. For example, to use a `ForEach`
loop to display the elements in the `$a` array, type:

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

The `Foreach` loop iterates through the array and returns each value in the
array until reaching the end of the array.

The `For` loop is useful when you are incrementing counters while examining the
elements in an array. For example, to use a `For` loop to return every other
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

You can use a `While` loop to display the elements in an array until a defined
condition is no longer true. For example, to display the elements in the `$a`
array while the array index is less than 4, type:

```powershell
$a = 0..9
$i=0
while($i -lt 4) {
  $a[$i]
  $i++
}
```

```Output
0
1
2
3
```

## Properties of PowerShell arrays

### Count or Length or LongLength

To determine how many items are in an array, use the **Length** property or its
**Count** alias. **Longlength** is useful if the array contains more than
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
array like the following example:

```powershell
$a = @(
  @(0,1),
  @("b", "c"),
  @(Get-Process)
)

"`$a rank: $($a.Rank)"
"`$a length: $($a.Length)"
"`$a[2] length: $($a[2].Length)"
"Process `$a[2][1]: $($a[2][1].ProcessName)"
```

In this example, you are creating a single-dimensional array that contains
other arrays. This is also known as a _jagged array_. The **Rank** property
proved that this is single-dimensional. To access items in a jagged array, the
indexes must be in separate brackets (`[]`).

```Output
$a rank: 1
$a length: 3
$a[2] length: 348
Process $a[2][1]: AcroRd32
```

Multidimensional arrays are stored in
[row-major order](https://wikipedia.org/wiki/Row-_and_column-major_order). The following example
shows how to create a truly multidimensional array.

```powershell
[string[,]]$rank2 = [string[,]]::New(3,2)
$rank2.rank
$rank2.Length
$rank2[0,0] = 'a'
$rank2[0,1] = 'b'
$rank2[1,0] = 'c'
$rank2[1,1] = 'd'
$rank2[2,0] = 'e'
$rank2[2,1] = 'f'
$rank2[1,1]
```

```Output
2
6
d
```

To access items in a multidimensional array, separate the indexes using a comma
(`,`) within a single set of brackets (`[]`).

Some operations on a multidimensional array, such as replication and
concatenation, require that array to be flattened. Flattening turns the array
into a 1-dimensional array of unconstrained type. The resulting array takes on
all the elements in row-major order. Consider the following example:

```powershell
$a = "red",$true
$b = (New-Object 'int[,]' 2,2)
$b[0,0] = 10
$b[0,1] = 20
$b[1,0] = 30
$b[1,1] = 40
$c = $a + $b
$a.GetType().Name
$b.GetType().Name
$c.GetType().Name
$c
```

The output shows that `$c` is a 1-dimensional array containing the items from
`$a` and `$b` in row-major order.

```output
Object[]
Int32[,]
Object[]
red
True
10
20
30
40
```

## Methods of arrays

### Clear

Sets all element values to the _default value_ of the array's element type.
The `Clear()` method does not reset the size of the array.

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

The `ForEach` method has several overloads that perform different operations.

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

The following example shows how use the `ForEach` method. In this case the
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

Just like the `-ArgumentList` parameter of `ForEach-Object`, the `Arguments`
parameter allows the passing of an array of values to a script block configured
to accept them.

> [!NOTE]
> Starting in Windows PowerShell 3.0 retrieving properties and executing
> methods for each item in a collection can also be accomplished using "Methods
> of scalar objects and collections". You can read more about that here
> [about_methods](about_methods.md).

### Where

Allows filtering to select elements of the array. Elements are selected based on
the result of evaluating a scriptblock for each element in turn (accessable as `$_`
or `$PSItem` within the scriptblock). An element is "selected" if the script evaluates 
to anything other than `$false`, after converting to `[Boolean]` if necessary, i.e.
`$false`, numeric zero (0), empty string, `$null` or an empty collection.
For more information about boolean
evaluation, see [about_Booleans](about_Booleans.md).

There is one definition for the `Where` method.

```
Where(scriptblock expression[, WhereOperatorSelectionMode mode
                            [, int numberToReturn]])
```

> [!NOTE]
> The syntax requires the usage of a script block. Parentheses are optional if
> the scriptblock is the only parameter. Also, there must not be a space
> between the method and the opening parenthesis or brace.

The `expression` is the scriptblock that is required for filtering, the `mode`
optional argument allows varying the choice of returned items, and the
`numberToReturn` optional argument allows the ability to limit the number of
items that are returned. Note that once the `numberToReturn` criterion has been
fulfilled, `Where` stops processing the collection. This can affect any side-effects
of the script block. If there are fewer than `numberToSelect` items to return then
they are all returned in a collection smaller than `numberToSelect`.

The members, values and effects of the `WhereOperatorSelectionMode` enumeration (in
conjunction with a specified `numberToReturn` or its default value) are:

|Member Name|Value|Effect|`numberToReturn` default value|
|-|-|------|----------------------------|
|Default|0|Return the first `numberToReturn` selected items|Unlimited|
|First|1|Return the first `numberToReturn` selected items|1|
|Last|2|Return the last `numberToReturn` selected items|1|
|SkipUntil|3|Skip items until a selected item is found, then return the selected item and *all* subsequent items (selected or not), up to `numberToReturn` items|Unlimited|
|Until|4|Return *all* items, up to `numberToReturn` items, until but not including the first selected item|Unlimited|
|Split|5|Return a two element array<br> &bull; The first element contains the first `numberToReturn` selected items<br> &bull; The second element contains *all* the remaining items|Unlimited|

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

Mode value used if `mode` not specified.

#### First

The `Default` and `First` modes both select items using the `expression` scriptblock.
The difference is the default value of `numberToReturn` if it is not specified.
If `numberToReturn` is supplied, the `Default` and `First` modes are identical.

```powershell
# Get the zip files in the current users profile, sorted by LastAccessTime.
$Zips = dir $env:userprofile -Recurse '*.zip' | Sort-Object LastAccessTime
# Get the least accessed file over 100MB
$Zips.Where({$_.Length -gt 100MB}, 'Default', 1)
# mode member name strings automatically cast to enumeration type
$Zips.Where({$_.Length -gt 100MB}, 'First') # same result
```

#### Last

Like `Default` and `First`, the `Last` mode selects items using the `expression` scriptblock.
However, instead of returning `numberToReturn` selected items starting from the first selected item,
`Last` returns all the remaining selected items starting `numberToReturn` items from the the end
of the list of selected items, implying that all items must be tested before `numberToReturn`
is applied. (note: the last selected item is considered to be one item from the end of the selection
list).

```powershell
$h = (Get-Date).AddHours(-1)
$logs = dir 'C:\' -Recurse '*.log' | Sort-Object CreationTime
# Find the last 5 log files created in the past hour.
$logs.Where({$_.CreationTime -gt $h}, 'Last', 5)
```

#### SkipUntil

The `SkipUntil` mode skips items until an item *passes* the script block expression filter.
It then returns this item and **ALL** subsequent collection
items without testing them. _Only the **first** returned item has been tested_.

This means that the returned collection can contain both _passing_ and
_non-passing_ items that have NOT been tested. This can affect any side-effects of the
script block similarly to the effect of `numberToReturn`.

```powershell
$computers = "Server01", "Server02", "Server03", "localhost", "Server04"
# Find the first available online server.
$computers.Where({ Test-Connection $_ }, 'SkipUntil', 1)
```

```Output
localhost
```

#### Until

The `Until` mode inverts the `SkipUntil` mode.  It returns `numberToReturn` items in a
collection up to, but not including, the first item which *passes* the script block expression.
Once an item _passes_ the scriptblock expression, the `Where` method stops processing items.

This means that you receive the first set of _non-passing_ items from the
`Where` method. _After_ one item passes, the rest are NOT tested or returned.

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

#### Split

The `Split` mode groups the collection items into two separate
collections. Those that pass the scriptblock expression, and those that do not.

If `numberToReturn` is specified, the first collection only contains up to this
many _passing_ items.

The remaining objects, including those beyond `numberToReturn` that would have
**PASSED** the expression filter, are returned in the second collection.

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

> [!NOTE]
> Both the `ForEach` and `Where` methods are intrinsic members. This means that all PowerShell
> objects may invoke them. If an object which is not a collection type (i.e. a type that implements
> `[System.Collections.IEnumerable]`) invokes `ForEach` or `Where`,
> it is treated as an array of one element, being the invoking object. See
[Arrays of zero or one](#arrays-of-zero-or-one). For example,
> `$nonarrayobj.ForEach{ }` is treated as `@($nonarrayobj).ForEach{ }`. Further, some .NET types
> already define their own `ForEach` method. In cases where an object type already defines a `ForEach`
> or `Where` method, these take precedence over the PowerShell intrinsic methods. For more information
> about intrinsic members, see [about_Instrinsic_Members](about_Intrinsic_Members.md)

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
value that is piped to the `Get-Member` cmdlet. The comma makes the value
the only item in an array of items. PowerShell pipes the array item as a whole and
`Get-Member` returns the members of the passed whole array object. Like the next two
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
$a = 0..4
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

Beginning in Windows PowerShell 3.0, both a single (non-collection) object
and `$null` can be treated as an array in certain contexts. Within these contexts,
`$null` is treated as an empty array `@()` while a non-collection object is treated
as a one item array containing just that object. Thus, you can access the following
properties and methods of PowerShell arrays,

- Count
- Length
- ForEach()
- Where()

You can also apply indexing to a non-collection object (but not `$null`).
This feature helps you to
avoid scripting errors that occur when a command that expects a collection gets
`$null` or a non-collection object, often because the supplied input was a pipeline
output that contained fewer than two items.

The following examples demonstrate this feature.

### $null

```powershell
$a = $null
$a.Count
$a.Length
$a.ForEach({$_}) # valid but no items so
$a.Where({$True}) # no output, not even $null
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
$a[0] # first (only) item is object
$a[-1] # and also last item
$a.ForEach({ $_ * 2 })
$a.Where({ $_ -lt 10 })
```

```Output
1
1
4
4
8
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

## Member enumeration

You can use member enumeration to get property values from all members of a
collection. When you use the member access operator (`.`) with a member name on
a collection object, such as an array, if the collection object does not have a
member of that name, the items of the collection are enumerated and PowerShell
looks for that member on each item. This applies to both property and method
members.

The following example creates two new files and stores the resulting objects in
the array variable `$files`. Since the array object does not have the
**LastWriteTime** member, the value of **LastWriteTime** is returned for each
item in the array.

```powershell
$files = (New-Item -Type File -Force '/temp/t1.txt'),
         (New-Item -Force -Type File '/temp/t2.txt')
$files.LastWriteTime
```

```Output
Friday, June 25, 2021 1:21:17 PM
Friday, June 25, 2021 1:21:17 PM
```

Member enumeration can be used to _get_ values from items in a collection, but
it cannot be used to _set_ values on items in a collection. For example:

```powershell
$files.LastWriteTime = (Get-Date).AddDays(-1)
```

```Output
InvalidOperation: The property 'LastWriteTime' cannot be found on this object.
Verify that the property exists and can be set.
```

To set the values you must use a method.

```powershell
$files.set_LastWriteTime((Get-Date).AddDays(-1))
$files.LastWriteTime
```

```Output
Thursday, June 24, 2021 1:23:30 PM
Thursday, June 24, 2021 1:23:30 PM
```

The `set_LastWriteTime()` method is a _hidden_ member of the **FileInfo**
object. The following example shows how to find members that have a _hidden_
`set` method.

```powershell
$files | Get-Member | Where-Object Definition -like '*set;*'
```

```Output
   TypeName: System.IO.FileInfo

Name              MemberType Definition
----              ---------- ----------
Attributes        Property   System.IO.FileAttributes Attributes {get;set;}
CreationTime      Property   datetime CreationTime {get;set;}
CreationTimeUtc   Property   datetime CreationTimeUtc {get;set;}
IsReadOnly        Property   bool IsReadOnly {get;set;}
LastAccessTime    Property   datetime LastAccessTime {get;set;}
LastAccessTimeUtc Property   datetime LastAccessTimeUtc {get;set;}
LastWriteTime     Property   datetime LastWriteTime {get;set;}
LastWriteTimeUtc  Property   datetime LastWriteTimeUtc {get;set;}
```

> [!CAUTION]
> Since the method is executed for each item in the collection, care should be
> taken when calling methods using member enumeration.

## See also

- [about_Assignment_Operators](about_Assignment_Operators.md)
- [about_Hash_Tables](about_Hash_Tables.md)
- [about_Operators](about_Operators.md)
- [about_For](about_For.md)
- [about_Foreach](about_Foreach.md)
- [about_While](about_While.md)
