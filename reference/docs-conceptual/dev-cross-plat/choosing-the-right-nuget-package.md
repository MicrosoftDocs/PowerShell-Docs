---
description: Alongside the executable packages published with each PowerShell release, the PowerShell team also maintains several packages available on NuGet. These packages allow targeting PowerShell as an API platform in .NET.
ms.custom: rjmholt
ms.date: 11/16/2022
title: Choosing the right PowerShell NuGet package for your .NET project
---
# Choosing the right PowerShell NuGet package for your .NET project

Alongside the `pwsh` executable packages published with each PowerShell release, the PowerShell team
also maintains several packages available on [NuGet][25]. These packages allow targeting PowerShell
as an API platform in .NET.

As a .NET application that provides APIs and expects to load .NET libraries implementing its own
(binary modules), it's essential that PowerShell be available in the form of a NuGet package.

Currently there are several NuGet packages that provide some representation of the PowerShell API
surface area. Which package to use with a particular project hasn't always been made clear. This
article sheds some light on a few common scenarios for PowerShell-targeting .NET projects and how to
choose the right NuGet package to target for your PowerShell-oriented .NET project.

## Hosting vs referencing

Some .NET projects seek to write code to be loaded into a pre-existing PowerShell runtime (such as
`pwsh`, `powershell.exe`, the PowerShell Integrated Console or the ISE), while others want to run
PowerShell in their own applications.

- **Referencing** is for when a project, usually a module, is intended to be loaded into PowerShell.
  It must be compiled against the APIs that PowerShell provides in order to interact with it, but
  the PowerShell implementation is supplied by the PowerShell process loading it in. For
  referencing, a project can use [reference assemblies][07] or the actual runtime assemblies as a
  compilation target, but must ensure that it does not publish any of these with its build.
- **Hosting** is when a project needs its own implementation of PowerShell, usually because it is a
  standalone application that needs to run PowerShell. In this case, pure reference assemblies
  cannot be used. Instead, a concrete PowerShell implementation must be depended upon. Because a
  concrete PowerShell implementation must be used, a specific version of PowerShell must be chosen
  for hosting; a single host application cannot multi-target PowerShell versions.

### Publishing projects that target PowerShell as a reference

> [!NOTE]
> We use the term **publish** in this article to refer to running `dotnet publish`, which places a
> .NET library into a directory with all of its dependencies, ready for deployment to a particular
> runtime.

In order to prevent publishing project dependencies that are just being used as compilation
reference targets, it is recommended to set the [PrivateAssets][06] attribute:

```xml
<PackageReference Include="PowerShellStandard.Library" Version="5.1.0.0" PrivateAssets="all" />
```

If you forget to do this and use a reference assembly as your target, you may see issues related to
using the reference assembly's default implementation instead of the actual implementation. This may
take the form of a `NullReferenceException`, since reference assemblies often mock the
implementation API by simply returning `null`.

## Key kinds of PowerShell-targeting .NET projects

While any .NET library or application can embed PowerShell, there are some common scenarios that use
PowerShell APIs:

- **Implementing a PowerShell binary module**

  PowerShell binary modules are .NET libraries loaded by PowerShell that must implement PowerShell
  APIs like the [PSCmdlet][04] or [CmdletProvider][03] types in order to expose cmdlets or providers
  respectively. Because they are loaded in, modules seek to compile against references to PowerShell
  without publishing it in their build. It's also common for modules to want to support multiple
  PowerShell versions and platforms, ideally with a minimum of overhead of disk space, complexity,
  or repeated implementation. See [about_Modules][09] for more information about modules.

- **Implementing a PowerShell Host**

  A PowerShell Host provides an interaction layer for the PowerShell runtime. It is a specific form
  of _hosting_, where a [PSHost][01] is implemented as a new user interface to PowerShell. For
  example, the PowerShell ConsoleHost provides a terminal user interface for PowerShell executables,
  while the PowerShell Editor Services Host and the ISE Host both provide an editor-integrated
  partially graphical user interface around PowerShell. While it's possible to load a host onto an
  existing PowerShell process, it's much more common for a host implementation to act as a
  standalone PowerShell implementation that redistributes the PowerShell engine.

