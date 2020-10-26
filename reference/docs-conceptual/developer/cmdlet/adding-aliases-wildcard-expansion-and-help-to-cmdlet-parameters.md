---
ms.date: 09/13/2016
ms.topic: reference
title: Adding Aliases, Wildcard Expansion, and Help to Cmdlet Parameters
description: Adding Aliases, Wildcard Expansion, and Help to Cmdlet Parameters
---
# Adding Aliases, Wildcard Expansion, and Help to Cmdlet Parameters

This section describes how to add aliases, wildcard expansion, and Help messages to the parameters of the Stop-Proc cmdlet (described in [Creating a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md)).

This Stop-Proc cmdlet attempts to stop processes that are retrieved using the Get-Proc cmdlet (described in [Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md)).

## Defining the Cmdlet

The first step in cmdlet creation is always naming the cmdlet and declaring the .NET class that implements the cmdlet. Because you are writing a cmdlet to change the system, it should be named accordingly. Because this cmdlet stops system processes, it uses the verb "Stop", defined by the [System.Management.Automation.Verbslifecycle](/dotnet/api/System.Management.Automation.VerbsLifeCycle) class, with the noun "Proc" to indicate process. For more information about approved cmdlet verbs, see [Cmdlet Verb Names](./approved-verbs-for-windows-powershell-commands.md).

The following code is the class definition for this Stop-Proc cmdlet.

```csharp
[Cmdlet(VerbsLifecycle.Stop, "proc",
        SupportsShouldProcess = true)]
public class StopProcCommand : Cmdlet
```

## Defining Parameters for System Modification

Your cmdlet needs to define parameters that support system modifications and user feedback. The cmdlet should define a `Name` parameter or equivalent so that the cmdlet will be able to modify the system by some sort of identifier. In addition, the cmdlet should define the `Force` and `PassThru` parameters. For more information about these parameters, see [Creating a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md).

## Defining a Parameter Alias

A parameter alias can be an alternate name or a well-defined 1-letter or 2-letter short name for a cmdlet parameter. In both cases, the goal of using aliases is to simplify user entry from the command line. Windows PowerShell supports parameter aliases through the [System.Management.Automation.Aliasattribute](/dotnet/api/System.Management.Automation.AliasAttribute) attribute, which uses the declaration syntax [Alias()].

The following code shows how an alias is added to the `Name` parameter.

```csharp
/// <summary>
/// Specify the mandatory Name parameter used to identify the
/// processes to be stopped.
/// </summary>
[Parameter(
           Position = 0,
           Mandatory = true,
           ValueFromPipeline = true,
           ValueFromPipelineByPropertyName = true,
           HelpMessage = "The name of one or more processes to stop. Wildcards are permitted."
)]
[Alias("ProcessName")]
public string[] Name
{
  get { return processNames; }
  set { processNames = value; }
}
private string[] processNames;
```

In addition to using the [System.Management.Automation.Aliasattribute](/dotnet/api/System.Management.Automation.AliasAttribute) attribute, the Windows PowerShell runtime performs partial name matching, even if no aliases are specified. For example, if your cmdlet has a `FileName` parameter and that is the only parameter that starts with `F`, the user could enter `Filename`, `Filenam`, `File`, `Fi`, or `F` and still recognize the entry as the `FileName` parameter.

## Creating Help for Parameters

Windows PowerShell allows you to create Help for cmdlet parameters. Do this for any parameter used for system modification and user feedback. For each parameter to support Help, you can set the `HelpMessage` attribute keyword in the [System.Management.Automation.Parameterattribute](/dotnet/api/System.Management.Automation.ParameterAttribute) attribute declaration. This keyword defines the text to display to the user for assistance in using the parameter. You can also set the `HelpMessageBaseName` keyword to identify the base name of a resource to use for the message. If you set this keyword, you must also set the `HelpMessageResourceId` keyword to specify the resource identifier.

The following code from this Stop-Proc cmdlet defines the `HelpMessage` attribute keyword for the `Name` parameter.

```csharp
/// <summary>
/// Specify the mandatory Name parameter used to identify the
/// processes to be stopped.
/// </summary>
[Parameter(
           Position = 0,
           Mandatory = true,
           ValueFromPipeline = true,
           ValueFromPipelineByPropertyName = true,
           HelpMessage = "The name of one or more processes to stop. Wildcards are permitted."
)]
```

## Overriding an Input Processing Method

Your cmdlet must override an input processing method, most often this will be [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord). When modifying the system, the cmdlet should call the [System.Management.Automation.Cmdlet.ShouldProcess](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) and [System.Management.Automation.Cmdlet.ShouldContinue](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue) methods to allow the user to provide feedback before a change is made. For more information about these methods, see [Creating a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md).

## Supporting Wildcard Expansion

