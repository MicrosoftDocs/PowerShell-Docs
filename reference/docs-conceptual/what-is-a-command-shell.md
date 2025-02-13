---
title: What is a command shell?
ms.date: 02/13/2025
description: This article explains the difference between command shells, command-line tools, and terminals.
---
# What is a command shell?

Many people use the terms _command shell_, _command-line tool_, and _terminal_ interchangeably,
which can be confusing. This article explains the difference between these concepts and provides
examples of each.

A **command shell** is an interactive command-line interface for managing a computer, also known as a
**Read-Eval-Print Loop** ([REPL][14]).

A shell takes input from the keyboard, evaluates that input, and executes the input as a shell
command or forwards the input to the operating system to be executed. Most shells can also read
commands from a script file, and can include programming features like variables, flow control, and
functions.

## Types of command shells

There are two main types of command shells:

- General purpose command shells

  General purpose command shells provide are designed to work with the operating system and allow
  you to run any command that the operating system supports. They also include shell-specific
  commands and programming features. The following list contains some examples of general purpose
  command shells:

  - [PowerShell][16]
  - [Windows Command Shell][06]
  - [bash][15] - popular on Linux
  - [zsh][12] - popular on macOS

- Utility command shells

  Utility command shells are designed to work with specific applications or services. These shells
  can only run commands that are specific to the application or service. Some utility shells support
  running commands from a batch script, but don't include programming features. Usually, these
  shells can only be used interactively.

  - [AI Shell][04] - An interactive-only shell used to communicate with AI services such as Azure
    OpenAI.
  - [netsh][07] - Network shell (netsh) is a command-line utility that allows you to configure and
    display the status of various network components on Windows. It's both a command-line tool and a
    command shell. It also supports running commands from a script file.

## Command-line tools

A **command-line tool** is a standalone program that you run from a command shell. Command-line
tools are typically designed to perform a specific task, such as managing files, configuring
settings, or querying for information. Command-line tools can be used in any shell that supports
running external programs.

- [Azure CLI][02] - a collection of command-line tools for managing Azure resources that can be run
  in any supported shell.
- [Azure PowerShell][03] - a collection of PowerShell modules for managing Azure resources that can
  be run in any supported version of PowerShell.
- [OpenSSH for Windows][05] - includes a command-line client and a server that provides secure
  communication over a network.
- [Windows Commands][08] - a collection of command-line tools that are built into Windows.

In general, command-line tools don't provide a command shell (REPL) interface. The `netsh` command
in Windows is an exception, as it's both a command-line tool and an interactive command shell.

## Terminals

A **terminal** is an application that provides a text-based window for hosting command shells. Some
terminals are designed to work with a specific shell, while others can host multiple shells. They
can also include advanced features such as:

- Ability to create multiple panes within a single window
- Ability to create multiple tabs to host multiple shells
- Ability to change color schemes and fonts
- Support for copy and paste operations

The following list contains some examples of terminal applications:

- [Windows Terminal][10] - a modern terminal application for Windows that can host multiple shells.
- [Windows Console Host][09] - the default host application on Windows for text-based applications.
  It can also host the Windows Command Shell or PowerShell.
- [Terminal for macOS][13] - the default terminal application on macOS that can host the bash or zsh
  shell.
- [iTerm2 for macOS][11] - a popular 3rd-party terminal application for macOS.
- [Azure Cloud Shell][01] - a browser-based terminal application hosted in Microsoft Azure. Azure
  Cloud shell gives you the choice of using bash or PowerShell. Each shell comes preconfigured with
  many command-line tools for managing Azure resources.

<!-- link references -->
[01]: /azure/cloud-shell/overview
[02]: /cli/azure
[03]: /powershell/azure
[04]: /powershell/utility-modules/aishell/overview
[05]: /windows-server/administration/openssh/openssh-overview
[06]: /windows-server/administration/windows-commands/cmd
[07]: /windows-server/administration/windows-commands/netsh
[08]: /windows-server/administration/windows-commands/windows-commands
[09]: /windows/console/consoles
[10]: /windows/terminal
[11]: https://iterm2.com/
[12]: https://support.apple.com/102360
[13]: https://support.apple.com/guide/terminal/welcome/mac
[14]: https://wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop
[15]: https://www.gnu.org/software/bash/
[16]: overview.md
