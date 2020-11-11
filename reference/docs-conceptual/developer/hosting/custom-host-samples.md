---
ms.date: 09/13/2016
ms.topic: reference
title: Custom Host Samples
description: Custom Host Samples
---
# Custom Host Samples

This section includes sample code for writing a custom host. You can use Microsoft Visual Studio to create a console application and then copy the code from the topics in this section into your host application.

## In This Section

 [Host01 Sample](./host01-sample.md)
 This sample shows how to implement a host application that uses a basic custom host.

 [Host02 Sample](./host02-sample.md)
 This sample shows how to write a host application that uses the Windows PowerShell runtime along with a custom host implementation. The host application sets the host culture to German, runs the [Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) cmdlet and displays the results as you would see them using pwrsh.exe, and then prints out the current data and time in German.

 [Host03 Sample](./host03-sample.md)
 This sample shows how to build an interactive console-based host application that reads commands from the command line, executes the commands, and then displays the results to the console.

 [Host04 Sample](./host04-sample.md)
 This sample shows how to build an interactive console-based host application that reads commands from the command line, executes the commands, and then displays the results to the console. This host application also supports displaying prompts that allow the user to specify multiple choices.

 [Host05 Sample](./host05-sample.md)
 This sample shows how to build an interactive console-based host application that reads commands from the command line, executes the commands, and then displays the results to the console. This host application also supports calls to remote computers by using the [Enter-PsSession](/powershell/module/Microsoft.PowerShell.Core/Enter-PSSession) and [Exit-PsSession](/powershell/module/Microsoft.PowerShell.Core/Exit-PSSession) cmdlets

 [Host06 Sample](./host06-sample.md)
 This sample shows how to build an interactive console-based host application that reads commands from the command line, executes the commands, and then displays the results to the console. In addition, this sample uses the Tokenizer APIs to specify the color of the text that is entered by the user.

## See Also
