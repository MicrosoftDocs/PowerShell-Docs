---
description: This article describes how to create a feedback provider.
ms.date: 09/01/2023
title: How to create a feedback provider
---
# How to create a feedback provider

PowerShell 7.4-preview.3 introduced the concept of feedback providers. A feedback provider is a
PowerShell module that implements the `IFeedbackProvider` interface to provide command suggestions
based on user command execution attempts. The provider is triggered when there's a success or
failure execution. Feedback providers use information from the success or failure to provide
feedback.

## Prerequisites

To create a feedback provider, you must satisfy the following prerequisites:

- Install PowerShell 7.4-preview.3 or higher
  - You must enable the `PSFeedbackProvider` experimental feature to enable support for feedback 
  providers and predictors. For more information, see
    [Using Experimental Features][02].
- Install .NET 8 SDK - 8.0-preview.3 or higher

## Overview of a feedback provider

A feedback provider is a PowerShell binary module that implements the
`System.Management.Automation.Subsystem.Feedback.IFeedbackProvider` interface. This interface 
declares the methods to get feedback based on the command line input. The feedback interface can 
provide suggestions based on the success or failure of the command invoked by the user. The 
suggestions can be anything that you want. For example, you might suggest ways to address an 
error or better practices, like avoiding the use of aliases. For more information, see the 
[What are Feedback Providers?][08] blog post.

The following diagram shows the architecture of a feedback provider:

![Diagram of the feedback provider architecture.][05]

PowerShell 7.4 is built on .NET 8. For more information on the SDK. See the [Download .NET 8.0][09]
page to get the latest version of the SDK.

The following examples walk you through the process of creating a simple feedback provider. Also,
you can register the provider with the command predictor interface to add feedback suggestions to
the command-line predictor experience. For more information about predictors, see
[Using predictors in PSReadLine][03] and [How to create a command line predictor][04].

## Step 1 - Create a new class library project

Use the following command to create a new project in the project directory:

```powershell
dotnet new classlib --name MyFeedbackProvider
```

Add a package reference for the `System.Management.Automation` package to your
`.csproj` file. The following example shows the updated `.csproj` file:

```xml
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="System.Management.Automation" Version="7.4.0-preview.3">
        <ExcludeAssets>contentFiles</ExcludeAssets>
        <PrivateAssets>All</PrivateAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

> [!NOTE]
> You should change the version of the `System.Management.Automation` assembly to match the version
> of the PowerShell preview that you are targeting. The minimum version is 7.4.0-preview.3.


## Step 2 - Add the class definition for your provider

Change the name of the `Class1.cs` file to match the name of your provider. This example uses
`myFeedbackProvider.cs`. This file contains the two main classes that define the feedback provider.
The following example shows the basic template for the class definitions.

```csharp
using System.Management.Automation;
using System.Management.Automation.Subsystem;
using System.Management.Automation.Subsystem.Feedback;
using System.Management.Automation.Subsystem.Prediction;
using System.Management.Automation.Language;

namespace myFeedbackProvider;

public sealed class myFeedbackProvider : IFeedbackProvider, ICommandPredictor
{

}

public class Init : IModuleAssemblyInitializer, IModuleAssemblyCleanup
{

}
```

## Step 3 - Implement the Init class

The `Init` class registers and unregisters the feedback provider with the subsystem manager. The
`OnImport()` method runs when the binary module is being loaded. The `OnRemove()`
method runs when the binary module is being removed. This example registers both
the feedback provider and command predictor subsystem.

```csharp
public class Init : IModuleAssemblyInitializer, IModuleAssemblyCleanup
{
    private const string Id = "<ADD YOUR GUID HERE>";

    public void OnImport()
    {
        var feedback = new myFeedbackProvider(Id);
        SubsystemManager.RegisterSubsystem(SubsystemKind.FeedbackProvider, feedback);
        SubsystemManager.RegisterSubsystem(SubsystemKind.CommandPredictor, feedback);
    }

