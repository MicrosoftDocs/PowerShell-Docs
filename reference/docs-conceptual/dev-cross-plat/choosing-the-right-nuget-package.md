---
description: Alongside the executable packages published with each PowerShell release, the PowerShell team also maintains several packages available on NuGet. These packages allow targeting PowerShell as an API platform in .NET.
ms.custom: rjmholt
ms.date: 12/08/2025
title: Choosing the right PowerShell NuGet package for your .NET project
---
# Choosing the right PowerShell NuGet package for your .NET project

Alongside the `pwsh` executable packages published with each PowerShell release, the PowerShell team
also maintains several packages available on [NuGet][18]. These packages allow targeting PowerShell
as an API platform in .NET.

As a .NET application that provides APIs and expects to load .NET libraries implementing its own
(binary modules), it's essential that PowerShell be available in the form of a NuGet package.

Currently there are several NuGet packages that provide some representation of the PowerShell API
surface area. Which package to use with a particular project isn't always clear. This article sheds
some light on a few common scenarios for PowerShell-targeting .NET projects and how to choose the
right NuGet package to target for your PowerShell-oriented .NET project.

## Hosting vs referencing

Some .NET projects seek to write code to be loaded into a preexisting PowerShell runtime (such as
`pwsh`, `powershell.exe`, the PowerShell Integrated Console, or the ISE), while others want to run
PowerShell in their own applications.

- **Referencing** is for when a project, usually a module, is intended to be loaded into PowerShell.
  You must compile the module against the APIs that PowerShell provides in order to interact with
  it. But PowerShell supplies the implementation by loading it in. A project can use
  [reference assemblies][02] or the actual runtime assemblies as a compilation target, but must
  ensure that it doesn't publish any of these assemblies with its build.
- **Hosting** is when a project needs its own implementation of PowerShell, usually because it's a
  standalone application that needs to run PowerShell. In this case, pure reference assemblies
  can't be used. Instead, a concrete PowerShell implementation must be depended upon. Because a
  concrete PowerShell implementation must be used, a specific version of PowerShell must be chosen
  for hosting; a single host application can't multi-target PowerShell versions.

### Publishing projects that target PowerShell as a reference

> [!NOTE]
> We use the term **publish** in this article to refer to running `dotnet publish`, which places a
> .NET library into a directory with all of its dependencies, ready for deployment to a particular
> runtime.

Set the [PrivateAssets][01] attribute to prevent publishing project dependencies that are just being
used as compilation reference targets:

```xml
<PackageReference Include="PowerShellStandard.Library" Version="5.1.0.0" PrivateAssets="all" />
```

If you don't set this attribute and use a reference assembly as your target, you can see issues
related to using the reference assembly's default implementation instead of the actual
implementation. For example, you can receive a `NullReferenceException`, since reference assemblies
often mock the implementation API by returning `null`.

## Key kinds of PowerShell-targeting .NET projects

While any .NET library or application can embed PowerShell, there are some common scenarios that use
PowerShell APIs:

- **Implementing a PowerShell binary module**

  PowerShell binary modules are .NET libraries loaded by PowerShell that must implement PowerShell
  APIs like the [PSCmdlet][31] or [CmdletProvider][30] types in order to expose cmdlets or providers
  respectively. Because they're loaded in, modules seek to compile against references to PowerShell
  without publishing it in their build. It's also common for modules to want to support multiple
  PowerShell versions and platforms, ideally with a minimum of overhead of disk space, complexity,
  or repeated implementation. For more information, see [about_Modules][04].

- **Implementing a PowerShell Host**

  A PowerShell Host provides an interaction layer for the PowerShell runtime. It's a specific form
  of _hosting_, where a [PSHost][28] is implemented as a new user interface to PowerShell. For
  example, the PowerShell ConsoleHost provides a terminal user interface for PowerShell executables,
  while the PowerShell Editor Services Host and the ISE Host both provide an editor-integrated
  partially graphical user interface around PowerShell. While it's possible to load a host onto an
  existing PowerShell process, it's much more common for a host implementation to act as a
  standalone PowerShell implementation that redistributes the PowerShell engine.

- **Calling into PowerShell from another .NET application**

  As with any application, you can call PowerShell as a subprocess to run workloads. However, as a
  .NET application, it's also possible to invoke PowerShell in-process to get back full .NET objects
  for use within the calling application. This is a more general form of _hosting_, where the
  application holds its own PowerShell implementation for internal use. For example, you could
  create a service or daemon running PowerShell to manage machine state, or a web application that
  runs PowerShell on request to do some work like managing cloud deployments.

- **Unit testing PowerShell modules from .NET**

  Usually, modules and other libraries designed to expose functionality to PowerShell should be
  tested from PowerShell. However, it's sometimes necessary to unit test APIs written for a
  PowerShell module from .NET.

