---
title:  Getting Information About Commands
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  56f8e5b4-d97c-4e59-abbe-bf13e464eb0d
---

# Getting Information About Commands
The Windows PowerShell **Get\-Command** cmdlet gets all commands that are available in your current session. When you type **Get\-Command** at a Windows PowerShell prompt, you will see output similar to the following:

```
PS> Get-Command
CommandType     Name                            Definition
-----------     ----                            ----------
Cmdlet          Add-Content                     Add-Content [-Path] <String[...
Cmdlet          Add-History                     Add-History [[-InputObject] ...
Cmdlet          Add-Member                      Add-Member [-MemberType] <PS...
...
```

This output looks a lot like the Help output of Cmd.exe: a tabular summary of internal commands. In the excerpt of the **Get\-Command** command output shown above, every command shown has a CommandType of Cmdlet. A cmdlet is Windows PowerShell's intrinsic command type – a type that corresponds roughly to the **dir** and **cd** commands of Cmd.exe and to built\-ins in UNIX shells such as BASH.

In the output of the **Get\-Command** command, all the definitions end with ellipses (...) to indicate that PowerShell cannot display all the content in the available space. When Windows PowerShell displays output, it formats the output as text and then arranges it to make the data fit cleanly into the window. We will talk about this later in the section on formatters.

The **Get\-Command** cmdlet has a **Syntax** parameter that gets the syntax of each cmdlet. To get the syntax of the Get\-Help cmdlet, use the following command:

**Get\-Command Get\-Help \-Syntax**

```
Get-Help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>] [-Functionality <String[]>]
 [-Role <String[]>] [-Full] [-Online] [-Verbose] [-Debug] [-ErrorAction <ActionPreference>] [-WarningAction <ActionPreference>] [-ErrorVariable <String>] [-WarningVariable <String>] [-OutVariable <String>] [-OutBuffer <Int32>]

Get-Help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>] [-Functionality <String[]>]
 [-Role <String[]>] [-Detailed] [-Online] [-Verbose] [-Debug] [-ErrorAction <ActionPreference>] [-WarningAction <ActionPreference>] [-ErrorVariable <String>] [-WarningVariable <String>] [-OutVariable <String>] [-OutBuffer <Int32>]

Get-Help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>] [-Functionality <String[]>]
 [-Role <String[]>] [-Examples] [-Online] [-Verbose] [-Debug] [-ErrorAction <ActionPreference>] [-WarningAction <ActionPreference>] [-ErrorVariable <String>] [-WarningVariable <String>] [-OutVariable <String>] [-OutBuffer <Int32>]

Get-Help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>] [-Functionality <String[]>]
 [-Role <String[]>] [-Parameter <String>] [-Online] [-Verbose] [-Debug] [-ErrorAction <ActionPreference>] [-WarningAction <ActionPreference>] [-ErrorVariable <String>] [-WarningVariable <String>] [-OutVariable <String>] [-OutBuffer <Int32>]
```

### Displaying Available Command Types
The **Get\-Command** command does not list every command that is available in Windows PowerShell. Instead, the **Get\-Command** command lists only the cmdlets in the current session. Windows PowerShell actually supports several other types of commands. Aliases, functions, and scripts are also Windows PowerShell commands, although they are not discussed in detail in the Windows PowerShell User's Guide. External files that are executable, or have a registered file type handler, are also classified as commands.

To get all commands in the session, type:

```
Get-Command *
```

Because this list includes external files in your search path, it may contain thousands of items. It is more useful to look at a reduced set of commands.

To get native commands of other types, use the **CommandType** parameter of the **Get\-Command** cmdlet.

> [!NOTE]
> The asterisk (\*) is used for wildcard matching in Windows PowerShell command arguments. The \* means "match one or more of any characters". You can type **Get\-Command a\&#42;** to find all commands that begin with the letter "a". Unlike wildcard matching in Cmd.exe, Windows PowerShell's wildcard will also match a period.

To get command aliases, which are the assigned nicknames of commands, type:

```
Get-Command -CommandType Alias
```

To get the functions in the current session, type:

```
Get-Command -CommandType Function
```

To display scripts in Windows PowerShell's search path, type:

```
Get-Command -CommandType Script
```

