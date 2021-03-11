---
title: Discover PowerShell
ms.date: 02/19/2021
ms.custom: chnoring
ms.reviewer: sewhee
description: This is the introduction to the tutorial series PowerBytes, learn to conquer your problems, one PowerByte at a time. 
---

# Discover PowerShell

PowerShell is a command-line shell and a scripting language in one. PowerShell started out on Windows. It was meant to help with task automation for administration tasks but has now grown to be cross platform and can be used for a variety of tasks.

A thing that makes PowerShell unique, is that it accepts and returns .NET objects over text, in most cases. This fact makes it easier to connect different commands in series, in a so called pipeline.

> [!NOTE]
> Pipelines will be covered more in detail in a future post in this tutorial series.

Even then, you might need to _massage_ the results a little.

## What can you use it for

PowerShell has grown its usage areas from the days when it was Windows-only. It's still used for task automation in general, but the areas where it can be used has grown. Today, you can use for a variety of tasks like:

- **Cloud management**. PowerShell can be used to manage cloud resources. You can for example read information on your cloud resources as well as deploy your resources and much more.
- **CI/CD**. It can also be used as part of a CI/CD pipeline.
- **Automate tasks is active directory and exchange**. You can use it to automate almost any task on a Windows machine like active directory and exchange.

There are many more areas of usage but the above is to give you a hint that PowerShell has come a long way.

## Who uses PowerShell

PowerShell is very powerful and a lot of people working in  multitude of roles can benefit from using it. Traditionally, PowerShell has been used by people with the SysOps role but is now being used by people calling themselves DevOps, Cloud Ops and even Developers, to mention some.

## Cmdlets, compiled commands

Upon install, you get a lot of commands installed. Commands, in PowerShell, are called cmdlets, it's pronounced as "command-let".

Every cmdlet is built up of a verb and a noun. This convention makes it easier to understand what it does. Additionally, that fact also make it easier to find the command your looking for, as you can filter on verb and noun, when looking for a specific cmdlet to use. A typical cmdlet therefore has the following naming convention "Verb-Noun", with an example being `Get-Process`.

### Core cmdlets

When you first pick up PowerShell, it might feel intimidating as there seem to be so much to learn. However, PowerShell is meant to be learned little at a time. Having that mindset going forward, lets you take one problem at a time.

Something that will help you on your journey, are the so called _core cmdlets_, commands that helps you discover PowerShell. Using the mentioned _core cmdlets_ you can discover what commands there are, what they do, and what types they operate on. Let's list the core cmdlets below:

- `Get-Command`. This command retrieves a list of all commands installed on your machine.
- `Get-Help`. By invoking this command, with the name of a command as an argument, you'll be shown a help page describing various parts of a command.

   > [!NOTE]
   > `Get-Help` will covered in the next part in this series

- `Get-Member`. It operates on object based output and is able to discover what object, properties and methods are available for a command.

Given these three commands, you can gradually find out what commands you have at your disposal and what they do.

## Find commands with Get-Command

By using cmdlet `Get-Command`, you will return a list of all available commands,  that are installed on your system. That list you get back, is quite large though. Additionally, it comes back alphabetically, sorted by command name. A question to ask yourself, is that what you want, or do you want it sorted on maybe noun instead, or maybe you want a grouped result?

There are couple of ways to manage the response you get back calling `Get-Command`:

- **limit number of records**. When calling `Get-Command`, the response is huge. To make this practical, to find the command/s you're looking for, you can limit the size that comes back. You can filter the response based on a property, you can also limit the number of records coming back. You can filter using either parameters or by using helper commandlets.

- **grouping and ordering**. It's possible to sort the result either in an ascending or a descending way. You can also group the results.

### Filter on parameters

You can filter the output of `Get-Command`, using different parameters. Filtering this way, is about querying a specific property on the command. The idea is that you specify what property you want to filter against, and then you provide a string that you want to match against. You'll therefore get a comparison that looks like this:

```powershell
Get-Command -Parameter '<value of parameter>'
```

