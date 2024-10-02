---
description: Lists the currently available experimental features and how to use them.
ms.date: 09/24/2024
title: Using Experimental Features in PowerShell
---
# Using Experimental Features in PowerShell

The Experimental Features support in PowerShell provides a mechanism for experimental features to
coexist with existing stable features in PowerShell or PowerShell modules.

An experimental feature is one where the design isn't finalized. The feature is available for users
to test and provide feedback. Once an experimental feature is finalized, the design changes become
breaking changes.

> [!CAUTION]
> Experimental features aren't intended to be used in production since the changes are allowed to be
> breaking. Experimental features aren't officially supported. However, we appreciate any feedback
> and bug reports. You can file issues in the [GitHub source repository][26].

For more information about enabling or disabling these features, see
[about_Experimental_Features][06].

## Experimental feature lifecycle

The [Get-ExperimentalFeature][30] cmdlet returns all experimental features available to PowerShell.
Experimental features can come from modules or the PowerShell engine. Module-based experimental
features are only available after you import the module. In the following example, the
**PSDesiredStateConfiguration** isn't loaded, so the `PSDesiredStateConfiguration.InvokeDscResource`
feature isn't available.

```powershell
Get-ExperimentalFeature
```

```Output
Name                             Enabled Source   Description
----                             ------- ------   -----------
PSCommandNotFoundSuggestion        False PSEngine Recommend potential commands based on fuzzy searc…
PSCommandWithArgs                  False PSEngine Enable `-CommandWithArgs` parameter for pwsh
PSFeedbackProvider                  True PSEngine Replace the hard-coded suggestion framework with …
PSLoadAssemblyFromNativeCode       False PSEngine Expose an API to allow assembly loading from nati…
PSModuleAutoLoadSkipOfflineFiles    True PSEngine Module discovery will skip over files that are ma…
PSSerializeJSONLongEnumAsNumber     True PSEngine Serialize enums based on long or ulong as an nume…
PSSubsystemPluginModel              True PSEngine A plugin model for registering and un-registering…
```

Use the [Enable-ExperimentalFeature][29] and [Disable-ExperimentalFeature][28] cmdlets to enable or
disable a feature. You must start a new PowerShell session for this change to be in effect. Run the
following command to enable the `PSCommandNotFoundSuggestion` feature:

```powershell
Enable-ExperimentalFeature PSCommandNotFoundSuggestion
```

```Output
WARNING: Enabling and disabling experimental features do not take effect until next start
of PowerShell.
```

When an experimental feature becomes _mainstream_, it's no longer available as an experimental
feature because the functionality is now part of the PowerShell engine or module. For example, the
`PSAnsiRenderingFileInfo` feature became mainstream in PowerShell 7.3. You get the functionality of
the feature automatically.

> [!NOTE]
> Some features have configuration requirements, such as preference variables, that must be set to
> get the desired results from the feature.

When an experimental feature is _discontinued_, that feature is no longer available in the
PowerShell. For example, the `PSNativePSPathResolution` feature was discontinued in PowerShell 7.3.

## Available features

This article describes the experimental features that are available and how to use the feature.

Legend

- The ![Experimental][02] icon indicates that the experimental feature is available in the version
  of PowerShell
- The ![Mainstream][01] icon indicates the version of PowerShell where the experimental feature
  became mainstream
- The ![Discontinued][03] icon indicates the version of PowerShell where the experimental feature
  was removed

|                        Name                         |         7.2         |         7.4         |    7.5 (preview)    |
| --------------------------------------------------- | :-----------------: | :-----------------: | :-----------------: |
| [PSCommandNotFoundSuggestion][10]                   | ![Experimental][02] | ![Experimental][02] |  ![Mainstream][01]  |
| [PSDesiredStateConfiguration.InvokeDscResource][14] | ![Experimental][02] | ![Experimental][02] | ![Experimental][02] |
| [PSNativePSPathResolution][21]                      | ![Experimental][02] |                     |                     |
| [PSSubsystemPluginModel][23]                        | ![Experimental][02] | ![Experimental][02] | ![Experimental][02] |
| [PSNativeCommandArgumentPassing][18]                | ![Experimental][02] |                     |                     |
| [PSAnsiRenderingFileInfo][09]                       | ![Experimental][02] |                     |                     |
| [PSLoadAssemblyFromNativeCode][16]                  | ![Experimental][02] | ![Experimental][02] | ![Experimental][02] |
| [PSNativeCommandErrorActionPreference][19]          |                     |  ![Mainstream][01]  |                     |
| [PSFeedbackProvider][15]                            |                     | ![Experimental][02] | ![Experimental][02] |
| [PSModuleAutoLoadSkipOfflineFiles][17]              |                     | ![Experimental][02] |  ![Mainstream][01]  |
| [PSCommandWithArgs][11]                             |                     | ![Experimental][02] |  ![Mainstream][01]  |
| [PSNativeWindowsTildeExpansion][22]                 |                     |                     | ![Experimental][02] |
| [PSRedirectToVariable][24]                          |                     |                     | ![Experimental][02] |
| [PSSerializeJSONLongEnumAsNumber][25]               |                     |                     | ![Experimental][02] |

