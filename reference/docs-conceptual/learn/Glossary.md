---
description: A glossary of PowerShell-related terminology.
ms.date: 06/11/2020
title: PowerShell Glossary
ms.custom: template-glossary-pattern
---
# PowerShell Glossary

This article lists common terms used to talk about PowerShell. It includes definitions and
guidelines such as capitalization.

## B

### Binary module

A PowerShell module whose root module is a binary (`.dll`) file. A binary module may or may not
include a module manifest.

## C

### Common Parameter

A parameter that's added to all cmdlets, advanced functions, and workflows by the PowerShell engine.

## D

### Dot source

In PowerShell, to start a command by typing a dot and a space before the command. Commands that are
dot sourced run in the current scope instead of in a new scope. Any variables, aliases, functions,
or drives that command creates are created in the current scope and are available to users when the
command is completed.

### Dynamic module

A module that exists only in memory. The New-Module and Import-PSSession cmdlets create dynamic
modules.

### Dynamic parameter

A parameter that's added to a PowerShell cmdlet, function, or script under certain conditions.
Cmdlets, functions, providers, and scripts can add dynamic parameters.

## F

### Formatting file

A PowerShell XML file that has the `.format.ps1xml` extension and that defines how PowerShell
displays an object based on its .NET Framework type.

## G

### Global session state

The session state that contains the data that's accessible to the user of a PowerShell session.

## H

### Host

The interface that the PowerShell engine uses to communicate with the user. For example, the host
specifies how prompts are handled between PowerShell and the user.

### Host application

A program that loads the PowerShell engine into its process and uses it to perform operations.

## I

### Input processing method

A method that a cmdlet can use to process the records it receives as input. The input processing
methods include the `BeginProcessing` method, the `ProcessRecord` method, the `EndProcessing`
method, and the `StopProcessing` method.

## M

### Manifest module

A PowerShell module that has a manifest and whose **RootModule** key is empty.

### Member-access enumeration

A PowerShell convenience feature to automatically enumerate items in a collection when using the
member-access operator (`.`).

### Module

A self-contained reusable unit that allows you to partition, organize, and abstract your PowerShell
code. A module can contain cmdlets, providers, functions, variables, and other types of resources
that can be imported as a single unit.

### Module manifest

A PowerShell data file (`.psd1`) that describes the contents of a module and that controls how a
module is processed.

### Module session state

The session state that contains the public and private data of a PowerShell module. The private data
in this session state isn't available to the user of a PowerShell session.

## N

### Non-terminating error

An error that doesn't stop PowerShell from continuing to process the command.

### Noun

The word that follows the hyphen in a PowerShell cmdlet name. The noun describes the resources upon
which the cmdlet acts.

## P

### Parameter set

A group of parameters that can be used in the same command to perform a specific action.

### Pipe

In PowerShell, to send the results of the preceding command as input to the next command in the
pipeline.

### Pipeline

A series of commands connected by pipeline operators (`|`). Each pipeline operator sends the results
of the preceding command as input to the next command.

### PowerShell cmdlet

A single command that participates in the pipeline semantics of PowerShell. This includes binary
(C#) cmdlets, advanced script functions, CDXML, and Workflows.

### PowerShell command

The elements in a pipeline that cause an action to be carried out. PowerShell commands are either
typed at the keyboard or invoked programmatically.

### PowerShell data file

A text file that has the `.psd1` file extension. PowerShell uses data files for various purposes
such as storing module manifest data and storing translated strings for script internationalization.

### PowerShell drive

A virtual drive that provides direct access to a data store. It can be defined by a PowerShell
provider or created at the command line. Drives created at the command line are session-specific
drives and are lost when the session is closed.

### Provider

A Microsoft .NET Framework-based program that makes the data in a specialized data store available
in PowerShell so that you can view and manage it.

### PSSession

A type of PowerShell session that's created, managed, and closed by the user.

## R

### Root module

The module specified in the RootModule key in a module manifest.

### Runspace

In PowerShell, the operating environment in which each command in a pipeline is executed.

## S

### Script block

In the PowerShell programming language, a collection of statements or expressions that can be used
as a single unit. A script block can accept arguments and return values.

### Script file

A file that has the `.ps1` extension and contains a script written in the PowerShell language.

### Script module

A PowerShell module whose root module is a script module (`.psm1`) file. A script module may include
a module manifest. The script defines the members that the script module exports.

### Shell

The command interpreter that's used to pass commands to the operating system.

### Switch parameter

A parameter that doesn't take an argument.

## T

### Terminating error

An error that stops PowerShell from processing the command.

### Transaction

An atomic unit of work. The work in a transaction must be completed as a whole. If any part of the
transaction fails, the entire transaction fails.

### Types file

A PowerShell XML file that has the `.ps1xml` extension and that extends the properties of Microsoft
.NET Framework types in PowerShell.

## V

### verb

The word that precedes the hyphen in a PowerShell cmdlet name. The verb describes the action that
the cmdlet performs.

## W

### Windows PowerShell ISE

The Integrated Scripting Environment (ISE) - A Windows PowerShell host application that enables you
to run commands and to write, test, and debug scripts in a friendly, syntax-colored,
Unicode-compliant environment.

### Windows PowerShell snap-in

A resource that defines a set of cmdlets, providers, and Microsoft .NET Framework types that can be
added to the Windows PowerShell environment.

### Windows PowerShell Workflow

A workflow is a sequence of programmed, connected steps that perform long-running tasks or require
the coordination of multiple steps across multiple devices or managed nodes. Windows PowerShell
Workflow lets IT pros and developers author sequences of multi-device management activities, or
single tasks within a workflow, as workflows. Windows PowerShell Workflow lets you adapt and run
both PowerShell scripts and XAML files as workflows.
