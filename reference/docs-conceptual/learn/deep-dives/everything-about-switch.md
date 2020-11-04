---
title: Everything you ever wanted to know about the switch statement
description: The switch statement in PowerShell offers features that aren't found in other languages.
ms.date: 05/23/2020
ms.custom: contributor-KevinMarquette
---
# Everything you ever wanted to know about the switch statement

Like many other languages, PowerShell has commands for controlling the flow of execution within your
scripts. One of those statements is the [switch][] statement and in PowerShell, it offers features
that aren't found in other languages. Today, we take a deep dive into working with the PowerShell
`switch`.

> [!NOTE]
> The [original version][] of this article appeared on the blog written by [@KevinMarquette][]. The
> PowerShell team thanks Kevin for sharing this content with us. Please check out his blog at
> [PowerShellExplained.com][].

## The `if` statement

One of the first statements that you learn is the `if` statement. It lets you execute a script block
if a statement is `$true`.

``` powershell
if ( Test-Path $Path )
{
    Remove-Item $Path
}
```

You can have much more complicated logic by using `elseif` and `else` statements. Here is an example
where I have a numeric value for day of the week and I want to get the name as a string.

``` powershell
$day = 3

if ( $day -eq 0 ) { $result = 'Sunday'        }
elseif ( $day -eq 1 ) { $result = 'Monday'    }
elseif ( $day -eq 2 ) { $result = 'Tuesday'   }
elseif ( $day -eq 3 ) { $result = 'Wednesday' }
elseif ( $day -eq 4 ) { $result = 'Thursday'  }
elseif ( $day -eq 5 ) { $result = 'Friday'    }
elseif ( $day -eq 6 ) { $result = 'Saturday'  }

$result
```

```Output
Wednesday
```

It turns out that this is a common pattern and there are many ways to deal with this. One
of them is with a `switch`.

## Switch statement

The `switch` statement allows you to provide a variable and a list of possible values. If the value
matches the variable, then its scriptblock is executed.

``` powershell
$day = 3

switch ( $day )
{
    0 { $result = 'Sunday'    }
    1 { $result = 'Monday'    }
    2 { $result = 'Tuesday'   }
    3 { $result = 'Wednesday' }
    4 { $result = 'Thursday'  }
    5 { $result = 'Friday'    }
    6 { $result = 'Saturday'  }
}

$result
```

```Output
'Wednesday'
```

For this example, the value of `$day` matches one of the numeric values, then the correct name is
assigned to `$result`. We are only doing a variable assignment in this example, but any PowerShell
can be executed in those script blocks.

### Assign to a variable

We can write that last example in another way.

``` powershell
$result = switch ( $day )
{
    0 { 'Sunday'    }
    1 { 'Monday'    }
    2 { 'Tuesday'   }
    3 { 'Wednesday' }
    4 { 'Thursday'  }
    5 { 'Friday'    }
    6 { 'Saturday'  }
}
```

We are placing the value on the PowerShell pipeline and assigning it to the `$result`. You can do
this same thing with the `if` and `foreach` statements.

### Default

We can use the `default` keyword to identify the what should happen if there is no match.

``` powershell
$result = switch ( $day )
{
    0 { 'Sunday' }
    # ...
    6 { 'Saturday' }
    default { 'Unknown' }
}
```

Here we return the value `Unknown` in the default case.

### Strings

I was matching numbers in those last examples, but you can also match strings.

``` powershell
$item = 'Role'

switch ( $item )
{
    Component
    {
        'is a component'
    }
    Role
    {
        'is a role'
    }
    Location
    {
        'is a location'
    }
}
```

```Output
is a role
```

I decided not to wrap the `Component`,`Role` and `Location` matches in quotes here to highlight that
they're optional. The `switch` treats those as a string in most cases.

## Arrays

One of the cool features of the PowerShell `switch` is the way it handles arrays. If you give a
`switch` an array, it processes each element in that collection.

``` powershell
$roles = @('WEB','Database')

switch ( $roles ) {
    'Database'   { 'Configure SQL' }
    'WEB'        { 'Configure IIS' }
    'FileServer' { 'Configure Share' }
}
```

```Output
Configure IIS
Configure SQL
```

If you have repeated items in your array, then they're matched multiple times by the appropriate
section.

