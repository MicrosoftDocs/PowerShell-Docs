---
layout: post
title: "Powershell: Everything you wanted to know about $null"
date: 2018-12-23
tags: [PowerShell,Everything]
share-img: "/img/share-img/2018-12-23-Powershell-null-everything-you-wanted-to-know.png"
---

The PowerShell `$null` often appears to be simple but it has a lot of nuances. Let's take a close look at `$null` so you know what happens when you unexpectedly run into a `$null` value.
<!--more-->

# Index

* TOC
{:toc}

# What is NULL

You can think of NULL as an unknown or empty value. A variable is NULL until you assign a value or a object to it. This can be important because there are some commands that require a value and will generate errors if the value is NULL.

## PowerShell $null

`$null` is an automatic variable in PowerShell used to represent NULL. You can assign it to variables, use it in comparisons and use it as a place holder for NULL in a collection.

PowerShell treats `$null` as an object with a value of NULL. This is different then what you may expect if you come from another language.

# Examples of $null

Any time you try to use a variable that you have not initialized with a value, it will be `$null`. This is one of the most common ways that `$null` values will sneak into your code.

``` posh
    PS> $null -eq $undefinedVariable
    True
```

It you happen to mistype a variable name then PowerShell will see it as a different variable and the value will be `$null`.

The other way you will find `$null` values is when they come from other commands that don't give you any results.

``` posh
    PS> function Get-Nothing {}
    PS> $value = Get-Nothing
    PS> $null -eq $value
    True
```

# Impact of $null

`$null` values will impact your code differently depending on where they show up.

## In strings

If you use `$null` in a string, then it will be a blank value (or empty string).

``` posh
    PS> $value = $null
    PS> Write-Output "The value is $value"
    The value is
```

This is one of the reasons that I like to place brackets around variables when using them in log messages. It is even more important to identify the edges of your variable values when the value is at the end of the string.

``` posh
    PS> $value = $null
    PS> Write-Output "The value is [$value]"
    The value is []
```

This makes empty strings and `$null` values easy to spot.

## In numeric equation

When a `$null` value is used in a numeric equation then your results will be invalid if they don't give an error. Sometimes the `$null` will evaluate to `0` and other times it will make the whole result `$null`. Here is an example with multiplication that gives 0 or `$null` depending on the order of the values.  

``` posh
    PS> $null * 5
    PS> $null -eq ( $null * 5 )
    True

    PS> 5 * $null
    0
    PS> $null -eq ( 5 * $null )
    False
```

## In place of a collection

A collection allow you use an index to access values. If you try to index into a collect that is actually `null`, then you will get this error: `Cannot index into a null array`.

``` posh
    PS> $value = $null
    PS> $value[10]
    Cannot index into a null array.
    At line:1 char:1
    + $value[10]
    + ~~~~~~~~~~
        + CategoryInfo          : InvalidOperation: (:) [], RuntimeException
        + FullyQualifiedErrorId : NullArray
```

I you have a collection but try to access an element that is not in the collection then you will get a `$null` result.

``` posh
    $array = @( 'one','two','three' )
    $null -eq $array[100]
    True
```

## In place of an object

If you try to access a property or sub property of an object that does not have the specified property then you get a `$null` value like you would for an undefined variable. It does not matter if the variable is `$null` or an actual object in this case.

``` posh
    PS> $null -eq $undefined.some.fake.property
    True

    PS> $date = Get-Date
    PS> $null -eq $date.some.fake.property
    True
```

### Method on a null-valued expression

Calling a method on a `$null` object will throw a `RuntimeException` exception.

``` posh
    PS> $value = $null
    PS> $value.toString()
    You cannot call a method on a null-valued expression.
    At line:1 char:1
    + $value.tostring()
    + ~~~~~~~~~~~~~~~~~
      + CategoryInfo          : InvalidOperation: (:) [], RuntimeException
      + FullyQualifiedErrorId : InvokeMethodOnNull
```

Whenever I see the phrase `You cannot call a method on a null-valued expression` then the first thing I do is look for is places that I am calling a method on a variable without first checking it for `$null`.

# Checking for $null

You may have noticed that I always place the `$null` on the left when checking for `$null` in my examples. This is intentional and accepted as a PowerShell best practice. There are some scenarios where placing it on the right will not give you the expected result.

Look at this next example and try to predict what the results will be:

