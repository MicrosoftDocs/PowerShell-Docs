---
ms.date: 09/13/2016
ms.topic: reference
title: Windows PowerShell Session State
description: Windows PowerShell Session State
---
# Windows PowerShell Session State

Session state refers to the current configuration of a Windows PowerShell session or module. A Windows PowerShell session is the operational environment that is used interactively by the command-line user or programmatically by a host application. The session state for a session is referred to as the global session state.

From a developer perspective, a Windows PowerShell session refers to the time between when a host application opens a Windows PowerShell runspace and when it closes the runspace. Looked at another way, the session is the lifetime of an instance of the Windows PowerShell engine that is invoked while the runspace exists.

## Module Session State

Module session states are created whenever the module or one of its nested modules is imported into the session. When a module exports an element such as a cmdlet, function, or script, a reference to that element is added to the global session state of the session. However, when the element is run, it is executed within the session state of the module.

## Session-State Data

Session state data can be public or private. Public data is available to calls from outside the session state while private data is available only to calls from within the session state. For example, a module can have a private function that can be called only by the module or only internally by a public element that has been exported. This is similar to the private and public members of a .NET Framework type.

Session-state data is stored by the current instance of the execution engine within the context of the current Windows PowerShell session. Session-state data consists of the following items:

- Path information

- Drive information

- Windows PowerShell provider information

- Information about the imported modules and references to the module elements (such as cmdlets, functions, and scripts) that are exported by the module. This information and these references are for the global session state only.

- Session-state variable information

## Accessing Session-State Data Within Cmdlets

Cmdlets can access session-state data either indirectly through the [System.Management.Automation.PSCmdlet.Sessionstate*](/dotnet/api/System.Management.Automation.PSCmdlet.SessionState) property of the cmdlet class or directly through the [System.Management.Automation.Sessionstate](/dotnet/api/System.Management.Automation.SessionState) class. The [System.Management.Automation.Sessionstate](/dotnet/api/System.Management.Automation.SessionState) class provides properties that can be used to investigate different types of session-state data.

## See Also

[System.Management.Automation.PSCmdlet.Sessionstate](/dotnet/api/System.Management.Automation.PSCmdlet.SessionState)

[System.Management.Automation.Sessionstate?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.SessionState)

[Windows PowerShell Cmdlets](./cmdlet-overview.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell Shell SDK](../windows-powershell-reference.md)
