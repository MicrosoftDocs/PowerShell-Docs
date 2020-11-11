---
ms.date: 09/13/2016
ms.topic: reference
title: Runspace Samples
description: Runspace Samples
---
# Runspace Samples

This section includes sample code that shows how to use different types of runspaces to run commands synchronously and asynchronously. You can use Microsoft Visual Studio to create a console application and then copy the code from the topics in this section into your host application.

## In This Section

> [!NOTE]
> For samples of host applications that create custom host interfaces, see [Custom Host Samples](./custom-host-samples.md).

 [Runspace01 Sample](./runspace01-sample.md)
 This sample shows how to use the [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) class to run the [Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) cmdlet synchronously and display its output in a console window.

 [Runspace02 Sample](./runspace02-sample.md)
 This sample shows how to use the [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) class to run the [Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) and [Sort-Object](/powershell/module/Microsoft.PowerShell.Utility/Sort-Object) cmdlets synchronously. The results of these commands is displayed by using a [System.Windows.Forms.Datagridview](/dotnet/api/System.Windows.Forms.DataGridView) control.

 [Runspace03 Sample](./runspace03-sample.md)
 This sample shows how to use the [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) class to run a script synchronously, and how to handle non-terminating errors. The script receives a list of process names and then retrieves those processes. The results of the script, including any non-terminating errors that were generated when running the script, are displayed in a console window.

 [Runspace04 Sample](./runspace04-sample.md)
 This sample shows how to use the [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) class to run commands, and how to catch terminating errors that are thrown when running the commands. Two commands are run, and the last command is passed a parameter argument that is not valid. As a result no objects are returned and a terminating error is thrown.

 [Runspace05 Sample](./runspace05-sample.md)
 This sample shows how to add a snap-in to an [System.Management.Automation.Runspaces.Initialsessionstate](/dotnet/api/System.Management.Automation.Runspaces.InitialSessionState) object so that the cmdlet of the snap-in is available when the runspace is opened. The snap-in provides a Get-Proc cmdlet (defined by the [GetProcessSample01 Sample](../cmdlet/getprocesssample01-sample.md)) that is run synchronously using a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object.

 [Runspace06 Sample](./runspace06-sample.md)
 This sample shows how to add a module to an [System.Management.Automation.Runspaces.Initialsessionstate](/dotnet/api/System.Management.Automation.Runspaces.InitialSessionState) object so that the module is loaded when the runspace is opened. The module provides a Get-Proc cmdlet (defined by the [GetProcessSample02 Sample](../cmdlet/getprocesssample02-sample.md)) that is run synchronously using a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object.

 [Runspace07 Sample](./runspace07-sample.md)
 This sample shows how to create a runspace, and then use that runspace to run two cmdlets synchronously by using a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object.

 [Runspace08 Sample](./runspace08-sample.md)
 This sample shows how to add commands and arguments to the pipeline of a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object and how to run the commands synchronously.

 [Runspace09 Sample](./runspace09-sample.md)
 This sample shows how to add a script to the pipeline of a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object and how to run the script asynchronously. Events are used to handle the output of the script.

 [Runspace10 Sample](./runspace10-sample.md)
 This sample shows how to create a default initial session state, how to add a cmdlet to the [System.Management.Automation.Runspaces.Initialsessionstate](/dotnet/api/System.Management.Automation.Runspaces.InitialSessionState), how to create a runspace that uses the initial session state, and how to run the command by using a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object.

 [Runspace11 Sample](./runspace11-sample.md)
 This shows how to use the [System.Management.Automation.Proxycommand](/dotnet/api/System.Management.Automation.ProxyCommand) class to create a proxy command that calls an existing cmdlet, but restricts the set of available parameters. The proxy command is then added to an initial session state that is used to create a constrained runspace. This means that the user can access the functionality of the cmdlet only through the proxy command.

## See Also
