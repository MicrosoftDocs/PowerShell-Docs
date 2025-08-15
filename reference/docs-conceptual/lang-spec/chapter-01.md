---
description: This Language Specification describe the syntax, semantics, and behavior of the PowerShell language.
ms.date: 01/08/2025
title: Windows PowerShell Language Specification 3.0
---
# Windows PowerShell Language Specification 3.0

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

## 1. Introduction

PowerShell is a command-line *shell* and scripting language, designed especially for system
administrators.

Most shells operate by executing a command or utility in a new process, and presenting the results
to the user as text. These shells also have commands that are built into the shell and run in the
shell process. Because there are few built-in commands, many utilities have been created to
supplement them. PowerShell is very different. Instead of processing text, the shell processes
objects. PowerShell also includes a large set of built-in commands with each having a consistent
interface and these can work with user-written commands.

An *object* is a data entity that has *properties* (i.e., characteristics) and *methods* (i.e.,
actions that can be performed on the object). All objects of the same type have the same base set of
properties and methods, but each *instance* of an object can have different property values.

A major advantage of using objects is that it is much easier to *pipeline* commands; that is, to
write the output of one command to another command as input. (In a traditional command-line
environment, the text output from one command needs to be manipulated to meet the input format of
another.)

PowerShell includes a very rich scripting language that supports constructs for looping, conditions,
flow-control, and variable assignment. This language has syntax features and keywords similar to
those used in the C# programming language ([§C.][§C.]).

There are four kinds of commands in PowerShell: scripts, functions and methods, cmdlets, and native
commands.

- A file of commands is called a *script*. By convention, a script has a filename extension of .ps1.
  The top-most level of a PowerShell program is a script, which, in turn, can invoke other commands.

- PowerShell supports modular programming via named procedures. A procedure written in PowerShell is
  called a *function*, while an external procedure made available by the execution environment (and
  typically written in some other language) is called a *method*.

- A *cmdlet* (pronounced "command-let") is a simple, single-task command-line tool. Although a
  cmdlet can be used on its own, the full power of cmdlets is realized when they are used in
  combination to perform complex tasks.

- A *native command* is part of the host environment.

Each time the PowerShell runtime environment begins execution, it begins what is called a *session*.
Commands then execute within the context of that session.

This specification defines the PowerShell language, the built-in cmdlets, and the use of objects via
the pipeline.

Unlike most shells, which accept and return text, Windows PowerShell is built on top of the .NET
Framework common language runtime (CLR) and the .NET Framework, and accepts and returns .NET
Framework objects.

<!-- reference links -->
[§C.]: chapter-16.md
