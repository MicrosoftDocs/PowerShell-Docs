---
title: PowerShell Engine Enhancements
author: jasonsh
---

# PowerShell Engine Enhancements #

The following improvements to the core PowerShell engine have been implemented for PowerShell 5.1:


## Performance ##

Performance has improved in some important areas:

1. Startup
2. Pipelining to cmdlets like ForEach-Object and Where-Object is approximately 50% faster 

Some example improvements (results may vary depending on your hardware): 

| Scenario | 5.0 Time (ms) | 5.1 Time (ms) |
| -------- | :---------------: | :---------------: |
| `powershell -command "echo 1"` | 900 | 250 |
| First ever PowerShell run: `powershell -command "Unknown-Command"` | 30000 | 13000 |
| Command analysis cache built: `powershell -command "Unknown-Command"` | 7000 | 520 |
| <code>1..1000000 &#124; % { }</code> | 1400 | 750 |
  
One change related to startup may impact some (unsupported) scenarios. PowerShell no longer
reads the files `$pshome\*.ps1xml` - these files have been converted to C# to avoid some file
and CPU overhead of processing the XML files. The files still exist to support V2 side-by-side,
so if you change the file contents, it will not have any effect to V5, only V2. Note that changing
the contents of these files was never a supported scenario.

Another visible change is how PowerShell caches the exported commands and other information for
modules that are installed on a system. Previous, this cache was stored in the directory
`$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\CommandAnalysis`. In WMF 5.1, the cache is a single
file `$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\ModuleAnalysisCache`.
See [analysis_cache.md]() for more details.

Starting with version 5.1, PowerShell is available in different editions which denote varying feature sets and platform compatibility.



## Bug Fixes ##

The following notable bugs were fixed:

### Module auto-discovery fully honors `$env:PSModulePath` ###

Module auto-discovery (loading modules automatically without an explicit Import-Module when calling a command)
was introduced in WMF3. When introduced, PowerShell checked for commands in `$PSHome\Modules` before
using `$env:PSModulePath`.

WMF5.1 changes this behavior to honor `$env:PSModulePath` completely. This allows for a user-authored module 
that defines commands provided by PowerShell (e.g. `Get-ChildItem`) to be auto-loaded and correctly overriding
the built-in command.

### File redirection no longer hard-codes `-Encoding Unicode` ###

In all previous versions of PowerShell, it was impossible to control the file encoding used by the file
redirection operator, e.g. `Get-ChildItem > out.txt` because PowerShell added `-Encoding Unicode`.

Starting with WMF 5.1, you can now change the file encoding of redirection by setting `$PSDefaultParameterValues`, e.g.

```
$PSDefaultParameterValues["Out-File:Encoding"] = "Ascii"
```

### Fixed a regression in accessing members of `System.Reflection.TypeInfo` ###

A regression introduced in WMF5 broke accessing members of `System.Reflection.RuntimeType`, e.g. `[int].ImplementedInterfaces`.
This bug has been fixed in WMF 5.1.


### Fixed some issues with COM objects ###

WMF5 introduced a new COM binder for invoking methods on COM objects and accessing properties of COM objects.
This new binder improved performance significantly but also introduced some bugs which have been fixed in WMF 5.1.

#### Argument conversions were not always performed correctly ####

In the following example:

```
$obj = New-Object -ComObject WScript.Shell
$obj.SendKeys([char]173)
```

The SendKeys method expects a string, but PowerShell did not convert the char to a string, deferring the conversion
to IDispatch::Invoke, which uses VariantChangeType to do the conversion, which in this example resulted in sending
the keys '1', '7', and '3' instead of the expected Volume.Mute key.

#### Enumerable COM objects not always handled correctly ####

PowerShell normally enumerates most enumerable objects, but a regression introduced in WMF5 prevented the enumeration
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

In the above example, WMF5 incorrectly wrote the Scripting.Dictionary to the pipeline
instead of enumerating the key value pairs.


### `[ordered]` was not allowed inside classes ###

WMF5 introduced classes with validation of type literals used in classes.  `[ordered]` looks like a type
literal but is not a true .NET type.  WMF5 incorrectly reported an error on `[ordered]` inside a class:

```
class CThing
{
    [object] foo($i)
    {
        [ordered]@{ Thing = $i }
    }
}
```


### Help on about topics with multiple versions does not work ###

Before WMF5.1, if you had multiple versions of a module installed and they all shared a help topic,
e.g. about_PSReadline, `help about_PSReadline` would return multiple topics with no obvious way
to view the real help.

WMF5.1 fixes this by returning the help for the latest version of the topic.

Get-Help does not provide a way to specify which version you want help for, the workaround is to
navigate to the modules directory and view the help directly with a tool like your favorite editor. 
