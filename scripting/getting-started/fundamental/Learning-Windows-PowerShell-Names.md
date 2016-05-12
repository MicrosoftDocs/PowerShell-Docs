---
title:  Learning Windows PowerShell Names
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  b4d0fd22-8298-4ee6-82ae-9b6f2907c986
---

# Learning Windows PowerShell Names
Learning names of commands and command parameters is a significant time investment with most command\-line interfaces. The issue is that there are very few patterns, so the only way to learn is by memorizing each command and each parameter that you need to use on a regular basis.

When you work with a new command or parameter, you cannot generally use what you already know; you have to find and learn a new name. If you look at how interfaces grow from a small set of tools with incremental additions to functionality, it is easy to see why the structure is nonstandard. With command names in particular, this may sound logical since each command is a separate tool, but there is a better way to handle command names.

Most commands are built to manage elements of the operating system or applications, such as services or processes. The commands have a variety of names that may or may not fit into a family. For example, on Windows systems, you can use the **net start** and **net stop** commands to start and stop a service. There is another more generalized service control tool for Windows that has a completely different name, **sc**, that does not fit into the naming pattern for the **net** service commands. For process management, Windows has the **tasklist** command to list processes and the **taskkill** command to kill processes.

Commands that take parameters have irregular parameter specifications. You cannot use the **net start** command to start a service on a remote computer. The **sc** command will start a service on a remote computer, but to specify the remote computer, you must prefix its name with a double backslash. For example, to start the spooler service on a remote computer named DC01, you would type **sc \\\\DC01 start spooler**. To list tasks running on DC01, you need to use the **\/S** (for "system") parameter and supply the name DC01 without backslashes, like this: **tasklist \/S DC01**.

Although there are important technical distinctions between a service and a process, they are both examples of manageable elements on a computer that have a well\-defined life cycle. You may want to start or stop a service or process, or get a list of all currently running services or processes. In other words, although a service and a process are different things, the actions we perform on a service or a process are often conceptually the same. Furthermore, choices we may make to customize an action by specifying parameters may be conceptually similar as well.

Windows PowerShell exploits these similarities to reduce the number of distinct names you need to know to understand and use cmdlets.

### Cmdlets Use Verb\-Noun Names to Reduce Command Memorization
Windows PowerShell uses a "verb\-noun" naming system, where each cmdlet name consists of a standard verb hyphenated with a specific noun. Windows PowerShell verbs are not always English verbs, but they express specific actions in Windows PowerShell. Nouns are very much like nouns in any language, they describe specific types of objects that are important in system administration. It is easy to demonstrate how these two\-part names reduce learning effort by looking at a few examples of verbs and nouns.

Nouns are less restricted, but they should always describe what a command acts upon. Windows PowerShell has commands such as **Get\-Process**, **Stop\-Process**, **Get\-Service**, and **Stop\-Service**.

In the case of two nouns and two verbs, consistency does not simplify learning that much. However, if you look at a standard set of 10 verbs and 10 nouns, you then have only 20 words to understand, but those words can be used to form 100 distinct command names.

Frequently, you can recognize what a command does by reading its name, and it is usually apparent what name should be used for a new command. For example, a computer shutdown command might be **Stop\-Computer**. A command that lists all computers on a network might be **Get\-Computer**. The command that gets the system date is **Get\-Date**.

You can list all commands that include a particular verb with the **\-Verb** parameter for **Get\-Command** (We will discuss **Get\-Command** in detail in the next section). For example, to see all cmdlets that use the verb **Get**, type:

```
PS> Get-Command -Verb Get
CommandType     Name                            Definition
-----------     ----                            ----------
Cmdlet          Get-Acl                         Get-Acl [[-Path] <String[]>]...
Cmdlet          Get-Alias                       Get-Alias [[-Name] <String[]...
Cmdlet          Get-AuthenticodeSignature       Get-AuthenticodeSignature [-...
Cmdlet          Get-ChildItem                   Get-ChildItem [[-Path] <Stri...
...
```

The **\-Noun** parameter is even more useful because it allows you to see a family of commands that affect the same type of object. For example, if you want to see which commands are available for managing services, type following command:

```
PS> Get-Command -Noun Service
CommandType     Name                            Definition
-----------     ----                            ----------
Cmdlet          Get-Service                     Get-Service [[-Name] <String...
Cmdlet          New-Service                     New-Service [-Name] <String>...
Cmdlet          Restart-Service                 Restart-Service [-Name] <Str...
Cmdlet          Resume-Service                  Resume-Service [-Name] <Stri...
Cmdlet          Set-Service                     Set-Service [-Name] <String>...
Cmdlet          Start-Service                   Start-Service [-Name] <Strin...
Cmdlet          Stop-Service                    Stop-Service [-Name] <String...
Cmdlet          Suspend-Service                 Suspend-Service [-Name] <Str... 
...
```

A command is not necessarily a cmdlet, just because it has a verb\-noun naming scheme. One example of a native Windows PowerShell command that is not a cmdlet but has a verb\-noun name, is the command for clearing a console window, Clear\-Host. The Clear\-Host command is actually an internal function, as you can see if you run Get\-Command against it:

```
PS> Get-Command -Name Clear-Host

CommandType     Name                            Definition
-----------     ----                            ----------
Function        Clear-Host                      $spaceType = [System.Managem...
```

### Cmdlets Use Standard Parameters
As noted earlier, commands used in traditional command\-line interfaces do not generally have consistent parameter names. Sometimes parameters do not have names at all. When they do, they are often single\-character or abbreviated words that can be typed rapidly but are not easily understood by new users.

Unlike most other traditional command\-line interfaces, Windows PowerShell processes parameters directly, and it uses this direct access to the parameters along with developer guidance to standardize parameter names. Although this does not guarantee that every cmdlet will always conform to the standards, it does encourage it.

> [!NOTE]
> Parameter names always have a '\-' prepended to them when you use them, to allow Windows PowerShell to clearly identify them as parameters. In the **Get\-Command \-Name Clear\-Host** example, the parameter's name is **Name**, but it is entered as \-**Name**.

Here are some of the general characteristics of the standard parameter names and usages.

#### The Help Parameter (?)
When you specify the **\-?** parameter to any cmdlet, the cmdlet is not executed. Instead, Windows PowerShell displays help for the cmdlet.

#### Common Parameters
Windows PowerShell has several parameters known as *common parameters*. Because these parameters are controlled by the Windows PowerShell engine, whenever they are implemented by a cmdlet, they will always behave the same way. The common parameters are **WhatIf**, **Confirm**, **Verbose**, **Debug**, **Warn**, **ErrorAction**, **ErrorVariable**, **OutVariable**, and **OutBuffer**.

#### Suggested Parameters
The Windows PowerShell core cmdlets use standard names for similar parameters. Although the use of parameter names is not enforced, there is explicit guidance for usage to encourage standardization.

For example, the guidance recommends naming a parameter that refers to a computer by name as **ComputerName**, rather than Server, Host, System, Node, or other common alternative words. Among the important suggested parameter names are **Force**, **Exclude**, **Include**, **PassThru**, **Path**, and **CaseSensitive**.