- **Calling into PowerShell from another .NET application**

  As with any application, PowerShell can be called as a subprocess to run workloads. However, as a
  .NET application, it's also possible to invoke PowerShell in-process to get back full .NET objects
  for use within the calling application. This is a more general form of _hosting_, where the
  application holds its own PowerShell implementation for internal use. Examples of this might be a
  service or daemon running PowerShell to manage machine state or a web application that runs
  PowerShell on request to do something like manage cloud deployments.

- **Unit testing PowerShell modules from .NET**

  While modules and other libraries designed to expose functionality to PowerShell should be
  primarily tested from PowerShell (we recommend [Pester][15]), sometimes it's necessary to unit
  test APIs written for a PowerShell module from .NET. This situation involves the module code
  trying to target a number of PowerShell versions, while testing should run it on specific,
  concrete implementations.

## PowerShell NuGet packages at a glance

In this article, we'll cover the following NuGet packages
that expose PowerShell APIs:

- [PowerShellStandard.Library][31], a reference assembly that enables building a single assembly
  that can be loaded by multiple PowerShell runtimes.
- [Microsoft.PowerShell.SDK][12], the way to target and rehost the whole PowerShell SDK
- The [System.Management.Automation][32] package, the core PowerShell runtime and engine
  implementation, that can be useful in minimal hosted implementations and for version-specific
  targeting scenarios.
- The **Windows PowerShell reference assemblies**, the way to target and effectively rehost Windows
  PowerShell (PowerShell versions 5.1 and below).

> [!NOTE]
> The [PowerShell NuGet][30] package is not a .NET library package at all, but instead provides the
> PowerShell dotnet global tool implementation. This should not be used by any projects, since it
> only provides an executable.

## PowerShellStandard.Library

The PowerShell Standard library is a reference assembly that captures the intersection of the APIs
of PowerShell versions 7, 6 and 5.1. This provides a compile-time-checked API surface to compile
.NET code against, allowing .NET projects to target PowerShell versions 7, 6 and 5.1 without risking
calling an API that won't be there.

PowerShell Standard is intended for writing PowerShell modules, or other code only intended to be
run after loading it into a PowerShell process. Because it is a reference assembly, PowerShell
Standard contains no implementation itself, so provides no functionality for standalone
applications.

### Using PowerShell Standard with different .NET runtimes

PowerShell Standard targets the [.NET Standard 2.0][08] target runtime, which is a façade runtime
designed to provide a common surface area shared by .NET Framework and .NET Core. This allows
targeting a single runtime to produce a single assembly that will work with multiple PowerShell
versions, but has the following consequences:

- The PowerShell loading the module or library must be running a minimum of .NET 4.6.1; .NET 4.6 and
  .NET 4.5.2 do not support .NET Standard. Note that a newer Windows PowerShell version does not
  mean a newer .NET Framework version; Windows PowerShell 5.1 may run on .NET 4.5.2.
- In order to work with a PowerShell running .NET Framework 4.7.1 or below, the .NET 4.6.1
  [NETStandard.Library][29] implementation is required to provide the netstandard.dll and other shim
  assemblies in older .NET Framework versions.

PowerShell 6+ provides its own shim assemblies for type forwarding from .NET Framework 4.6.1 (and
above) to .NET Core. This means that as long as a module uses only APIs that exist in .NET Core,
PowerShell 6+ can load and run it when it has been built for .NET Framework 4.6.1 (the `net461`
runtime target).

This means that binary modules using PowerShell Standard to target multiple PowerShell versions with
a single published DLL have two options:

1. Publishing an assembly built for the `net461` target runtime. This involves:
   - Publishing the project for the `net461` runtime
   - Also compiling against the `netstandard2.0` runtime (without using its build output) to ensure
     that all APIs used are also present in .NET Core.

1. Publishing an assembly build for the `netstandard2.0` target runtime. This requires:
   - Publishing the project for the `netstandard2.0` runtime
   - Taking the `net461` dependencies of NETStandard.Library and copying them into the project
     assembly's publish location so that the assembly is type-forwarded corrected in .NET Framework.

To build PowerShell modules or libraries targeting older .NET Framework versions, it may be
preferable to target multiple .NET runtimes. This will publish an assembly for each target runtime,
and the correct assembly will need to be loaded at module load time (for example with a small psm1
as the root module).

### Testing PowerShell Standard projects in .NET

When it comes to testing your module in .NET test runners like xUnit, remember that compile-time
checks can only go so far. You must test your module against the relevant PowerShell platforms.

To test APIs built against PowerShell Standard in .NET, you should add `Microsoft.Powershell.SDK` as
a testing dependency with .NET Core (with the version set to match the desired PowerShell version),
and the appropriate Windows PowerShell reference assemblies with .NET Framework.

For more information on PowerShell Standard and using it to write a binary module that works in
multiple PowerShell versions, see [this blog post][14]. Also see the
[PowerShell Standard repository][19] on GitHub.

## Microsoft.PowerShell.SDK

`Microsoft.PowerShell.SDK` is a meta-package that pulls together all of the components of the
PowerShell SDK into a single NuGet package. A self-contained .NET application can use
Microsoft.PowerShell.SDK to run arbitrary PowerShell functionality without depending on any external
PowerShell installations or libraries.

> [!NOTE]
> The PowerShell SDK just refers to all the component packages that make up PowerShell, and which
> can be used for .NET development with PowerShell.

A given `Microsoft.Powershell.SDK` version contains the concrete implementation of the same version
of the PowerShell application; version 7.0 contains the implementation of PowerShell 7.0 and running
commands or scripts with it will largely behave like running them in PowerShell 7.0.

Running PowerShell commands from the SDK is mostly, but not totally, the same as running them from
`pwsh`. For example, [Start-Job][10] currently depends on the `pwsh` executable being available, and
so will not work with `Microsoft.Powershell.SDK` by default.

Targeting `Microsoft.Powershell.SDK` from a .NET application allows you to integrate with all of
PowerShell's implementation assemblies, such as `System.Management.Automation`,
`Microsoft.PowerShell.Management`, and other module assemblies.

Publishing an application targeting `Microsoft.Powershell.SDK` will include all these assemblies,
and any dependencies PowerShell requires. It will also include other assets that PowerShell required
in its build, such as the module manifests for `Microsoft.PowerShell.*` modules and the `ref`
directory required by [Add-Type][11].

Given the completeness of `Microsoft.Powershell.SDK`, it's best suited for:

- Implementation of PowerShell hosts.
- xUnit testing of libraries targeting PowerShell reference assemblies.
- Invoking PowerShell in-process from a .NET application.

`Microsoft.PowerShell.SDK` may also be used as a reference target when a .NET project is intended to
be used as a module or otherwise loaded by PowerShell, but depends on APIs only present in a
particular version of PowerShell. Note that an assembly published against a specific version of
`Microsoft.PowerShell.SDK` will only be safe to load and use in that version of PowerShell. To
target multiple PowerShell versions with specific APIs, multiple builds are required, each targeting
their own version of `Microsoft.Powershell.SDK`.

> [!NOTE]
> The PowerShell SDK is only available for PowerShell versions 6 and up. To provide equivalent
> functionality with Windows PowerShell, use the Windows PowerShell reference assemblies described
> below.

## System.Management.Automation

The `System.Management.Automation` package is the heart of the PowerShell SDK. It exists on NuGet,
primarily, as an asset for `Microsoft.Powershell.SDK` to pull in. However, it can also be used
directly as a package for smaller hosting scenarios and version-targeting modules.