## PowerShell NuGet packages at a glance

The following NuGet packages expose PowerShell APIs:

- [PowerShellStandard.Library][24], a reference assembly that enables building a single assembly
  that you can load in multiple PowerShell runtimes.
- [Microsoft.PowerShell.SDK][05], the way to target and rehost the whole PowerShell SDK
- The [System.Management.Automation][25] package, the core PowerShell runtime and engine
  implementation, that can be useful in minimal hosted implementations and for version-specific
  targeting scenarios.
- The **Windows PowerShell reference assemblies**, the way to target and effectively rehost Windows
  PowerShell (PowerShell versions 5.1 and below).

> [!NOTE]
> The [PowerShell NuGet][23] package isn't a .NET library package at all, but instead provides the
> PowerShell dotnet global tool implementation. Don't use this package in any projects, since it
> only provides an executable.

## PowerShellStandard.Library

The PowerShell Standard library is a reference assembly that captures the intersection of the APIs
of PowerShell v7 and v5.1. It provides a compile-time-checked API surface to compile .NET code
against, allowing .NET projects to target PowerShell v7 and v5.1 without risking calling an API that
that's not available.

Use PowerShell Standard to write PowerShell modules or other code only intended to be run after
loading it into a PowerShell process. Because it's a reference assembly, PowerShell Standard
contains no implementation itself, so it provides no functionality for standalone applications.

### Using PowerShell Standard with different .NET runtimes

PowerShell Standard targets the [.NET Standard 2.0][03] target runtime, which is a façade runtime
designed to provide a common surface area shared by .NET Framework and .NET Core. It allows you to
target a single runtime to produce a single assembly that works with multiple PowerShell versions,
but has the following consequences:

- The PowerShell instance loading the module or library must be running a minimum of .NET 4.6.1; .NET 4.6 and
  .NET 4.5.2 don't support .NET Standard.

  > [!NOTE]
  > A newer Windows PowerShell version doesn't mean a newer .NET Framework version. Windows
  > PowerShell 5.1 can run on .NET 4.5.2.

- To work with a PowerShell running .NET Framework 4.7.1 or below, the .NET 4.6.1
  [NETStandard.Library][22] implementation is required to provide the `netstandard.dll` and other
  shim assemblies in older .NET Framework versions.

PowerShell 6 (and higher) provides its own shim assemblies for type forwarding from .NET Framework
4.6.1 (and higher) to .NET Core. As long as a module uses only APIs that exist in .NET Core,
PowerShell 6 (and higher) can load and run it if it was built for .NET Framework 4.6.1 (the `net461`
runtime target).

Binary modules using PowerShell Standard to target multiple PowerShell versions with a single
published DLL have two options:

1. Publishing an assembly built for the `net461` target runtime involves:
   - Publishing the project for the `net461` runtime
   - Also compiling against the `netstandard2.0` runtime (without using its build output) to ensure
     that all APIs used are also present in .NET Core.

1. Publishing an assembly build for the `netstandard2.0` target runtime requires:
   - Publishing the project for the `netstandard2.0` runtime
   - Taking the `net461` dependencies of NETStandard.Library and copying them into the project
     assembly's publish location so that the assembly is type-forwarded corrected in .NET Framework.

To build PowerShell modules or libraries targeting older .NET Framework versions, you might find it
preferable to target multiple .NET runtimes. Doing so publishes an assembly for each target runtime.
The correct assembly must be loaded at module load time, for example with a small `.psm1` file as
the root module.

### Testing PowerShell Standard projects in .NET

When you test your module in .NET with test runners like xUnit, remember that compile-time checks
can only go so far. You must test your module against the relevant PowerShell platforms.

To test APIs built against PowerShell Standard in .NET, you should add `Microsoft.PowerShell.SDK` as
a testing dependency with .NET Core (with the version set to match the desired PowerShell version),
and the appropriate Windows PowerShell reference assemblies with .NET Framework.

For more information on PowerShell Standard and using it to write a binary module that works in
multiple PowerShell versions, see [this blog post][07]. Also see the
[PowerShell Standard repository][12] on GitHub.

## Microsoft.PowerShell.SDK

`Microsoft.PowerShell.SDK` is a meta-package that pulls together all of the components of the
PowerShell SDK into a single NuGet package. A self-contained .NET application can use
Microsoft.PowerShell.SDK to run arbitrary PowerShell functionality without depending on any external
PowerShell installations or libraries.

> [!NOTE]
> The PowerShell SDK just refers to all the component packages that make up PowerShell, and which
> can be used for .NET development with PowerShell.

