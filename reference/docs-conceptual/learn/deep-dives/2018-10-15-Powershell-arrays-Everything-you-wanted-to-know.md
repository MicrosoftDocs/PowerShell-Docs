---
layout: post
title: "Powershell: Everything you wanted to know about arrays"
date: 2018-10-15
tags: [PowerShell,Basics,Arrays]
share-img: "/img/share-img/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know.png"
---

[Arrays](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-6&viewFallbackFrom=powershell-Microsoft.PowerShell.Core) are a fundamental language feature of most programming languages. They are a collection of values or objects and are therefore, difficult to avoid. Let's take a close look at arrays and everything they have to offer.

<!--more-->

# Page Index

* TOC
{:toc}

# What is an array?

I am going to start with a basic technical description of what arrays are and how they are used by most programming languages before I shift into the other ways PowerShell makes use of them.

An array is a data structure that serves as a collection of multiple items. You can iterate over the array or access individual items using an index. The array is created as a sequential chunk of memory where each value is stored right next to the other.

I'll touch on each of those details as we go.

# Basic usage

Because arrays are such a basic feature of PowerShell, there is a simple syntax for working with them in PowerShell.

## Create an array with @()

An empty array can be created by using `@()`

``` posh
    PS> $data = @()
    PS> $data.count
    0
```

We can create an array and seed it with values just by placing them in the `@()` parentheses.

``` posh
    PS> $data = @('Zero','One','Two','Three')
    PS> $data.count
    4

    PS> $data
    Zero
    One
    Two
    Three
```

This array has 4 items. When we call the `$data` variable, we see the list of our items. If it is an array of strings, then we will have one line per string.

We can declare an array on multiple lines. The comma is optional in this case and generally left out.

``` posh
    $data = @(
        'Zero'
        'One'
        'Two'
        'Three'
    )
```

I prefer to declare my arrays on multiple lines like that. Not only does it get easier to read when you have multiple items, it also makes it easier to compare to previous versions when using source control.

### Other syntax

It's commonly understood that `@()` is the syntax for creating an array, but comma separated lists work most of the time.

``` posh
    $data = 'Zero','One','Two','Three'
```

### Write-Output to create arrays

One cool little trick worth mentioning is that you can use `Write-Output` to quickly create strings at the console.

``` posh
    $data = Write-Output Zero One Two Three
```

This is handy because you don't have to put quotes around the strings when the parameter accepts strings. I would never do this in a script but it's fair game in the console. 

## Accessing items

Now that you have an array with items in it, you may want to access and update those items.

### Offset

To access individual items, we uses the brackets `[]` with an offset value starting at 0. This is how we get the first item in our array:

``` posh
    PS> $data = 'Zero','One','Two','Three'
    PS> $data[0]
    Zero
```

The reason why we use zero here is because the first item is at the beginning of the list so we use an offset of 0 items to get to it. To get to the second item, we would need to use an offset of 1 to skip the first item.

``` posh
    PS> $data[1]
    One
```

This would mean that the last item is at offset 3.

``` posh
    PS> $data[3]
    Three
```

### Index

Now you can see why I picked the values that I did for this example. I introduced this as an offset because that is what it really is, but this offset is more commonly referred to as an index. An index that starts at `0`. For the rest of this article I will call the offset an index.

### Special index tricks

In most languages, you can only specify a single number as the index and you will get a single item back. PowerShell is much more flexible. You can use multiple indexes at once. By providing a list of indexes, we can select several items.

``` posh
    PS> $data[0,2,3]
    Zero
    Two
    Three
```

The items will be returned based on the order of the indexes provided. If you duplicate an index, you will get that item both times.

``` posh
    PS> $data[3,0,3]
    Three
    Zero
    Three
```

We can specify a sequence of numbers with the built in `..` operator.

``` posh
    PS> $data[1..3]
    One
    Two
    Three
```

This works in reverse too.

``` posh
    PS> $data[3..1]
    Three
    Two
    One
```

You can use negitive index values to offset from the end. So if you need the last item in the list, you can use `-1`.

