---
description: Creating a Cmdlet that Modifies the System
ms.date: 09/13/2016
title: Creating a Cmdlet that Modifies the System
---
# Creating a Cmdlet that Modifies the System

Sometimes a cmdlet must modify the running state of the system, not just the state of the Windows
PowerShell runtime. In these cases, the cmdlet should allow the user a chance to confirm whether or
not to make the change.

To support confirmation a cmdlet must do two things.

- Declare that the cmdlet supports confirmation when you specify the
  [System.Management.Automation.CmdletAttribute][15]
  attribute by setting the SupportsShouldProcess keyword to `true`.

- Call
  [System.Management.Automation.Cmdlet.ShouldProcess][13]
  during the execution of the cmdlet (as shown in the following example).

By supporting confirmation, a cmdlet exposes the `Confirm` and `WhatIf` parameters that are provided
by Windows PowerShell, and also meets the development guidelines for cmdlets (For more information
about cmdlet development guidelines, see
[Cmdlet Development Guidelines][04].).

## Changing the System

The act of "changing the system" refers to any cmdlet that potentially changes the state of the
system outside Windows PowerShell. For example, stopping a process, enabling or disabling a user
account, or adding a row to a database table are all changes to the system that should be confirmed.
In contrast, operations that read data or establish transient connections do not change the system
and generally do not require confirmation. Confirmation is also not needed for actions whose effect
is limited to inside the Windows PowerShell runtime, such as `Set-Variable`. Cmdlets that might or
might not make a persistent change should declare `SupportsShouldProcess` and call
[System.Management.Automation.Cmdlet.ShouldProcess][13] only if they are about to make a persistent
change.

> [!NOTE]
> ShouldProcess confirmation applies only to cmdlets. If a command or script modifies the running
> state of a system by directly calling .NET methods or properties, or by calling applications
> outside of Windows PowerShell, this form of confirmation will not be available.

## The StopProc Cmdlet

This topic describes a Stop-Proc cmdlet that attempts to stop processes that are retrieved using the
Get-Proc cmdlet (described in [Creating Your First Cmdlet][06]).

## Defining the Cmdlet

The first step in cmdlet creation is always naming the cmdlet and declaring the .NET class that
implements the cmdlet. Because you are writing a cmdlet to change the system, it should be named
accordingly. This cmdlet stops system processes, so the verb name chosen here is "Stop", defined by
the [System.Management.Automation.VerbsLifecycle][17] class, with the noun "Proc" to indicate that
the cmdlet stops processes. For more information about approved cmdlet verbs, see [Cmdlet Verb
Names][03].

The following is the class definition for this Stop-Proc cmdlet.

```csharp
[Cmdlet(VerbsLifecycle.Stop, "Proc",
        SupportsShouldProcess = true)]
public class StopProcCommand : Cmdlet
```

Be aware that in the [System.Management.Automation.CmdletAttribute][15] declaration, the
`SupportsShouldProcess` attribute keyword is set to `true` to enable the cmdlet to make calls to
[System.Management.Automation.Cmdlet.ShouldProcess][13] and
[System.Management.Automation.Cmdlet.ShouldContinue][12]. Without this keyword set, the `Confirm`
and `WhatIf` parameters will not be available to the user.

### Extremely Destructive Actions

Some operations are extremely destructive, such as reformatting an active hard disk partition. In
these cases, the cmdlet should set `ConfirmImpact` = `ConfirmImpact.High` when declaring the
[System.Management.Automation.CmdletAttribute][15] attribute. This setting forces the cmdlet to
request user confirmation even when the user has not specified the `Confirm` parameter. However,
cmdlet developers should avoid overusing `ConfirmImpact` for operations that are just potentially
destructive, such as deleting a user account. Remember that if `ConfirmImpact` is set to
[System.Management.Automation.ConfirmImpact][16] **High**.

Similarly, some operations are unlikely to be destructive, although they do in theory modify the
running state of a system outside Windows PowerShell. Such cmdlets can set `ConfirmImpact` to
[System.Management.Automation.ConfirmImpact.Low][16]. This will bypass confirmation requests where
the user has asked to confirm only medium-impact and high-impact operations.

## Defining Parameters for System Modification

This section describes how to define the cmdlet parameters, including those that are needed to
support system modification. See [Adding Parameters that Process CommandLine Input][03] if you need
general information about defining parameters.

The Stop-Proc cmdlet defines three parameters: `Name`, `Force`, and `PassThru`.

The `Name` parameter corresponds to the `Name` property of the process input object. Be aware that
the `Name` parameter in this sample is mandatory, as the cmdlet will fail if it does not have a
named process to stop.

The `Force` parameter allows the user to override calls to
[System.Management.Automation.Cmdlet.ShouldContinue][12]. In fact, any cmdlet that calls
[System.Management.Automation.Cmdlet.ShouldContinue][12] should have a `Force` parameter so that
when `Force` is specified, the cmdlet skips the call to
[System.Management.Automation.Cmdlet.ShouldContinue][12] and proceeds with the operation. Be aware
that this does not affect calls to [System.Management.Automation.Cmdlet.ShouldProcess][13].

