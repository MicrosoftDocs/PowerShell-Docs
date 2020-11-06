---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 03/26/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/set-pssessionconfiguration?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-PSSessionConfiguration
---
# Set-PSSessionConfiguration

## SYNOPSIS
Changes the properties of a registered session configuration.

## SYNTAX

### NameParameterSet (Default)

```
Set-PSSessionConfiguration [-Name] <String> [-ApplicationBase <String>] [-RunAsCredential <PSCredential>]
 [-ThreadOptions <PSThreadOptions>] [-AccessMode <PSSessionConfigurationAccessMode>] [-UseSharedProcess]
 [-StartupScript <String>] [-MaximumReceivedDataSizePerCommandMB <Double>]
 [-MaximumReceivedObjectSizeMB <Double>] [-SecurityDescriptorSddl <String>] [-ShowSecurityDescriptorUI]
 [-Force] [-NoServiceRestart] [-PSVersion <Version>] [-SessionTypeOption <PSSessionTypeOption>]
 [-TransportOption <PSTransportOption>] [-ModulesToImport <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### AssemblyNameParameterSet

```
Set-PSSessionConfiguration [-Name] <String> [-AssemblyName] <String> [-ApplicationBase <String>]
 [-ConfigurationTypeName] <String> [-RunAsCredential <PSCredential>] [-ThreadOptions <PSThreadOptions>]
 [-AccessMode <PSSessionConfigurationAccessMode>] [-UseSharedProcess] [-StartupScript <String>]
 [-MaximumReceivedDataSizePerCommandMB <Double>] [-MaximumReceivedObjectSizeMB <Double>]
 [-SecurityDescriptorSddl <String>] [-ShowSecurityDescriptorUI] [-Force] [-NoServiceRestart]
 [-PSVersion <Version>] [-SessionTypeOption <PSSessionTypeOption>] [-TransportOption <PSTransportOption>]
 [-ModulesToImport <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SessionConfigurationFile

```
Set-PSSessionConfiguration [-Name] <String> [-RunAsCredential <PSCredential>]
 [-ThreadOptions <PSThreadOptions>] [-AccessMode <PSSessionConfigurationAccessMode>] [-UseSharedProcess]
 [-StartupScript <String>] [-MaximumReceivedDataSizePerCommandMB <Double>]
 [-MaximumReceivedObjectSizeMB <Double>] [-SecurityDescriptorSddl <String>] [-ShowSecurityDescriptorUI]
 [-Force] [-NoServiceRestart] [-TransportOption <PSTransportOption>] -Path <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-PSSessionConfiguration` cmdlet changes the properties of the session configurations on the
local computer.

Use the **Name** parameter to identify the session configuration that you want to change. Use the
other parameters to specify new values for the properties of the session configuration. To delete a
property value from the configuration, and use the default value, enter an empty string ("") or a
value of `$Null` for the corresponding parameter.

Starting in PowerShell 3.0, you can use a session configuration file to define a session
configuration. This feature provides a simple and discoverable method for setting and changing the
properties of sessions that use the session configuration. To specify a session configuration file,
use the **Path** parameter of `Set-PSSessionConfiguration`. For information about session
configuration files, see [about_Session_Configuration_Files](About/about_Session_Configuration_Files.md).
For information about how to create and modify a session configuration file, see the
`New-PSSessionConfigurationFile` cmdlet.

Session configurations define the environment of remote sessions (**PSSessions**) that connect to
the local computer. Every **PSSession** uses a session configuration. The session configuration
determines the features of the **PSSession**, such as the modules that are available in the session,
the cmdlets that are permitted to run, the language mode, quotas, and timeouts. The security
descriptor of the session configuration determines who can use the session configuration to connect
to the local computer. For more information about session configurations, see [about_Session_Configurations](About/about_Session_Configurations.md).

To see the properties of a session configuration, use the `Get-PSSessionConfiguration` cmdlet or the
WSMan Provider. For more information about the WSMan Provider, type `Get-Help WSMan`.

## EXAMPLES

### Example 1: Create and change a session configuration

This example shows how to add and remove a startup script from a configuration.

The first command creates the **AdminShell** configuration. The second command adds the
`AdminConfig.ps1` script to the configuration. The change is effective when you restart **WinRM**.
The third command removes the `AdminConfig.ps1` script from the configuration.

```powershell
Register-PSSessionConfiguration -Name "AdminShell" -AssemblyName "C:\Shells\AdminShell.dll" -ConfigurationTypeName "AdminClass"
Set-PSSessionConfiguration -Name "AdminShell" -StartupScript "AdminConfig.ps1"
Set-PSSessionConfiguration -Name "AdminShell" -StartupScript $Null
```

### Example 2: Display results

This example increases the value of the **MaximumReceivedObjectSizeMB** property to 20. This command
also prompts you to restart the **WinRM** service. The change is not effective until the **WinRM**
service is restarted.

```powershell
Set-PSSessionConfiguration -Name "IncObj" -MaximumReceivedObjectSizeMB 20
```

```Output
WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Plugin\IncObj\InitializationParameters

ParamName                       ParamValue
---------                       ----------
psmaximumreceivedobjectsizemb   20

"Restart WinRM service"
WinRM service need to be restarted to make the changes effective. Do you want to run the command "restart-service winrm"?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): y
```

### Example 3: Display results in different ways

In this example, `Set-PSSessionConfiguration` changes the startup script in the **MaintenanceShell**
session configuration to `Maintenance.ps1`. The output shows the change and prompts you to restart
the **WinRM** service. The response is "y" (yes).

`Get-PSSessionConfiguration` gets the **MaintenanceShell** session configuration. The pipeline
operator (|) sends the results of the command to `Format-List`, which displays all the properties of
the configuration object in a list. Next, using the WSMan provider, we view the initialization
parameters for the **MaintenanceShell** configuration. `Get-ChildItem` (alias `dir`) gets the child
items in the **InitializationParameters** node for the **MaintenanceShell** plug-in. For more
information about the WSMan provider, type `Get-Help wsman`.

```powershell
Set-PSSessionConfiguration -Name "MaintenanceShell" -StartupScript "C:\ps-test\Maintenance.ps1"
```

```Output
WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Plugin\MaintenanceShell\InitializationParameters

ParamName            ParamValue
---------            ----------
startupscript        c:\ps-test\Mainte...

"Restart WinRM service"
WinRM service need to be restarted to make the changes effective. Do you want to run
the command "restart-service winrm"?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): y

```

```powershell
Get-PSSessionConfiguration MaintenanceShell | Format-List -Property *
```

```Output
xmlns            : http://schemas.microsoft.com/wbem/wsman/1/config/PluginConfiguration
Name             : MaintenanceShell
Filename         : %windir%\system32\pwrshplugin.dll
SDKVersion       : 1
XmlRenderingType : text
lang             : en-US
PSVersion        : 2.0
startupscript    : c:\ps-test\Maintenance.ps1
ResourceUri      : http://schemas.microsoft.com/powershell/MaintenanceShell
SupportsOptions  : true
ExactMatch       : true
Capability       : {Shell}
Permission       :
```

```powershell
dir WSMan:\localhost\Plugin\MaintenanceShell\InitializationParameters
```

```Output
ParamName     ParamValue
---------     ----------
PSVersion     2.0
startupscript c:\ps-test\Maintenance.ps1
```

## PARAMETERS

### -AccessMode

Enables and disables the session configuration and determines whether it can be used for remote or
local sessions on the computer. The acceptable values for this parameter are:

- Disabled. Disables the session configuration. It cannot be used for remote or local access to the
  computer. This value sets the **Enabled** property of the session configuration
  (`WSMan:\<ComputerName>\PlugIn\<SessionConfigurationName>\Enabled`) to **False**.
- Local. Adds a **Network_Deny_All** entry to security descriptor of the session configuration.
  Users of the local computer can use the session configuration to create a local loopback session
  on the same computer, but remote users are denied access.
- Remote. Removes **Deny_All** and **Network_Deny_All** entries from the security descriptors of the
  session configuration. Users of local and remote computers can use the session configuration to
  create sessions and run commands on this computer.

The default value is **Remote**.

Other cmdlets can override the value of this parameter later. For example, the `Enable-PSRemoting`
cmdlet enables all session configurations on the computer and permits remote access to them, and the
`Disable-PSRemoting` cmdlet permits only local access to all session configurations on the computer.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Management.Automation.Runspaces.PSSessionConfigurationAccessMode
Parameter Sets: (All)
Aliases:
Accepted values: Disabled, Local, Remote

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationBase

Specifies the path of the assembly file (\*.dll) that is specified in the value of the
**AssemblyName** parameter.

```yaml
Type: System.String
Parameter Sets: NameParameterSet, AssemblyNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssemblyName

Specifies the assembly name. This cmdlet creates a session configuration based on a class that is
defined in an assembly.

Enter the filename or full path of an assembly .dll file that defines a session configuration. If
you enter only the file name, you can enter the path in the value of the **ApplicationBase**
parameter.

```yaml
Type: System.String
Parameter Sets: AssemblyNameParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigurationTypeName

Specifies the type of the session configuration that is defined in the assembly in the
**AssemblyName** parameter. The type that you specify must implement the
**System.Management.Automation.Remoting.PSSessionConfiguration** class.

This parameter is required when you specify an assembly name.

```yaml
Type: System.String
Parameter Sets: AssemblyNameParameterSet
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Suppresses all user prompts, and restarts the **WinRM** service without prompting. Restarting the
service makes the configuration change effective.

To prevent a restart and suppress the restart prompt, use the **NoServiceRestart** parameter.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumReceivedDataSizePerCommandMB

Specifies the limit on the amount of data that can be sent to this computer in any single remote
command. Enter the data size in megabytes (MB). The default is 50 MB.

If a data size limit is defined in the configuration type that is specified in the
**ConfigurationTypeName** parameter, the limit in the configuration type is used. The value of this
parameter is ignored.

```yaml
Type: System.Nullable`1[System.Double]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumReceivedObjectSizeMB

Specifies the limits on the amount of data that can be sent to this computer in any single object.
Enter the data size in megabytes. The default is 10 MB.

If an object size limit is defined in the configuration type that is specified in the
**ConfigurationTypeName** parameter, the limit in the configuration type is used. The value of this
parameter is ignored.

```yaml
Type: System.Nullable`1[System.Double]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModulesToImport

Specifies the modules and snap-ins that are automatically imported into sessions that use the
session configuration. Enter the module and snap-in names.

By default, only the **Microsoft.PowerShell.Core** snap-in is imported into sessions, but unless the
cmdlets are excluded, you can use the `Import-Module` and Add-PSSnapin cmdlets to add modules and
snap-ins to the session.

The modules specified in this parameter value are imported in additions to modules specified in the
session configuration file (`New-PSSessionConfigurationFile`). However, settings in the session
configuration file can hide the commands exported by modules or prevent users from using them.

The modules specified in this parameter value replace the list of modules specified by using the
**ModulesToImport** parameter of the `Register-PSSessionConfiguration` cmdlet.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Object[]
Parameter Sets: NameParameterSet, AssemblyNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies the name of the session configuration that you want to change.

You cannot use this parameter to change the name of the session configuration.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoServiceRestart

Does not restart the **WinRM** service, and suppresses the prompt to restart the service.

By default, when you run `Set-PSSessionConfiguration`, you are prompted to restart the **WinRM**
service to make the new session configuration effective. Until the **WinRM** service is restarted,
the new session configuration is not effective.

To restart the **WinRM** service without prompting, use the **Force** parameter. To restart the
**WinRM** service manually, use the `Restart-Service` cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path of a session configuration file (.pssc), such as one created by the
`New-PSSessionConfigurationFile` cmdlet. If you omit the path, the default is the current directory.

For information about how to modify a session configuration file, see the help topic for the
`New-PSSessionConfigurationFile` cmdlet.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: SessionConfigurationFile
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PSVersion

Specifies the version of PowerShell in sessions that use this session configuration.

The value of this parameter takes precedence over the value of the **PowerShellVersion** key in the
session configuration file.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Version
Parameter Sets: NameParameterSet, AssemblyNameParameterSet
Aliases: PowerShellVersion

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunAsCredential

Specifies credentials for commands in the session. By default, commands run with the permissions of
the current user.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityDescriptorSddl

Specifies a different Security Descriptor Definition Language (SDDL) string for the configuration.

This string determines the permissions that are required to use the new session configuration. To
use a session configuration in a session, users must have at least Execute(Invoke) permission for
the configuration.

To use the default security descriptor for the configuration, enter an empty string ("") or a value
of `$Null`. The default is the root SDDL in the WSMan: drive.

If the security descriptor is complex, consider using the **ShowSecurityDescriptorUI** parameter
instead of this one. You cannot use both parameters in the same command.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionTypeOption

Specifies type-specific options for the session configuration. Enter a session type options object,
such as the **PSWorkflowExecutionOption** object that the `New-PSWorkflowExecutionOption` cmdlet
returns.

The options of sessions that use the session configuration are determined by the values of session
options and the session configuration options. Unless specified, options set in the session, such as
by using the `New-PSSessionOption` cmdlet, take precedence over options set in the session
configuration. However, session option values cannot exceed maximum values set in the session
configuration.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Management.Automation.PSSessionTypeOption
Parameter Sets: NameParameterSet, AssemblyNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowSecurityDescriptorUI

Indicates that this cmdlet a property sheet that helps you create a new SDDL for the session
configuration. The property sheet appears after you run the `Set-PSSessionConfiguration` command and
then restart the **WinRM** service.

When you set permissions to the configuration, remember that users must have at least
Execute(Invoke) permission to use the session configuration in a session.

You cannot use the **SecurityDescriptorSDDL** parameter and this parameter in the same command.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartupScript

Specifies the startup script for the configuration. Enter the fully qualified path of a PowerShell
script. The specified script runs in the new session that uses the session configuration.

To delete a startup script from a session configuration, enter an empty string ("") or a value of
`$Null`.

You can use a startup script to further configure the user session. If the script generates an
error, even a non-terminating error, the session is not created and the `New-PSSession` command
fails.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThreadOptions

Specifies the thread options setting in the configuration. This setting defines how threads are
created and used when a command is executed in the session. The acceptable values for this parameter
are:

- Default
- ReuseThread
- UseCurrentThread
- UseNewThread

The default value is **UseCurrentThread**.

For more information, see [PSThreadOptions Enumeration](/dotnet/api/system.management.automation.runspaces.psthreadoptions).

```yaml
Type: System.Management.Automation.Runspaces.PSThreadOptions
Parameter Sets: (All)
Aliases:
Accepted values: Default, UseNewThread, ReuseThread, UseCurrentThread

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TransportOption

Specifies the transport options for the session configuration. Enter a transport options object,
such as the **WSManConfigurationOption** object that the `New-PSTransportOption` cmdlet returns.

The options of sessions that use the session configuration are determined by the values of session
options and the session configuration options. Unless specified, options set in the session, such as
by using the `New-PSSessionOption` cmdlet, take precedence over options set in the session
configuration. However, session option values cannot exceed maximum values set in the session
configuration.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Management.Automation.PSTransportOption
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSharedProcess

Use only one process to host all sessions that are started by the same user and use the same session
configuration. By default, each session is hosted in its own process.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThreadApartmentState

Specifies the apartment state of the threading module to be used. Acceptable values are:

- Unknown
- MTA
- STA

```yaml
Type: System.Threading.ApartmentState
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### Microsoft.WSMan.Management.WSManConfigLeafElement

## NOTES

This cmdlet is only available on Windows platforms.

To run this cmdlet, start PowerShell by using the Run as administrator option.

The `Set-PSSessionConfiguration` cmdlet does not change the configuration name and the **WSMan**
provider does not support the `Rename-Item` cmdlet. To change the name of a session configuration,
use the `Unregister-PSSessionConfiguration` cmdlet to delete the configuration and then use the
`Register-PSSessionConfiguration` cmdlet to create and register a new session configuration.

You can use the `Set-PSSessionConfiguration` cmdlet to change the default Microsoft.PowerShell and
Microsoft.PowerShell32 session configurations. They are not protected. To revert to the original
version of a default session configuration, use the `Unregister-PSSessionConfiguration` cmdlet to
delete the default session configuration and then use the `Enable-PSRemoting` cmdlet to restore it.

The properties of a session configuration object vary with the options set for the session
configuration and the values of those options. Also, session configurations that use a session
configuration file have additional properties.

You can use commands in the WSMan: drive to change the properties of session configurations.
However, you cannot use the WSMan: drive in PowerShell 2.0 to change session configuration
properties that are introduced in PowerShell 3.0, such as **OutputBufferingMode**. Windows
PowerShell 2.0 commands do not generate an error, but they are ineffective. To change properties
introduced in PowerShell 3.0, use the WSMan: drive in PowerShell 3.0.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[New-PSSessionConfigurationFile](New-PSSessionConfigurationFile.md)

[New-PSSessionOption](New-PSSessionOption.md)

[New-PSTransportOption](New-PSTransportOption.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Test-PSSessionConfigurationFile](Test-PSSessionConfigurationFile.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../Microsoft.WsMan.Management/About/about_WSMan_Provider.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

[about_Session_Configuration_Files](About/about_Session_Configuration_Files.md)
