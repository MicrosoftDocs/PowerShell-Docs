---
ms.date: 09/13/2016
ms.topic: reference
title: Creating Runspaces
description: Creating Runspaces
---
# Creating Runspaces

A runspace is the operating environment for the commands that are invoked by a host application. This environment includes the commands and data that are currently present, and any language restrictions that currently apply.

 Host applications can use the default runspace that is provided by Windows PowerShell, which includes all available core commands, or create a custom runspace that includes only a subset of the available commands. To create a customized runspace, you create an [System.Management.Automation.Runspaces.Initialsessionstate](/dotnet/api/System.Management.Automation.Runspaces.InitialSessionState) object and assign it to your runspace.

## Runspace tasks

1. [Creating an InitialSessionState](./creating-an-initialsessionstate.md)

2. [Creating a constrained runspace](./creating-a-constrained-runspace.md)

3. [Creating multiple runspaces](./creating-multiple-runspaces.md)

## See Also
