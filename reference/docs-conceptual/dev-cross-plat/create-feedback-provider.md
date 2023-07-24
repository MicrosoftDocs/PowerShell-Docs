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
are trying to execute in the shell. They currently trigger when there is a success or failure of execution. 

## System requirements

To create and use a feedback provider, you must be using the following software versions:

- PowerShell 7.4-preview.2 or higher - includes the feedback provider interface
- .NET 8 SDK 


## Overview of a feedback provider

A feedback provider is a PowerShell binary module. The module must implement the
`using System.Management.Automation.Subsystem.Feedback` interface. This interface
declares the methods used to <TODO>

TODO: Architecture?

## Creating the code

You must have .NET 8 SDK installed to create a feedback provider. For more information on the SDK
see [Download .NET 8.0](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)

<TODO: 
- have trigger on any success
- have trigger on success of particular command 
>


## Using a feedback provider

Feedback providers will trigger after the defined action has taken place. So if you have designed
your feedback provider to trigger on a success and after a certain command, you will have to have
the module imported and then run the command to verify it is working.

We suggest importing feedback providers in your `$PROFILE` so that they are always available. You can edit your `$PROFILE` by opening it in any text editor or if you have Visual Studio Code installed you can run the following command:

```powershell
code $PROFILE
```

You can get a list of installed predictors, using the following command:

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