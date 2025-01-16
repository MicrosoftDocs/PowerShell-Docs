---
description: When writing a binary PowerShell module in C#, it's natural to take dependencies on other packages or libraries to provide functionality.
ms.custom: rjmholt
ms.date: 08/08/2022
title: Resolving PowerShell module assembly dependency conflicts
---
# Resolving PowerShell module assembly dependency conflicts

When writing a binary PowerShell module in C#, it's natural to take dependencies on other packages
or libraries to provide functionality. Taking dependencies on other libraries is desirable for code
reuse. PowerShell always loads assemblies into the same context. This presents issues when a
module's dependencies conflict with already-loaded DLLs and may prevent using two otherwise
unrelated modules in the same PowerShell session.

If you've had this problem, you've seen an error message like this:

![Assembly load conflict error message][1]

This article looks at some ways dependency conflicts occur in PowerShell and ways to mitigate
dependency conflict issues. Even if you're not a module author, there are some tricks in here that
might help you with dependency conflicts occurring in modules that you use.

## Why do dependency conflicts occur?

In .NET, dependency conflicts occur when two versions of the same assembly are loaded into the same
_Assembly Load Context_. This term means slightly different things on different .NET platforms,
which is covered [later][2] in this article. This conflict is a common problem that occurs in any
software where versioned dependencies are used.

Conflict issues are compounded by the fact that a project almost never deliberately or directly
depends on two versions of the same dependency. Instead, the project has two or more dependencies
that each require a different version of the same dependency.

For example, say your .NET application, `DuckBuilder`, brings in two dependencies, to perform parts
of its functionality and looks like this:

![Two dependencies of DuckBuilder rely on different versions of Newtonsoft.Json][3]

Because `Contoso.ZipTools` and `Fabrikam.FileHelpers` both depend on different versions of
**Newtonsoft.Json**, there may be a dependency conflict depending on how each dependency is loaded.

### Conflicting with PowerShell's dependencies

In PowerShell, the dependency conflict issue is magnified because PowerShell's own dependencies are
loaded into the same shared context. This means the PowerShell engine and all loaded PowerShell
modules must not have conflicting dependencies. A classic example of this is **Newtonsoft.Json**:

![FictionalTools module depends on newer version of Newtonsoft.Json than PowerShell][4]

In this example, the module `FictionalTools` depends on **Newtonsoft.Json** version `12.0.3`, which is
a newer version of **Newtonsoft.Json** than `11.0.2` that ships in the example PowerShell.

> [!NOTE]
> This is an example. PowerShell 7.0 currently ships with **Newtonsoft.Json 12.0.3**. Newer versions
> of PowerShell have newer versions of **Newtonsoft.Json**.

Because the module depends on a newer version of the assembly, it won't accept the version that
PowerShell already has loaded. But because PowerShell has already loaded a version of the assembly,
the module can't load its own version using the conventional load mechanism.

### Conflicting with another module's dependencies

Another common scenario in PowerShell is that a module is loaded that depends on one version of an
assembly, and then another module is loaded later that depends on a different version of that
assembly.

This often looks like the following:

![Two PowerShell modules require different versions of the Microsoft.Extensions.Logging dependency][5]

In this case, the `FictionalTools` module requires a newer version of `Microsoft.Extensions.Logging`
than the `FilesystemManager` module.

Imagine these modules load their dependencies by placing the dependency assemblies in the same
directory as the root module assembly. This allows .NET to implicitly load them by name. If we're
running PowerShell 7.0 (on top of .NET Core 3.1), we can load and run `FictionalTools`, then load
and run `FilesystemManager` without issue. However, in a new session, if we load and run
`FilesystemManager`, then load `FictionalTools`, we get a `FileLoadException` from the
`FictionalTools` command because it requires a newer version of `Microsoft.Extensions.Logging` than
the one loaded. `FictionalTools` can't load the version needed because an assembly of the same name
has already been loaded.

## PowerShell and .NET

PowerShell runs on the .NET platform, which is responsible for resolving and loading assembly
dependencies. We must understand how .NET operates here to understand dependency conflicts.

We must also confront the fact that different versions of PowerShell run on different .NET
implementations. In general, PowerShell 5.1 and below run on .NET Framework, while PowerShell 6 and
above run on .NET Core. These two implementations of .NET load and handle assemblies differently.
This means that resolving dependency conflicts can vary depending on the underlying .NET platform.

### Assembly Load Contexts

