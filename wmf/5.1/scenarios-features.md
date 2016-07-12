---
title:   New Scenarios and Features in WMF 5.1 (Preview)
ms.date:  2016-07-06
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
author:  keithb
manager:  dongill
ms.prod:  powershell
ms.technology: WMF
---

# New Scenarios and Features in WMF 5.1 (Preview) #

> Note: This information is preliminary and subject to change.

## PowerShell Editions ##
Starting with version 5.1, PowerShell is available in different editions which denote varying feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework and provides compatibility with scripts and modules targeting versions of PowerShell running on full footprint editions of Windows such as Server Core and Windows Desktop.
- **Core Edition:** Built on .NET Core and provides compatibility with scripts and modules targeting versions of PowerShell running on reduced footprint editions of Windows such as Nano Server and Windows IoT.

**Learn more about using PowerShell Editions**
- [Determine running edition of PowerShell]()
- [Declare a module's compatibility to specific PowerShell versions]()
- [Filter Get-Module results by CompatiblePSEditions]()
- [Prevent script execution unless run on a comaptible edition of PowerShell]()

## Module Analysis Cache ##
Starting with WMF 5.1, PowerShell provides control
over the file that is used to cache data about a module, such as the commands it exports.

By default, this cache is stored in the file `${env:LOCALAPPDATA}\Microsoft\Windows\PowerShell\ModuleAnalysisCache`.
The cache is typically read at startup while searching for a command
and is written on a background thread sometime after a module is imported.

To change the default location of the cache, set the environment variable PSModuleAnalysisCachePath
before starting PowerShell. Changes to this environment variable will only affect children processes.
The value should name a full path (including filename) that PowerShell has permission to create and write files.
To disable the file cache, set this value to an invalid location, for example:

```PowerShell
$env:PSModuleAnalysisCachePath = 'nul'
```

This sets the path to an invalid device. Iff PowerShell can't write to the path, no error is returned, but you can see error reporting via a tracer:

```PowerShell
Trace-Command -PSHost -Name Modules -Expression { Import-Module Microsoft.PowerShell.Management -Force }
```

When writing out the cache, PowerShell will check for modules that no longer exist
to avoid an unnecessarily large cache.
Sometimes these checks are not desirable, in which case you can turn them off by setting

```PowerShell
$env:PSDisableModuleAnalysisCacheCleanup = 1
```

Setting this environment variable will take effect immediately in the current process.

##Specifying module version

In WMF 5.1, `using module` behaves the same way as other module-related constructions in PowerShell. Previously, you had no way to specify a particular module version; if there were multiple versions present, this resulted in an error.


In WMF 5.1:

* You can use `ModuleSpecification` [hashtable](https://msdn.microsoft.com/en-us/library/jj136290(v=vs.85).aspx). 
This hashtable has the same format as `Get-Module -FullyQualifiedName`.

**Example:** `using module @{ModuleName = 'PSReadLine'; RequiredVersion = '1.1'}`

* If there are multiple versions of the module, PowerShell uses the **same resolution logic** as `Import-Module` and doesn't return an error--the same behavior as `Import-Module` and `Import-DscResource`.

## PowerShell console improvements

The following changes have been made to Powershell.exe in WMF 5.1 to improve the console experience:

###VT100 support

Windows 10 added support for [VT100 escape sequences](https://msdn.microsoft.com/en-us/library/windows/desktop/mt638032(v=vs.85).aspx).
PowerShell will ignore certain VT100 formatting escape sequences when calculating table widths.

PowerShell also added a new API that can be used in formatting code to determine if VT100 is supported. For example:

```
if ($host.UI.SupportsVirtualTerminal)
{
    $esc = [char]0x1b
    "A yellow ${esc}[93mhello${esc}[0m"
}
else
{
    "A default hello"
}
```
Here is a complete [example](https://gist.github.com/lzybkr/dcb973dccd54900b67783c48083c28f7) that can be used to highlight matches from Select-String.
Save the example in a file named `MatchInfo.format.ps1xml`, then to use it, in your profile or elsewhere, run `Update-FormatData -Prepend MatchInfo.format.ps1xml`.

Note that VT100 escape sequences are only supported starting with the Windows 10 Anniversary update; they are not supported on earlier systems.   

### Vi mode support in PSReadline

[PSReadline](https://github.com/lzybkr/PSReadLine) adds support for vi mode. To use vi mode, run `Set-PSReadline -EditMode vi`.

### Redirected stdin w/ interactive input 

In earlier versions, starting PowerShell with `powershell -File -` was required when stdin was redirected and
you wanted to enter commands interactively.

With WMF 5.1, this hard to discover option is no longer necessary, you can start powershell without any options, e.g. `powershell`.

Note that PSReadline does not currently supported redirected stdin, and the builtin commanding line editing experience with redirected
stdin is extremely limited, e.g. arrow keys don't work.  A future release of PSReadline should address this issue.   

##PowerShell engine improvements

The following improvements to the core PowerShell engine have been implemented in WMF 5.1:


## Performance ##

Performance has improved in some important areas:

- Startup
- Pipelining to cmdlets like ForEach-Object and Where-Object is approximately 50% faster 

Some example improvements (your results may vary depending your your hardware): 

| Scenario | 5.0 Time (ms) | 5.1 Time (ms) |
| -------- | :---------------: | :---------------: |
| `powershell -command "echo 1"` | 900 | 250 |
| First ever PowerShell run: `powershell -command "Unknown-Command"` | 30000 | 13000 |
| Command analysis cache built: `powershell -command "Unknown-Command"` | 7000 | 520 |
| `1..1000000 | % { }` | 1400 | 750 |
  
> [!NOTE]  
> One change related to startup might impact some unsupported scenarios. PowerShell no longer
reads the files `$pshome\*.ps1xml` - these files have been converted to C# to avoid some file
and CPU overhead of processing the XML files. The files still exist to support V2 side-by-side,
so if you change the file contents, it will not have any effect to V5, only V2. Note that changing
the contents of these files was never a supported scenario.

Another visible change is how PowerShell caches the exported commands and other information for
modules that are installed on a system. Previous, this cache was stored in the directory
`$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\CommandAnalysis`. In WMF 5.1, the cache is a single
file `$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\ModuleAnalysisCache`.
See [analysis_cache.md]() for more details.



## Bug fixes ##

The following notable bugs were fixed:

### Module auto-discovery fully honors `$env:PSModulePath` ###

Module auto-discovery (loading modules automatically without an explicit Import-Module when calling a command)
was introduced in WMF 3. When introduced, PowerShell checked for commands in `$PSHome\Modules` before
using `$env:PSModulePath`.

WMF 5.1 changes this behavior to honor `$env:PSModulePath` completely. This allows for a user-authored module 
that defines commands provided by PowerShell (e.g. `Get-ChildItem`) to be auto-loaded and correctly overriding
the built-in command.

### File redirection no longer hard-codes `-Encoding Unicode` ###

In all previous versions of PowerShell, it was impossible to control the file encoding used by the file
redirection operator, e.g. `get-childitem > out.txt` because PowerShell added `-Encoding Unicode`.

Starting with WMF 5.1, you can now change the file encoding of redirection by setting `$PSDefaultParameterValues`, e.g.

```
$PSDefaultParameterValues["Out-File:Encoding"] = "Ascii"
```

### Fixed a regression in accessing members of `System.Reflection.TypeInfo` ###

A regression introduced in WMF 5.0 broke accessing members of `System.Reflection.RuntimeType`, e.g. `[int].ImplementedInterfaces`.
This bug has been fixed in WMF5.1.


### Fixed some issues with COM objects ###

WMF 5.0 introduced a new COM binder for invoking methods on COM objects and accessing properties of COM objects.
This new binder improved performance significantly but also introduced some bugs which have been fixed in WMF5.1.

#### Argument conversions were not always performed correctly ####

In the following example:

```
$obj = new-object -com wscript.shell
$obj.SendKeys([char]173)
```

The SendKeys method expects a string, but PowerShell did not convert the char to a string, deferring the conversion
to IDispatch::Invoke, which uses VariantChangeType to do the conversion, which in this example resulted in sending
the keys '1', '7', and '3' instead of the expected Volume.Mute key.

#### Enumerable COM objects not always handled correctly ####

PowerShell normally enumerates most enumerable objects, but a regression introduced in WMF 5.0 prevented the enumeration
of COM objects that implement IEnumerable.  For example:

```
function Get-COMDictionary
{
    $d = New-Object -ComObject Scripting.Dictionary
    $d.Add('a', 2)
    $d.Add('b', 2)
    return $d
}

$x = Get-COMDictionary
```

In the above example, WMF 5.0 incorrectly wrote the Scripting.Dictionary to the pipeline
instead of enumerating the key value pairs.

This change also addresses [issues 1752224 on Connect](https://connect.microsoft.com/PowerShell/feedback/details/1752224)

### `[ordered]` was not allowed inside classes ###

WMF5 introduced classes with validation of type literals used in classes.  `[ordered]` looks like a type
literal but is not a true .Net type.  WMF5 incorrectly reported an error on `[ordered]` inside a class:

```
class CThing
{
    [object] foo($i)
    {
        [ordered]@{ Thing = $i }
    }
}
```


### Help on About topics with multiple versions does not work ###

Before WMF 5.1, if you had multiple versions of a module installed and they all shared a help topic,
for example, about_PSReadline, `help about_PSReadline` would return multiple topics with no obvious way
to view the real help.

WMF 5.1 fixes this by returning the help for the latest version of the topic.

Get-Help does not provide a way to specify which version you want help for. To work around this,
navigate to the modules directory and view the help directly with a tool like your favorite editor. 

## OneGet improvements
WMF 5.1 includes a number of fixes and improvements to address some of the user experience gaps in the WMF 5.0 release. 

###Version alias removed

**Scenario**: If you have version 1.0 and 2.0 of a package, P1, installed on your system, and you want to uninstall version 1.0, you would run "uninstall-package -name P1 -version 1.0" and expect version 1.0 to be uninstalled after running the cmdlet. However the result is that version 2.0 gets uninstalled. 
	
This occurs because the "-version" parameter is an alias of the "-minimumversion" parameter. When OneGet is looking for a qualified package with the minimum version of 1.0, it returns the latest version. This behavior is expected in normal cases because finding the latest version is usually the desired result. However, it should not apply to the uninstall-package case.
	
**Solution**: In WMF 5.1, the -version alias is removed entirely in OneGet and PowerShellGet. 

###Multiple prompts for bootstrapping the NuGet provider

**Scenario**: When you run Find-Module or Install-module or other OneGet cmdlets on your computer for the first time, OneGet tries to bootstrap the NuGet provider. It does this because the PowerShellGet provider also uses the NuGet provider to download PowerShell modules. OneGet then prompts the user for permission to install the NuGet provider. After the user selects "yes" for the bootstrapping, the latest version of the NuGet provider will be installed. 
	
However, in some cases, when you have an old version of NuGet provider installed on your computer, the older version of NuGet sometimes gets loaded first into the PowerShell session (that's the race condition in OneGet). However PowerShellGet requires the later version of the NuGet provider to work, so PowerShellGet asks the OneGet for bootstrapping the NuGet provider again. This results in multiple prompts for bootstrapping the NuGet provider.

**Solution**: In WMF 5.1, OneGet now loads the latest version of the NuGet provider to avoid multiple prompts for bootstrapping the NuGet provider.

You could also work around this issue by manually deleting the old version of the NuGet provider (NuGet-Anycpu.exe) if exists from $env:ProgramFiles\PackageManagement\ProviderAssemblies 
$env:LOCALAPPDATA\PackageManagement\ProviderAssemblies


###Support for OneGet on computers with intranet access only

**Scenario**: In WMF 5.0, OneGet did not support computers that have only intranet (but not internet) access.

**Solution**: In WMF 5.1, you can follow these steps to allow intranet computers to use OneGet:

1. Download the NuGet provider using another computer that has an internet connection by using Install-PackageProvider NuGet.

2. Find the NuGet provider under either  $env:ProgramFiles\PackageManagement\ProviderAssemblies\nuget  or  $env:LOCALAPPDATA\PackageManagement\ProviderAssemblies\nuget. 

3. Copy the binaries to a folder or network share location that the intranet computer can access, and then install the NuGet provider with "Install-PackageProvider NuGet -Source <Path to folder>".


###Event logging improvements

When you install packages, you are changing the state of the computer. In WMF 5.1, OneGet now logs events to the Windows event log for install, uninstall, and save-package activities. The Event channel is the same as for PowerShell, that is, Microsoft-Windows-PowerShell, Operational.

###Support for basic authentication

In WMF 5.1, OneGet supports finding and installing packages from a repository that requires basic authentication. You can supply your credentials to the Find-Package and Install-Package cmdlets. For example:

``` PowerShell
Find-Package -Source <SourceWithCredential> -Credential (Get-Credential)
```
###Support for using OneGet behind a proxy

In WMF 5.1, OneGet now takes new proxy parameters: -ProxyCredential and -Proxy. Using these parameters, you can specify the proxy URL and credentials to OneGet cmdlets. By default, system proxy settings are used. For example:

``` PowerShell
Find-Package -Source http://www.nuget.org/api/v2/ -Proxy http://www.myproxyserver.com -ProxyCredential (Get-Credential)
```