A given `Microsoft.PowerShell.SDK` version contains the concrete implementation of the same version
of the PowerShell application. Version 7.0 contains the implementation of PowerShell 7.0. Commands
or scripts behave like running them in PowerShell 7.0. However, running PowerShell commands from the
SDK isn't the same as running them from `pwsh`. For example, [Start-Job][26] depends on the `pwsh`
executable being available, so it doesn't work with `Microsoft.PowerShell.SDK` by default.

Targeting `Microsoft.PowerShell.SDK` from a .NET application allows you to integrate with all of
PowerShell's implementation assemblies, such as `System.Management.Automation`,
`Microsoft.PowerShell.Management`, and other module assemblies.

Publishing an application targeting `Microsoft.PowerShell.SDK` includes all these assemblies, and
any dependencies PowerShell requires. It also includes other assets that PowerShell required in its
build, such as the module manifests for `Microsoft.PowerShell.*` modules and the `ref` directory
required by [Add-Type][27].

`Microsoft.PowerShell.SDK` is best suited for:

- Implementation of PowerShell hosts.
- xUnit testing of libraries targeting PowerShell reference assemblies.
- Invoking PowerShell in-process from a .NET application.

You can use `Microsoft.PowerShell.SDK` as a reference target for a .NET project to create a
PowerShell module or assembly loaded by PowerShell that depends on APIs only present in a particular
version of PowerShell. An assembly published for a specific version of `Microsoft.PowerShell.SDK` is
only safe to load and use in that version of PowerShell. To target multiple PowerShell versions with
specific APIs, multiple builds are required, each targeting their own version of
`Microsoft.PowerShell.SDK`.

> [!NOTE]
> The PowerShell SDK is only available for PowerShell v6 and higher. To provide equivalent
> functionality with Windows PowerShell, use the Windows PowerShell reference assemblies described
> later in this article.

## System.Management.Automation

The `System.Management.Automation` package is the heart of the PowerShell SDK. It exists on NuGet,
primarily, as an asset for `Microsoft.PowerShell.SDK` to pull in. However, it can also be used
directly as a package for smaller hosting scenarios and version-targeting modules.

Specifically, the `System.Management.Automation` package is the preferred when:

- You're only looking to use PowerShell language functionality from the
  `System.Management.Automation.Language` namespace, such as the PowerShell parser, AST, and AST
  visitor APIs.
- You only wish to execute specific commands from the `Microsoft.PowerShell.Core` module and can
  execute them in a session state created with the [CreateDefault2][32] factory method.

Additionally, `System.Management.Automation` is a useful reference assembly when:

- You wish to target APIs that are only present within a specific PowerShell version
- You aren't depending on types occurring outside the `System.Management.Automation` assembly, such
  as types exported by cmdlets in `Microsoft.PowerShell.*` modules.

## Windows PowerShell reference assemblies

For Windows PowerShell versions 5.1 and older, there's no SDK to provide an implementation of
PowerShell, since Windows PowerShell's implementation is a part of Windows. Instead, the Windows
PowerShell reference assemblies provide both reference targets and a way to rehost Windows
PowerShell, acting the same as the PowerShell SDK does for version 6 and higher. Windows PowerShell
reference assemblies have a different package for each version of Windows PowerShell:

- [PowerShell 5.1][21]
- [PowerShell 4][20]
- [PowerShell 3][19]

You can find information about how to use the Windows PowerShell reference assemblies in the
[Windows PowerShell SDK][05].

## Real-world examples using these NuGet packages

Different PowerShell tooling projects target different PowerShell NuGet packages depending on their
needs. Listed here are some notable examples.

### PSReadLine

[PSReadLine][13], the PowerShell module that provides much of PowerShell's rich console experience,
targets PowerShell Standard as a dependency rather than a specific PowerShell version, and targets
the `net461` .NET runtime in its [csproj][14].

PowerShell v6 (and higher) supplies its own shim assemblies that allow a DLL targeting the `net461`
runtime to _just work_ when loaded. The shim simplifies the delivery and module layout of
PSReadLine. PowerShell Standard ensures that the module only uses APIs that are available in both
Windows PowerShell 5.1 and PowerShell 6 (and higher), which allows the module to ship with only a
single assembly.

The .NET 4.6.1 target does mean that Windows PowerShell running on .NET 4.5.2 and .NET 4.6 isn't
supported though.

### PowerShell Editor Services

[PowerShell Editor Services][09] (PSES) is the backend for the [PowerShell extension][17] for
[Visual Studio Code][06]. This PowerShell module gets loaded by a PowerShell and then takes over
that process to rehost PowerShell within itself, while also providing Language Service Protocol and
Debug Adapter features.

