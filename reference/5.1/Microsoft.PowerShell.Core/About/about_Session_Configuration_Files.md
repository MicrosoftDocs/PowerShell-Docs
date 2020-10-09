---
description:  Describes session configuration files, which are used in a session configuration (also known as an "endpoint") to define the environment of sessions that use the session configuration. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/03/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_session_configuration_files?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Session_Configuration_Files
---

# About Session Configuration Files

## SHORT DESCRIPTION

Describes session configuration files, which are used in a session
configuration (also known as an "endpoint") to define the environment of
sessions that use the session configuration.

## LONG DESCRIPTION

A "session configuration file" is a text file with a .pssc file name extension
that contains a hash table of session configuration properties and values. You
can use a session configuration file to set the properties of a session
configuration. Doing so defines the environment of any Windows PowerShell
sessions that use that session configuration.

Session configuration files make it easy to create custom session
configurations without using complex C# assemblies or scripts.

A "session configuration" or "endpoint" is a collection of local computer
settings that determine such things as which users can create sessions on the
computer; which commands users can run in those sessions; and whether the
session should run as a privileged virtual account. For more information about
session configurations, see [about_Session_Configurations](about_Session_Configurations.md).

Session configurations were introduced in Windows PowerShell 2.0, and session
configuration files were introduced in Windows PowerShell 3.0. You must use
Windows PowerShell 3.0 to include a session configuration file in a session
configuration. However, users of Windows PowerShell 2.0 (and later) are
affected by the settings in the session configuration.

## Creating Custom Sessions

You can customize many features of a Windows PowerShell session by specifying
session properties in a session configuration. You can customize a session by
writing a C# program that defines a custom runspace, or you can use a session
configuration file to define the properties of sessions created by using the
session configuration. As a general rule, it is easier to use the session
configuration file than to write a C# program.

You can use a session configuration file to create items such as
fully-functioning sessions for highly trusted users; locked-down sessions that
allow minimal access; sessions designed for particular and that contain only
the modules required for those tasks; and sessions where unprivileged users
can only run specific commands as a privileged account.

In addition to that, you can manage whether users of the session can use
Windows PowerShell language elements such as script blocks, or whether they
can only run commands. You can manage the version of Windows PowerShell users
can run in the session; manage which modules are imported into the session;
and manage which cmdlets, functions, and aliases session users can run. When
using the RoleDefinitions field, you can give users different capabilities in
the session based on group membership.

For more information about RoleDefinitions and how to define this Value, see
the help topic for the New-PSRoleCapabilityFile Cmdlet.

## Creating a Session Configuration File

The easiest way to create a session configuration file is by using the
New-PSSessionConfigurationFile cmdlet. This cmdlet generates a file that uses
the correct syntax and format, and that automatically verifies many of the
configuration file property values.

For detailed descriptions of the properties that you can set in a session
configuration file, see the help topic for the New-PSSessionConfigurationFile
cmdlet.

The following command creates a session configuration file that uses the
default values. The resulting configuration file uses only the default values
because no parameters other than the Path parameter (which specifies the file
path) are included:

```powershell
New-PSSessionConfigurationFile -Path .\Defaults.pssc
```

To view the new configuration file in your default text editor, use the
following command:

```powershell
Invoke-Item -Path .\Defaults.pssc
```

To create a session configuration for sessions in which user can run commands,
but not use other elements of the Windows PowerShell language, type:

```powershell
New-PSSessionConfigurationFile -LanguageMode NoLanguage
-Path .\NoLanguage.pssc
```

In the preceding command, setting the LanguageMode parameter to NoLanguage
prevents users from doing such things as writing or running scripts, or using
variables.

To create a session configuration for sessions in which users can use only Get
cmdlets, type:

```powershell
New-PSSessionConfigurationFile -VisibleCmdlets Get-*
-Path .\GetSessions.pssc
```

In the preceding example, setting the VisibleCmdlets parameter to Get-* limits
users to cmdlets that have names that start with the string value "Get-".

To create a session configuration for sessions that run under a privileged
virtual account instead of the user's credentials, type:

```powershell
New-PSSessionConfigurationFile -RunAsVirtualAccount
-Path .\VirtualAccount.pssc
```

To create a session configuration for sessions in which the commands visible
to the user are specified in a role capabilities file, type:

```powershell
New-PSSessionConfigurationFile -RoleDefinitions
@{ 'CONTOSO\User' = @{ RoleCapabilities = 'Maintenance' }}
-Path .\Maintenance.pssc
```

### Using a Session Configuration File

You can include a session configuration file when you create a session
configuration or add you can add a file to the session configuration at a
later time.

To include a session configuration file when creating a session configuration,
use the Path parameter of the Register-PSSessionConfiguration cmdlet.

For example, the following command uses the NoLanguage.pssc file when it
creates a NoLanguage session configuration.

