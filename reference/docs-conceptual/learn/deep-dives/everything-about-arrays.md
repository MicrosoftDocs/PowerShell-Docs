---
title: Everything you wanted to know about arrays
description: Arrays are a fundamental language feature of most programming languages.
ms.date: 10/08/2020
ms.custom: contributor-KevinMarquette
---
# Everything you wanted to know about arrays

[Arrays][] are a fundamental language feature of most programming languages. They're a collection of
values or objects that are difficult to avoid. Let's take a close look at arrays and everything they
have to offer.

> [!NOTE]
> The [original version][] of this article appeared on the blog written by [@KevinMarquette][]. The
> PowerShell team thanks Kevin for sharing this content with us. Please check out his blog at
> [PowerShellExplained.com][].

## What is an array?

I'm going to start with a basic technical description of what arrays are and how they are used by
most programming languages before I shift into the other ways PowerShell makes use of them.

An array is a data structure that serves as a collection of multiple items. You can iterate over the
array or access individual items using an index. The array is created as a sequential chunk of
memory where each value is stored right next to the other.

I'll touch on each of those details as we go.

## Basic usage

Because arrays are such a basic feature of PowerShell, there is a simple syntax for working with
them in PowerShell.

### Create an array

An empty array can be created by using `@()`

```powershell
PS> $data = @()
PS> $data.count
0
```

We can create an array and seed it with values just by placing them in the `@()` parentheses.

```powershell
PS> $data = @('Zero','One','Two','Three')
PS> $data.count
4

PS> $data
Zero
One
Two
Three
```

This array has 4 items. When we call the `$data` variable, we see the list of our items. If it's an
array of strings, then we get one line per string.

We can declare an array on multiple lines. The comma is optional in this case and generally left
out.

```powershell
$data = @(
    'Zero'
    'One'
    'Two'
    'Three'
)
```

I prefer to declare my arrays on multiple lines like that. Not only does it get easier to read when
you have multiple items, it also makes it easier to compare to previous versions when using source
control.

#### Other syntax

It's commonly understood that `@()` is the syntax for creating an array, but comma-separated lists
work most of the time.

```powershell
$data = 'Zero','One','Two','Three'
```

#### Write-Output to create arrays

One cool little trick worth mentioning is that you can use `Write-Output` to quickly create strings
at the console.

```powershell
$data = Write-Output Zero One Two Three
```

This is handy because you don't have to put quotes around the strings when the parameter accepts
strings. I would never do this in a script but it's fair game in the console.

### Accessing items

Now that you have an array with items in it, you may want to access and update those items.

#### Offset

To access individual items, we use the brackets `[]` with an offset value starting at 0. This is
how we get the first item in our array:

```powershell
PS> $data = 'Zero','One','Two','Three'
PS> $data[0]
Zero
```

The reason why we use zero here is because the first item is at the beginning of the list so we use
an offset of 0 items to get to it. To get to the second item, we would need to use an offset of 1 to
skip the first item.

```powershell
PS> $data[1]
One
```

This would mean that the last item is at offset 3.

```powershell
PS> $data[3]
Three
```

#### Index

Now you can see why I picked the values that I did for this example. I introduced this as an offset
because that is what it really is, but this offset is more commonly referred to as an index. An
index that starts at `0`. For the rest of this article I will call the offset an index.

#### Special index tricks

In most languages, you can only specify a single number as the index and you get a single item back.
PowerShell is much more flexible. You can use multiple indexes at once. By providing a list of
indexes, we can select several items.

```powershell
PS> $data[0,2,3]
Zero
Two
Three
```

The items are returned based on the order of the indexes provided. If you duplicate an index,
you get that item both times.

```powershell
PS> $data[3,0,3]
Three
Zero
Three
```

We can specify a sequence of numbers with the built-in `..` operator.

```powershell
PS> $data[1..3]
One
Two
Three
```

This works in reverse too.

```powershell
PS> $data[3..1]
Three
Two
One
```

You can use negative index values to offset from the end. So if you need the last item in the list,
you can use `-1`.

```powershell
PS> $data[-1]
Three
```

