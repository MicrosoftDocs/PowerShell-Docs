---
title:   Bug Fixes in WMF 5.1 (Preview)
ms.date:  2016-07-13
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
author:  keithb
manager:  dongill
ms.prod:  powershell
ms.technology: WMF
---

# Bug Fixes in WMF 5.1 (Preview)#

## Bug fixes ##

The following notable bugs are fixed in WMF 5.1:

### Module auto-discovery fully honors `$env:PSModulePath` ###

Module auto-discovery (loading modules automatically without an explicit Import-Module when calling a command)
was introduced in WMF 3. 
When introduced, PowerShell checked for commands in `$PSHome\Modules` before using `$env:PSModulePath`.

WMF 5.1 changes this behavior to honor `$env:PSModulePath` completely. 
This allows for a user-authored module that defines commands provided by PowerShell (e.g. `Get-ChildItem`) to be auto-loaded and correctly overriding the built-in command.

### File redirection no longer hard-codes `-Encoding Unicode` ###

In all previous versions of PowerShell, it was impossible to control the file encoding used by the file
redirection operator, e.g. `Get-ChildItem > out.txt` because PowerShell added `-Encoding Unicode`.

Starting with WMF 5.1, you can now change the file encoding of redirection by setting `$PSDefaultParameterValues`:

```
$PSDefaultParameterValues["Out-File:Encoding"] = "Ascii"
```

### Fixed a regression in accessing members of `System.Reflection.TypeInfo` ###

A regression introduced in WMF 5.0 broke accessing members of `System.Reflection.RuntimeType`, e.g. `[int].ImplementedInterfaces`.
This bug has been fixed in WMF 5.1.


### Fixed some issues with COM objects ###

WMF 5.0 introduced a new COM binder for invoking methods on COM objects and accessing properties of COM objects. 
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

In the above example, WMF 5.0 incorrectly wrote the Scripting.Dictionary to the pipeline instead of enumerating the key/value pairs.

This change also addresses [issue 1752224 on Connect](https://connect.microsoft.com/PowerShell/feedback/details/1752224)

### `[ordered]` was not allowed inside classes ###

WMF 5.0 introduced classes with validation of type literals used in classes.  
`[ordered]` looks like a type literal but is not a true .NET type. 
WMF 5.0 incorrectly reported an error on `[ordered]` inside a class:

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

`Get-Help` does not provide a way to specify which version you want help for. 
To work around this, navigate to the modules directory and view the help directly with a tool like your favorite editor. 