```powershell
Register-PSSessionConfiguration -Name NoLanguage
-Path .\NoLanguage.pssc
```

When a new NoLanguage session starts, users will only have access to Windows
PowerShell commands.

To add a session configuration file to an existing session configuration, use
the Set-PSSessionConfiguration cmdlet and the Path parameter. This affects any
new sessions created with the specified session configuration. Note that the
Set-PSSessionConfiguration cmdlet changes the session itself and does not
modify the session configuration file.

For example, the following command adds the NoLanguage.pssc file to the
LockedDown session configuration.

```powershell
Set-PSSessionConfiguration -Name LockedDown
-Path .\NoLanguage.pssc
```

When users use the LockedDown session configuration to create a session, they
will be able to run cmdlets but they will not be able to create or use
variables, assign values, or use other Windows PowerShell language elements.

The following command uses the New-PSSession cmdlet to create a session on the
computer Srv01 that uses the LockedDown session configuration, saving an
object reference to the session in the $s variable. The ACL (access control
list) of the session configuration determines who can use it to create a
session.

```powershell
$s = New-PSSession -ComputerName Srv01
-ConfigurationName LockedDown
```

Because the NoLanguage constraints were added to the LockedDown session
configuration, users in LockedDown sessions will only be able to run Windows
PowerShell commands and cmdlets. For example, the following two commands use
the Invoke-Command cmdlet to run commands in the session referenced in the $s
variable. The first command, which runs the Get-UICulture cmdlet and does not
use any variables, succeeds. The second command, which gets the value of the
$PSUICulture variable, fails.

```
Invoke-Command -Session $s {Get-UICulture}
en-US

Invoke-Command -Session $s {$PSUICulture}
The syntax is not supported by this runspace. This might be
because it is in no-language mode.
+ CategoryInfo          : ParserError: ($PSUICulture:String) [],
ParseException
+ FullyQualifiedErrorId : ScriptsNotAllowed
```

## Editing a Session Configuration File

All settings in a session configuration except for RunAsVirtualAccount and
RunAsVirtualAccountGroups can be modified by editing the session configuration
file used by the session configuration. To do this, begin by locating the
active copy of the session configuration file.

When you use a session configuration file in a session configuration, Windows
PowerShell creates an active copy of the session configuration file and stores
it in the \$pshome\\SessionConfig directory on the local computer.

The location of the active copy of a session configuration file is stored in
the ConfigFilePath property of the session configuration object.

The following command gets the location of the session configuration file for
the NoLanguage session configuration.

```powershell
(Get-PSSessionConfiguration -Name NoLanguage).ConfigFilePath
```

That command returns a file path similar to the following:

```
C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\
NoLanguage_0c115179-ff2a-4f66-a5eb-e56e5692ba22.pssc
```

You can edit the .pssc file in any text editor. After the file is saved it
will be employed by any new sessions that use the session configuration.

If you need to modify the RunAsVirtualAccount or the RunAsVirtualAccountGroups
settings, you must un-register the session configuration and re-register a
session configuration file that includes the edited values.

## Testing a Session Configuration File

Use the Test-PSSessionConfigurationFile cmdlet to test manually edited session
configuration files. That's important: if the file syntax and values are not
valid users will not be able to use the session configuration to create a
session.

For example, the following command tests the active session configuration file
of the NoLanguage session configuration.

```powershell
Test-PSSessionConfigurationFile -Path C:\WINDOWS\System32\
WindowsPowerShell\v1.0\SessionConfig\
NoLanguage_0c115179-ff2a-4f66-a5eb-e56e5692ba22.pssc
```

If the syntax and values in the configuration file are valid
Test-PSSessionConfigurationFile returns True. If the syntax and values are not
valid then the cmdlet returns False.

You can use Test-PSSessionConfigurationFile to test any session configuration
file, including files that the New-PSSessionConfiguration cmdlet creates. For
more information, see the help topic for the Test-PSSessionConfigurationFile
cmdlet.

## Removing a Session Configuration File

You cannot remove a session configuration file from a session configuration.
However, you can replace the file with a new file that uses the default
settings. This effectively cancels the settings used by the original
configuration file.

To replace a session configuration file, create a new session configuration
file that uses the default settings, then use the Set-PSSessionConfiguration
cmdlet to replace the custom session configuration file with the new file.

For example, the following commands create a Default session configuration
file and then replace the active session configuration file in the NoLanguage
session configuration.

```powershell
New-PSSessionConfigurationFile -Path .\Default.pssc
Set-PSSessionConfiguration -Name NoLanguage
-Path .\Default.pssc
```

When these commands finish, the NoLanguage session configuration will actually
provide full language support (the default setting) for all sessions created
with that session configuration.

Viewing the Properties of a Session Configuration The session configuration
objects that represent session configurations using session configuration
files have additional properties that make it easy to discover and analyze the
session configuration. (Note that the type name shown below includes a
formatted view definition.) You can view the properties by running the
Get-PSSessionConfiguration cmdlet and piping the returned data to the
Get-Member cmdlet:

```powershell
Get-PSSessionConfiguration NoLanguage | Get-Member
```

```output
TypeName: Microsoft.PowerShell.Commands.PSSessionConfigurationCommands
#PSSessionConfiguration

Name                          MemberType     Definition
----                          ----------     ----------
Equals                        Method         bool Equals(System.O...
GetHashCode                   Method         int GetHashCode()
GetType                       Method         type GetType()
ToString                      Method         string ToString()
Architecture                  NoteProperty   System.String Archit...
Author                        NoteProperty   System.String Author...
AutoRestart                   NoteProperty   System.String AutoRe...
Capability                    NoteProperty   System.Object[] Capa...
CompanyName                   NoteProperty   System.String Compan...
configfilepath                NoteProperty   System.String config...
Copyright                     NoteProperty   System.String Copyri...
Enabled                       NoteProperty   System.String Enable...
ExactMatch                    NoteProperty   System.String ExactM...
ExecutionPolicy               NoteProperty   System.String Execut...
Filename                      NoteProperty   System.String Filena...
GUID                          NoteProperty   System.String GUID=0...
ProcessIdleTimeoutSec         NoteProperty   System.String Proces...
IdleTimeoutms                 NoteProperty   System.String IdleTi...
lang                          NoteProperty   System.String lang=e...
LanguageMode                  NoteProperty   System.String Langua...
MaxConcurrentCommandsPerShell NoteProperty   System.String MaxCon...
MaxConcurrentUsers            NoteProperty   System.String MaxCon...
MaxIdleTimeoutms              NoteProperty   System.String MaxIdl...
MaxMemoryPerShellMB           NoteProperty   System.String MaxMem...
MaxProcessesPerShell          NoteProperty   System.String MaxPro...
MaxShells                     NoteProperty   System.String MaxShells
MaxShellsPerUser              NoteProperty   System.String MaxShe...
Name                          NoteProperty   System.String Name=N...
PSVersion                     NoteProperty   System.String PSVersion
ResourceUri                   NoteProperty   System.String Resour...
RunAsPassword                 NoteProperty   System.String RunAsP...
RunAsUser                     NoteProperty   System.String RunAsUser
SchemaVersion                 NoteProperty   System.String Schema...
SDKVersion                    NoteProperty   System.String SDKVer...
OutputBufferingMode           NoteProperty   System.String Output...
SessionType                   NoteProperty   System.String Sessio...
UseSharedProcess              NoteProperty   System.String UseSha...
SupportsOptions               NoteProperty   System.String Suppor...
xmlns                         NoteProperty   System.String xmlns=...
XmlRenderingType              NoteProperty   System.String XmlRen...
Permission                    ScriptProperty System.Object Permis...
```

These properties make it easy to search for specific session configurations.
For example, you can use the ExecutionPolicy property to find a session
configuration that supports sessions with the RemoteSigned execution policy.
Note that, because the ExecutionPolicy property exists only on sessions that
use session configuration files, the command might not return all qualifying
session configurations.

```powershell
Get-PSSessionConfiguration |
where {$_.ExecutionPolicy -eq "RemoteSigned"}
```

The following command gets session configurations in which the RunAsUser is
the Exchange administrator.

```powershell
 Get-PSSessionConfiguration |
where {$_.RunAsUser -eq "Exchange01\Admin01"}
```

To view information about the role definitions associated with a configuration
use the Get-PSSessionCapability cmdlet. This cmdlet enables you to determine
the commands and environment available to specific users in specific
endpoints.

## NOTES

Session configurations also support a type of session known as an "empty"
session. An Empty session type enables you to create custom sessions with
selected commands. If you do not add modules, functions, or scripts to an
empty session, the session is limited to expressions and might not be of any
practical use. The SessionType property tells you whether or not you are
working with an empty session.

## SEE ALSO

[about_Session_Configurations](about_Session_Configurations.md)

[New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)

[Disable-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Disable-PSSessionConfiguration)

[Enable-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Enable-PSSessionConfiguration)

[Get-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Get-PSSessionConfiguration)

[New-PSSessionConfigurationFile](xref:Microsoft.PowerShell.Core.New-PSSessionConfigurationFile)

[Register-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Register-PSSessionConfiguration)

[Set-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Set-PSSessionConfiguration)

[Test-PSSessionConfigurationFile](xref:Microsoft.PowerShell.Core.Test-PSSessionConfigurationFile)

[Unregister-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Unregister-PSSessionConfiguration)

[Get-PSSessionCapability](xref:Microsoft.PowerShell.Core.Get-PSSessionCapability)

[New-PSRoleCapabilityFile](xref:Microsoft.PowerShell.Core.New-PSRoleCapabilityFile)