One word of caution here with the `..` operator. The sequence `0..-1` and `-1..0` evaluate to the
values `0,-1` and `-1,0`. It's easy to see `$data[0..-1]` and think it would enumerate all items if
you forget this detail. `$data[0..-1]` gives you the same value as `$data[0,-1]` by giving you the
first and last item in the array (and none of the other values).

#### Out of bounds

In most languages, if you try to access an index of an item that is past the end of the array, you
would get some type of error or an exception. PowerShell silently returns nothing.

```powershell
PS> $null -eq $data[9000]
True
```

#### Cannot index into a null array

If your variable is `$null` and you try to index it like an array, you get a
`System.Management.Automation.RuntimeException` exception with the message
`Cannot index into a null array`.

```powershell
PS> $empty = $null
SP> $empty[0]
Error: Cannot index into a null array.
```

So make sure your arrays are not `$null` before you try to access elements inside them.

#### Count

Arrays and other collections have a count property that tells you how many items are in the array.

```powershell
PS> $data.count
4
```

PowerShell 3.0 added a count property to most objects. you can have a single object and it should
give you a count of `1`.

```powershell
PS> $date = Get-Date
PS> $date.count
1
```

Even `$null` has a count property except it returns `0`.

```powershell
PS> $null.count
0
```

There are some traps here that I will revisit when I cover checking for `$null` or empty arrays
later on in this article.

#### Off-by-one errors

A common programming error is created because arrays start at index 0. Off-by-one errors can be
introduced in two ways.

The first is by mentally thinking you want the second item and using an index of `2` and really getting
the third item. Or by thinking that you have four items and you want last item, so you use the count
to access the last item.

```powershell
$data[ $data.count ]
```

PowerShell is perfectly happy to let you do that and give you exactly what item exists at index 4:
`$null`. You should be using `$data.count - 1` or the `-1` that we learned about above.

```powershell
PS> $data[ $data.count - 1 ]
Three
```

This is where you can use the `-1` index to get the last element.

```powershell
PS> $data[ -1 ]
Three
```

Lee Dailey also pointed out to me that we can use `$data.GetUpperBound(0)` to get the max index
number.

```powershell
PS> $data.GetUpperBound(0)
3
PS> $data[ $data.GetUpperBound(0) ]
Three
```

The second most common way is when iterating the list and not stopping at the right time. I'll
revisit this when we talk about using the `for` loop.

### Updating items

We can use the same index to update existing items in the array. This gives us direct access to
update individual items.

```powershell
$data[2] = 'dos'
$data[3] = 'tres'
```

If we try to update an item that is past the last element, then we get an
`Index was outside the bounds of the array.` error.

```powershell
PS> $data[4] = 'four'
Index was outside the bounds of the array.
At line:1 char:1
+ $data[4] = 'four'
+ ~~~~~~~~~~~~~
+ CategoryInfo          : OperationStopped: (:) [], IndexOutOfRangeException
+ FullyQualifiedErrorId : System.IndexOutOfRangeException
```

I'll revisit this later when I talk about how to make an array larger.

### Iteration

At some point, you might need to walk or iterate the entire list and perform some action for each
item in the array.

#### Pipeline

Arrays and the PowerShell pipeline are meant for each other. This is one of the simplest ways to
process over those values. When you pass an array to a pipeline, each item inside the array is
processed individually.

```powershell
PS> $data = 'Zero','One','Two','Three'
PS> $data | ForEach-Object {"Item: [$PSItem]"}
Item: [Zero]
Item: [One]
Item: [Two]
Item: [Three]
```

If you have not seen `$PSItem` before, just know that it's the same thing as `$_`. You can use either
one because they both represent the current object in the pipeline.

#### ForEach loop

The `ForEach` loop works well with collections. Using the syntax:
`foreach ( <variable> in <collection> )`

```powershell
foreach ( $node in $data )
{
    "Item: [$node]"
}
```

#### ForEach method

I tend to forget about this one but it works well for simple operations. PowerShell allows you to
call `.ForEach()` on a collection.

```powershell
PS> $data.foreach({"Item [$PSItem]"})
Item [Zero]
Item [One]
Item [Two]
Item [Three]
```