``` posh
    PS> $data[-1]
    Three
```

One word of caution here with the `..` operator. The sequence `0..-1` and `-1..0` evaluate to the values `0,-1` and `-1,0`. It's easy to see `$data[0..-1]` and think it would enumerate all items if you forget this detail. `$data[0..-1]` gives you the same value as `$data[0,-1]` by giving you the first and last item in the array (and none of the other values).

### Out of bounds

In most languages, if you try to access an index of an item that is past the end of the array, you would get some type of error or an exception. PowerShell will silently give you nothing.

``` posh
    PS> $null -eq $data[9000]
    True
```

### Cannot index into a null array

If your variable is `$null` and you try to index it like an array, you will get a `System.Management.Automation.RuntimeException` exception with the message `Cannot index into a null array`.

``` posh
    PS> $empty = $null
    SP> $empty[0]
    Error: Cannot index into a null array.
```

So make sure your arrays are not `$null` before you try to access elements inside them.

### Count

Arrays and other collections have a count property that tells you how many items are in the array.

``` posh
    PS> $data.count
    4
```

PowerShell 3.0 added a count property to most objects. you can have a single object and it should give you a count of `1`.

``` posh
    PS> $date = Get-Date
    PS> $date.count
    1
```

Even `$null` has a count property except it returns `0`.

``` posh
    PS> $null.count
    0
```

There are some traps here that I will revisit when I cover checking for `$null` or empty arrays later on in this article.

### Off by one errors

A common programming error is created because arrays start at index 0. An off by one error can be introduced in two very common ways.

The first is by mentally thinking you want the 2nd item and using an index of `2` and really getting the third item. Or by thinking that you have `4` items and you want last item, so you will just use the size to access the last item.

``` posh
    $data[ $data.count ]
```

PowerShell is perfectly happy to let you do that and give you exactly what item exists at index 4, `$null`. You should be using `$data.count - 1` or the `-1` that we learned about above.

``` posh
    PS> $data[ $data.count - 1 ]
    Three
```

This is where you can use the `-1` index to get the last element.


``` posh
    PS> $data[ -1 ]
    Three
```

Lee Dailey also pointed out to me that we can use `$data.GetUpperBound(0)` to get the max index number.


``` posh
    PS> $data.GetUpperBound(0)
    Three
```

The second most common way is when iterating the list and just not stopping at the right time. I'll revisit this when we talk about using the `for` loop.

## Updating items

We can use the same index to update existing items in the array. This gives us direct access to update individual items.

``` posh
    $data[2] = 'dos'
    $data[3] = 'tres'
```

If we try to update an item that is past the last element, then we get an `Index was outside the bounds of the array.` error.

``` posh
    PS> $data[4] = 'four'
    Index was outside the bounds of the array.
    At line:1 char:1
    + $data[4] = 'four'
    + ~~~~~~~~~~~~~
    + CategoryInfo          : OperationStopped: (:) [], IndexOutOfRangeException
    + FullyQualifiedErrorId : System.IndexOutOfRangeException
```

I'll revisit this later when I talk about how to make an array larger.

## Iteration

At some point, you will need to walk or iterate the entire list and perform some action for each item in the array.

### Pipeline

Arrays and the PowerShell pipeline are meant for each other. This is one of the simplest ways to process over those values. When you pass an array to a pipeline, each item inside the array is processed individually.

``` posh
    PS> $data = 'Zero','One','Two','Three'
    PS> $data | ForEach-Object {"Item: [$PSItem]"}
    Item: [Zero]
    Item: [One]
    Item: [Two]
    Item: [Three]
```

If you have not seen `$PSItem` before, just know that its the same thing as `$_`. You can use either one because they both represent the current object in the pipeline.

### ForEach loop

The `ForEach` loop works well with collections. Using the syntax: `foreach ( <variable> in <collection> )`

``` posh
    foreach ( $node in $data )
    {
        "Item: [$node]"
    }
```

### ForEach method

I tend to forget about this one but it works well for simple operations. PowerShell allows you to call `.ForEach()` on a collections.

