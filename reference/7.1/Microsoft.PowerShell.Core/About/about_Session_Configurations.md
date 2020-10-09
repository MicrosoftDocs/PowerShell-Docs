---
description: Describes session configurations, which determine the users who can connect to the computer remotely and the commands they can run. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 12/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_session_configurations?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Session_Configurations
---
# About Session Configurations

## SHORT DESCRIPTION
Describes session configurations, which determine the users who can connect to
the computer remotely and the commands they can run.

## LONG DESCRIPTION

A session configuration, also known as an "endpoint" is a group of settings on
the local computer that define the environment for the PowerShell sessions that
are created when remote or local users connect to PowerShell on the local computer.

Administrators of the computer can use session configurations to protect the
computer and to define custom environments for users who connect to the
computer.

Administrators can also use session configurations to determine the
permissions that are required to connect to the computer remotely. By default,
only members of the Administrators group have permission to use the session
configuration to connect remotely, but you can change the default settings to
allow all users, or selected users, to connect remotely to your computer.

Beginning in PowerShell 3.0, you can use a session configuration file to
define the elements of a session configuration. This feature makes it easy to
customize sessions without writing code and to discover the properties of a
session configuration. To create a session configuration file, use the
New-PSSessionConfiguration cmdlet. For more information about session
configuration files, see
[about_Session_Configuration_Files](about_Session_Configuration_Files.md).

Session configurations are a feature of Web Services for Management
(WS-Management) based PowerShell remoting. They are used only when you use the
New-PSSession, Invoke-Command, or Enter-PSSession cmdlets to connect to a
remote computer.

Note: To manage the session configurations, start PowerShell with the
"Run as administrator" option.

About Session Configurations

Every PowerShell session uses a session configuration. This includes
persistent sessions that you create by using the New-PSSession or
Enter-PSSession cmdlets, and the temporary sessions that PowerShell creates
when you use the ComputerName parameter of a cmdlet that uses
WS-Management-based remoting technology, such as Invoke-Command.

Administrators can use session configurations to protect the resources of the
computer and to create custom environments for users who connect to the
computer. For example, you can use a session configuration to limit the size
of objects that the computer receives in the session, to define the language
mode of the session, and to specify the cmdlets, providers, and functions that
are available in the session.

By configuring the security descriptor of a session configuration, you
determine who can use the session configuration to connect to the computer.
Users must have Execute permission to a session configuration to use it in a
session. If a user does not have the required permissions to use any of the
session configurations on a computer, the user cannot connect to the computer
remotely.

By default, only Administrators of the computer have permission to use the
default session configurations. But, you can change the security descriptors
to allow everyone, no one, or only selected users to use the session
configurations on your computer.

Built-in Session Configurations

PowerShell 3.0 includes built-in session configurations named
Microsoft.PowerShell and Microsoft.PowerShell.Workflow. On computers running
64-bit versions of Windows, PowerShell also provides Microsoft.PowerShell32, a
32-bit session configuration.

The Microsoft.PowerShell session configuration is used for sessions by
default, that is, when a command to create a session does not include the
ConfigurationName parameter of the New-PSSession, Enter-PSSession, or
Invoke-Command cmdlet.

The security descriptors for the default session configurations allow only
members of the Administrators group on the local computer to use them. As
such, only members of the Administrators group can connect to the computer
remotely unless you change the default settings.

You can change the default session configurations by using the
$PSSessionConfigurationName preference variable. For more information, see
about_Preference_Variables.

Viewing Session Configurations on the Local Computer

To get the session configurations on your local computer, use the
Get-PSSessionConfiguration cmdlet.

For example, type:

```powershell
PS C:> Get-PSSessionConfiguration | Format-List -Property Name, Permission

Name       : microsoft.powershell
Permission : BUILTIN\Administrators AccessAllowed

Name       : microsoft.powershell.workflow
Permission : BUILTIN\Administrators AccessAllowed

Name       : microsoft.powershell32
Permission : BUILTIN\Administrators AccessAllowed
```