The `.foreach()` takes a parameter that is a script block. You can drop the parentheses and just
provide the script block.

```powershell
$data.foreach{"Item [$PSItem]"}
```

This is a lesser known syntax but it works just the same. This `foreach` method was added in
PowerShell 4.0.

#### For loop

The `for` loop is used heavily in most other languages but you don't see it much in PowerShell. When
you do see it, it's often in the context of walking an array.

```powershell
for ( $index = 0; $index -lt $data.count; $index++)
{
    "Item: [{0}]" -f $data[$index]
}
```

The first thing we do is initialize an `$index` to `0`. Then we add the condition that `$index` must
be less than `$data.count`. Finally, we specify that every time we loop that me must increase the
index by `1`. In this case `$index++` is short for `$index = $index + 1`.

Whenever you're using a `for` loop, pay special attention to the condition. I used
`$index -lt $data.count` here. It's easy to get the condition slightly wrong to get an off-by-one
error in your logic. Using `$index -le $data.count` or `$index -lt ($data.count - 1)` are ever so
slightly wrong. That would cause your result to process too many or too few items. This is the
classic off-by-one error.

#### Switch loop

This is one that is easy to overlook. If you provide an array to a [switch statement][], it
checks each item in the array.

```powershell
$data = 'Zero','One','Two','Three'
switch( $data )
{
    'One'
    {
        'Tock'
    }
    'Three'
    {
        'Tock'
    }
    Default
    {
        'Tick'
    }
}
```

```Output
Tick
Tock
Tick
Tock
```

There are a lot of cool things that we can do with the switch statement. I have another article
dedicated to this.

- [Everything you ever wanted to know about the switch statement][switch statement]

#### Updating values

When your array is a collection of string or integers (value types), sometimes you may want to
update the values in the array as you loop over them. Most of the loops above use a variable in the
loop that holds a copy of the value. If you update that variable, the original value in the array is
not updated.

The exception to that statement is the `for` loop. If you want to walk an array and update values
inside it, then the `for` loop is what you're looking for.

```powershell
for ( $index = 0; $index -lt $data.count; $index++ )
{
    $data[$index] = "Item: [{0}]" -f $data[$index]
}
```

This example takes a value by index, makes a few changes, and then uses that same index to assign
it back.

## Arrays of Objects

So far, the only thing we've placed in an array is a value type, but arrays can also contain
objects.

```powershell
$data = @(
    [pscustomobject]@{FirstName='Kevin';LastName='Marquette'}
    [pscustomobject]@{FirstName='John'; LastName='Doe'}
)
```

Many cmdlets return collections of objects as arrays when you assign them to a variable.

```powershell
$processList = Get-Process
```

All of the basic features we already talked about still apply to arrays of objects with a few
details worth pointing out.

### Accessing properties

We can use an index to access an individual item in a collection just like with value types.

```powershell
PS> $data[0]

FirstName LastName
-----     ----
Kevin     Marquette
```

We can access and update properties directly.

```powershell
PS> $data[0].FirstName

Kevin

PS> $data[0].FirstName = 'Jay'
PS> $data[0]

FirstName LastName
-----     ----
Jay       Marquette
```

#### Array properties

Normally you would have to enumerate the whole list like this to access all the properties:

```powershell
PS> $data | ForEach-Object {$_.LastName}

Marquette
Doe
```

Or by using the `Select-Object -ExpandProperty` cmdlet.

```powershell
PS> $data | Select-Object -ExpandProperty LastName

Marquette
Doe
```

But PowerShell offers us the ability to request `LastName` directly. PowerShell enumerates them
all for us and returns a clean list.

```powershell
PS> $data.LastName

Marquette
Doe
```

The enumeration still happens but we don't see the complexity behind it.

### Where-Object filtering

This is where `Where-Object` comes in so we can filter and select what we want out of the array
based on the properties of the object.

```powershell
PS> $data | Where-Object {$_.FirstName -eq 'Kevin'}

FirstName LastName
-----     ----
Kevin     Marquette
```

We can write that same query to get the `FirstName` we are looking for.

```powershell
$data | Where FirstName -eq Kevin
```

#### Where()