### PSItem

You can use the `$PSItem` or `$_` to reference the current item that was processed. When we do a
simple match, `$PSItem` is the value that we are matching. I'll be performing some advanced matches
in the next section where this variable is used.

## Parameters

A unique feature of the PowerShell `switch` is that it has a number of [switch parameters][] that
change how it performs.

### -CaseSensitive

The matches aren't case-sensitive by default. If you need to be case-sensitive, you can use
`-CaseSensitive`. This can be used in combination with the other switch parameters.

### -Wildcard

We can enable wildcard support with the `-wildcard` switch. This uses the same wildcard logic as the
`-like` operator to do each match.

``` powershell
$Message = 'Warning, out of disk space'

switch -Wildcard ( $message )
{
    'Error*'
    {
        Write-Error -Message $Message
    }
    'Warning*'
    {
        Write-Warning -Message $Message
    }
    default
    {
        Write-Information $message
    }
}
```

```Output
WARNING: Warning, out of disk space
```

Here we are processing a message and then outputting it on different streams based on the contents.

### -Regex

The switch statement supports regex matches just like it does wildcards.

``` powershell
switch -Regex ( $message )
{
    '^Error'
    {
        Write-Error -Message $Message
    }
    '^Warning'
    {
        Write-Warning -Message $Message
    }
    default
    {
        Write-Information $message
    }
}
```

I have more examples of using regex in another article I wrote: [The many ways to use regex][].

### -File

A little known feature of the switch statement is that it can process a file with the `-File`
parameter. You use `-file` with a path to a file instead of giving it a variable expression.

``` powershell
switch -Wildcard -File $path
{
    'Error*'
    {
        Write-Error -Message $PSItem
    }
    'Warning*'
    {
        Write-Warning -Message $PSItem
    }
    default
    {
        Write-Output $PSItem
    }
}
```

It works just like processing an array. In this example, I combine it with wildcard matching and
make use of the `$PSItem`. This would process a log file and convert it to warning and error
messages depending on the regex matches.

## Advanced details

Now that you're aware of all these documented features, we can use them in the context of more
advanced processing.

### Expressions

The `switch` can be on an expression instead of a variable.

``` powershell
switch ( ( Get-Service | Where status -eq 'running' ).name ) {...}
```

Whatever the expression evaluates to is the value used for the match.

### Multiple matches

You may have already picked up on this, but a `switch` can match to multiple conditions. This is
especially true when using `-wildcard` or `-regex` matches. You can add the same condition multiple
times and all of them are triggered.

``` powershell
switch ( 'Word' )
{
    'word' { 'lower case word match' }
    'Word' { 'mixed case word match' }
    'WORD' { 'upper case word match' }
}
```

```Output
lower case word match
mixed case word match
upper case word match
```

All three of these statements are fired. This shows that every condition is checked (in order). This
holds true for processing arrays where each item checks each condition.

### Continue

Normally, this is where I would introduce the `break` statement, but it's better that we learn how
to use `continue` first. Just like with a `foreach` loop, `continue` continues onto the next item in
the collection or exits the `switch` if there are no more items. We can rewrite that last example
with continue statements so that only one statement executes.

``` powershell
switch ( 'Word' )
{
    'word'
    {
        'lower case word match'
        continue
    }
    'Word'
    {
        'mixed case word match'
        continue
    }
    'WORD'
    {
        'upper case word match'
        continue
    }
}
```

```Output
lower case word match
```

Instead of matching all three items, the first one is matched and the switch continues to the next
value. Because there are no values left to process, the switch exits. This next example is showing
how a wildcard could match multiple items.

``` powershell
switch -Wildcard -File $path
{
    '*Error*'
    {
        Write-Error -Message $PSItem
        continue
    }
    '*Warning*'
    {
        Write-Warning -Message $PSItem
        continue
    }
    default
    {
        Write-Output $PSItem
    }
}
```

Because a line in the input file could contain both the word `Error` and `Warning`, we only want the
first one to execute and then continue processing the file.

### Break

A `break` statement exits the switch. This is the same behavior that `continue` presents for single
values. The difference is shown when processing an array. `break` stops all processing in the switch
and `continue` moves onto the next item.

