---
description: Lists the currently available experimental features and how to use them.
ms.date: 11/30/2023
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
> and bug reports. You can file issues in the [GitHub source repository][24].

For more information about enabling or disabling these features, see
[about_Experimental_Features][06].

## Experimental feature lifecycle

The [Get-ExperimentalFeature][28] cmdlet returns all experimental features available to PowerShell.
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
PSSubsystemPluginModel              True PSEngine A plugin model for registering and un-registering…
```

Use the [Enable-ExperimentalFeature][27] and [Disable-ExperimentalFeature][26] cmdlets to enable or
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

|                        Name                         |         7.2         |         7.3         |         7.4         |
| --------------------------------------------------- | :-----------------: | :-----------------: | :-----------------: |
| [PSCommandNotFoundSuggestion][10]                   | ![Experimental][02] | ![Experimental][02] | ![Experimental][02] |
| [PSDesiredStateConfiguration.InvokeDscResource][14] | ![Experimental][02] | ![Experimental][02] | ![Experimental][02] |
| [PSNativePSPathResolution][21]                      | ![Experimental][02] | ![Discontinued][03] |                     |
| [PSSubsystemPluginModel][22]                        | ![Experimental][02] | ![Experimental][02] | ![Experimental][02] |
| [PSNativeCommandArgumentPassing][18]                | ![Experimental][02] |  ![Mainstream][01]  |                     |
| [PSAnsiRenderingFileInfo][09]                       | ![Experimental][02] |  ![Mainstream][01]  |                     |
| [PSLoadAssemblyFromNativeCode][16]                  | ![Experimental][02] | ![Experimental][02] | ![Experimental][02] |
| [PSNativeCommandErrorActionPreference][19]          |                     | ![Experimental][02] |  ![Mainstream][01]  |
| [PSCustomTableHeaderLabelDecoration][13]            |                     |                     |  ![Mainstream][01]  |
| [PSFeedbackProvider][15]                            |                     |                     | ![Experimental][02] |
| [PSModuleAutoLoadSkipOfflineFiles][17]              |                     |                     | ![Experimental][02] |
| [PSCommandWithArgs][11]                             |                     |                     | ![Experimental][02] |
| [PSConstrainedAuditLogging][12]                     |                     |                     |  ![Mainstream][01]  |
| [PSNativeCommandPreserveBytePipe][20]               |                     |                     |  ![Mainstream][01]  |
| [PSWindowsNativeCommandArgPassing][23]              |                     |                     |  ![Mainstream][01]  |

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

### PSConstrainedAuditLogging

<!-- Keep this until 7.4.1 then remove since it's already in the mainstream docs -->

> [!NOTE]
> This feature became mainstream in PowerShell 7.4.

On Windows, when PowerShell runs under a Windows Defender Application Control (WDAC) policy, it
changes its behavior based on the defined security policy. Under a WDAC policy, PowerShell runs
trusted scripts and modules allowed by the policy in Full Language mode. All other scripts and
script blocks are untrusted and run in Constrained Language mode. PowerShell throws errors when the
untrusted scripts attempt to perform disallowed actions. It's difficult to know why a script fails
to run correctly in Constrained Language mode.

When you enable the `PSConstrainedAuditLogging` experimental feature, PowerShell supports WDAC
policies in **Audit** mode. In audit mode, PowerShell runs the untrusted scripts in Constrained
Language mode but logs messages to the event log instead of throwing errors. The log messages
describe what restrictions would apply if the policy was in **Enforce** mode.

This feature was added in PowerShell 7.4-preview.4.

### PSCustomTableHeaderLabelDecoration

<!-- Keep this until 7.4.1 then remove since it's already in the mainstream docs -->

> [!NOTE]
> This feature became mainstream in PowerShell 7.4.

When you enable this feature, `$PSStyle` includes formatting differentiation for table header labels
that aren't property members. For example, the default output from `Get-Process` includes the
following columns: `NPM(K)`, `PM(M)`, `WS(M)`, and `CPU(s)`.

```powershell
Get-Process pwsh
```

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     99    84.57     170.50       5.89   48688   1 pwsh
     73    87.75     133.08       3.09   49120   1 pwsh
     98    70.31     158.56       4.23   91220   1 pwsh
    125    70.19     171.33       4.84   92124   1 pwsh
```

These column names don't match any properties of the **System.Diagnostics.Process** object returned
by the cmdlet. These are values calculated by the PowerShell formatting system.

With this feature enabled these column headers are displayed in italics to distinguish these column
names from property names.

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
> Use the [stop-parsing token][08] (`--%`) or the [`Start-Process`][30] cmdlet to sidestep native
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
> See [TestExe][25] in the PowerShell source repository.

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
information, see [Trace-Command][31].

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

