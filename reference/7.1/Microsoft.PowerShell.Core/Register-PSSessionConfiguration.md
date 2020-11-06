---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 03/28/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/register-pssessionconfiguration?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Register-PSSessionConfiguration
---
# Register-PSSessionConfiguration

## SYNOPSIS
Creates and registers a new session configuration.

## SYNTAX

### NameParameterSet (Default)

```
Register-PSSessionConfiguration [-ProcessorArchitecture <String>] [-Name] <String> [-ApplicationBase <String>]
 [-RunAsCredential <PSCredential>] [-ThreadApartmentState <ApartmentState>] [-ThreadOptions <PSThreadOptions>]
 [-AccessMode <PSSessionConfigurationAccessMode>] [-UseSharedProcess] [-StartupScript <String>]
 [-MaximumReceivedDataSizePerCommandMB <Double>] [-MaximumReceivedObjectSizeMB <Double>]
 [-SecurityDescriptorSddl <String>] [-ShowSecurityDescriptorUI] [-Force] [-NoServiceRestart]
 [-PSVersion <Version>] [-SessionTypeOption <PSSessionTypeOption>] [-TransportOption <PSTransportOption>]
 [-ModulesToImport <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### AssemblyNameParameterSet

```
Register-PSSessionConfiguration [-ProcessorArchitecture <String>] [-Name] <String> [-AssemblyName] <String>
 [-ApplicationBase <String>] [-ConfigurationTypeName] <String> [-RunAsCredential <PSCredential>]
 [-ThreadApartmentState <ApartmentState>] [-ThreadOptions <PSThreadOptions>]
 [-AccessMode <PSSessionConfigurationAccessMode>] [-UseSharedProcess] [-StartupScript <String>]
 [-MaximumReceivedDataSizePerCommandMB <Double>] [-MaximumReceivedObjectSizeMB <Double>]
 [-SecurityDescriptorSddl <String>] [-ShowSecurityDescriptorUI] [-Force] [-NoServiceRestart]
 [-PSVersion <Version>] [-SessionTypeOption <PSSessionTypeOption>] [-TransportOption <PSTransportOption>]
 [-ModulesToImport <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SessionConfigurationFile

```
Register-PSSessionConfiguration [-ProcessorArchitecture <String>] [-Name] <String>
 [-RunAsCredential <PSCredential>] [-ThreadApartmentState <ApartmentState>] [-ThreadOptions <PSThreadOptions>]
 [-AccessMode <PSSessionConfigurationAccessMode>] [-UseSharedProcess] [-StartupScript <String>]
 [-MaximumReceivedDataSizePerCommandMB <Double>] [-MaximumReceivedObjectSizeMB <Double>]
 [-SecurityDescriptorSddl <String>] [-ShowSecurityDescriptorUI] [-Force] [-NoServiceRestart]
 [-TransportOption <PSTransportOption>] -Path <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Register-PSSessionConfiguration` cmdlet creates and registers a new session configuration on
the local computer. This is an advanced cmdlet that you can use to create custom sessions for remote
users.

Every PowerShell session (**PSSession**) uses a session configuration, also known as an endpoint.
When users create a session that connects to the computer, they can select a session configuration
or use the default session configuration that is registered when you enable PowerShell remoting.
Users can also set the $PSSessionConfigurationName preference variable, which specifies a default
configuration for remote sessions created in the current session.

The session configuration defines the environment for the remote session. The configuration can
determine which commands and language elements are available in the session, and it can include
settings that protect the computer, such as those that limit the amount of data that the session can
receive remotely in a single object or command. The security descriptor of the session configuration
determines which users have permission to use the session configuration.

You can define the elements of configuration by using an assembly that implements a new
configuration class and by using a script that runs in the session. Beginning in PowerShell
3.0, you can also use a session configuration file to define the session configuration.

For information about session configurations, see [about_Session_Configurations](About/about_Session_Configurations.md).
For information about session configuration files, see [about_Session_Configuration_Files](About/about_Session_Configuration_Files.md).

## EXAMPLES

### Example 1: Register a NewShell session configuration

In this example, we register the **NewShell** session configuration. The **AssemblyName** and
**ApplicationBase** parameters specify the location of the **MyShell.dll** file, which specifies
the cmdlets and providers in the session configuration. The **ConfigurationTypeName**
parameter specifies the configuration class to use from the assembly.

```powershell
$sessionConfiguration = @{
    Name='NewShell'
    ApplicationBase='c:\MyShells\'
    AssemblyName='MyShell.dll'
    ConfigurationTypeName='MyClass'
}
Register-PSSessionConfiguration @sessionConfiguration
```

To use this configuration, type `New-PSSession -ConfigurationName newshell`.

### Example 2: Register a MaintenanceShell session configuration

This example registers the **MaintenanceShell** session configuration on the local computer. The
**StartupScript** parameter specifies the `Maintenance.ps1` script.

```powershell
Register-PSSessionConfiguration -Name MaintenanceShell -StartupScript C:\ps-test\Maintenance.ps1
```

When a user uses a `New-PSSession` command and selects the **MaintenanceShell** configuration, the
`Maintenance.ps1` script runs in the new session. The script can configure the session. This
includes importing modules and setting the execution policy for the session. If the script generates
any errors, including non-terminating errors, the `New-PSSession` command fails.

### Example 3: Register a session configuration

This example registers the **AdminShell** session configuration.

The `$sessionParams` variable is a hashtable containing all the parameter values. This hashtable is
passed to the cmdlet using PowerShell splatting. The `Register-PSSessionConfiguration` command uses
the **SecurityDescritorSDDL** parameter to specify the SDDL in the value of the `$sddl` variable and
the **MaximumReceivedObjectSizeMB** parameter to increase the object size limit. It also uses the
**StartupScript** parameter to specify a script that configures the session.

```powershell
$sddl = "O:NSG:BAD:P(A;;GA;;;BA)S:P(AU;FA;GA;;;WD)(AU;FA;SA;GWGX;;WD)"
$sessionParams = @{
    Name="AdminShell"
    SecurityDescriptorSDDL=$sddl
    MaximumReceivedObjectSizeMB=20
    StartupScript="C:\scripts\AdminShell.ps1"
}
Register-PSSessionConfiguration @sessionParams
```

### Example 4: Return a configuration container element

This example shows how to register the **MaintenanceShell** configuration.
`Register-PSSessionConfiguration` returns a **WSManConfigContainerElement** object stored in the
`$s` variable. `Format-List` displays all the properties of the returned object. The **PSPath**
property shows that the object is stored in a directory of the WSMan: drive. `Get-ChildItem` (alias
`dir`) displays the items in the `WSMan:\LocalHost\PlugIn` path. These include the new
**MaintenanceShell** configuration and the two default configurations that come with PowerShell.

```powershell
$s = Register-PSSessionConfiguration -Name MaintenanceShell -StartupScript C:\ps-test\Maintenance.ps1
$s | Format-List -Property *
dir WSMan:\LocalHost\Plugin
```

```Output
PSPath            : Microsoft.WSMan.Management\WSMan::localhost\Plugin\MaintenanceShell
PSParentPath      : Microsoft.WSMan.Management\WSMan::localhost\Plugin
PSChildName       : MaintenanceShell
PSDrive           : WSMan
PSProvider        : Microsoft.WSMan.Management\WSMan
PSIsContainer     : True
Keys              : {Name=MaintenanceShell}
Name              : MaintenanceShell
TypeNameOfElement : Container

Name                      Type                 Keys
----                      ----                 ----
MaintenanceShell          Container            {Name=MaintenanceShell}
microsoft.powershell      Container            {Name=microsoft.powershell}
microsoft.powershell32    Container            {Name=microsoft.powershell32}
```

### Example 5: Register a session configuration with a startup script

In this example we create and register the **WithProfile** session configuration. The
**StartupScript** parameter directs PowerShell to run the specified script for any session that uses
the session configuration.

```powershell
Register-PSSessionConfiguration -Name WithProfile -StartupScript Add-Profile.ps1
```

The script contains a single command that uses dot sourcing to run the user's
**CurrentUserAllHosts** profile in the current scope of the session.

For more information about profiles, see [about_Profiles](./About/about_Profiles.md). For more
information about dot sourcing, see [about_Scopes](./About/about_Scopes.md).

## PARAMETERS

### -AccessMode

Enables and disables the session configuration and determines whether it can be used for remote or
local sessions on the computer. The acceptable values for this parameter are:

- Disabled. Disables the session configuration. It cannot be used for remote or local access to the
  computer.
- Local. Allows users of the local computer to use the session configuration to create a local
  loopback session on the same computer, but denies access to remote users.
- Remote. Allows local and remote users to use the session configuration to create sessions and run
  commands on this computer.

The default value is Remote.

Other cmdlets can override the value of this parameter later. For example, the `Enable-PSRemoting`
cmdlet allows for remote access to all session configurations, the `Enable-PSSessionConfiguration`
cmdlet enables session configurations, and the `Disable-PSRemoting` cmdlet prevents remote access to
all session configurations.

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
**AssemblyName** parameter. Use this parameter when the value of the **AssemblyName** parameter does
not include a path. The default is the current directory.

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

Specifies the name of an assembly file (\*.dll) in which the configuration type is defined. You can
specify the path of the .dll in this parameter or in the value of the **ApplicationBase** parameter.

This parameter is required when you specify the **ConfigurationTypeName** parameter.

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

Specifies the fully qualified name of the Microsoft .NET Framework type that is used for this
configuration. The type that you specify must implement the
**System.Management.Automation.Remoting.PSSessionConfiguration** class.

To specify the assembly file (\*.dll) that implements the configuration type, specify the
**AssemblyName** and **ApplicationBase** parameters.

Creating a type lets you control more aspects of the session configuration, such as exposing or
hiding certain parameters of cmdlets, or setting data size and object size limits that users cannot
override.

If you omit this parameter, the **DefaultRemotePowerShellConfiguration** class is used for the
session configuration.

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

Suppresses all user prompts and restarts the **WinRM** service without prompting. Restarting the
service makes the configuration change effective.

To prevent a restart and suppress the restart prompt, specify the **NoServiceRestart** parameter.

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

Specifies a limit for the amount of data that can be sent to this computer in any single remote
command. Enter the data size in megabytes (MB). The default is 50 MB.

If a data size limit is defined in the configuration type that is specified in the
**ConfigurationTypeName** parameter, the limit in the configuration type is used and the value of
this parameter is ignored.

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

Specifies a limit for the amount of data that can be sent to this computer in any single object.
Enter the data size in megabytes. The default is 10 MB.

If an object size limit is defined in the configuration type that is specified in the
**ConfigurationTypeName** parameter, the limit in the configuration type is used and the value of
this parameter is ignored.

```yaml
Type: System.Nullable`1[System.Double]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModulesToImport

Specifies the modules that are automatically imported into sessions that use the session
configuration.

By default, only **Microsoft.PowerShell.Core** is imported into sessions. Unless the cmdlets are
excluded, you can use `Import-Module` to add modules to the session.

The modules specified in this parameter value are imported in additions to modules that are
specified by the **SessionType** parameter and those listed in the **ModulesToImport** key in the
session configuration file (`New-PSSessionConfigurationFile`). However, settings in the session
configuration file can hide the commands exported by modules or prevent users from using them.

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

Specifies a name for the session configuration. This parameter is required.

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

By default, when you run a `Register-PSSessionConfiguration` command, you are prompted to restart
the **WinRM** service to make the new session configuration effective. Until the **WinRM** service
is restarted, the new session configuration is not effective.

To restart the **WinRM** service without prompting, specify the **Force** parameter. To restart the
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

Specifies the path and filename of a session configuration file (.pssc), such as one created by
`New-PSSessionConfigurationFile`. If you omit the path, the default is the current directory.

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

### -ProcessorArchitecture

Determines whether a 32-bit or 64-bit version of the PowerShell process is started in sessions that
use this session configuration. The acceptable values for this parameter are: x86 (32-bit) and AMD64
(64-bit). The default value is determined by the processor architecture of the computer that hosts
the session configuration.

You can use this parameter to create a 32-bit session on a 64-bit computer. Attempts to create a
64-bit process on a 32-bit computer fail.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: PA
Accepted values: x86, amd64

Required: False
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

Specifies a Security Descriptor Definition Language (SDDL) string for the configuration.

This string determines the permissions that are required to use the new session configuration. To
use a session configuration in a session, users must have at least Execute (Invoke) permission for
the configuration.

If the security descriptor is complex, consider using the **ShowSecurityDescriptorUI** parameter
instead of this parameter. You cannot use both parameters in the same command.

If you omit this parameter, the root SDDL for the **WinRM** service is used for this configuration.
To view or change the root SDDL, use the WSMan provider. For example
`Get-Item wsman:\localhost\service\rootSDDL`. For more information about the WSMan provider, type
`Get-Help wsman`.

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

Indicates that this cmdlet displays a property sheet that helps you create the SDDL for the session
configuration. The property sheet appears after you enter the `Register-PSSessionConfiguration`
command and then restart the **WinRM** service.

When setting the permissions for the configuration, remember that users must have at least Execute
(Invoke) permission to use the session configuration in a session.

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

Specifies the fully qualified path of a PowerShell script. The specified script runs in the new
session that uses the session configuration.

You can use the script to additionally configure the session. If the script generates an error, even
a non-terminating error, the session is not created and the `New-PSSession` command fails.

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

Specifies how threads are created and used when a command runs in the session. The acceptable values
for this parameter are:

- Default
- ReuseThread
- UseCurrentThread
- UseNewThread

The default value is **UseCurrentThread**.

For more information, see [PSThreadOptions Enumeration](/dotnet/api/system.management.automation.runspaces.psthreadoptions?view=powershellsdk-1.1.0).

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

Specifies the transport option.

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

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### Microsoft.WSMan.Management.WSManConfigContainerElement

## NOTES

This cmdlet is only available on Windows platforms.

To run this cmdlet you must start PowerShell by using the **Run as administrator** option.

This cmdlet generates XML that represents a Web Services for Management (WS-Management) plug-in
configuration and sends the XML to WS-Management, which registers the plug-in on the local computer
(`New-Item wsman:\localhost\plugin`).

The properties of a session configuration object vary with the options set for the session
configuration and the values of those options. Also, session configurations that use a session
configuration file have additional properties.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[New-PSSessionConfigurationFile](New-PSSessionConfigurationFile.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Test-PSSessionConfigurationFile](Test-PSSessionConfigurationFile.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../Microsoft.WsMan.Management/About/about_WSMan_Provider.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

[about_Session_Configuration_Files](About/about_Session_Configuration_Files.md)