    public void OnRemove(PSModuleInfo psModuleInfo)
    {
        SubsystemManager.UnregisterSubsystem<ICommandPredictor>(new Guid(Id));
        SubsystemManager.UnregisterSubsystem<IFeedbackProvider>(new Guid(Id));
    }
}
```

Replace the `<ADD YOUR GUID HERE>` placeholder value with a unique Guid. You can generate a Guid
using the `New-Guid` cmdlet.

```powershell
New-Guid
```

The Guid is a unique identifier for your provider. The provider must have a unique Id to be
registered with the subsystem.

## Step 4 - Add class members and define the constructor

The following code implements the properties defined in the interfaces, adds needed class members, and creates the constructor for the `myFeedbackProvider` class.

```csharp
// Gets the global unique identifier for the subsystem implementation.
private readonly Guid _guid;
public Guid Id => _guid;

// Gets the name of a subsystem implementation, this will be the name displayed
// when triggered
public string Name => "myFeedbackProvider";

// Gets the description of a subsystem implementation.
public string Description => "This is very simple feedback provider";

// Gets a dictionary that contains the functions to be defined at the global scope
// of a PowerShell session.
Dictionary<string, string>? ISubsystem.FunctionsToDefine => null;

// Gets the trigger that causes the feedback provider to be invoked. In this case,
// it gets All triggers. See FeedbackTrigger enum for more details
public FeedbackTrigger Trigger => FeedbackTrigger.All;

// List of candidates from the feedback provider to be passed as predictor results
private List<string>? _candidates;

// PowerShell session used to run PowerShell commands that help create suggestions.
private PowerShell _powershell;

// Constructor
internal myFeedbackProvider(string guid)
{
    _guid = new Guid(guid); // Save guid
    _powershell = PowerShell.Create(); // Create PowerShell instance
}
```

## Step 5 - Create the GetFeedback() method

The `GetFeedback` method takes two parameters, `context` and `token`. The `context` parameter
receives the information about the trigger so you can decide how to respond with suggestions. The
`token` parameter is used for cancellation. This function returns a `FeedbackItem` containing the
suggestion. The function also contains some variables that are used to construct the feedback.

```csharp
// Gets feedback based on the given commandline and error record.
// context - The context for the feedback call.
// token - The cancellation token to cancel the operation.
public FeedbackItem? GetFeedback(FeedbackContext context, CancellationToken token)
{
    // Target describes the different kinds of triggers to activate on,
    var target = context.Trigger;
    var commandLine = context.CommandLine;
    var ast = context.CommandLineAst;

    // defining the header and footer variables
    string header;
    string footer;

    // List of the actions
    List<string>? actions = new List<string>();

    // Trigger on success code goes here

    // Trigger on error code goes here

    return null;
}
```

The following image shows how these fields are used in the suggestions that are displayed to the
user.

![Screenshot of example feedback providers][06]

### Create suggestions for a Success trigger

For a successful invocation, we want to expand any aliases used in the last execution. Using the
`CommandLineAst`, we identify any aliased commands and create a suggestion to use the fully
qualified command name instead.

```csharp
// Trigger on success
if (target == FeedbackTrigger.Success){
    // Getting the commands from the AST and only finding those that are Commands
    var astCmds = ast.FindAll((cAst) => cAst is CommandAst, true);

    // Check to see if there are any command returned
    if(astCmds is null || astCmds.Count() == 0){
        return null;
    }

    // Inspect each of the commands
    foreach(var command in astCmds)
    {

        // Get the command name
        var aliasedCmd = ((CommandAst) command).GetCommandName();

        // Check if its an alias or not, if so then add it to the list of actions
        if(TryGetAlias(aliasedCmd, out string commandString))
        {
            actions.Add(aliasedCmd + " --> " + commandString);

        }

    }

    // If no aliases were found return null
    if(actions.Count == 0){
        return null;
    }

    // If aliases are found, set the header to a description and return a new FeedbackItem.
    header = "You have used an aliased command:";
    // Copy actions to _candidates for the predictor
    _candidates = actions;

    return new FeedbackItem(header, actions);
}
```

### Implement the TryGetAlias() method

The `TryGetAlias()` method is a private helper function that returns a boolean value to indicate
whether the command is an alias. In the class constructor, we created a PowerShell instance that we
can use to run PowerShell commands. The `TryGetAlias()` method uses this PowerShell instance to
invoke the `GetCommand` method to determine if the command is an alias. The `AliasInfo` object
returned by `GetCommand` contains full name of the aliased command. The parameters of
`TryGetAlias()` are: `command`, which is the command to be checked, and `targetCommand`, which is
the output variable to contain the full name of the aliased command.

```csharp
private bool TryGetAlias(string command, out string targetCommand){
    // Create PowerShell runspace as a session state proxy to run GetCommand and check
    // if its an alias
    AliasInfo? pwshAliasInfo =
        _powershell.Runspace.SessionStateProxy.InvokeCommand.GetCommand(command, CommandTypes.Alias) as AliasInfo;

    // if its null then it is not an aliased command so just return false
    if(pwshAliasInfo is null){
        targetCommand = String.Empty;
        return false;
    }

    // Set targetCommand to referenced command name
    targetCommand = pwshAliasInfo.ReferencedCommand.Name;
    return true;
}
```

### Create suggestions for a Failure trigger

When a command execution fails, we want to suggest that the user `Get-Help` to get more information
about how to use the command.

```csharp
// Trigger on error
if (target == FeedbackTrigger.Error){
    // Gets the command that caused the error.
    var erroredCommand = context.LastError?.InvocationInfo.MyCommand;
    if (erroredCommand is null){
        return null;
    }

    header = "You have triggered an error with the command " + erroredCommand +
        ". Try using the following command to get help:";
    actions.Add("Get-Help " + erroredCommand);
    footer = "You can also check online documentation at https://learn.microsoft.com/en-us/powershell/module/?term=" +
        erroredCommand;

    // Copy actions to _candidates for the predictor
    _candidates = actions;
    return new FeedbackItem(header, actions, footer, FeedbackDisplayLayout.Portrait);
}
```

## Step 6 - Send suggestions to the command line predictor

Another way your feedback provider can enhance the user experience is to provide command suggestions
to the **ICommandPredictor** interface. For more information about creating a command line
predictor, see [How to create a command line predictor][04].

The following code implements the methods necessary to add predictor behavior to your feedback
provider.

- `CanAcceptFeedback()` - This method returns a Boolean value that indicates whether the predictor accepts a specific type of feedback.
- `GetSuggestion()` - Overloads the method of the **ICommandPredictor** interface. This method
  returns a `SuggestionPackage` object that contains the suggestions to be displayed by the
  predictor.
- `OnCommandLineAccepted()` - Overloads the method of the **ICommandPredictor** interface. This
  method is called when a command line is accepted to execute.

```csharp
#region ICommandPredictor

