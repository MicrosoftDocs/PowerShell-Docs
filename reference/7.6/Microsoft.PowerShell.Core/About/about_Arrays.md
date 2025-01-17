---
description: Describes arrays, which are data structures designed to store collections of items.
Locale: en-US
ms.date: 01/03/2025
no-loc: [Count, Length, LongLength, Rank, ForEach, Clear, Default, First, Last, SkipUntil, Until, Split, Tuple]
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Arrays
---
# about_Arrays

## Short description

Describes arrays, which are data structures designed to store collections of
items.

## Long description

An array is a data structure that's designed to store a collection of items.
The items can be the same type or different types.

Beginning in Windows PowerShell 3.0, a collection of zero or one object has
some properties of arrays.

## Creating and initializing an array

To create and initialize an array, assign multiple values to a variable. The
values stored in the array are delimited with a comma and separated from the
variable name by the assignment operator (`=`).

For example, to create an array named `$A` that contains the seven numeric
(integer) values of 22, 5, 10, 8, 12, 9, and 80, type:

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

You can also create and initialize an array using the range operator (`..`).
The following example creates an array containing the values 5 through 8.

```powershell
$C = 5..8
```

As a result, `$C` contains four values: 5, 6, 7, and 8.

When no data type is specified, PowerShell creates each array as an object
array (**System.Object[]**). To determine the data type of an array, use the
`GetType()` method. For example:

```powershell
$A.GetType()
```

To create a strongly typed array, that is, an array that can contain only
values of a particular type, cast the variable as an array type, such as
**string[]**, **long[]**, or **int32[]**. To cast an array, precede the
variable name with an array type enclosed in brackets. For example:

```powershell
[Int32[]]$ia = 1500, 2230, 3350, 4000
```

As a result, the `$ia` array can contain only integers.

You can create arrays that are cast to any supported type in the .NET. For
example, the objects that `Get-Process` retrieves to represent processes are of
the **System.Diagnostics.Process** type. To create a strongly typed array of
process objects, enter the following command:

```powershell
[Diagnostics.Process[]]$zz = Get-Process
```

## The array sub-expression operator

The array sub-expression operator creates an array from the statements inside
it. Whatever the statement inside the operator produces, the operator places it
in an array. Even if there is zero or one object.

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

The array operator is useful in scripts when you are getting objects, but don't
know how many to expect. For example:

```powershell
$p = @(Get-Process Notepad)
```

For more information about the array sub-expression operator, see
[about_Operators][11].

## Accessing and using array elements

### Reading an array

You can refer to an array using its variable name. To display all the elements
in the array, invoke the array name. For example, `$a` is an array of the
numbers 0 through 9:

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

You can refer to the elements in an array using an index. Enclose the index
number in brackets. Index values start at `0`. For example, to display the
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
example, to retrieve the second to fifth elements of the array, you would type:

```powershell
$a[1..4]
```

```Output
1
2
3
4
```

Negative numbers count from the end of the array. For example, `-1` refers to
the last element of the array. To display the last three elements of the array,
in index ascending order, type:

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

However, be cautious when using this notation. The notation cycles from the end
boundary to the beginning of the array.

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

Also, one common mistake is to assume `$a[0..-2]` refers to all the elements of
the array, except for the last one. It refers to the first, last, and
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

You can also use looping constructs, such as `foreach`, `for`, and `while`
loops, to refer to the elements in an array. For example, to use a `foreach`
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

The `foreach` loop iterates through the array and returns each value in the
array until reaching the end of the array.

The `for` loop is useful when you are incrementing counters while examining the
elements in an array. For example, to use a `for` loop to return every other
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

You can use a `while` loop to display the elements in an array until a defined
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

## Properties of arrays

### Count or Length or LongLength

In PowerShell, arrays have three properties that indicate the number of items
contained in the array.

- **Count** - This property is the most commonly used property to determine the
  number of items in any collection, not just an array. It's an `[Int32]` type
  value. In Windows PowerShell 5.1 (and older) **Count** alias property for
  **Length**.

- **Length** - This property is an `[Int32]` type value. This contains the same
  value as **Count**.

  > [!NOTE]
  > While **Count** and **Length** are equivalent for arrays, **Length** can
  > have a different meaning for other types. For example, **Length** for a
  > string is the number of characters in the string. But the **Count**
  > property is always `1`.

- **Longlength** - This property is an `[Int64]` type value. Use this property
  for arrays containing more than 2,147,483,647 elements.

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

Multidimensional arrays are stored in [row-major order][14]. The following
example shows how to create a truly multidimensional array.

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

Sets all element values to the _default value_ of the array's element type. The
`Clear()` method doesn't reset the size of the array.

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
[Int[]] $intA = 1, 2, 3
$intA.Clear()
$intA
```

```Output
0
0
0
```

### ForEach()

Allows to iterate over all elements in the array and perform a given operation
for each element of the array.

The `ForEach()` method has several overloads that perform different operations.

```Syntax
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

