---
description: Explains language modes and their effect on PowerShell sessions.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 09/09/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_language_modes?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Language_Modes
---
# About Language Modes

## SHORT DESCRIPTION
Explains language modes and their effect on PowerShell sessions.

## LONG DESCRIPTION

The language mode of a PowerShell session determines, in part, which elements
of the PowerShell language can be used in the session.

PowerShell supports the following language modes:

- FullLanguage
- ConstrainedLanguage (introduced in PowerShell 3.0)
- RestrictedLanguage
- NoLanguage

### WHAT IS A LANGUAGE MODE?

The language mode determines the language elements that are permitted in the
session.

The language mode is actually a property of the session configuration (or
"endpoint") that is used to create the session. All sessions that use a
particular session configuration have the language mode of the session
configuration.

All PowerShell sessions have a language mode, including PSSessions that you
create by using the `New-PSSession` cmdlet, temporary sessions that use the
ComputerName parameter, and the default sessions that appear when you start
PowerShell.

Remote sessions are created by using the session configurations on the remote
computer. The language mode set in the session configuration determines the
language mode of the session. To specify the session configuration of a
PSSession, use the ConfigurationName parameter of cmdlets that create a
session.

### LANGUAGE MODES

This section describes the language modes in PowerShell sessions.

#### FULL LANGUAGE (FullLanguage)

The FullLanguage mode permits all language elements in the session.
FullLanguage is the default language mode for default sessions on all versions
of Windows except for Windows RT.

#### RESTRICTED LANGUAGE (RestrictedLanguage)

In RestrictedLanguage mode, users may run commands (cmdlets, functions, CIM
commands, and workflows) but are not permitted to use script blocks.

By default, only the following variables are permitted in RestrictedLanguage
mode:

- `$PSCulture`
- `$PSUICulture`
- `$True`
- `$False`
- `$Null`

Module manifests, which use RestrictedLanguage mode, permit the following
additional variables as well:

- `$PSScriptRoot`
- `$PSEdition` (in PowerShell Core)
- `$EnabledExperimentalFeatures` (in PowerShell Core)

Only the following comparison operators are permitted:

- `-eq` (equal)
- `-gt` (greater-than)
- `-lt` (less-than)

Assignment statements, property references, and method calls are not
permitted.

#### NO LANGUAGE (NoLanguage)

NoLanguage mode can only be used through the API. NoLanguage mode means no
script text of any form is permitted. This precludes the use of the
**AddScript()** method which sends fragments of PowerShell script to be parsed
and executed. You can only use **AddCommand()** and **AddParameter()** which
don't go through the parser.

#### CONSTRAINED LANGUAGE (Constrained Language)

The ConstrainedLanguage mode permits all cmdlets and all PowerShell language
elements, but it limits permitted types.

ConstrainedLanguage mode is designed to support User Mode Code Integrity (UMCI)
on Windows RT. It is the only supported language mode on Windows RT, but it is
available on all supported systems.

UMCI protects ARM devices by allowing only Microsoft-signed and
Microsoft-certified apps to be installed on Windows RT-based devices.
ConstrainedLanguage mode prevents users from using PowerShell to circumvent or
violate UMCI.

The features of ConstrainedLanguage mode are as follows:

- All cmdlets in Windows modules, and other UMCI-approved cmdlets, are
  fully functional and have complete access to system resources, except as
  noted.

- All elements of the PowerShell scripting language are permitted.

- All modules included in Windows can be imported and all commands that the
  modules export run in the session.

- In PowerShell Workflow, you can write and run script workflows (workflows
  written in the PowerShell language). XAML-based workflows are not supported
  and you cannot run XAML in a script workflow, such as by using
  `Invoke-Expression -Language XAML`. Also, workflows cannot call other
  workflows, although nested workflows are permitted.

- The `Add-Type` cmdlet can load signed assemblies, but it cannot load
  arbitrary C# code or Win32 APIs.

- The `New-Object` cmdlet can be used only on allowed types (listed below).

- Only allowed types (listed below) can be used in PowerShell. Other types are
  not permitted.

- Type conversion is permitted, but only when the result is an allowed type.

- Cmdlet parameters that convert string input to types work only when the
  resulting type is an allowed type.

- The **ToString()** method and the .NET methods of allowed types (listed
  below) can be invoked. Other methods cannot be invoked.

- Users can get all properties of allowed types. Users can set the values of
  properties only on Core types. Only the following COM objects are permitted:

  - **Scripting.Dictionary**
  - **Scripting.FileSystemObject**
  - **VBScript.RegExp**

The following types are permitted in ConstrainedLanguage mode. Users
can get properties, invoke methods, and convert objects to these types.

Allowed Types:

- AliasAttribute
- AllowEmptyCollectionAttribute
- AllowEmptyStringAttribute
- AllowNullAttribute
- Array
- Bool
- byte
- char
- CmdletBindingAttribute
- DateTime
- decimal
- DirectoryEntry
- DirectorySearcher
- double
- float
- Guid
- Hashtable
- int
- Int16
- long
- ManagementClass
- ManagementObject
- ManagementObjectSearcher
- NullString
- OutputTypeAttribute
- ParameterAttribute
- PSCredential
- PSDefaultValueAttribute
- PSListModifier
- PSObject
- PSPrimitiveDictionary
- PSReference
- PSTypeNameAttribute
- Regex
- SByte
- string
- SupportsWildcardsAttribute
- SwitchParameter
- System.Globalization.CultureInfo
- System.Net.IPAddress
- System.Net.Mail.MailAddress
- System.Numerics.BigInteger
- System.Security.SecureString
- TimeSpan
- UInt16
- UInt32
- UInt64

### FINDING THE LANGUAGE MODE OF A SESSION CONFIGURATION

When a session configuration is created by using a session configuration file,
the session configuration has a LanguageMode property. You can find the
language mode by getting the value of the LanguageMode property.

```powershell
(Get-PSSessionConfiguration -Name Test).LanguageMode
FullLanguage
```

On other session configurations, you can find the language mode indirectly by
finding the language mode of a session that is created by using the session
configuration.

### FINDING THE LANGUAGE MODE OF A SESSION

You can find the language mode of a FullLanguage or ConstrainedLanguage
session by getting the value of the LanguageMode property of the session
state.

For example:

```powershell
$ExecutionContext.SessionState.LanguageMode
ConstrainedLanguage
```

However, in sessions with RestrictedLanguage and NoLanguage modes,
you cannot use the dot method to get property values. Instead, the error
message reveals the language mode.

When you run the `$ExecutionContext.SessionState.LanguageMode` command in a
RestrictedLanguage session, PowerShell returns the
PropertyReferenceNotSupportedInDataSection and
VariableReferenceNotSupportedInDataSection error messages.

- PropertyReferenceNotSupportedInDataSection: Property references are not
  allowed in restricted language mode or a Data section.
- VariableReferenceNotSupportedInDataSection A variable that cannot be
  referenced in restricted language mode or a Data section is being
  referenced.

When you run the `$ExecutionContext.SessionState.LanguageMode` command in a
NoLanguage session, PowerShell returns the ScriptsNotAllowed error message.

- ScriptsNotAllowed: The syntax is not supported by this runspace. This might
  be because it is in no-language mode.

## SEE ALSO

- [about_Session_Configuration_Files](about_Session_Configuration_Files.md)
- [about_Session_Configurations](about_Session_Configurations.md)
