---
description: PowerShell provides methods to create loops, make decisions, and logically control the flow of code in scripts.
ms.custom: Contributor-mikefrobbins
ms.date: 12/08/2022
ms.reviewer: mirobb
title: Flow control
---
# Chapter 6 - Flow control

## Scripting

When you move from writing PowerShell one-liners to writing scripts, it sounds a lot more
complicated than it really is. A script is nothing more than the same or similar commands that you
would run interactively in the PowerShell console, except they're saved as a `.PS1` file. There are
some scripting constructs that you may use such as a `foreach` loop instead of the `ForEach-Object`
cmdlet. To beginners, the differences can be confusing especially when you consider that `foreach`
is both a scripting construct and an alias for the `ForEach-Object` cmdlet.

## Looping

One of the great things about PowerShell is, once you figure out how to do something for one item,
it's almost as easy to do the same task for hundreds of items. Simply loop through the items using
one of the many different types of loops in PowerShell.

### ForEach-Object

`ForEach-Object` is a cmdlet for iterating through items in a pipeline such as with PowerShell
one-liners. `ForEach-Object` streams the objects through the pipeline.

Although the **Module** parameter of `Get-Command` accepts multiple values that are strings, it only
accepts them via pipeline input by property name or via parameter input. In the following scenario,
if I want to pipe two strings by value to `Get-Command` for use with the **Module** parameter, I
would need to use the `ForEach-Object` cmdlet.

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
`$PSItem` can be used instead of `$_`. But I find that most experienced PowerShell users still
prefer using `$_` since it's backward compatible and less to type.

When using the `foreach` keyword, you must store all of the items in memory before iterating through
them, which could be difficult if you don't know how many items you're working with.

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

Many times a loop such as `foreach` or `ForEach-Object` is necessary. Otherwise you'll receive an
error message.

```powershell
Get-ADComputer -Identity 'DC01', 'WEB01'
```

```Output
Get-ADComputer : Cannot convert 'System.Object[]' to the type
'Microsoft.ActiveDirectory.Management.ADComputer' required by parameter 'Identity'.
Specified method is not supported.
At line:1 char:26
+ Get-ADComputer -Identity 'DC01', 'WEB01'
+                          ~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Get-ADComputer], ParameterBindingExc
   eption
    + FullyQualifiedErrorId : CannotConvertArgument,Microsoft.ActiveDirectory.Management
   .Commands.GetADComputer
```

Other times, you can get the same results while eliminating the loop altogether. Consult the cmdlet
help to understand your options.

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

As you can see in the previous examples, the **Identity** parameter for `Get-ADComputer` only accepts a
single value when provided via parameter input, but it allows for multiple items when the input is
provided via pipeline input.

### For

A `for` loop iterates while a specified condition is true. The `for` loop is not something that I
use often, but it does have its uses.

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

In the previous example, the loop will iterate four times by starting off with the number one and
continue as long as the counter variable `$i` is less than 5. It will sleep for a total of 10
seconds.

### Do

There are two different `do` loops in PowerShell. `Do Until` runs while the specified condition is
false.

```powershell
$number = Get-Random -Minimum 1 -Maximum 10
do {
  $guess = Read-Host -Prompt "What's your guess?"
  if ($guess -lt $number) {
    Write-Output 'Too low!'
  }
  elseif ($guess -gt $number) {
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

The previous example is a numbers game that continues until the value you guess equals the same
number that the `Get-Random` cmdlet generated.

`Do While` is just the opposite. It runs as long as the specified condition evaluates to true.

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

`Do` loops always run at least once because the condition is evaluated at the end of the loop.

### While

Similar to the `Do While` loop, a `While` loop runs as long as the specified condition is true. The
difference however, is that a `While` loop evaluates the condition at the top of the loop before any
code is run. So it doesn't run if the condition evaluates to false.

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

The previous example calculates what day Thanksgiving Day is on in the United States. It's always on
the fourth Thursday of November. So the loop starts with the 22nd day of November and adds a day
while the day of the week isn't equal to Thursday. If the 22nd is a Thursday, the loop doesn't run
at all.

## Break, Continue, and Return

`Break` is designed to break out of a loop. It's also commonly used with the `switch` statement.

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

The `break` statement shown in the previous example causes the loop to exit on the first iteration.

Continue is designed to skip to the next iteration of a loop.

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

The previous example will output the numbers 1, 2, 4, and 5. It skips number 3 and continues with
the next iteration of the loop. Similar to `break`, `continue` breaks out of the loop except only
for the current iteration. Execution continues with the next iteration instead of breaking out of
the loop and stopping.

Return is designed to exit out of the existing scope.

```powershell
$number = 1..10
foreach ($n in $number) {
  if ($n -ge 4) {
    Return $n
  }
}
```

```Output
4
```

Notice that in the previous example, return outputs the first result and then exits out of the
loop. A more thorough explanation of the result statement can be found in one of my blog articles:
["The PowerShell return keyword"]["The PowerShell return keyword"].

## Summary

In this chapter, you've learned about the different types of loops that exist in PowerShell.

## Review

1. What is the difference in the `ForEach-Object` cmdlet and the foreach scripting construct?
1. What is the primary advantage of using a While loop instead of a Do While or Do Until loop.
1. How do the break and continue statements differ?

## Recommended Reading

- [ForEach-Object][ForEach-Object]
- [about_ForEach][about_ForEach]
- [about_For][about_For]
- [about_Do][about_Do]
- [about_While][about_While]
- [about_Break][about_Break]
- [about_Continue][about_Continue]
- [about_Return][about_Return]

<!-- link references -->
[ForEach-Object]: /powershell/module/microsoft.powershell.core/foreach-object
[about_ForEach]: /powershell/module/microsoft.powershell.core/about/about_foreach
[about_For]: /powershell/module/microsoft.powershell.core/about/about_for
[about_Do]: /powershell/module/microsoft.powershell.core/about/about_do
[about_While]: /powershell/module/microsoft.powershell.core/about/about_while
[about_Break]: /powershell/module/microsoft.powershell.core/about/about_break
[about_Continue]: /powershell/module/microsoft.powershell.core/about/about_continue
[about_Return]: /powershell/module/microsoft.powershell.core/about/about_return
["The PowerShell return keyword"]: https://mikefrobbins.com/2015/07/23/the-powershell-return-keyword/