The session configuration object is expanded in PowerShell 3.0 to
display the properties of the session configuration that are configured by
using a session configuration file.

For example, to see all of the properties of a session configuration
object, type:

```powershell
PS C:> Get-PSSessionConfiguration | Format-List -Property *
```

You can also use the WSMan provider in PowerShell to view session
configurations. The WSMan provider creates a WSMAN: drive in your session.

In the WSMAN: drive, session configurations are in the Plugin node. (All
session configurations are in the Plugin node, but there are items in the
Plugin node that are not session configurations.)

For example, to view the session configurations on the local computer,
type:

```powershell
PS C:> dir wsman:\localhost\plugin\microsoft*

WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Plugin

Type       Keys                              Name
----       ----                              ----
Container  {Name=microsoft.powershell}       microsoft.powershell
Container  {Name=microsoft.powershell.wor... microsoft.powershell.workflow
Container  {Name=microsoft.powershell32}     microsoft.powershell32
```

Viewing Session Configurations on a Remote Computer

To view the session configurations on a remote computer, use the Connect-WSMan
cmdlet to add a note for the remote computer to the WSMAN: drive on your local
computer, and then use the WSMAN: drive to view the session configurations.

For example, the following command adds a node for the Server01 remote
computer to the WSMAN: drive on the local computer.

```powershell
PS C:> Connect-WSMan server01.corp.fabrikam.com
```

When the command is complete, you can navigate to the node for the Server01
computer to view the session configurations.

For example:

```powershell
PS C:> cd wsman:

PS WSMan:> dir

ComputerName                                  Type
------------                                  ----
localhost                                     Container
server01.corp.fabrikam.com                    Container

PS WSMan:> dir server01\plugin\

WSManConfig: Microsoft.WSMan.Management\WSMan::server01.corp.fabrikam.com\Pl
ugin

Type       Keys                              Name
----       ----                              ----
Container  {Name=microsoft.powershell}       microsoft.powershell
Container  {Name=microsoft.powershell.wor... microsoft.powershell.workflow
Container  {Name=microsoft.powershell32}     microsoft.powershell32
```

Changing the Security Descriptor of a Session Configuration

In Windows Server 2012 and newer releases of Windows Server, the built-in
session configurations are enabled for remote users by default. In other
supported versions of Windows, you must change the security descriptors of the
session configurations to allow remote access.

To enable remote access to the session configurations on the computer, use the
Enable-PSRemoting cmdlet. This cmdlet creates two session configurations:

- with the name defined as: "PowerShell." + "current PowerShell version"
- with name "PowerShell.6", untied to any specific PowerShell version.

Also, by default, only members of the Administrators group on the computer
have Execute permission to the default session configurations, but you can
change the security descriptors on the default session configurations and on
any session configurations that you create.

To give other users permission to connect to the computer remotely, use the
Set-PSSessionConfiguration cmdlet to add "Execute" permissions for those users
to the security descriptors of the Microsoft.PowerShell and
Microsoft.PowerShell32 session configurations.

For example, the following command opens a property page that lets you change
the security descriptor for the Microsoft.PowerShell default session
configuration.

```powershell
Set-PSSessionConfiguration -name Microsoft.PowerShell `
  -ShowSecurityDescriptorUI