`$PSNativeCommandUseErrorActionPreference` is set to `$true` by default. With the preference set to
`$true` you get the following behavior:

- When `$ErrorActionPreference = 'Stop'`, scripts will break when a native command returns a
  non-zero exit code.
- When `$ErrorActionPreference = 'Continue'` (the default), you will see PowerShell error messages
  for native command errors, but scripts won't break.

### PSNativeCommandPreserveBytePipe

<!-- Keep this until 7.4.1 then remove since it's already in the mainstream docs -->

> [!NOTE]
> This feature became mainstream in PowerShell 7.4.

This feature preserves the byte-stream data when redirecting the **stdout** stream of a native
command to a file or when piping byte-stream data to the **stdin** stream of a native command.

For example, using the native command `curl` you can download a binary file and save it to disk
using redirection.

```powershell
$uri = 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.4/powershell-7.3.4-linux-arm64.tar.gz'

# native command redirected to a file
curl -s -L $uri > powershell.tar.gz
```

You can also pipe the byte-stream data to the **stdin** stream of another native command. The
following example downloads a zipped TAR file using `curl`. The downloaded file data is streamed
to the `tar` command to extract the contents of the archive.

```powershell
# native command output piped to a native command
curl -s -L $uri | tar -xzvf - -C .
```

You can also pipe the byte-stream output of a PowerShell command to the input of native command. The
following examples use `Invoke-WebRequest` to download the same TAR file as the previous example.

```powershell
# byte stream piped to a native command
(Invoke-WebRequest $uri).Content | tar -xzvf - -C .

# bytes piped to a native command (all at once as byte[])
,(Invoke-WebRequest $uri).Content | tar -xzvf - -C .
```

This feature doesn't support byte-stream data when redirecting **stderr** output to **stdout**. When
you combine the **stderr** and **stdout** streams, the combined streams are treated as string data.

This experimental feature was added in PowerShell 7.4-preview.4.

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

### PSSubsystemPluginModel

This feature enables the subsystem plugin model in PowerShell. The feature makes it possible to
separate components of `System.Management.Automation.dll` into individual subsystems that reside in
their own assembly. This separation reduces the disk footprint of the core PowerShell engine and
allows these components to become optional features for a minimal PowerShell installation.

Currently, only the **CommandPredictor** subsystem is supported. This subsystem is used along with
the PSReadLine module to provide custom prediction plugins. In future, **Job**,
**CommandCompleter**, **Remoting** and other components could be separated into subsystem assemblies
outside of `System.Management.Automation.dll`.

The experimental feature includes a new cmdlet, [Get-PSSubsystem][29]. This cmdlet is only available
when the feature is enabled. This cmdlet returns information about the subsystems that are available
on the system.

### PSWindowsNativeCommandArgPassing

<!-- Keep this until 7.4.1 then remove since it's already in the mainstream docs -->

> [!NOTE]
> This feature became mainstream in PowerShell 7.4.

The feature changes the default values of the `$PSNativeCommandArgumentPassing` variable.

- When you enable this feature on Windows, `$PSNativeCommandArgumentPassing` is set to `Windows`.
- When you enable this feature on non-Windows platforms, `$PSNativeCommandArgumentPassing` is set to
  `Standard`.
- When you disable this feature on Windows, `$PSNativeCommandArgumentPassing` is set to `Legacy`.
- When you disable this feature on non-Windows platforms, `$PSNativeCommandArgumentPassing` is set
  to `Standard`.

Also, this feature adds new telemetry metrics to inform us how the feature is being used.

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
[12]: #psconstrainedauditlogging
[13]: #pscustomtableheaderlabeldecoration
[14]: #psdesiredstateconfigurationinvokedscresource
[15]: #psfeedbackprovider
[16]: #psloadassemblyfromnativecode
[17]: #psmoduleautoloadskipofflinefiles
[18]: #psnativecommandargumentpassing
[19]: #psnativecommanderroractionpreference
[20]: #psnativecommandpreservebytepipe
[21]: #psnativepspathresolution
[22]: #pssubsystempluginmodel
[23]: #pswindowsnativecommandargpassing
[24]: https://github.com/PowerShell/PowerShell/issues/new/choose
[25]: https://github.com/PowerShell/PowerShell/tree/master/test/tools/TestExe
[26]: xref:Microsoft.PowerShell.Core.Disable-ExperimentalFeature
[27]: xref:Microsoft.PowerShell.Core.Enable-ExperimentalFeature
[28]: xref:Microsoft.PowerShell.Core.Get-ExperimentalFeature
[29]: xref:Microsoft.PowerShell.Core.Get-PSSubsystem
[30]: xref:Microsoft.PowerShell.Management.Start-Process
[31]: xref:Microsoft.PowerShell.Utility.Trace-Command
