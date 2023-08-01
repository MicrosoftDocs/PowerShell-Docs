---
description: This article describes how to create a feedback provider.
ms.date: 07/18/2023
title: How to create a feedback provider
---
# How to create a feedback provider

PowerShell 7.4-preview.2 introduces the concept of feedback providers. A feedback provider is a
PowerShell module that utilizes the `IFeedbackProvider` interface that will trigger on a user action
and give feedback to the user.

Feedback providers are PowerShell modules that can give suggestions to the user based on what they
are trying to execute in the shell. They currently trigger when there is a success or failure of
execution. Feedback providers can take the specific information from successes and failures and
based on that information, trigger and provide feedback to the user.

## System requirements

To create and use a feedback provider, you must be using the following software versions:

- PowerShell 7.4-preview.2 or higher - includes the feedback provider interface
- .NET 8 SDK 

## Overview of a feedback provider

A feedback provider is a PowerShell binary module. The module must implement the
`using System.Management.Automation.Subsystem.Feedback` interface. This interface
declares the methods used to get feedback based on the given command line and error record.

![Architecture](media/create-feedback-provider/feedbackproviderarch.png)

## Creating the code

You must have .NET 8 SDK installed to create a feedback provider. For more information on the SDK
see [Download .NET 8.0](https://dotnet.microsoft.com/en-us/download/dotnet/8.0). In this example we will be creating a simple feedback provider and will also register with the command predictor interface to give the feedback to the predictive experience. You can read more about predictors in [Using predictors in PSReadLine](https://learn.microsoft.com/powershell/scripting/learn/shell/using-predictors), and [How to create a command line predictor](./create-command-line-predictor.md).

First, you will need to create a new .NET class library project. You can do this by running the following in the project directory:

```powershell

dotnet new classlib --name MyFeedbackProvider
```

You will need to add an `ItemGroup`` to include the `System.Management.Automation` package to your .csproj file. Your .csproj file should look like the following:

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
> Since we are still in preview you may need to change the version of the
> System.Management.Automation to a greater package version. The minimum verison is 7.4.0-preview.3.


You can delete the default `Class.cs` file that is created with the project. You will need to add a
new class file to the project. You can name this file whatever you want. For this example we will
name it `MyFeedbackProvider.cs`. You will need to add the following using statements to the top of
the file:

```csharp

- import SMA namespace
- inherit from IFeedbackProvider
- implement the interface methods
- init the feedback provider

```csharp
TODO Add full code 
```


### Breaking down the code

There is a lot going on in the code above, lets break it down and explain what each part is doing.

You are going to first need and `Init` class that inherits from the `IModuleAssemblyInitializer` and `IModuleAssemblyCleanup` interfaces. This will allow you to register and unregister your feedback provider with the subsystem manager. `OnImport` runs when the binary module is registered with the subsystem and `OnRemove` runs when the binary module is unregistered from the subsystem. 

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

You will need to replace `<ADD YOUR GUID HERE>` with a unique GUID. You can generate a GUID by running the following command in PowerShell:

```powershell
New-Guid
```

This is required to maintain a unique identifier for your feedback provider. It is passed to the constructor of the `myFeedbackProvider` class.

That constructor will only need to assign the passed GUID to a private variable that can be seen here:

```csharp 
private readonly Guid _guid;
public Guid Id => _guid;

// Constructor
internal myFeedbackProvider(string guid)
{
    _guid = new Guid(guid);
}
```

You will need to implement a number of required methods and variables in your feedback provider class.

```csharp
public FeedbackTrigger Trigger => FeedbackTrigger.All;

Dictionary<string, string>? ISubsystem.FunctionsToDefine => null;

// Descriptive values of the feedback provider
public string Name => "myFeedbackProvider"; // is the display name when triggered
public string Description => "This is very simple feedback provider";
```

Now you are ready to implement the main `GetFeedback` method that will be the main trigger for
feedback.

```csharp

```

## Using a feedback provider

Feedback providers will trigger after the defined action has taken place. So if you have designed
your feedback provider to trigger on a success and after a certain command, you will have to have
the module imported and then run the command to verify it is working.

We suggest importing feedback providers in your `$PROFILE` so that they are always available. You can edit your `$PROFILE` by opening it in any text editor or if you have Visual Studio Code installed you can run the following command:

```powershell
code $PROFILE
```

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
> [Using Experimental Features](../learn/experimental-features.md#pssubsystempluginmodel).

## Enhancing feedback provider experience

Another way to enhance users experience with your feedback provider is to make it utilize the
ICommandPredictor interface so the feedback can be given to the users predictor experience. You can
read more about creating a command line predictor in the
[How to create a command line predictor](./create-command-line-predictor.md) article. 

Additionally you can refer to the command-not-found feedback provider repository to see an example
of a feedback provider that utilizes the command line predictor interface.