// Gets a value indicating whether the predictor accepts a specific kind of feedback.
// client - Represents the client that initiates the call.
// feedback - the specific kind of feedback
public bool CanAcceptFeedback(PredictionClient client, PredictorFeedbackKind feedback)
{
    return feedback switch
    {
        PredictorFeedbackKind.CommandLineAccepted => true,
        _ => false,
    };
}

// Get the predictive suggestions. It indicates the start of a suggestion rendering session.
// client - Represents the client that initiates the call.
// context - The PredictionContext object to be used for prediction.
// cancellationToken - The cancellation token to cancel the prediction.
public SuggestionPackage GetSuggestion(PredictionClient client, PredictionContext context,
    CancellationToken cancellationToken)
{
    if (_candidates is not null)
    {
        string input = context.InputAst.Extent.Text;
        List<PredictiveSuggestion>? result = null;

        foreach (string c in _candidates)
        {
            if (c.StartsWith(input, StringComparison.OrdinalIgnoreCase))
            {
                result ??= new List<PredictiveSuggestion>(_candidates.Count);
                result.Add(new PredictiveSuggestion(c));
            }
        }

        if (result is not null)
        {
            return new SuggestionPackage(result);
        }
    }

    return default;
}

// A command line was accepted to execute. The predictor can start processing early as needed
// with the latest history.
public void OnCommandLineAccepted(PredictionClient client, IReadOnlyList<string> history)
{
    // Reset the candidate state once the command is accepted.
    _candidates = null;
}

public void OnSuggestionDisplayed(PredictionClient client, uint session, int countOrIndex) { }

public void OnSuggestionAccepted(PredictionClient client, uint session, string acceptedSuggestion) { }

public void OnCommandLineExecuted(PredictionClient client, string commandLine, bool success) { }

