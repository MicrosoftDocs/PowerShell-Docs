---
ms.date: 03/30/2020
ms.topic: reference
title: Installing the Windows PowerShell SDK
description: Installing the Windows PowerShell SDK
---
# Installing the Windows PowerShell SDK

Applies To: Windows PowerShell 2.0, Windows PowerShell 3.0

The following topic describes how to install the PowerShell SDK on different versions of Windows.

## Installing Windows PowerShell 3.0 SDK for Windows 8 and Windows Server 2012

Windows PowerShell 3.0 is automatically installed with Windows 8 and Windows Server 2012. In
addition, you can download and install the reference assemblies for Windows PowerShell 3.0 as part
of the Windows 8 SDK. These assemblies allow you to write cmdlets, providers, and host programs for
Windows PowerShell 3.0. When you install the Windows SDK for Windows 8, the Windows PowerShell
assemblies are automatically installed in the reference assembly folder, in `\Program Files
(x86)\Reference Assemblies\Microsoft\WindowsPowerShell\3.0`. For more information, see the Windows 8
SDK download site. Windows PowerShell code samples are also available in the
[powershell-sdk-samples](https://github.com/MicrosoftDocs/powershell-sdk-samples/tree/master/SDK-3.0)
repository.

## Installing Windows PowerShell 3.0 SDK for Windows 7 and Windows Server 2008 R2

Windows 7 and Windows Server 2008 R2 automatically have PowerShell 2.0 installed. In addition, you
can install PowerShell 3.0 on these systems. You can also install the Windows 8 SDK on Windows 7 and
Windows Server 2008 R2 as described above.

## Installing Windows PowerShell 2.0 SDK for Windows 7, Vista, XP, Server 2003, and Server 2008

The Windows PowerShell 2.0 SDK provides the reference assemblies needed to write cmdlets, providers,
and hosting applications, and it provides C# sample code that can be used as the starting point when
you begin writing code. You can download the code samples from
[https://www.microsoft.com/download/details.aspx?id=2560](https://www.microsoft.com/download/details.aspx?id=2560).

### Reference assemblies

Reference assemblies are installed in the following location by default: `c:\Program Files\Reference
Assemblies\Microsoft\WindowsPowerShell\V1.0`.

> [!NOTE]
> Code that is compiled against the Windows PowerShell 2.0 assemblies cannot be loaded into Windows
> PowerShell 1.0 installations. However, code that is compiled against the Windows PowerShell 1.0
> assemblies can be loaded into Windows PowerShell 2.0 installations.

### Samples

Code samples are installed in the following location by default: `C:\Program Files\Microsoft
SDKs\Windows\v7.0\Samples\sysmgmt\WindowsPowerShell\`. The following sections provide a brief
description of what each sample does.

#### Cmdlet samples

- GetProcessSample01 - Shows how to write a simple cmdlet that gets all the processes on the local
  computer.
- GetProcessSample02 - Shows how to add parameters to the cmdlet. The cmdlet takes one or more
  process names and returns the matching processes.
- GetProcessSample03 - Shows how to add parameters that accept input from the pipeline.
- GetProcessSample04 - Shows how to handle non-terminating errors.
- GetProcessSample05 - Shows how to display a list of specified processes.
- SelectObject - Shows how to write a filter to select only certain objects.
- SelectString - Shows how to search files for specified patterns.
- StopProcessSample01 - Shows how to implement a PassThru parameter, and how to request user
  feedback by calls to the ShouldProcess and ShouldContinue methods. Users specify the PassThru
  parameter when they want to force the cmdlet to return an object,
- StopProcessSample02 - Shows how to stop a specific process.
- StopProcessSample03 - Shows how to declare aliases for parameters and how to support wildcards.
- StopProcessSample04 - Shows how to declare parameter sets, the object that the cmdlet takes as
  input, and how to specify the default parameter set to use.

#### Remoting samples

- RemoteRunspace01 - Shows how to create a remote runspace that is used to establish a remote
  connection.
- RemoteRunspacePool01 - Shows how to construct a remote runspace pool and how to run multiple
  commands concurrently by using this pool.
- Serialization01 - Shows how to look at an existing .NET class and make sure that information from
  selected public properties of this class is preserved across serialization/deserialization.
- Serialization02 - Shows how to look at an existing .NET class and make sure that information from
  instance of this class is preserved across serialization/deserialization when the information is
  not available in public properties of the class.
- Serialization03 - Shows how to look at an existing .NET class and make sure that instances of this
  class and of derived classes are deserialized (rehydrated) into live .NET objects.

#### Event samples

- Event01 - Shows how to create a cmdlet for event registration by deriving from
  ObjectEventRegistrationBase.
- Event02 - Shows how to shows how to receive notifications of Windows PowerShell events that are
  generated on remote computers. It uses the PSEventReceived event exposed through the Runspace
  class.

#### Hosting application samples

- Runspace01 - Shows how to use the PowerShell class to run the `Get-Process` cmdlet synchronously.
  The `Get-Process` cmdlet returns Process objects for each process running on the local computer.
- Runspace02 - Shows how to use the PowerShell class to run the `Get-Process` and `Sort-Object`
  cmdlets synchronously. The `Get-Process` cmdlet returns Process objects for each process running
  on the local computer, and the `Sort-Object` sorts the objects based on their Id property. The
  results of these commands is displayed by using a DataGridView control.
- Runspace03 - Shows how to use the PowerShell class to run a script synchronously, and how to
  handle non-terminating errors. The script receives a list of process names and then retrieves
  those processes. The results of the script, including any non-terminating errors that were
  generated when running the script, are displayed in a console window.
- Runspace04 - Shows how to use the PowerShell class to run commands, and how to catch terminating
  errors that are thrown when running the commands. Two commands are run, and the last command is
  passed a parameter argument that is not valid. As a result, no objects are returned and a
  terminating error is thrown.
- Runspace05 - Shows how to add a snap-in to an InitialSessionState object so that the cmdlet of the
  snap-in is available when the runspace is opened. The snap-in provides a Get-Proc cmdlet (defined
  by the GetProcessSample01 Sample) that is run synchronously using a PowerShell object.
- Runspace06 - Shows how to add a module to an InitialSessionState object so that the module is
  loaded when the runspace is opened. The module provides a Get-Proc cmdlet (defined by the
  GetProcessSample02 Sample) that is run synchronously using a PowerShell object.
- Runspace07 - Shows how to create a runspace, and then use that runspace to run two cmdlets
  synchronously using a PowerShell object.
- Runspace08 - Shows how to add commands and arguments to the pipeline of a PowerShell object and
  how to run the commands synchronously.
- Runspace09 - Shows how to add a script to the pipeline of a PowerShell object and how to run the
  script asynchronously. Events are used to handle the output of the script.
- Runspace10 - Shows how to create a default initial session state, how to add a cmdlet to the
  InitialSessionState, how to create a runspace that uses the initial session state, and how to run
  the command using a PowerShell object.
- Runspace11 - Shows how to use the ProxyCommand class to create a proxy command that calls an
  existing cmdlet, but restricts the set of available parameters. The proxy command is then added to
  an initial session state that is used to create a constrained runspace. This means that the user
  can access the functionality of the cmdlet only through the proxy command.
- PowerShell01 - Shows how to create a constrained runspace using an InitialSessionState object.
- PowerShell02 - Shows how to use a runspace pool to run multiple commands concurrently.

#### Host samples

- Host01 - Shows how to implement a host application that uses a custom host. In this sample a
  runspace is created that uses the custom host, and then the PowerShell API is used to run a script
  that calls `exit`. The host application then looks at the output of the script and prints out the
  results.
- Host02 - Shows how to write a host application that uses the Windows PowerShell runtime along with
  a custom host implementation. The host application sets the host culture to German, runs the
  `Get-Process` cmdlet and displays the results as you would see them by using pwrsh.exe, and then
  prints out the current data and time in German.
- Host03 - Shows how to build an interactive console-based host application that reads commands from
  the command line, executes the commands, and then displays the results to the console.
- Host04 - Shows how to build an interactive console-based host application that reads commands from
  the command line, executes the commands, and then displays the results to the console. This host
  application also supports displaying prompts that allow the user to specify multiple choices.
- Host05 - Shows how to build an interactive console-based host application that reads commands from
  the command line, executes the commands, and then displays the results to the console. This host
  application also supports calls to remote computers by using the `Enter-PsSession` and
  `Exit-PsSession` cmdlets.
- Host06 - Shows how to build an interactive console-based host application that reads commands from
  the command line, executes the commands, and then displays the results to the console. In
  addition, this sample uses the Tokenizer APIs to specify the color of the text that is entered by
  the user.

#### Provider samples

- AccessDBProviderSample01 - Shows how to declare a provider class that derives directly from the
  CmdletProvider class. It is included here only for completeness.

- AccessDBProviderSample02 - Shows how to overwrite the NewDrive and RemoveDrive methods to support
  calls to the `New-PSDrive` and `Remove-PSDrive` cmdlets. The provider class in this sample derives
  from the DriveCmdletProvider class.

- AccessDBProviderSample03 - Shows how to overwrite the GetItem and SetItem methods to support calls
  to the `Get-Item` and `Set-Item` cmdlets. The provider class in this sample derives from the
  ItemCmdletProvider class.

- AccessDBProviderSample04 - Shows how to overwrite container methods to support calls to the
  `Copy-Item`, `Get-ChildItem`, `New-Item`, and `Remove-Item` cmdlets. These methods should be
  implemented when the data store contains items that are containers. A container is a group of
  child items under a common parent item. The provider class in this sample derives from the
  ItemCmdletProvider class.

- AccessDBProviderSample05 - Shows how to overwrite container methods to support calls to the
  `Move-Item` and `Join-Path` cmdlets. These methods should be implemented when the user needs to
  move items within a container and if the data store contains nested containers. The provider class
  in this sample derives from the NavigationCmdletProvider class.

- AccessDBProviderSample06 - Shows how to overwrite content methods to support calls to the
  `Clear-Content`, `Get-Content`, and `Set-Content` cmdlets. These methods should be implemented
  when the user needs to manage the content of the items in the data store. The provider class in
  this sample derives from the NavigationCmdletProvider class, and it implements the
  IContentCmdletProvider interface.
