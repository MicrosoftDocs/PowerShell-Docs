---
ms.date: 09/13/2016
ms.topic: reference
title: Windows PowerShell Programmer&#39;s Guide
description: Windows PowerShell Programmer&#39;s Guide
---
# Windows PowerShell Programmer&#39;s Guide

This programmer's guide is targeted at developers who are interested in providing a command-line
management environment for system administrators. Windows PowerShell provides a simple way for you
to build management commands that expose .NET objects, while allowing Windows PowerShell to do most
of the work for you.

In traditional command development, you are required to write a parameter parser, a parameter
binder, filters, and all other functionality exposed by each command. Windows PowerShell provides
the following to make it easy for you to write commands:

- A powerful Windows PowerShell runtime (execution engine) with its own parser and a mechanism for
  automatically binding command parameters.

- Utilities for formatting and displaying command results using a command line interpreter (CLI).

- Support for high levels of functionality (through Windows PowerShell providers) that make it easy
  to access stored data.

  At little cost, you can represent a .NET object by a rich command or set of commands that will
  offer a complete command-line experience to the administrator.

  The next section covers the key Windows PowerShell concepts and terms. Familiarize yourself with
  these concepts and terms before starting development.

## About Windows PowerShell

Windows PowerShell defines several types of commands that you can use in development. These commands
include: functions, filters, scripts, aliases, and executables (applications). The main command type
discussed in this guide is a simple, small command called a "cmdlet". Windows PowerShell furnishes a
set of cmdlets and fully supports cmdlet customization to suit your environment. The Windows
PowerShell runtime processes all command types just as it does cmdlets, using pipelines.

In addition to commands, Windows PowerShell supports various customizable Windows PowerShell
providers that make available specific sets of cmdlets. The shell operates within the Windows
PowerShell-provided host application (Windows PowerShell.exe), but it is equally accessible from a
custom host application that you can develop to meet specific requirements. For more information,
see [How Windows PowerShell Works](/previous-versions//ms714658(v=vs.85)).

### Windows PowerShell Cmdlets

A cmdlet is a lightweight command that is used in the Windows PowerShell environment. The Windows
PowerShell runtime invokes these cmdlets within the context of automation scripts that are provided
at the command line, and the Windows PowerShell runtime also invokes them programmatically through
Windows PowerShell APIs.

For more information about cmdlets, see [Writing a Windows PowerShell Cmdlet](../cmdlet/writing-a-windows-powershell-cmdlet.md).

### Windows PowerShell Providers

In performing administrative tasks, the user may need to examine data stored in a data store (for
example, the file system, the Windows Registry, or a certificate store). To make these operations
easier, Windows PowerShell defines a module called a Windows PowerShell provider that can be used to
access a specific data store, such as the Windows Registry. Each provider supports a set of related
cmdlets to give the user a symmetrical view of the data in the store.

Windows PowerShell provides several default Windows PowerShell providers. For example, the Registry
provider supports navigation and manipulation of the Windows Registry. Registry keys are represented
as items, and registry values are treated as properties.

If you expose a data store that the user will need to access, you might need to write your own
Windows PowerShell provider, as described in
[Creating Windows PowerShell Providers](./how-to-create-a-windows-powershell-provider.md). For more
information aboutWindows PowerShell providers, see
[How Windows PowerShell Works](/previous-versions//ms714658(v=vs.85)).

### Host Application

Windows PowerShell includes the default host application powershell.exe, which is a console
application that interacts with the user and hosts the Windows PowerShell runtime using a console
window.

Only rarely will you need to write your own host application for Windows PowerShell, although
customization is supported. One case in which you might need your own application is when you have a
requirement for a GUI interface that is richer than the interface provided by the default host
application. You might also want a custom application when you are basing your GUI on the command
line. For more information, see
[How to Create a Windows PowerShell Host Application](/powershell/scripting/developer/hosting/writing-a-windows-powershell-host-application).

### Windows PowerShell Runtime

The Windows PowerShell runtime is the execution engine that implements command processing. It
includes the classes that provide the interface between the host application and Windows PowerShell
commands and providers. The Windows PowerShell runtime is implemented as a runspace object for the
current Windows PowerShell session, which is the operational environment in which the shell and the
commands execute. For operational details, see
[How Windows PowerShell Works](/previous-versions//ms714658(v=vs.85)).

### Windows PowerShell Language

The Windows PowerShell language provides scripting functions and mechanisms to invoke commands. For
complete scripting information, see the Windows PowerShell Language Reference shipped with Windows
PowerShell.

### Extended Type System (ETS)

Windows PowerShell provides access to a variety of different objects, such as .NET and XML objects.
As a consequence, to present a common abstraction for all object types the shell uses its extended
type system (ETS). Most ETS functionality is transparent to the user, but the script or .NET
developer uses it for the following purposes:

- Viewing a subset of the members of specific objects. Windows PowerShell provides an "adapted" view
  of several specific object types.

- Adding members to existing objects.

- Access to serialized objects.

- Writing customized objects.

  Using ETS, you can create flexible new "types" that are compatible with the Windows PowerShell
  language. If you are a .NET developer, you are able to work with objects using the same semantics
  as the Windows PowerShell language applies to scripting, for example, to determine if an object
  evaluates to `true`.

  For more information about ETS and how Windows PowerShell uses objects, see
  [Windows PowerShell Object Concepts](/powershell/scripting/learn/understanding-important-powershell-concepts).

## Programming for Windows PowerShell

Windows PowerShell defines its code for commands, providers, and other program modules using the
.NET Framework. You are not confined to the use of Microsoft Visual Studio in creating customized
modules for Windows PowerShell, although the samples provided in this guide are known to run in this
tool. You can use any .NET language that supports class inheritance and the use of attributes. In
some cases, Windows PowerShell APIs require the programming language to be able to access generic
types.

## Programmer's Reference

For reference when developing for Windows PowerShell, see the
[Windows PowerShell SDK](../windows-powershell-reference.md).

## Getting Started Using Windows PowerShell

For more information about starting to use the Windows PowerShell shell, see the
[Getting Started with Windows PowerShell](/powershell/scripting/getting-started/getting-started-with-windows-powershell)
shipped with Windows PowerShell. A Quick Reference tri-fold document is also supplied as a primer
for cmdlet use.

## Contents of This Guide

|Topic|Definition|
|-----------|----------------|
|[How to Create a Windows PowerShell Provider](./how-to-create-a-windows-powershell-provider.md)|This section describes how to build a Windows PowerShell provider for Windows PowerShell.|
|[How to Create a Windows PowerShell Host Application](/powershell/scripting/developer/hosting/writing-a-windows-powershell-host-application)|This section describes how to write a host application that manipulates a runspace and how to write a host application that implements its own custom host.|
|[How to Create a Windows PowerShell Snap-in](../cmdlet/how-to-create-a-windows-powershell-snap-in.md)|This section describes how to create a snap-in that is used to register all cmdlets and providers in an assembly and how to create a custom snap-in.|
|[How to Create a Console Shell](./how-to-create-a-console-shell.md)|This section describes how to create a console shell that is not extensible.|
|[Windows PowerShell Concepts](./windows-powershell-concepts.md)|This section contains conceptual information that will help you understand Windows PowerShell from the viewpoint of a developer.|

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)
