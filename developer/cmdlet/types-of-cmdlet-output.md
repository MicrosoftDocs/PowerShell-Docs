---
title: "Types of Cmdlet Output | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
helpviewer_keywords:
  - "cmdlets [PowerShell SDK], output"
ms.assetid: 547e6695-e936-4cac-a90b-417d0dab393d
caps.latest.revision: 12
---
# Types of Cmdlet Output

Windows PowerShellprovides several methods that can be called by cmdlets to generate output. Typically, these methods use a specific operation to write their output to a specific data stream, such as the success data stream or the error data stream. This topic describes the types of output and the methods used to generate them.

## Types of Output

Success output
Cmdlets can report success by returning an object that can be processed by the next command in the pipeline. To do this, the cmdlet calls the [System.Management.Automation.Cmdlet.Writeobject%28System.Object%29*](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject%28System.Object%29) method after the cmdlet has successfully performed its action. We recommend that you call this method instead of the [System.Management.Automation.Host.Pshostuserinterface.Writeline](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface.WriteLine) or [System.Console.Writeline](/dotnet/api/System.Console.WriteLine) methods.

You can provide a `PassThru` switch parameter for cmdlets that do not typically return objects. When the `PassThru` switch parameter is specified at the command line, the cmdlet is asked to return an object. For an example of a cmdlet that has a `PassThru` parameter, see [Add-History](/powershell/module/Microsoft.PowerShell.Core/Add-History).
You can provide a `PassThru` switch parameter for cmdlets that do not typically return objects. When the `PassThru` switch parameter is specified at the command line, the cmdlet is asked to return an object. For an example of a cmdlet that has a `PassThru` parameter, see [Add-History](/powershell/module/Microsoft.PowerShell.Core/Add-History).

Error output
Cmdlets can report errors. When a terminating error occurs, the cmdlet throws an exception. When a non-terminating error occurs, the cmdlet calls the [System.Management.Automation.Provider.Cmdletprovider.Writeerror](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteError) method to send an error record to the error data stream. For more information about error reporting, see [Windows PowerShell Error Reporting](./error-reporting-concepts.md).

Verbose output
Cmdlets can provide useful information to the user while the cmdlet is correctly processing records by calling the [System.Management.Automation.Cmdlet.Writeverbose*](/dotnet/api/System.Management.Automation.Cmdlet.WriteVerbose) method. This generates verbose messages that indicate how the action is proceeding.

By default, verbose messages are not displayed. However, the user can specify the `Verbose` parameter when the cmdlet is run to display these messages. `Verbose` is a common parameter that is available to all cmdlets.

Progress output
Cmdlets can provide progress information to the user when the cmdlet is performing tasks that take a long time to complete, such as copying a directory recursively. To do this, the cmdlet calls the [System.Management.Automation.Cmdlet.Writeprogress*](/dotnet/api/System.Management.Automation.Cmdlet.WriteProgress) method.

Debug output
Cmdlets can provide debug messages that are helpful when troubleshooting the cmdlet code. To do this the cmdlet calls the [System.Management.Automation.Cmdlet.Writedebug*](/dotnet/api/System.Management.Automation.Cmdlet.WriteDebug) method.

By default, debug messages are not displayed. However, the user can specify the `Debug` parameter when the cmdlet is run to display these messages. `Debug` is a common parameter that is available to all cmdlets.

Warning output
Cmdlets can display warning messages by calling the [System.Management.Automation.Cmdlet.Writewarning*](/dotnet/api/System.Management.Automation.Cmdlet.WriteWarning) method.

By default, warning messages are displayed. However, users can configure warning messages by using the `$WarningPreference` variable or by using the `Verbose` and `Debug` parameters when the cmdlet is called.

## Displaying Output to the User

For all write-method calls, with the exception of the [System.Management.Automation.Cmdlet.Writeobject*](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject) method, the display of the contents of these calls is determined by specific runtime variables. By using these variables, you can make the appropriate write call at the correct place in your code and not worry about when or if the output should be displayed.

## Accessing the Output Functionality of a Host Application

You can also design a cmdlet to directly access the output functionality of a host application through the Windows PowerShell runtime. Using the host APIs provided by Windows PowerShell instead of [System.Console](/dotnet/api/System.Console) or [System.Windows.Forms](/dotnet/api/System.Windows.Forms) ensures that your cmdlet will work with a variety of hosts, such as the powershell.exe console host, the powershell_ise.exe graphical host, the Windows PowerShell remoting host, and in 3rd party hosts.

## See Also

[Windows PowerShell Error Reporting](./error-reporting-concepts.md)

[Windows PowerShell Cmdlets](./cmdlet-overview.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
