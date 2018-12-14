---
ms.date:  12/14/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Alias Provider
online version:  http://go.microsoft.com/fwlink/?LinkId=834943
---
# Experimental Features

The Experimental Features support in PowerShell is to provide a mechanism for
experimental features to coexist with existing stable features in PowerShell
or PowerShell modules.

An experimental feature is one where the design is not finalized and available
to users to provide feedback.  Once an experimental feature is no longer
experimental, design changes would become breaking changes.  Experimental
features are not intended to be used in production as changes are allowed to
be breaking.

Experimental features are disabled by default and need to be explicitly enabled
by the user or administrator of the system.

Enabled experimental features are listed in the `powershell.config.json` file
in `$PSHOME` for all users or the user specific configuration file for a
specific user.

> [!NOTE]
> If experimental features are enabled in the user configuration file, then
> that will take precedence over any experimental features listed in the system
> configuration file.

## Declaring Experimental Features in Modules written in C#

Module authors who want to leverage the Experimental Feature flags can declare
a cmdlet as experimental by using the `Experimental` attribute:

```csharp
[Experimental("PSWebCmdletV2", ExperimentAction.Show)]
[Cmdlet(Verbs.Invoke, "WebRequest")]
public class InvokeWebRequestCommandV2 : WebCmdletBaseV2 { ... }
```

## Declaring Experimental Features in Modules written in PowerShell

Module written in PowerShell can also use the `Experimental` attribute to
declare experimental cmdlets:

```powershell
function Enable-SSHRemoting {
    [Experimental("PSSSHRemoting", "Show")]
    [CmdletBinding()]
    param()
    ...
}
```

### Mutually Exclusive Experimental Features

In cases where an experimental cmdlet overrides an existing cmdlet and the
two cannot coexist side-by-side.  The use of `ExperimentAction.Hide` can allow
only one of the two cmdlets to be enabled at one time:

```csharp
[Experimental("PSWebCmdletV2", ExperimentAction.Show)]
[Cmdlet(Verbs.Invoke, "WebRequest")]
public class InvokeWebRequestCommandV2 : WebCmdletBaseV2 { ... }

[Experimental("PSWebCmdletV2", ExperimentAction.Hide)]
[Cmdlet(Verbs.Invoke, "WebRequest")]
public class InvokeWebRequestCommand : WebCmdletBase { ... }
```

In this example, there is a newer experimental `Invoke-WebRequest` cmdlet.
If the `PSWebCmdletV2` experimental feature is not enabled, then the non-
experimental `InvokeWebRequestCommand` implements the cmdlet.  However, if
the `PSWebCmdletV2` experimental feature is enabled, then the existing
`InvokeWebRequestCommand` implementation is hidden and the `InvokeWebRequestCommandV2`
is available implementing `Invoke-WebRequest`.  This allows users to try out
the new cmdlet and provide feedback while reverting to the non-experimental
version when needed.

### Experimental Parameters in Cmdlets

If the experimental feature is a new set of parameters on an existing cmdlet
rather than an entirely new cmdlet, the `Experimental` attribute can also be
applied to parameters:

```csharp
[Experimental("PSNewAddTypeCompilation", ExperimentAction.Show)]
[Parameter(ParameterSet = "NewCompilation")]
public CompilationParameters CompileParameters { ... }

[Experimental("PSNewAddTypeCompilation", ExperimentAction.Hide)]
[Parameter()]
public CodeDom CodeDom { ... }
```

```powershell
param(
    [Experimental("PSNewFeature", "Show")]
    [string] $NewName,

    [Experimental("PSNewFeature", "Hide")]
    [string] $OldName
)
```

## See also

[Enable-ExperimentalFeature](../Enable-ExperimentalFeature.md)

[Disable-ExperimentalFeature](../Disable-ExperimentalFeature.md)

[Get-ExperimentalFeature](../Get-ExperimentalFeature.md)