### PSAnsiRenderingFileInfo

> [!NOTE]
> This feature became mainstream in PowerShell 7.3.

The ANSI formatting features were added in PowerShell 7.2. This feature adds the `$PSStyle.FileInfo`
member and enables coloring of specific file types.

- `$PSStyle.FileInfo.Directory` - Built-in member to specify the color for directories
- `$PSStyle.FileInfo.SymbolicLink` - Built-in member to specify the color for symbolic links
- `$PSStyle.FileInfo.Executable` - Built-in member to specify the color for executables.
- `$PSStyle.FileInfo.Extension` - Use this member to define the colors for different file
  extensions. The **Extension** member pre-includes extensions for archive and PowerShell files.

For more information, see [about_Automatic_Variables][05].

### PSCommandNotFoundSuggestion

> [!NOTE]
> This feature became mainstream in PowerShell 7.5-preview.5.

Recommends potential commands based on fuzzy matching search after a **CommandNotFoundException**.

```powershell
PS> get
```

```Output
get: The term 'get' isn't recognized as the name of a cmdlet, function, script file,
or operable program. Check the spelling of the name, or if a path was included, verify
that the path is correct and try again.

Suggestion [4,General]: The most similar commands are: set, del, ft, gal, gbp, gc, gci,
gcm, gdr, gcs.
```

### PSCommandWithArgs

> [!NOTE]
> This feature became mainstream in PowerShell 7.5-preview.5.

This feature enables the `-CommandWithArgs` parameter for `pwsh`. This parameter allows you to
execute a PowerShell command with arguments. Unlike `-Command`, this parameter populates the `$args`
built-in variable that can be used by the command.

The first string is the command and subsequent strings delimited by whitespace are the arguments.

For example:

```powershell
pwsh -CommandWithArgs '$args | % { "arg: $_" }' arg1 arg2
```

This example produces the following output:

```Output
arg: arg1
arg: arg2
```

This feature was added in PowerShell 7.4-preview.2.

### PSDesiredStateConfiguration.InvokeDscResource

Enables compilation to MOF on non-Windows systems and enables the use of `Invoke-DSCResource`
without an LCM.

Beginning with PowerShell 7.2, the **PSDesiredStateConfiguration** module was removed and this
feature is disabled by default. To enable this feature you must install the
**PSDesiredStateConfiguration** v2.0.5 module from the PowerShell Gallery and enable the feature.

DSC v3 doesn't have this experimental feature. DSC v3 only supports `Invoke-DSCResource` and doesn't
use or support MOF compilation. For more information, see
[PowerShell Desired State Configuration v3][04].

### PSFeedbackProvider

When you enable this feature, PowerShell uses a new feedback provider to give you feedback when a
command can't be found. The feedback provider is extensible, and can be implemented by third-party
modules. The feedback provider can be used by other subsystems, such as the predictor subsystem, to
provide predictive IntelliSense results.

This feature includes two built-in feedback providers:

- **GeneralCommandErrorFeedback** serves the same suggestion functionality existing today
- **UnixCommandNotFound**, available on Linux, provides feedback similar to bash.

  The **UnixCommandNotFound** serves as both a feedback provider and a predictor. The suggestion
  from command-not-found command is used both for providing the feedback when command can't be found
  in an interactive run, and for providing predictive IntelliSense results for the next command
  line.

This feature was added in PowerShell 7.4-preview.3.

### PSLoadAssemblyFromNativeCode

Exposes an API to allow assembly loading from native code.

### PSModuleAutoLoadSkipOfflineFiles

> [!NOTE]
> This feature became mainstream in PowerShell 7.5-preview.5.

With this feature enabled, if a user's **PSModulePath** contains a folder from a cloud provider,
such as OneDrive, PowerShell no longer triggers the download of all files contained within that
folder. Any file marked as not downloaded are skipped. Users who use cloud providers to sync their
modules between machines should mark the module folder as **Pinned** or the equivalent status for
providers other than OneDrive. Marking the module folder as **Pinned** ensures that the files are
always kept on disk.

This feature was added in PowerShell 7.4-preview.1.

### PSNativeCommandArgumentPassing

> [!NOTE]
> This feature became mainstream in PowerShell 7.3.

When this experimental feature is enabled PowerShell uses the `ArgumentList` property of the
`StartProcessInfo` object rather than our current mechanism of reconstructing a string when invoking
a native executable.

