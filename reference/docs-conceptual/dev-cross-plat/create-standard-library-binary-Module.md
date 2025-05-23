---
description: The PowerShell Standard Library allows us to create cross platform modules that work in both PowerShell and with Windows PowerShell 5.1.
ms.custom: contributor-KevinMarquette
ms.date: 02/02/2023
title: How to create a Standard Library Binary Module
---
# How to create a Standard Library binary module

I recently had an idea for module that I wanted to implement as a binary module. I have yet to
create one using the [PowerShell Standard Library][04] so this felt like a good opportunity. I used
the [Creating a cross-platform binary module][03] guide to create this module without any
roadblocks. We're going to walk that same process and I'll add a little extra commentary along the
way.

> [!NOTE]
> The [original version][07] of this article appeared on the blog written by [@KevinMarquette][08].
> The PowerShell team thanks Kevin for sharing this content with us. Please check out his blog at
> [PowerShellExplained.com][05].

## What's the PowerShell Standard Library?

The PowerShell Standard Library allows us to create cross platform modules that work in both
PowerShell and Windows PowerShell 5.1.

## Why binary modules?

When you are writing a module in C# you give up easy access to PowerShell cmdlets and functions. But
if you are creating a module that doesn't depend on a lot of other PowerShell commands, the
performance benefit can be significant. PowerShell was optimized for the administrator, not the
computer. By switching to C#, you get to shed the overhead added by PowerShell.

For example, we have a critical process that does a lot of work with JSON and hashtables. We
optimized the PowerShell as much as we could but the process still takes 12 minutes to complete. The
module already contained a lot of C# style PowerShell. This makes conversion to a binary module
clean and simple. By converting to a binary module, we reduced the process time from over 12 minutes
to under four minutes.

### Hybrid modules

You can mix binary cmdlets with PowerShell advanced functions. Everything you know about script
modules applies the same way. The empty `psm1` file is included so you can add other PowerShell
functions later.

Almost all of the compiled cmdlets that I have created started out as PowerShell functions first.
All of our binary modules are really hybrid modules.

### Build scripts

I kept the build script simple here. I generally use a large `Invoke-Build` script as part of my
CI/CD pipeline. It does more magic like running Pester tests, running **PSScriptAnalyzer**, managing
versioning, and publishing to the PSGallery. Once I started using a build script for my modules, I
was able to find lots of things to add to it.

## Planning the module

The plan for this module is to create a `src` folder for the C# code and structure the rest like I
would for a script module. This includes using a build script to compile everything into an `Output`
folder. The folder structure looks like this:

```
MyModule
├───src
├───Output
│   └───MyModule
├───MyModule
│   ├───Data
│   ├───Private
│   └───Public
└───Tests
```

## Getting Started

First I need to create the folder and create the git repo. I'm using `$module` as a placeholder for
the module name. This should make it easier for you to reuse these examples if needed.

```powershell
$module = 'MyModule'
New-Item -Path $module -Type Directory
Set-Location $module
git init
```

Then create the root level folders.

```powershell
New-Item -Path 'src' -Type Directory
New-Item -Path 'Output' -Type Directory
New-Item -Path 'Tests' -Type Directory
New-Item -Path $module -Type Directory
```

### Binary module setup

This article is focused on the binary module so that's where we'll start. This section pulls
examples from the [Creating a cross-platform binary module][03] guide. Review that guide if you need
more details or have any issues.

First thing we want to do is check the version of the [dotnet core SDK][09] that we have installed.
I'm using 2.1.4, but you should have 2.0.0 or newer before continuing.

```powershell
PS> dotnet --version
2.1.4
```

I'm working out of the `src` folder for this section.

```powershell
Set-Location 'src'
```

Using the dotnet command, create a new class library.

```powershell
dotnet new classlib --name $module
```

This created the library project in a subfolder but I don't want that extra level of nesting. I'm
going to move those files up a level.

```powershell
Move-Item -Path .\$module\* -Destination .\
Remove-Item $module -Recurse
```

Set the .NET core SDK version for the project. I have the 2.1 SDK so I'm going to specify `2.1.0`.
Use `2.0.0` if you're using the 2.0 SDK.

```powershell
dotnet new globaljson --sdk-version 2.1.0
```

Add the **PowerShell Standard Library** [NuGet package][10] to the project. Make sure you use the
most recent version available for the level of compatibility that you need. I would default to the
latest version but I don't think this module leverages any features newer than PowerShell 3.0.

```powershell
dotnet add package PowerShellStandard.Library --version 7.0.0-preview.1
```

We should have a src folder that looks like this:

```powershell
PS> Get-ChildItem
    Directory: \MyModule\src

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        7/14/2018   9:51 PM                obj
-a----        7/14/2018   9:51 PM             86 Class1.cs
-a----        7/14/2018  10:03 PM            259 MyModule.csproj
-a----        7/14/2018  10:05 PM             45 global.json
```

Now we're ready to add our own code to the project.

### Building a binary cmdlet

We need to update the `src\Class1.cs` to contain this starter cmdlet:

```csharp
using System;
using System.Management.Automation;

namespace MyModule
{
    [Cmdlet( VerbsDiagnostic.Resolve , "MyCmdlet")]
    public class ResolveMyCmdletCommand : PSCmdlet
    {
        [Parameter(Position=0)]
        public Object InputObject { get; set; }

        protected override void EndProcessing()
        {
            this.WriteObject(this.InputObject);
            base.EndProcessing();
        }
    }
}
```

Rename the file to match the class name.

```powershell
Rename-Item .\Class1.cs .\ResolveMyCmdletCommand.cs
```

Then we can build our module.

