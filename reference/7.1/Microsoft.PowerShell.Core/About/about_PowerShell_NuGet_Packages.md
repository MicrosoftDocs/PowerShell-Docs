---
keywords: powershell,cmdlet,nuget
locale: en-us
ms.date: 09/27/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pipelines?view=powershell-7.x&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Pipelines
---
# About PowerShell NuGet Packages

## Short Description

Using PowerShell APIs from .NET code by targeting appropriate NuGet packages.

## Long Description

Along with the main application, [pwsh],
PowerShell is also made available in the form of various NuGet packages.
These packages allow other .NET projects to use PowerShell APIs to do things such as
implement PowerShell cmdlets or invoke PowerShell commands and scripts from C# or other .NET code.

Some particular scenarios where a .NET project may need to call PowerShell APIs include:

- **Implementing a PowerShell binary module**.
  This is where cmdlets are implemented in a .NET language such as C#.
  For more information, see [about_Modules].
- **Implementing a PowerShell host**.
  A PowerShell host provides an interaction surface for the PowerShell runtime,
  whereby the object-oriented PowerShell engine can be linked up
  to a textual or graphical presentation layer.
  Examples of this include the PowerShell ConsoleHost, the PowerShell Editor Services Host
  and the PowerShell ISE Host. See [about_PowerShell_Hosts] for more details.
- **Calling PowerShell for some functionalities of a .NET application or library**.
  Sometimes the implementation of a .NET project may find it easiest
  to use PowerShell behind the scenes to implement a feature or service a request.
  Examples of this might be a Windows service or UNIX daemon that uses PowerShell
  to manage machine state, or a web application that runs PowerShell to manage cloud resources.

To serve these scenarios, PowerShell can be targeted through a number of NuGet packages:

- The [PowerShell SDK], which brings the whole implementation of PowerShell
  (i.e. `pwsh`) with it.
- [PowerShell Standard], a façade assembly that has no implementation
  but presents a set of APIs common to PowerShell versions for easier
  cross-platform module development.
- [System.Management.Automation], the core PowerShell engine assembly,
  suitable for some minimal PowerShell integrations.