#endregion;
```

## Step 7 - Build the feedback provider

Now you are ready to build and begin using your feedback provider! To build the project, run the
following command:

```powershell
dotnet build
```

This command create the PowerShell module as a DLL file in the following path of your project
folder: `bin/Debug/net8.0/myFeedbackProvider`

## Using a feedback provider

To test your new feedback provider, import the compiled module into your PowerShell session. This
can be done by importing the folder described after building has succeeded:

```powershell
Import-Module ./bin/Debug/net8.0/myFeedbackProvider
```

Once you're satisfied with your module, you should create a module manifest, publish it to the
PowerShell Gallery, and install it in your `$env:PSModulePath`. For more information, see
[How to create a module manifest][01]. You can add the `Import-Module` command to your `$PROFILE`
script so the module is available in PowerShell session.

You can get a list of installed feedback providers, using the following command:

```powershell
Get-PSSubsystem -Kind FeedbackProvider
```

```Output
Kind              SubsystemType      IsRegistered Implementations
----              -------------      ------------ ---------------
FeedbackProvider  IFeedbackProvider          True {general}
```

> [!NOTE]
> `Get-PSSubsystem` is an experimental cmdlet that was introduced in PowerShell 7.1 You must enable
> the `PSSubsystemPluginModel` experimental feature to use this cmdlet. For more information, see
> [Using Experimental Features][02].

The following screenshot shows some example suggestions from the new provider.

![Screenshot of success and error feedback provider triggers][07]

## Appendix - Full implementation code

The following code combines the previous examples into the find full implementation of the provider
class.

```csharp
using System.Management.Automation;
using System.Management.Automation.Subsystem;
using System.Management.Automation.Subsystem.Feedback;
using System.Management.Automation.Subsystem.Prediction;
using System.Management.Automation.Language;

namespace myFeedbackProvider;

public sealed class myFeedbackProvider : IFeedbackProvider, ICommandPredictor
{

    // Gets the trigger that causes the feedback provider to be invoked. In this case,
    // it gets All triggers. See FeedbackTrigger enum for more details
    public FeedbackTrigger Trigger => FeedbackTrigger.All;

    // Gets a dictionary that contains the functions to be defined at the global scope
    // of a PowerShell session.
    Dictionary<string, string>? ISubsystem.FunctionsToDefine => null;

    // Gets the name of a subsystem implementation, this will be the name displayed
    // when triggered
    public string Name => "myFeedbackProvider";

    // Gets the description of a subsystem implementation.
    public string Description => "This is very simple feedback provider";

    // Gets the global unique identifier for the subsystem implementation.
    private readonly Guid _guid;
    public Guid Id => _guid;

    // List of candidates from the feedback provider to be passed as predictor results
    private List<string>? _candidates;

    // PowerShell session used to run PowerShell commands that help create suggestions.
    private PowerShell _powershell;

    // Constructor
    internal myFeedbackProvider(string guid)
    {
        _guid = new Guid(guid); // Save guid
        _powershell = PowerShell.Create(); // Create PowerShell instance
    }

    #region IFeedbackProvider

    // Gets feedback based on the given commandline and error record.
    // context - The context for the feedback call.
    // token - The cancellation token to cancel the operation.
    public FeedbackItem? GetFeedback(FeedbackContext context, CancellationToken token)
    {

        var target = context.Trigger;
        var commandLine = context.CommandLine;
        var ast = context.CommandLineAst;

        // defining the header and footer variables
        string header;
        string footer;

        List<string>? actions = new List<string>();

        // Trigger on success
       if (target == FeedbackTrigger.Success){
            // Getting the commands from the AST and only finding those that are Commands
            var astCmds = ast.FindAll((cAst) => cAst is CommandAst, true);

            // Check to see if there are any command returned
            if(astCmds is null || astCmds.Count() == 0){
                return null;
            }

            // Navigate through each of the commands
            foreach(var command in astCmds){

                // Get the command name
                var aliasedCmd = ((CommandAst) command).GetCommandName();

                // Check if its an alias or not, if so then add it to the list of actions
                if(TryGetAlias(aliasedCmd, out string commandString)){
                    actions.Add(aliasedCmd + " --> " + commandString);

                }

            }

            // If no aliases were found return null
            if(actions.Count == 0){
                return null;
            }

            // If aliases are found, set the header to a description and return a new FeedbackItem.
            header = "You have used an aliased command:";
            // Copy actions to _candidates for the predictor
            _candidates = actions;

            return new FeedbackItem(header, actions);
        }

        // Trigger on error
        if (target == FeedbackTrigger.Error){
            // Gets the command that caused the error.
            var erroredCommand = context.LastError?.InvocationInfo.MyCommand;
            if (erroredCommand is null){
                return null;
            }

            header = "You have triggered an error with the command " + erroredCommand +
                ". Try using the following command to get help:";
            actions.Add("Get-Help " + erroredCommand);
            footer = "You can also check online documentation at https://learn.microsoft.com/en-us/powershell/module/?term=" +
                erroredCommand;

            // Copy actions to _candidates for the predictor
            _candidates = actions;
            return new FeedbackItem(header, actions, footer, FeedbackDisplayLayout.Portrait);
        }

        return null;

    }