The `PassThru` parameter allows the user to indicate whether the cmdlet passes an output object
through the pipeline, in this case, after a process is stopped. Be aware that this parameter is tied
to the cmdlet itself instead of to a property of the input object.

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

The cmdlet must override an input processing method. The following code illustrates the
[System.Management.Automation.Cmdlet.ProcessRecord][11] override used in the sample Stop-Proc
cmdlet. For each requested process name, this method ensures that the process is not a special
process, tries to stop the process, and then sends an output object if the `PassThru` parameter is
specified.

```csharp
protected override void ProcessRecord()
{
  foreach (string name in processNames)
  {
    // For every process name passed to the cmdlet, get the associated
    // process(es). For failures, write a non-terminating error
    Process[] processes;

    try
    {
      processes = Process.GetProcessesByName(name);
    }
    catch (InvalidOperationException ioe)
    {
      WriteError(new ErrorRecord(ioe,"Unable to access the target process by name",
                 ErrorCategory.InvalidOperation, name));
      continue;
    }

    // Try to stop the process(es) that have been retrieved for a name
    foreach (Process process in processes)
    {
      string processName;

      try
      {
        processName = process.ProcessName;
      }

      catch (Win32Exception e)
        {
          WriteError(new ErrorRecord(e, "ProcessNameNotFound",
                     ErrorCategory.ReadError, process));
          continue;
        }

        // Call Should Process to confirm the operation first.
        // This is always false if WhatIf is set.
        if (!ShouldProcess(string.Format("{0} ({1})", processName,
                           process.Id)))
        {
          continue;
        }
        // Call ShouldContinue to make sure the user really does want
        // to stop a critical process that could possibly stop the computer.
        bool criticalProcess =
             criticalProcessNames.Contains(processName.ToLower());

        if (criticalProcess &&!force)
        {
          string message = String.Format
                ("The process \"{0}\" is a critical process and should not be stopped. Are you sure you wish to stop the process?",
                processName);

          // It is possible that ProcessRecord is called multiple times
          // when the Name parameter receives objects as input from the
          // pipeline. So to retain YesToAll and NoToAll input that the
          // user may enter across multiple calls to ProcessRecord, this
          // information is stored as private members of the cmdlet.
          if (!ShouldContinue(message, "Warning!",
                              ref yesToAll,
                              ref noToAll))
          {
            continue;
          }
        } // if (criticalProcess...
        // Stop the named process.
        try
        {
          process.Kill();
        }
        catch (Exception e)
        {
          if ((e is Win32Exception) || (e is SystemException) ||
              (e is InvalidOperationException))
          {
            // This process could not be stopped so write
            // a non-terminating error.
            string message = String.Format("{0} {1} {2}",
                             "Could not stop process \"", processName,
                             "\".");
            WriteError(new ErrorRecord(e, message,
                       ErrorCategory.CloseError, process));
                       continue;
          } // if ((e is...
          else throw;
        } // catch

        // If the PassThru parameter argument is
        // True, pass the terminated process on.
        if (passThru)
        {
          WriteObject(process);
        }
    } // foreach (Process...
  } // foreach (string...
} // ProcessRecord
```

## Calling the ShouldProcess Method

The input processing method of your cmdlet should call the
[System.Management.Automation.Cmdlet.ShouldProcess][13] method to confirm execution of an operation
before a change (for example, deleting files) is made to the running state of the system. This
allows the Windows PowerShell runtime to supply the correct "WhatIf" and "Confirm" behavior within
the shell.

> [!NOTE]
> If a cmdlet states that it supports should process and fails to make the
> [System.Management.Automation.Cmdlet.ShouldProcess][13] call, the user might modify the system
> unexpectedly.

The call to [System.Management.Automation.Cmdlet.ShouldProcess][13] sends the name of the resource
to be changed to the user, with the Windows PowerShell runtime taking into account any command-line
settings or preference variables in determining what should be displayed to the user.

The following example shows the call to [System.Management.Automation.Cmdlet.ShouldProcess][13] from
the override of the [System.Management.Automation.Cmdlet.ProcessRecord][11] method in the sample
Stop-Proc cmdlet.

```csharp
if (!ShouldProcess(string.Format("{0} ({1})", processName,
                   process.Id)))
{
  continue;
}
```

## Calling the ShouldContinue Method

The call to the [System.Management.Automation.Cmdlet.ShouldContinue][12] method sends a secondary
message to the user. This call is made after the call to
[System.Management.Automation.Cmdlet.ShouldProcess][13] returns `true` and if the `Force` parameter
was not set to `true`. The user can then provide feedback to say whether the operation should be
continued. Your cmdlet calls [System.Management.Automation.Cmdlet.ShouldContinue][12] as an
additional check for potentially dangerous system modifications or when you want to provide
yes-to-all and no-to-all options to the user.

The following example shows the call to [System.Management.Automation.Cmdlet.ShouldContinue][12]
from the override of the [System.Management.Automation.Cmdlet.ProcessRecord][11] method in the
sample Stop-Proc cmdlet.

