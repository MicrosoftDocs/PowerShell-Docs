---
description: Explains language modes and their effect on PowerShell sessions.
Locale: en-US
ms.date: 10/04/2023
no-loc: [FullLanguage, ConstrainedLanguage, RestrictedLanguage, NoLanguage]
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_language_modes?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Language_Modes
---
# about_Language_Modes

## Short description
Explains language modes and their effect on PowerShell sessions.

## Long description

The language mode of a PowerShell session determines which elements of the
PowerShell language can be used in the session.

PowerShell supports the following language modes:

- `FullLanguage`
- `RestrictedLanguage`
- `ConstrainedLanguage` (introduced in PowerShell 3.0)
- `NoLanguage`

## What is a language mode?

The language mode determines the language elements that are permitted in the
session.

The language mode is a property of the session configuration (or "endpoint")
that's used to create the session. All sessions that use a particular session
configuration have the language mode of the session configuration.

All PowerShell sessions have a language mode. Sessions are created using the
session configurations on the target computer. The language mode set in the
session configuration determines the language mode of the session. To specify
the session configuration of a PSSession, use the **ConfigurationName**
parameter of cmdlets that create a session.

Beginning in PowerShell 7.3, you can run `pwsh` with the **ConfigurationFile**
parameter. This allows you to start PowerShell using a specific configuration.

## Finding the language mode of a session

You can find the language mode of a `FullLanguage` or `ConstrainedLanguage`
session by getting the value of the **LanguageMode** property of the session
state.

For example:

```powershell
$ExecutionContext.SessionState.LanguageMode
ConstrainedLanguage
```

However, in sessions with `RestrictedLanguage` and `NoLanguage` modes, you
can't use the [member-access operator][02] (`.`) to get property values.
Instead, the error message reveals the language mode.

When you run the `$ExecutionContext.SessionState.LanguageMode` command in a
`RestrictedLanguage` session, PowerShell returns the
**PropertyReferenceNotSupportedInDataSection** and
**VariableReferenceNotSupportedInDataSection** error messages.

- **PropertyReferenceNotSupportedInDataSection**: Property references aren't
  allowed in restricted language mode or a Data section.
- **VariableReferenceNotSupportedInDataSection**: A variable that can't be
  referenced in restricted language mode or a Data section is being
  referenced.

When you run the `$ExecutionContext.SessionState.LanguageMode` command in a
NoLanguage session, PowerShell returns the **ScriptsNotAllowed** error message.

- **ScriptsNotAllowed**: The syntax isn't supported by this runspace. This
  might be because it's in no-language mode.

## Finding the language mode of a session configuration

When a session configuration is created using a session configuration file, the
session configuration has a **LanguageMode** property. You can find the
language mode by getting the value of the **LanguageMode** property.

```powershell
(Get-PSSessionConfiguration -Name Test).LanguageMode
FullLanguage
```

On other session configurations, you can find the language mode indirectly by
finding the language mode of a session that's created using the session
configuration.

## Setting the language mode

The language mode in a PowerShell session can be set through the built-in
`$ExecutionContext` variable.

```powershell
$ExecutionContext.SessionState.LanguageMode = "ConstrainedLanguage"
```

However, doing this is only useful for experimenting with language modes.
Language modes are intended to provide added security to PowerShell sessions
for specific contexts.

Languages modes are set when you use a system application control policy or
create a session configuration.

### Using a system application control policy

PowerShell automatically runs in `ConstrainedLanguage` mode when it's running
under a system application control policy. The application control
policies detected are AppLocker and Windows Defender Application Control (WDAC)
on Windows platforms.

PowerShell applies other restrictions besides language modes when it detects an
application control policy. For example, there are additional restrictions to
dot-sourcing and module importing under a policy.

When a PowerShell session is started under a policy, it runs in
`ConstrainedLanguage` mode. Beginning in PowerShell 7.4, the start up banner
display includes a message indicating it's running in that mode. This allows
users to have a usable interactive shell experience, running cmdlets and native
commands, as well as access to basic language elements. But the user can't
access PowerShell, .NET, or COM APIs that could be abused by a malicious actor.

Any script or script-based module executed in this session runs in
`ConstrainedLanguage` mode. However, any script or script-based module allowed
by the policy runs in `FullLanguage` mode without any constraints. This way, a
system locked down by policy can have scripts that are trusted by the policy
and run with few constraints.

### Using a session configuration

PowerShell remoting optionally supports creating custom session configurations.
You can set the language mode you want for that custom configuration.
PowerShell Just Enough Administration (JEA) configurations use `NoLanguage`
mode to restrict sessions to command invocations only. With JEA, the remote
session can be restricted to specific users. The JEA users are limited to
running a defined set of commands and can't directly access APIs, the file
system, or other system resources.

For more information, see [JEA Session configurations][01] and
[New-PSSessionConfigurationFile][05].

## Language mode features and limitations

This section describes the language modes in PowerShell sessions.

### FullLanguage mode

The `FullLanguage` mode permits all language elements in the session.
`FullLanguage` is the default language mode for default sessions on all
versions of Windows.

### RestrictedLanguage mode

In `RestrictedLanguage` mode, users can run commands (cmdlets, functions, CIM
commands, and workflows), but can't use script blocks. This mode is also used
to process modules manifests loaded by `Import-Module`.

Beginning in PowerShell 7.2, the `New-Object` cmdlet is disabled in
`RestrictedLanguage` mode when system lockdown is configured.