``` powershell
$Messages = @(
    'Downloading update'
    'Ran into errors downloading file'
    'Error: out of disk space'
    'Sending email'
    '...'
)

switch -Wildcard ($Messages)
{
    'Error*'
    {
        Write-Error -Message $PSItem
        break
    }
    '*Error*'
    {
        Write-Warning -Message $PSItem
        continue
    }
    '*Warning*'
    {
        Write-Warning -Message $PSItem
        continue
    }
    default
    {
        Write-Output $PSItem
    }
}
```

```Output
Downloading update
WARNING: Ran into errors downloading file
write-error -message $PSItem : Error: out of disk space
+ CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
+ FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException
```

In this case, if we hit any lines that start with `Error` then we get an error and the switch stops.
This is what that `break` statement is doing for us. If we find `Error` inside the string and not
just at the beginning, we write it as a warning. We do the same thing for `Warning`. It's
possible that a line could have both the word `Error` and `Warning`, but we only need one to
process. This is what the `continue` statement is doing for us.

### Break labels

The `switch` statement supports `break/continue` labels just like `foreach`.

``` powershell
:filelist foreach($path in $logs)
{
    :logFile switch -Wildcard -File $path
    {
        'Error*'
        {
            Write-Error -Message $PSItem
            break filelist
        }
        'Warning*'
        {
            Write-Error -Message $PSItem
            break logFile
        }
        default
        {
            Write-Output $PSItem
        }
    }
}
```

I personally don't like the use of break labels but I wanted to point them out because they're
confusing if you've never seen them before. When you have multiple `switch` or `foreach` statements
that are nested, you may want to break out of more than the inner most item. You can place a label
on a `switch` that can be the target of your `break`.

### Enum

PowerShell 5.0 gave us enums and we can use them in a switch.

``` powershell
enum Context {
    Component
    Role
    Location
}

$item = [Context]::Role

switch ( $item )
{
    Component
    {
        'is a component'
    }
    Role
    {
        'is a role'
    }
    Location
    {
        'is a location'
    }
}
```

```Output
is a role
```

If you want to keep everything as strongly typed enums, then you can place them in parentheses.

``` powershell
switch ($item )
{
    ([Context]::Component)
    {
        'is a component'
    }
    ([Context]::Role)
    {
        'is a role'
    }
    ([Context]::Location)
    {
        'is a location'
    }
}
```

The parentheses are needed here so that the switch doesn't treat the value `[Context]::Location` as
a literal string.

### ScriptBlock

We can use a scriptblock to perform the evaluation for a match if needed.

``` powershell
$age = 37

switch ( $age )
{
    {$PSItem -le 18}
    {
        'child'
    }
    {$PSItem -gt 18}
    {
        'adult'
    }
}
```

```Output
'adult'
```

This adds complexity and can make your `switch` hard to read. In most cases where you would use
something like this it would be better to use `if` and `elseif` statements. I would consider using
this if I already had a large switch in place and I needed two items to hit the same evaluation
block.

One thing that I think helps with legibility is to place the scriptblock in parentheses.

``` powershell
switch ( $age )
{
    ({$PSItem -le 18})
    {
        'child'
    }
    ({$PSItem -gt 18})
    {
        'adult'
    }
}
```

It still executes the same way and gives a better visual break when quickly looking at it.

### Regex $matches

We need to revisit regex to touch on something that isn't immediately obvious. The use of regex
populates the `$matches` variable. I do go into the use of `$matches` more when I talk about
[The many ways to use regex][]. Here is a quick sample to show it in action with named matches.

``` powershell
$message = 'my ssn is 123-23-3456 and credit card: 1234-5678-1234-5678'

switch -regex ($message)
{
    '(?<SSN>\d\d\d-\d\d-\d\d\d\d)'
    {
        Write-Warning "message contains a SSN: $($matches.SSN)"
    }
    '(?<CC>\d\d\d\d-\d\d\d\d-\d\d\d\d-\d\d\d\d)'
    {
        Write-Warning "message contains a credit card number: $($matches.CC)"
    }
    '(?<Phone>\d\d\d-\d\d\d-\d\d\d\d)'
    {
        Write-Warning "message contains a phone number: $($matches.Phone)"
    }
}
```

