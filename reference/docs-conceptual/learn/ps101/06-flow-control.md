---
description: PowerShell provides methods to create loops, make decisions, and logically control the flow of code in scripts.
ms.custom: Contributor-mikefrobbins
ms.date: 3/20/2025
ms.reviewer: mirobb
title: Flow control
---

# Chapter 6 - Flow control

## Scripting

When you move from writing PowerShell one-liners to writing scripts, it sounds more complicated than
it is. A script is nothing more than the same or similar commands you run interactively in the
PowerShell console, except you save them as a `.ps1` file. There are some scripting constructs that
you might use, such as a `foreach` loop instead of the `ForEach-Object` cmdlet. The differences can
be confusing for beginners when considering that `foreach` is both a language keyword and an
alias for the `ForEach-Object` cmdlet.

## Looping

One of the best aspects of PowerShell is its scalability. Once you learn how to perform a task for a
single item, applying the same action to hundreds of items is almost as straightforward. Loop
through the items using one of the different types of loops in PowerShell.

### ForEach-Object

`ForEach-Object` is a cmdlet for iterating through items in a pipeline, such as with PowerShell
one-liners. `ForEach-Object` streams the objects through the pipeline.

Although the **Module** parameter of `Get-Command` accepts multiple string values, it only accepts
them via pipeline input by property name. In the following scenario, if you want to pipe two string
values to `Get-Command` for use with the **Module** parameter, you need to use the `ForEach-Object`
cmdlet.

```powershell
'ActiveDirectory', 'SQLServer' |
    ForEach-Object {Get-Command -Module $_} |
    Group-Object -Property ModuleName -NoElement |
    Sort-Object -Property Count -Descending
```

```Output
Count Name
----- ----
  147 ActiveDirectory
   82 SqlServer
```

In the previous example, `$_` is the current object. Beginning with PowerShell version 3.0,
`$PSItem` can be used instead of `$_`. Most experienced PowerShell users prefer using `$_` since
it's backward compatible and less to type.

When using the `foreach` keyword, you must store the items in memory before iterating through them,
which could be difficult if you don't know how many items you're working with.

```powershell
$ComputerName = 'DC01', 'WEB01'
foreach ($Computer in $ComputerName) {
    Get-ADComputer -Identity $Computer
}
```

```Output
DistinguishedName : CN=DC01,OU=Domain Controllers,DC=mikefrobbins,DC=com
DNSHostName       : dc01.mikefrobbins.com
Enabled           : True
Name              : DC01
ObjectClass       : computer
ObjectGUID        : c38da20c-a484-469d-ba4c-bab3fb71ae8e
SamAccountName    : DC01$
SID               : S-1-5-21-2989741381-570885089-3319121794-1001
UserPrincipalName :

DistinguishedName : CN=WEB01,CN=Computers,DC=mikefrobbins,DC=com
DNSHostName       : web01.mikefrobbins.com
Enabled           : True
Name              : WEB01
ObjectClass       : computer
ObjectGUID        : 33aa530e-1e31-40d8-8c78-76a18b673c33
SamAccountName    : WEB01$
SID               : S-1-5-21-2989741381-570885089-3319121794-1107
UserPrincipalName :
```

Many times a loop such as `foreach` or `ForEach-Object` is necessary. Otherwise you receive an error
message.

```powershell
Get-ADComputer -Identity 'DC01', 'WEB01'
```

```Output
Get-ADComputer : Cannot convert 'System.Object[]' to the type
'Microsoft.ActiveDirectory.Management.ADComputer' required by parameter
'Identity'. Specified method is not supported.
At line:1 char:26
+ Get-ADComputer -Identity 'DC01', 'WEB01'
+                          ~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Get-ADComputer], Parame
   terBindingException
    + FullyQualifiedErrorId : CannotConvertArgument,Microsoft.ActiveDirecto
   ry.Management.Commands.GetADComputer
```

Other times, you can get the same results while eliminating the loop. Consult the cmdlet help to
understand your options.

```powershell
'DC01', 'WEB01' | Get-ADComputer
```

```Output
DistinguishedName : CN=DC01,OU=Domain Controllers,DC=mikefrobbins,DC=com
DNSHostName       : dc01.mikefrobbins.com
Enabled           : True
Name              : DC01
ObjectClass       : computer
ObjectGUID        : c38da20c-a484-469d-ba4c-bab3fb71ae8e
SamAccountName    : DC01$
SID               : S-1-5-21-2989741381-570885089-3319121794-1001
UserPrincipalName :

DistinguishedName : CN=WEB01,CN=Computers,DC=mikefrobbins,DC=com
DNSHostName       : web01.mikefrobbins.com
Enabled           : True
Name              : WEB01
ObjectClass       : computer
ObjectGUID        : 33aa530e-1e31-40d8-8c78-76a18b673c33
SamAccountName    : WEB01$
SID               : S-1-5-21-2989741381-570885089-3319121794-1107
UserPrincipalName :
```

As you can see in the previous examples, the **Identity** parameter for `Get-ADComputer` only
accepts a single value when provided via parameter input. However, by using the pipeline, you can
send multiple values to the command because the values are processed one at a time.

### For

A `for` loop iterates while a specified condition is true. I don't use the `for` loop often, but it
has uses.

