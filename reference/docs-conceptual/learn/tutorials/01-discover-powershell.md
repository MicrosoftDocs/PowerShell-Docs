---
title: Discover PowerShell
ms.date: 03/12/2021
ms.custom: chnoring
ms.reviewer: sewhee
description: Learn what PowerShell is and some essential commands used to discover more about PowerShell.
---

# Discover PowerShell

PowerShell is a command-line shell and a scripting language in one. PowerShell started out on
Windows. It was meant to help with task automation for administration tasks but has now grown to be
cross platform and can be used for a variety of tasks.

The thing that makes PowerShell unique is that accepts and returns .NET objects, rather than text.
This fact makes it easier to connect different commands in series, in a _pipeline_.

> [!NOTE]
> Pipelines will be covered more in detail in this tutorial series.

Even then, you might need to _massage_ the results a little.

## What can PowerShell  be used for?

Usage of PowerShell has grown since the days when it was Windows-only. It's still used for Windows
task automation, but today, you can use for a variety of tasks like:

- **Cloud management**. PowerShell can be used to manage cloud resources. For example, you can
  retrieve information about cloud resources, as well as update or deploy new resources.
- **CI/CD**. It can also be used as part of a Continuous Integration/Continuous Deployment pipeline.
- **Automate tasks for Active Directory and Exchange**. You can use it to automate almost any task
  on Windows like creating users in Active Directory and mailboxes in Exchange.

There are many more areas of usage but the list above gives you a hint that PowerShell has come a
long way.

## Who uses PowerShell?

PowerShell is very powerful and a lot of people, working in multitude of roles, can benefit from
using it. Traditionally, PowerShell has been used by the System Administrator role but is now being
used by people calling themselves DevOps, Cloud Ops, and even Developers.

## PowerShell cmdlets

PowerShell comes with hundreds of preinstalled commands. PowerShell command are called cmdlets;
pronounced as "command-lets".

The name of each cmdlet consists of a "Verb-Noun" pair; for example `Get-Process`. This naming
convention makes it easier to understand what the cmdlet does. It also make it easier to find the
command your looking for. When looking for a cmdlet to use, you can filter on the verb or noun.

### Using cmdlets to explore PowerShell

When you first pick up PowerShell, it might feel intimidating as there seems to be so much to learn.
However, PowerShell is designed to help you learn a little at a time, as you need it.

PowerShell includes cmdlets that help you discover PowerShell. Using these three cmdlets, you can
discover what commands available, what they do, and what types they operate on.

- `Get-Verb`. Running this command returns a list of verbs that most commands adhere to.
  Additionally, the response describes what these verbs does. As most commands follow this naming,
  it sets expectations on what a command does, which helps you select the appropriate command but
  also what to name a command, should you be creating one.
- `Get-Command`. This command retrieves a list of all commands installed on your machine.
- `Get-Member`. It operates on object based output and is able to discover what object, properties
  and methods are available for a command.
- `Get-Help`. Invoking this command with the name of a command as an argument displays a help page
  describing various parts of a command.

Using these commands, you can discover almost anything you need to know about PowerShell.

### Verb

_Verb_ is an important concept in PowerShell. It's a naming standard that most cmdlets follow. It's
also a naming standard you're expected to follow when you write your own commands. The idea is that
the _Verb_ says what you're trying to do, like read or maybe change data. PowerShell has a
standardized list of verbs. To get a full list of all possible verbs, use the `Get-Verb` cmdlet:

```powershell
Get-Verb
```

The output from running it, is a long list of verbs. What's informative about the response, is that
it also shows more context, what such a verb is meant to do. Here's the first row of the output:

```output
Verb        AliasPrefix Group          Description
----        ----------- -----          -----------
Add         a           Common         Adds a resource to a container, or attaches an item to ano…
```

## Find commands with Get-Command

The `Get-Command` cmdlet returns a list of all available commands that are installed on your system.
That list you get back, is quite large though. To make finding commands easier you can limit the
amount of information that comes back. You can filter the response using either parameters or by
using helper cmdlets.

### Filter on name

You can filter the output of `Get-Command`, using different parameters. Filtering this way, is about
querying a specific property on the command. The idea is that you specify what property you want to
filter against, and then you provide a string that you want to match against. You'll therefore get a
comparison that looks like this:

```powershell
Get-Command -Name '*Process'
```

At this point, the filtering is trying to do an exact matching against the provided string argument.
If you want to have more flexibility, in the comparison, you can use a wildcard `*`, that does
pattern matching. The following code would look for all commands, who's name ends with process:

