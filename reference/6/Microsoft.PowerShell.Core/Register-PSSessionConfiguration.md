---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821508
external help file:  System.Management.Automation.dll-Help.xml
title:  Register-PSSessionConfiguration
---

# Register-PSSessionConfiguration

## SYNOPSIS
Creates and registers a new session configuration.

## SYNTAX

### NameParameterSet (Default)
```
Register-PSSessionConfiguration [-ProcessorArchitecture <String>] [-SessionType <PSSessionType>]
 [-Name] <String> [-ApplicationBase <String>] [-RunAsCredential <PSCredential>]
 [-ThreadApartmentState <ApartmentState>] [-ThreadOptions <PSThreadOptions>]
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
The **Register-PSSessionConfiguration** cmdlet creates and registers a new session configuration on the local computer.
This is an advanced cmdlet that you can use to create custom sessions for remote users.

Every PowerShell session (**PSSession**) uses a session configuration, also known as an endpoint.
When users create a session that connects to the computer, they can select a session configuration or use the default session configuration that is registered when you enable PowerShell remoting.
Users can also set the $PSSessionConfigurationName preference variable, which specifies a default configuration for remote sessions created in the current session.

The session configuration defines the environment for the remote session.
The configuration can determine which commands and language elements are available in the session, and it can include settings that protect the computer, such as those that limit the amount of data that the session can receive remotely in a single object or command.
The security descriptor of the session configuration determines which users have permission to use the session configuration.

You can define the elements of configuration by using an assembly that implements a new configuration class and by using a script that runs in the session.
Beginning in Windows PowerShell 3.0, you can also use a session configuration file to define the session configuration.

For information about session configurations, see about_Session_Configurations (http://go.microsoft.com/fwlink/?LinkID=145152).
For information about session configuration files, see about_Session_Configuration_Files (http://go.microsoft.com/fwlink/?LinkID=236023).

## EXAMPLES

### Example 1: Register a NewShell session configuration
```
PS C:\> Register-PSSessionConfiguration -Name NewShell -ApplicationBase c:\MyShells\ -AssemblyName MyShell.dll -ConfigurationTypeName MyClass
```

This command registers the NewShell session configuration.
It uses the *AssemblyName* and *ApplicationBase* parameters to specify the location of the MyShell.dll file, which specifies the cmdlets and providers in the session configuration.
It also uses the *ConfigurationTypeName* parameter to specify a new class that additionally configures the session.

To use this configuration, type `New-PSSession -ConfigurationName newshell`.

### Example 2: Register a MaintenanceShell session configuration
```
PS C:\> Register-PSSessionConfiguration -Name MaintenanceShell -StartupScript C:\ps-test\Maintenance.ps1
```

This command registers the MaintenanceShell session configuration on the local computer.
The command uses the *StartupScript* parameter to specify the Maintenance.ps1 script.

When a user uses a New-PSSession command and selects the MaintenanceShell configuration, the Maintenance.ps1 script runs in the new session.
The script can configure the session.
This includes importing modules, adding Windows PowerShell snap-ins, and setting the execution policy for the session.
If the script generates any errors, including non-terminating errors, the **New-PSSession** command fails.

### Example 3: Register an AdminShell session configuration
```
PS C:\> $sddl = "O:NSG:BAD:P(A;;GA;;;BA)S:P(AU;FA;GA;;;WD)(AU;FA;SA;GWGX;;WD)"
PS C:\> Register-PSSessionConfiguration -Name AdminShell -SecurityDescriptorSDDL $sddl -MaximumReceivedObjectSizeMB 20 -StartupScript C:\scripts\AdminShell.ps1
```

This example registers the AdminShell session configuration.

The first command saves a custom SDDL in the $sddl variable.

The second command registers the new shell.
The command uses the *SecurityDescritorSDDL* parameter to specify the SDDL in the value of the $sddl variable and the *MaximumReceivedObjectSizeMB* parameter to increase the object size limit.
It also uses the *StartupScript* parameter to specify a script that configures the session.

As an alternative to using the *SecurityDescriptorSDDL* parameter, you can use the *ShowSecurityDescriptorUI* parameter, which displays a property sheet that you can use to set permissions for the session configuration.
When you click OK in the property sheet, the tool generates an SDDL for the session configuration.

### Example 4: Return a configuration container element
```
The first command uses the **Register-PSSessionConfiguration** cmdlet to register the MaintenanceShell configuration. It saves the object that the cmdlet returns in the $s variable.
PS C:\> $s = Register-PSSessionConfiguration -Name MaintenanceShell -StartupScript C:\ps-test\Maintenance.ps1

The second command displays the contents of the $s variable.
PS C:\> $s

WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Plugin
Name                      Type                 Keys
----                      ----                 ----
MaintenanceShell          Container            {Name=MaintenanceShell}


The third command uses the **GetType** method and its **FullName** property to display the type name of the object that **Register-PSSessionConfiguration** returns.
PS C:\> $s.GetType().FullName
TypeName: Microsoft.WSMan.Management.WSManConfigContainerElement

The fourth command uses the Format-List cmdlet to display all the properties of the object that **Register-PSSessionConfiguration** returns in a list. The **PSPath** property shows that the object is stored in a directory of the WSMan: drive.
PS C:\> $s | Format-List -Property *
PSPath            : Microsoft.WSMan.Management\WSMan::localhost\Plugin\MaintenanceShell
PSParentPath      : Microsoft.WSMan.Management\WSMan::localhost\Plugin
PSChildName       : MaintenanceShell
PSDrive           : WSMan
PSProvider        : Microsoft.WSMan.Management\WSMan
PSIsContainer     : True
Keys              : {Name=MaintenanceShell}
Name              : MaintenanceShell
TypeNameOfElement : Container

The fifth command uses the Get-ChildItem cmdlet to display the items in the WSMan:\LocalHost\PlugIn path. These include the new MaintenanceShell configuration and the two default configurations that come with PowerShell.
PS C:\> dir WSMan:\LocalHost\Plugin
Name                      Type                 Keys
----                      ----                 ----
MaintenanceShell          Container            {Name=MaintenanceShell}
microsoft.powershell      Container            {Name=microsoft.powershell}
microsoft.powershell32    Container            {Name=microsoft.powershell32}
```

This example shows that a **Register-PSSessionConfiguration** command returns a **WSManConfigContainerElement**.
It also shows how to find the container elements in the WSMan: drive.

### Example 5: Register a WithProfile session configuration on the local computer
```
PS C:\> Register-PSSessionConfiguration -Name WithProfile -StartupScript Add-Profile.ps1
# Add-Profile.ps1
. c:\users\admin01\documents\windowspowershell\profile.ps1
```

This command creates and registers the WithProfile session configuration on the local computer.
The command uses the *StartupScript* parameter to direct PowerShell to run the specified script in any session that uses the session configuration.

The content of the specified script, Add-Profile.ps1, is also displayed.
The script contains a single command that uses dot sourcing to run the user's **CurrentUserAllHosts** profile in the current scope of the session.

For more information about profiles, see about_Profiles.
For more information about dot sourcing, see about_Scopes.

### Example 6: Compare a no-language session to restricted-language session
```
The first pair of commands use the **New-PSSessionConfigurationFile** cmdlet to create two session configuration files. The first command creates a no-Language file. The second command creates a restricted-language file. Other than the value of the *LanguageMode* parameter, the session configuration files are equivalent.
PS C:\> New-PSSessionConfigurationFile -Path .\NoLanguage.pssc -LanguageMode NoLanguage
PS C:\> New-PSSessionConfigurationFile -Path .\RestrictedLanguage.pssc -LanguageMode Restricted

The second pair of commands use the configuration files to create session configurations on the local computer.
PS C:\> Register-PSSessionConfiguration -Path .\NoLanguage.pssc -Name NoLanguage -Force
PS C:\> Register-PSSessionConfiguration -Path .\RestrictedLanguage.pssc -Name RestrictedLanguage -Force

The third pair of command creates two sessions, each of which uses one of the session configurations that was created in the previous command pair.
PS C:\> $NoLanguage = New-PSSession -ComputerName Srv01 -ConfigurationName NoLanguage
PS C:\> $RestrictedLanguage = New-PSSession -ComputerName Srv01 -ConfigurationName RestrictedLanguage

