---
description: This chapter introduces the concepts of output formatting, command aliases, providers, and comparison operations.
ms.custom: Contributor-mikefrobbins
ms.date: 01/09/2025
ms.reviewer: mirobb
title: Formatting, aliases, providers, comparison
---

# Chapter 5 - Formatting, aliases, providers, comparison

## Prerequisites

The **SqlServer** PowerShell module is required by some examples shown in this chapter. For more
information about the **SqlServer** PowerShell module and installation instructions, see
[SQL Server PowerShell overview][sql-server-powershell]. It's also used in subsequent chapters.
Download and install it on your Windows lab environment computer.

## Format Right

In Chapter 4, you learned to filter as far to the left as possible. The rule for manually formatting
a command's output is similar to that rule, except it needs to occur as far to the right as
possible.

The most common format commands are `Format-Table` and `Format-List`. `Format-Wide` and
`Format-Custom` can also be used, but are less common.

As mentioned in Chapter 3, a command that returns more than four properties defaults to a list
unless custom formatting is used.

```powershell
Get-Service -Name w32time |
    Select-Object -Property Status, DisplayName, Can*
```

```Output
Status              : Running
DisplayName         : Windows Time
CanPauseAndContinue : False
CanShutdown         : True
CanStop             : True
```

Use the `Format-Table` cmdlet to manually override the formatting and show the output in a table
instead of a list.

```powershell
Get-Service -Name w32time |
    Select-Object -Property Status, DisplayName, Can* |
    Format-Table
```

```Output
Status  DisplayName  CanPauseAndContinue CanShutdown CanStop
------  -----------  ------------------- ----------- -------
Running Windows Time               False        True    True
```

The default output for `Get-Service` is three properties in a table.

```powershell
Get-Service -Name w32time
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  w32time            Windows Time
```

Use the `Format-List` cmdlet to override the default formatting and return the results in a list.

```powershell
Get-Service -Name w32time | Format-List
```

Notice that simply piping `Get-Service` to `Format-List` made it return additional properties. This
doesn't occur with every command because of how the format for that particular command is set up
behind the scenes.

```Output
Name                : w32time
DisplayName         : Windows Time
Status              : Running
DependentServices   : {}
ServicesDependedOn  : {}
CanPauseAndContinue : False
CanShutdown         : True
CanStop             : True
ServiceType         : Win32OwnProcess, Win32ShareProcess
```

The number one thing to be aware of with the format cmdlets is they produce format objects that are
different than normal objects in PowerShell.

```powershell
Get-Service -Name w32time | Format-List | Get-Member
```

```Output
   TypeName: Microsoft.PowerShell.Commands.Internal.Format.FormatStartData

Name                                    MemberType Definition
----                                    ---------- ----------
Equals                                  Method     bool Equals(System.Obj...
GetHashCode                             Method     int GetHashCode()
GetType                                 Method     type GetType()
ToString                                Method     string ToString()
autosizeInfo                            Property   Microsoft.PowerShell.C...
ClassId2e4f51ef21dd47e99d3c952918aff9cd Property   string ClassId2e4f51ef...
groupingEntry                           Property   Microsoft.PowerShell.C...
pageFooterEntry                         Property   Microsoft.PowerShell.C...
pageHeaderEntry                         Property   Microsoft.PowerShell.C...
shapeInfo                               Property   Microsoft.PowerShell.C...


   TypeName: Microsoft.PowerShell.Commands.Internal.Format.GroupStartData

Name                                    MemberType Definition
----                                    ---------- ----------
Equals                                  Method     bool Equals(System.Obj...
GetHashCode                             Method     int GetHashCode()
GetType                                 Method     type GetType()
ToString                                Method     string ToString()
ClassId2e4f51ef21dd47e99d3c952918aff9cd Property   string ClassId2e4f51ef...
groupingEntry                           Property   Microsoft.PowerShell.C...
shapeInfo                               Property   Microsoft.PowerShell.C...


   TypeName: Microsoft.PowerShell.Commands.Internal.Format.FormatEntryData

Name                                    MemberType Definition
----                                    ---------- ----------
Equals                                  Method     bool Equals(System.Obj...
GetHashCode                             Method     int GetHashCode()
GetType                                 Method     type GetType()
ToString                                Method     string ToString()
ClassId2e4f51ef21dd47e99d3c952918aff9cd Property   string ClassId2e4f51ef...
formatEntryInfo                         Property   Microsoft.PowerShell.C...
outOfBand                               Property   bool outOfBand {get;set;}
writeStream                             Property   Microsoft.PowerShell.C...


   TypeName: Microsoft.PowerShell.Commands.Internal.Format.GroupEndData

Name                                    MemberType Definition
----                                    ---------- ----------
Equals                                  Method     bool Equals(System.Obj...
GetHashCode                             Method     int GetHashCode()
GetType                                 Method     type GetType()
ToString                                Method     string ToString()
ClassId2e4f51ef21dd47e99d3c952918aff9cd Property   string ClassId2e4f51ef...
groupingEntry                           Property   Microsoft.PowerShell.C...


   TypeName: Microsoft.PowerShell.Commands.Internal.Format.FormatEndData

Name                                    MemberType Definition
----                                    ---------- ----------
Equals                                  Method     bool Equals(System.Obj...
GetHashCode                             Method     int GetHashCode()
GetType                                 Method     type GetType()
ToString                                Method     string ToString()
ClassId2e4f51ef21dd47e99d3c952918aff9cd Property   string ClassId2e4f51ef...
groupingEntry                           Property   Microsoft.PowerShell.C...
```

