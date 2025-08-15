---
description: This article explains how App Control for Business works to secure PowerShell and the restrictions it imposes.
ms.date: 09/19/2024
title: How App Control for Business works with PowerShell
---
# How App Control works with PowerShell

This article explains how **App Control for Business** secures PowerShell and the
restrictions it imposes. The secure behavior of PowerShell varies based on the version of Windows
and PowerShell you're using.

## How PowerShell detects a system lockdown policy

PowerShell detects both **AppLocker** and **App Control for Business** system
wide polices. AppLocker is deprecated. App Control is the preferred application control system for Windows.

### Legacy App Control policy enforcement detection

PowerShell uses the legacy App Control `WldpGetLockdownPolicy` API to discover two things:

- System wide policy enforcement: `None`, `Audit`, `Enforce`
- Individual file policy: `None`, `Audit` (allowed by policy), `Enforce` (not allowed by policy)

All versions of PowerShell (v5.1 - v7.x) support this App Control policy detection.

### Latest App Control policy enforcement detection

App Control introduced new APIs in recent versions of Windows. Beginning with version 7.3, PowerShell uses
the new `WldpCanExecuteFile` API to decide how a file should be handled. Windows PowerShell 5.1
doesn't support this new API. The new API takes precedence over the legacy API for individual files.
However, PowerShell continues to use the legacy API to get the system wide policy configuration. If
the new API isn't available, PowerShell falls back to the old API behavior.

The new API provides the following information for each file:

- `WLDP_CAN_EXECUTE_ALLOWED`
- `WLDP_CAN_EXECUTE_BLOCKED`
- `WLDP_CAN_EXECUTE_REQUIRE_SANDBOX`

## PowerShell behavior under lockdown policy

PowerShell can run in both interactive and non-interactive modes.

- In interactive mode, PowerShell is a command-line application that takes users command-line input
  as commands or scripts to run. Results are displayed back to the user.
- In non-interactive mode, PowerShell loads modules and runs script files without user input. Result
  data streams are either ignored or redirected to a file.

### Interactive mode running under policy enforcement

PowerShell runs commands in `ConstrainedLanguage` mode. This mode prevents interactive users from
running certain commands or executing arbitrary code. For more information about the restrictions in
this mode, see the [PowerShell restrictions under lockdown policy][02] section of this article.

### Noninteractive mode running under policy enforcement

When PowerShell runs a script or loads a module, it uses the App Control API to get the policy enforcement
for the file.

PowerShell version 7.3 or higher uses the `WldpCanExecuteFile` API if available. This API returns one
of the following results:

- `WLDP_CAN_EXECUTE_ALLOWED`: The file is approved by policy and is used in `FullLanguage` mode with
  a few restrictions.
- `WLDP_CAN_EXECUTE_BLOCKED`: The file isn't approved by policy. PowerShell throws an error when the
  file is run or loaded.
- `WLDP_CAN_EXECUTE_REQUIRE_SANDBOX`: The file isn't approved by the policy but it can still be run
  or loaded in `ConstrainedLanguage` mode.

In Windows PowerShell 5.1 or if `WldpCanExecuteFile` API isn't available, PowerShell's per file
behavior is:

- `None`: The file is run loaded in `FullLanguage` mode with a few restrictions.
- `Audit`: The file is run or loaded in `FullLanguage` mode with no restrictions. In PowerShell
  7.4 or higher, the policy logs restriction information to the Windows event logs.
- `Enforce`: The file is run or loaded in `ConstrainedLanguage` mode.

## PowerShell restrictions under lockdown policy

When PowerShell detects the system is under a App Control lockdown policy, it applies restrictions even if
the script is trusted and running in `FullLanguage` mode. These restrictions prevent known behaviors
of PowerShell that could result in arbitrary code execution on a locked-down system. The lockdown
policy enforces the following restrictions:

- Module dot-sourcing with wildcard function export restriction

  Any module that uses script dot-sourcing and exports functions using wildcard names results in an
  error. Blocking wildcard exports prevents script injection from a malicious user who can plant an
  untrusted script that gets dot-sourced into a trusted module. The malicious script could then gain
  access to the trusted module's private functions.

  **Security recommendation:** Never use script dot-sourcing in a module and always export module
  functions with explicit names (no wildcard characters).

- Nested module with wildcard function export restriction

  If a parent module exports functions using function name wildcard characters, PowerShell removes
  any function name in a nested module from the function export list. Blocking wildcard exports from
  nested modules prevents accidental exporting of dangerous nested functions through wildcard name
  matching.

  **Security recommendation:** Always export module functions with explicit names (no wildcard
  characters).

- Interactive shell parameter type conversion

  When the system is locked down, interactive PowerShell sessions run in `ConstrainedLanguage` mode
  to prevent arbitrary code execution. Trusted modules loaded into the session run in `FullLanguage`
  mode. If a trusted module cmdlet uses complex types for its parameters, type conversion during
  parameter binding can fail if the conversion isn't allowed across trust boundaries. The failure
  occurs when PowerShell tries to convert a value by running a type constructor. Type constructors
  aren't allowed to run in `ConstrainedLanguage` mode.

  In this example, parameter binding type conversion is normally allowed, but fails when run in
  `ConstrainedLanguage` mode. The `ConnectionPort` type constructor isn't allowed:

  ```powershell
  PS> Create-ConnectionOnPort -Connection 22
  Create-ConnectionOnPort: Cannot bind parameter 'Connection'. Cannot convert the "22"
  value of type "System.Int32" to type "ConnectionPort".
  ```

