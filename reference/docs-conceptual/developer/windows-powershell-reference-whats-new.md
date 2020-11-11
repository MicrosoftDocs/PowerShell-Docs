---
ms.date: 09/13/2016
ms.topic: reference
title: Windows PowerShell Reference - What's New
description: Windows PowerShell Reference - What's New
---
# What's New

Windows PowerShell 2.0 provides the following new features for use when writing cmdlets, providers,
and host applications.

## Modules

You can now package and distribute Windows PowerShell solutions by using modules. Modules allow you
to partition, organize, and abstract your Windows PowerShell code into self-contained, reusable
units. For more information about modules, see Writing a Windows PowerShell Module.

## The PowerShell class

The PowerShell class provides a simpler solution for creating applications, referred to as host
applications, that programmatically run commands. This class allows you to create a pipeline of
commands, specify the runspace that is used to run the commands, and specify invoking the commands
synchronously or asynchronously.

## The RunspacePool class

Runspace pools allow you to create multiple runspaces by using a single call. The
CreateRunspacePool method provides several overloads that can be used to create runspaces that have
the same features, such as the same host, initial session state, and connection information.

## The InitialSessionState class

The InitialSessionState class allows you to create a session state configuration that is used when
a runspace is opened. You can create a custom configuration, a default configuration that includes
the commands provided by mshshort, and a configuration whose commands are restricted based on the
capabilities of the session.

## Remote runspaces

You can now create runspaces that can be opened on remote computers, allowing you to run commands
on the remote machine and collect the results locally. To create a remote runspace, you must
specify information about the remote connection when creating the runspace. See the CreateRunspace
and CreateRunspacePool methods for examples. The connection information is defined by the
RunspaceConnectionInfo class.

## Private runspace elements

You can now create runspaces whose elements are public or private. This allows you to create
runspaces whose elements are available to the runspace, but are not available to the user. See the
ConstrainedSessionStateEntry class to find out which elements of the runspace can be made private.

## Runspace threading modes and apartment state

You can now specify how threads are created and used when running commands in a runspace. See the
System.Management.Automation.Runspaces.Runspace.ThreadOptions and
System.Management.Automation.Runspaces.RunspacePool.ThreadOptions properties.

You can now get the apartment state of the threads that are used to run commands in a runspace. See
the System.Management.Automation.Runspaces.Runspace.ApartmentState and
System.Management.Automation.Runspaces.RunspacePool.ApartmentState properties.

## Transaction cmdlets

You can now create cmdlets that can be used within a transaction. When a cmdlet is used in a
transaction, its actions are temporary, and they can be accepted or rejected by the transaction
cmdlets provided by Windows PowerShell.

For more information about transactions, see How to Support Transactions.

## Transaction provider

You can now create providers that can be used within a transaction. Similar to cmdlets, when a
provider is used in a transaction, its actions are temporary, and they can be accepted or rejected
by the transaction cmdlets provided by Windows PowerShell.

For more information about specifying support for transaction within a provider class, see the
System.Management.Automation.Provider.CmdletProviderAttribute.ProviderCapabilities property.

## Job cmdlets

You can now write cmdlets that can perform their action as a job. These jobs are run in the
background without interacting with the current session. For more information about how Windows
PowerShell supports jobs, see Background Jobs.

## Cmdlet output types

You can now specify the .NET Framework types that are returned by your cmdlets by declaring the
OutputType attribute when writing your cmdlets. This will allow others to determine what type of
objects are returned by a cmdlet by looking at the OutputType property of the cmdlet.

## Event support

You can now write cmdlets that add and consume events. See the PSEvent class.

## Proxy commands

You can now write proxy commands that can be used to run another command. A proxy command allows
you to control what functionality of the source cmdlet is available to the user. For example, you
can create a proxy command that removes a parameter that is supplied by the source command. See the
ProxyCommand class.

## Multiple choice prompts

You can now write applications that can provide prompts that allow the user to select multiple
choices. See the IHostUISupportsMultipleChoiceSelection interface

## Interactive sessions

You can now write applications that can start and stop an interactive session on a remote computer.
See the IHostSupportsInteractiveSession interface.

## Custom Cmdlet Help for Providers

You can now create customized Help topics for the provider cmdlets. Custom cmdlet help topics can
explain how the cmdlet works in the provider path and document special features, including the
dynamic parameters that the provider adds to the cmdlet.