Arrays have a `Where()` method on them that allows you to specify a `scriptblock` for the filter.

```powershell
$data.Where({$_.FirstName -eq 'Kevin'})
```

This feature was added in PowerShell 4.0.

### Updating objects in loops

With value types, the only way to update the array is to use a for loop because we need to know the
index to replace the value. We have more options with objects because they are reference types. Here
is a quick example:

```powershell
foreach($person in $data)
{
    $person.FirstName = 'Kevin'
}
```

This loop is walking every object in the `$data` array. Because objects are reference types, the
`$person` variable references the exact same object that is in the array. So updates to its
properties do update the original.

You still can't replace the whole object this way. If you try to assign a new object to the
`$person` variable, you're updating the variable reference to something else that no longer points
to the original object in the array. This doesn't work like you would expect:

```powershell
foreach($person in $data)
{
    $person = [pscustomobject]@{
        FirstName='Kevin'
        LastName='Marquette'
    }
}
```

## Operators

The operators in PowerShell also work on arrays. Some of them work slightly differently.

### -join

The `-join` operator is the most obvious one so let's look at it first. I like the `-join`
operator and use it often. It joins all elements in the array with the character or string that
you specify.

```powershell
PS> $data = @(1,2,3,4)
PS> $data -join '-'
1-2-3-4
PS> $data -join ','
1,2,3,4
```

One of the features that I like about the `-join` operator is that it handles single items.

```powershell
PS> 1 -join '-'
1
```

I use this inside logging and verbose messages.

```powershell
PS> $data = @(1,2,3,4)
PS> "Data is $($data -join ',')."
Data is 1,2,3,4.
```

#### -join $array

Here is a clever trick that Lee Dailey pointed out to me. If you ever want to join everything
without a delimiter, instead of doing this:

```powershell
PS> $data = @(1,2,3,4)
PS> $data -join $null
1234
```

You can use `-join` with the array as the parameter with no prefix. Take a look at this example to
see that I'm talking about.

```powershell
PS> $data = @(1,2,3,4)
PS> -join $data
1234
```

### -replace and -split

The other operators like `-replace` and `-split` execute on each item in the array. I can't say
that I have ever used them this way but here is an example.

```powershell
PS> $data = @('ATX-SQL-01','ATX-SQL-02','ATX-SQL-03')
PS> $data -replace 'ATX','LAX'
LAX-SQL-01
LAX-SQL-02
LAX-SQL-03
```

### -contains

The `-contains` operator allows you to check an array of values to see if it contains a specified
value.

```powershell
PS> $data = @('red','green','blue')
PS> $data -contains 'green'
True
```

### -in

When you have a single value that you would like to verify matches one of several values, you can
use the `-in` operator. The value would be on the left and the array on the right-hand side of the
operation.

```powershell
PS> $data = @('red','green','blue')
PS> 'green' -in $data
True
```

This can get expensive if the list is large. I often use a regex pattern if I'm checking more than
a few values.

```powershell
PS> $data = @('red','green','blue')
PS> $pattern = "^({0})$" -f ($data -join '|')
PS> $pattern
^(red|green|blue)$

PS> 'green' -match $pattern
True
```

### -eq and -ne

Equality and arrays can get complicated. When the array is on the left side, every item gets
compared. Instead of returning `True`, it returns the object that matches.

```powershell
PS> $data = @('red','green','blue')
PS> $data -eq 'green'
green
```

When you use the `-ne` operator, we get all the values that are not equal to our value.

```powershell
PS> $data = @('red','green','blue')
PS> $data -ne 'green'
red
blue
```

When you use this in an `if()` statement, a value that is returned is a `True` value. If no value is returned, then it's a `False` value. Both of these next statements evaluate to `True`.

```powershell
$data = @('red','green','blue')
if ( $data -eq 'green' )
{
    'Green was found'
}
if ( $data -ne 'green' )
{
    'And green was not found'
}
```

I'll revisit this in a moment when we talk about testing for `$null`.

### -match

The `-match` operator tries to match each item in the collection.