In .NET, an _Assembly Load Context_ (ALC) is a runtime namespace into which assemblies are loaded.
The assemblies' names must be unique. This concept allows assemblies to be uniquely resolved by name
in each ALC.

### Assembly reference loading in .NET

The semantics of assembly loading depend on both the .NET implementation (.NET Core vs .NET
Framework) and the .NET API used to load a particular assembly. Rather than go into detail here,
there are links in the [Further reading][6] section that go into great detail on how .NET assembly
loading works in each .NET implementation.

In this article we'll refer to the following mechanisms:

- Implicit assembly loading (effectively `Assembly.Load(AssemblyName)`), when .NET implicitly tries
  to load an assembly by name from a static assembly reference in .NET code.
- `Assembly.LoadFrom()`, a plugin-oriented loading API that adds handlers to resolve dependencies of
  the loaded DLL. This method may not resolve dependencies the way we want.
- `Assembly.LoadFile()`, a basic loading API intended to load only the assembly asked for and does
  not handle any dependencies.

### Differences in .NET Framework vs .NET Core

The way these APIs work has changed in subtle ways between .NET Core and .NET Framework, so it's
worth reading through the included [links][7]. Importantly, Assembly Load Contexts and other
assembly resolution mechanisms have changed between .NET Framework and .NET Core.

In particular, .NET Framework has the following features:

- The Global Assembly Cache, for machine-wide assembly resolution
- Application Domains, which work like in-process sandboxes for assembly isolation, but also present
  a serialization layer to contend with
- A limited assembly load context model that has a fixed set of assembly load contexts, each with
  their own behavior:
  - The default load context, where assemblies are loaded by default
  - The load-from context, for loading assemblies manually at runtime
  - The reflection-only context, for safely loading assemblies
    to read their metadata without running them
  - The mysterious void that assemblies loaded with `Assembly.LoadFile(string path)` and
    `Assembly.Load(byte[] asmBytes)` live in

For more information, see [Best Practices for Assembly Loading][8].

.NET Core (and .NET 5+) has replaced this complexity with a simpler model:

- No Global Assembly Cache. Applications bring all their own dependencies. This removes an external
  factor for dependency resolution in applications, making dependency resolution more reproducible.
  PowerShell, as the plugin host, complicates this slightly for modules. Its dependencies in
  `$PSHOME` are shared with all modules.
- Only one Application Domain, and no ability to create new ones. The Application Domain concept
  is maintained in .NET to be the global state of the .NET process.
- A new, extensible Assembly Load Context (ALC) model. Assembly resolution can be namespaced by putting it
  in a new ALC. .NET processes begin with a single default ALC into which all assemblies are
  loaded (except for those loaded with `Assembly.LoadFile(string)` and `Assembly.Load(byte[])`). But
  the process can create and define its own custom ALCs with its own loading logic. When an assembly
  is loaded, the first ALC it's loaded into is responsible for resolving its dependencies. This
  creates opportunities to implement powerful .NET plugin loading mechanisms.

In both implementations, assemblies are loaded lazily. This means that they're loaded when a method
requiring their type is run for the first time.

For example, here are two versions of the same code that load a dependency at different times.

The first always loads its dependency when `Program.GetRange()` is called, because the dependency
reference is lexically present within the method:

```csharp
using Dependency.Library;

public static class Program
{
    public static List<int> GetRange(int limit)
    {
        var list = new List<int>();
        for (int i = 0; i < limit; i++)
        {
            if (i >= 20)
            {
                // Dependency.Library will be loaded when GetRange is run
                // because the dependency call occurs directly within the method
                DependencyApi.Use();
            }

            list.Add(i);
        }
        return list;
    }
}
```

The second loads its dependency only if the `limit` parameter is 20 or more, because of the internal
indirection through a method:

```csharp
using Dependency.Library;

public static class Program
{
    public static List<int> GetNumbers(int limit)
    {
        var list = new List<int>();
        for (int i = 0; i < limit; i++)
        {
            if (i >= 20)
            {
                // Dependency.Library is only referenced within
                // the UseDependencyApi() method,
                // so will only be loaded when limit >= 20
                UseDependencyApi();
            }

            list.Add(i);
        }
        return list;
    }

    private static void UseDependencyApi()
    {
        // Once UseDependencyApi() is called, Dependency.Library is loaded
        DependencyApi.Use();
    }
}
```

This is a good practice since it minimizes the memory and filesystem I/O and uses the resources more
efficiently. The unfortunate a side effect of this is that we won't know that the assembly fails to
load until we reach the code path that tries to load the assembly.

