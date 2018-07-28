---
title: "Adding User Messages to Your Cmdlet | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
helpviewer_keywords:
  - "WriteWarning"
  - "notifications, writing"
  - "progress notification"
  - "WriteVerbose"
  - "Stop-Proc"
  - "WriteProgress"
  - "WriteDebug"
  - "notifications, debug"
  - "ProgressRecord"
  - "samples, Stop-Proc cmdlet"
  - "notifications, progress"
  - "notifications, warning"
  - "WriteObject"
  - "WriteError"
  - "verbose notification"
  - "ProcessRecord"
  - "notifications, verbose"
  - "debug notification"
  - "cmdlet, writing notifications"
  - "warning"
  - "code sample, user notifications"
  - "user notifications"
ms.assetid: 14c13acb-f0b7-4613-bc7d-c361d14da1a2
caps.latest.revision: 8
---
# Adding User Messages to Your Cmdlet

Cmdlets can write several kinds of messages that can be displayed to the user by the Windows PowerShell runtime. These messages include the following types:

- Verbose messages that contain general user information.

- Debug messages that contain troubleshooting information.

- Warning messages that contain a notification that the cmdlet is about to perform an operation that can have unexpected results.

- Progress report messages that contain information about how much work the cmdlet has completed when performing an operation that takes a long time.

There are no limits to the number of messages that your cmdlet can write or the type of messages that your cmdlet writes. Each message is written by making a specific call from within the input processing method of your cmdlet.

## The StopProc Cmdlet

Topics in this section include the following:

- [Defining the Cmdlet](#Defining-the-Cmdlet)

- [Defining Parameters for System Modification](#Defining-Parameters-for-System-Modification)

- [Overriding an Input Processing Method](#Overriding-an-Input-Processing-Method)

- [Writing a Verbose Message](#Writing-a-Verbose-Message)

- [Writing a Debug Message](#Writing-a-Debug-Message)

- [Writing a Warning Message](#Writing-a-Warning-Message)

- [Writing a Progress Message](#Writing-a-Progress-Message)

- [Code Sample](#Code-Sample)

- [Define Object Types and Formatting](#Define-Object-Types-and-Formatting)

- [Building the Cmdlet](#Building-the-Cmdlet)

- [Testing the Cmdlet](#Testing-the-Cmdlet)

## Defining the Cmdlet

The first step in cmdlet creation is always naming the cmdlet and declaring the .NET class that implements the cmdlet. Any sort of cmdlet can write user notifications from its input processing methods; so, in general, you can name this cmdlet using any verb that indicates what system modifications the cmdlet performs. For more information about approved cmdlet verbs, see [Cmdlet Verb Names](./approved-verbs-for-windows-powershell-commands.md).

The Stop-Proc cmdlet is designed to modify the system; therefore, the [System.Management.Automation.Cmdletattribute](/dotnet/api/System.Management.Automation.CmdletAttribute) declaration for the .NET class must include the `SupportsShouldProcess` attribute keyword and be set to `true`.

The following code is the definition for this Stop-Proc cmdlet class. For more information about this definition, see [Creating a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md).

```csharp
[Cmdlet(VerbsLifecycle.Stop, "proc",
        SupportsShouldProcess = true)]
public class StopProcCommand : Cmdlet
```

## Defining Parameters for System Modification

The Stop-Proc cmdlet defines three parameters: `Name`, `Force`, and `PassThru`. For more information about defining these parameters, see [Creating a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md).

Here is the parameter declaration for the Stop-Proc cmdlet.

```csharp
[Parameter(
           Position = 0,
           Mandatory = true,
           ValueFromPipeline = true,
           ValueFromPipelineByPropertyName = true
)]
public string[] Name
{
  get { return processNames; }
  set { processNames = value; }
}
private string[] processNames;

/// <summary>
/// Specify the Force parameter that allows the user to override
/// the ShouldContinue call to force the stop operation. This
/// parameter should always be used with caution.
/// </summary>
[Parameter]
public SwitchParameter Force
{
  get { return force; }
  set { force = value; }
}
private bool force;

/// <summary>
/// Specify the PassThru parameter that allows the user to specify
/// that the cmdlet should pass the process object down the pipeline
/// after the process has been stopped.
/// </summary>
[Parameter]
public SwitchParameter PassThru
{
  get { return passThru; }
  set { passThru = value; }
}
private bool passThru;
```

## Overriding an Input Processing Method

Your cmdlet must override an input processing method, most often it will be [System.Management.Automation.Cmdlet.Processrecord*](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord). This Stop-Proc cmdlet overrides the [System.Management.Automation.Cmdlet.Processrecord*](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) input processing method. In this implementation of the Stop-Proc cmdlet, calls are made to write verbose messages, debug messages, and warning messages.

> [!NOTE]
> For more information about how this method calls the [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) and [System.Management.Automation.Cmdlet.Shouldcontinue*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue) methods, see [Creating a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md).

## Writing a Verbose Message

The [System.Management.Automation.Cmdlet.Writeverbose*](/dotnet/api/System.Management.Automation.Cmdlet.WriteVerbose) method is used to write general user-level information that is unrelated to specific error conditions. The system administrator can then use that information to continue processing other commands. In addition, any information written using this method should be localized as needed.

The following code from this Stop-Proc cmdlet shows two calls to the [System.Management.Automation.Cmdlet.Writeverbose*](/dotnet/api/System.Management.Automation.Cmdlet.WriteVerbose) method from the override of the [System.Management.Automation.Cmdlet.Processrecord*](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) method.

```csharp
message = String.Format("Attempting to stop process \"{0}\".", name);
WriteVerbose(message);
```

```csharp
message = String.Format("Stopped process \"{0}\", pid {1}.",
                        processName, process.Id);

WriteVerbose(message);
```

## Writing a Debug Message

The [System.Management.Automation.Cmdlet.Writedebug*](/dotnet/api/System.Management.Automation.Cmdlet.WriteDebug) method is used to write debug messages that can be used to troubleshoot the operation of the cmdlet. The call is made from an input processing method.

> [!NOTE]
> Windows PowerShell also defines a `Debug` parameter that presents both verbose and debug information. If your cmdlet supports this parameter, it does not need to call [System.Management.Automation.Cmdlet.Writedebug*](/dotnet/api/System.Management.Automation.Cmdlet.WriteDebug) in the same code that calls [System.Management.Automation.Cmdlet.Writeverbose*](/dotnet/api/System.Management.Automation.Cmdlet.WriteVerbose).

The following two sections of code from the sample Stop-Proc cmdlet show calls to the [System.Management.Automation.Cmdlet.Writedebug*](/dotnet/api/System.Management.Automation.Cmdlet.WriteDebug) method from the override of the [System.Management.Automation.Cmdlet.Processrecord*](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) method.

This debug message is written immediately before [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) is called.

```csharp
message =
          String.Format("Acquired name for pid {0} : \"{1}\"",
                       process.Id, processName);
WriteDebug(message);
```

This debug message is written immediately before [System.Management.Automation.Cmdlet.Writeobject*](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject) is called.

```csharp
message =
         String.Format("Writing process \"{0}\" to pipeline",
         processName);
WriteDebug(message);
WriteObject(process);
```

Windows PowerShell automatically routes any [System.Management.Automation.Cmdlet.Writedebug*](/dotnet/api/System.Management.Automation.Cmdlet.WriteDebug) calls to the tracing infrastructure and cmdlets. This allows the method calls to be traced to the hosting application, a file, or a debugger without your having to do any extra development work within the cmdlet. The following command-line entry implements a tracing operation.

**PS> trace-expression stop-proc -file proc.log -command stop-proc notepad**

## Writing a Warning Message

The [System.Management.Automation.Cmdlet.Writewarning*](/dotnet/api/System.Management.Automation.Cmdlet.WriteWarning) method is used to write a warning when the cmdlet is about to perform an operation that might have an unexpected result, for example, overwriting a read-only file.

The following code from the sample Stop-Proc cmdlet shows the call to the [System.Management.Automation.Cmdlet.Writewarning*](/dotnet/api/System.Management.Automation.Cmdlet.WriteWarning) method from the override of the [System.Management.Automation.Cmdlet.Processrecord*](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) method.

```csharp
 if (criticalProcess)
 {
   message =
             String.Format("Stopping the critical process \"{0}\".",
                           processName);
   WriteWarning(message);
} // if (criticalProcess...
```

## Writing a Progress Message

The [System.Management.Automation.Cmdlet.Writeprogress*](/dotnet/api/System.Management.Automation.Cmdlet.WriteProgress) is used to write progress messages when cmdlet operations take an extended amount of time to complete. A call to [System.Management.Automation.Cmdlet.Writeprogress*](/dotnet/api/System.Management.Automation.Cmdlet.WriteProgress) passes a [System.Management.Automation.Progressrecord](/dotnet/api/System.Management.Automation.ProgressRecord) object that is sent to the hosting application for rendering to the user.

> [!NOTE]
> This Stop-Proc cmdlet does not include a call to the [System.Management.Automation.Cmdlet.Writeprogress*](/dotnet/api/System.Management.Automation.Cmdlet.WriteProgress) method.

The following code is an example of a progress message written by a cmdlet that is attempting to copy an item.

```csharp
int myId = 0;
string myActivity = "Copy-item: Copying *.* to c:\abc";
string myStatus = "Copying file bar.txt";
ProgressRecord pr = new ProgressRecord(myId, myActivity, myStatus);
WriteProgress(pr);

pr.RecordType = ProgressRecordType.Completed;
WriteProgress(pr);
```

## Code Sample

For the complete C# sample code, see [StopProcessSample02 Sample](./stopprocesssample02-sample.md).

## Define Object Types and Formatting

Windows PowerShell passes information between cmdlets using .NET objects. Consequently, a cmdlet might need to define its own type, or the cmdlet might need to extend an existing type provided by another cmdlet. For more information about defining new types or extending existing types, see [Extending Object Types and Formatting](http://msdn.microsoft.com/en-us/da976d91-a3d6-44e8-affa-466b1e2bd351).

## Building the Cmdlet

After implementing a cmdlet, it must be registered with Windows PowerShell through a Windows PowerShell snap-in. For more information about registering cmdlets, see [How to Register Cmdlets, Providers, and Host Applications](http://msdn.microsoft.com/en-us/a41e9054-29c8-40ab-bf2b-8ce4e7ec1c8c).

## Testing the Cmdlet

When your cmdlet has been registered with Windows PowerShell, you can test it by running it on the command line. Let's test the sample Stop-Proc cmdlet. For more information about using cmdlets from the command line, see the [Getting Started with Windows PowerShell](/powershell/scripting/getting-started/getting-started-with-windows-powershell).

- The following command-line entry uses Stop-Proc to stop the process named "NOTEPAD", provide verbose notifications, and print debug information.

    ```powershell
    PS> stop-proc -Name notepad -Verbose -Debug
    ```

The following output appears.

    ```
    VERBOSE: Attempting to stop process " notepad ".
    DEBUG: Acquired name for pid 5584 : "notepad"

    Confirm
    Continue with this operation?
    [Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help (default is "Y"): Y

    Confirm
    Are you sure you want to perform this action?
    Performing operation "stop-proc" on Target "notepad (5584)".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y
    VERBOSE: Stopped process "notepad", pid 5584.
    ```

## See Also

[Create a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md)

[How to Create a Windows PowerShell Cmdlet](http://msdn.microsoft.com/en-us/0d721742-c849-4d0d-964f-78ddd9cd258c)

[Extending Object Types and Formatting](http://msdn.microsoft.com/en-us/da976d91-a3d6-44e8-affa-466b1e2bd351)

[How to Register Cmdlets, Providers, and Host Applications](http://msdn.microsoft.com/en-us/a41e9054-29c8-40ab-bf2b-8ce4e7ec1c8c)

[Windows PowerShell SDK](../windows-powershell-reference.md)