- The Windows PowerShell reference assembly packages, named like `Microsoft.PowerShell.<version>.ReferenceAssemblies`,
  that provide [façade assemblies] for Windows PowerShell versions
  [3](https://www.nuget.org/packages/Microsoft.PowerShell.3.ReferenceAssemblies/),
  [4](https://www.nuget.org/packages/Microsoft.PowerShell.4.ReferenceAssemblies/),
  and [5](https://www.nuget.org/packages/Microsoft.PowerShell.5.ReferenceAssemblies/).

### The PowerShell SDK

The PowerShell SDK is the largest PowerShell package and contains the entire implementation of PowerShell.
A self-contained .NET application can use the PowerShell SDK to run arbitrary PowerShell functionality
without depending on any external PowerShell installations or libraries.

Targeting the PowerShell SDK NuGet package from a .NET application will allow integration with
all of PowerShell's implementation assemblies, such as `System.Management.Automation`,
`Microsoft.PowerShell.Management` and other module assemblies.

Publishing an application targeting the PowerShell SDK will include
all these assemblies, along with any dependencies PowerShell requires, as well as
other assets that PowerShell requires in its build
such as the module manifests for `Microsoft.PowerShell.*` modules
and the `refs` directory required by [Add-Type].

Given the completeness of the PowerShell SDK, it is best suited for:

- Implementation of PowerShell hosts.
- xUnit testing of libraries targeting PowerShell reference assemblies.
- Invoking PowerShell in-process from a .NET application.

The PowerShell SDK may also be used as a reference assembly
when a .NET project is intended to be used as a module or otherwise loaded by PowerShell,
but depends on APIs only present in a particular version of PowerShell.

> [!NOTE]
> The PowerShell SDK is only available for PowerShell versions 6 and up.
> To provide equivalent functionality with Windows PowerShell,
> use the Windows PowerShell reference assemblies described below.

### PowerShell Standard Library

PowerShell Standard Library is a façade assembly
that captures the intersection of the APIs of some PowerShell versions.
This provides a compile-time-checked API surface to compile .NET code against,
allowing .NET projects to target multiple PowerShell versions
without risking calling an API that won't be there.

PowerShell Standard is intended for writing PowerShell modules,
or other code only intended to be run after loading it into a PowerShell process.
Because it is a façade assembly, PowerShell Standard contains no implementation itself,
so provides no functionality for standalone applications.

Because it provides no implementation, PowerShell Standard should not be published with a build.
If it is published and invoked, it may surface as a `NullReferenceException` due to the default
implementation of the façade assembly.
To prevent this, it is recommended to set the [PrivateAssets attribute](https://docs.microsoft.com/en-us/dotnet/core/tools/csproj#packagereference):

```xml
<PackageReference Include="PowerShellStandard.Library" Version="5.1.0.0" PrivateAssets="all" />
```

There are currently three versions of PowerShell Standard:

- [PowerShell Standard 5.1], which exposes APIs common to Windows PowerShell 5.1,
  PowerShell 6 and PowerShell 7.
- [PowerShell Standard 7], which exposes a richer set of APIs common to Windows PowerShell 5.1
  and PowerShell 7 only, allowing it to expose more of the functionality not present in PowerShell 6.
- [PowerShell Standard 3], which exposes APIs common to Windows PowerShell 3, 4 and 5.1,
  as well as PowerShell 6 and 7. This allows the broadest targeting of PowerShell versions,
  but exposes the fewest APIs as a result.

PowerShell Standard targets the [.NET Standard] target runtime, which is a façade runtime
designed to provide a common surface area shared by .NET Framework and .NET Core.
This allows targeting a single runtime to produce a single assembly that will work
with multiple PowerShell versions, but has the following consequences:

- The PowerShell loading the module or library must be running a minimum of .NET 4.6.1;
  .NET 4.6 and .NET 4.5.2 do not support .NET Standard. Note that a newer Windows PowerShell version
  does not mean a newer .NET Framework version; Windows PowerShell 5.1 may run on .NET 4.5.2.
- In order to work with a PowerShell running .NET Framework 4.7.1 or below,
  the .NET 4.6.1 [NETStandard.Library] implemenation is required
  to provide the netstandard.dll shim assembly for older .NET Framework versions.
- Targeting PowerShells running on different .NET runtimes
  will require the project itself to target the .NET Standard runtime,
  which exposes a common but reduced set of .NET APIs.

> [!CAUTION]
> There is no compile-time check to prevent using APIs not present in older .NET Framework versions
> from being used with .NET Standard.
> Loading an assembly compiled against .NET Standard into a PowerShell running
> on .NET 4.6 or older, or on .NET 4.7.1 or older without netstandard.dll,
> may work initially but could later fail.
> Libraries targeting PowerShell Standard should be evaluated for compatibility
> by testing them with the target PowerShell and .NET Framework versions.

> [!TIP]
> To build PowerShell modules or libraries targeting older .NET Framework versions,
> it may be preferable to target multiple .NET runtimes.
> This will publish an assembly for each target runtime,
> and the correct assembly will need to be loaded at module load time
> (for example with a small psm1 as the root module).

For more information on PowerShell Standard and using it to write a binary module
that works in multiple PowerShell versions, see [this blog post](https://devblogs.microsoft.com/powershell/powershell-standard-library-build-single-module-that-works-across-windows-powershell-and-powershell-core/).

### System.Management.Automation

The PowerShell engine assembly, which contains the core runtime and commands for PowerShell,
is published as a separate NuGet package.
This is primarily to facilitate the way the PowerShell SDK is propagated,
but this package may also be used in particular reduced scenarios:

- For using the PowerShell parser and AST APIs
  in the `System.Management.Automation.Language` namespace
  without executing any PowerShell or otherwise using the PowerShell runtime.
- For minimal PowerShell executions using only the `Microsoft.PowerShell.Core` commands
  and run in a session state created with `InitialSessionState.CreateDefault2()`.
- As a minimal reference assembly for specific versions of the PowerShell engine,
  when references to core module types (in `Microsoft.PowerShell.*` namespaces) are not required.

As with the façade assemblies, if the System.Management.Automation package
is used as a reference assembly, it should be used with `PrivateAssets = "all"`.

### Windows PowerShell reference assemblies

Windows PowerShell (PowerShell versions 5.1 and older) APIs can be targeted
through the Windows PowerShell reference assemblies,
published under the `Microsoft.PowerShell.<version>.ReferenceAssemblies` NuGet packages.

These reference assemblies can be used for targeting specific versions of Windows PowerShell,
just as versions of the PowerShell SDK can be used to target specific versions of PowerShell 6+.

The Windows PowerShell reference assemblies should be used when implementing
a host for Windows PowerShell or for implementing PowerShell modules that require specific
APIs in Windows PowerShell or specific Windows PowerShell versions.

> [!NOTE]
> Because Windows PowerShell is always guaranteed to be present on Windows,
> targeting the Windows PowerShell reference assemblies
> is the same as targeting the Windows PowerShell implementation.

For more information on using the Windows PowerShell reference assemblies,
see [Installing the Windows PowerShell SDK](https://docs.microsoft.com/en-us/powershell/scripting/developer/installing-the-windows-powershell-sdk).

[pwsh.exe]: ./about_pwsh.md
[about_Modules]: ./about_Modules.md
[about_PowerShell_Hosts]: ./about_PowerShell_Hosts.md
[PowerShell SDK]: https://www.nuget.org/packages/Microsoft.PowerShell.SDK/
[PowerShell Standard]: https://www.nuget.org/packages/PowerShellStandard.Library/
[System.Management.Automation]: https://www.nuget.org/packages/System.Management.Automation/
[façade assemblies]: https://github.com/dotnet/standard/blob/master/docs/history/evolution-of-design-time-assemblies.md#definitions
[PowerShell Standard 5.1]: https://www.nuget.org/packages/PowerShellStandard.Library
[PowerShell Standard 7]: ./TODO
[PowerShell Standard 3]: https://www.nuget.org/packages/PowerShellStandard.Library/3.0.0-preview-01
[.NET Standard]: https://docs.microsoft.com/en-us/dotnet/standard/net-standard
[NETStandard.Library]: https://www.nuget.org/packages/NETStandard.Library/