The following example shows how use the `ForEach()` method. In this case the
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

Just like the **ArgumentList** parameter of `ForEach-Object`, the `arguments`
parameter allows the passing of an array of arguments to a script block
configured to accept them.

For more information about the behavior of **ArgumentList**, see
[about_Splatting][12].

#### ForEach(type convertToType)

The `ForEach()` method can be used to cast the elements to a different type;
the following example shows how to convert a list of string dates to
`[DateTime]` type.

```powershell
("1/1/2017", "2/1/2017", "3/1/2017").ForEach([datetime])
```

```Output

Sunday, January 1, 2017 12:00:00 AM
Wednesday, February 1, 2017 12:00:00 AM
Wednesday, March 1, 2017 12:00:00 AM
```

#### ForEach(string propertyName)

#### ForEach(string propertyName, object[] newValue)

The `ForEach()` method can also be used to retrieve, or set property values for
every item in the collection.

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

Lastly, `ForEach()` methods can be used to execute a method on every item in
the collection.

```powershell
("one", "two", "three").ForEach("ToUpper")
```

```Output
ONE
TWO
THREE
```

Just like the **ArgumentList** parameter of `ForEach-Object`, the `arguments`
parameter allows the passing of an array of values to a script block configured
to accept them.

> [!NOTE]
> Starting in Windows PowerShell 3.0 retrieving properties and executing
> methods for each item in a collection can also be accomplished using "Methods
> of scalar objects and collections". You can read more about that here
> [about_Methods][10].

### Where()

Allows to filter or select the elements of the array. The script must evaluate
to anything different than: zero (0), empty string, `$false` or `$null` for the
element to show after the `Where()`. For more information about boolean
evaluation, see [about_Booleans][04].

There is one definition for the `Where()` method.

```
Where(scriptblock expression[, WhereOperatorSelectionMode mode
                            [, int numberToReturn]])
```

> [!NOTE]
> The syntax requires the usage of a script block. Parentheses are optional if
> the scriptblock is the only parameter. Also, there must not be a space
> between the method and the opening parenthesis or brace.

The `Expression` is a scriptblock that's required for filtering, the `mode`
optional argument allows additional selection capabilities, and the
`numberToReturn` optional argument allows the ability to limit how many items
are returned from the filter.

The value of `mode` must be a [WhereOperatorSelectionMode][02] enum value:

- `Default` (`0`) - Return all items
- `First` (`1`) - Return the first item
- `Last` (`2`) - Return the last item
- `SkipUntil` (`3`) - Skip items until condition is true, return all the remaining
  items (including the first item for which the condition is true)
- `Until` (`4`) - Return all items until condition is true
- `Split` (`5`) - Return an array of two elements
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

The next example shows how to select all non-empty strings.

```powershell
('hi', '', 'there').Where{ $_ }
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
# Get the zip files in the current users profile, sorted by LastAccessTime
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
# Find the last 5 log files created in the past hour
$logs.Where({$_.CreationTime -gt $h}, 'Last', 5)
```

#### SkipUntil

The `SkipUntil` mode skips all objects in a collection until an object passes
the script block expression filter. It then returns **ALL** remaining
collection items without testing them. _Only one passing item is tested_.

This means the returned collection contains both _passing_ and
_non-passing_ items that have _NOT_ been tested.

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

The `Until` mode inverts the `SkipUntil` mode. It returns **ALL** items in a
collection until an item passes the script block expression. Once an item
_passes_ the scriptblock expression, the `Where()` method stops processing
items.

This means that you receive the first set of _non-passing_ items from the
`Where()` method. _After_ one item passes, the rest are _NOT_ tested or
returned.

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
> `Until` returns the items **BEFORE** the first _PASS_. `SkipUntil` returns
> all items **AFTER** the first _pass_, including the first passing item.

#### Split

The `Split` mode splits, or groups collection items into two separate
collections. Those that pass the scriptblock expression, and those that do not.

If a `numberToReturn` is specified, the first collection, contains the
_passing_ items, not to exceed the value specified.

The remaining objects, even those that _PASS_ the expression filter, are
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

> [!NOTE]
> Both `ForEach()` and `Where()` methods are intrinsic members. For more
> information about intrinsic members, see [about_Intrinsic_Members][08].

## Get the members of an array

To get the properties and methods of an array, such as the **Length** property
and the **SetValue** method, use the **InputObject** parameter of the
`Get-Member` cmdlet.

When you pipe an array to `Get-Member`, PowerShell sends the items one at a
time and `Get-Member` returns the type of each item in the array (ignoring
duplicates).

When you use the **InputObject** parameter, `Get-Member` returns the members of
the array.

For example, the following command gets the members of the `$a` array variable.

```powershell
Get-Member -InputObject $a
```

You can also get the members of an array by typing a comma (`,`) before the
value that's piped to the `Get-Member` cmdlet. The comma makes the array the
second item in an array of arrays. PowerShell pipes the arrays one at a time
and `Get-Member` returns the members of the array. Like the next two examples.

