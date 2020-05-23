---
layout: post
title: "Powershell: Everything you wanted to know about the IF statement"
date: 2019-08-11
tags: [PowerShell,Everything]
share-img: "/img/share-img/2019-08-11-Powershell-if-then-else-equals-operator.png"
---

Like many other languages, PowerShell has statements for conditionally executing code in your scripts. One of those statements is the [if](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-5.1) statement. Today we will take a deep dive into one of the most fundamental commands in PowerShell.

<!--more-->

# Index

* TOC
{:toc}

# Conditional execution

Your scripts will often need to make decisions and perform different logic based on those decisions. This is what I mean by conditional execution. You have one statement or value to evaluate, then execute a different sections of code based on that evaluation. This is exactly what the `if` statement does.

# The if statement

Here is a very basic example of the `if` statement:

``` posh
    $condition = $true
    if ( $condition )
    {
        Write-Output "The condition was true"
    }
```

The first thing the `if` statement does is evaluate the expression in parentheses. If it evaluates to `$true`, then it will executes the `scriptblock` in the braces. If the value was `$false`, then it would skip over that scriptblock.

In the previous example, the `if` statement was just evaluating the `$condition` variable. It was `$true` and would have executed the `Write-Output` command inside the scriptblock.

In some languages, you can place a single line of code after the `if` statement and it will get executed. That is not the case in PowerShell. You need to provide a full `scriptblock` with braces for it to work correctly.

# Comparison operators

The most common thing you will use the `if` statement for is comparing two items with each other. Powershell has special operators for different comparison scenarios. When you use a comparison operator, the value on the left hand side is compared to the value on the right hand side.

## -eq for equality

The `-eq` does an equality check between two values to make sure they are equal to each other.

``` posh
    $value = Get-MysteryValue
    if ( 5 -eq $value )
    {
        # do something
    }
```

In this example, I am taking a known value of `5` and comparing it to my `$value` to see if they match.

One possible usecase is to check the status of a value before you take an action on it. You could get a service and check that the status was running before you called `Restart-Service` on it.

It is common in other languages like C# to use `==` for equality (ex: `5 == $value`) but that does not work with powershell. Another common mistake that people make is to use the equals sign (ex: `5 = $value`) that is reserved for assigning values to variables. By placing your known value on the left, it makes that mistaken more awkward to make.

This operator (and others) have a few variations.

* `-eq` case insensitive equality
* `-ieq` case insensitive equality
* `-ceq` case sensitive equality

### -ne not equal

Many operators have a related operator that is checking for the opposite result. `-ne` will verify the values do not equal each other.


``` posh
    if ( 5 -ne $value )
    {
        # do something
    }
```

Use this to make sure that the action only executes if the value is not `5`. A good use-cases where would be to check if a service was in the running state before you try and start it.

**Variations:**

* `-ne` case insensitive not equal
* `-ine` case insensitive not equal
* `-cne` case sensitive not equal

These are just inverse variations of `-eq`. I'll group these types together when I list variations for other operators.

## -gt -ge -lt -le for greater than or less than

These operators are used when checking to see if a value is larger or smaller than another value. The `-gt -ge -lt -le` stand for GreaterThan, GreaterThanOrEqual, LessThan, and LessThanOrEqual.


``` posh
    if ( $value -gt 5 )
    {
        # do something
    }
```

**Variations:**

* `-gt` greater than
* `-igt` greater than, case insensitive
* `-cgt` greater than, case sensitive
* `-ge` greater than or equal
* `-ige` greater than or equal, case insensitive
* `-cge` greater than or equal, case sensitive
* `-lt` less than
* `-ilt` less than, case insensitive
* `-clt` less than, case sensitive
* `-le` less than or equal
* `-ile` less than or equal, case insensitive
* `-cle` less than or equal, case sensitive

I don't know why you would use case sensitive and insensitive options for these operators.

## -like wildcard matches

PowerShell has its own wildcard based pattern matching syntax and you can use it with the `-like` operator. These wildcard patterns are fairly basic.

* `?` will match any single character
* `*` will match any number of characters

``` posh
   $value = 'S-ATX-SQL01'
   if ( $value -like 'S-*-SQL??')
   {
       # do something
   }
```

It is important to point out that the pattern matches the whole string. If you need to match something in the middle of the string then you will need to place the `*` on both ends of the string.