It can also create a timing condition for assembly load conflicts. If two parts of the same program
try to load different versions of the same assembly, the version loaded depends on which code path
is run first.

For PowerShell, this means that the following factors can affect an assembly load conflict:

- Which module was loaded first?
- Was the code path that uses the dependency library run?
- Does PowerShell load a conflicting dependency at startup or only under certain code paths?

## Quick fixes and their limitations

In some cases, it's possible to make small adjustments to your module and fix things with minimal
effort. But these solutions tend to come with caveats. While they may apply to your module, they
won't work for every module.

### Change your dependency version

The simplest way to avoid dependency conflicts is to agree on a dependency. This may be possible
when:

- Your conflict is with a direct dependency of your module and you control the version.
- Your conflict is with an indirect dependency, but you can configure your direct dependencies to
  use a workable indirect dependency version.
- You know the conflicting version and can rely on it not changing.

The **Newtonsoft.Json** package is a good example of this last scenario. This is a dependency of
PowerShell 6 and above, and isn't used in Windows PowerShell. Meaning a simple way to resolve
versioning conflicts is to target the lowest version of **Newtonsoft.Json** across the PowerShell
versions you wish to target.

For example, PowerShell 6.2.6 and PowerShell 7.0.2 both currently use **Newtonsoft.Json** version
12.0.3. To create a module targeting Windows PowerShell, PowerShell 6, and PowerShell 7, you would
target **Newtonsoft.Json 12.0.3** as a dependency and include it in your built module. When the
module is loaded in PowerShell 6 or 7, PowerShell's own **Newtonsoft.Json** assembly is already
loaded. Since it's the version required for your module, resolution succeeds. In Windows PowerShell,
the assembly isn't already present in PowerShell, so it's loaded from your module folder instead.

Generally, when targeting a concrete PowerShell package, like **Microsoft.PowerShell.Sdk** or
**System.Management.Automation**, NuGet should be able to resolve the right dependency versions
required. Targeting both Windows PowerShell and PowerShell 6+ becomes more difficult because you
must choose between targeting multiple frameworks or **PowerShellStandard.Library**.

Circumstances where pinning to a common dependency version won't work include:

- The conflict is with an indirect dependency, and none of your dependencies can be configured to
  use a common version.
- The other dependency version is likely to change often, so settling on a common version is only a
  short-term fix.

### Use the dependency out of process

This solution is more for module users than module authors. This is a solution to use when
confronted with a module that won't work due to an existing dependency conflict.

Dependency conflicts occur because two versions of the same assembly are loaded into the same .NET
process. A simple solution is to load them into different processes, as long as you can still
use the functionality from both together.

In PowerShell, there are several ways to achieve this:

- Invoke PowerShell as a subprocess

  To run a PowerShell command out of the current process, start a new PowerShell process directly
  with the command call:

  ```powershell
  pwsh -c 'Invoke-ConflictingCommand'
  ```

  The main limitation here is that restructuring the result can be trickier or more error prone than
  other options.

- The PowerShell job system

  The PowerShell job system also runs commands out of process, by sending commands to a new
  PowerShell process and returning the results:

  ```powershell
  $result = Start-Job { Invoke-ConflictingCommand } | Receive-Job -Wait
  ```

  In this case, you just need to be sure that any variables and state are passed in correctly.

  The job system can also be slightly cumbersome when running small commands.

- PowerShell remoting

  When it's available, PowerShell remoting can be a useful way to run commands out of process. With
  remoting, you can create a fresh **PSSession** in a new process, call its commands over PowerShell
  remoting, then use the results locally with the other modules containing the conflicting
  dependencies.

  An example might look like this:

  ```powershell
  # Create a local PowerShell session
  # where the module with conflicting assemblies will be loaded
  $s = New-PSSession

  # Import the module with the conflicting dependency via remoting,
  # exposing the commands locally
  Import-Module -PSSession $s -Name ConflictingModule

  # Run a command from the module with the conflicting dependencies
  Invoke-ConflictingCommand
  ```

- Implicit remoting to Windows PowerShell

  Another option in PowerShell 7 is to use the `-UseWindowsPowerShell` flag on `Import-Module`. This
  imports the module through a local remoting session into Windows PowerShell:

  ```powershell
  Import-Module -Name ConflictingModule -UseWindowsPowerShell
  ```

  Be aware that modules may not be compatible with or may work differently with Windows PowerShell.

#### When out-of-process invocation should not be used

