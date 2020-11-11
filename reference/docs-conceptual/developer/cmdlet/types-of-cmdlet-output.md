---
ms.date: 01/18/2019
ms.topic: reference
title: Types of Cmdlet Output
description: Types of Cmdlet Output
---

# Types of cmdlet output

PowerShell provides several methods that can be called by cmdlets to generate output. These methods
use a specific operation to write their output to a specific data stream, such as the success data
stream or the error data stream. This article describes the types of output and the methods used to
generate them.

## Types of output

### Success output

Cmdlets can report success by returning an object that can be processed by the next command in the
pipeline. After the cmdlet has successfully performed its action, the cmdlet calls the
[System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject)
method. We recommend that you call this method instead of the
[System.Console.WriteLine](/dotnet/api/System.Console.WriteLine) or
[System.Management.Automation.Host.PSHostUserInterface.WriteLine](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface.WriteLine)
methods.

You can provide a **PassThru** switch parameter for cmdlets that do not typically return objects.
When the **PassThru** switch parameter is specified at the command line, the cmdlet is asked to
return an object. For an example of a cmdlet that has a **PassThru** parameter, see
[Add-History](/powershell/module/Microsoft.PowerShell.Core/Add-History).

### Error output

Cmdlets can report errors. When a terminating error occurs, the cmdlet throws an exception. When a
non-terminating error occurs, the cmdlet calls the
[System.Management.Automation.Provider.CmdletProvider.WriteError](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.WriteError)
method to send an error record to the error data stream. For more information about error
reporting, see [Error Reporting Concepts](./error-reporting-concepts.md).

### Verbose output

Cmdlets can provide useful information to you while the cmdlet is correctly processing records by
calling the
[System.Management.Automation.Cmdlet.WriteVerbose](/dotnet/api/System.Management.Automation.Cmdlet.WriteVerbose)
method. The method generates verbose messages that indicate how the action is proceeding.

By default, verbose messages are not displayed. You can specify the **Verbose** parameter when the
cmdlet is run to display these messages. **Verbose** is a common parameter that is available to all
cmdlets.

### Progress output

Cmdlets can provide progress information to you when the cmdlet is performing tasks that take a
long time to complete, such as copying a directory recursively. To display progress information the
cmdlet calls the
[System.Management.Automation.Cmdlet.WriteProgress](/dotnet/api/System.Management.Automation.Cmdlet.WriteProgress)
method.

### Debug output

Cmdlets can provide debug messages that are helpful when troubleshooting the cmdlet code. To
display debug information the cmdlet calls the
[System.Management.Automation.Cmdlet.WriteDebug](/dotnet/api/System.Management.Automation.Cmdlet.WriteDebug)
method.

By default, debug messages are not displayed. You can specify the **Debug** parameter when the
cmdlet is run to display these messages. **Debug** is a common parameter that is available to all
cmdlets.

### Warning output

Cmdlets can display warning messages by calling the
[System.Management.Automation.Cmdlet.WriteWarning](/dotnet/api/System.Management.Automation.Cmdlet.WriteWarning)
method.

By default, warning messages are displayed. However, you can configure warning messages by using
the `$WarningPreference` variable or by using the **Verbose** and **Debug** parameters when the
cmdlet is called.

## Displaying output

For all write-method calls, the content display is determined by specific runtime variables. The
exception is the
[System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject)
method. By using these variables, you can make the appropriate write call at the correct place in
your code and not worry about when or if the output should be displayed.

## Accessing the output functionality of a host application

You can also design a cmdlet to directly access the output functionality of a host application
through the PowerShell runtime. Using the host APIs provided by PowerShell instead of
[System.Console](/dotnet/api/System.Console) or
[System.Windows.Forms](/dotnet/api/System.Windows.Forms) ensures that your cmdlet will work with a
variety of hosts. For example: the **powershell.exe** console host, the **powershell_ise.exe**
graphical host, the PowerShell remoting host, and third-party hosts.

## See also

[Error Reporting Concepts](./error-reporting-concepts.md)

[Cmdlet Overview](./cmdlet-overview.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
