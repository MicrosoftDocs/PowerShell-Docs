---
description: This article summarizes the differences and breaking changes from Windows PowerShell 5.1 and the current version of PowerShell that is based on .NET Core.
ms.date: 02/03/2020
title: Differences between Windows PowerShell 5.1 and PowerShell 7.x
---
  1
```

### Conversions from PSMethod to Delegate

You can convert a `PSMethod` into a delegate. This allows you to do things like passing `PSMethod`
`[M]::DoubleStrLen` as a delegate value into `[M]::AggregateString`:

```powershell
class M {
    static [int] DoubleStrLen([string] $value) { return 2 * $value.Length }

    static [long] AggregateString([string[]] $values, [func[string, int]] $selector) {
        [long] $res = 0
        foreach($s in $values){
            $res += $selector.Invoke($s)
        }
        return $res
    }
}

[M]::AggregateString((gci).Name, [M]::DoubleStrLen)
```

## Cmdlet changes

### Check `system32` for compatible built-in modules on Windows

In the Windows 10 1809 update and Windows Server 2019, we updated a number of built-in PowerShell
modules to mark them as compatible with PowerShell.

When PowerShell starts up, it automatically includes `$windir\System32` as part of the
`PSModulePath` environment variable. However, it only exposes modules to `Get-Module` and
`Import-Module` if its `CompatiblePSEdition` is marked as compatible with `Core`.

You can override this behavior to show all modules using the `-SkipEditionCheck` switch parameter.
We've also added a `PSEdition` property to the table output.

### `-lp` alias for all `-LiteralPath` parameters

We created a standard parameter alias `-lp` for all the built-in PowerShell cmdlets that have a
`-LiteralPath` parameter.

### Fix `Get-Item -LiteralPath a*b` if `a*b` doesn't actually exist to return error

Previously, `-LiteralPath` given a wildcard would treat it the same as `-Path` and if the wildcard
found no files, it would silently exit. Correct behavior should be that `-LiteralPath` is literal
so if the file doesn't exist, it should error. Change is to treat wildcards used with `-Literal` as
literal.

### Set working directory to current directory in `Start-Job`

The `Start-Job` cmdlet now uses the current directory as the working directory for the new job.

### Remove `-Protocol` from `*-Computer` cmdlets

Due to issues with RPC remoting in CoreFX (particularly on non-Windows platforms) and ensuring a
consistent remoting experience in PowerShell, the `-Protocol` parameter was removed from the
`\*-Computer` cmdlets. DCOM is no longer supported for remoting. The following cmdlets only support
WSMAN remoting:

- `Rename-Computer`
- `Restart-Computer`
- `Stop-Computer`

### Remove `-ComputerName` from `*-Service` cmdlets

In order to encourage the consistent use of PSRP, the `-ComputerName` parameter was removed from
`*-Service` cmdlets.

### Fix `Get-Content -Delimiter` to not include the delimiter in the returned lines

Previously, the output while using `Get-Content -Delimiter` was inconsistent and inconvenient as it
required further processing of the data to remove the delimiter. This change removes the delimiter
in returned lines.

### Changes to `Format-Hex`

The `-Raw` parameter is now a "no-op" (in that it does nothing). Going forward all output is
displayed with a true representation of numbers that includes all of the bytes for its type. This is
what the `-Raw` parameter was doing prior to this change.

### Typo fix in Get-ComputerInfo property name

`BiosSerialNumber` was misspelled as `BiosSeralNumber` and has been changed to the correct spelling.

### Add `Get-StringHash` and `Get-FileHash` cmdlets

This change is that some hash algorithms are not supported by CoreFX, therefore they are no longer
available:

- `MACTripleDES`
- `RIPEMD160`

### Add validation on `Get-*` cmdlets where passing $null returns all objects instead of error

Passing `$null` to any of the following now throws an error:

- `Get-Credential -UserName`
- `Get-Event -SourceIdentifier`
- `Get-EventSubscriber -SourceIdentifier`
- `Get-Help -Name`
- `Get-PSBreakpoint -Script`
- `Get-PSProvider -PSProvider`
- `Get-PSSessionConfiguration -Name`
- `Get-Runspace -Name`
- `Get-RunspaceDebug -RunspaceName`
- `Get-Service -Name`
- `Get-TraceSource -Name`
- `Get-Variable -Name`

### Add support for the W3C Extended Log File Format in `Import-Csv`

Previously, the `Import-Csv` cmdlet cannot be used to directly import the log files in W3C extended
log format and additional action would be required. With this change, W3C extended log format is
supported.

### `Import-Csv` applies `PSTypeNames` upon import when type information is present in the CSV

Previously, objects exported using `Export-CSV` with `TypeInformation` imported with
`ConvertFrom-Csv` were not retaining the type information. This change adds the type information to
`PSTypeNames` member if available from the CSV file.

### `-NoTypeInformation` is the default on `Export-Csv`

Previously, the `Export-CSV` cmdlet would output a comment as the first line containing the type
name of the object. The change excludes the type information by default because it's not understood
by most CSV tools. This change was made to address customer feedback.

Use `-IncludeTypeInformation` to retain the previous behavior.

### Allow `*` to be used in registry path for `Remove-Item`

Previously, `-LiteralPath` given a wildcard would treat it the same as `-Path` and if the wildcard
found no files, it would silently exit. Correct behavior should be that `-LiteralPath` is literal
so if the file doesn't exist, it should error. Change is to treat wildcards used with `-Literal` as
literal.

### Group-Object now sorts the groups

As part of the performance improvement, `Group-Object` now returns a sorted listing of the groups.
Although you should not rely on the order, you could be broken by this change if you wanted the
first group. We decided that this performance improvement was worth the change since the impact of
being dependent on previous behavior is low.

### Standard deviation in `Measure-Object`

The output from `Measure-Object` now includes a `StandardDeviation` property.

```powershell
Get-Process | Measure-Object -Property CPU -AllStats
```

```Output
Count             : 308
Average           : 31.3720576298701
Sum               : 9662.59375
Maximum           : 4416.046875
Minimum           :
StandardDeviation : 264.389544720926
Property          : CPU
```

### `Get-PfxCertificate -Password`

`Get-PfxCertificate` now has the `Password` parameter, which takes a `SecureString`. This allows you
to use it non-interactively:

```powershell
$certFile = '\\server\share\pwd-protected.pfx'
$certPass = Read-Host -AsSecureString -Prompt 'Enter the password for certificate: '

