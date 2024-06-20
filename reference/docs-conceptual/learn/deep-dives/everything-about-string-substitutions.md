---
description: There are many ways to use variables in strings to create formatted text.
ms.custom: contributor-KevinMarquette
ms.date: 06/20/2024
title: Everything you wanted to know about variable substitution in strings
---
# Everything you wanted to know about variable substitution in strings

There are many ways to use variables in strings. I'm calling this variable substitution but I'm
referring to any time you want to format a string to include values from variables. This is
something that I often find myself explaining to new scripters.

> [!NOTE]
> The [original version][14] of this article appeared on the blog written by
> [@KevinMarquette][16]. The PowerShell team thanks Kevin for sharing this content with us. Please
> check out his blog at [PowerShellExplained.com][13].

## Concatenation

The first class of methods can be referred to as concatenation. It's basically taking several
strings and joining them together. There's a long history of using concatenation to build formatted
strings.

```powershell
$name = 'Kevin Marquette'
$message = 'Hello, ' + $name
```

Concatenation works out OK when there are only a few values to add. But this can get complicated
quickly.

```powershell
$first = 'Kevin'
$last = 'Marquette'
```

```powershell
$message = 'Hello, ' + $first + ' ' + $last + '.'
```

This simple example is already getting harder to read.

## Variable substitution

PowerShell has another option that is easier. You can specify your variables directly in the
strings.

```powershell
$message = "Hello, $first $last."
```

The type of quotes you use around the string makes a difference. A double quoted string allows the
substitution but a single quoted string doesn't. There are times you want one or the other so you
have an option.

## Command substitution

Things get a little tricky when you start trying to get the values of properties into a string. This
is where many new people get tripped up. First let me show you what they think should work (and at
face value almost looks like it should).

```powershell
$directory = Get-Item 'c:\windows'
$message = "Time: $directory.CreationTime"
```

You would be expecting to get the `CreationTime` off of the `$directory`, but instead you get this
`Time: c:\windows.CreationTime` as your value. The reason is that this type of substitution only
sees the base variable. It considers the period as part of the string so it stops resolving the
value any deeper.

It just so happens that this object gives a string as a default value when placed into a string.
Some objects give you the type name instead like `System.Collections.Hashtable`. Just something
to watch for.

PowerShell allows you to do command execution inside the string with a special syntax. This allows
us to get the properties of these objects and run any other command to get a value.

```powershell
$message = "Time: $($directory.CreationTime)"
```

This works great for some situations but it can get just as crazy as concatenation if you have just
a few variables.

### Command execution

You can run commands inside a string. Even though I have this option, I don't like it. It gets
cluttered quickly and hard to debug. I either run the command and save to a variable or use a format
string.

```powershell
$message = "Date: $(Get-Date)"
```

## Format string

.NET has a way to format strings that I find fairly easy to work with. First let me show you the
static method for it before I show you the PowerShell shortcut to do the same thing.

```powershell
# .NET string format string
[string]::Format('Hello, {0} {1}.',$first,$last)

# PowerShell format string
'Hello, {0} {1}.' -f $first, $last
```

What is happening here is that the string is parsed for the tokens `{0}` and `{1}`, then it uses
that number to pick from the values provided. If you want to repeat one value some place in the
string, you can reuse that values number.

The more complicated the string gets, the more value you get out of this approach.

### Format values as arrays

If your format line gets too long, you can place your values into an array first.

```powershell
$values = @(
    "Kevin"
    "Marquette"
)
'Hello, {0} {1}.' -f $values
```

This is not splatting because I'm passing the whole array in, but the idea is similar.

## Advanced formatting

I intentionally called these out as coming from .NET because there are lots of formatting options
already well [documented][01] on it. There are built-in ways to format various data types.

```powershell
"{0:yyyyMMdd}" -f (Get-Date)
"Population {0:N0}" -f  8175133
```

```Output
20211110
Population 8,175,133
```

I'm not going to go into them but I just wanted to let you know that this is a very powerful
formatting engine if you need it.

## Joining strings

Sometimes you actually do want to concatenate a list of values together. There's a `-join` operator
that can do that for you. It even lets you specify a character to join between the strings.

```powershell
$servers = @(
    'server1'
    'server2'
    'server3'
)

$servers  -join ','
```

If you want to `-join` some strings without a separator, you need to specify an empty string `''`.
But if that is all you need, there's a faster option.

```powershell
[string]::Concat('server1','server2','server3')
[string]::Concat($servers)
```

It's also worth pointing out that you can also `-split` strings too.

## Join-Path

This is often overlooked but a great cmdlet for building a file path.

```powershell
$folder = 'Temp'
Join-Path -Path 'c:\windows' -ChildPath $folder
```

The great thing about this is it works out the backslashes correctly when it puts the values
together. This is especially important if you are taking values from users or config files.

This also goes well with `Split-Path` and `Test-Path`. I also cover these in my post about
[reading and saving to files][15].

## Strings are arrays

I do need to mention adding strings here before I go on. Remember that a string is just an array of
characters. When you add multiple strings together, a new array is created each time.

Look at this example:

```powershell
$message = "Numbers: "
foreach($number in 1..10000)
{
    $message += " $number"
}
```

It looks very basic but what you don't see is that each time a string is added to `$message` that a
whole new string is created. Memory gets allocated, data gets copied and the old one is discarded.
Not a big deal when it's only done a few times, but a loop like this would really expose the issue.

