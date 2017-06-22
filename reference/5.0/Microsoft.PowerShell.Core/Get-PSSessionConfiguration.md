---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821490
external help file:  System.Management.Automation.dll-Help.xml
title:  Get-PSSessionConfiguration
---

# Get-PSSessionConfiguration

## SYNOPSIS
Gets the registered session configurations on the computer.

## SYNTAX

```
Get-PSSessionConfiguration [[-Name] <String[]>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
The **Get-PSSessionConfiguration** cmdlet gets the session configurations that have been registered on the local computer.
This is an advanced cmdlet is designed for system administrators to manage customized session configurations your users.

Starting in Windows PowerShell 3.0, you can define the properties of a session configuration by using a session configuration (.pssc) file.
This feature lets you create customized and restricted sessions without writing a computer program.
For more information about session configuration files, see about_Session_Configuration_Files (http://go.microsoft.com/fwlink/?LinkID=236023).

Starting in Windows PowerShell 3.0, new note properties have been added to the session configuration object that **Get-PSSessionConfiguration** returns.
These properties make it easier for users and session configuration authors to examine and compare session configurations.

To create and register a session configuration, use the Register-PSSessionConfiguration cmdlet.
For more information about session configurations, see about_Session_Configurations (http://go.microsoft.com/fwlink/?LinkID=145152).

## EXAMPLES

### Example 1: Get session configurations for the local computer
```
PS C:\> Get-PSSessionConfiguration
```

This command gets the session configurations on the local computer.

### Example 2: Get default session configurations
```
PS C:\> Get-PSSessionConfiguration -Name Microsoft*
Name                      PSVersion  StartupScript        Permission
----                      ---------  -------------        ----------
microsoft.powershell      2.0                             BUILTIN\Administrators AccessAll...
microsoft.powershell32    2.0                             BUILTIN\Administrators AccessAll...
```

This command gets the two default session configurations that come with Windows PowerShell.
The command uses the *Name* parameter of **Get-PSSessionConfiguration** to get only the session configurations with names that begin with "Microsoft".

### Example 3: Display properties of a session configuration created from a file
```
PS C:\> Get-PSSessionConfiguration -Name Full | Format-List -Property *
Copyright                     : (c) 2011 User01. All rights reserved.
AliasDefinitions              : {System.Collections.Hashtable}
SessionType                   : Default
CompanyName                   : Unknown
GUID                          : 1e9cb265-dae0-4bd3-89a9-8338a47698a1
Author                        : User01
ExecutionPolicy               : Restricted
SchemaVersion                 : 1.0.0.0
LanguageMode                  : FullLanguage
Architecture                  : 64
Filename                      : %windir%\system32\pwrshplugin.dll
ResourceUri                   : http://schemas.microsoft.com/powershell/Full
MaxConcurrentCommandsPerShell : 1500
UseSharedProcess              : false
ProcessIdleTimeoutSec         : 0
xmlns                         : http://schemas.microsoft.com/wbem/wsman/1/config/PluginConfiguration
MaxConcurrentUsers            : 10
lang                          : en-US
SupportsOptions               : true
ExactMatch                    : true
configfilepath                : C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\Full_1e9cb265-dae0-4bd3-89a9-8338a47698a1.pssc
RunAsUser                     :
IdleTimeoutms                 : 7200000
PSVersion                     : 3.0
OutputBufferingMode           : Block
AutoRestart                   : false
MaxShells                     : 300
MaxMemoryPerShellMB           : 1024
MaxIdleTimeoutms              : 43200000
SDKVersion                    : 1
Name                          : Full
XmlRenderingType              : text
Capability                    : {Shell}
RunAsPassword                 :
MaxProcessesPerShell          : 25
Enabled                       : True
MaxShellsPerUser              : 30
Permission                    :
```

This example shows the properties and property values of a session configuration that was created by using a session configuration file.

The command uses the **Get-PSSessionConfiguration** command to get the Full session configuration.
A pipeline operator sends the Full session configuration to the Format-List cmdlet.
The *Property* parameter with a value of * (all) directs **Format-List** to display all of the properties and property values of the object in a list.

The output of this command has very useful information.
This includes the author of the session configuration, the session type, language mode, and execution policy of sessions that are created by using this session configuration, session quotas, and the full path of the session configuration file.

This view of a session configuration is used for sessions that include a session configuration file.
For more information about session configuration files, see about_Session_Configuration_Files (http://go.microsoft.com/fwlink/?LinkID=236023).

### Example 4: Get and sort properties of a session configuration
```
PS C:\> (Get-PSSessionConfiguration Microsoft.PowerShell.Workflow).PSObject.Properties | Select-Object Name,Value | Sort-Object Name