``` posh
    if ( $value -eq $null )
    {
        'The array is $null'
    }
    if ( $value -ne $null )
    {
        'The array is not $null'
    }
```

If I do not define `$value` then the first one will evaluate to `$true` and our message will be `The array is $null`. The trap here is that it is possible to create a `$value` that will allow both of them to be `$false`

``` posh
   $value = @( $null )
```

In this case the `$value` is an array that contains a `$null`. The `-eq` will check every value in the array and returns the `$null` that is matched (This evaluates to `$false`). The `-ne` will return everything that does not match `$null` and in this case there are no results (This also evaluates to `$false`). Neither one will be `$true` even though it looks like one of them should be.

Not only can we create a value that makes both of them evaluate to `$false`, it is possible to create a value where they both evaluate to `$true`. [Mathias Jessen @IISResetMe](https://blog.iisreset.me/author/iisresetme) has a [good post](https://blog.iisreset.me/schrodingers-argumentlist) that dives into that scenario.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">If you like <a href="https://twitter.com/hashtag/PowerShell?src=hash&amp;ref_src=twsrc%5Etfw">#PowerShell</a> and puzzles, here&#39;s a funny existential crisis in code!<br><br>New blog post: &quot;Schrödinger&#39;s  -ArgumentList&quot;<a href="https://t.co/np7TQcpksf">https://t.co/np7TQcpksf</a></p>&mdash; Mathias Jessen (@IISResetMe) <a href="https://twitter.com/IISResetMe/status/1085556351441555456?ref_src=twsrc%5Etfw">January 16, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


## PSScriptAnalyzer and VSCode

The [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) module has a rule that checks for this issue called `PSPossibleIncorrectComparisonWithNull`.

``` text
    PS> Invoke-ScriptAnalyzer ./myscript.ps1

    RuleName                              Message
    --------                              -------
    PSPossibleIncorrectComparisonWithNull $null should be on the left side of equality comparisons.
```

Because VSCode uses the PSScriptAnalyser rules too, it will also hilight or identify this as a problem in your script.

## Simple if check

A common way that people check for a non `$null` value is to use a simple `if()` statement without the comparison.

``` posh
    if ( $value )
    {
        Do-Something
    }
```

If the value is `$null`, this will evaluate to `$false`. This is simple and easy to read, but be careful that it is looking for exactly what you are expecting it to look for. I read that line of code as `If $value has a value`, but thats not the whole story. That line is actually saying `If $value is not $null or 0 or $false or an empty string`. 

Here is a more complete sample of that statement.

``` posh
    if ( $null -ne $value -and
         $value -ne 0 -and
         $value -ne '' -and
         $value -ne $false )
    {
        Do-Something
    }
```

It is perfectly OK to use a basic if check as long as you remember those other values count as `$false` and not just that a variable has a value.

I ran into this issue when refactoring some code a few days ago. It had a basic property check like this.

``` posh
    if ( $object.property )
    {
        $object.property = $value
    }
```

I wanted to assign a value to the object property only if it existed. In most cases, the original object had a value that would evaluate to `$true` in the `if` statement. But I ran into an issue where the value was occasionally not getting set. I debugged into and I found that the object did have the property but it was a blank string value. This prevented it from ever getting updated with the previous logic. So I added a proper `$null` check and everything worked.

``` posh
    if ( $null -ne $object.property )
    {
        $object.property = $value
    }
```

It's little bugs like this that are hard to spot that make me aggressivly check values for `$null`.

# $null.Count

If you try to access a property on a `$null` value, that the property will also be `$null`. The `count` property is the exception to this rule.

``` posh
    PS> $value = $null
    PS> $value.count
    0
```

When you have a `$null` value, then the `count` will be `0`. This special property is added by PowerShell.

## [PSCustomObject] Count

Almost all objects in PowerShell have that count property. One important exception is the `[PSCustomObject]` in Windows PowerShell 5.1 (This is fixed in PowerShell 6.0). It does not have a count property so you will get a `$null` value if you try to use it. I call this out here so that you don't try an use `.Count` instead of a `$null` check.

Running this example on Windows PowerShell 5.1 and PowerShell 6.0 will give you different results.

``` posh
    $value = [PSCustomObject]@{Name='MyObject'}
    if ( $value.count -eq 1 )
    {
       "We have a value"
    }
```

# Empty null

There is one special type of `$null` that acts differently than the others. I am going to call it the empty `$null` but its really a [System.Management.Automation.Internal.AutomationNull](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.internal.automationnull?view=powershellsdk-1.1.0). This empty `$null` is the one you get as the result of a function or script block that returns nothing (a void result).

``` posh
    PS> function Get-Nothing {}
    PS> $nothing = Get-Nothing
    PS> $null -eq $nothing
    True
```

If you compare it with `$null` then you will get a `$null` value. When used in an evaluation where a value is required, the value is always `$null`. But if you place it inside an array, it is treated the same as an empty array.

``` posh
    PS> $containempty = @( @() )
    PS> $containnothing = @($nothing)
    PS> $containnull = @($null)

    PS> $containempty.count
    0
    PS> $containnothing.count
    0
    PS> $containnull.count
    1
```

You can have an array that contains one `$null` value and its `count` will be `1`. But if you place an empty result inside an array then it is not counted as an item. The count will be `0`.

If you treat the empty `$null` like a collection, then it is empty.

## Pipeline

The primary place you will see the difference is when using the pipeline. You can pipe a `$null` value but not an empty `$null` value.

``` posh
    PS> $null | ForEach-Object{ Write-Output 'NULL Value' }
    'NULL Value'
    PS> $nothing | ForEach-Object{ Write-Output 'No Value' }
```

Depending on your code, you should account for the `$null` in your logic.

* Either check for `$null` first
* Filter out null on the pipeline (`... | Where {$null -ne $_} | ...`)
* Handle it in the pipeline function

# foreach

One of my favorite features of `foreach` is that it does not enumerate over a `$null` collection.

``` posh
    foreach ( $node in $null )
    {
        #skipped
    }
```

This saves me from having to `$null` check the collection before I enumerate it. If you have a collection of `$null` values then the `$node` can still be `$null`.

The foreach started working this way with PowerShell 3.0. If you happen to be on a older version then this is not the case. This is one of the important changes to be aware of when backporting code for 2.0 compatibility.

# Value types

Technically, only reference types can be `$null`. But PowerShell is very generous and allows for variables to be any type. If you decide to stronly type a value type then it cannot be `$null`. PowerShell can convert `$null` to a default value for many types.

``` posh
    PS> [int]$number = $null
    PS> $number
    0

    PS> [bool]$boolean = $null
    PS> $boolean
    False

    PS> [string]$string = $null
    PS> $string -eq ''
    True
```

There are some types that do not have a valid conversion from `$null`. These types will generate a `Cannot convert null to type` error.

``` posh
    PS> [datetime]$date = $null
    Cannot convert null to type "System.DateTime".
    At line:1 char:1
    + [datetime]$date = $null
    + ~~~~~~~~~~~~~~~~~~~~~~~
        + CategoryInfo          : MetadataError: (:) [], ArgumentTransformationMetadataException
        + FullyQualifiedErrorId : RuntimeException
```

## Function parameters

Using a strongly typed value is in function parameters is very common. We generally learn to define the types of our parameters even if we tend not to define the types of other variables in our scripts. You may already have some strongly typed variables in your functions and not even realize it.

``` posh
    function Do-Something
    {
        param(
            [String] $Value
        )
    }
```

As soon as you set the type of the parameter as a `string`, the value can never be `$null`. It is very common to check if a value is `$null` to see if the user provided a value or not.

``` posh
    if ( $null -ne $Value ){...}
```

The `$Value` will be an empty string `''` by default in this case if no value is provided. Use the automatic varible `$PSBoundParameters.Value` instead.

``` posh
    if ( $null -ne $PSBoundParameters.Value ){...}
```

`$PSBoundParameters` only contains parameter that were specified when the function was called. You can also use the `ContainsKey` method to check for the property.

``` posh
    if ( $PSBoundParameters.ContainsKey('Value') ){...}
```

## IsNotNullOrEmpty

If the value is a string, you can use a static string function to check if the value is `$null` or an empty string at the same time.

``` posh
    if ( -not [string]::IsNullOrEmpty( $value ) ){...}
```

I find myself using this often when I know the value type should be a string.

# When I $null check

I am a defensive scripter. Anytime I call a function and assign it to a variable, I will check it for `$null`.

``` posh
    $userList = Get-ADUser kevmar
    if ($null -ne $userList){...}
```

I much prefer using `if` or `foreach` over using `try/catch`. Don't get me wrong, I still use `try/catch` a lot. But if I can test for an error condition or an empty set of results, I can allow my exception handling be for true exceptions.

I also tend to check for `$null` before I index into a value or call methods on an object. These two actions will fail if they are on a `$null` object so I find it important to validate them first. I already covered those senarios earlier in this post.

## No results senario

It is important to know that different functions and commands handle the no results scenario differently. Many PowerShell commands return the empty `$null` and an error in the error stream. But other will throw exceptions or give you a status object. It is still up to you to know how the commands you are calling deal with the no results and error scenarios.

# Initalizing to $null

One habbit that I have picked up is initalizing all my variables before I use them. You are required to do this in other languages. At the top of my function or as I enter a foreach loop, I will define all the values that I will be using.

Here is a scenario that I want you to take a close look at. It's a recreation of a bug I had to chase down before.

``` posh
    function Do-Something
    {
        foreach ( $node in 1..6 )
        {
            try
            {
                $result = Get-Something -ID $node
            }
            catch
            {
                Write-Verbose "[$result] not valid"
            }

            if ( $null -ne $result )
            {
                Update-Something $result
            }
        }
    }
```

The expectation here is that Get-Something will either return a result or an empty `$null`. If there is an error then we log it. Then we check to make sure we got a valid result before processing it.

The bug hidding in this code is when `Get-Something` throws an exception and does not assign a value to `$result`. It fails before the assignment so we don't even assign `$null` to the `$result` varialbe. `$result` will still contain the previous valid `$result` from other iterations. `Update-Something` to execute multiple times on the same object in this example.

I will set `$result` to `$null` right inside the foreach loop before I use it to mitigate this issue.

``` posh
    foreach ( $node in 1..6 )
    {
        $result = $null
        try
        {
            ...
```

## Scope issues

This also helps mitigate scoping issues. In that example, we assign values to `$result` over and over in a loop. But because PowerShell allows variable values from outside the function to bleed into the scope of the current function, initalizing them inside your function will mitigate bugs that can be introduced that way.

An uninitalized variable in your function will not be `$null` if it is set to a value in a parent scope. This can be other functions callig your function that happen to use the same variable names.

If I take that same `Do-something` example and remove the loop I would end up with something that looks like this example:

``` posh
    function Invoke-Something
    {
        $result = 'ParentScope'
        Do-Something
    }

    function Do-Something
    {
        try
        {
            $result = Get-Something -ID $node
        }
        catch
        {
            Write-Verbose "[$result] not valid"
        }

        if ( $null -ne $result )
        {
            Update-Something $result
        }
    }
```

If the call to `Get-Something` were to throw an exception, then my `$null` check will find the `$result` from `Invoke-Something`. Initalizing the value inside your function mitigates this issue.

Naming variables is hard and it is common for an author to use the same variable names in multiple functions. I know I use `$node`,`$result`,`$data` all the time. So it would be very easy for values from different scopes to show up in places where they should not be.

# Redirect output to $null

I have been talking about `$null` values for this entire article but the topic is not complete if I didn't mention redirecting output to `$null`. There will be times where you will have commands that output information or objects that you want to suppress. Redirecting output to `$null` does exactly that.

## Out-Null

The Out-Null command is the built-in way to redirect pipeline data to `$null`.

``` posh
    New-Item -Type Directory -Path $path | Out-Null
```

## Assign to $null

You can assign the results of a command to `$null` for the same effect as using `Out-Null`.

``` posh
    $null = New-Item -Type Directory -Path $path
```

Because `$null` is a constant value, you can never overwrite it. I don't like the way it looks in my code but it often performs faster than `Out-Null`.

## Redirect to $null

You can also use the redirection opperator to send output to `$null`.

``` posh
    New-Item -Type Directory -Path $path > $null
```

If you are dealing with command line executables that output on the different streams. You can redirect all output streams to `$null` like this:

``` posh
   git status *> $null
```

# Summary

I covered a lot of ground on this one and I know this article is more fragmented than most of my deep dives. That is because `$null` values can pop up in many different places in PowerShell and all the nuances are specific to where you find it. I hope you walk away from this with a better understanding of `$null` and an awareness of the more obscure scenarios you may run into.