``` posh
   $value = 'S-ATX-SQL02'
   if ( $value -like '*SQL*')
   {
       # do something
   }
```

**Variations:**

* `-like` case insensitive wildcard
* `-ilike` case insensitive wildcard
* `-clike` case sensitive wildcard
* `-notlike` case insensitive wildcard not matched
* `-inotlike` case insensitive wildcard not matched
* `-cnotlike` case sensitive wildcard not matched

## -match regular expression

The `-match` operator allows you to check a string for a regular expression based match. Use this when the wildcard patterns are not flexible enough for you.

``` posh
   $value = 'S-ATX-SQL01'
   if ( $value -match 'S-\w\w\w-SQL\d\d')
   {
       # do something
   }
```

A regex pattern will match anywhere in the string by default. So you can specify a substring that you want matched like this:

``` posh
   $value = 'S-ATX-SQL01'
   if ( $value -match 'SQL')
   {
       # do something
   }
```

Regex is a complex language of its own and worth looking into. I talk more about `-match` and [the many ways to use regex](/2017-07-31-Powershell-regex-regular-expression/?utm_source=blog&utm_medium=blog&utm_content=ifstatement) in another article.

**Variations:**

* `-match` case insensitive regex
* `-imatch` case insensitive regex
* `-cmatch` case sensitive regex
* `-notmatch` case insensitive regex not matched
* `-inotmatch` case insensitive regex not matched
* `-cnotmatch` case sensitive regex not matched


## -is of type

You are able to check a value's type with the `-is` operator.

``` posh
    if ( $value -is [string] )
    {
        # do something
    }
```

You may use this if you are working with classes or accepting various objects over the pipeline. You could have either a service or a service name as your input. Then check to see if you have a service and fetch the service if you only have the name.

``` posh
    if ( $Service -isnot [System.ServiceProcess.ServiceController] )
    {
        $Service = Get-Service -Name $Service
    }
```

**Variations:**

* `-is` of type
* `-isnot` not of type


# Collection operators

When you use the previous operators with a single value, the result is `$true` or `$false`. This is handled slightly differently when working with a collection. Each item in the collection gets evaluated and the operator will instead return every value that evaluates to `$true`.

``` posh
    PS> 1,2,3,4 -eq 3
    3
```

This still works correctly in a `if` statement. So a value is returned by your operator, then the whole statement is `$true`.

``` posh
    $array = 1..6
    if ( $array -gt 3 )
    {
        # do something
    }
```

There is one small trap hiding in the details here that I need to point out. When using the `-ne` operator this way, it is easy to mistakenly look at the logic backwards. Using `-ne` with a collection will return `$true` if any item in the collection does not match your value.

``` posh
    PS> 1,2,3 -ne 4
    1
    2
    3
```

This may look like a clever trick, but we have operators `-contains` and `-in` that handle this more efficiently and `-notcontains` will correctly do what you expect.

## -contains

The `-contains` operator will check the collection for your value. As soon as as it finds a match, it will return `$true`.

``` posh
    $array = 1..6
    if ( $array -contains 3 )
    {
        # do something
    }
```

This is the preferred way to see if a collection contains your value.  Using `Where-Object` ( or `-eq`) will walk the entire list every time and be significantly slower.

**Variations:**

* `-contains` case insensitive match
* `-icontains` case insensitive match
* `-ccontains` case sensitive match
* `-notcontains` case insensitive not matched
* `-inotcontains` case insensitive not matched
* `-cnotcontains` case sensitive not matched


## -in

The `-in` operator is just like the `-contains` operator except the collection is on the right hand side.


``` posh
    $array = 1..6
    if ( 3 -in $array )
    {
        # do something
    }
```

**Variations:**

* `-in` case insensitive match
* `-iin` case insensitive match
* `-cin` case sensitive match
* `-notin` case insensitive not matched
* `-inotin` case insensitive not matched
* `-cnotin` case sensitive not matched


# Logical operators

Logical operators are used to invert or combine other expressions.

## -not

The `-not` operator flips an expression from `$false` to `$true` or from `$true` to `$false`.  Here is an example where we want to perform an action when `Test-Path` is `$false`.

``` posh
    if ( -not ( Test-Path -Path $path ) )
```

Most of the operators we talked about do have a variation where you would not need to use the `-not` operator, but there are still times you would use it.

### !

You can use `!` as an alias for `-not`.

``` posh
    if ( -not $value ){}
    if ( !$value ){}
```