Specifically, the `System.Management.Automation` package may be a preferable provider of PowerShell
functionality when:

- You're only looking to use PowerShell language functionality (in the
  `System.Management.Automation.Language` namespace) like the PowerShell parser, AST, and AST
  visitor APIs (for example for static analysis of PowerShell).
- You only wish to execute specific commands from the `Microsoft.PowerShell.Core` module and can
  execute them in a session state created with the [CreateDefault2][05] factory method.

Additionally, `System.Management.Automation` is a useful reference assembly when:

- You wish to target APIs that are only present within a specific PowerShell version
- You won't be depending on types occurring outside the `System.Management.Automation` assembly (for
  example, types exported by cmdlets in `Microsoft.PowerShell.*` modules).

## Windows PowerShell reference assemblies

For PowerShell versions 5.1 and older (Windows PowerShell), there is no SDK to provide an
implementation of PowerShell, since Windows PowerShell's implementation is a part of Windows.

Instead, the Windows PowerShell reference assemblies provide both reference targets and a way to
rehost Windows PowerShell, acting the same as the PowerShell SDK does for versions 6 and up.

Rather than being differentiated by version, Windows PowerShell reference assemblies have a
different package for each version of Windows PowerShell:

- [PowerShell 5.1][28]
- [PowerShell 4][27]
- [PowerShell 3][26]

Information on how to use the Windows PowerShell reference assemblies can be found in the
[Windows PowerShell SDK][12].

## Real-world examples using these NuGet packages

Different PowerShell tooling projects target different PowerShell NuGet packages depending on their
needs. Listed here are some notable examples.

### PSReadLine

[PSReadLine][20], the PowerShell module that provides much of PowerShell's rich console experience,
targets PowerShell Standard as a dependency rather than a specific PowerShell version, and targets
the `net461` .NET runtime in its [csproj][21].

PowerShell 6+ supplies its own shim assemblies that allow a DLL targeting the `net461` runtime to
"just work" when loaded in (by redirecting binding to .NET Framework's `mscorlib.dll` to the
relevant .NET Core assembly).

This simplifies PSReadLine's module layout and delivery significantly, since PowerShell Standard
ensures the only APIs used will be present in both PowerShell 5.1 and PowerShell 6+, while also
allowing the module to ship with only a single assembly.

The .NET 4.6.1 target does mean that Windows PowerShell running on
.NET 4.5.2 and .NET 4.6 is not supported though.

### PowerShell Editor Services

[PowerShell Editor Services][16] (PSES) is the backend for the [PowerShell extension][24] for
[Visual Studio Code][13], and is actually a form of PowerShell module that gets loaded by a
PowerShell executable and then takes over that process to rehost PowerShell within itself while also
providing Language Service Protocol and Debug Adapter features.