```csharp
if (criticalProcess &&!force)
{
  string message = String.Format
        ("The process \"{0}\" is a critical process and should not be stopped. Are you sure you wish to stop the process?",
        processName);

  // It is possible that ProcessRecord is called multiple times
  // when the Name parameter receives objects as input from the
  // pipeline. So to retain YesToAll and NoToAll input that the
  // user may enter across multiple calls to ProcessRecord, this
  // information is stored as private members of the cmdlet.
  if (!ShouldContinue(message, "Warning!",
                      ref yesToAll,
                      ref noToAll))
  {
    continue;
  }
} // if (criticalProcess...
```

## Stopping Input Processing

The input processing method of a cmdlet that makes system modifications must provide a way of
stopping the processing of input. In the case of this Stop-Proc cmdlet, a call is made from the
[System.Management.Automation.Cmdlet.ProcessRecord][11] method to the
[System.Diagnostics.Process.Kill*][10] method. Because the `PassThru` parameter is set to `true`,
[System.Management.Automation.Cmdlet.ProcessRecord][11] also calls
[System.Management.Automation.Cmdlet.WriteObject][14] to send the process object to the pipeline.

## Code Sample

For the complete C# sample code, see [StopProcessSample01 Sample][07].

## Defining Object Types and Formatting

Windows PowerShell passes information between cmdlets using .NET objects. Consequently, a cmdlet may
need to define its own type, or the cmdlet may need to extend an existing type provided by another
cmdlet. For more information about defining new types or extending existing types, see
[Extending Object Types and Formatting][09].

## Building the Cmdlet

After implementing a cmdlet, it must be registered with Windows PowerShell through a Windows
PowerShell snap-in. For more information about registering cmdlets, see
[How to Register Cmdlets, Providers, and Host Applications][08].

## Testing the Cmdlet

When your cmdlet has been registered with Windows PowerShell, you can test it by running it on the
command line. Here are several tests that test the Stop-Proc cmdlet. For more information about
using cmdlets from the command line, see the [Running commands in the shell][01].

- Start Windows PowerShell and use the Stop-Proc cmdlet to stop processing as shown below. Because
  the cmdlet specifies the `Name` parameter as mandatory, the cmdlet queries for the parameter.

    ```powershell
    PS> Stop-Proc
    ```

    The following output appears.

    ```
    Cmdlet Stop-Proc at command pipeline position 1
    Supply values for the following parameters:
    Name[0]:
    ```

- Now let's use the cmdlet to stop the process named "NOTEPAD". The cmdlet asks you to confirm the
  action.

    ```powershell
    PS> Stop-Proc -Name notepad
    ```

    The following output appears.

    ```
    Confirm
    Are you sure you want to perform this action?
    Performing operation "Stop-Proc" on Target "notepad (4996)".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y
    ```

- Use Stop-Proc as shown to stop the critical process named "WINLOGON". You are prompted and warned
  about performing this action because it will cause the operating system to reboot.

    ```powershell
    PS> Stop-Proc -Name Winlogon
    ```

    The following output appears.

    ```Output
    Confirm
    Are you sure you want to perform this action?
    Performing operation "Stop-Proc" on Target "winlogon (656)".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y
    Warning!
    The process " winlogon " is a critical process and should not be stopped. Are you sure you wish to stop the process?
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): N
    ```

- Let's now try to stop the WINLOGON process without receiving a warning. Be aware that this command
  entry uses the `Force` parameter to override the warning.

    ```powershell
    PS> Stop-Proc -Name winlogon -Force
    ```

    The following output appears.

    ```Output
    Confirm
    Are you sure you want to perform this action?
    Performing operation "Stop-Proc" on Target "winlogon (656)".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): N
    ```

## See Also

- [Adding Parameters that Process Command-Line Input][03]
- [Extending Object Types and Formatting][09]
- [How to Register Cmdlets, Providers, and Host Applications][08]
- [Windows PowerShell SDK][02]
- [Cmdlet Samples][05]

<!-- link references -->
[01]: ../../learn/shell/running-commands.md
[02]: ../windows-powershell-reference.md
[03]: ./adding-parameters-that-process-command-line-input.md
[04]: ./cmdlet-development-guidelines.md
[05]: ./cmdlet-samples.md
[06]: ./creating-a-cmdlet-without-parameters.md
[07]: ./stopprocesssample01-sample.md
[08]: /previous-versions/ms714644(v=vs.85)
[09]: /previous-versions/ms714665(v=vs.85)
[10]: xref:System.Diagnostics.Process.Kill%2A
[11]: xref:System.Management.Automation.Cmdlet.ProcessRecord%2A
[12]: xref:System.Management.Automation.Cmdlet.ShouldContinue%2A
[13]: xref:System.Management.Automation.Cmdlet.ShouldProcess%2A
[14]: xref:System.Management.Automation.Cmdlet.WriteObject%2A
[15]: xref:System.Management.Automation.CmdletAttribute
[16]: xref:System.Management.Automation.ConfirmImpact
[17]: xref:System.Management.Automation.VerbsLifecycle