What this means is format commands can't be piped to most other commands. They can be piped to some
of the `Out-*` commands, but that's about it. This is why you want to perform any formatting at the
very end of the line (format right).

## Aliases

An alias in PowerShell is a shorter name for a command. PowerShell includes a set of built-in
aliases and you can also define your own aliases.

The `Get-Alias` cmdlet is used to find aliases. If you already know the alias for a command, the
**Name** parameter is used to determine what command the alias is associated with.

```powershell
Get-Alias -Name gcm
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Alias           gcm -> Get-Command
```

Multiple aliases can be specified for the value of the **Name** parameter.

```powershell
Get-Alias -Name gcm, gm
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Alias           gcm -> Get-Command
Alias           gm -> Get-Member
```

You often see the **Name** parameter omitted since it's a positional parameter.

```powershell
Get-Alias gm
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Alias           gm -> Get-Member
```

If you want to find aliases for a command, you need to use the **Definition** parameter.

```powershell
Get-Alias -Definition Get-Command, Get-Member
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Alias           gcm -> Get-Command
Alias           gm -> Get-Member
```

The **Definition** parameter can't be used positionally, so it must be specified.

Aliases can save you a few keystrokes, and they're fine when you type commands into the console.
They shouldn't be used in scripts or any code that you're saving or sharing with others. As
mentioned earlier in this book, using full cmdlet and parameter names is self-documenting and easier
to understand.

Use caution when creating your own aliases because they only exist in your current PowerShell
session on your computer.

## Providers

A provider in PowerShell is an interface that allows file system-like access to a data store. There
are several built-in providers in PowerShell.

```powershell
Get-PSProvider
```

As you can see in the following results, there are built-in providers for the registry, aliases,
environment variables, the file system, functions, variables, certificates, and WSMan.

```Output
Name                 Capabilities                 Drives
----                 ------------                 ------
Registry             ShouldProcess, Transactions  {HKLM, HKCU}
Alias                ShouldProcess                {Alias}
Environment          ShouldProcess                {Env}
FileSystem           Filter, ShouldProcess, Cr... {C, D}
Function             ShouldProcess                {Function}
Variable             ShouldProcess                {Variable}
```

The actual drives that these providers use to expose their data store can be determined with the
`Get-PSDrive` cmdlet. The `Get-PSDrive` cmdlet not only displays drives exposed by providers but
also displays Windows logical drives, including drives mapped to network shares.

```powershell
Get-PSDrive
```

```Output
Name           Used (GB)     Free (GB) Provider      Root
----           ---------     --------- --------      ----
Alias                                  Alias
C                  18.56        107.62 FileSystem    C:\
Cert                                   Certificate   \
D                                      FileSystem    D:\
Env                                    Environment
Function                               Function
HKCU                                   Registry      HKEY_CURRENT_USER
HKLM                                   Registry      HKEY_LOCAL_MACHINE
Variable                               Variable
WSMan                                  WSMan
```

Third-party modules such as the **ActiveDirectory** PowerShell module and the **SqlServer**
PowerShell module both add their own PowerShell provider and PSDrive.

Import the **ActiveDirectory** and **SqlServer** PowerShell modules.

```powershell
Import-Module -Name ActiveDirectory, SQLServer
```

Check to see if any additional PowerShell providers were added.

```powershell
Get-PSProvider
```

Notice that in the following set of results, two new PowerShell providers now exist, one for Active
Directory and another one for SQL Server.