```

To deny everyone permission to all the session configurations on the computer,
use the Disable-PSSessionConfiguration cmdlet. For example, the following
command disables the default session configurations on the computer.

```powershell
PS C:> Disable-PSSessionConfiguration -Name Microsoft.PowerShell
```

To prevent remote users from connecting to the computer, but allow local users
to connect, use the Disable-PSRemoting cmdlet. Disable-PSRemoting adds a
"Network_Deny_All" entry to all session configurations on the computer.

```powershell
PS C:> Disable-PSRemoting
```

To allow remote users to use all session configurations on the computer, use
the Enable-PSRemoting or Enable-PSSessionConfiguration cmdlet. For example,
the following command enables remote access to the built-in session
configurations.

```powershell
PS C:> Enable-PSSessionConfiguration -name Microsoft.Power*
```

To make other changes to the security descriptor of a session configuration,
use the Set-PSSessionConfiguration cmdlet. Use the SecurityDescriptorSDDL
parameter to submit an SDDL string value. Use the ShowSecurityDescriptorUI
parameter to display a user interface property sheet that helps you to create
a new SDDL.

For example:

```powershell
Set-PSSessionConfiguration -Name Microsoft.PowerShell `
  -ShowSecurityDescriptorUI
```

Creating a New Session Configuration

To create a new session configuration on the local computer, use the
Register-PSSessionConfiguration cmdlet. To define the new session
configuration, you can use a C# assembly, a PowerShell script, and the
parameters of the Register-PSSessionConfiguration cmdlet.

For example, the following command creates a session configuration that is
identical the Microsoft.PowerShell session configuration, except that it
limits the data received from a remote command to 20 megabytes (MB). (The
default is 50 MB).

```powershell
Register-PSSessionConfiguration -Name NewConfig `
  -MaximumReceivedDataSizePerCommandMB 20
```

When you create a session configuration, you can manage it by using the other
session configuration cmdlets, and it appears in the WSMAN: drive.

For more information, see Register-PSSessionConfiguration.

Removing a Session Configuration

To remove a session configuration from the local computer, use the
Unregister-PSSessionConfiguration cmdlet. For example, the following command
removes the NewConfig session configuration from the computer.

```powershell
PS C:> Unregister-PSSessionConfiguration -Name NewConfig
```

For more information, see Unregister-PSSessionConfiguration.

Restoring a Session Configuration

To restore a default session configuration that was deleted (unregistered)
accidentally, use the Enable-PSRemoting cmdlet.

The Enable-PSRemoting cmdlet recreates all default sessions configurations
that do not exist on the computer. It does not overwrite or change the
property values of existing session configurations.

To restore the original property values of a default session configuration,
use the Unregister-PSSessionConfiguration to delete the session configuration
and then use the Enable-PSRemoting cmdlet to recreate it.

Selecting a Session Configuration

To select a particular session configuration for a session, use the
ConfigurationName parameter of New-PSSession, Enter-PSSession, or
Invoke-Command.

For example, this command uses the New-PSSession cmdlet to start a PSSession
on the Server01 computer. The command uses the ConfigurationName parameter to
select the WithProfile configuration on the Server01 computer.

```powershell
PS C:> New-PSSession -ComputerName Server01 -ConfigurationName WithProfile
```

This command will succeed only if the current user has permission to use the
WithProfile session configuration or can supply the credentials of a user who
has the required permissions.

You can also use the $PSSessionConfigurationName preference variable to change
the default session configuration on the computer. For more information about
the $PSSessionConfigurationName preference variable, see
about_Preference_Variables.

## KEYWORDS

about_Endpoints
about_SessionConfigurations

## SEE ALSO

[about_Preference_Variables](about_Preference_Variables.md)

[about_PSSessions](about_PSSessions.md)

[about_Remote](about_Remote.md)

[about_Session_Configuration_Files](about_Session_Configuration_Files.md)

[New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)

[Disable-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Disable-PSSessionConfiguration)

[Enable-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Enable-PSSessionConfiguration)

[Get-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Get-PSSessionConfiguration)

[New-PSSessionConfigurationFile](xref:Microsoft.PowerShell.Core.New-PSSessionConfigurationFile)

[Register-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Register-PSSessionConfiguration)

[Set-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Set-PSSessionConfiguration)

[Test-PSSessionConfigurationFile](xref:Microsoft.PowerShell.Core.Test-PSSessionConfigurationFile)

[Unregister-PSSessionConfiguration](xref:Microsoft.PowerShell.Core.Unregister-PSSessionConfiguration)