```powershell
PS> $servers = @(
    'LAX-SQL-01'
    'LAX-API-01'
    'ATX-SQL-01'
    'ATX-API-01'
)
PS> $servers -match 'SQL'
LAX-SQL-01
ATX-SQL-01
```

When you use `-match` with a single value, a special variable `$Matches` gets populated with match
info. This isn't the case when an array is processed this way.

We can take the same approach with `Select-String`.

```powershell
$servers | Select-String SQL
```

I take a closer look at `Select-String`,`-match` and the `$matches` variable in another post called
[The many ways to use regex][].

### $null or empty

Testing for `$null` or empty arrays can be tricky. Here are the common traps with arrays.

At a glance, this statement looks like it should work.

```powershell
if ( $array -eq $null)
{
    'Array is $null'
}
```

But I just went over how `-eq` checks each item in the array. So we can have an array of several
items with a single $null value and it would evaluate to `$true`

```powershell
$array = @('one',$null,'three')
if ( $array -eq $null)
{
    'I think Array is $null, but I would be wrong'
}
```

This is why it's a best practice to place the `$null` on the left side of the operator. This makes
this scenario a non-issue.

```powershell
if ( $null -eq $array )
{
    'Array actually is $null'
}
```

A `$null` array isn't the same thing as an empty array. If you know you have an array, check the
count of objects in it. If the array is `$null`, the count is `0`.

```powershell
if ( $array.count -gt 0 )
{
    "Array isn't empty"
}
```

There is one more trap to watch out for here. You can use the `count` even if you have a single
object, unless that object is a `PSCustomObject`. This is a bug that is fixed in PowerShell 6.1.
That's good news, but a lot of people are still on 5.1 and need to watch out for it.

```powershell
PS> $object = [PSCustomObject]@{Name='TestObject'}
PS> $object.count
$null
```

If you're still on PowerShell 5.1, you can wrap the object in an array before checking the count to
get an accurate count.

```powershell
if ( @($array).count -gt 0 )
{
    "Array isn't empty"
}
```

To fully play it safe, check for `$null`, then check the count.

```powershell
if ( $null -ne $array -and @($array).count -gt 0 )
{
    "Array isn't empty"
}
```

### All -eq

I recently saw someone ask [how to verify that every value in an array matches a given value][].
Reddit user **/u/bis** had this clever [solution][] that checks for any incorrect values and then
flips the result.

```powershell
$results = Test-Something
if ( -not ( $results -ne 'Passed') )
{
    'All results a Passed'
}
```

## Adding to arrays

At this point, you're starting to wonder how to add items to an array. The quick answer is that you
can't. An array is a fixed size in memory. If you need to grow it or add a single item to it, then
you need to create a new array and copy all the values over from the old array. This sounds like a
lot of work, however, PowerShell hides the complexity of creating the new array. PowerShell
implements the addition operator (`+`) for arrays.