``` posh
    PS> $data.foreach({"Item [$PSItem]"})
    Item [Zero]
    Item [One]
    Item [Two]
    Item [Three]
```

The `.foreach()` takes a parameter that is a script block. You can drop the parentheses and just provide the script block.

``` posh
    $data.foreach{"Item [$PSItem]"}
```

This is a lesser known syntax but it works just the same. This `foreach` method was added in PowerShell 4.0.

### For loop

The `for` loop is used heavily in most other languages but you don’t see it much in PowerShell. When you do see it, it is often in the context of walking an array.

``` posh
    for ( $index = 0; $index -lt $data.count; $index++)
    {
        "Item: [{0}]" -f $data[$index]
    }
```

The first thing we do is initialize an `$index` to `0`. Then we add the condition that `$index` must be less than `$data.count`. Finally, we specify that every time we loop that me must increase the index by `1`. In this case `$index++` is short for `$index = $index + 1`.

Whenever you are using a `for` loop, pay special attention to the condition. I used `$index -lt $data.count` here. It is very easy to get the condition slightly wrong to get an off by one error in your logic. Using `$index -le $data.count` or `$index -lt ($data.count - 1)` are ever so slightly wrong. That would cause your result to process too many or too few items. This is the classic off by one error.

### Switch loop

This is one that is very easy to overlook. If you provide an array to a [switch statement](/2018-01-12-Powershell-switch-statement/?utm_source=blog&utm_medium=blog&utm_content=arrays), it will match on each item in the array.

``` posh
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

This will produce this output:

```
    Tick
    Tock
    Tick
    Tock
```

There are a lot of cool things like this that we can do with the switch statement. I have another article dedicated to this.

* [Everything you ever wanted to know about the switch statement](/2018-01-12-Powershell-switch-statement/?utm_source=blog&utm_medium=blog&utm_content=arrays)

### Updating values

When your array is a collection of string or integers (value types), sometimes you will want to update the values in the array as you loop over them. Most of the loops above use a variable in the loop that holds a copy of the value. If you update that variable, the original value in the array is not updated.

The exception to that statement is the `for` loop. If you are wanting to walk an array and update values inside it, then the `for` loop is what you are looking for.

``` posh
    for ( $index = 0; $index -lt $data.count; $index++ )
    {
        $data[$index] = "Item: [{0}]" -f $data[$index]
    }
```

This examples takes a value by index, makes a few changes, and then uses that same index to assign it back.

# Arrays of Objects

So far, the only thing we have placed in an array is a value type, but arrays can also contain objects.

``` posh
   $data = @(
       [pscustomobject]@{FirstName='Kevin';LastName='Marquette'}
       [pscustomobject]@{FirstName='John'; LastName='Doe'}
   )
```

Many cmdlets return collections of objects as arrays when you assign them to a variable.

``` posh
    $processList = Get-Process
```

All of the basic features we already talked about still apply to arrays of objects with a few details worth pointing out.

## Accessing properties

We can use an index to access an individual item in a collection just like with value types.

``` posh
    PS> $data[0]

    FirstName LastName
    -----     ----
    Kevin     Marquette
```

We can access and update properties directly.

``` posh
    PS> $data[0].FirstName

    Kevin

    PS> $data[0].FirstName = 'Jay'
    PS> $data[0]

    FirstName LastName
    -----     ----
    Jay       Marquette
```

### Array properties

Normally you would have to enumerate the whole list like this to access all the properties:

``` posh
    PS> $data | ForEach-Object {$_.LastName}

    Marquette
    Doe
```

Or by using the `Select-Object -ExpandProperty` cmdlet.

``` posh
    PS> $data | Select-Object -ExpandProperty LastName

    Marquette
    Doe
```

But PowerShell offers us the ability to request `LastName` directly. PowerShell will enumerate them all for us and give us a clean list.

``` posh
    PS> $data.LastName

    Marquette
    Doe