Above, the parameter the `-Name` is used to filter. Apart from `-Name`, you can also filter on
`-ParameterName` and `-Type`, for example.

### Filtering on Noun and Verb

You've seen how you can filter on `-Name`, and that there are other parameters you can filter on as
well. Verb and noun is something you can filter on as well. Such filtering targets part of a
command's name.

- **Filter on verb**. The verb part of a command's name is the leftmost part. In the command
  `Get-Process`, the verb part is `Get`. To filter on th verb part, specify `-Verb` as a parameter
  like so:

   ```powershell
   Get-Command -Verb 'Get'
   ```

   The above command would list all the commands where the verb part is `Get`.

- **Filter on noun**. The rightmost part of a command is the noun part. Where verb should be among
  the verbs returned from invoking `Get-Verb`, a noun can be anything. In the command `Get-Process`,
  the noun part is `Process`. To filter on noun, specify `-Noun` as a parameter and a string
  argument, like so:

   ```powershell
   Get-Command -Noun U*
   ```

Only using the verb, or the noun, to filter on, might lead to a big result still. To narrow down
your search, it's good to combine the two parameters like the below example:

```powershell
Get-Command -Verb Get -Noun U*
```

The result of the above looks like so:

```output
CommandType     Name                         Version    Source
-----------     ----                         -------    ------
Cmdlet          Get-UICulture                7.0.0.0    Microsoft.PowerShell.Utility
Cmdlet          Get-Unique                   7.0.0.0    Microsoft.PowerShell.Utility
Cmdlet          Get-Uptime                   7.0.0.0    Microsoft.PowerShell.Utility
Cmdlet          Get-UsageAggregates          2.0.0      Az.Billing
```

Thereby, you narrowed down the output quite bit by knowing the verb and what it's called.

### Use helper cmdlets to filter results

Apart from using parameters to filter, you can also use commands to help you with this task. Here's
some commands that can act as filters:

- `Select-Object`. It's a very versatile command that helps you pick out specific properties from
  one or more objects. Additionally by using it's parameters you can limit the response you get
  back. Here's an example of `Select-Object` being used to ask for a limited number of records:

   ```powershell
   Get-Command | Select-Object -First 3
   ```

   The result from the above is the three first commands, counted from the top. The result looks
   like so:

   ```output
   CommandType     Name                                               Version    Source
   -----------     ----                                               -------    ------
   Alias           Add-AdlAnalyticsDataSource                         1.0.2      Az.DataLakeAnalytics
   Alias           Add-AdlAnalyticsFirewallRule                       1.0.2      Az.DataLakeAnalytics
   Alias           Add-AdlStoreFirewallRule                           1.3.0      Az.DataLakeStore
   ```

   It's worth looking into to this command further as it can do a lot more
   [docs Select-Object](/powershell/module/microsoft.powershell.utility/select-object)

- `Where-Object`. The where object helps you select objects from a collection based on the values
  of properties. The command takes an expression in which you are able to express what column/s you
  want to match against what values. To find all process object where the `ProcessName` starts with
  `p`, you could use `Where-Object` like so:

  ```powershell
  Get-Process | Where-Object {$_.ProcessName -Like "p*"}
  ```

  Above, the `Get-Process` cmdlet produces a collection of process objects. To filter down the
  response, you _pipe_ the command `Where-Object`. Piping means that two or more commands are
  connected via a pipe `|` character. The idea is that the output from one command serves as the
  input for the next command, as read from left to right. The `Where-Object` uses an expression to
  filter. The expression itself uses the `-Like` operator and string argument that is a wildcard
  expression.

## Explore objects with Get-Member

Once you've been able to locate the cmdlet you want, you want to know more about what it produces,
the output. The output is interesting for several reasons like:

- **Standalone**. You might run just one cmdlet and you want to display the output in some sort of
  report. The question to ask yourself is whether the command produces an output that works for you,
  or if you need to change it.
- **When used in a pipeline**. It's common in PowerShell to connect several commands in a pipeline,
  to fetch data, filter and finally to transform it. For a command to fit into a pipeline, you have
  to look at what input and output it produces. The idea is that the output of a command is used as
  the input of another command.

The `Get-Member` cmdlet displays the properties and methods of the result. Additionally it also show
the type of the object. Pipe the output you want to inspect to `Get-Member`.

```powershell
Get-Process | Get-Member
```

The result displays the returned type as `TypeName` and then all the properties and methods of the
object. Here's an excerpt of such a result:

```output
TypeName: System.Diagnostics.Process

Name        MemberType     Definition
----        ----------     ----------
Handles     AliasProperty  Handles = Handlecount
Name        AliasProperty  Name = ProcessName
```