$certThumbPrint = (Get-PfxCertificate -FilePath $certFile -Password $certPass ).ThumbPrint
```

### Removal of the `more` function

In the past, PowerShell shipped a function on Windows called `more` that wrapped `more.com`. That
function has now been removed.

Also, the `help` function changed to use `more.com` on Windows, or the system's default pager
specified by `$env:PAGER` on non-Windows platforms.

### `cd DriveName:` now returns users to the current working directory in that drive

Previously, using `Set-Location` or `cd` to return to a PSDrive sent users to the default location
for that drive. Users are now sent to the last known current working directory for that session.

### `cd -` returns to previous directory

```powershell
C:\Windows\System32> cd C:\
C:\> cd -
C:\Windows\System32>
```

Or on Linux:

```ShellSession
PS /etc> cd /usr/bin
PS /usr/bin> cd -
PS /etc>
```

Also, `cd` and `cd --` change to `$HOME`.

### `Update-Help` as non-admin

By popular demand, `Update-Help` no longer needs to be run as an administrator. `Update-Help` now
defaults to saving help to a user-scoped folder.

### `Where-Object -Not`

With the addition of `-Not` parameter to `Where-Object`, can filter an object at the pipeline for
the non-existence of a property, or a null/empty property value.

For example, this command returns all services that don't have any dependent services defined:

```powershell
Get-Service | Where-Object -Not DependentServices
```

## Changes to Web Cmdlets

The underlying .NET API of the Web Cmdlets has been changed to `System.Net.Http.HttpClient`. This
change provides many benefits. However, this change along with a lack of interoperability with
Internet Explorer have resulted in several breaking changes within `Invoke-WebRequest` and
`Invoke-RestMethod`.

- `Invoke-WebRequest` now supports basic HTML Parsing only. `Invoke-WebRequest` always returns a
  `BasicHtmlWebResponseObject` object. The `ParsedHtml` and `Forms` properties have been removed.
- `BasicHtmlWebResponseObject.Headers` values are now `String[]` instead of `String`.
- `BasicHtmlWebResponseObject.BaseResponse` is now a `System.Net.Http.HttpResponseMessage` object.
- The `Response` property on Web Cmdlet exceptions is now a `System.Net.Http.HttpResponseMessage`
  object.
- Strict RFC header parsing is now default for the `-Headers` and `-UserAgent` parameter. This can
  be bypassed with `-SkipHeaderValidation`.
- `file://` and `ftp://` URI schemes are no longer supported.
- `System.Net.ServicePointManager` settings are no longer honored.
- There is currently no certificate based authentication available on macOS.
- Use of `-Credential` over an `http://` URI will result in an error. Use an `https://` URI or
  supply the `-AllowUnencryptedAuthentication` parameter to suppress the error.