As a module author, out-of-process command invocation is difficult to bake into a module and may
have edge cases that cause issues. In particular, remoting and jobs may not be available in all
environments where your module needs to work. However, the general principle of moving the
implementation out of process and allowing the PowerShell module to be a thinner client, may still
be applicable.

As a module user, there are cases where out-of-process invocation won't work:

- When PowerShell remoting is unavailable because you don't have privileges to use it or it
  is not enabled.
- When a particular .NET type is needed from output as input to a method or another command.
  Commands running over PowerShell remoting emit deserialized objects rather than strongly-typed
  .NET objects. This means that method calls and strongly typed APIs don't work with the output of
  commands imported over remoting.

## More robust solutions

The previous solutions all had scenarios and modules that don't work. However, they also have the
virtue of being relatively simple to implement correctly. The following solutions are more robust,
but require more effort to implement correctly and can introduce subtle bugs if not written
carefully.

### Loading through .NET Core Assembly Load Contexts

[Assembly Load Contexts][9] (ALCs) were introduced in .NET Core 1.0 to specifically address the need
to load multiple versions of the same assembly into the same runtime.

Within .NET, they offer the most robust solution to the problem of loading conflicting versions of
an assembly. However, custom ALCs are not available in .NET Framework. This means that this solution
only works in PowerShell 6 and above.

Currently, the best example of using an ALC for dependency isolation in PowerShell is in PowerShell
Editor Services, the language server for the PowerShell extension for Visual Studio Code. An
[ALC is used][10] to prevent PowerShell Editor Services' own dependencies from clashing with those
in PowerShell modules.

Implementing module dependency isolation with an ALC is conceptually difficult, but we will work
through a minimal example. Imagine we have a simple module that is only intended to work in
PowerShell 7. The source code is organized as follows:

```
+ AlcModule.psd1
+ src/
    + TestAlcModuleCommand.cs
    + AlcModule.csproj
```

The cmdlet implementation looks like this:

```csharp
using Shared.Dependency;

namespace AlcModule
{
    [Cmdlet(VerbsDiagnostic.Test, "AlcModule")]
    public class TestAlcModuleCommand : Cmdlet
    {
        protected override void EndProcessing()
        {
            // Here's where our dependency gets used
            Dependency.Use();
            // Something trivial to make our cmdlet do *something*
            WriteObject("done!");
        }
    }
}
```

The (heavily simplified) manifest, looks like this:

```powershell
@{
    Author = 'Me'
    ModuleVersion = '0.0.1'
    RootModule = 'AlcModule.dll'
    CmdletsToExport = @('Test-AlcModule')
    PowerShellVersion = '7.0'
}
```

And the `csproj` looks like this:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netcoreapp3.1</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Shared.Dependency" Version="1.0.0" />
    <PackageReference Include="Microsoft.PowerShell.Sdk" Version="7.0.1" PrivateAssets="all" />
  </ItemGroup>
</Project>
```

When we build this module, the generated output has the following layout:

```
AlcModule/
  + AlcModule.psd1
  + AlcModule.dll
  + Shared.Dependency.dll
```

In this example, our problem is in the `Shared.Dependency.dll` assembly, which is our imaginary
conflicting dependency. This is the dependency that we need to put behind an ALC so that we can use
the module-specific version.

We need to re-engineer the module so that:

- Module dependencies are only loaded into our custom ALC, and not into PowerShell's ALC, so
  there can be no conflict. Moreover, as we add more dependencies to our project, we don't want to
  continuously add more code to keep loading working. Instead, we want reusable, generic dependency
  resolution logic.
- Loading the module still works as normal in PowerShell. Cmdlets and other types that the
  PowerShell module system needs are defined within PowerShell's own ALC.

To mediate these two requirements, we must break up our module into two assemblies:

- A cmdlets assembly, `AlcModule.Cmdlets.dll`, that contains definitions of all the types that
  PowerShell's module system needs to load our module correctly. Namely, any implementations of the
  `Cmdlet` base class and the class that implements `IModuleAssemblyInitializer`, which sets up the
  event handler for `AssemblyLoadContext.Default.Resolving` to properly load `AlcModule.Engine.dll`
  through our custom ALC. Since PowerShell 7 deliberately hides types defined in assemblies loaded
  in other ALCs, any types that are meant to be publicly exposed to PowerShell must also be defined
  here. Finally, our custom ALC definition needs to be defined in this assembly. Beyond that, as
  little code as possible should live in this assembly.
- An engine assembly, `AlcModule.Engine.dll`, that handles the actual implementation of the module.
  Types from this are available in the PowerShell ALC, but it's initially loaded through our custom
  ALC. Its dependencies are only loaded into the custom ALC. Effectively, this becomes a _bridge_
  between the two ALCs.

Using this bridge concept, our new assembly situation looks like this:

![Diagram representing AlcModule.Engine.dll bridging the two ALCs][11]

To make sure the default ALC's dependency probing logic doesn't resolve the dependencies to be
loaded into the custom ALC, we need to separate these two parts of the module in different
directories. The new module layout has the following structure:

```
AlcModule/
  AlcModule.Cmdlets.dll
  AlcModule.psd1
  Dependencies/
  | + AlcModule.Engine.dll
  | + Shared.Dependency.dll