PSES provides concrete implementation targets for `netcoreapp2.1` to target PowerShell 6+ (since
PowerShell 7's `netcoreapp3.1` runtime is backwards compatible) and `net461` to target Windows
PowerShell 5.1, but contains most of its logic in a second assembly that targets `netstandard2.0`
and PowerShell Standard. This design allows it to pull in dependencies required for .NET Core and
.NET Framework platforms, while still simplifying most of the codebase behind a uniform abstraction.

Because PSES targets PowerShell Standard, it requires a runtime implementation to be tested
correctly. To do this, [PSES's xUnit][11] tests pull in `Microsoft.PowerShell.SDK` and
`Microsoft.PowerShell.5.ReferenceAssemblies` to provide a PowerShell implementation in the test
environment.

Since PSES can't support .NET 4.6 and older, it [performs a check][10] at runtime before calling any
of the APIs that could cause a crash on the lower .NET Framework runtimes.

### PSScriptAnalyzer

[PSScriptAnalyzer][15], the linter for PowerShell, must target syntactic elements only introduced in
certain versions of PowerShell. Because recognition of these syntactic elements is accomplished by
implementing an [AstVisitor2][29], it's not possible to use PowerShellStandard and also implement
AST visitor methods for newer PowerShell syntaxes.

Instead, PSScriptAnalyzer targets each [PowerShell version][16] as a build configuration and
produces a separate DLL for each version. This increases build size and complexity, but allows:

- Version-specific API targeting
- Version-specific functionality to be implemented with essentially no runtime cost
- Total support for Windows PowerShell running on .NET Framework 4.5.2 and higher

## Summary

This article listed and discussed the NuGet packages you can target and the reasons for using each
one. The general recommendations are:

- PowerShell **modules** should compile against PowerShell Standard if they only require APIs common
  to different PowerShell versions.
- PowerShell **hosts and applications** that need to run PowerShell internally should target:
  - The PowerShell SDK for PowerShell v6 and higher
  - Or the relevant Windows PowerShell reference assemblies for Windows PowerShell
- PowerShell modules that need **version-specific APIs** should target the PowerShell SDK or Windows
  PowerShell reference assemblies for the required PowerShell versions. Use them as reference
  assemblies so you don't publish the PowerShell dependencies.

<!--link references -->
[01]: /dotnet/core/tools/csproj#packagereference
[02]: /dotnet/standard/assembly/reference-assemblies
[03]: /dotnet/standard/net-standard
[04]: /powershell/module/microsoft.powershell.core/about/about_modules
[05]: /powershell/scripting/developer/windows-powershell
[06]: https://code.visualstudio.com/
[07]: https://devblogs.microsoft.com/powershell/powershell-standard-library-build-single-module-that-works-across-windows-powershell-and-powershell-core/
[09]: https://github.com/PowerShell/PowerShellEditorServices/
[10]: https://github.com/PowerShell/PowerShellEditorServices/blob/8c500ee1752201d3c1cc2e5d90f1a2af3b1eb15d/src/PowerShellEditorServices.Hosting/EditorServicesLoader.cs#L231-L251
[11]: https://github.com/PowerShell/PowerShellEditorServices/blob/8c500ee1752201d3c1cc2e5d90f1a2af3b1eb15d/test/PowerShellEditorServices.Test/PowerShellEditorServices.Test.csproj#L15-L20
[12]: https://github.com/PowerShell/PowerShellStandard
[13]: https://github.com/PowerShell/PSReadLine
[14]: https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/PSReadLine.csproj
[15]: https://github.com/powershell/psscriptanalyzer
[16]: https://github.com/PowerShell/PSScriptAnalyzer/blob/master/Engine/Engine.csproj
[17]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
[18]: https://www.nuget.org/
[19]: https://www.nuget.org/packages/Microsoft.PowerShell.3.ReferenceAssemblies/
[20]: https://www.nuget.org/packages/Microsoft.PowerShell.4.ReferenceAssemblies/
[21]: https://www.nuget.org/packages/Microsoft.PowerShell.5.ReferenceAssemblies/
[22]: https://www.nuget.org/packages/NETStandard.Library/
[23]: https://www.nuget.org/packages/PowerShell/
[24]: https://www.nuget.org/packages/PowerShellStandard.Library/
[25]: https://www.nuget.org/packages/System.Management.Automation/
[26]: xref:Microsoft.PowerShell.Core.Start-Job
[27]: xref:Microsoft.PowerShell.Utility.Add-Type
[28]: xref:System.Management.Automation.Host.PSHost
[29]: xref:System.Management.Automation.Language.AstVisitor2
[30]: xref:System.Management.Automation.Provider.CmdletProvider
[31]: xref:System.Management.Automation.PSCmdlet
[32]: xref:System.Management.Automation.Runspaces.InitialSessionState.CreateDefault2%2A