- `Enter-PSHostProcess` cmdlet disallowed

  The `Enter-PSHostProcess` cmdlet is disabled and throws an error if used. This command is used for
  attach-and-debug sessions. It allows you to connect to any other PowerShell session on the local
  machine. The cmdlet is disabled to prevent information disclosure and arbitrary code execution.

## PowerShell restrictions under constrained language mode

Script or function that isn't approved by the App Control policy is untrusted. When you run an untrusted
command, PowerShell either blocks the command from running (new behavior) or runs the command in
`ConstrainedLanguage` mode. The following restrictions apply to `ConstrainedLanguage` mode:

- `Add-Type` cmdlet disallowed

  Blocking `Add-Type` prevents the execution of arbitrary .NET code.

- `Import-LocalizedData` cmdlet restricted

  Blocking the **SupportedCommand** parameter of `Import-LocalizedData` prevents the execution of
  arbitrary code.

- `Invoke-Expression` cmdlet restricted

  All script blocks passed to the `Invoke-Expression` cmdlet are run in `ConstrainedLanguage` mode
  to prevent arbitrary code execution.

- `New-Object` cmdlet restricted

  The `New-Object` cmdlet is restricted to use only allowed .NET and COM types, to prevent access to
  untrusted types.

- `ForEach-Object` cmdlet restriction

  Type method invocation for variables passed to the `ForeEach-Object` is disallowed for any .NET
  type not in the approved list. In general, `ConstrainedLanguage` mode disallows any object method
  invocation except for approved .NET types to prevent access to untrusted .NET types.

- `Export-ModuleMember` cmdlet restriction

  Using `Export-ModuleMember` cmdlet to export functions in a nested module script file where the
  child module isn't trusted and the parent module is trusted, results in an error. Blocking this
  scenario prevents a malicious untrusted module from exporting dangerous functions from a trusted
  module.

- `New-Module` cmdlet restriction

  When you run `New-Module` in a trusted script, any script block provided by the `ScriptBlock`
  parameter is marked to run in `ConstrainedLanguage` mode to prevent the injection of arbitrary
  code into a trusted execution context.

- `Configuration` keyword not allowed

  The `Configuration` language keyword isn't allowed in `ConstrainedLanguage` mode to prevent code
  injection attacks.

- `class` keyword not allowed

  The `class` language keyword isn't allowed in `ConstrainedLanguage` mode to prevent the injection
  of arbitrary code.

- Script Block processing scope restrictions

  Child script blocks aren't allowed to run in parent script block scopes if the script blocks have
  different trust levels. For example, you create a child relationship when you dot-source one
  script into another. Blocking this scenario prevents an untrusted script from getting access to
  dangerous functions in the trusted script scope.

- Prevent command discovery of untrusted script functions

  PowerShell command discovery doesn't return functions from an untrusted source, such as an
  untrusted script or module, to a trusted function. Blocking discovery of untrusted commands
  prevents code injection through command planting.

- Hashtable to object conversion not allowed

  `ConstrainedLanguage` mode blocks hashtable to object conversions in the `Data` sections of
  PowerShell data (`.psd1`) files to prevent potential code injection attacks.

- Automatic type conversion restricted

  `ConstrainedLanguage` mode blocks automatic type conversion except for a small set of approved
  safe types to prevent potential code injection attacks.

- Implicit module function export restriction

  If a module doesn't explicitly export functions, PowerShell implicitly exports all defined module
  functions automatically as a convenience feature. In `ConstrainedLanguage` mode, implicit exports
  no longer occur when a module is loaded across trust boundaries. Blocking implicit exports
  prevents unintended exposure of dangerous module functions not meant for public use.

- Script files can't be imported as modules

  PowerShell allows you to import script files (`.ps1`) as a module. All defined functions become
  publicly accessible. `ConstrainedLanguage` mode blocks importation of script file to prevent
  unintended exposure of dangerous script functions.

- Setting variables `AllScope` restriction

  `ConstrainedLanguage` mode disables the ability to set `AllScope` on variables. Limiting the scope
  of variables prevents the variables from interfering with the session state of trusted commands.

- Type method invocation not allowed

  `ConstrainedLanguage` mode doesn't allow method invocation on unapproved types. Blocking methods
  on unapproved types prevents invocation of .NET type methods that might be dangerous or allow code
  injection.

- Type property setters not allowed

  `ConstrainedLanguage` mode restricts invocation of property setters on unapproved types. Blocking
  property setters on unapproved types prevents code injection attacks.

- Type creation not allowed

  `ConstrainedLanguage` mode blocks type creation on unapproved types to block untrusted
  constructors that could allow code injection.

- Module scope operator not allowed

  `ConstrainedLanguage` mode doesn't allow the use of the module scope operator. For example:
  `& (Get-Module MyModule) MyFunction`. Blocking the module scope operator prevents access to module
  private functions and variables.

## Further reading

- For more information about PowerShell language modes, see [about_Language_Modes][01].
- For information about how to configure and use App Control, see [How to use App Control for PowerShell][03].

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_language_modes
[02]: #powershell-behavior-under-lockdown-policy
[03]: how-to-use-wdac.md