You will see `!` used more by people that come from another languages like C#. I prefer to type it out because I find it hard to see when quickly looking at my scripts.

## -and

You can combine expressions with the `-and` operator. When you do that, both sides need to be `$true` for the whole expression to be `$true`.

``` posh
    if ( ($age -gt 13) -and ($age -lt 55) )
```

In that example, `$age` must be 13 or older for the left side and less than 55 for the right side. I added extra parentheses to make it more clear in that example but they are optional as long as the expresion is simple. Here is the same example without them.

``` posh
    if ( $age -gt 13 -and $age -lt 55 )
```

Evaluation happens from left to right. If the first item evaluates to `$false` then it will exit early and not perform the right comparison. This is handy when you need to make sure a value exists before you use it. `Test-Path` for example will throw an error if you give it a `$null` path.

``` posh
    if ( $null -ne $path -and (Test-Path -Path $path) )
```

## -or

The `-or` allows for you to specify two expressions and returns `$true` if either one of them is `$true`. 

``` posh
    if ( $age -le 13 -or $age -ge 55 )
```

Just like with the `-and` operator, the evaluation happens from left to right. Except that if the first part is `$true`, then the whole statement is `$true` and it will not process the rest of the expression.


Also make note of how the syntax works for these operators. You need two separate expressions. I have seen users try to do something like this `$value -eq 5 -or 6` without realizing their mistake.  

## -xor exclusive or

This one is a little unusual. `-xor` allows only one expression to evaluate to `$true`. So if both items are `$false` or both items are `$true`, then the whole expression is `$false`. Another way to look at this is the expression is only `$true` when the results of the expression are different.

It's rare that anyone would ever use this logical operator and I can't think up a good example as to why I would ever use it.

# Bitwise operators

