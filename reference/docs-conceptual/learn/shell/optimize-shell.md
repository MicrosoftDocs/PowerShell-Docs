---
description: >
  This article provides an overview of the shell features that help users improve
  their user experience.
title: Optimizing your shell experience
ms.date: 7/14/2022
---
# Optimizing your shell experience

PowerShell is a command-line shell and a scripting language used for automation.

[Wikipedia][wiki] includes the following description of a shell:

> A shell manages the user-system interaction by prompting users for input, interpreting their
> input, and then handling output from the underlying operating system (much like a read-eval-print
> loop or [REPL][REPL]).

Similar to other shells like `bash` or `cmd.exe`, PowerShell allows you to run any command available
on your system, not just PowerShell commands.

PowerShell commands are known as _cmdlets_ (pronounced command-lets). Cmdlets are PowerShell
commands, not stand-alone executables. PowerShell commands can't be run in other shells without
running PowerShell first.

## Features of the PowerShell command-line interface

PowerShell is a modern command shell that includes the best features of other popular shells. Unlike
most shells that only accept and return text, PowerShell accepts and returns .NET objects. The shell
has several features that you can use to optimize your interactive user experience.

- Robust command-line [history][history]
- [Tab completion][tab] and [command prediction][prediction]
- Supports command and parameter [aliases][aliases]
- [Pipeline][Pipeline] for chaining commands
- In-console [help][help] system, similar to Unix `man` pages

<!-- link reference -->
[aliases]: /powershell/module/microsoft.powershell.core/about/about_aliases
[help]: dynamic-help.md
[history]: /powershell/module/microsoft.powershell.core/about/about_history
[Pipeline]: /powershell/module/microsoft.powershell.core/about/about_pipelines
[prediction]: using-predictors.md
[REPL]: https://wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop
[tab]: tab-completion.md
[wiki]: https://wikipedia.org/wiki/Shell_(computing)#Overview