```

To see how the implementation changes, we'll start with the implementation of
`AlcModule.Engine.dll`:

```csharp
using Shared.Dependency;

namespace AlcModule.Engine
{
    public class AlcEngine
    {
        public static void Use()
        {
            Dependency.Use();
        }
    }
}
```

This is a simple container for the dependency, `Shared.Dependency.dll`, but you should think of it
as the .NET API for your functionality that the cmdlets in the other assembly wrap for PowerShell.

The cmdlet in `AlcModule.Cmdlets.dll` looks like this:

```csharp
// Reference our module's Engine implementation here
using AlcModule.Engine;

namespace AlcModule.Cmdlets
{
    [Cmdlet(VerbsDiagnostic.Test, "AlcModule")]
    public class TestAlcModuleCommand : Cmdlet
    {
        protected override void EndProcessing()
        {
            AlcEngine.Use();
            WriteObject("done!");
        }
    }
}
```

At this point, if we were to load **AlcModule** and run `Test-AlcModule`, we get a
**FileNotFoundException** when the default ALC tries to load `Alc.Engine.dll` to run
`EndProcessing()`. This is good, since it means the default ALC can't find the dependencies we want
to hide.

Now we need to add code to `AlcModule.Cmdlets.dll` so that it knows how to resolve
`AlcModule.Engine.dll`. First we must define our custom ALC to resolve assemblies from our module's
`Dependencies` directory:

```csharp
namespace AlcModule.Cmdlets
{
    internal class AlcModuleAssemblyLoadContext : AssemblyLoadContext
    {
        private readonly string _dependencyDirPath;

        public AlcModuleAssemblyLoadContext(string dependencyDirPath)
        {
            _dependencyDirPath = dependencyDirPath;
        }

        protected override Assembly Load(AssemblyName assemblyName)
        {
            // We do the simple logic here of looking for an assembly of the given name
            // in the configured dependency directory.
            string assemblyPath = Path.Combine(
                _dependencyDirPath,
                $"{assemblyName.Name}.dll");

            if (File.Exists(assemblyPath))
            {
                // The ALC must use inherited methods to load assemblies.
                // Assembly.Load*() won't work here.
                return LoadFromAssemblyPath(assemblyPath);
            }

            // For other assemblies, return null to allow other resolutions to continue.
            return null;
        }
    }
}
```

Then we need to hook up our custom ALC to the default ALC's `Resolving` event, which is the ALC
version of the `AssemblyResolve` event on Application Domains. This event is fired to find
`AlcModule.Engine.dll` when `EndProcessing()` is called.

```csharp
namespace AlcModule.Cmdlets
{
    public class AlcModuleResolveEventHandler : IModuleAssemblyInitializer, IModuleAssemblyCleanup
    {
        // Get the path of the dependency directory.
        // In this case we find it relative to the AlcModule.Cmdlets.dll location
        private static readonly string s_dependencyDirPath = Path.GetFullPath(
            Path.Combine(
                Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location),
                "Dependencies"));

        private static readonly AlcModuleAssemblyLoadContext s_dependencyAlc =
            new AlcModuleAssemblyLoadContext(s_dependencyDirPath);

        public void OnImport()
        {
            // Add the Resolving event handler here
            AssemblyLoadContext.Default.Resolving += ResolveAlcEngine;
        }

        public void OnRemove(PSModuleInfo psModuleInfo)
        {
            // Remove the Resolving event handler here
            AssemblyLoadContext.Default.Resolving -= ResolveAlcEngine;
        }