```

The enumeration still happens but we don't see the complexity behind it.

## Where-Object filtering

This is where `Where-Object` comes in so we can filter and select what we want out of the array based on the properties of the object.

``` posh
    PS> $data | Where-Object {$_.FirstName -eq 'Kevin'}

    FirstName LastName
    -----     ----
    Kevin     Marquette
```

We can write that same query like this to get the `FirstName` we are looking for.

``` posh
    $data | Where FirstName -eq Kevin
```

### Where()

Arrays have a `Where()` method on them that allows you to specify a `scriptblock` for the filter.

``` posh
    $data.Where({$_.FirstName -eq 'Kevin'})
```

This feature was added in PowerShell 4.0.

## Updating objects in loops

With value types, the only way to update the array is to use a for loop because we need to know the index to replace the value. We have more options with objects because they are reference types. Here is a quick example:

``` posh
    foreach($person in $data)
    {
        $person.FirstName = 'Kevin'
    }
```

This loop is walking every object in the `$data` array. Because objects are reference types, the `$person` variable references the exact same object that is in the array. So updates to it's properties will update the original.

You still can't replace the whole object this way. If you try to assign a new object to the `$person` variable, you are updating the variable reference to something else that no longer points to the original object in the array. This will not work like you would expect:

```
    foreach($person in $data)
    {
        $person = [pscustomobject]@{
            FirstName='Kevin'
            LastName='Marquette'
        }
    }
```


# Operators

The operators in PowerShell also work on arrays. Some of them work slightly differently.

## -join

The `-join` operator is the most obvious one so we will look at it first. I like the `-join` operator and use it often. It will join all elements in the array with a character or string that you specify.

``` posh
    PS> $data = @(1,2,3,4)
    PS> $data -join '-'
    1-2-3-4
    PS> $data -join ','
    1,2,3,4
```

One of the features that I like about the `-join` operator is that it handles single items.

``` posh
    PS> 1 -join '-'
    1
```

I use this inside logging and verbose messages.

``` posh
    PS> $data = @(1,2,3,4)
    PS> "Data is $($data -join ',')."
    Data is 1,2,3,4.
```

### -join $array

Here is a clever trick that Lee Dailey pointed out to me. If you ever want to join everything without a delimiter, instead of doing this:

``` posh
    PS> $data = @(1,2,3,4)
    PS> $data -join $null
    1234
```

You can use `-join` with the array as the parameter with no prefix. Take a look at this example to see that I am talking about.

``` posh
    PS> $data = @(1,2,3,4)
    PS> -join $data
    1234
```

## -replace and -split

The other operators like `-replace` and `-split` will execute on each item in the array. I can't say that I have ever used them this way but here is an example.

``` posh
    PS> $data = @('ATX-SQL-01','ATX-SQL-02','ATX-SQL-03')
    PS> $data -replace 'ATX','LAX'
    LAX-SQL-01
    LAX-SQL-02
    LAX-SQL-03
```

## -contains

The `-contains` operator will allow you to check an array of values to see if it contains a specified value.

``` posh
    PS> $data = @('red','green','blue')
    PS> $data -contains 'green'
    True
```

## -in

When you have a single value that you would like to verify matches one of several values, you can use the `-in` operator. The value would be on the left and the array on the right hand side of the operation.

``` posh
    PS> $data = @('red','green','blue')
    PS> 'green' -in $data
    True
```

This can get expensive if the list is large. I will often use a regex pattern if I am checking more than 4-5 values.

``` posh
    PS> $data = @('red','green','blue')
    PS> $pattern = "^({0})$" -f ($data -join '|')
    PS> $pattern
    ^(red|green|blue)$

    PS> 'green' -match $pattern
    True
```

## -eq and -ne

Equality and arrays can get complicated. When the array is on the left side, every item will get compared. Instead of returning `True`, it will return the object that matches.

``` posh
    PS> $data = @('red','green','blue')
    PS> $data -eq 'green'
    green
```

When you use the `-ne` operator, we will get all the values that are not equal to our value.

``` posh
    PS> $data = @('red','green','blue')
    PS> $data -ne 'green'
    red
    blue
