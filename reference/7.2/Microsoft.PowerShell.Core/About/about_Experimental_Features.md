---
description: The Experimental Features support in PowerShell provides a mechanism for experimental features to coexist with existing stable features in PowerShell or PowerShell modules.
Locale: en-US
ms.date: 03/13/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_experimental_features?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: About experimental features
---
# Experimental Features

The Experimental Features support in PowerShell provides a mechanism for
experimental features to coexist with existing stable features in PowerShell
or PowerShell modules.

An experimental feature is one where the design is not finalized. The feature
is available for users to test and provide feedback. Once an experimental
feature is finalized, the design changes become breaking changes. Experimental
features aren't intended to be used in production since the changes are
allowed to be breaking.

Experimental features are disabled by default and need to be explicitly enabled
by the user or administrator of the system.

Enabled experimental features are listed in the `powershell.config.json` file
in `$PSHOME` for all users or the user-specific configuration file for a
specific user.

> [!NOTE]
> Experimental features enabled in the user configuration file take precedence
> over experimental features listed in the system configuration file.

## The Experimental Attribute

Use the `Experimental` attribute to declare some code as experimental.

Use the following syntax to declare the `Experimental` attribute providing the
name of the experimental feature and the action to take if the experimental
feature is enabled:

```csharp
[Experimental(NameOfExperimentalFeature, ExperimentAction)]
```

For modules, the `NameOfExperimentalFeature` must follow the form of
`<modulename>.<experimentname>`. The `ExperimentAction` parameter must be
specified and the only valid values are:

- `Show` means to show this experimental feature if the feature is enabled
- `Hide` means to hide this experimental feature if the feature is enabled

### Declaring Experimental Features in Modules Written in C\#

Module authors who want to use the Experimental Feature flags can declare a
cmdlet as experimental by using the `Experimental` attribute.

```csharp
[Experimental("MyWebCmdlets.PSWebCmdletV2", ExperimentAction.Show)]
[Cmdlet(Verbs.Invoke, "WebRequest")]
public class InvokeWebRequestCommandV2 : WebCmdletBaseV2 { ... }
```

### Declaring Experimental Features in Modules written in PowerShell

Module written in PowerShell can also use the `Experimental` attribute to
declare experimental cmdlets:

```powershell
function Enable-SSHRemoting {
    [Experimental("MyRemoting.PSSSHRemoting", "Show")]
    [CmdletBinding()]
    param()
    ...
}
```

### Mutually Exclusive Experimental Features

There are cases where an experimental feature cannot co-exist side-by-side with
an existing feature or another experimental feature.

For example, you can have an experimental cmdlet that overrides an existing
cmdlet. The two versions can't coexist side by side. The
`ExperimentAction.Hide` setting allows only one of the two cmdlets to be
enabled at one time.

In this example, we create a new experimental `Invoke-WebRequest` cmdlet.
`InvokeWebRequestCommand` contains the non-experimental implementation.
`InvokeWebRequestCommandV2` contains the experimental version of the cmdlet.

The use of `ExperimentAction.Hide` will allow only one of the two features to
be enabled at one time:

```csharp
[Experimental("MyWebCmdlets.PSWebCmdletV2", ExperimentAction.Show)]
[Cmdlet(Verbs.Invoke, "WebRequest")]
public class InvokeWebRequestCommandV2 : WebCmdletBaseV2 { ... }

[Experimental("MyWebCmdlets.PSWebCmdletV2", ExperimentAction.Hide)]
[Cmdlet(Verbs.Invoke, "WebRequest")]
public class InvokeWebRequestCommand : WebCmdletBase { ... }
```

When the `MyWebCmdlets.PSWebCmdletV2` experimental feature is enabled, the existing
`InvokeWebRequestCommand` implementation is hidden and the
`InvokeWebRequestCommandV2` provides the implementation of
`Invoke-WebRequest`.

This allows users to try out the new cmdlet and provide feedback then revert
to the non-experimental version when needed.

### Experimental Parameters in Cmdlets

The `Experimental` attribute can also be applied to individual parameters. This
allows you to create an experimental set of parameters for an existing cmdlet
rather than an entirely new cmdlet.

Here is an example in C#:

```csharp
[Experimental("MyModule.PSNewAddTypeCompilation", ExperimentAction.Show)]
[Parameter(ParameterSet = "NewCompilation")]
public CompilationParameters CompileParameters { ... }

[Experimental("MyModule.PSNewAddTypeCompilation", ExperimentAction.Hide)]
[Parameter()]
public CodeDom CodeDom { ... }
```

Here is a different example in PowerShell script:

```powershell
param(
    [Experimental("MyModule.PSNewFeature", "Show")]
    [string] $NewName,

    [Experimental("MyModule.PSNewFeature", "Hide")]
    [string] $OldName
)
```

## Checking if an Experimental Feature is Enabled

In your code, you will need to check if your experimental feature is enabled
before taking appropriate action. You can determine if an experimental feature
is enabled using the static `IsEnabled()` method on the
`System.Management.Automation.ExperimentalFeature` class.

Here is an example in C#:

```csharp
if (ExperimentalFeature.IsEnabled("MyModule.MyExperimentalFeature"))
{
   // code specific to the experimental feature
}
```

Here is an example in PowerShell script:

```powershell
if ([ExperimentalFeature]::IsEnabled("MyModule.MyExperimentalFeature"))
{
  # code specific to the experimental feature
}
```

## See also

[Enable-ExperimentalFeature](xref:Microsoft.PowerShell.Core.Enable-ExperimentalFeature)

[Disable-ExperimentalFeature](xref:Microsoft.PowerShell.Core.Disable-ExperimentalFeature)

[Get-ExperimentalFeature](xref:Microsoft.PowerShell.Core.Get-ExperimentalFeature)