> [!NOTE]
> PowerShell does not implement a subtraction operation. If you want a flexible alternative to an
> array, you need to use a [generic `List`](#generic-list) object.

### Array addition

We can use the addition operator with arrays to create a new array. So given these two arrays:

```powershell
$first = @(
    'Zero'
    'One'
)
$second = @(
    'Two'
    'Three'
)
```

We can add them together to get a new array.

```powershell
PS> $first + $second

Zero
One
Two
Three
```

### Plus equals +=

We can create a new array in place and add an item to it like this:

```powershell
$data = @(
    'Zero'
    'One'
    'Two'
    'Three'
)
$data += 'four'
```

Just remember that every time you use `+=` that you're duplicating and creating a new array. This
is a not an issue for small datasets but it scales extremely poorly.

### Pipeline assignment

You can assign the results of any pipeline into a variable. It's an array if it contains multiple
items.

```powershell
$array = 1..5 | ForEach-Object {
    "ATX-SQL-$PSItem"
}
```

Normally when we think of using the pipeline, we think of the typical PowerShell one-liners. We can
leverage the pipeline with `foreach()` statements and other loops. So instead of adding items to an
array in a loop, we can drop items onto the pipeline.

```powershell
$array = foreach ( $node in (1..5))
{
    "ATX-SQL-$node"
}
```

## Array Types

By default, an array in PowerShell is created as a `[PSObject[]]` type. This allows it to contain
any type of object or value. This works because everything is inherited from the `PSObject` type.

### Strongly typed arrays

You can create an array of any type using a similar syntax. When you create a strongly typed array,
it can only contain values or objects the specified type.

```powershell
PS> [int[]] $numbers = 1,2,3
PS> [int[]] $numbers2 = 'one','two','three'
ERROR: Cannot convert value "one" to type "System.Int32". Input string was not in a correct format."

PS> [string[]] $strings = 'one','two','three'
```

### ArrayList

Adding items to an array is one of its biggest limitations, but there are a few other collections
that we can turn to that solve this problem.

The `ArrayList` is commonly one of the first things that we think of when we need an array that is
faster to work with. It acts like an object array every place that we need it, but it handles adding
items quickly.

Here is how we create an `ArrayList` and add items to it.

```powershell
$myarray = [System.Collections.ArrayList]::new()
[void]$myArray.Add('Value')
```

We are calling into .NET to get this type. In this case, we are using the default constructor to
create it. Then we call the `Add` method to add an item to it.

The reason I'm using `[void]` at the beginning of the line is to suppress the return code. Some
.NET calls do this and can create unexpected output.

If the only data that you have in your array is strings, then also take a look at using
[StringBuilder][]. It's almost the same thing but has some methods that are just for dealing with
strings. The `StringBuilder` is specially designed for performance.

It's common to see people move to `ArrayList` from arrays. But it comes from a time where C# didn't
have generic support. The `ArrayList` is deprecated in support for the generic `List[]`

### Generic List

A generic type is a special type in C# that defines a generalized class and the user specifies the
data types it uses when created. So if you want a list of numbers or strings, you would define
that you want list of `int` or `string` types.

Here is how you create a List for strings.

```powershell
$mylist = [System.Collections.Generic.List[string]]::new()
```

Or a list for numbers.

```powershell
$mylist = [System.Collections.Generic.List[int]]::new()
```

We can cast an existing array to a list like this without creating the object first:

```powershell
$mylist = [System.Collections.Generic.List[int]]@(1,2,3)
```

We can shorten the syntax with the `using namespace` statement in PowerShell 5 and newer. The
`using` statement needs to be the first line of your script. By declaring a namespace, PowerShell
lets you leave it off of the data types when you reference them.

```powershell
using namespace System.Collections.Generic
$myList = [List[int]]@(1,2,3)
```

This makes the `List` much more usable.

You have a similar `Add` method available to you. Unlike the ArrayList, there is no return value on
the `Add` method so we don't have to `void` it.

```powershell
$myList.Add(10)
```

And we can still access the elements like other arrays.

```powershell
PS> $myList[-1]
10
```

#### List[PSObject]

You can have a list of any type, but when you don't know the type of objects, you can use
`[List[PSObject]]` to contain them.

```powershell
$list = [List[PSObject]]::new()
```

#### Remove()

The `ArrayList` and the generic `List[]` both support removing items from the collection.

```powershell
using namespace System.Collections.Generic
$myList = [List[string]]@('Zero','One','Two','Three')
[void]$myList.Remove("Two")
Zero
One
Three
```

When working with value types, it removes the first one from the list. You can call it over and
over again to keep removing that value. If you have reference types, you have to provide the object
that you want removed.

```powershell
[list[System.Management.Automation.PSDriveInfo]]$drives = Get-PSDrive
$drives.remove($drives[2])
```

```powershell
$delete = $drives[2]
$drives.remove($delete)
```

The remove method returns `true` if it was able to find and remove the item from the collection.

### More collections

There are many other collections that can be used but these are the good generic array replacements.
If you're interested in learning about more of these options, take a look at this
[Gist](https://gist.github.com/kevinblumenfeld/4a698dbc90272a336ed9367b11d91f1c) that
[Mark Kraus](https://get-powershellblog.blogspot.com/2016/11/about-mark-kraus.html) put together.

## Other nuances

Now that I have covered all the major functionality, here are a few more things that I wanted to
mention before I wrap this up.

### Pre-sized arrays

I mentioned that you can't change the size of an array once it's created. We can create an array of
a pre-determined size by calling it with the `new($size)` constructor.

```powershell
$data = [Object[]]::new(4)
$data.count
4
```

### Multiplying arrays

An interesting little trick is that you can multiply an array by an integer.

```powershell
PS> $data = @('red','green','blue')
PS> $data * 3
red
green
blue
red
green
blue
red
green
blue
```

### Initialize with 0

A common scenario is that you want to create an array with all zeros. If you're only going to have
integers, a strongly typed array of integers defaults to all zeros.

```powershell
PS> [int[]]::new(4)
0
0
0
0
```

We can use the multiplying trick to do this too.

```powershell
PS> $data = @(0) * 4
PS> $data
0
0
0
0
```

The nice thing about the multiplying trick is that you can use any value. So if you would rather
have `255` as your default value, this would be a good way to do it.

```powershell
PS> $data = @(255) * 4
PS> $data
255
255
255
255
```

### Nested arrays

An array inside an array is called a nested array. I don't use these much in PowerShell but I have
used them more in other languages. Consider using an array of arrays when your data fits in a grid
like pattern.

Here are two ways we can create a two-dimensional array.

```powershell
$data = @(@(1,2,3),@(4,5,6),@(7,8,9))

$data2 = @(
    @(1,2,3),
    @(4,5,6),
    @(7,8,9)
)
```

The comma is very important in those examples. I gave an earlier example of a normal array on
multiple lines where the comma was optional. That isn't the case with a multi-dimensional array.

The way we use the index notation changes slightly now that we've a nested array. Using the
`$data` above, this is how we would access the value 3.

```powershell
PS> $outside = 0
PS> $inside = 2
PS> $data[$outside][$inside]
3
```

Add a set of bracket for each level of array nesting. The first set of brackets is for the outer
most array and then you work your way in from there.

### Write-Output -NoEnumerate

PowerShell likes to unwrap or enumerate arrays. This is a core aspect of the way PowerShell uses the
pipeline but there are times that you don't want that to happen.

I commonly pipe objects to `Get-Member` to learn more about them. When I pipe an array to it, it
gets unwrapped and Get-Member sees the members of the array and not the actual array.

```powershell
PS> $data = @('red','green','blue')
PS> $data | Get-Member
TypeName: System.String
...
```

To prevent that unwrap of the array, you can use `Write-Object -NoEnumerate`.

```powershell
PS> Write-Output -NoEnumerate $data | Get-Member
TypeName: System.Object[]
...
```

I have a second way that's more of a hack (and I try to avoid hacks like this). You can place a
comma in front of the array before you pipe it.

```powershell
PS> ,$data | Get-Member
TypeName: System.Object[]
...
```

### Return an array

This unwrapping of arrays also happens when you output or return values from a function. You can
still get an array if you assign the output to a variable so this isn't commonly an issue.

The catch is that you have a new array. If that is ever a problem, you can use
`Write-Output -NoEnumerate $array` or `return ,$array` to work around it.

## Anything else?

I know this is all a lot to take in. My hope is that you learn something from this article
every time you read it and that it turns out to be a good reference for you for a long time to
come. If you found this to be helpful, please share it with others you think may get value out
of it.

From here, I would recommend you check out a similar post that I wrote about [hashtables][].

<!-- link references -->
[original version]: https://powershellexplained.com/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know/
[powershellexplained.com]: https://powershellexplained.com/
[@KevinMarquette]: https://twitter.com/KevinMarquette
[Arrays]: /powershell/module/microsoft.powershell.core/about/about_arrays
[switch statement]: everything-about-switch.md
[hashtables]: everything-about-hashtable.md
[The many ways to use regex]: https://powershellexplained.com/2017-07-31-Powershell-regex-regular-expression/
[how to verify that every value in an array matches a given value]: https://www.reddit.com/r/PowerShell/comments/9mzo09/if_statement_multiple_variables_but_1_condition
[solution]: https://www.reddit.com/r/PowerShell/comments/9mzo09/if_statement_multiple_variables_but_1_condition/e7iizca
[StringBuilder]: https://powershellexplained.com/2017-11-20-Powershell-StringBuilder/