Name                                                                                                              Value
----                                                                                                              -----
ActivityProcessIdleTimeoutSec                                                                                        60
AllowedActivity                                                                                   {PSDefaultActivities}
Architecture                                                                                                         64
AssemblyName                                                ...licKeyToken=31bf3856ad364e35, processorArchitecture=MSIL
AutoRestart                                                                                                       false
Capability                                                                                                      {Shell}
Enabled                                                                                                            true
EnableValidation                                                                                                   true
ExactMatch                                                                                                        False
Filename                                                                              %windir%\system32\pwrshplugin.dll
IdleTimeoutms                                                                                                   7200000
lang                                                                                                              en-US
MaxActivityProcesses                                                                                                  5
MaxConcurrentCommandsPerShell                                                                                      1000
MaxConcurrentUsers                                                                                                    5
MaxConnectedSessions                                                                                                100
MaxDisconnectedSessions                                                                                            1000
MaxIdleTimeoutms                                                                                             2147483647
MaxMemoryPerShellMB                                                                                                1024
MaxPersistenceStoreSizeGB                                                                                            10
MaxProcessesPerShell                                                                                                 15
MaxRunningWorkflows                                                                                                  30
MaxSessionsPerRemoteNode                                                                                              5
MaxSessionsPerWorkflow                                                                                                5