At this point, the filtering is trying to do an exact matching against the provided string argument. If you want to have more flexibility, in the comparison, you can use a wildcard `*`, that does pattern matching. The following code would look for all commands, who's name ends with process:

```powershell
Get-Command -Name '*Process'
```

Above, the parameter the `-Name` is used to filter. Apart from `-Name`, you can also filter on `-ParameterName` and `-Type`, for example.

### Verb and noun

Verb and Noun are two important concepts in PowerShell. It's a naming standard that most cmdlets follow. It's also a naming standard you're expected to follow, once you write your own commands. The idea is that the _verb_ says what you're trying to do, read data or maybe change it. To get a full list of all possible verbs, you can run `Get-Verb` like so:

```powershell
Get-Verb
```

The output from running it, is a long list of verbs. What's informative about the response, is that it also shows more context, what such a verb is meant to do. Here's the first row of the output:

```output
Verb        AliasPrefix Group          Description
----        ----------- -----          -----------
Add         a           Common         Adds a resource to a container, or attaches an item to ano…
```

The noun on the other hand, is context specific. Know that the noun should be at the end of a commands name, like with the command `Get-Process`, for example. The noun is `Process`.

Nouns and verbs can be used as parameters, when you call `Get-Command`. Thereby, they can be used to filter a response. Here's an example where `-Noun` is used:

```powershell
Get-Command -Noun Process
```

with a resulting list, only containing commands whose noun part equals `Process`:

```output
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Debug-Process                                      7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Get-Process                                        7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Start-Process                                      7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Process                                       7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Wait-Process                                       7.0.0.0    Microsoft.PowerShell.Management
```

### Helper cmdlets, that helps with filtering

Apart from using parameters to filter, you can also use commands to help you with this task. Here's some commands that can act as filters:

- **Select-Object**. It's a very versatile command that helps you pick out specific properties from one or more objects. Additionally by using it's parameters you can limit the response you get back. Here's an example of `Select-Object` being used to ask for a limited number of records:

   ```powershell
   Get-Command | Select-Object -First 3
   ```

   The result from the above is the three first commands, counted from the top. The result looks like so:

   ```outline
   CommandType     Name                                               Version    Source
   -----------     ----                                               -------    ------
   Alias           Add-AdlAnalyticsDataSource                         1.0.2      Az.DataLakeAnalytics
   Alias           Add-AdlAnalyticsFirewallRule                       1.0.2      Az.DataLakeAnalytics
   Alias           Add-AdlStoreFirewallRule                           1.3.0      Az.DataLakeStore
   ```

   It's worth looking into to this command further as it can do a lot more [docs Select-Object](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-object?view=powershell-7.1)

- **Where-Object**. The where object helps you select objects from a collection based on the values of properties. The command takes an expression in which you are able to express what column/s you want to match against what values. To find all process object where the `ProcessName` starts with `p`, you could use `Where-Object` like so:

  ```powershell
  Get-Process | Where-Object {$_.ProcessName -Match "^p.*"}
  ```

  Above, the `Get-Process` command produces a collection of process objects. To filter down the response, you _pipe_ the command `Where-Object`. Piping means that two or more commands are connected via a pipe `|` character. The idea is that the output from one command serves as the input for the next command, as read from left to right. The `Where-Object` uses an expression to filter. As can be seen by the use of curly brackets **{}**. The expression itself uses the `-Match` operator and string argument that is a regular expression.

## Explore a command with Get-Member

Once you've been able to locate the command you want, you want to know more about what it produces, the output. The output is interesting for several reasons like:

- **Standalone**. You might run just one command and you want to for example display the output in some sort of report. The question to ask yourself is wether the command produces an output that works for you, or if you need to change it.
- **When used in a pipeline**. It's common in PowerShell to connect several commands in a pipeline, to fetch data, filter and finally to transform it. For a command to fit into a pipeline, you have to look at what input and output it produces. The idea is that the output of a command is used as the input of another command.