```Output
Name                 Capabilities                       Drives
----                 ------------                       ------
Registry             ShouldProcess, Transactions        {HKLM, HKCU}
Alias                ShouldProcess                      {Alias}
Environment          ShouldProcess                      {Env}
FileSystem           Filter, ShouldProcess, Credentials {C, A, D}
Function             ShouldProcess                      {Function}
Variable             ShouldProcess                      {Variable}
ActiveDirectory      Include, Exclude, Filter, Shoul... {AD}
SqlServer            Credentials                        {SQLSERVER}
```

A PSDrive for each of those modules was also added.

```powershell
Get-PSDrive
```

```Output
Name           Used (GB)     Free (GB) Provider      Root
----           ---------     --------- --------      ----
A                                      FileSystem    A:\
AD                                     ActiveDire... //RootDSE/
Alias                                  Alias
C                  19.38        107.13 FileSystem    C:\
Cert                                   Certificate   \
D                                      FileSystem    D:\
Env                                    Environment
Function                               Function
HKCU                                   Registry      HKEY_CURRENT_USER
HKLM                                   Registry      HKEY_LOCAL_MACHINE
SQLSERVER                              SqlServer     SQLSERVER:\
Variable                               Variable
WSMan                                  WSMan
```

PSDrives can be accessed just like a traditional file system.

```powershell
Get-ChildItem -Path Cert:\LocalMachine\CA
```

```Output
   PSParentPath: Microsoft.PowerShell.Security\Certificate::LocalMachine\CA

Thumbprint                                Subject
----------                                -------
FEE449EE0E3965A5246F000E87FDE2A065FD89D4  CN=Root Agency
D559A586669B08F46A30A133F8A9ED3D038E2EA8  OU=www.verisign.com/CPS Incorp....
109F1CAED645BB78B3EA2B94C0697C740733031C  CN=Microsoft Windows Hardware C...
```

## Comparison Operators

PowerShell contains various comparison operators that are used to compare values or find values that
match certain patterns. The following table contains a list of comparison operators in PowerShell.

All the operators listed in the table are case-insensitive. To make them case-sensitive, place a `c`
in front of the operator. For example, `-ceq` is the case-sensitive version of the equals (`-eq`)
comparison operator.

|    Operator    |                         Definition                          |
| -------------- | ----------------------------------------------------------- |
| `-eq`          | Equal to                                                    |
| `-ne`          | Not equal to                                                |
| `-gt`          | Greater than                                                |
| `-ge`          | Greater than or equal to                                    |
| `-lt`          | Less than                                                   |
| `-le`          | Less than or equal to                                       |
| `-Like`        | Match using the `*` wildcard character                      |
| `-NotLike`     | Doesn't match using the `*` wildcard character              |
| `-Match`       | Matches the specified regular expression                    |
| `-NotMatch`    | Doesn't match the specified regular expression              |
| `-Contains`    | Determines if a collection contains a specified value       |
| `-NotContains` | Determines if a collection doesn't contain a specific value |
| `-In`          | Determines if a specified value is in a collection          |
| `-NotIn`       | Determines if a specified value isn't in a collection       |
| `-Replace`     | Replaces the specified value                                |

Proper case "PowerShell" is equal to lower case "powershell" using the equals comparison operator.

```powershell
'PowerShell' -eq 'powershell'
```

```Output
True
```

It's not equal using the case-sensitive version of the equals comparison operator.

```powershell
'PowerShell' -ceq 'powershell'
```

```Output
False
```

The not equal comparison operator reverses the condition.

```powershell
'PowerShell' -ne 'powershell'
```

```Output
False
```

Greater than, greater than or equal to, less than, and less than or equal all work with string or
numeric values.

```powershell
5 -gt 5
```

```Output
False
```

Using greater than or equal to instead of greater than with the previous example returns the
**Boolean** true since five is equal to five.

```powershell
5 -ge 5
```

```Output
True
```

Based on the results from the previous two examples, you can probably guess how both less than and
less than or equal to work.

```powershell
5 -lt 10
```

```Output
True
```

The `-Like` and `-Match` operators can be confusing, even for experienced PowerShell users. `-Like`
is used with the wildcard characters `*` and `?` to perform "like" matches.

```powershell
'PowerShell' -like '*shell'
```

```Output
True
```

`-Match` uses a regular expression to perform the matching.

```powershell
'PowerShell' -match '^.*shell$'
```

```Output
True
```

Use the range operator to store the numbers 1 through 10 in a variable.

```powershell
$Numbers = 1..10
```

Determine if the `$Numbers` variable includes 15.

```powershell
$Numbers -contains 15
```

```Output
False
```

Determine if it includes the number 10.

```powershell
$Numbers -contains 10
```

```Output
True
```

`-NotContains` reverses the logic to see if the `$Numbers` variable doesn't contain a value.