```powershell
for ($i = 1; $i -lt 5; $i++) {
    Write-Output "Sleeping for $i seconds"
    Start-Sleep -Seconds $i
}
```

```Output
Sleeping for 1 seconds
Sleeping for 2 seconds
Sleeping for 3 seconds
Sleeping for 4 seconds
```

In the previous example, the loop iterates four times by starting with the number one and continuing
as long as the counter variable `$i` is less than 5. It sleeps for a total of 10 seconds.

### Do

There are two different `do` loops in PowerShell: `do until` and `do while`. `do until` runs until
the specified condition is false.

The following example is a numbers game that continues until the value you guess equals the same
number that the `Get-Random` cmdlet generated.

```powershell
$number = Get-Random -Minimum 1 -Maximum 10
do {
    $guess = Read-Host -Prompt "What's your guess?"
    if ($guess -lt $number) {
        Write-Output 'Too low!'
    } elseif ($guess -gt $number) {
        Write-Output 'Too high!'
    }
}
until ($guess -eq $number)
```

```Output
What's your guess?: 1
Too low!
What's your guess?: 2
Too low!
What's your guess?: 3
```

`Do While` is the opposite. It runs as long as the specified condition is evaluated as true.

```powershell
$number = Get-Random -Minimum 1 -Maximum 10
do {
    $guess = Read-Host -Prompt "What's your guess?"
    if ($guess -lt $number) {
        Write-Output 'Too low!'
    } elseif ($guess -gt $number) {
        Write-Output 'Too high!'
    }
}
while ($guess -ne $number)
```

```Output
What's your guess?: 1
Too low!
What's your guess?: 2
Too low!
What's your guess?: 3
Too low!
What's your guess?: 4
```

The same results are achieved with a `Do While` loop by reversing the test condition to not equals.

`do` loops always run at least once because the condition is evaluated at the end of the loop.

### While

Like the `do while` loop, a `while` loop runs as long as the specified condition is true. The
difference, however, is that a `while` loop evaluates the condition at the top of the loop before
any code is run. So, it doesn't run if the condition is evaluated as false.

The following example calculates what day Thanksgiving Day is on in the United States. It's always
on the fourth Thursday of November. The loop starts with the 22nd day of November and adds a day,
while the day of the week isn't equal to Thursday. If the 22nd is a Thursday, the loop doesn't run
at all.

```powershell
$date = Get-Date -Date 'November 22'
while ($date.DayOfWeek -ne 'Thursday') {
    $date = $date.AddDays(1)
}
Write-Output $date
```

```Output
Thursday, November 23, 2017 12:00:00 AM
```

## break, continue, and return

The `break` keyword is designed to exit a loop and is often used with the `switch` statement. In
the following example, `break` causes the loop to end after the first iteration.

```powershell
for ($i = 1; $i -lt 5; $i++) {
    Write-Output "Sleeping for $i seconds"
    Start-Sleep -Seconds $i
    break
}
```

```Output
Sleeping for 1 seconds
```

The `continue` keyword is designed to skip to the next iteration of a loop.

The following example outputs the numbers 1, 2, 4, and 5. It skips number 3 and continues with the
next iteration of the loop. Like `break`, `continue` breaks out of the loop except only for the
current iteration. Execution continues with the next iteration instead of breaking out of the loop
altogether and stopping.

```powershell
while ($i -lt 5) {
    $i += 1
    if ($i -eq 3) {
        continue
    }
    Write-Output $i
}
```

```Output
1
2
4
5
```

The `return` keyword is designed to exit out of the existing scope.

Notice in the following example that `return` outputs the first result and then exits out of the
loop.

```powershell
$number = 1..10
foreach ($n in $number) {
    if ($n -ge 4) {
        return $n
    }
}
```

```Output
4
```

A more thorough explanation of the result statement can be found in one of my blog articles:
[The PowerShell return keyword][the-powershell-return-keyword].

## Summary

In this chapter, you learned about the different types of loops that exist in PowerShell.

## Review

1. What is the difference between the `ForEach-Object` cmdlet and the `foreach` statement?
1. What is the primary advantage of using a `while` loop instead of a `do while` or `do until` loop?
1. How do the `break` and `continue` statements differ?

## References

- [ForEach-Object][ForEach-Object]
- [about_Foreach][about_Foreach]
- [about_For][about_For]
- [about_Do][about_Do]
- [about_While][about_While]
- [about_Break][about_Break]
- [about_Continue][about_Continue]
- [about_Return][about_Return]

<!-- link references -->

[foreach-object]: /powershell/module/microsoft.powershell.core/foreach-object
[about-foreach]: /powershell/module/microsoft.powershell.core/about/about_foreach
[about-for]: /powershell/module/microsoft.powershell.core/about/about_for
[about-do]: /powershell/module/microsoft.powershell.core/about/about_do
[about-while]: /powershell/module/microsoft.powershell.core/about/about_while
[about-break]: /powershell/module/microsoft.powershell.core/about/about_break
[about-continue]: /powershell/module/microsoft.powershell.core/about/about_continue
[about-return]: /powershell/module/microsoft.powershell.core/about/about_return
[the-powershell-return-keyword]: https://mikefrobbins.com/2015/07/23/the-powershell-return-keyword/