```

When you use this in an `if()` statement, a value that is returned is a `True` value. If no value is returned then it is a `False` value. Both of these next statements will evaluate to `True`.

``` posh
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

## -match

The `-match` operator will try to match each item in the collection.

``` posh
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

When you use `-match` with a single value, a special variable `$Matches` gets populated with match info. This is not the case when an array is processed this way.

We can take the same approach with `Select-String`.

``` posh
    $servers | Select-String SQL
```

I take a closer look at `Select-String`,`-match` and the `$matches` variable in another post called [The many ways to use regex](/2017-07-31-Powershell-regex-regular-expression/?utm_source=blog&utm_medium=blog&utm_content=arrays).

# $null or empty

Testing for `$null` or empty arrays can be tricky. Here are the common traps with arrays.

At a glance, this statement looks like it should work.

``` posh
    if ( $array -eq $null)
    {
        'Array is $null'
    }
```

But I just went over how `-eq` checks each item in the array. So we can have an array of several items with a single $null value and it would evaluate to `$true`

``` posh
    $array = @('one',$null,'three')
    if ( $array -eq $null)
    {
        'I think Array is $null, but I would be wrong'
    }
```

This is why it's a best practice to place the `$null` on the left side of the operator. This makes this scenario a non-issue.

``` posh
    if ( $null -eq $array )
    {
        'Array actually is $null'
    }
```

A `$null` array is not the same thing as an empty array. If you know you have an array, check the count of objects in it. If the array is `$null`, the count will be `0`.

``` posh
    if ( $array.count -gt 0 )
    {
        'Array is not empty'
    }
```

There is one more trap to watch out for here. You can use the `count` even if you have a single object, unless that object is a `PSCustomObject`. This is a bug that is fixed in PowerShell 6.1. That's good news, but a lot of people are still on 5.1 and need to watch out for it.

``` posh
    PS> $object = [PSCustomObject]@{Name='TestObject'}
    PS> $object.count
    $null
```

If you are still on PowerShell 5.1, you can wrap the object in an array before checking the count to get an accurate count.

``` posh
    if ( @($array).count -gt 0 )
    {
        'Array is not empty'
    }
```

To fully play it safe, check for `$null`, then check the count.

``` posh
    if ( $null -ne $array -and @($array).count -gt 0 )
    {
        'Array is not empty'
    }
```

## All -eq

I recently saw someone ask [how to verify that every value in an array matches a given value](https://www.reddit.com/r/PowerShell/comments/9mzo09/if_statement_multiple_variables_but_1_condition). Reddit user /u/bis had this clever [solution](https://www.reddit.com/r/PowerShell/comments/9mzo09/if_statement_multiple_variables_but_1_condition/e7iizca) that checks for any incorrect values and then flips the result.

``` posh
    $results = Test-Something
    if ( -not ( $results -ne 'Passed') )
    {
        'All results a Passed'
    }
```


# Adding to arrays

At this point, you're starting to wonder how to add items to an array. The quick answer is that you can't. An array is a fixed size in memory. If you need to grow it or add a single item to it, then you need to create a new array and copy all the values over from the old array. This sounds expensive and like a lot of work, however, PowerShell hides the complexity of creating the new array.

## Array addition

We can use the addition operator with arrays to create a new array. So given these two arrays:

``` posh
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

``` posh
    PS> $first + $second

    Zero
    One
    Two
    Three
```

## Plus equals +=

We can create a new array in place and add an item to it like this:

``` posh
    $data = @(
        'Zero'
        'One'
        'Two'
        'Three'
    )
    $data += 'four'
```

Just remember that every time you use `+=` that you are duplicating and creating a new array. This is a not an issue for small datasets but it scales extremely poorly.

## Pipeline assignment

You can assign the results of any pipeline into a variable. It will be an array if it contains multiple items.

``` posh
    $array = 1..5 | ForEach-Object {
        "ATX-SQL-$PSItem"
    }
```

Normally when we think of using the pipeline, we think of the typical PowerShell one-liners. We can leverage the pipeline with `foreach()` statements and other loops. So instead of adding items to an array in a loop, we can drop items onto the pipeline.