        private static Assembly ResolveAlcEngine(AssemblyLoadContext defaultAlc, AssemblyName assemblyToResolve)
        {
            // We only want to resolve the Alc.Engine.dll assembly here.
            // Because this will be loaded into the custom ALC,
            // all of *its* dependencies will be resolved
            // by the logic we defined for that ALC's implementation.
            //
            // Note that we are safe in our assumption that the name is enough
            // to distinguish our assembly here,
            // since it's unique to our module.
            // There should be no other AlcModule.Engine.dll on the system.
            if (!assemblyToResolve.Name.Equals("AlcModule.Engine"))
            {
                return null;
            }

            // Allow our ALC to handle the directory discovery concept
            //
            // This is where Alc.Engine.dll is loaded into our custom ALC
            // and then passed through into PowerShell's ALC,
            // becoming the bridge between both
            return s_dependencyAlc.LoadFromAssemblyName(assemblyToResolve);
        }
    }
}
```

With the new implementation, take a look at the sequence of calls that occurs when the
module is loaded and `Test-AlcModule` is run:

![Sequence diagram of calls using the custom ALC to load dependencies][12]

Some points of interest are:

- The `IModuleAssemblyInitializer` is run first when the module loads and sets the `Resolving`
  event.
- We don't load the dependencies until `Test-AlcModule` is run and its `EndProcessing()` method
  is called.
- When `EndProcessing()` is called, the default ALC fails to find `AlcModule.Engine.dll` and fires
  the `Resolving` event.
- Our event handler hooks up the custom ALC to the default ALC and loads `AlcModule.Engine.dll`
  only.
- When `AlcEngine.Use()` is called within `AlcModule.Engine.dll`, the custom ALC again kicks
  in to resolve `Shared.Dependency.dll`. Specifically, it always loads _our_ `Shared.Dependency.dll`
  since it never conflicts with anything in the default ALC and only looks in our `Dependencies`
  directory.

Assembling the implementation, our new source code layout looks like this:

```
+ AlcModule.psd1
+ src/
  + AlcModule.Cmdlets/
  | + AlcModule.Cmdlets.csproj
  | + TestAlcModuleCommand.cs
  | + AlcModuleAssemblyLoadContext.cs
  | + AlcModuleInitializer.cs
  |
  + AlcModule.Engine/
  | + AlcModule.Engine.csproj
  | + AlcEngine.cs
```

AlcModule.Cmdlets.csproj looks like:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netcoreapp3.1</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <ProjectReference Include="..\AlcModule.Engine\AlcModule.Engine.csproj" />
    <PackageReference Include="Microsoft.PowerShell.Sdk" Version="7.0.1" PrivateAssets="all" />
  </ItemGroup>
</Project>
```

AlcModule.Engine.csproj looks like this:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netcoreapp3.1</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Shared.Dependency" Version="1.0.0" />
  </ItemGroup>
</Project>
```

So, when we build the module, our strategy is:

- Build `AlcModule.Engine`
- Build `AlcModule.Cmdlets`
- Copy everything from `AlcModule.Engine` into the `Dependencies` directory, and remember what we
  copied
- Copy everything from `AlcModule.Cmdlets` that wasn't in `AlcModule.Engine` into the base module
  directory

Since the module layout here is so crucial to dependency separation, here's a build script to use
from the source root:

```powershell
param(
    # The .NET build configuration
    [ValidateSet('Debug', 'Release')]
    [string]
    $Configuration = 'Debug'
)

# Convenient reusable constants
$mod = "AlcModule"
$netcore = "netcoreapp3.1"
$copyExtensions = @('.dll', '.pdb')

# Source code locations
$src = "$PSScriptRoot/src"
$engineSrc = "$src/$mod.Engine"
$cmdletsSrc = "$src/$mod.Cmdlets"

# Generated output locations
$outDir = "$PSScriptRoot/out/$mod"
$outDeps = "$outDir/Dependencies"

# Build AlcModule.Engine
Push-Location $engineSrc
dotnet publish -c $Configuration
Pop-Location

# Build AlcModule.Cmdlets
Push-Location $cmdletsSrc
dotnet publish -c $Configuration
Pop-Location

# Ensure out directory exists and is clean
Remove-Item -Path $outDir -Recurse -ErrorAction Ignore
New-Item -Path $outDir -ItemType Directory
New-Item -Path $outDeps -ItemType Directory

# Copy manifest
Copy-Item -Path "$PSScriptRoot/$mod.psd1"

# Copy each Engine asset and remember it
$deps = [System.Collections.Generic.Hashtable[string]]::new()
Get-ChildItem -Path "$engineSrc/bin/$Configuration/$netcore/publish/" |
    Where-Object { $_.Extension -in $copyExtensions } |
    ForEach-Object { [void]$deps.Add($_.Name); Copy-Item -Path $_.FullName -Destination $outDeps }