To discover the output of a command, you can use the cmdlet `Get-Member`. The command displays the properties and methods of the result. Additionally it also show the type of the object. To use `Get-Member` you need to _pipe_ it with the command you want to know more about, like so:

```powershell
Get-Process | Get-Member
```

The result will first display the returned type as `TypeName` and then all the properties and methods of the object. Here's an excerpt of such a result:

```output
TypeName: System.Diagnostics.Process

Name                       MemberType     Definition
----                       ----------     ----------
Handles                    AliasProperty  Handles = Handlecount
Name                       AliasProperty  Name = ProcessName
```

An object usually has plenty of properties and methods, to more easily find what you're looking for, you can filter the results. By using the parameter `-MemberType`, you can specify to, for example see all the methods, like in the below example:

```powershell
Get-Process | Get-Member -MemberType Method
```

When you get a response back, PowerShell usually only displays a few properties. In the above response, `Name`, `MemberType` and `Definition` was displayed. To change that display, you can use the cmdlet `Select-Object`. `Select-Object` allows you to specify what columns you want to see. You can either provide it with the name of the column, a comma separated list or a wildcard `*`. Here's an example where `Select-Object` is used to retrieve `Name` and `Definition`:

```powershell
Get-Process | Get-Member | Select-Object Name, Definition
```

### Search by type

Another way to approach searching for the command you want, is by searching for commands all operating on the same type. When you used `Get-Member`, you got the returned type as the first line of the response like so:

```output
TypeName: System.Diagnostics.Process
```

You can now use this type and search for commands like so:

```powershell
Get-Command -ParameterType Process
```

The result from invoking the above is a list with commands that solely operates on the `Process` type:

```output
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Debug-Process                                      7.0.0.0    Microsoft.PowerShell.Managem…
Cmdlet          Enter-PSHostProcess                                7.1.0.0    Microsoft.PowerShell.Core
Cmdlet          Get-Process                                        7.0.0.0    Microsoft.PowerShell.Managem…
Cmdlet          Get-PSHostProcessInfo                              7.1.0.0    Microsoft.PowerShell.Core
Cmdlet          Stop-Process                                       7.0.0.0    Microsoft.PowerShell.Managem…
Cmdlet          Wait-Process                                       7.0.0.0    Microsoft.PowerShell.Managem…
```

As you can see, knowing the type of a command, can greatly narrow down your search after commands that might be interesting for you.

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

   Congrats, you've successfully run your first command and was able to get information of what version of PowerShell is installed on your system.

## Exercise - find related commands

In this exercise your goal is to learn more about a command. In doing so you'll also find things like what type it operates on and what other similar commands operate on that same type.

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

   What you're getting back, is a the types returned by the command `Get-Command`. At this point you can now find out what other command also operates on these types.

1. Run the command `Get-Command`:

   ```powershell
   Get-Command -ParameterType Process
   ```

   Your output resembles this:

   ```output
   CommandType     Name                                               Version    Source
    -----------     ----                                               -------    ------
    Cmdlet          Debug-Process                                      7.0.0.0    Microsoft.PowerShell.Managem…
    Cmdlet          Enter-PSHostProcess                                7.1.0.0    Microsoft.PowerShell.Core
    Cmdlet          Get-Process                                        7.0.0.0    Microsoft.PowerShell.Managem…
    Cmdlet          Get-PSHostProcessInfo                              7.1.0.0    Microsoft.PowerShell.Core
    Cmdlet          Stop-Process                                       7.0.0.0    Microsoft.PowerShell.Managem…
    Cmdlet          Wait-Process                                       7.0.0.0    Microsoft.PowerShell.Managem…
   ```

   Congrats, you've managed to find other commands that operates on the same type `Process`. Using `Get-Member`, is a good starting point to understand what other commands you should check out next.

## Summary

In this first part, you learned what PowerShell is and what areas in can be used. You where then taught about cmdlets and in particular the so called _core cmdlets_. Knowing the core cmdlets is important as it teaches you how to learn. Out of the the three core cmdlets, you were taught to use `Get-Command` and `Get-Member`. In the next part, you'll learn how to use the powerful help system. 