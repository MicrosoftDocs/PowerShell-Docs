---
description: Lists the currently available experimental features and how to use them.
ms.date: 01/18/2022
title: Using Experimental Features in PowerShell
---
# Using Experimental Features in PowerShell

The Experimental Features support in PowerShell provides a mechanism for experimental features to
coexist with existing stable features in PowerShell or PowerShell modules.

An experimental feature is one where the design is not finalized. The feature is available for users
to test and provide feedback. Once an experimental feature is finalized, the design changes become
breaking changes.

> [!CAUTION]
> Experimental features aren't intended to be used in production since the changes are allowed to be
> breaking. Experimental features are not officially supported. However, we appreciate any feedback
> and bug reports. You can file issues in the
> [GitHub source repository](https://github.com/PowerShell/PowerShell/issues/new/choose).

For more information about enabling or disabling these features, see
[about_Experimental_Features](/powershell/module/microsoft.powershell.core/about/about_experimental_features).

## Available features

This article describes the experimental features that are available and how to use the feature.

Legend

- &#x2714;&#xfe0f; - indicates that the experimental feature is available in the version of
  PowerShell
- &#x2705; - indicates the version of PowerShell where the experimental feature became mainstream
- &#x274c; - indicates the version of PowerShell where the experimental feature was removed

|                            Name                            |       7.0        |       7.1        |       7.2        |       7.3        |
| ---------------------------------------------------------- | :--------------: | :--------------: | :--------------: | :--------------: |
| PSNullConditionalOperators                                 | &#x2714;&#xfe0f; |     &#x2705;     |                  |                  |
| PSUnixFileStat (non-Windows only)                          | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |     &#x2705;     |                  |
| Microsoft.PowerShell.Utility.PSManageBreakpointsInRunspace | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |     &#x2705;     |                  |
| PSCultureInvariantReplaceOperator                          |                  | &#x2714;&#xfe0f; |     &#x2705;     |                  |
| PSNotApplyErrorActionToStderr                              |                  | &#x2714;&#xfe0f; |     &#x2705;     |                  |
| PSImplicitRemotingBatching                                 | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |     &#x274c;     |                  |
| PSCommandNotFoundSuggestion                                | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |
| PSDesiredStateConfiguration.InvokeDscResource              | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |
| PSNativePSPathResolution                                   |                  | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |
| PSSubsystemPluginModel                                     |                  | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |
| PSNativeCommandArgumentPassing                             |                  |                  | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |
| PSAnsiRenderingFileInfo                                    |                  |                  | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |
| PSLoadAssemblyFromNativeCode                               |                  |                  | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |
| PSCleanBlock                                               |                  |                  |                  | &#x2714;&#xfe0f; |
| PSStrictModeAssignment                                     |                  |                  |                  | &#x2714;&#xfe0f; |

## Microsoft.PowerShell.Utility.PSManageBreakpointsInRunspace

> [!NOTE]
> This feature became mainstream in PowerShell 7.2.

In PowerShell 7.0, the experiment enables the **BreakAll** parameter on the `Debug-Runspace` and
`Debug-Job` cmdlets to allow users to decide if they want PowerShell to break immediately in the
current location when they attach a debugger.

In PowerShell 7.1, this experiment also adds the **Runspace** parameter to the `*-PSBreakpoint`
cmdlets.

- `Disable-PSBreakpoint`
- `Enable-PSBreakpoint`
- `Get-PSBreakpoint`
- `Remove-PSBreakpoint`
- `Set-PSBreakpoint`

The **Runspace** parameter specifies a **Runspace** object to interact with breakpoints in the
specified runspace.

```powershell
Start-Job -ScriptBlock {
    Set-PSBreakpoint -Command Start-Sleep
    Start-Sleep -Seconds 10
}

$runspace = Get-Runspace -Id 1

$breakpoint = Get-PSBreakPoint -Runspace $runspace
```

In this example, a job is started and a breakpoint is set to break when the `Set-PSBreakPoint` is
run. The runspace is stored in a variable and passed to the `Get-PSBreakPoint` command with the
**Runspace** parameter. You can then inspect the breakpoint in the `$breakpoint` variable.

## PSAnsiRenderingFileInfo

This experiment was added in PowerShell 7.2. This feature adds the $PSStyle.FileInfo member and
enables coloring of specific file types.

- `$PSStyle.FileInfo.Directory` - Built-in member to specify color for directories
- `$PSStyle.FileInfo.SymbolicLink` - Built-in member to specify color for symbolic links
- `$PSStyle.FileInfo.Executable` - Built-in member to specify color for executables.
- `$PSStyle.FileInfo.Extension` - Use this member to define colors for different file extensions.
  The **Extension** member pre-includes extensions for archive and PowerShell files.

For more information, see
[about_Automatic_Variables](/powershell/module/Microsoft.PowerShell.Core/About/about_Automatic_Variables).

> [!NOTE]
> You must have the **PSAnsiRendering** experimental feature enabled to use this feature.

## PSCleanBlock

The `clean` block is a convenient way for users to clean up resources that span
across the `begin`, `process`, and `end` blocks. It's semantically similar to a
`finally` block that covers all other named blocks of a script function or a
script cmdlet. Resource cleanup is enforced for the following scenarios:

1. when the pipeline execution finishes normally without terminating error
1. when the pipeline execution is interrupted due to terminating error
1. when the pipeline is halted by `Select-Object -First`
1. when the pipeline is being stopped by <kbd>Ctrl+c</kbd> or
   `StopProcessing()`

> [!CAUTON]
> Adding the `clean` block is a breaking change. Because `clean` is parsed as a
> keyword, it prevents users from directly calling a command named `clean` as
> the first statement in a script block. However, it's likely a non-issue in
> most practical cases, and when it is, the command can still be invoked with
> the call operator (`& clean`).

For more information about this experimental feature, see
[RFC0059](https://github.com/PowerShell/PowerShell-RFC/blob/master/Archive/Experimental/RFC0059-Cleanup-Script-Block.md)
in the PowerShell/PowerShell-RFC repository.

## PSCommandNotFoundSuggestion

Recommends potential commands based on fuzzy matching search after a **CommandNotFoundException**.

```powershell
PS> get
```

```Output
get: The term 'get' is not recognized as the name of a cmdlet, function, script file, or operable
program. Check the spelling of the name, or if a path was included, verify that the path is correct
and try again.

Suggestion [4,General]: The most similar commands are: set, del, ft, gal, gbp, gc, gci, gcm, gdr,
gcs.
```

## PSCultureInvariantReplaceOperator

When the left-hand operand in a `-replace` operator statement is not a string, that operand is
converted to a string.

When this feature is disabled, the `-replace` operator does a culture-sensitive string conversion.
For example, if your culture is set to French (fr), the value `1.2` is converted to the string
`1,2`.

```powershell
PS> [cultureinfo]::CurrentCulture = 'fr'
PS> 1.2 -replace ','
12
PS> [cultureinfo]::CurrentCulture = 'en'
PS> 1.2 -replace ','
1.2
```

With the feature enabled:

```powershell
PS> [cultureinfo]::CurrentCulture = 'fr'
PS> 1.2 -replace ','
1.2
```

## PSDesiredStateConfiguration.InvokeDscResource

Enables compilation to MOF on non-Windows systems and enables the use of `Invoke-DSCResource`
without an LCM.

In earlier previews of PowerShell 7.2, this feature was enabled by default. Beginning with
PowerShell 7.2-preview7, the **PSDesiredStateConfiguration** module was removed and this feature is
disabled by default. To enable this feature you must install the **PSDesiredStateConfiguration**
v2.0.5 module from the PowerShell Gallery and enable the feature using `Enable-ExperimentalFeature`.

## PSImplicitRemotingBatching

> [!NOTE]
> This experimental feature was removed in PowerShell 7.2 and is no longer supported.

This feature examines the command typed in the shell, and if all the commands are implicit remoting
proxy commands that form a simple pipeline, then the commands are batched together and invoked as a
single remote pipeline.

Example:

```powershell
# Create remote session and import TestIMod module
$s = nsn -host remoteMachine
icm $s { ipmo 'C:\Users\user\Documents\WindowsPowerShell\Modules\TestIMod\TestIMod.psd1' }
Import-PSSession $s -mod testimod

$maxProcs = 1000
$filter = 'pwsh','powershell*','wmi*'

# Without batching, this pipeline takes approximately 12 seconds to run
Measure-Command { Get-AllProcesses -MaxCount $maxProcs | Select-Custom $filter | Group-Stuff $filter }
Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 12
Milliseconds      : 463

# But with the batching experimental feature enabled, it takes approximately 0.20 seconds
Measure-Command { Get-AllProcesses -MaxCount $maxProcs | Select-Custom $filter | Group-Stuff $filter }
Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 0
Milliseconds      : 209
```

As seen above, with the batching feature enabled, all three implicit remoting proxy commands,
`Get-AllProcesses`, `Select-Custom`, `Group-Stuff`, run in the remote session and the result from
the pipeline is the only data returned to the client. This decreases the amount of data sent back
and forth between client and remote session, and also reduces the amount of object serialization and
de-serialization.

## PSLoadAssemblyFromNativeCode

Exposes an API to allow assembly loading from native code.

## PSNativeCommandArgumentPassing

When this experimental feature is enabled PowerShell uses the `ArgumentList` property of the
`StartProcessInfo` object rather than our current mechanism of reconstructing a string when invoking
a native executable.

> [!CAUTION]
> The new behavior is a **breaking change** from current behavior. This may break scripts and
> automation that work around the various issues when invoking native applications. Historically,
> quotes must be escaped and it is not possible to provide empty arguments to a native application.

This feature adds a new automatic variable `$PSNativeCommandArgumentPassing` that allows you to
select the behavior at runtime. The valid values are `Legacy`, `Standard`, and `Windows`. `Legacy`
is the historic behavior. The default when the experimental feature is enabled is the new `Standard`
behavior.

When the preference variable is set to `Windows`, invocations of the following files automatically
use the `Legacy` style argument passing.

- `cmd.exe`
- `cscript.exe`
- `wscript.exe`
- ending with `.bat`
- ending with `.cmd`
- ending with `.js`
- ending with `.vbs`
- ending with `.wsf`

If the `$PSNativeArgumentPassing` is set to either `Legacy` or `Standard`, the check for these files
do not occur. The default behavior is platform specific. On Windows platforms, the default setting
is `Windows` and non-Windows platforms is `Standard`.

New behaviors made available by this change:

- Literal or expandable strings with embedded quotes the quotes are now preserved:

  ```powershell
  PS > $a = 'a" "b'
  PS > $PSNativeCommandArgumentPassing = "Legacy"
  PS > testexe -echoargs $a 'a" "b' a" "b
  Arg 0 is <a b>
  Arg 1 is <a b>
  Arg 2 is <a b>
  PS > $PSNativeCommandArgumentPassing = "Standard"
  PS > testexe -echoargs $a 'a" "b' a" "b
  Arg 0 is <a" "b>
  Arg 1 is <a" "b>
  Arg 2 is <a b>
  ```

- Empty strings as arguments are now preserved:

  ```powershell
  PS>  $PSNativeCommandArgumentPassing = "Legacy"
  PS> testexe -echoargs '' a b ''
  Arg 0 is <a>
  Arg 1 is <b>
  PS> $PSNativeCommandArgumentPassing = "Standard"
  PS> testexe -echoargs '' a b ''
  Arg 0 is <>
  Arg 1 is <a>
  Arg 2 is <b>
  Arg 3 is <>
  ```

The new behavior does not change invocations that look like this:

```powershell
PS> $PSNativeCommandArgumentPassing = "Legacy"
PS> testexe -echoargs -k com:port=\\devbox\pipe\debug,pipe,resets=0,reconnect
Arg 0 is <-k>
Arg 1 is <com:port=\\devbox\pipe\debug,pipe,resets=0,reconnect>
PS> $PSNativeCommandArgumentPassing = "Standard"
PS> testexe -echoargs -k com:port=\\devbox\pipe\debug,pipe,resets=0,reconnect
Arg 0 is <-k>
Arg 1 is <com:port=\\devbox\pipe\debug,pipe,resets=0,reconnect>
```

Additionally, parameter tracing is now provided so `Trace-Command` provides useful information
for debugging.

```powershell
PS> $PSNativeCommandArgumentPassing = "Legacy"
PS> trace-command -PSHOST -Name ParameterBinding { testexe -echoargs $a 'a" "b' a" "b }
DEBUG: 2021-02-01 17:19:53.6438 ParameterBinding Information: 0 : BIND NAMED native application line args [/Users/james/src/github/forks/jameswtruher/PowerShell-1/test/tools/TestExe/bin/testexe]
DEBUG: 2021-02-01 17:19:53.6440 ParameterBinding Information: 0 :     BIND argument [-echoargs a" "b a" "b "a b"]
DEBUG: 2021-02-01 17:19:53.6522 ParameterBinding Information: 0 : CALLING BeginProcessing
Arg 0 is <a b>
Arg 1 is <a b>
Arg 2 is <a b>
PS> $PSNativeCommandArgumentPassing = "Standard"
PS> trace-command -PSHOST -Name ParameterBinding { testexe -echoargs $a 'a" "b' a" "b }
DEBUG: 2021-02-01 17:20:01.9829 ParameterBinding Information: 0 : BIND NAMED native application line args [/Users/james/src/github/forks/jameswtruher/PowerShell-1/test/tools/TestExe/bin/testexe]
DEBUG: 2021-02-01 17:20:01.9829 ParameterBinding Information: 0 :     BIND cmd line arg [-echoargs] to position [0]
DEBUG: 2021-02-01 17:20:01.9830 ParameterBinding Information: 0 :     BIND cmd line arg [a" "b] to position [1]
DEBUG: 2021-02-01 17:20:01.9830 ParameterBinding Information: 0 :     BIND cmd line arg [a" "b] to position [2]
DEBUG: 2021-02-01 17:20:01.9831 ParameterBinding Information: 0 :     BIND cmd line arg [a b] to position [3]
DEBUG: 2021-02-01 17:20:01.9908 ParameterBinding Information: 0 : CALLING BeginProcessing
Arg 0 is <a" "b>
Arg 1 is <a" "b>
Arg 2 is <a b>
```

## PSNativePSPathResolution

If a PSDrive path that uses the FileSystem provider is passed to a native command, the resolved file
path is passed to the native command. This means a command like `code temp:/test.txt` now works as
expected.

Also, on Windows, if the path starts with `~`, that is resolved to the full path and passed to the
native command. In both cases, the path is normalized to the directory separators for the relevant
operating system.

- If the path is not a PSDrive or `~` (on Windows), then path normalization doesn't occur
- If the path is in single quotes, then it's not resolved and treated as literal

## PSNotApplyErrorActionToStderr

When this experimental feature is enabled, error records redirected from native commands, like when
using redirection operators (`2>&1`), are not written to the `$Error` variable and the preference
variable `$ErrorActionPreference` does not affect the redirected output.

Many native commands write to `stderr` as an alternative stream for additional information. This
behavior can cause confusion when looking through errors or the additional output information can
be lost to the user if `$ErrorActionPreference` is set to a state that mutes the output.

When a native command has a non-zero exit code, `$?` is set to `$false`. If the exit code is zero,
`$?` is set to `$true`.

## PSNullConditionalOperators

Introduces new operators for Null conditional member access operators - `?.` and `?[]`. Null member
access operators can be used on scalar types and array types. Return the value of the accessed
member if the variable is not null. If the value of the variable is null, then return null.

```powershell
$x = $null
${x}?.propname
${x?}?.propname

${x}?[0]
${x?}?[0]

${x}?.MyMethod()
```

The property `propname` is accessed and it's value is returned only if `$x` is not null. Similarly,
the indexer is used only if `$x` is not null. If `$x` is null, then null is returned.

The `?.` and `?[]` operators are member access operators and do not allow a space in between the
variable name and the operator.

Since PowerShell allows `?` as part of the variable name, disambiguation is required when the
operators are used without a space between the variable name and the operator. To disambiguate, the
variables must use `{}` around the variable name like: `${x?}?.propertyName` or `${y}?[0]`.

> [!NOTE]
> This feature has moved out of the experimental phase and is a mainstream feature in PowerShell 7.1
> and higher.

## PSStrictModeAssignment

PowerShell 7.3-preview.2 adds the **StrictMode** parameter to `Invoke-Command` to allow specifying
strict mode when invoking command locally. The **StrictMode** parameter sets the provided version
for the process. Once the process completes, the **StrictMode** version is set back to what it was
before the `Invoke-Command`.

This feature does not support asynchronous jobs on remote machines.

## PSUnixFileStat

This feature provides more Unix-like file listings by including data from the Unix **stat** API. It
adds a new note property in the filesystem provider named **UnixStat** that includes a rendering of
information from the Unix `stat(2)` API.

The output from `Get-ChildItem` should look something like this:

```powershell
dir | select -first 4 -skip 5


    Directory: /Users/jimtru/src/github/forks/JamesWTruher/PowerShell-1

UnixMode   User      Group           LastWriteTime        Size Name
--------   ----      -----           -------------        ---- ----
drwxr-xr-x jimtru    staff        10/23/2019 13:16         416 test
drwxr-xr-x jimtru    staff         11/8/2019 10:37         896 tools
-rw-r--r-- jimtru    staff         11/8/2019 10:37      112858 build.psm1
-rw-r--r-- jimtru    staff         11/8/2019 10:37      201297 CHANGELOG.md
```

> [!NOTE]
> This feature has moved out of the experimental phase and is a mainstream feature in PowerShell 7.1
> and higher.

## PSSubsystemPluginModel

This feature enables the subsystem plugin model in PowerShell. The feature makes it possible to
separate components of `System.Management.Automation.dll` into individual subsystems that reside in
their own assembly. This separation reduces the disk footprint of the core PowerShell engine and
allows these components to become optional features for a minimal PowerShell installation.

Currently, only the **CommandPredictor** subsystem is supported. This subsystem is used along with
the PSReadLine module to provide custom prediction plugins. In future, **Job**,
**CommandCompleter**, **Remoting** and other components could be separated into subsystem
assemblies outside of `System.Management.Automation.dll`.

The experimental feature includes a new cmdlet,
[Get-PSSubsystem](xref:Microsoft.PowerShell.Core.Get-PSSubsystem). This cmdlet is only available
when the feature is enabled. This cmdlet returns information about the subsystems that are available
on the system.