# Now copy each Cmdlets asset, not taking any found in Engine
Get-ChildItem -Path "$cmdletsSrc/bin/$Configuration/$netcore/publish/" |
    Where-Object { -not $deps.Contains($_.Name) -and $_.Extension -in $copyExtensions } |
    ForEach-Object { Copy-Item -Path $_.FullName -Destination $outDir }
```

Finally, we have a general way to isolate our module's dependencies in an Assembly Load Context that
remains robust over time as more dependencies are added.

For a more detailed example, go to this [GitHub repository][13]. This example demonstrates how to
migrate a module to use an ALC, while keeping that module working in .NET Framework. It also shows
how to use .NET Standard and PowerShell Standard to simplify the core implementation.

This solution is also used by the [Bicep PowerShell module][14], and the blog post
[Resolving PowerShell Module Conflicts][15] is another good read about this solution.

### Assembly resolving handler for side-by-side loading

Although being robust, the solution described above requires the module assembly to not directly
reference the dependency assemblies, but instead, reference a wrapper assembly that references the
dependency assemblies. The wrapper assembly acts like a bridge, forwarding the calls from the module
assembly to the dependency assemblies. This makes it usually a non-trivial amount of work to adopt
this solution:

- For a new module, this would add additional complexity to the design and implementation
- For an existing module, this would require significant refactoring

There is a simplified solution to achieve side-by-side assembly loading, by hooking up a `Resolving`
event with a custom `AssemblyLoadContext` instance. Using this method is easier for the module
author but has two limitations. Check out the [PowerShell-ALC-Samples][16] repository for sample
code and documentation that describes these limitations and detailed scenarios for this solution.

> [!IMPORTANT]
> Do not use `Assembly.LoadFile` for the dependency isolation purpose. Using `Assembly.LoadFile`
> creates a _Type Identity_ issue when another module loads a different version of the same assembly
> into the default `AssemblyLoadContext`. While this API loads an assembly to a separate
> `AssemblyLoadContext` instance, the assemblies loaded are discoverable by PowerShell's
> [type resolution code][33]. Therefore, there could be duplicate types with the same fully qualifed
> type name available from two different ALCs.

### Custom Application Domains

The final and most extreme option for assembly isolation is to use custom **Application Domains**.
**Application Domains** are only available in .NET Framework. They are used to provide in-process
isolation between parts of a .NET application. One of the uses is to isolate assembly loads from
each other within the same process.

However, **Application Domains**are serialization boundaries. Objects in one application domain
can't be referenced and used directly by objects in another application domain. You can work around
this by implementing `MarshalByRefObject`. But when you don't control the types, as is often the
case with dependencies, it's not possible to force an implementation here. The only solution is to
make large architectural changes. The serialization boundary also has serious performance
implications.

Because **Application Domains** have this serious limitation, are complicated to implement, and only
work in .NET Framework, we won't give an example of how you might use them here. While they're worth
mentioning as a possibility, they're not recommended.

If you're interested in trying to use a custom application domain, the following links might help:

- [Conceptual documentation on Application Domains][17]
- [Examples for using Application Domains][18]

## Solutions for dependency conflicts that don't work for PowerShell

Finally, we'll address some possibilities that come up when researching .NET dependency conflicts in
.NET that can look promising, but generally won't work for PowerShell.

These solutions have the common theme that they are changes to deployment configurations for an
environment where you control the application and possibly the entire machine. These solutions are
oriented toward scenarios like web servers and other applications deployed to server environments,
where the environment is intended to host the application and is free to be configured by the
deploying user. They also tend to be very much .NET Framework oriented, meaning they don't work with
PowerShell 6 or higher.

If you know that your module is only used in Windows PowerShell 5.1 environments that you have total
control over, some of these may be options. In general however, **modules shouldn't modify global
machine state like this**. It can break configurations that cause problems in `powershell.exe`,
other modules, or other dependent applications that cause your module to fail in unexpected ways.

### Static binding redirect with app.config to force using the same dependency version

.NET Framework applications can take advantage of an `app.config` file to configure some application
behaviors declaratively. It's possible to write an `app.config` entry that configures assembly
binding to redirect assembly loading to a particular version.

Two issues with this for PowerShell are:

- .NET Core doesn't support `app.config`, so this solution only applies to `powershell.exe`.
- `powershell.exe` is a shared application that lives in the `System32` directory. It's likely that
  your module won't be able to modify its contents on many systems. Even if it can, modifying
  the `app.config` could break an existing configuration or affect the loading of other modules.

### Setting `codebase` with app.config

For the same reasons, trying to configure the `codebase` setting in `app.config` is not going to
work in PowerShell modules.

### Installing dependencies to the Global Assembly Cache (GAC)

Another way to resolve dependency version conflicts in .NET Framework is to install dependencies to
the GAC, so that different versions can be loaded side-by-side from the GAC.

Again, for PowerShell modules, the chief issues here are:

- The GAC only applies to .NET Framework, so this does not help in PowerShell 6 and above.
- Installing assemblies to the GAC is a modification of global machine state and may cause
  side-effects in other applications or to other modules. It may also be difficult to do correctly,
  even when your module has the required access privileges. Getting it wrong could cause serious,
  machine-wide issues in other .NET applications.

## Further reading

There's plenty more to read on .NET assembly version dependency conflicts. Here are some nice
jumping off points:

- [.NET: Assemblies in .NET][19]
- [.NET Core: The managed assembly loading algorithm][20]
- [.NET Core: Understanding System.Runtime.Loader.AssemblyLoadContext][21]
- [.NET Core: Discussion about side-by-side assembly loading solutions][22]
- [.NET Framework: Redirecting assembly versions][23]
- [.NET Framework: Best practices for assembly loading][24]
- [.NET Framework: How the runtime locates assemblies][25]
- [.NET Framework: Resolve assembly loads][26]
- [Stack Overflow: Assembly binding redirect, how and why?][27]
- [PowerShell: Discussion about implementing AssemblyLoadContexts][28]
- [PowerShell: `Assembly.LoadFile()` doesn't load into default AssemblyLoadContext][29]
- [Rick Strahl: When does a .NET assembly dependency get loaded?][30]
- [Jon Skeet: Summary of versioning in .NET][31]
- [Nate McMaster: Deep dive into .NET Core primitives][32]

<!-- link references -->
[1]: ./media/resolving-dependency-conflicts/moduleconflict.png
[2]: #powershell-and-net
[3]: ./media/resolving-dependency-conflicts/dep-conflict.jpg
[4]: ./media/resolving-dependency-conflicts/engine-conflict.jpg
[5]: ./media/resolving-dependency-conflicts/mod-conflict.jpg
[6]: #further-reading
[7]: #further-reading
[8]: /dotnet/framework/deployment/best-practices-for-assembly-loading
[9]: /dotnet/api/system.runtime.loader.assemblyloadcontext
[10]: https://github.com/PowerShell/PowerShellEditorServices/blob/master/src/PowerShellEditorServices.Hosting/Internal/PsesLoadContext.cs
[11]: ./media/resolving-dependency-conflicts/alc-diagram.jpg
[12]: ./media/resolving-dependency-conflicts/alc-sequence.png
[13]: https://github.com/rjmholt/ModuleDependencyIsolationExample
[14]: https://github.com/PSBicep/PSBicep
[15]: https://pipe.how/get-assemblyloadcontext/
[16]: https://github.com/daxian-dbw/PowerShell-ALC-Samples
[17]: /dotnet/framework/app-domains/application-domains
[18]: /dotnet/framework/app-domains/use
[19]: /dotnet/standard/assembly/
[20]: /dotnet/core/dependency-loading/loading-managed
[21]: /dotnet/core/dependency-loading/understanding-assemblyloadcontext
[22]: https://github.com/dotnet/runtime/issues/13471
[23]: /dotnet/framework/configure-apps/redirect-assembly-versions
[24]: /dotnet/framework/deployment/best-practices-for-assembly-loading
[25]: /dotnet/framework/deployment/how-the-runtime-locates-assemblies
[26]: /dotnet/standard/assembly/resolve-loads
[27]: https://stackoverflow.com/questions/43365736/assembly-binding-redirect-how-and-why
[28]: https://github.com/PowerShell/PowerShell/issues/11571
[29]: https://github.com/PowerShell/PowerShell/issues/12052
[30]: https://weblog.west-wind.com/posts/2012/Nov/03/Back-to-Basics-When-does-a-NET-Assembly-Dependency-get-loaded
[31]: https://codeblog.jonskeet.uk/2019/06/30/versioning-limitations-in-net/
[32]: https://natemcmaster.com/blog/2017/12/21/netcore-primitives/
[33]: https://github.com/PowerShell/PowerShell/blob/918bb8c952af1d461abfc98bc709a1d359168a1c/src/System.Management.Automation/utils/ClrFacade.cs#L56-L61