MaxShells                                                                                                            25
MaxShellsPerUser                                                                                                     25
ModulesToImport                                             %windir%\system32\windowspowershell\v1.0\Modules\PSWorkflow
Name                                                                                      microsoft.powershell.workflow
OutOfProcessActivity                                                                                     {InlineScript}
OutputBufferingMode                                                                                               Block
ParentResourceUri                                           ...s.microsoft.com/powershell/microsoft.powershell.workflow
Permission                                                  ...ssAllowed, BUILTIN\Remote Management Users AccessAllowed
PersistencePath                                             ...s\juneb\AppData\Local\Microsoft\Windows\PowerShell\WF\PS
PersistWithEncryption                                                                                             False
ProcessIdleTimeoutSec                                                                                             28800
PSSessionConfigurationTypeName                              ...osoft.PowerShell.Workflow.PSWorkflowSessionConfiguration
PSVersion                                                                                                           3.0
RemoteNodeSessionIdleTimeoutSec                                                                                      60
ResourceUri                                                 ...s.microsoft.com/powershell/microsoft.powershell.workflow
RunAsPassword
RunAsUser
SDKVersion                                                                                                            2
SecurityDescriptorSddl                                      ...;GA;;;BA)(A;;GA;;;RM)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)
SessionConfigurationData                                    ...    </SessionConfigurationData>
SessionThrottleLimit                                                                                                100
SupportsOptions                                                                                                    true
Uri                                                         ...s.microsoft.com/powershell/microsoft.powershell.workflow
UseSharedProcess                                                                                                   true
WorkflowShutdownTimeoutMSec                                                                                         500
xmlns                                                       ...as.microsoft.com/wbem/wsman/1/config/PluginConfiguration
XmlRenderingType                                                                                                   text
```

This command gets the properties of the Microsoft.PowerShell.Worfklow session configuration and sorts them into alphabetical order for easy reading.
You can use this command format in a function to get this display for any session configuration.

This example was contributed by Shay Levy, a Windows PowerShell MVP from Sderot, Israel.

### Example 5: Examine the contents of the Plugin node
```
PS C:\> dir wsman:\localhost\plugin
Type            Keys                                Name
----            ----                                ----
Container       {Name=Event Forwarding Plugin}      Event Forwarding Plugin
Container       {Name=Full}                         Full
Container       {Name=microsoft.powershell}         microsoft.powershell
Container       {Name=microsoft.powershell.workf... microsoft.powershell.workflow
Container       {Name=microsoft.powershell32}       microsoft.powershell32
Container       {Name=microsoft.ServerManager}      microsoft.ServerManager
Container       {Name=WMI Provider}                 WMI Provider
```

This command uses the dir alias of the Get-ChildItem cmdlet in the WSMan: provider drive to examine the content of the **Plugin** node.
This is another way to view the session configurations on the computer.

The **PlugIn** node contains **ContainerElement** objects (Microsoft.WSMan.Management.WSManConfigContainerElement) that represent the registered Windows PowerShell session configurations, together with other plug-ins for WS-Management.

### Example 6: View session configuration on a remote computer
```
The first command uses the Connect-WSMan cmdlet to connect to the WinRM service on the Server01 remote computer.
PS C:\> Connect-WSMan -ComputerName Server01

The second command uses dir in the WSMan: drive to get the items in the Server01\Plugin path.The output shows the items in the **Plugin** directory on the Server01 computer. The items include the session configurations, which are a type of WSMan plug-in, together with other types of plug-ins on the computer.
PS C:\> dir WSMan:\Server01\Plugin
   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Plugin

Type            Keys                                Name
----            ----                                ----
Container       {Name=Empty}                        Empty
Container       {Name=Event Forwarding Plugin}      Event Forwarding Plugin
Container       {Name=Full}                         Full
Container       {Name=microsoft.powershell}         microsoft.powershell
Container       {Name=microsoft.powershell.workf... microsoft.powershell.workflow
Container       {Name=microsoft.powershell32}       microsoft.powershell32
Container       {Name=microsoft.ServerManager}      microsoft.ServerManager
Container       {Name=NoLanguage}                   NoLanguage
Container       {Name=RestrictedLang}               RestrictedLang
Container       {Name=RRS}                          RRS
Container       {Name=SEL Plugin}                   SEL Plugin
Container       {Name=WithProfile}                  WithProfile
Container       {Name=WMI Provider}                 WMI Provider

The third command returns the names of the plugins that are session configurations. The command searches for a value of Shell in the **Capability** property, which is in the Plugin\Resources\<ResourceNumber> path in the WSMan: drive.
PS C:\> dir WSMan:\Server01\Plugin\*\Resources\Resource*\Capability | where {$_.Value -eq "Shell"} | foreach {($_.PSPath.split("\"))[3] }
Empty
Full
microsoft.powershell
microsoft.powershell.workflow
microsoft.powershell32
microsoft.ServerManager
NoLanguage
RestrictedLang
RRS
WithProfile
```

This example shows how to use the WSMan provider to view the session configurations on a remote computer.
This method does not provide as much information as a **Get-PSSessionConfiguration** command, but the user does not have to be a member of the Administrators group to run this command.

### Example 7: Run this cmdlet on a remote computer
```
The first command uses the Enable-WSManCredSSP cmdlet to enable **CredSSP** delegation from the Server01 local computer to the Server02 remote computer. This configures the **CredSSP** client setting on the local computer.
PS C:\> Enable-WSManCredSSP -Delegate Server02

The second command uses the **Connect-WSMan** cmdlet to connect to the Server02 computer. This action adds a node for the Server02 computer to the WSMan: drive on the local computer. This lets you view and change the WS-Management settings on the Server02 computer.
PS C:\> Connect-WSMan Server02

The third command uses the Set-Item cmdlet to change the value of the **CredSSP** item in the Service node of the Server02 computer to True. This configures the service settings on the remote computer.
PS C:\> Set-Item WSMan:\Server02*\Service\Auth\CredSSP -Value $true

The fourth command uses the Invoke-Command cmdlet to run a **Get-PSSessionConfiguration** command on the Server02 computer. The command uses the *Credential* parameter, and it uses the *Authentication* parameter with a value of CredSSP.The output shows the session configurations on the Server02 remote computer.
PS C:\> Invoke-Command -ScriptBlock {Get-PSSessionConfiguration} -ComputerName Server02 -Authentication CredSSP -Credential Domain01\Admin01
Name                      PSVersion  StartupScript        Permission                          PSComputerName
----                      ---------  -------------        ----------                          --------------
microsoft.powershell      2.0                             BUILTIN\Administrators AccessAll... server02.corp.fabrikam.com
microsoft.powershell32    2.0                             BUILTIN\Administrators AccessAll... server02.corp.fabrikam.com
MyX86Shell                2.0        c:\test\x86Shell.ps1 BUILTIN\Administrators AccessAll... server02.corp.fabrikam.com
```

This example shows how to run a **Get-PSSessionConfiguration** command on a remote computer.
The command requires that CredSSP delegation be enabled in the client settings on the local computer and in the service settings on the remote computer.

To run the commands in this example, you must be a member of the Administrators group on the local computer and the remote computer and you must start Windows PowerShell by using the Run as administrator option.

### Example 8: Get the resource URI of a session configuration
```
PS C:\> (Get-PSSessionConfiguration -Name CustomShell).resourceURI
http://schemas.microsoft.com/powershell/microsoft.CustomShell
```

This command uses the **Get-PSSessionConfiguration** cmdlet to get the resource Uniform Resource Identifier (URI) of a session configuration.

This command is useful when you set the value of the $PSSessionConfigurationName preference variable, which takes a resource URI.

The $PSSessionConfiguationName variable specifies the default configuration that is used when you create a session.
This variable is set on the local computer, but it specifies a configuration on the remote computer.
For more information about the $PSSessionConfiguration variable, see about_Preference_Variables (http://go.microsoft.com/fwlink/?LinkID=113248).

## PARAMETERS

### -Force
Suppresses the prompt to restart the WinRM service, if the service is not already running.

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

### -Name
Specifies an array of names.
This cmdlet gets the session configurations with the specified name or name pattern.
Enter one or more session configuration names.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration

## NOTES
* To run this cmdlet, start Windows PowerShell by using the Run as administrator option.
* To view the session configurations on the computer, you must be a member of the Administrators group on the computer.
* To run a **Get-PSSessionConfiguration** command on a remote computer, Credential Security Service Provider (CredSSP) authentication must be enabled in the client settings on the local computer by using the Enable-WSManCredSSP cmdlet, and in the service settings on the remote computer. You must also use the **CredSSP** value of the *Authentication* parameter when establishing the remote session. Otherwise, access is denied.
* The note properties of the object that **Get-PSSessionConfiguration** returns appear on the object only when they have a value. Only session configurations that were created by using a session configuration file have all of the defined properties.
* The properties of a session configuration object vary with the options set for the session configuration and the values of those options. Also, session configurations that use a session configuration file have additional properties.
* You can use commands in the WSMan: drive to change the properties of session configurations. However, you cannot use the WSMan: drive in Windows PowerShell 2.0 to change session configuration properties that are introduced in Windows PowerShell 3.0, such as **OutputBufferingMode**. Windows PowerShell 2.0 commands do not generate an error, but they are ineffective. To change  properties introduced in Windows PowerShell 3.0, use the WSMan: drive in Windows PowerShell 3.0.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[New-PSSessionConfigurationFile](New-PSSessionConfigurationFile.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Test-PSSessionConfigurationFile](Test-PSSessionConfigurationFile.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../Microsoft.WsMan.Management/Providers/WSMan-Provider.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

[about_Session_Configuration_Files](About/about_Session_Configuration_Files.md)