To allow the selection of multiple objects, your cmdlet can use the [System.Management.Automation.Wildcardpattern](/dotnet/api/System.Management.Automation.WildcardPattern) and [System.Management.Automation.Wildcardoptions](/dotnet/api/System.Management.Automation.WildcardOptions) classes to provide wildcard expansion support for parameter input. Examples of wildcard patterns are lsa*, \*.txt, and [a-c]\*. Use the back-quote character (`) as an escape character when the pattern contains a character that should be used literally.

Wildcard expansions of file and path names are examples of common scenarios where the cmdlet may want to allow support for path inputs when the selection of multiple objects is required. A common case is in the file system, where a user wants to see all files residing in the current folder.

You should need a customized wildcard pattern matching implementation only rarely. In this case, your cmdlet should support either the full POSIX 1003.2, 3.13 specification for wildcard expansion or the following simplified subset:

- **Question mark (?).** Matches any character at the specified location.

- **Asterisk (\*).** Matches zero or more characters starting at the specified location.

- **Open bracket ([).** Introduces a pattern bracket expression that can contain characters or a range of characters. If a range is required, a hyphen (-) is used to indicate the range.

- **Close bracket (]).** Ends a pattern bracket expression.

- **Back-quote escape character (`).** Indicates that the next character should be taken literally. Be aware that when specifying the back-quote character from the command line (as opposed to specifying it programmatically), the back-quote escape character must be specified twice.

> [!NOTE]
> For more information about wildcard patterns, see [Supporting Wildcards in Cmdlet Parameters](./supporting-wildcard-characters-in-cmdlet-parameters.md).

The following code shows how to set wildcard options and define the wildcard pattern used for resolving the `Name` parameter for this cmdlet.

```csharp
WildcardOptions options = WildcardOptions.IgnoreCase |
                          WildcardOptions.Compiled;
WildcardPattern wildcard = new WildcardPattern(name,options);
```

The following code shows how to test whether the process name matches the defined wildcard pattern. Notice that, in this case, if the process name does not match the pattern, the cmdlet continues on to get the next process name.

```csharp
if (!wildcard.IsMatch(processName))
{
  continue;
}
```

## Code Sample

For the complete C# sample code, see [StopProcessSample03 Sample](./stopprocesssample03-sample.md).

## Define Object Types and Formatting

Windows PowerShell passes information between cmdlets using .Net objects. Consequently, a cmdlet may need to define its own type, or the cmdlet may need to extend an existing type provided by another cmdlet. For more information about defining new types or extending existing types, see [Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85)).

## Building the Cmdlet

After implementing a cmdlet, it must be registered with Windows PowerShell through a Windows PowerShell snap-in. For more information about registering cmdlets, see [How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85)).

## Testing the Cmdlet

When your cmdlet has been registered with Windows PowerShell, you can test it by running it on the command line. Let's test the sample Stop-Proc cmdlet. For more information about using cmdlets from the command line, see the [Getting Started with Windows PowerShell](/powershell/scripting/getting-started/getting-started-with-windows-powershell).

- Start Windows PowerShell and use Stop-Proc to stop a process using the ProcessName alias for the `Name` parameter.

    ```powershell
    PS> stop-proc -ProcessName notepad
    ```

    The following output appears.

    ```
    Confirm
    Are you sure you want to perform this action?
    Performing operation "stop-proc" on Target "notepad (3496)".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y
    ```

- Make the following entry on the command line. Because the Name parameter is mandatory, you are prompted for it. Entering "!?" brings up the help text associated with the parameter.

    ```powershell
    PS> stop-proc
    ```

    The following output appears.

    ```
    Cmdlet stop-proc at command pipeline position 1
    Supply values for the following parameters:
    (Type !? for Help.)
    Name[0]: !?
    The name of one or more processes to stop. Wildcards are permitted.
    Name[0]: notepad
    ```

- Now make the following entry to stop all processes that match the wildcard pattern "*note\*". You are prompted before stopping each process that matches the pattern.

    ```powershell
    PS> stop-proc -Name *note*
    ```

    The following output appears.

    ```
    Confirm
    Are you sure you want to perform this action?
    Performing operation "stop-proc" on Target "notepad (1112)".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y
    ```

    The following output appears.

    ```
    Confirm
    Are you sure you want to perform this action?
    Performing operation "stop-proc" on Target "ONENOTEM (3712)".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): N
    ```

    The following output appears.

    ```
    Confirm
    Are you sure you want to perform this action?
    Performing operation "stop-proc" on Target "ONENOTE (3592)".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): N
    ```

## See Also

[Create a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md)

[How to Create a Windows PowerShell Cmdlet](/powershell/scripting/developer/cmdlet/writing-a-windows-powershell-cmdlet)

[Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85))

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85))

[Supporting Wildcards in Cmdlet Parameters](./supporting-wildcard-characters-in-cmdlet-parameters.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