### StringBuilder

StringBuilder is also very popular for building large strings from lots of smaller strings. The
reason why is because it just collects all the strings you add to it and only concatenates all of
them at the end when you retrieve the value.

```powershell
$stringBuilder = New-Object -TypeName "System.Text.StringBuilder"

[void]$stringBuilder.Append("Numbers: ")
foreach($number in 1..10000)
{
    [void]$stringBuilder.Append(" $number")
}
$message = $stringBuilder.ToString()
```

Again, this is something that I'm reaching out to .NET for. I don't use it often anymore but it's
good to know it's there.

## Delineation with braces

This is used for suffix concatenation within the string. Sometimes your variable doesn't have a
clean word boundary.

```powershell
$test = "Bet"
$tester = "Better"
Write-Host "$test $tester ${test}ter"
```

Thank you Redditor `u/real_parbold` for that one.

Here is an alternate to this approach:

```powershell
Write-Host "$test $tester $($test)ter"
Write-Host "{0} {1} {0}ter" -f $test, $tester
```

I personally use format string for this, but this is good to know incase you see it in the wild.

## Find and replace tokens

While most of these features limit your need to roll your own solution, there are times where you
may have large template files where you want to replace strings inside.

Let us assume you pulled in a template from a file that has a lot of text.

```powershell
$letter = Get-Content -Path TemplateLetter.txt -RAW
$letter = $letter -replace '#FULL_NAME#', 'Kevin Marquette'
```

You may have lots of tokens to replace. The trick is to use a very distinct token that is easy to
find and replace. I tend to use a special character at both ends to help distinguish it.

I recently found a new way to approach this. I decided to leave this section in here because this is
a pattern that is commonly used.

### Replace multiple tokens

When I have a list of tokens that I need to replace, I take a more generic approach. I would place
them in a hashtable and iterate over them to do the replace.

```powershell
$tokenList = @{
    Full_Name = 'Kevin Marquette'
    Location = 'Orange County'
    State = 'CA'
}

$letter = Get-Content -Path TemplateLetter.txt -RAW
foreach( $token in $tokenList.GetEnumerator() )
{
    $pattern = '#{0}#' -f $token.key
    $letter = $letter -replace $pattern, $token.Value
}
```

Those tokens could be loaded from JSON or CSV if needed.

### ExecutionContext ExpandString

There's a clever way to define a substitution string with single quotes and expand the variables
later. Look at this example:

```powershell
$message = 'Hello, $Name!'
$name = 'Kevin Marquette'
$string = $ExecutionContext.InvokeCommand.ExpandString($message)
```

The call to `.InvokeCommand.ExpandString` on the current execution context uses the variables in
the current scope for substitution. The key thing here is that the `$message` can be defined very
early before the variables even exist.

If we expand on that just a little bit, we can perform this substitution over and over with different
values.

```powershell
$message = 'Hello, $Name!'
$nameList = 'Mark Kraus','Kevin Marquette','Lee Dailey'
foreach($name in $nameList){
    $ExecutionContext.InvokeCommand.ExpandString($message)
}
```

To keep going on this idea; you could be importing a large email template from a text file to do
this. I have to thank [Mark Kraus][02] for this suggestion.

## Whatever works the best for you

I'm a fan of the format string approach. I definitely do this with the more complicated strings or
if there are multiple variables. On anything that is very short, I may use any one of these.

## Anything else?

I covered a lot of ground on this one. My hope is that you walk away learning something new.

## Links

If you'd like to learn more about the methods and features that make string interpolation possible,
see the following list for the reference documentation.

- Concatenation uses the [addition operator][05]
- Variable and command substitution follow the [quoting rules][10]
- Formatting uses the [format operator][09]
- Joining strings uses the [join operator][08] and references [`Join-Path`][11], but you could also
  read about [`Join-String`][12]
- Arrays are documented in [About arrays][06]
- StringBuilder is a .NET class, with its [own documentation][04]
- Braces in strings is also covered in the [quoting rules][10]
- Token replacement uses the [replace operator][07]
- The `$ExecutionContext.InvokeCommand.ExpandString()` method has
  [.NET API reference documentation][03]

<!-- link references -->
[01]: /dotnet/api/system.string.format#overloads
[02]: https://get-powershellblog.blogspot.com/
[03]: /dotnet/api/system.management.automation.commandinvocationintrinsics.expandstring
[04]: /dotnet/api/system.text.stringbuilder
[05]: /powershell/module/microsoft.powershell.core/about/about_arithmetic_operators#adding-and-multiplying-non-numeric-types
[06]: /powershell/module/microsoft.powershell.core/about/about_arrays
[07]: /powershell/module/microsoft.powershell.core/about/about_comparison_operators#replacement-operator
[08]: /powershell/module/microsoft.powershell.core/about/about_join
[09]: /powershell/module/microsoft.powershell.core/about/about_operators#format-operator--f
[10]: /powershell/module/microsoft.powershell.core/about/about_quoting_rules
[11]: /powershell/module/microsoft.powershell.management/join-path
[12]: /powershell/module/microsoft.powershell.utility/join-string
[13]: https://powershellexplained.com/
[14]: https://powershellexplained.com/2017-01-13-powershell-variable-substitution-in-strings/
[15]: https://powershellexplained.com/2017-03-18-Powershell-reading-and-saving-data-to-files/
[16]: https://twitter.com/KevinMarquette