> [!CAUTION]
> The new behavior is a **breaking change** from current behavior. This may break scripts and
> automation that work around the various issues when invoking native applications. Historically,
> quotes must be escaped and it isn't possible to provide empty arguments to a native application.
> Use the [stop-parsing token][08] (`--%`) or the [`Start-Process`][32] cmdlet to sidestep native
> argument passing when needed.

This feature adds a new `$PSNativeCommandArgumentPassing` preference variable that controls this
behavior. This variable allows you to select the behavior at runtime. The valid values are `Legacy`,
`Standard`, and `Windows`. The default behavior is platform specific. On Windows platforms, the
default setting is `Windows` and non-Windows platforms default to `Standard`.

`Legacy` is the historic behavior. The behavior of `Windows` and `Standard` mode are the same
except, in `Windows` mode, invocations of the following files automatically use the `Legacy` style
argument passing.


- `cmd.exe`
- `find.exe`
- `cscript.exe`
- `wscript.exe`
- `sqlcmd.exe` - Added in PowerShell 7.3.1
- ending with `.bat`
- ending with `.cmd`
- ending with `.js`
- ending with `.vbs`
- ending with `.wsf`

If the `$PSNativeCommandArgumentPassing` is set to either `Legacy` or `Standard`, the parser doesn't
check for these files.

The default behavior is platform specific. On Windows platforms, the default setting is `Windows`
and non-Windows platforms is `Standard`.

> [!NOTE]
> The following examples use the `TestExe.exe` tool. You can build `TestExe` from the source code.
> See [TestExe][27] in the PowerShell source repository.

New behaviors made available by this change:

- Literal or expandable strings with embedded quotes the quotes are preserved:

  ```powershell
  PS> $a = 'a" "b'
  PS> TestExe -echoargs $a 'c" "d' e" "f
  Arg 0 is <a" "b>
  Arg 1 is <c" "d>
  Arg 2 is <e f>
  ```

- Empty strings as arguments are preserved:

  ```powershell
  PS> TestExe -echoargs '' a b ''
  Arg 0 is <>
  Arg 1 is <a>
  Arg 2 is <b>
  Arg 3 is <>
  ```

For more examples of the new behavior, see [about_Parsing][07].

PowerShell 7.3 also added the ability to trace parameter binding for native commands. For more
information, see [Trace-Command][34].

### PSNativeCommandErrorActionPreference

<!-- Keep this until 7.4.1 then remove since it's already in the mainstream docs -->

> [!NOTE]
> This feature became mainstream in PowerShell 7.4.

Native commands usually return an exit code to the calling application that's zero for success or
non-zero for failure. However, native commands currently don't participate in the PowerShell error
stream. Redirected **stderr** output isn't interpreted the same as the PowerShell error stream. Many
native commands use stderr as an information or verbose stream, thus only the exit code matters.
Users working with native commands in their scripts need to check the exit status after each call
using similar to the following example:

```powershell
if ($LASTEXITCODE -ne 0) {
    throw "Command failed. See above errors for details"
}
```

However, this example doesn't support all cases where `$?` can be false from a cmdlet or function
error, making `$LASTEXITCODE` stale.

This feature implements the `$PSNativeCommandUseErrorActionPreference` preference variable that
controls how native commands errors are handled in PowerShell. This allows native command failures
to produce error objects that are added to the PowerShell error stream and may terminate execution
of the script without extra handling.

`$PSNativeCommandUseErrorActionPreference` is set to `$false` by default. With the preference set to
`$true` you get the following behavior:

- When `$ErrorActionPreference = 'Stop'`, scripts will break when a native command returns a
  non-zero exit code.
- When `$ErrorActionPreference = 'Continue'` (the default), you will see PowerShell error messages
  for native command errors, but scripts won't break.

### PSNativePSPathResolution

> [!NOTE]
> This experimental feature was removed in PowerShell 7.3 and is no longer supported.

If a PSDrive path that uses the FileSystem provider is passed to a native command, the resolved file
path is passed to the native command. This means a command like `code temp:/test.txt` now works as
expected.

Also, on Windows, if the path starts with `~`, that's resolved to the full path and passed to the
native command. In both cases, the path is normalized to the directory separators for the relevant
operating system.

- If the path isn't a PSDrive or `~` (on Windows), then path normalization doesn't occur
- If the path is in single quotes, then it's not resolved and treated as literal

### PSRedirectToVariable

> [!NOTE]
> This experimental feature was added in PowerShell 7.5-preview.4.

When enabled, this feature adds support for redirecting to the variable drive. This feature allows
you to redirect data to a variable using the `variable:name` syntax. PowerShell inspects the target
of the redirection and if it uses the variable provider it calls `Set-Variable` rather than
`Out-File`.

The following example shows how to redirect the output of a command to a variable:

```powershell
. {
    "Output 1"
    Write-Warning "Warning, Warning!"
    "Output 2"
} 3> variable:warnings
$warnings
```

```Output
Output 1
Output 2
WARNING: Warning, Warning!
```

### PSSubsystemPluginModel

This feature enables the subsystem plugin model in PowerShell. The feature makes it possible to
separate components of `System.Management.Automation.dll` into individual subsystems that reside in
their own assembly. This separation reduces the disk footprint of the core PowerShell engine and
allows these components to become optional features for a minimal PowerShell installation.

Currently, only the **CommandPredictor** subsystem is supported. This subsystem is used along with
the PSReadLine module to provide custom prediction plugins. In future, **Job**,
**CommandCompleter**, **Remoting** and other components could be separated into subsystem assemblies
outside of `System.Management.Automation.dll`.

The experimental feature includes a new cmdlet, [Get-PSSubsystem][31]. This cmdlet is only available
when the feature is enabled. This cmdlet returns information about the subsystems that are available
on the system.

### PSNativeWindowsTildeExpansion

When this feature is enabled, PowerShell expands unquoted tilde (`~`) to the user's current home
folder before invoking native commands. The following examples show how the feature works.

With the feature disabled, the tilde is passed to the native command as a literal string.

```powershell
PS> cmd.exe /c echo ~
~
```

With the feature enabled, PowerShell expands the tilde before it's passed to the native command.

```powershell
PS> cmd.exe /c echo ~
C:\Users\username
```

This feature only applies to Windows. On non-Windows platforms, tilde expansion is handled natively.

This feature was added in PowerShell 7.5-preview.2.

### PSSerializeJSONLongEnumAsNumber

This feature enables the cmdlet [ConvertTo-Json][33] to serialize any enum values based on
`Int64/long` or `UInt64/ulong` as a numeric value rather than the string representation of that enum
value. This aligns the behavior of enum serialization with other enum base types where the cmdlet
serializes enums as their numeric value. Use the **EnumsAsStrings** parameter to serialize as the
string representation.

For example:

```powershell
# PSSerializeJSONLongEnumAsNumber disabled
@{
    Key = [System.Management.Automation.Tracing.PowerShellTraceKeywords]::Cmdlets
} | ConvertTo-Json
# { "Key": "Cmdlets" }

# PSSerializeJSONLongEnumAsNumber enabled
@{
    Key = [System.Management.Automation.Tracing.PowerShellTraceKeywords]::Cmdlets
} | ConvertTo-Json
# { "Key": 32 }

# -EnumsAsStrings to revert back to the old behaviour
@{
    Key = [System.Management.Automation.Tracing.PowerShellTraceKeywords]::Cmdlets
} | ConvertTo-Json -EnumsAsStrings
# { "Key": "Cmdlets" }
```

<!-- link references -->
[01]: ../../media/shared/check-mark-button-2705.svg
[02]: ../../media/shared/construction-sign-1f6a7.svg
[03]: ../../media/shared/cross-mark-274c.svg
[04]: /powershell/dsc/overview?view=dsc-3.0&preserve-view=true
[05]: /powershell/module/microsoft.powershell.core/about/about_automatic_variables
[06]: /powershell/module/microsoft.powershell.core/about/about_experimental_features
[07]: /powershell/module/microsoft.powershell.core/about/about_parsing
[08]: /powershell/module/microsoft.powershell.core/about/about_parsing#the-stop-parsing-token
[09]: #psansirenderingfileinfo
[10]: #pscommandnotfoundsuggestion
[11]: #pscommandwithargs
[14]: #psdesiredstateconfigurationinvokedscresource
[15]: #psfeedbackprovider
[16]: #psloadassemblyfromnativecode
[17]: #psmoduleautoloadskipofflinefiles
[18]: #psnativecommandargumentpassing
[19]: #psnativecommanderroractionpreference
[21]: #psnativepspathresolution
[22]: #psnativewindowstildeexpansion
[23]: #pssubsystempluginmodel
[24]: #psredirecttovariable
[25]: #psserializejsonlongenumasnumber
[26]: https://github.com/PowerShell/PowerShell/issues/new/choose
[27]: https://github.com/PowerShell/PowerShell/tree/master/test/tools/TestExe
[28]: xref:Microsoft.PowerShell.Core.Disable-ExperimentalFeature
[29]: xref:Microsoft.PowerShell.Core.Enable-ExperimentalFeature
[30]: xref:Microsoft.PowerShell.Core.Get-ExperimentalFeature
[31]: xref:Microsoft.PowerShell.Core.Get-PSSubsystem
[32]: xref:Microsoft.PowerShell.Management.Start-Process
[33]: xref:Microsoft.PowerShell.Utility.ConvertTo-Json
[34]: xref:Microsoft.PowerShell.Utility.Trace-Command