```Output
WARNING: message may contain a SSN: 123-23-3456
WARNING: message may contain a credit card number: 1234-5678-1234-5678
```

### $null

You can match a `$null` value that doesn't have to be the default.

``` powershell
$value = $null

switch ( $value )
{
    $null
    {
        'Value is null'
    }
    default
    {
        'value is not null'
    }
}

```Output
Value is null
```

Same goes for an empty string.

``` powershell
switch ( '' )
{
    ''
    {
        'Value is empty'
    }
    default
    {
        'value is a empty string'
    }
}

```Output
Value is empty
```

### Constant expression

Lee Dailey pointed out that we can use a constant `$true` expression to evaluate `[bool]` items.
Imagine if we have several boolean checks that need to happen.

``` powershell
$isVisible = $false
$isEnabled = $true
$isSecure = $true

switch ( $true )
{
    $isEnabled
    {
        'Do-Action'
    }
    $isVisible
    {
        'Show-Animation'
    }
    $isSecure
    {
        'Enable-AdminMenu'
    }
}
```

```Output
Do-Action
Enabled-AdminMenu
```

This is a clean way to evaluate and take action on the status of several boolean fields. The
cool thing about this is that you can have one match flip the status of a value that hasn't been
evaluated yet.

``` powershell
$isVisible = $false
$isEnabled = $true
$isAdmin = $false

switch ( $true )
{
    $isEnabled
    {
        'Do-Action'
        $isVisible = $true
    }
    $isVisible
    {
        'Show-Animation'
    }
    $isAdmin
    {
        'Enable-AdminMenu'
    }
}
```

```Output
Do-Action
Show-Animation
```

Setting `$isEnabled` to `$true` in this example makes sure that `$isVisible` is also set to
`$true`. Then when `$isVisible` gets evaluated, its scriptblock is invoked. This is a bit
counter-intuitive but is a clever use of the mechanics.

### $switch automatic variable

When the `switch` is processing its values, it creates an enumerator and calls it `$switch`. This is
an automatic variable created by PowerShell and you can manipulate it directly.

```powershell
$a = 1, 2, 3, 4

switch($a) {
    1 { [void]$switch.MoveNext(); $switch.Current }
    3 { [void]$switch.MoveNext(); $switch.Current }
}
```

This gives you the results of:

```Output
2
4
```

By moving the enumerator forward, the next item doesn't get processed by the `switch` but you can
access that value directly. I would call it madness.

## Other patterns

### Hashtables

One of my most popular posts is the one I did on [hashtables][]. One of the use cases for a
`hashtable` is to be a lookup table. That is an alternate approach to a common pattern that a
`switch` statement is often addressing.

``` powershell
$day = 3

$lookup = @{
    0 = 'Sunday'
    1 = 'Monday'
    2 = 'Tuesday'
    3 = 'Wednesday'
    4 = 'Thursday'
    5 = 'Friday'
    6 = 'Saturday'
}

$lookup[$day]
```

```Output
Wednesday
```

If I'm only using a `switch` as a lookup, I often use a `hashtable` instead.

### Enum

PowerShell 5.0 introduced the `Enum` and it's also an option in this case.

``` powershell
$day = 3

enum DayOfTheWeek {
    Sunday
    Monday
    Tuesday
    Wednesday
    Thursday
    Friday
    Saturday
}

[DayOfTheWeek]$day
```

```Output
Wednesday
```

We could go all day looking at different ways to solve this problem. I just wanted to make sure you
knew you had options.

## Final words

The switch statement is simple on the surface but it offers some advanced features that most people
don't realize are available. Stringing those features together makes this a powerful feature. I hope
you learned something that you had not realized before.

<!-- link references -->
[original version]: https://powershellexplained.com/2018-01-12-Powershell-switch-statement/
[powershellexplained.com]: https://powershellexplained.com/
[@KevinMarquette]: https://twitter.com/KevinMarquette
[switch]: /powershell/module/microsoft.powershell.core/about/about_switch
[switch parameters]: https://www.powershellmagazine.com/2013/12/20/using-powershell-switch-vs-boolean-parameters-in-sma-runbooks/
[The many ways to use regex]: https://powershellexplained.com/2017-07-31-Powershell-regex-regular-expression
[hashtables]: everything-about-hashtable.md