```powershell
,$a | Get-Member

,(1,2,3) | Get-Member
```

## Manipulating an array

You can change the elements in an array, add an element to an array, and
combine the values from two arrays into a third array.

To change the value of a particular element in an array, specify the array name
and the index of the element that you want to change, and then use the
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
> When you use the `+=` operator, PowerShell actually creates a new array with
> the values of the original array and the added value. This might cause
> performance issues if the operation is repeated several times or the size of
> the array is too big.

It isn't easy to delete elements from an array, but you can create a new array
that contains only selected elements of an existing array. For example, to
create the `$t` array with all the elements in the `$a` array except for the
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

Beginning in Windows PowerShell 3.0, a scalar types and collection of zero or
one objects has the **Count** and **Length** properties. Also, you can use
array index notation to access the value of a singleton scalar object. This
feature helps you to avoid scripting errors that occur when a command that
expects a collection gets fewer than two items.

The following example shows that a variable that contains no objects has a
**Count** and **Length** of 0.

```powershell
PS> $a = $null
PS> $a.Count
0
PS> $a.Length
0
```

The following example shows that a variable that contains one object has a
**Count** and **Length** of 1. You can also use array indexing to access the
value of the object.

```powershell
PS> $a = 4
PS> $a.Count
1
PS> $a.Length
1
PS> $a[0]
4
PS> $a[-1]
4
```

When you run a command that could return a collection or a single object, you
can use array indexing to access the value of the object without having to test
the **Count** or **Length** properties. However, if the result is a single
object (singleton), and that object has a **Count** or **Length** property, the
value of those properties belong to the singleton object and don't represent
the number of items in the collection.

In the following example, the command returns a single string object. The
**Length** of that string is `4`.

```powershell
PS> $result = 'one','two','three','four' | Where-Object {$_ -like 'f*'}
PS> $result.GetType().FullName
System.String
PS> $result
four
PS> $result.Count
1
PS❯ $result.Length
4
```

If you want `$result` to be an array of strings, you need to declare the
variable as an array.

In this example, `$result` is an array of strings. The **Count** and **Length**
of the array is `1`, and the **Length** of the first element is `4`.

```powershell
PS> [string[]]$result = 'one','two','three','four' |
    Where-Object {$_ -like 'f*'}
PS> $result.GetType().FullName
System.String[]
PS> $result
four
PS> $result.Count
1
PS> $result.Length
1
PS> $result[0].Length
4
```

## Indexing support for System.Tuple objects

PowerShell 6.1 added the support for indexed access of **Tuple** objects,
similar to arrays. For example:

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

For more information, see [System.Tuple][01].

## Indexing .NET types that implement `IDictionary<TKey, TValue>`

PowerShell doesn't call a type's true indexer for types that implement the
generic `IDictionary<TKey, TValue>` interface. Instead, when given a key,
PowerShell tests for the existence of the key using `TryGetValue()`, which
returns `$null` when the key doesn't exist.

By contrast, if you call the type's true indexer using `Item(<key>)`, the
method throws an exception when the key doesn't exist.

The following example illustrates the difference.

```powershell
PS> [Collections.Generic.Dictionary[string, int]]::new()['nosuchkey']
# No output ($null)

PS> [Collections.Generic.Dictionary[string, int]]::new().Item('nosuchkey')
GetValueInvocationException: Exception getting "Item": "The given key 'nosuchkey'
 was not present in the dictionary."
```

## Member-access enumeration

Starting in PowerShell 3.0, when you use the member-access operator to access a
member that doesn't exist on a list collection, PowerShell automatically
enumerates the items in the collection and attempts to access the specified
member on each item. For more information, see
[about_Member-Access_Enumeration][09].

### Examples

The following example creates two new files and stores the resulting objects in
the array variable `$files`. Since the array object doesn't have the
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

Member-access enumeration enables you to _get_ values from items in a
collection, but not to _set_ values on items in a collection. For example:

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
object. The following example shows how to find _hidden_ `set` methods.

```powershell
$files | Get-Member -Force -Name set_*
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

- [about_For][05]
- [about_ForEach][06]
- [about_Hash_Tables][07]
- [about_Member-Access_Enumeration][09]
- [about_Operators][11]
- [about_Assignment_Operators][03]
- [about_While][13]

<!-- link references -->
[01]: /dotnet/api/system.tuple
[02]: xref:System.Management.Automation.WhereOperatorSelectionMode
[03]: about_Assignment_Operators.md
[04]: about_Booleans.md
[05]: about_For.md
[06]: about_ForEach.md
[07]: about_Hash_Tables.md
[08]: about_Intrinsic_Members.md
[09]: about_Member-Access_Enumeration.md
[10]: about_Methods.md
[11]: about_Operators.md
[12]: about_Splatting.md#splatting-with-arrays
[13]: about_While.md
[14]: https://wikipedia.org/wiki/Row-_and_column-major_order