``` posh
    $array = foreach ( $node in (1..5))
    {
        "ATX-SQL-$node"
    }
```

By assigning the results of the `foreach` to a variable, we capture all the objects and create a single array.

# Array Types

By default, an array in PowerShell is created as a `[PSObject[]]` type. This allows it to contain any type of object or value. This works because everything is inherited from the `PSObject` type.

## Strongly typed arrays

You can create an array of any type using a similar syntax. When you create a strongly typed array, it can only contain values or objects the specified type.

``` posh
    PS> [int[]] $numbers = 1,2,3
    PS> [int[]] $numbers2 = 'one','two','three'
    ERROR: Cannot convert value "one" to type "System.Int32". Input string was not in a correct format."

    PS> [string[]] $strings = 'one','two','three'
```

## ArrayList

Adding items to an array is one of its biggest limitations, but there are a few other collections that we can turn to that solve this problem. 

The `ArrayList` is commonly one of the first things that we think of when we need an array that is faster to work with. It acts like an object array every place that we need it, but it handles adding items quickly.

Here is how we create an `ArrayList` and add items to it.

``` posh
    $myarray = [System.Collections.ArrayList]::new()
    [void]$myArray.Add('Value')
```

We are calling into .Net to get this type. In this case we are using the default constructor to create it. Then we call the `Add` method to add an item to it.

The reason I am using `[void]` at the beginning of the line is to suppress the return code. Some .Net calls will do this and can create unexpected output.

If the only data that you have in your array is strings, then also take a look at using [StringBuilder](/2017-11-20-Powershell-StringBuilder/?utm_source=blog&utm_medium=blog&utm_content=arraysinline). It is almost the same thing but has some methods that are just for dealing with strings. The `StringBuilder` is specially designed for performance.

* [Concatenate strings using StringBuilder](/2017-11-20-Powershell-StringBuilder/?utm_source=blog&utm_medium=blog&utm_content=arrays)

It is really common to see people move to `ArrayList` from arrays. But it comes from a time where C# did not have generic support. The `ArrayList` is depreciated in support for the generic `List[]`

## Generic List

A generic type is a special type in C# that define a generalized class and the user will specify the data types it will use when created. So if you want a list of numbers or strings, you would define that you want list of `int` or `string` types.

Here is how you create a List for strings.

``` posh
    $mylist = [System.Collections.Generic.List[string]]::new()
```

Or a list for numbers.

``` posh
    $mylist = [System.Collections.Generic.List[int]]::new()
```

We can cast an existing array to a list like this without creating the object first:

``` posh
    $mylist = [System.Collections.Generic.List[int]]@(1,2,3)
```

We can shorten the syntax a little bit with the `using namespace` statement in PowerShell 5 and newer. The `using` statement needs to be the first line of your script. By declaring a namespace, PowerShell will let you leave it off of the datatypes when you reference them.

``` posh
    using namespace System.Collections.Generic
    $myList = [List[int]]@(1,2,3)
```

This makes the `List` much more usable.

You have a similar `Add` method available to you. Unlike the ArrayList, there is no return value on the `Add` method so we don't have to `void` it.

``` posh
    $myList.Add(10)
```

And we can still access the elements like other arrays.

``` posh
    PS> $myList[-1]
    10
```

### List[PSObject]

You can have a list of any type, but when you don’t know the type of objects, you can use `[List[PSObject]]` to contain them.

``` posh
    $list = [List[PSObject]]::new()
```

### Remove()

The `ArrayList` and the generic `List[]` both support removing items from the collection.

``` posh
    using namespace System.Collections.Generic
    $myList = [List[string]]@('Zero','One','Two','Three')
    [void]$myList.Remove("Two")
    Zero
    One
    Three
```

When working with value types, it will remove the first one from the list. You can call it over and over again to keep removing that value. If you have reference types, you have to provide the object that you want removed.

``` posh
    [list[System.Management.Automation.PSDriveInfo]]$drives = Get-PSDrive
    $drives.remove($drives[2])
```

