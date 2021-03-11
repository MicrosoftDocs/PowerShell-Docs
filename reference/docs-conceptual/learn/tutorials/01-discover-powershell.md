---
title: Discover PowerShell
ms.date: 02/19/2021
ms.custom: chnoring
ms.reviewer: sewhee
description: This is the introduction to the tutorial series PowerBytes, learn to conquer your problems, one PowerByte at a time. 
---

# Discover PowerShell

PowerShell is a command-line shell and a scripting language in one. PowerShell started out on Windows. It was meant to help with task automation for administration tasks but has now grown to be cross platform and can be used for a variety of tasks.

A thing that makes PowerShell unique, is that accepts and returns .NET objects over text. This fact makes it easier to connect different commands in series, in a so called pipeline.

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

When you first pick up PowerShell, it might feel intimidating as there seems to be so much to learn. However, PowerShell is designed to help you learn a little at a time, as you need it. 

PowerShell includes cmdlets that help you discover PowerShell. Using these three cmdlets, you can discover what
commands available, what they do, and what types they operate on.

- `Get-Command`. This command retrieves a list of all commands installed on your machine.
- `Get-Help`. By invoking this command, with the name of a command as an argument, you'll be shown a help page describing various parts of a command.
- `Get-Member`. It operates on object based output and is able to discover what object, properties and methods are available for a command.

Given these three commands, you can gradually find out what commands you have at your disposal and what they do.

## Find commands with Get-Command

By using cmdlet `Get-Command`, you will return a list of all available commands,  that are installed on your system. That list you get back, is quite large though. Additionally, it comes back alphabetically, sorted by command name. A question to ask yourself, is that what you want, or do you want it sorted on maybe noun instead, or maybe you want a grouped result?

There are couple of ways to manage the response you get back calling `Get-Command`:

- **limit number of records**. When calling `Get-Command`, the response is huge. To make this practical, to find the command/s you're looking for, you can limit the size that comes back. You can filter the response based on a property, you can also limit the number of records coming back. You can filter using either parameters or by using helper commandlets.

- **grouping and ordering**. It's possible to sort the result either in an ascending or a descending way. You can also group the results.

### Filter on parameters

You can filter the output of `Get-Command`, using different parameters. Filtering this way is about querying a specific property on the command. The idea is that you specify what property you want to filter against, and then you provide a string that you want to match against. You'll therefore get a comparison that looks like this:

```powershell
Get-Command -Parameter '<value of parameter>'
```

At this point, the filtering is trying to do an exact matching against the provided string argument. If you want to have more flexibility, in the comparison, you can use a wildcard `*`, that does pattern matching. The following code would look for all commands, who's name ends with process:

```powershell
Get-Command -Name '*Process'
```

Above, the parameter the `-Name` is used to filter. Apart from `-Name`, you can also filter on `-ParameterName` and `-Type`, for example.

### verb and noun

Verb and Noun are two important concepts in PowerShell. It's a naming standard that most commandlets follow. It's also a naming standard you're expected to follow, once you write your own commands. The idea is that the _verb_ says what you're trying to do, read data or maybe change it. To get a full list of all possible verbs, you can run `Get-Verb` like so:

```powershell
Get-Verb
```

The output from running it, is a long list of verbs. What's informative about the response, is that it also shows more context, what such a verb is meant to do. Here's the first row of the output:

```output
Verb        AliasPrefix Group          Description
----        ----------- -----          -----------
Add         a           Common         Adds a resource to a container, or attaches an item to ano…
```

The noun on the other hand, is context specific. Just know that the noun should be at the end of a commands name, like with the command `Get-Process`, for example. The noun is `Process`.

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

### Helper cmdlets

**Take n records**
-Last
-First <n records>
Get-Command | Select-Object -first 3

**select objects based on prop value**
Where-Object {expression}
Get-Process | Where-Object {$_.ProcessName -Match "^p.*"}

**Sorting**
Sort-Object -Descending // default sorts on name
Sort-Object -Property <property>
Get-Command | Select-Object -first 3 | Sort-Object -Descending

**Group by**
group by 

## Explore a command with Get-Member 

another way to approach your learning PS is to find related commands. related commands can be defined as commands operating on the same type. So how do we know that = get-member, gives us the type. once we have the type, we can use that as an argument when we use get-command

Get-Process | Get-Member # Process
Get-Process -ParameterType Process # shows all commands operating on that type

## Exercise - calling your first command

## Exercise 

Select a command we want to know more about
Inspect command and find type
Find related commands

## Summary