- `-MaximumRedirection` now produces a terminating error when redirection attempts exceed the
  provided limit instead of returning the results of the last redirection.
- In PowerShell 6.2, a change was made to default to UTF-8 encoding for JSON responses. When a
  charset is not supplied for a JSON response, the default encoding should be UTF-8 per RFC 8259.
- Default encoding set to UTF-8 for `application-json` responses
- Added `-SkipHeaderValidation` parameter to allow `Content-Type` headers that aren't
  standards-compliant
- Added `-Form` parameter to support simplified `multipart/form-data` support
- Compliant, case-insensitive handling of relation keys
- Added `-Resume` parameter for web cmdlets

### Invoke-RestMethod returns useful info when no data is returned

When an API returns just `null`, `Invoke-RestMethod` was serializing this as the string `"null"`
instead of `$null`. This change fixes the logic in `Invoke-RestMethod` to properly serialize a
valid single value JSON `null` literal as `$null`.

### Web Cmdlets warn when `-Credential` is sent over unencrypted connections

When using HTTP, content including passwords are sent as clear-text. This change is to not allow
this by default and return an error if credentials are being passed in an insecure manner. Users
can bypass this by using the `-AllowUnencryptedAuthentication` switch.

## API changes

### Remove `AddTypeCommandBase` class

The `AddTypeCommandBase` class was removed from `Add-Type` to improve performance. This class is
only used by the `Add-Type` cmdlet and should not impact users.

### Removed `VisualBasic` as a supported language in Add-Type

In the past, you could compile Visual Basic code using the `Add-Type` cmdlet. Visual Basic was
rarely used with `Add-Type`. We removed this feature to reduce the size of PowerShell.

### Removed `RunspaceConfiguration` support

Previously, when creating a PowerShell runspace programmatically using the API, you could use the
legacy [`RunspaceConfiguration`][runspaceconfig] or the newer [`InitialSessionState`][iss] classes.
This change removed support for `RunspaceConfiguration` and only supports `InitialSessionState`.

[runspaceconfig]: /dotnet/api/system.management.automation.runspaces.runspaceconfiguration
[iss]: /dotnet/api/system.management.automation.runspaces.initialsessionstate

### `CommandInvocationIntrinsics.InvokeScript` bind arguments to `$input` instead of `$args`

An incorrect position of a parameter resulted in the args passed as input instead of as args.

### Remove `ClrVersion` and `BuildVersion` properties from `$PSVersionTable`

The `ClrVersion` property of `$PSVersionTable` is not useful with CoreCLR. End users should not be
using that value to determine compatibility.

The `BuildVersion` property was tied to the Windows build version, which is not available on
non-Windows platforms. Use the `GitCommitId` property to retrieve the exact build version of
PowerShell.

### Implement Unicode escape parsing