The seventh command uses the Invoke-Command cmdlet to run an **If** statement in the no-Language session. The command fails, because the language elements in the command are not permitted in a no-language session.
PS C:\> Invoke-Command -Session $NoLanguage {if ((Get-Date) -lt "1January2014") {"Before"} else {"After"} }
The syntax is not supported by this runspace. This might be because it is in no-language mode.
    + CategoryInfo          : ParserError: (if ((Get-Date) ...") {"Before"}  :String) [], ParseException
    + FullyQualifiedErrorId : ScriptsNotAllowed
    + PSComputerName        : localhost


The eighth command uses the **Invoke-Command** cmdlet to run the same **If** statement in the restricted-language session. Because these language elements are permitted in the restricted-language session, the command succeeds.
PS C:\> Invoke-Command -Session $RestrictedLanguage {if ((Get-Date) -lt "1January2014") {"Before"} else {"After"} }
Before
```

The commands in this example compare a no-language session to a restricted-language session.
The example shows the effect of using the *LanguageMode* parameter of **New-PSSessionConfigurationFile** to limit the types of commands and statements that users can run in a session that uses a custom session configuration.

To run the commands in this example, start PowerShell by using the Run as administrator option.
This option is required to run the Register-PSSessionConfiguration cmdlet.

## PARAMETERS

### -AccessMode
Enables and disables the session configuration and determines whether it can be used for remote or local sessions on the computer.
The acceptable values for this parameter are:

- Disabled.
Disables the session configuration.
It cannot be used for remote or local access to the computer.
- Local.
Allows users of the local computer to use the session configuration to create a local loopback session on the same computer, but denies access to remote users.
- Remote.
Allows local and remote users to use the session configuration to create sessions and run commands on this computer.

The default value is Remote.

Other cmdlets can override the value of this parameter later.
For example, the Enable-PSRemoting cmdlet allows for remote access to all session configurations, the Enable-PSSessionConfiguration cmdlet enables session configurations, and the Disable-PSRemoting cmdlet prevents remote access to all session configurations.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: PSSessionConfigurationAccessMode
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
Specifies the path of the assembly file (*.dll) that is specified in the value of the *AssemblyName* parameter.
Use this parameter when the value of the *AssemblyName* parameter does not include a path.
The default is the current directory.

```yaml
Type: String
Parameter Sets: NameParameterSet, AssemblyNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssemblyName
Specifies the name of an assembly file (*.dll) in which the configuration type is defined.
You can specify the path of the .dll in this parameter or in the value of the *ApplicationBase* parameter.

This parameter is required when you specify the *ConfigurationTypeName* parameter.

```yaml
Type: String
Parameter Sets: AssemblyNameParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigurationTypeName
Specifies the fully qualified name of the Microsoft .NET Framework type that is used for this configuration.
The type that you specify must implement the **System.Management.Automation.Remoting.PSSessionConfiguration** class.

To specify the assembly file (.dll) that implements the configuration type, specify the *AssemblyName* and *ApplicationBase* parameters.

Creating a type lets you control more aspects of the session configuration, such as exposing or hiding certain parameters of cmdlets, or setting data size and object size limits that users cannot override.

If you omit this parameter, the **DefaultRemotePowerShellConfiguration** class is used for the session configuration.

```yaml
Type: String
Parameter Sets: AssemblyNameParameterSet
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Suppresses all user prompts and restarts the **WinRM** service without prompting.
Restarting the service makes the configuration change effective.

To prevent a restart and suppress the restart prompt, specify the *NoServiceRestart* parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumReceivedDataSizePerCommandMB
Specifies a limit for the amount of data that can be sent to this computer in any single remote command.
Enter the data size in megabytes (MB).
The default is 50 MB.

If a data size limit is defined in the configuration type that is specified in the *ConfigurationTypeName* parameter, the limit in the configuration type is used and the value of this parameter is ignored.

```yaml
Type: Double
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
Enter the data size in megabytes.
The default is 10 MB.

If an object size limit is defined in the configuration type that is specified in the *ConfigurationTypeName* parameter, the limit in the configuration type is used and the value of this parameter is ignored.

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModulesToImport
Specifies the modules and snap-ins that are automatically imported into sessions that use the session configuration.

By default, only the **Microsoft.PowerShell.Core** snap-in is imported into sessions.
Unless the cmdlets are excluded, you can use the Import-Module and Add-PSSnapin cmdlets to add modules and snap-ins to the session.

The modules specified in this parameter value are imported in additions to modules that are specified by the *SessionType* parameter and those listed in the *ModulesToImport* key in the session configuration file (New-PSSessionConfigurationFile).
However, settings in the session configuration file can hide the commands exported by modules or prevent users from using them.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: Object[]
Parameter Sets: NameParameterSet, AssemblyNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies a name for the session configuration.
This parameter is required.

```yaml
Type: String
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

By default, when you run a **Register-PSSessionConfiguration** command, you are prompted to restart the **WinRM** service to make the new session configuration effective.
Until the **WinRM** service is restarted, the new session configuration is not effective.

To restart the **WinRM** service without prompting, specify the *Force* parameter.
To restart the **WinRM** service manually, use the Restart-Service cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PSVersion
Specifies the version of PowerShell in sessions that use this session configuration.

The value of this parameter takes precedence over the value of the **PowerShellVersion** key in the session configuration file.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: Version
Parameter Sets: NameParameterSet, AssemblyNameParameterSet
Aliases: PowerShellVersion

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path and file name of a session configuration file (.pssc), such as one created by the New-PSSessionConfigurationFile cmdlet.
If you omit the path, the default is the current directory.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: SessionConfigurationFile
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProcessorArchitecture
Determines whether a 32-bit or 64-bit version of the PowerShell process is started in sessions that use this session configuration.
The acceptable values for this parameter are: x86 (32-bit) and AMD64 (64-bit).
The default value is determined by the processor architecture of the computer that hosts the session configuration.

You can use this parameter to create a 32-bit session on a 64-bit computer.
Attempts to create a 64-bit process on a 32-bit computer fail.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PA
Accepted values: x86, amd64

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunAsCredential
Specifies credentials for commands in the session.
By default, commands run with the permissions of the current user.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: PSCredential
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

This string determines the permissions that are required to use the new session configuration.
To use a session configuration in a session, users must have at least Execute(Invoke) permission for the configuration.

If the security descriptor is complex, consider using the *ShowSecurityDescriptorUI* parameter instead of this parameter.
You cannot use both parameters in the same command.

If you omit this parameter, the root SDDL for the **WinRM** service is used for this configuration.
To view or change the root SDDL, use the WSMan provider.
For example `Get-Item wsman:\localhost\service\rootSDDL`.
For more information about the WSMan provider, type `Get-Help wsman`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionType
Specifies the type of session that is created by using the session configuration.
The acceptable values for this parameter are:

- Empty.
No modules or snap-ins are added to session by default.
Use the parameters of this cmdlet to add modules, functions, scripts, and other features to the session.
- Default.
Adds the Microsoft.PowerShell.Core snap-in to the session.
This module includes the Import-Module and Add-PSSnapin cmdlets that users can use to import other modules and snap-ins unless you explicitly prohibit the use of the cmdlets.
- RestrictedRemoteServer.
Includes only the following cmdlets: Exit-PSSession, Get-Command, Get-FormatData, Get-Help, Measure-Object, Out-Default, and Select-Object.
Use a script or assembly, or the keys in the session configuration file, to add modules, functions, scripts, and other features to the session.

The default value is Default.

The value of this parameter takes precedence over the value of the **SessionType** key in the session configuration file.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: PSSessionType
Parameter Sets: NameParameterSet
Aliases:
Accepted values: DefaultRemoteShell, Workflow

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionTypeOption
Specifies type-specific options for the session configuration.
Enter a session type options object, such as the **PSWorkflowExecutionOption** object that the New-PSWorkflowExecutionOption cmdlet returns.

The options of sessions that use the session configuration are determined by the values of session options and the session configuration options.
Unless specified, options set in the session, such as by using the New-PSSessionOption cmdlet, take precedence over options set in the session configuration.
However, session option values cannot exceed maximum values set in the session configuration.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: PSSessionTypeOption
Parameter Sets: NameParameterSet, AssemblyNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowSecurityDescriptorUI
Indicates that this cmdlet displays a property sheet that helps you create the SDDL for the session configuration.
The property sheet appears after you enter the **Register-PSSessionConfiguration** command and then restart the **WinRM** service.

When setting the permissions for the configuration, remember that users must have at least Execute(Invoke) permission to use the session configuration in a session.

You cannot use the *SecurityDescriptorSDDL* parameter and this parameter in the same command.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartupScript
Specifies the fully qualified path of a PowerShell script.
The specified script runs in the new session that uses the session configuration.

You can use the script to additionally configure the session.
If the script generates an error, even a non-terminating error, the session is not created and the New-PSSession command fails.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThreadApartmentState
Specifies the apartment state of the threads in the session.
The acceptable values for this parameter are: STA, MTA, and Unknown.
The default value is Unknown.

```yaml
Type: ApartmentState
Parameter Sets: (All)
Aliases:
Accepted values: STA, MTA, Unknown

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThreadOptions
Specifies how threads are created and used when a command runs in the session.
The acceptable values for this parameter are:

- Default
- ReuseThread
- UseCurrentThread
- UseNewThread

The default value is UseCurrentThread.

For more information, see "PSThreadOptions Enumeration" in the Microsoft Developer Network (MSDN) library.

```yaml
Type: PSThreadOptions
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

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: PSTransportOption
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSharedProcess
Use only one process to host all sessions that are started by the same user and use the same session configuration.
By default, each session is hosted in its own process.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### Microsoft.WSMan.Management.WSManConfigContainerElement

## NOTES
* To run this cmdlet on Windows Vista, Windows Server 2008, and later versions of the Windows operating system, start PowerShell by using the Run as administrator option.
* This cmdlet generates XML that represents a Web Services for Management (WS-Management) plug-in configuration and sends the XML to WS-Management, which registers the plug-in on the local computer (`New-Item wsman:\localhost\plugin`).
* The properties of a session configuration object vary with the options set for the session configuration and the values of those options. Also, session configurations that use a session configuration file have additional properties.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[New-PSSessionConfigurationFile](New-PSSessionConfigurationFile.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Test-PSSessionConfigurationFile](Test-PSSessionConfigurationFile.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)