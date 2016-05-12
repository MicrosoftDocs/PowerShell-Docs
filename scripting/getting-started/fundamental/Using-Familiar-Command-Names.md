---
title:  Using Familiar Command Names
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  021e2424-c64e-4fa5-aa98-aa6405758d5d
---

# Using Familiar Command Names
Using a mechanism called *aliasing*, Windows PowerShell allows users to refer to commands by alternate names. Aliasing allows users with experience in other shells to reuse common command names that they already know to perform similar operations in Windows PowerShell. Although we will not discuss Windows PowerShell aliases in detail, you can still use them as you get started with Windows PowerShell.

Aliasing associates a command name that you type with another command. For example, Windows PowerShell has an internal function named **Clear\-Host** that clears the output window. If you type either the **cls** or **clear** command at a command prompt, Windows PowerShell interprets that this is an alias for the **Clear\-Host** function and runs the **Clear\-Host** function.

This feature helps users to learn Windows PowerShell. First, most Cmd.exe and UNIX users have a large repertoire of commands that users already know by name, and although the Windows PowerShell equivalents may not produce identical results, they are close enough in form that users can use them to do work without having to first memorize the Windows PowerShell names. Second, the major source of frustration in learning a new shell when the user is already familiar with another shell, is the errors that are caused by "finger memory". If you have used Cmd.exe for years, when you have a screen full of output and want to clean it up, you would reflexively type the **cls** command and press the ENTER key. Without the alias to the **Clear\-Host** function in Windows PowerShell, you would simply get the error message "**'cls' is not recognized as a cmdlet, function, operable program, or script file.**" and be left with no idea of what to do to clear the output.

The following is a brief listing of the common Cmd.exe and UNIX commands that you can use inside Windows PowerShell:

|||||
|-|-|-|-|
|cat|dir|mount|rm|
|cd|echo|move|rmdir|
|chdir|erase|popd|sleep|
|clear|h|ps|sort|
|cls|history|pushd|tee|
|copy|kill|pwd|type|
|del|lp|r|write|
|diff|ls|ren||

If you find yourself using one of these commands reflexively and want to learn the real name of the native Windows PowerShell command, you can use the **Get\-Alias** command:

```
PS> Get-Alias cls

CommandType     Name                            Definition
-----------     ----                            ----------
Alias           cls                             Clear-Host
```

To make examples more readable, the Windows PowerShell User's Guide generally avoids using aliases. However, knowing more about aliases this early can still be useful if you are working with arbitrary snippets of Windows PowerShell code from another source or want to define your own aliases. The rest of this section will discuss standard aliases and how to define your own aliases.

### Interpreting Standard Aliases
Unlike the aliases described above, which were designed for name\-compatibility with other interfaces, the aliases built into Windows PowerShell are generally designed for brevity. These shorter names can be typed quickly, but are impossible to read if you do not know what they refer to.

Windows PowerShell tries to compromise between clarity and brevity by providing a set of standard aliases that are based on shorthand names for common verbs and nouns. This allows a core set of aliases for common cmdlets that are readable when you know the shorthand names. For example, in standard aliases the verb **Get** is abbreviated to **g**, the verb **Set** is abbreviated to **s**, the noun **Item** is abbreviated to **i**, the noun **Location** is abbreviated to **l**, and the noun Command is abbreviated to **cm**.

Here is a brief example to illustrate how this works. The standard alias for Get\-Item comes from combining **g** for Get and **i** for Item: **gi**. The standard alias for Set\-Item comes from combining **s** for Set and **i** for Item: **si**. The standard alias for Get\-Location comes from combining **g** for Get and **l** for Location, **gl**. The standard alias for Set\-Location comes from combining **s** for Set and **l** for Location, **sl**. The standard alias for Get\-Command comes from combining **g** for Get and **cm** for Command, **gcm**. There is no Set\-Command cmdlet, but if there were, we would be able to guess that the standard alias comes from **s** for Set and **cm** for Command: **scm**. Furthermore, people familiar with Windows PowerShell aliasing who encounter **scm** would be able to guess that the alias refers to Set\-Command.

### Creating New Aliases
You can create your own aliases using the Set\-Alias cmdlet. For example, the following statements create the standard cmdlet aliases discussed in Interpreting Standard Aliases:

```
Set-Alias -Name gi -Value Get-Item
Set-Alias -Name si -Value Set-Item
Set-Alias -Name gl -Value Get-Location
Set-Alias -Name sl -Value Set-Location
Set-Alias -Name gcm -Value Get-Command
```

Internally, Windows PowerShell uses commands like these during startup, but these aliases are not changeable. If you attempt to actually execute one of these commands, you will get an error explaining that the alias cannot be modified. For example:

<pre>PS> Set-Alias -Name gi -Value Get-Item
Set-Alias : Alias is not writeable because alias gi is read-only or constant and cannot be written to.
At line:1 char:10
+ Set-Alias  <<<< -Name gi -Value Get-Item</pre>