`` `u####`` or `` `u{####}`` is converted to the corresponding Unicode character. To output a
literal `` `u``, escape the backtick: ``` ``u```.

### Parameter binding problem with `ValueFromRemainingArguments` in PS functions

`ValueFromRemainingArguments` now returns the values as an array instead of a single value which
itself is an array.

### Cleaned up uses of `CommandTypes.Workflow` and `WorkflowInfoCleaned`

Clean up code related to the uses of `CommandTypes.Workflow` and `WorkflowInfo` in
**System.Management.Automation**.

These minor breaking changes mainly affect help provider code.

- Change the public constructors of `WorkflowInfo` to internal. We don't support workflow anymore,
  so it makes sense to not allow people to create `Workflow` instances.
- Remove the type **System.Management.Automation.DebugSource** since it's only used for workflow
  debugging.
- Remove the overload of `SetParent` from the abstract class **Debugger** that is only used for
  workflow debugging.
- Remove the same overload of `SetParent` from the derived class **RemotingJobDebugger**.

### Do not wrap return result in `PSObject` when converting a `ScriptBlock` to a delegate

When a `ScriptBlock` is converted to a delegate type to be used in C# context, wrapping the result
in a `PSObject` brings unneeded troubles:

- When the value is converted to the delegate return type, the `PSObject` essentially gets
  unwrapped. So the `PSObject` is unneeded.
- When the delegate return type is `object`, it gets wrapped in a `PSObject` making it hard to
  work with in C# code.

After this change, the returned object is the underlying object.

## Remoting Support

PowerShell Remoting (PSRP) using WinRM on Unix platforms requires NTLM/Negotiate or Basic Auth over
HTTPS. PSRP on macOS only supports Basic Auth over HTTPS. Kerberos-based authentication is not
supported for non-Windows platforms.

PowerShell also supports PowerShell Remoting (PSRP) over SSH on all platforms (Windows, macOS, and
Linux). For more information, see
[SSH remoting in PowerShell](/powershell/scripting/learn/remoting/SSH-Remoting-in-PowerShell-Core).

### PowerShell Direct for Containers tries to use `pwsh` first

[PowerShell Direct](/virtualization/hyper-v-on-windows/user-guide/powershell-direct) is a feature of
PowerShell and Hyper-V that allows you to connect to a Hyper-V VM or Container without network
connectivity or other remote management services.

In the past, PowerShell Direct connected using the built-in Windows PowerShell instance on the
Container. Now, PowerShell Direct first attempts to connect using any available `pwsh.exe` on the
`PATH` environment variable. If `pwsh.exe` isn't available, PowerShell Direct falls back to use
`powershell.exe`.

### `Enable-PSRemoting` now creates separate remoting endpoints for preview versions

`Enable-PSRemoting` now creates two remoting session configurations:

- One for the major version of PowerShell. For example, `PowerShell.6`. This endpoint that can be
  relied upon across minor version updates as the "system-wide" PowerShell 6 session configuration
- One version-specific session configuration, for example: `PowerShell.6.1.0`

This behavior is useful if you want to have multiple PowerShell 6 versions installed and accessible
on the same machine.

Additionally, preview versions of PowerShell now get their own
remoting session configurations after running the `Enable-PSRemoting` cmdlet:

```powershell
C:\WINDOWS\system32> Enable-PSRemoting
```

Your output may be different if you haven't set up WinRM before.

```Output
WinRM is already set up to receive requests on this computer.
WinRM is already set up for remote management on this computer.
```

Then you can see separate PowerShell session configurations for the preview and stable builds of
PowerShell 6, and for each specific version.

```powershell
Get-PSSessionConfiguration
```

```Output
Name          : PowerShell.6.2-preview.1
PSVersion     : 6.2
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed

Name          : PowerShell.6-preview
PSVersion     : 6.2
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed

Name          : powershell.6
PSVersion     : 6.1
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed

Name          : powershell.6.1.0
PSVersion     : 6.1
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed
```

### `user@host:port` syntax supported for SSH

SSH clients typically support a connection string in the format `user@host:port`. With the addition
of SSH as a protocol for PowerShell Remoting, we've added support for this format of connection
string:

`Enter-PSSession -HostName fooUser@ssh.contoso.com:2222`

## Telemetry can only be disabled with an environment variable

PowerShell sends basic telemetry data to Microsoft when it is launched. The data includes the OS
name, OS version, and PowerShell version. This data allows us to better understand the environments
where PowerShell is used and enables us to prioritize new features and fixes.

To opt-out of this telemetry, set the environment variable `POWERSHELL_TELEMETRY_OPTOUT` to `true`,
`yes`, or `1`. We no longer support deletion of the file
`DELETE_ME_TO_DISABLE_CONSOLEHOST_TELEMETRY` to disable telemetry.