```powershell
$Numbers -notcontains 15
```

The previous example returns the **Boolean** true because it's true that the `$Numbers` variable
doesn't contain 15.

```Output
True
```

It does, however, contain the number 10, so it's false when tested.

```powershell
$Numbers -notcontains 10
```

```Output
False
```

The `-in` comparison operator was first introduced in PowerShell version 3.0. It's used to determine
if a value is _in_ an array. The `$Numbers` variable is an array since it contains multiple values.

```powershell
15 -in $Numbers
```

```Output
False
```

In other words, `-in` performs the same test as the contains comparison operator except from the
opposite direction.

```powershell
10 -in $Numbers
```

```Output
True
```

Fifteen isn't in the `$Numbers` array, so false is returned in the following example.

```powershell
15 -in $Numbers
```

```Output
False
```

Just like the `-contains` operator, `not` reverses the logic for the `-in` operator.

```powershell
10 -notin $Numbers
```

The previous example returns false because the `$Numbers` array does include 10 and the condition
tests to determine if it doesn't contain 10.

```Output
False
```

Determine if fifteen isn't in the `$Numbers` array.

```powershell
15 -notin $Numbers
```

15 is "not in" the `$Numbers` array so it returns the **Boolean** true.

```Output
True
```

The `-replace` operator does just want you would think. It's used to replace something. Specifying
one value replaces that value with nothing. In the following example, you replace "Shell" with
nothing.

```powershell
'PowerShell' -replace 'Shell'
```

```Output
Power
```

If you want to replace a value with a different one, specify the new one after the pattern you want
to replace. SQL Saturday in Baton Rouge is an event I try to speak at every year. In the following
example, the word "Saturday" is replaced with the abbreviation "Sat".

```powershell
'SQL Saturday - Baton Rouge' -Replace 'saturday','Sat'
```

```Output
SQL Sat - Baton Rouge
```

There are also methods like **Replace()** that can be used to replace things similar to how the
replace operator works. However, the `-Replace` operator is case-insensitive by default, and the
**Replace()** method is case-sensitive.

```powershell
'SQL Saturday - Baton Rouge'.Replace('saturday','Sat')
```

Notice that the word "Saturday" isn't replaced. This is because it's specified in a different case
than the original.

```Output
SQL Saturday - Baton Rouge
```

When the word "Saturday" is specified in the same case as the original, the **Replace()** method
performs the replacement as expected.

```powershell
'SQL Saturday - Baton Rouge'.Replace('Saturday','Sat')
```

```Output
SQL Sat - Baton Rouge
```

Be careful when using methods to transform data because you can encounter unforeseen problems, such
as failing the _Turkey Test_. For an example, see my blog article,
[Using Pester to Test PowerShell Code with Other Cultures][pester-test-other-cultures]. I recommend
using operators instead of methods whenever possible to avoid these types of problems.

While the comparison operators can be used, as shown in the previous examples, I typically use them
with the `Where-Object` cmdlet to perform filtering.

## Summary

You learned several topics in this chapter, including Formatting Right, Aliases, Providers, and
Comparison Operators.

## Review

1. Why is it necessary to perform formatting as far to the right as possible?
1. How do you determine what the actual cmdlet is for the `%` alias?
1. Why shouldn't you use aliases in scripts you save or code you share with others?
1. Perform a directory listing on the drives that are associated with one of the registry providers.
1. What's one of the main benefits of using the replace operator instead of the replace method?

## References

- [Format-Table][format-table]
- [Format-List][format-list]
- [Format-Wide][format-wide]
- [about_Aliases][about-aliases]
- [about_Providers][about-providers]
- [about_Comparison_Operators][about-comparison-operators]
- [about_Arrays][about-arrays]

## Next steps

In the next chapter, you'll learn about flow control, scripting, loops, and conditional logic.

<!-- link references -->

[sql-server-powershell]: /sql/powershell/download-sql-server-ps-module
[format-table]: /powershell/module/microsoft.powershell.utility/format-table
[format-list]: /powershell/module/microsoft.powershell.utility/format-list
[format-wide]: /powershell/module/microsoft.powershell.utility/format-wide
[about-aliases]: /powershell/module/microsoft.powershell.core/about/about_aliases
[about-providers]: /powershell/module/microsoft.powershell.core/about/about_providers
[about-comparison-operators]: /powershell/module/microsoft.powershell.core/about/about_comparison_operators
[about-arrays]: /powershell/module/microsoft.powershell.core/about/about_arrays
[pester-test-other-cultures]: https://mikefrobbins.com/2015/10/22/using-pester-to-test-powershell-code-with-other-cultures/