    // function to check whether a command is an alias
    private bool TryGetAlias(string command, out string targetCommand){
        // Create PowerShell runspace as a session state proxy to run GetCommand and check
        // if its an alias
        AliasInfo? pwshAliasInfo =
            _powershell.Runspace.SessionStateProxy.InvokeCommand.GetCommand(command, CommandTypes.Alias) as AliasInfo;

        // if its null then it is not an aliased command so just return false
        if(pwshAliasInfo is null){
            targetCommand = String.Empty;
            return false;
        }

        // Set targetCommand to referenced command name
        targetCommand = pwshAliasInfo.ReferencedCommand.Name;
        return true;
    }
    #endregion


    #region ICommandPredictor
    // Gets a value indicating whether the predictor accepts a specific kind of feedback.
    // client - Represents the client that initiates the call.
    // feedback - the specific kind of feedback
    public bool CanAcceptFeedback(PredictionClient client, PredictorFeedbackKind feedback)
    {
        return feedback switch
        {
            PredictorFeedbackKind.CommandLineAccepted => true,
            _ => false,
        };
    }

    // Get the predictive suggestions. It indicates the start of a suggestion rendering session.
    // client - Represents the client that initiates the call.
    // context - The PredictionContext object to be used for prediction.
    // cancellationToken - The cancellation token to cancel the prediction.
    public SuggestionPackage GetSuggestion(PredictionClient client, PredictionContext context,
        CancellationToken cancellationToken)
    {
        if (_candidates is not null)
        {
            string input = context.InputAst.Extent.Text;
            List<PredictiveSuggestion>? result = null;

            foreach (string c in _candidates)
            {
                if (c.StartsWith(input, StringComparison.OrdinalIgnoreCase))
                {
                    result ??= new List<PredictiveSuggestion>(_candidates.Count);
                    result.Add(new PredictiveSuggestion(c));
                }
            }

            if (result is not null)
            {
                return new SuggestionPackage(result);
            }
        }

        return default;
    }

    // A command line was accepted to execute. The predictor can start processing early as
    // needed with the latest history.
    public void OnCommandLineAccepted(PredictionClient client, IReadOnlyList<string> history)
    {
        // Reset the candidate state once the command is accepted.
        _candidates = null;
    }

    public void OnSuggestionDisplayed(PredictionClient client, uint session, int countOrIndex) { }

    public void OnSuggestionAccepted(PredictionClient client, uint session, string acceptedSuggestion) { }

    public void OnCommandLineExecuted(PredictionClient client, string commandLine, bool success) { }

    #endregion;
}


public class Init : IModuleAssemblyInitializer, IModuleAssemblyCleanup
{
    private const string Id = "47013747-CB9D-4EBC-9F02-F32B8AB19D48";

    public void OnImport()
    {
        var feedback = new myFeedbackProvider(Id);
        SubsystemManager.RegisterSubsystem(SubsystemKind.FeedbackProvider, feedback);
        SubsystemManager.RegisterSubsystem(SubsystemKind.CommandPredictor, feedback);
    }

    public void OnRemove(PSModuleInfo psModuleInfo)
    {
        SubsystemManager.UnregisterSubsystem<ICommandPredictor>(new Guid(Id));
        SubsystemManager.UnregisterSubsystem<IFeedbackProvider>(new Guid(Id));
    }
}
```

<!-- link references -->
[01]: ../developer/module/how-to-write-a-powershell-module-manifest.md
[02]: ../learn/experimental-features.md#pssubsystempluginmodel
[03]: ../learn/shell/using-predictors.md
[04]: ./create-cmdline-predictor.md
[05]: ./media/create-feedback-provider/feedback-provider-arch.png
[06]: ./media/create-feedback-provider/feedback-provider-fields.png
[07]: ./media/create-feedback-provider/feedback-provider-output.png
[08]: https://devblogs.microsoft.com/powershell/what-are-feedback-providers/
[09]: https://dotnet.microsoft.com/download/dotnet/8.0