Bitwise operators perform calculations on the bits within the values and produce a new value as the result. Teaching [bitwise operators](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators?view=powershell-6#bitwise-operators) is beyond the scope of this article, but here is the list the them.

* `-band` binary AND
* `-bor` binary OR
* `-bxor` binary exclusive OR
* `-bnot` binary NOT
* `-shl` shift left
* `-shr` shift right


# PowerShell expressions
  
We can use normal PowerShell inside the condition statement.

``` posh
    if ( Test-Path -Path $Path )
```

`Test-Path` returns `$true` or `$false` when it executes. This also applies to commands that return other values.

``` posh
    if ( Get-Process Notepad* )
```

It will evaluate to `$true` if there is a returned process and `$false` if there is nothing. It is perfectly valid to use pipeline expressions or other PowerShell statements like this:

``` posh
    if ( Get-Process | Where Name -eq Notepad )
```

These expressions can be combined with each other with the `-and` and `-or` operators, but you may have to use parenthesis to break them into sub-expressions.

``` posh
    if ( (Get-Process) -and (Get-Service) )
```

## Checking for $null

Having a no result or a `$null` value evaluates to `$false` in the `if` statement. When checking specifically for `$null`, it is a best practice to place the `$null` on the left hand side.

``` posh
    if ( $null -eq $value )
```

There are quite a few nuances when dealing with `$null` values in PowerShell. If you are interested in diving deeper, I have an article about [everything you wanted to know about $null](/2018-12-23-Powershell-null-everything-you-wanted-to-know/?utm_source=blog&utm_medium=blog&utm_content=ifstatement).

## Variable assignment

I almost forgot to add this one until [Prasoon Karunan V](https://twitter.com/prasoonkarunan) reminded me of it.

<blockquote class="twitter-tweet" data-conversation="none"><p lang="en" dir="ltr">you could add below case as well :-)<br>if($process=Get-Process notepad -ErrorAction ignore){$process}else{$false}</p>&mdash; Prasoon Karunan V (@prasoonkarunan) <a href="https://twitter.com/prasoonkarunan/status/1160752165842853888?ref_src=twsrc%5Etfw">August 12, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Normally when you assign a value to a variable, the value is not passed onto the pipeline or console. When you do a variable assignment in a sub expression, it does get passed on to the pipeline.

``` posh
    PS> $first = 1
    PS> ($second = 2)
    2
```

See how the `$first` assignment has no output and the `$second` assignment does? When an assignment is done in an `if` statement, it will execute just like the `$second` assignment above. Here is a clean example on how you could use it:

``` posh
    if ( $process = Get-Process Notepad* )
    {
        $process | Stop-Process
    }
```

If `$process` gets assigned a value, then the statement will be `$true` and then the `$process` will get stopped.

Make sure you don't confuse this with `-eq` because this is not an equality check. This is a more obscure feature that most people don't realize works this way.

# Alternate execution path

The `if` statement allows you to specify an action for not only when the statement is `$true`, but also for when it is `$false`. This is where the `else` statement comes into play.

## else

The `else` statement is always the last part of the `if` statement when used.

``` posh
    if ( Test-Path -Path $Path -PathType Leaf )
    {
        Move-Item -Path $Path -Destination $archivePath
    }
    else
    {
        Write-Warning "$path does not exist or is not a file."
    }
```

In this example, we check the `$path` to make sure it is a file. If we find the file, we move it. If not, we write a warning. This type of branching logic is very common.


## Nested if

The `if` and `else` statements take a script block, so we can place any PowerShell command inside them, including another `if` statement. This allows you to make use of much more complicated logic.

``` posh
    if ( Test-Path -Path $Path -PathType Leaf )
    {
        Move-Item -Path $Path -Destination $archivePath
    }
    else
    {
        if ( Test-Path -Path $Path )
        {
            Write-Warning "A file was required but a directory was found instead."
        }
        else
        {
            Write-Warning "$path could not be found."
        }
    }
```

In this example, we test the happy path first and then take action on it. If that fails, we do another check and to provide more detailed information to the user.

## elseif

We are not limited to just a single conditional check. We can chain `if` and `else` statements together instead of nesting them by using the `elseif` statement.

``` posh
    if ( Test-Path -Path $Path -PathType Leaf )
    {
        Move-Item -Path $Path -Destination $archivePath
    }
    elseif ( Test-Path -Path $Path )
    {
        Write-Warning "A file was required but a directory was found instead."
    }
    else
    {
        Write-Warning "$path could not be found."
    }
```

The execution happens from the top to the bottom. The top `if` statement is evaluated first. If that is `$false`, then it moves down to the next `elseif` or `else` in the list. That last `else` is the default action to take if none of the others return `$true`.

## switch

At tis point, I need to mention the `switch` statement. It provides an alternate syntax for doing multiple comparisons with a value. With the `switch`, you specify an expression and that result gets compared with several different values. If one of those values mach, then the matching code block is executed. Take a look at this example:

``` posh
    $itemType = 'Role'
    switch ( $itemType )
    {
        'Component'
        {
            'is a component'
        }
        'Role'
        {
            'is a role'
        }
        'Location'
        {
            'is a location'
        }
    }
```

There three possible values that can match the `$itemType`. In this case, it will match with `Role` and the `is a role` would get executed. I used a very simple example just to give you some exposure to the `switch` operator. I talk more about [everything you ever wanted to know about the switch statement](/2018-01-12-Powershell-switch-statement/?utm_source=blog&utm_medium=blog&utm_content=ifstatement) in another article.



# Pipeline

The pipeline is a very unique and important feature of PowerShell. Any value that is not suppressed or assigned to a variable gets placed in the pipeline. The `if` provides us a way to take advantage of the pipeline in a way that is not always obvious.

``` posh
    $discount = if ( $age -ge 55 )
    {
        Get-SeniorDiscount
    }
    elseif ( $age -le 13 )
    {
        Get-ChildDiscount
    }
    else
    {
        0.00
    }
```

Each script block is placing the results the commands or the value into the pipeline. Then we are assigning the result of the if statement to the `$discount` variable. That example could have just as easily assigned those values to the `$discount` variable directly in each scriptblock. I can't say that I use this with the `if` statement very often, but I do have an example where I have used this recently.

## Array inline

I have a function called [Invoke-SnowSql](https://github.com/loanDepot/SnowSQL/blob/a3731b52e4ab4ecb503fb81e2d8cb131e8f90410/SnowSQL/public/Invoke-SnowSql.ps1#L90) that launches an executable with several commandline arguments. Here is a clip from that function where I build the array of arguments.

``` posh
    $snowSqlParam = @(
        '--accountname', $Endpoint
        '--username', $Credential.UserName
        '--option', 'exit_on_error=true'
        '--option', 'output_format=csv'
        '--option', 'friendly=false'
        '--option', 'timing=false'
        if ($Debug)
        {
            '--option', 'log_level=DEBUG'
        }
        if ($Path)
        {
            '--filename', $Path
        }
        else
        {
            '--query', $singleLineQuery
        }
    )
```

The `$Debug` and `$Path` variables are parameters on the function that are provided by the end user. I evaluate them inline inside the initialization of my array. If `$Debug` is true, then those values fall into the `$snowSqlParam` in the correct place. Same holds true for the `$Path` variable.


# Simplify complex operations

It is inevitable that you run into a situation that has way too many comparisons to check and your if statement scrolls way off the right side of the screen.

``` posh
    $user = Get-ADUser -Identity $UserName
    if ( $null -ne $user -and $user.Department -eq 'Finance' -and $user.Title -match 'Senior' -and $user.HomeDrive -notlike '\\server\*' )
    {
        # Do Something
    }
```

They can be hard to read and that make you more prone to make mistakes. There are a few things we can do about that.

## Line continuation

There some operators in PowerShell that let you wrap you command to the next line. The logical operators `-and` and `-or` are good operators to use if you want to break your expression into multiple lines.

``` posh
    if ($null -ne $user -and
        $user.Department -eq 'Finance' -and
        $user.Title -match 'Senior' -and
        $user.HomeDrive -notlike '\\server\*'
    )
    {
        # Do Something
    }
```

There is still a lot going on there, but placing each piece on its own line makes a big difference. I generally only do this when I get more than two comparisons or if I have to scroll to the right to read any of the ligic.

## Pre-calculating results

We can take that statement out of the if statement and only check the result.

``` posh
    $needsSecureHomeDrive = $null -ne $user -and
        $user.Department -eq 'Finance' -and
        $user.Title -match 'Senior' -and
        $user.HomeDrive -notlike '\\server\*'

    if ( $needsSecureHomeDrive )
    {
        # Do Something
    }
```

This just feels much cleaner than the previous example. You also are given an opportunity to use a variable name that explains what it is that you are really checking. This is also and example of self documenting code that saves unnecessary comments.

## Multiple if statements

We can break this up into multiple statements and check them one at a time. In this case we will use a flag or a tracking variable to combine the results.

``` posh

    $skipUser = $false

    if( $null -eq $user )
    {
        $skipUser = $true
    }

    if( $user.Department -ne 'Finance' )
    {
        Write-Verbose "Is not in Finance department"
        $skipUser = $true
    }

    if( $user.Title -match 'Senior' )
    {
        Write-Verbose "Does not have Senior title"
        $skipUser = $true
    }

    if( $user.HomeDrive -like '\\server\*' )
    {
        Write-Verbose "Home drive already configured"
        $skipUser = $true
    }

    if ( -not $skipUser )
    {
        # do something
    }
```

I did have to invert the logic to make the flag logic work correctly. Each evaluation is an individual `if` statement. The advantage of this is that when you are debugging, you can tell exactly what the logic is doing. I was able to add much better verbosity at the same time.

The obvious downside is that it is so much more code to write. The code is more complex to look at as it takes a single line of logic and explodes it into 25 or more lines. 

## Using functions

We can also move all that validation logic into a function. Look at how clean this looks at a glance.

``` posh
    if ( Test-SecureDriveConfiguration -ADUser $user )
    {
        # do something
    }
```

You still have to create the function to do the validation, but it makes this code much easier to work with. It makes this code easier to test. In your tests, you can mock the call to `Test-ADDriveConfiguration` and you only need two tests for this function. One where it returns `$true` and one where it returns `$false`. Testing the other function will be simpler because it is so small.

The body of that function could still be that one-liner we started with or the exploded logic that we used in the last section. This works well for both scenarios and allows you to easily change that implementation later.


# Error handling

One really important use of the `if` statement is to check for error conditions before you run into errors. A good example is to check if a folder already exists before you try and create it.

``` posh
   if ( -not (Test-Path -Path $folder) )
   {
       New-Item -Type Directory -Path $folder
   }
```

I like to say that if you expect an exception to happen, then its not really an exception. So check your values and validate your conditions where you can.

If you want to dive a little more into actual exception handling, I have an article on [everything you ever wanted to know about exceptions](/2017-04-10-Powershell-exceptions-everything-you-ever-wanted-to-know/?utm_source=blog&utm_medium=blog&utm_content=ifstatement).


# Final words

The `if` statement is such a simple statement but is a very fundamental piece of PowerShell. You will find yourself using this multiple times in almost every script you write. I hope you you have a better understanding than you had before.