By default, only the following variables are permitted in `RestrictedLanguage`
mode:

- `$PSCulture`
- `$PSUICulture`
- `$True`
- `$False`
- `$Null`

Module manifests are loaded in `RestrictedLanguage` mode and may use these
additional variables:

- `$PSScriptRoot`
- `$PSEdition`
- `$EnabledExperimentalFeatures`
- Any environment variables, like `$ENV:TEMP`

Only the following comparison operators are permitted:

- `-eq` (equal)
- `-gt` (greater-than)
- `-lt` (less-than)

Assignment statements, property references, and method calls aren't permitted.

### ConstrainedLanguage mode

`ConstrainedLanguage` mode is designed to allow basic language elements such as
loops, conditionals, string expansion, and access to object properties. The
restrictions prevent operations that could be abused by a malicious actor.

The `ConstrainedLanguage` mode permits all cmdlets and a subset of PowerShell
language elements, but limits the object types that can be used.

The features of `ConstrainedLanguage` mode are as follows:

- All cmdlets in Windows modules are fully functional and have complete access
  to system resources, except as noted.
- All elements of the PowerShell scripting language are permitted.
- All modules included in Windows can be imported and all commands that the
  modules export run in the session.
- The `Add-Type` cmdlet can load signed assemblies, but it can't load arbitrary
  C# code or Win32 APIs.
- The `New-Object` cmdlet can be used only on allowed types (listed below).
- Only allowed types can be used in PowerShell. Other types aren't permitted.
  Type conversion is permitted, but only when the result is an allowed type.
- Cmdlet parameters that convert string input to types work only when the
  resulting type is an allowed type.
- The `ToString()` method and the .NET methods of allowed types can be invoked.
- Users can get all properties of allowed types. Users can set the values of
  properties only on allowed types.

The following .NET types are permitted in `ConstrainedLanguage` mode. Users can
get properties, invoke methods, and convert objects to these types.

Allowed Types:

- `[adsi]`
- `[adsisearcher]`
- `[Alias]`
- `[AllowEmptyCollection]`
- `[AllowEmptyString]`
- `[AllowNull]`
- `[ArgumentCompleter]`
- `[ArgumentCompletions]`
- `[array]`
- `[bigint]`
- `[bool]`
- `[byte]`
- `[char]`
- `[cimclass]`
- `[cimconverter]`
- `[ciminstance]`
- `[CimSession]`
- `[cimtype]`
- `[CmdletBinding]`
- `[cultureinfo]`
- `[datetime]`
- `[decimal]`
- `[double]`
- `[DscLocalConfigurationManager]`
- `[DscProperty]`
- `[DscResource]`
- `[ExperimentAction]`
- `[Experimental]`
- `[ExperimentalFeature]`
- `[float]`
- `[guid]`
- `[hashtable]`
- `[int]`
- `[int16]`
- `[int32]`
- `[int64]`
- `[ipaddress]`
- `[IPEndpoint]`
- `[long]`
- `[mailaddress]`
- `[Microsoft.PowerShell.Commands.ModuleSpecification]`
- `[NoRunspaceAffinity]`
- `[NullString]`
- `[Object[]]`
- `[ObjectSecurity]`
- `[ordered]`
- `[OutputType]`
- `[Parameter]`
- `[PhysicalAddress]`
- `[pscredential]`
- `[pscustomobject]`
- `[PSDefaultValue]`
- `[pslistmodifier]`
- `[psobject]`
- `[psprimitivedictionary]`
- `[PSTypeNameAttribute]`
- `[ref]`
- `[regex]`
- `[sbyte]`
- `[securestring]`
- `[semver]`
- `[short]`
- `[single]`
- `[string]`
- `[SupportsWildcards]`
- `[switch]`
- `[timespan]`
- `[uint]`
- `[uint16]`
- `[uint32]`
- `[uint64]`
- `[ulong]`
- `[uri]`
- `[ushort]`
- `[ValidateCount]`
- `[ValidateDrive]`
- `[ValidateLength]`
- `[ValidateNotNull]`
- `[ValidateNotNullOrEmpty]`
- `[ValidateNotNullOrWhiteSpace]`
- `[ValidatePattern]`
- `[ValidateRange]`
- `[ValidateScript]`
- `[ValidateSet]`
- `[ValidateTrustedData]`
- `[ValidateUserDrive]`
- `[version]`
- `[void]`
- `[WildcardPattern]`
- `[wmi]`
- `[wmiclass]`
- `[wmisearcher]`
- `[X500DistinguishedName]`
- `[X509Certificate]`
- `[xml]`

Only the following COM object types are permitted:

- `Scripting.Dictionary`
- `Scripting.FileSystemObject`
- `VBScript.RegExp`

### NoLanguage mode

PowerShell `NoLanguage` mode disables PowerShell scripting language completely.
You can't run scripts or use variables. You can only run native commands and
cmdlets.

Beginning in PowerShell 7.2, the `New-Object` cmdlet is disabled in
`NoLanguage` mode when system lockdown is configured.

## See also

- [about_Session_Configuration_Files][03]
- [about_Session_Configurations][04]

<!-- link references -->
[01]: /powershell/scripting/learn/remoting/jea/session-configurations
[02]: about_member-access_enumeration.md
[03]: about_Session_Configuration_Files.md
[04]: about_Session_Configurations.md
[05]: xref:Microsoft.PowerShell.Core.New-PSSessionConfigurationFile
