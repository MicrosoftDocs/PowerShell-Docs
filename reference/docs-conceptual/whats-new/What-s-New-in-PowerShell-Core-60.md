# What's New in PowerShell Core 6.0

## Renamed `powershell(.exe)` to `pwsh(.exe)`

The binary name for PowerShell Core has been changed from `powershell(.exe)` to `pwsh(.exe)` in order to provide a deterministic way for users to open PowerShell Core on machines where both Windows PowerShell and PowerShell Core are installed.

`pwsh` is also much shorter and easier to type.

Additionally, we've made some changes to `pwsh(.exe)`:

- Change positional parameter for `powershell.exe` from `-Command` to `-File`.
 This fixes the usage of `#!` (aka as a shebang) in PowerShell scripts that are being executed from non-PowerShell shells on non-Windows platforms.
 This also means that you can now do things like `powershell foo.ps1` or `powershell fooScript` without specifying `-File`.
 However, this change now requires that you explicitly specify `-c` or `-Command` when trying to do things like `powershell.exe Get-Command`.
 (#4019)
- Update PowerShell Core to accept the `-i` (or `-Interactive`) switch to indicate an interactive shell. (#3558)
 This will help when using PowerShell as a default shell on Unix platforms.
- Remove parameters `-importsystemmodules` and `-psconsoleFile` from `pwsh.exe`. (#4995)
- Fix `pwsh -version` and built-in help for `pwsh.exe` to align with other native tools. (#4958 & #4931) (Thanks @iSazonov)
- Make invalid argument error messages for `-File` and `-Command` consistent and make exit codes consistent with Unix standards (#4573)
- Add `-WindowStyle` parameter on Windows. (#4573)

## Moved from .NET Framework to .NET Core

TODO

## Support for macOS and Linux

PowerShell now supports macOS and Linux, including:

TODO

We also made a number of changes to PowerShell in order to make it work better with non-Windows ecosystems.
Some of these are breaking changes which also affect Windows.
Others are only present or applicable in non-Windows installations of PowerShell Core.

TODO: organize
- Add support for native command globbing on Unix platforms.
- `more` function respects the Linux `$PAGER`; defaults to `less`
 This means you can now use wildcards with native binaries/commands (e.g. `ls *.txt`). (#3463)
- Escape trailing backslash when dealing with native command arguments. (#4965)
- Ignore the `-ExecutionPolicy` switch when running PowerShell on non-Windows platforms because script signing is not currently supported. (#3481)
- Fix ConsoleHost to honour `NoEcho` on Unix platforms. (#3801)
- Fix `Get-Help` to support case insensitive pattern matching on Unix platforms. (#3852)
- `powershell` man-page added to package

### Logging

On macOS, PowerShell uses the native `os_log` APIs to log to Apple's [unified logging system][os_log].
On Linux, PowerShell uses [Syslog][], a ubiquitous logging solution.

### Filesystem

A number of changes have been made on macOS and Linux to support filename characters not traditionally supported on Windows:

- Paths given to cmdlets are now slash-agnostic (both / and \ work as directory separator)
- XDG Base Directory Specification is now respected and used by default.
 This means that the Linux/macOS profile path is located at `~/.config/powershell/profile.ps1`,
 the history save path is located at `~/.local/share/powershell/PSReadline/ConsoleHost_history.txt`,
 and the user module path is located at `~/.local/share/powershell/Modules`.
- Enable support of folders and files with colon in name on Unix. (#4959)
- Script names or full paths can have commas. (#4136) (Thanks to @TimCurwick!)
- Fix detection of whether `-LiteralPath` was used to suppress wildcard expansion for navigation cmdlets. (#5038)
- Update `Get-ChildItem` to be more in line with the way that the *nix `ls -R` and the Windows `DIR /S` native commands handle symbolic links to directories during a recursive search.
 Now, `Get-ChildItem` returns the symbolic links it encountered during the search, but it won't search the directories those links target. (#3780)

### Case sensitivity

Generally speaking, PowerShell tries to be case insensitive, while macOS and Linux tend to be case sensitive
(unlike Windows, which is generally case-preserving/insensitive).

For example, environment variables are case-sensitive on macOS and Linux,
so we standardized the casing of the `PSModulePath` environment variable. (#3255)
We also made `Import-Module` case insensitive when it's using a file path to determine the module's name. (#5097)

## Support for side-by-side installations

PowerShell Core is fully side-by-side:

- PowerShell Core is installed, configured, and executed separately from Windows PowerShell
- PowerShell Core has a "portable" ZIP package, so any number of versions can be installed anywhere on disk,
 or local to an application that takes PowerShell as a dependency

This means that it is significantly easier to test new and preview versions of PowerShell and migrating existing workloads over time.
Side-by-side also enables backwards compatibility as scripts can be pinned to specific versions that they require.

> Note: by default, the MSI-based installer on Windows does an in-place, update install.
Similarly, package-based installations updates on non-Windows platforms are in-place.

## Backwards compatibility with Windows PowerShell

Our goal with PowerShell Core is to remain as compatible with Windows PowerShell as technically possible.
To that end, we're leveraging a technology called [.NET Standard](https://docs.microsoft.com/dotnet/standard/net-standard) 2.0 to provide binary compatibility with existing .NET assemblies.
Many PowerShell modules depend on these assemblies (often times DLLs), so .NET Standard allows them to continue working with .NET Core.
When those DLL dependencies reside in the Global Assembly Cache (GAC), PowerShell Core does its best to look up those DLLs in well-known locations on the filesystem.

You can learn more about .NET Standard on the [.NET Blog](https://blogs.msdn.microsoft.com/dotnet/2016/09/26/introducing-net-standard/), [YouTube](https://www.youtube.com/watch?v=YI4MurjfMn8&list=PLRAdsfhKI4OWx321A_pr-7HhRNk7wOLLY), and via [this excellent FAQ on GitHub](https://github.com/dotnet/standard/blob/master/docs/faq.md).

We've also done our best to make sure that all aspects of the PowerShell language and "built-in" modules (e.g. `Microsoft.PowerShell.Management`, `Microsoft.PowerShell.Utility`, etc.) work the same as they do in Windows PowerShell.
In many cases, with the help of our amazing community, we've added new capabilities and bug fixes to those cmdlets.
In some cases, functionality was removed or is unavailable, usually due to a missing dependency in underlying .NET layers,
but we've done our best to limit these cases.

Most of the modules that ship as part of Windows (e.g. `DnsClient`, `Hyper-V`, `NetTCPIP`, `Storage`, etc.) and other Microsoft products including Azure and Office have not been *explicitly* ported to .NET Core yet.
However, we are working with these product groups and teams to validate and port their existing modules on PowerShell Core.
with the promise of .NET Standard and [CDXML](https://msdn.microsoft.com/en-us/library/jj542525(v=vs.85).aspx), many of these traditional Windows PowerShell modules work great in PowerShell Core.

TODO

## Docker support

TODO

## SSH-based PowerShell Remoting

The PowerShell Remoting Protocol (PSRP) now works with the Secure Shell (SSH) protocol, in addition to the traditional WinRM-based PSRP.

This means that you can use cmdlets like `Enter-PSSession` and `New-PSSession` and authenticate using SSH.
All you have to do is register PowerShell as a subsystem with an OpenSSH-based SSH server,
and you can use your existing SSH-based authenticate mechanisms (like passwords or private keys) with the traditional `PSSession` semantics.

For more information on configuring and using SSH-based remoting,
check out [PowerShell Remoting over SSH][ssh-remoting]

## Default encoding is UTF-8 without a BOM

In the past, Windows PowerShell cmdlets like `Get-Content`, `Set-Content` used various different encodings like ASCII and UTF-16.
The variance in encoding defaults created some problems when mixing cmdlets without specifying an encoding.

Additionally, non-Windows platforms traditionally use UTF-8 without a Byte Order Mark (BOM) as the default encoding for text files.
Given that more Windows applications and tools are moving away from UTF-16 and towards BOM-less UTF-8,
we took the opportunity in PowerShell Core to change the default behavior to conform with the broader ecosystem.s

This means that all built-in cmdlets which use the `-Encoding` parameter will use the `UTF8NoBOM` value by default, including:

- Add-Content
- Export-Clixml
- Export-Csv
- Export-PSSession
- Format-Hex
- Get-Content
- Import-Csv
- New-ModuleManifest
- Out-File
- Select-String
- Send-MailMessage
- Set-Content

These cmdlets have also been updated so that the `-Encoding` parameter universally accepts `System.Text.Encoding`.

The default value of `$OutputEncoding` has also been changed to UTF-8.

As a best practice, you should explitly set encodings with the `-Encoding` parameter in scripts to produce deterministic behavior across platforms.

## Support backgrounding of pipelines with ampersand (`&`) (#3360)

Putting `&` at the end of a pipeline will cause the pipeline to be run as a PowerShell job.
When a pipeline is backgrounded, a job object is returned.
Once the pipeline is running as a job, all of the standard `*-Job` cmdlets can be used to manage the job.
Variables (ignoring process-specific variables) used in the pipeline are automatically copied to the job so `Copy-Item $foo $bar &` just works.
The job is also run in the current directory instead of the user's home directory.
For more information about PowerShell jobs, see [about_Jobs](https://msdn.microsoft.com/powershell/reference/6/about/about_jobs).

## Semantic versioning

- Make `SemanticVersion` compatible with `SemVer 2.0`. (#5037) (Thanks @iSazonov!)
- Change default `ModuleVersion` in `New-ModuleManifest` to `0.0.1` to align with SemVer. (#4842) (Thanks @LDSpits)
- Added `semver` as a type accelerator for `System.Management.Automation.SemanticVersion`. (#4142) (Thanks to @oising!)
- Enable comparison between a `SemanticVersion` instance and a `Version` instance that is constructed only with `Major` and `Minor` version values.

## Language updates

- Implement Unicode escape parsing so that users can use Unicode characters as arguments, strings or variable names. (#3958) (Thanks to @rkeithhill!)
- Add new escape character for ESC: `` `e``
- Add support for converting enums to string (#4318) (Thanks @KirkMunro)
- Fix casting single element array to a generic collection. (#3170)
- Add char range overload to the `..` operator, so `'a'..'z'` returns characters from 'a' to 'z'. (#5026) (Thanks @IISResetMe!)
- Fix variable assignment to not overwrite read-only variables
- Push locals of automatic variables to 'DottedScopes' when dotting script cmdlets (#4709)
- Enable use of 'Singleline,Multiline' option in split operator (#4721) (Thanks @iSazonov)

## Engine updates

- `$PSVersionTable` has four new properties:
    - `PSEdition`: This is set to `Core` on PowerShell Core and `Desktop` on Windows PowerShell
    - `GitCommitId`: This is the Git commit ID of the Git branch or tag where PowerShell was built.
    On released builds, it will likely be the same as `PSVersion`.
    - `OS`: This is an OS version string returned by `[System.Environment]::OSVersion.VersionString`
    - `Platform`: This is returned by `[System.Environment]::OSVersion.Platform`
    It is set to `WinNT32` on Windows, `MacOSX` on macOS, and `Unix` on Linux.
- Remove the `BuildVersion` property from `$PSVersionTable`.
 This property was strongly tied to the Windows build version.
 Instead, we recommend that you use `GitCommitId` to retrieve the exact build version of PowerShell Core.
 (#3877) (Thanks to @iSazonov!)
- Remove `ClrVersion` property from `$PSVersionTable`.
 (This property is largely irrelevant for .NET Core,
 and was only preserved in .NET Core for specific legacy purposes that are inapplicable to PowerShell.)
- Three new automatic variables have been created to determine whether PowerShell is running in a given OS:
 `$IsWindows`, `$IsMacOs`, and `$IsLinux`.
- Add `GitCommitId` to PowerShell Core banner.
 Now you don't have to run `$PSVersionTable` as soon as you start PowerShell to get the version! (#3916) (Thanks to @iSazonov!)
- Add a JSON config file called `PowerShellProperties.json` in `$PSHome` to store some settings required before startup time (e.g. `ExecutionPolicy`).
- Don't block pipeline when running Windows EXE's
- Enable enumeration of COM collections. (#4553)

## Cmdlet updates

### New cmdlets

- Add `Get-Uptime` to `Microsoft.PowerShell.Utility`.
- Add `Remove-Alias` Command. (#5143) (Thanks @PowershellNinja!)
- Add `Remove-Service` to Management module. (#4858) (Thanks @joandrsn!)

### Web cmdlets

- Add certificate authentication support for web cmdlets. (#4646) (Thanks @markekraus)
- Add support for content headers to web cmdlets. (#4494 & #4640) (Thanks @markekraus)
- Add multiple link header support to Web Cmdlets. (#5265) (Thanks @markekraus!)
- Support Link header pagination in web cmdlets (#3828)
    - For `Invoke-WebRequest`, when the response includes a Link header we create a RelationLink property as a Dictionary representing the URLs and `rel` attributes and ensure the URLs are absolute to make it easier for the developer to use.
    - For `Invoke-RestMethod`, when the response includes a Link header we expose a `-FollowRelLink` switch to automatically follow `next` `rel` links until they no longer exist or once we hit the optional `-MaximumFollowRelLink` parameter value.
- Add `-CustomMethod` parameter to web cmdlets to allow for non-standard method verbs. (#3142) (Thanks to @Lee303!)
- Add `SslProtocol` support to Web Cmdlets. (#5329) (Thanks @markekraus!)
- Add Multipart support to web cmdlets. (#4782) (Thanks @markekraus)
- Add `-NoProxy` to web cmdlets so that they ignore the system-wide proxy setting. (#3447) (Thanks to @TheFlyingCorpse!)
- User Agent of Web Cmdlets now reports the OS platform (#4937) (Thanks @LDSpits)
- Add `-SkipHeaderValidation` switch to web cmdlets to support adding headers without validating the header value. (#4085)
- Enable web cmdlets to not validate the HTTPS certificate of the server if required.
- Add authentication parameters to web cmdlets. (#5052) (Thanks @markekraus)
    - Add `-Authentication` that provides three options: Basic, OAuth, and Bearer.
    - Add `-Token` to get the bearer token for OAuth and Bearer options.
    - Add `-AllowUnencryptedAuthentication` to bypass authentication that is provided for any transport scheme other than HTTPS.
- Add `-ResponseHeadersVariable` to `Invoke-RestMethod` to enable the capture of response headers. (#4888) (Thanks @markekraus)
- Fix web cmdlets to include the HTTP response in the exception when the response status code is not success. (#3201)
- Change web cmdlets `UserAgent` from `WindowsPowerShell` to `PowerShell`. (#4914) (Thanks @markekraus)
- Add explicit `ContentType` detection to `Invoke-RestMethod` (#4692)
- Fix web cmdlets `-SkipHeaderValidation` to work with non-standard User-Agent headers. (#4479 & #4512) (Thanks @markekraus)

### JSON cmdlets

- Add `-AsHashtable` to `ConvertFrom-Json` to return a `Hashtable` instead. (#5043) (Thanks @bergmeister!)
- Use prettier formatter with `ConvertTo-Json` output. (#2787) (Thanks to @kittholland!)
- Add `Jobject` serialization support to `ConvertTo-Json`. (#5141)
- Fix `ConvertFrom-Json` to deserialize an array of strings from the pipeline that together construct a complete JSON string.
 This fixes some cases where newlines would break JSON parsing. (#3823)
- Remove the `AliasProperty "Count"` defined for `System.Array`.
 This removes the extraneous `Count` property on some `ConvertFrom-Json` output. (#3231) (Thanks to @PetSerAl!)

### CSV cmdlets

- Add `PSTypeName` Support for `Import-Csv` and `ConvertFrom-Csv`. (#5389) (Thanks @markekraus!)
- Make `Import-Csv` support `CR`, `LF` and `CRLF` as line delimiters. (#5363) (Thanks @iSazonov!)
- Make `-NoTypeInformation` the default on `Export-Csv` and `ConvertTo-Csv`. (#5164) (Thanks @markekraus)

### Service cmdlets

- Add properties `UserName`, `Description`, `DelayedAutoStart`, `BinaryPathName` and `StartupType` to the `ServiceController` objects returned by `Get-Service`. (#4907) (Thanks @joandrsn)
- Add functionality to set credentials on `Set-Service` command. (#4844) (Thanks @joandrsn)

### Other cmdlets

- Add a parameter to `Get-ChildItem` called `-FollowSymlink` that traverses symlinks on demand, with checks for link loops. (#4020)
- Update `Add-Type` to support `CSharpVersion7`. (#3933) (Thanks to @iSazonov)
- Remove the `Microsoft.PowerShell.LocalAccounts` module due to the use of unsupported APIs until a better solution is found. (#4302)
- Remove the `*-Counter` cmdlets in `Microsoft.PowerShell.Diagnostics` due to the use of unsupported APIs until a better solution is found. (#4303)
- Add support for `Invoke-Item -Path <folder>`. (#4262)
- Add `-Extension` and `-LeafBase` switches to `Split-Path` so that you can split paths between the filename extension and the rest of the filename. (#2721) (Thanks to @powercode!)
- Add parameters `-Top` and `-Bottom` to `Sort-Object` for Top/Bottom N sort
- Expose a process' parent process by adding the `CodeProperty "Parent"` to `System.Diagnostics.Process`. (#2850) (Thanks to @powercode!)
- Use MB instead of KB for memory columns of `Get-Process`
- Add `-NoNewLine` switch for `Out-String`. (#5056) (Thanks @raghav710)
- `Move-Item` cmdlet honors `-Include`, `-Exclude`, and `-Filter` parameters. (#3878)
- Allow `*` to be used in registry path for `Remove-Item`. (#4866)
- Add `-Title` to `Get-Credential` and unify the prompt experience across platforms.
- Add the `-TimeOut` parameter to `Test-Connection`. (#2492)
- `Get-AuthenticodeSignature` cmdlets can now get file signature timestamp. (#4061)
- Remove unsupported `-ShowWindow` switch from `Get-Help`. (#4903)
- Fix `Get-Content -Delimiter` to not include the delimiter in the array elements returned (#3706) (Thanks @mklement0)
- Add `Meta`, `Charset`, and `Transitional` parameters to `ConvertTo-HTML` (#4184) (Thanks @ergo3114)
- Add `WindowsUBR` and `WindowsVersion` properties to `Get-ComputerInfo` result
- Add `-Group` parameter to `Get-Verb`
- Add `ShouldProcess` support to `New-FileCatalog` and `Test-FileCatalog` (fixes `-WhatIf` and `-Confirm`). (#3074) (Thanks to @iSazonov!)
- Add `-WhatIf` switch to `Start-Process` cmdlet (#4735) (Thanks @sarithsutha)
- Add `ValidateNotNullOrEmpty` to many existing parameters.

## Tab completion

- Enhance type inference in tab completion based on runtime variable values. (#2744) (Thanks to @powercode!)
 This enables tab completion in situations like:
 ```powershell
 $p = Get-Process
 $p | Foreach-Object Prio<tab>
 ```
- Add Hashtable tab completion for `-Property` of `Select-Object`. (#3625) (Thanks to @powercode)
- Enable argument auto-completion for `-ExcludeProperty` and `-ExpandProperty` of `Select-Object`. (#3443) (Thanks to @iSazonov!)
- Fix a bug in tab completion to make `native.exe --<tab>` call into native completer. (#3633) (Thanks to @powercode!)

## Breaking changes

We've introduced a number of breaking changes in PowerShell Core 6.0.
To read more about them in detail, check out our doucment on [Breaking Changes in PowerShell Core 6.0][breaking-changes].

## Debugging

- Support for remote step-in debugging for `Invoke-Command -ComputerName`. (#3015)
- Enable binder debug logging in PowerShell Core

## Filesystem updates

- Enable usage of the Filesystem provider from a UNC path. ($4998)
- `Split-Path` now works with UNC roots
- `cd` with no arguments now behaves as `cd ~`
- Fix PowerShell Core to allow use of long paths that are more than 260 characters. (#3960)

## Performance improvements

We've made *many* improvements to performance across PowerShell,
including in startup time, various built-in cmdlets, and interaction with native binaries.

- Fix performance issues in `Add-Type`. (#5243) (Thanks @iSazonov!)

## Bug fixes

A number of bugs have been fixed within PowerShell Core.
For a complete list, check out our [changelog][] on GitHub.

## Telemetry

- PowerShell Core 6.0 added telemetry to the console host to report two values (#3620):
    - the OS platform (`$PSVersionTable.OSDescription`)
    - the exact version of PowerShell (`$PSVersionTable.GitCommitId`)

If you want to opt-out of this telemetry, simply delete `$PSHome\DELETE_ME_TO_DISABLE_CONSOLEHOST_TELEMETRY`.
Even before the first run of Powershell, deleting this file will bypass all telemetry.
In the future, we plan on also enabling a configuration value for whatever is approved as part of [RFC0015](https://github.com/PowerShell/PowerShell-RFC/blob/master/1-Draft/RFC0015-PowerShell-StartupConfig.md).
We also plan on exposing this telemetry data (as well as whatever insights we leverage from the telemetry) in [our community dashboard][community-dashboard].
You can find out more about how we're using this data in [this blog post][telemetry-blog].

[os_log]: https://developer.apple.com/documentation/os/logging
[Syslog]: TODO
[ssh-remoting]: TODO
[breaking-changes]: TODO
[changelog]: TODO
[community-dashboard]: TODO
[telemetry-blog]: https://blogs.msdn.microsoft.com/powershell/2017/01/31/powershell-open-source-community-dashboard/