An object usually has plenty of properties and methods, to more easily find what you're looking for,
you can filter the results. By using the parameter `-MemberType`, you can specify to, for example
see all the methods, like in the below example:

```powershell
Get-Process | Get-Member -MemberType Method
```

When you get a response back, PowerShell usually only displays a few properties. In the above
response, `Name`, `MemberType` and `Definition` was displayed. To change that display, you can use
the cmdlet `Select-Object`. `Select-Object` allows you to specify what columns you want to see. You
can either provide it with the name of the column, a comma separated list or a wildcard `*`. Here's
an example where `Select-Object` is used to retrieve `Name` and `Definition`:

```powershell
Get-Process | Get-Member | Select-Object Name, Definition
```

### Search by type

Another way to approach searching for the command you want, is by searching for commands all
operating on the same type. When you used `Get-Member`, you got the returned type as the first line
of the response like so:

```output
TypeName: System.Diagnostics.Process
```

You can now use this type and search for commands like so:

```powershell
Get-Command -ParameterType Process
```

The result from invoking the above is a list with commands that solely operates on the `Process`
type:

```output
CommandType     Name                         Version    Source
-----------     ----                         -------    ------
Cmdlet          Debug-Process                7.0.0.0    Microsoft.PowerShell.Managem…
Cmdlet          Enter-PSHostProcess          7.1.0.0    Microsoft.PowerShell.Core
Cmdlet          Get-Process                  7.0.0.0    Microsoft.PowerShell.Managem…
Cmdlet          Get-PSHostProcessInfo        7.1.0.0    Microsoft.PowerShell.Core
Cmdlet          Stop-Process                 7.0.0.0    Microsoft.PowerShell.Managem…
Cmdlet          Wait-Process                 7.0.0.0    Microsoft.PowerShell.Managem…
```

As you can see, knowing the type of a command, can greatly narrow down your search after commands
that might be interesting for you.

## Exercise - calling your first command

In this exercise, you'll learn how to run your first command.

1. Start a PowerShell console by typing `pwsh`:

   ```powershell
   pwsh
   ```

1. Run the following `$PSVersionTable.PSVersion`:

   ```powershell
   $PSVersionTable.PSVersion
   ```

   Your output looks similar to this:

   ```output
   Major  Minor  Patch  PreReleaseLabel BuildLabel
   -----  -----  -----  --------------- ----------
   7      1      0
   ```

   Congrats, you've successfully run your first command and was able to get information of what
   version of PowerShell is installed on your system.

## Exercise - find related commands

In this exercise your goal is to learn more about a command. In doing so you'll also find things
like what type it operates on and what other similar commands operate on that same type.

1. Ensure you have a started PowerShell shell
1. Run the the command `Get-Process`:

   ```powershell
   Get-Process | Get-Member | Select-Object TypeName -Unique
   ```

   Your output resembles this:

   ```output
   TypeName
   --------
   System.Diagnostics.Process
   --------
   ```

   What you're getting back, is a the types returned by the command `Get-Command`. At this point you
   can now find out what other command also operates on these types.

1. Run the command `Get-Command`:

   ```powershell
   Get-Command -ParameterType Process
   ```

   Your output resembles this:

   ```output
   CommandType     Name                         Version    Source
    -----------     ----                        -------    ------
    Cmdlet          Debug-Process               7.0.0.0    Microsoft.PowerShell.Managem…
    Cmdlet          Enter-PSHostProcess         7.1.0.0    Microsoft.PowerShell.Core
    Cmdlet          Get-Process                 7.0.0.0    Microsoft.PowerShell.Managem…
    Cmdlet          Get-PSHostProcessInfo       7.1.0.0    Microsoft.PowerShell.Core
    Cmdlet          Stop-Process                7.0.0.0    Microsoft.PowerShell.Managem…
    Cmdlet          Wait-Process                7.0.0.0    Microsoft.PowerShell.Managem…
   ```

   Congratulations, you've managed to find other commands that operates on the same type `Process`.
   Using `Get-Member` is a good starting point to understand what other commands you should check
   out next.

## Summary

In this first part, you learned what PowerShell is and what areas in can be used. You where then
taught about cmdlets and in particular `Get-Command`, `Get-Verb` and `Get-Member`. Knowing theses
cmdlets is important as it teaches you how to learn. In the next part, you'll learn how to use the
powerful help system.

### Additional resources

- [Get-Command](xref:Microsoft.PowerShell.Core.Get-Command)
- [Get-Member](xref:Microsoft.PowerShell.Utility.Get-Member)
