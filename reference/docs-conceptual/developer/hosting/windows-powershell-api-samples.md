---
ms.date: 09/13/2016
ms.topic: reference
title: Windows PowerShell API Samples
description: Windows PowerShell API Samples
---
# Windows PowerShell API Samples

This section includes sample code that shows how to create runspaces that restrict functionality, and how to asynchronously run commands by using a runspace pool to supply the runspaces. You can use Microsoft Visual Studio to create a console application and then copy the code from the topics in this section into your host application.

## In This Section

[PowerShell01 Sample](./windows-powershell01-sample.md)
This sample shows how to use an [System.Management.Automation.Runspaces.Initialsessionstate](/dotnet/api/System.Management.Automation.Runspaces.InitialSessionState) object to limit the functionality of a runspace. The output of this sample demonstrates how to restrict the language mode of the runspace, how to mark a cmdlet as private, how to add and remove cmdlets and providers, how to add a proxy command, and more.

[PowerShell02 Sample](./windows-powershell02-sample.md)
This sample shows how to run commands asynchronously by using the runspaces of a runspace pool. The sample generates a list of commands, and then runs those commands while the Windows PowerShell engine opens a runspace from the pool when it is needed.
