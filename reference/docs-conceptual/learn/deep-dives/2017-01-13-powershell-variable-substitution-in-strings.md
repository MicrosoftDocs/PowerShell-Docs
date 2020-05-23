---
layout: post
title: "Powershell: Everything you wanted to know about variable substitution in strings"
date: 2017-01-13
tags: [PowerShell,Strings,Basics]
share-img: "/img/share-img/2017-01-13-powershell-variable-substitution-in-strings.png"
---

There are many ways to use variables in strings. I am calling this variable substitution but I am referring to any time you want to format a string to include values from variables. This is something that comes up a lot that I find myself explaining quite often to new scripters.<!--more-->

[Index](#index)

# Concatenation

The the first class of methods can be referred to as concatenation. It is basically taking several strings and joining them together. There is a long history of using this to build formated strings.

    $name = 'Kevin Marquette'
    $message = 'Hello, ' + $name

This works out OK when there are very few values to add. Especially so if there is just one value at the end of the string. But this can spiral get complicated quick.

    $first = 'Kevin'
    $last = 'Marquette'

    $message = 'Hello, ' + $first + ' ' + $last + '.'

This is a very simple and common requirement and this is already getting harder to read. 

# Variable substitution

Powershell has another option that is very easy. You can specify your variables directly in the strings.

    $message = "Hello, $first $last."

This is where the type of quotes you use on your strings makes a difference. A double quoted string will allow the substitution but a single quoted string will not. There are times you will want one or the other so you have an option.

# Command substitution

Things get a little tricky when you start trying to get the values of properties into a string. This is where many new people get tripped up. First let me show you what they think should work (and at face value almost looks like it should).

    $directory = Get-Item 'c:\windows'
    $message = "Time: $directory.CreationTime"

You would be expecting to get the `CreationTime` off of the `$directory`, but instead you get this `Time: c:\windows.CreationTime` as your value. The reason is that this type of substitution only sees the base variable. It considers the period as part of the string so it stops resolving the value any deeper. 

It just so happens that this object gives a string as a default value when placed into a string. Some objects will give you the type name instead like `System.Collections.Hashtable`. Just something to watch for.

Powershell allows you to do command execution inside the string with a special syntax. This allows us to get the properties of these objects and run any other command to get a value.

    $message = "Time: $($directory.CreationTime)"

This works great for some situations but it can get just as crazy as concatenation if you have just a few variables.

## Command execution

I kind of glazed over this really quickly a second ago. You can run commands inside a string.

    $message = "Date: $(Get-Date)"

Even though I have this option, I don't like it. It gets cluttered quickly and hard to debug. I will either run the command and save to a variable or use a format string.

# Format string

.Net has a way to format strings that I find to be fairly easy to work with. First let me show you the static method for it before I show you the Powershell shortcut to do the same thing.

    # .Net string format string
    [string]::Format('Hello, {0} {1}.',$first,$last)

    # Powershell format string
    'Hello, {0} {1}.' -f $first, $last

What is happening here is that the string is parsed for the tokens `{0}` and `{1}`, then it uses that number to pick from the values provided. If you want to repeat one value some place in the string, you can reuse that values number.

The more complicated the string gets, the more value you will get out of this approach. 

## Format values as arrays

If your format line gets too long, you can place your values into an array first.

    $values = @(
        "Kevin"
        "Marquette"
    )
    'Hello, {0} {1}.' -f $values

This is not splatting because I am passing the whole array in, but the idea is similar.

## Advanced formatting

I intentionally called these out as coming from .Net because there are lots of formatting options already well [documented](https://msdn.microsoft.com/en-us/library/system.string.format(v=vs.110).aspx) on it. There are built in ways to format various data types.

    "{0:yyyyMMdd}" -f (get-date)
    "Population {0:N0}" -f  8175133

I am not going to go into them but I just wanted to let you know that this is a very powerful formatting engine if you need it.

# Joining strings

Sometimes you actually do want to concatenate a list of values together. There is a `-Join` operator that can do that for you. It will even let you specify a character to join between the strings.

    $servers = @(
        'server1'
        'server2'
        'server3'
    )

    $servers  -join ','

If you want to `-Join` some strings without a separator, you need to specify an empty string `''`. But if that is all you need, there is a faster option.

    [string]::Concat('server1','server2','server3')
    [string]::Concat($servers)


It is also worth pointing out that you can also `-Split` strings too.

# Join-Path

This is often overlooked but a great cmdlet for building a file path.

    $folder = 'Temp'
    Join-Path -Path 'c:\windows' -ChildPath $folder

The great thing about this is it will work out the backslashes correctly when it puts the values together. This is especially important if you are taking values from users or config files.

This also goes well with `Split-Path` and `Test-Path`. I also cover these in my post about [reading and saving to files](/2017-03-18-Powershell-reading-and-saving-data-to-files/?utm_source=blog&utm_medium=blog&utm_content=internal).

# Strings are arrays

I do need to mention adding strings here before I go on. Remember that a string is just an array of characters. When you add multiple strings together, a new array is created each time.

Look at this example:

    $message = "Numbers: "
    foreach($number in 1..10000)
    {
        $message += " $number"
    }

It looks very basic but what you don't see is that each time a string is added to `$message` that a whole new string is created. Memory gets allocated, data gets copied and the old one is discarded. Not a big deal when it is only done a few times, but a loop like this would really expose the issue.

## StringBuilder

StringBuilder is also very popular for building large strings from lots of smaller strings. The reason why is because it just collects all the strings you add to it and only concatenates all of them at the end when you retrieve the value.

    $stringBuilder = New-Object -TypeName "System.Text.StringBuilder"

    [void]$stringBuilder.Append("Numbers: ")
    foreach($number in 1..10000)
    {
        [void]$stringBuilder.Append(" $number")
    }
    $message = $stringBuilder.ToString()

Again, this is something that I am reaching out to .Net for. I don't use it often anymore but it is good to know it is there.

# Delineation with braces

This is used for suffix concatenation within the string. Sometimes your variable does not have a clean word boundary. 

    $test = "Bet"
    $tester = "Better"
    Write-Host "$test $tester ${test}ter"

Thank you [/u/real_parbold](https://www.reddit.com/r/PowerShell/comments/5npf8h/kevmar_everything_you_wanted_to_know_about/dcdfm6p/) for that one.

Here is an alternate to this approache:

    Write-Host "$test $tester $($test)ter"
    Write-Host "{0} {1} {0}ter" -f $test, $tester

I personally use format string for this, but this is good to know incase you see it in the wild. 

# Find and replace tokens

While most of thease features limit your need to roll your own solution, there are times where you may have large template files where you want to replace strings inside.

Let us assume you pulled in a template from a file that has a lot of text.

    $letter = Get-Content -Path TemplateLetter.txt -RAW
    $letter = $letter -replace '#FULL_NAME#', 'Kevin Marquette'

You may have lots of tokens to replace. The trick is to use a very distinct token that is easy to find and replace. I tend to use a special character at both ends to help distinguish it. 

I recently found a new way to approach this. I decided to leave this section in here because this is a pattern that is commonly used. 

## Replace multiple tokens

When I have a list of tokens that I need to replace, I take a more generic approach. I would place them in a hashtable and iterate over them to do the replace.

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

Those tokens could be loaded from JSON or CSV if needed.

## ExecutionContext ExpandString

There is a clever way to define a substitution string with single quotes and expand the vaiables later. Look at this example:

    $message = 'Hello, $Name!'
    $name = 'Kevin Marquette'    
    $string = $ExecutionContext.InvokeCommand.ExpandString($message)

The call to `.InvokeCommand.ExpandString` on the current execution context will use the variables in the current scope for substitution. The key thing here is that the `$message` can be defined very early before the variables even exist. 

If we expand on that just a little bit, we can perform this substitution over and over wih different values.

    $message = 'Hello, $Name!'
    $nameList = 'Mark Kraus','Kevin Marquette','Lee Dailey'
    foreach($name in $nameList){
        $ExecutionContext.InvokeCommand.ExpandString($message)
    }

To keep going on this idea; you could be importing a large email template from a text file to do this. I have to thank [Mark Kraus](https://get-powershellblog.blogspot.com/) for this [sugestion](https://www.reddit.com/r/PowerShell/comments/5npf8h/kevmar_everything_you_wanted_to_know_about/dcdfia5/). 


# Whatever works the best for you

I am a fan of the format string approach. I definitely do this with the more complicated strings or if there are multiple variables. On anything that is very short, I may use any one of these. 

## Anything else?
I covered a lot of ground on this one. My hope is that you walk away leaning something new.

Here is a list of everything we covered in case you want to jump back up to something. 

# Index

* TOC
{:toc}