```powershell
PS> dotnet build

Microsoft (R) Build Engine version 15.5.180.51428 for .NET Core
Copyright (C) Microsoft Corporation. All rights reserved.

Restore completed in 18.19 ms for C:\workspace\MyModule\src\MyModule.csproj.
MyModule -> C:\workspace\MyModule\src\bin\Debug\netstandard2.0\MyModule.dll

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:02.19
```

We can call `Import-Module` on the new dll to load our new cmdlet.

```powershell
PS> Import-Module .\bin\Debug\netstandard2.0\$module.dll
PS> Get-Command -Module $module

CommandType Name                    Version Source
----------- ----                    ------- ------
Cmdlet      Resolve-MyCmdlet        1.0.0.0 MyModule
```

If the import fails on your system, try updating .NET to 4.7.1 or newer. The
[Creating a cross-platform binary module][03] guide goes into more details on .NET support and
compatibility for older versions of .NET.

### Module manifest

It's cool that we can import the dll and have a working module. I like to keep going with it and
create a module manifest. We need the manifest if we want to publish to the PSGallery later.

From the root of our project, we can run this command to create the module manifest that we need.

```powershell
$manifestSplat = @{
    Path              = ".\$module\$module.psd1"
    Author            = 'Kevin Marquette'
    NestedModules     = @('bin\MyModule.dll')
    RootModule        = "$module.psm1"
    FunctionsToExport = @('Resolve-MyCmdlet')
}
New-ModuleManifest @manifestSplat
```

I'm also going to create an empty root module for future PowerShell functions.

```powershell
Set-Content -Value '' -Path ".\$module\$module.psm1"
```

This allows me to mix both normal PowerShell functions and binary cmdlets in the same project.

### Building the full module

I compile everything together into an output folder. We need to create a build script to do that. I
would normally add this to an `Invoke-Build` script, but we can keep it simple for this example. Add
this to a `build.ps1` at the root of the project.

```powershell
$module = 'MyModule'
Push-Location $PSScriptRoot

dotnet build $PSScriptRoot\src -o $PSScriptRoot\output\$module\bin
Copy-Item "$PSScriptRoot\$module\*" "$PSScriptRoot\output\$module" -Recurse -Force

Import-Module "$PSScriptRoot\Output\$module\$module.psd1"
Invoke-Pester "$PSScriptRoot\Tests"
```

These commands build our DLL and place it into our `output\$module\bin` folder. It then copies the
other module files into place.

```
Output
└───MyModule
    ├───MyModule.psd1
    ├───MyModule.psm1
    └───bin
        ├───MyModule.deps.json
        ├───MyModule.dll
        └───MyModule.pdb
```

At this point, we can import our module with the psd1 file.

```powershell
Import-Module ".\Output\$module\$module.psd1"
```

From here, we can drop the `.\Output\$module` folder into our `$Env:PSModulePath` directory and it
autoloads our command whenever we need it.

### Update: dotnet new PSModule

I learned that the `dotnet` tool has a `PSModule` template.

All the steps that I outlined above are still valid, but this template cuts many of them out. It's
still a fairly new template that's still getting some polish placed on it. Expect it to keep getting
better from here.

This is how you use install and use the PSModule template.

```powershell
dotnet new -i Microsoft.PowerShell.Standard.Module.Template
dotnet new psmodule
dotnet build
Import-Module "bin\Debug\netstandard2.0\$module.dll"
Get-Module $module
```

This minimally-viable template takes care of adding the .NET SDK, PowerShell Standard Library, and
creates an example class in the project. You can build it and run it right away.

## Important details

Before we end this article, here are a few other details worth mentioning.

### Unloading DLLs

Once a binary module is loaded, you can't really unload it. The DLL file is locked until you unload
it. This can be annoying when developing because every time you make a change and want to build it,
the file is often locked. The only reliable way to resolve this is to close the PowerShell session
that loaded the DLL.

### VS Code reload window action

I do most of my PowerShell dev work in [VS Code][02]. When I'm working on a binary module (or a
module with classes), I've gotten into the habit of reloading VS Code every time I build.
<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> pops the command window and `Reload Window` is always
at the top of my list.

### Nested PowerShell sessions

One other option is to have good Pester test coverage. Then you can adjust the build.ps1 script to
start a new PowerShell session, perform the build, run the tests, and close the session.

### Updating installed modules

This locking can be annoying when trying to update your locally installed module. If any session has
it loaded, you have to go hunt it down and close it. This is less of an issue when installing from a
PSGallery because module versioning places the new one in a different folder.

You can set up a local PSGallery and publish to that as part of your build. Then do your local
install from that PSGallery. This sounds like a lot of work, but this can be as simple as starting a
docker container. I cover a way to do that in my post on
[Using a NuGet server for a PSRepository][06].

## Final thoughts

I didn't touch on the C# syntax for creating a cmdlet, but there is plenty of documentation on it
in the [Windows PowerShell SDK][01]. It's definitely something worth experimenting with as a
stepping stone into more serious C#.

<!-- link references -->
[01]: /powershell/scripting/developer/windows-powershell-reference
[02]: https://code.visualstudio.com
[03]: https://github.com/PowerShell/PowerShell/blob/master/docs/cmdlet-example/command-line-simple-example.md
[04]: https://github.com/PowerShell/PowerShellStandard
[05]: https://powershellexplained.com/
[06]: https://powershellexplained.com/2018-03-03-Powershell-Using-a-NuGet-server-for-a-PSRepository/
[07]: https://powershellexplained.com/2018-08-04-Powershell-Standard-Library-Binary-Module/
[08]: https://twitter.com/KevinMarquette
[09]: https://www.microsoft.com/net/download/core
[10]: https://www.nuget.org/packages/PowerShellStandard.Library/