``` posh
    $delete = $drives[2]
    $drives.remove($delete)
```

The remove method will return true if it was able to find and remove the item from the collection.

## More collections

There are many other collections that can be used but these are the good generic array replacements. If you are interested in learning about more of these options, take a look at this [Gist](https://gist.github.com/kevinblumenfeld/4a698dbc90272a336ed9367b11d91f1c) that [Mark Kraus](https://get-powershellblog.blogspot.com/2016/11/about-mark-kraus.html) put together.

# Other nuances

Now that I have covered all the major functionality, here are a few more things that I wanted to mention before I wrap this up.

## Pre-sized arrays

I mentioned that you can't change the size of an array once it is created. We can create an array of a pre-determined size by calling it with the `new($size)` constructor.

``` posh
    $data = [Object[]]::new(4)
    $data.count
    4
```

## Multiplying arrays

An interesting little trick is that you can multiply an array by an integer.

``` posh
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

## Initialize with 0

A common scenario is that you want to create an array with all zeros. If you are only going to have integers, a strongly typed array of integers will default to all zeros.

``` posh
    PS> [int[]]::new(4)
    0
    0
    0
    0
```

We can use the multiplying trick to do this too.

``` posh
    PS> $data = @(0) * 4
    PS> $data
    0
    0
    0
    0
```

The nice thing about the multiplying trick is that you can use any value. So if you would rather have `255` as your default value, this would be a good way to do it.

``` posh
    PS> $data = @(255) * 4
    PS> $data
    255
    255
    255
    255
```

## Nested arrays

An array inside an array is called a nested array. I don't use these much in PowerShell but I have used them more in other languages. Consider using an array of arrays when your data fits in a grid like pattern.

Here are two ways we can create a 2 dimensional array.

``` posh
    $data = @(@(1,2,3),@(4,5,6),@(7,8,9))

    $data2 = @(
        @(1,2,3),
        @(4,5,6),
        @(7,8,9)
    )
```

The comma is very important in those examples. I gave an earlier example of a normal array on multiple lines where the comma was optional. That is not the case with a multi-dimensional array.

The way we use the index notation changes slightly now that we have a nested array. Using the `$data` above, this is how we would access the value 3.

``` posh
    PS> $outside = 0
    PS> $inside = 2
    PS> $data[$outside][$inside]
    3
```

Add a set of bracket for each level of array nesting. The first set of brackets is for the outer most array and then you work your way in from there.

## Write-Output -NoEnumerate

PowerShell likes to unwrap or enumerate arrays. This is a core aspect of the way PowerShell uses the pipeline but there are times that you don't want that to happen.

I commonly pipe objects to `Get-Member` to learn more about them. When I pipe an array to it, it gets unwrapped and Get-Member sees the members of the array and not the actual array.

``` posh
    PS> $data = @('red','green','blue')
    PS> $data | Get-Member
    TypeName: System.String
    ...
```

To prevent that unwrap of the array, you can use `Write-Object -NoEnumerate`.

``` posh
    PS> Write-Output -NoEnumerate $data | Get-Member
    TypeName: System.Object[]
    ...
```

I have a second way to do this that's more of a hack (and I try to avoid hacks like this). You can place a comma in front of the array before you pipe it.

``` posh
    PS> ,$data | Get-Member
    TypeName: System.Object[]
    ...
```

### Return an array

This un-wrapping of arrays also happens when you output or return values from a function. You can still get an array if you assign the output to a variable so this is not commonly an issue.

The catch is that you will have a new array. If that is ever a problem, you can use `Write-Output -NoEnumerate $array` or `return ,$array` to work around it.


# Anything else?

I know this is all a lot to take in. My hope is that you will learn something from this article every time you read it and that it will turn out to be a good reference for you for a long time to come. If you found this to be helpful, please share it with others that you think will get value out of it.

From here, I would recommend you check out a similar post that I wrote about [hashtables](/2016-11-06-powershell-hashtable-everything-you-wanted-to-know-about/?utm_source=blog&utm_medium=blog&utm_content=arrays).