PSES provides concrete implementation targets for `netcoreapp2.1` to target PowerShell 6+ (since
PowerShell 7's `netcoreapp3.1` runtime is backwards compatible) and `net461` to target Windows
PowerShell 5.1, but contains most of its logic in a second assembly that targets `netstandard2.0`
and PowerShell Standard. This allows it to pull in dependencies required for .NET Core and .NET
Framework platforms, while still simplifying most of the codebase behind a uniform abstraction.

Because it is built against PowerShell Standard, PSES requires a runtime implementation of
PowerShell in order to be tested correctly. To do this, [PSES's xUnit][18] tests pull in
`Microsoft.PowerShell.SDK` and `Microsoft.PowerShell.5.ReferenceAssemblies` in order to provide a
PowerShell implementation in the test environment.

As with PSReadLine, PSES cannot support .NET 4.6 and below, but it [performs a check][17] at runtime
before calling any of the APIs that could cause a crash on the lower .NET Framework runtimes.

### PSScriptAnalyzer

[PSScriptAnalyzer][22], the linter for PowerShell, must target syntactic elements only introduced in
certain versions of PowerShell. Because recognition of these syntactic elements is accomplished by
implementing an [AstVisitor2][02], it's not possible to use PowerShellStandard and also implement
AST visitor methods for newer PowerShell syntaxes.

Instead, PSScriptAnalyzer [targets each PowerShell version][23] as a build configuration, and
produces a separate DLL for each of them. This increases build size and complexity, but allows:

- Version-specific API targeting
- Version-specific functionality to be implemented with essentially no runtime cost
- Total support for Windows PowerShell all the way down to .NET Framework 4.5.2

## Summary

In this article, we've listed and discussed the NuGet packages available to target when implementing
a .NET project that uses PowerShell, and the reasons you might have for using one over another.

If you've skipped to the summary, some broad recommendations are:

- PowerShell **modules** should compile against PowerShell Standard if they only require APIs common
  to different PowerShell versions.
- PowerShell **hosts and applications** that need to run PowerShell internally should target the
  PowerShell SDK for PowerShell 6+ or the relevant Windows PowerShell reference assemblies for
  Windows PowerShell.
- PowerShell modules that need **version-specific APIs** should target the PowerShell SDK or Windows
  PowerShell reference assemblies for the required PowerShell versions, using them as reference
  assemblies (that is, not publishing the PowerShell dependencies).

<!--link references -->
[01]: /dotnet/api/system.management.automation.host.pshost
[02]: /dotnet/api/system.management.automation.language.astvisitor2
[03]: /dotnet/api/system.management.automation.provider.cmdletprovider
[04]: /dotnet/api/system.management.automation.pscmdlet
[05]: /dotnet/api/system.management.automation.runspaces.initialsessionstate.createdefault2
[06]: /dotnet/core/tools/csproj#packagereference
[07]: /dotnet/standard/assembly/reference-assemblies
[08]: /dotnet/standard/net-standard
[09]: /powershell/module/microsoft.powershell.core/about/about_modules
[10]: /powershell/module/microsoft.powershell.core/start-job
[11]: /powershell/module/microsoft.powershell.utility/add-type
[12]: /powershell/scripting/developer/windows-powershell
[13]: https://code.visualstudio.com/
[14]: https://devblogs.microsoft.com/powershell/powershell-standard-library-build-single-module-that-works-across-windows-powershell-and-powershell-core/
[15]: https://github.com/Pester/Pester
[16]: https://github.com/PowerShell/PowerShellEditorServices/
[17]: https://github.com/PowerShell/PowerShellEditorServices/blob/8c500ee1752201d3c1cc2e5d90f1a2af3b1eb15d/src/PowerShellEditorServices.Hosting/EditorServicesLoader.cs#L231-L251
[18]: https://github.com/PowerShell/PowerShellEditorServices/blob/8c500ee1752201d3c1cc2e5d90f1a2af3b1eb15d/test/PowerShellEditorServices.Test/PowerShellEditorServices.Test.csproj#L15-L20
[19]: https://github.com/PowerShell/PowerShellStandard
[20]: https://github.com/PowerShell/PSReadLine
[21]: https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/PSReadLine.csproj
[22]: https://github.com/powershell/psscriptanalyzer
[23]: https://github.com/PowerShell/PSScriptAnalyzer/blob/master/Engine/Engine.csproj
[24]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
[25]: https://www.nuget.org/
[26]: https://www.nuget.org/packages/Microsoft.PowerShell.3.ReferenceAssemblies/
[27]: https://www.nuget.org/packages/Microsoft.PowerShell.4.ReferenceAssemblies/
[28]: https://www.nuget.org/packages/Microsoft.PowerShell.5.ReferenceAssemblies/
[29]: https://www.nuget.org/packages/NETStandard.Library/
[30]: https://www.nuget.org/packages/PowerShell/
[31]: https://www.nuget.org/packages/PowerShellStandard.Library/
[32]: https://www.nuget.org/packages/System.Management.Automation/
