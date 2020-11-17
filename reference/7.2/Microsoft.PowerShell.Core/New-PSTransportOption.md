---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/new-pstransportoption?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-PSTransportOption
---
# New-PSTransportOption

## SYNOPSIS
Creates an object that contains advanced options for a session configuration.

## SYNTAX

```
New-PSTransportOption [-MaxIdleTimeoutSec <Int32>] [-ProcessIdleTimeoutSec <Int32>] [-MaxSessions <Int32>]
 [-MaxConcurrentCommandsPerSession <Int32>] [-MaxSessionsPerUser <Int32>] [-MaxMemoryPerSessionMB <Int32>]
 [-MaxProcessesPerSession <Int32>] [-MaxConcurrentUsers <Int32>] [-IdleTimeoutSec <Int32>]
 [-OutputBufferingMode <OutputBufferingMode>] [<CommonParameters>]
```

## DESCRIPTION

The **New-PSTransportOption** cmdlet creates an object that contains transport options for session configurations.
You can use the object as the value of the *TransportOption* parameter of cmdlets that create or change a session configuration, such as the Register-PSSessionConfiguration and Set-PSSessionConfiguration cmdlets.

You can also change the transport option settings by editing the values of the session configuration properties in the WSMan: drive.
For more information, see WSMan Provider.

The session configuration options represent the session values set on the server-side, or receiving end of a remote connection.
The client-side, or sending end of the connection, can set session option values when the session is created, or when the client disconnects from or reconnects to the session.
Unless stated otherwise, when the setting values conflict, the client-side values take precedence.
However, the client-side values cannot violate maximum values and quotas set in the session configuration.

Without parameters, **New-PSTransportOption** generates a transport option object that has null values for all of the options.
If you omit a parameter, the object has a null value for the property that the parameter represents.
A null value does not affect the session configuration.

For more information about session options, see New-PSSessionOption.
For more information about session configurations, see [about_Session_Configurations](About/about_Session_Configurations.md).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Generate a default transport option

```powershell
New-PSTransportOption
```

```Output
ProcessIdleTimeoutSec           :
MaxIdleTimeoutSec               :
MaxSessions                     :
MaxConcurrentCommandsPerSession :
MaxSessionsPerUser              :
MaxMemoryPerSessionMB           :
MaxProcessesPerSession          :
MaxConcurrentUsers              :
IdleTimeoutSec                  :
OutputBufferingMode             :
```

This command runs the **New-PSTransportOption** without parameters.
The output shows that the cmdlet generates a transport option object that has null values for all properties.

### Example 2: Get session configuration options

This example shows how to use a transport options object to set session configuration options.

```powershell
$t = New-PSTransportOption -MaxSessions 40
Register-PSSessionConfiguration -Name ITTasks -TransportOption $t
Get-PSSessionConfiguration -Name ITTasks | Format-List -Property *
```

```Output
Architecture                  : 64
Filename                      : %windir%\system32\pwrshplugin.dll
ResourceUri                   : http://schemas.microsoft.com/powershell/ITTasks
MaxConcurrentCommandsPerShell : 1000
UseSharedProcess              : false
ProcessIdleTimeoutSec         : 0
xmlns                         : http://schemas.microsoft.com/wbem/wsman/1/config/PluginConfiguration
MaxConcurrentUsers            : 5
lang                          : en-US
SupportsOptions               : true
ExactMatch                    : true
RunAsUser                     :
IdleTimeoutms                 : 7200000
PSVersion                     : 3.0
OutputBufferingMode           : Block
AutoRestart                   : false
MaxShells                     : 40
MaxMemoryPerShellMB           : 1024
MaxIdleTimeoutms              : 43200000
SDKVersion                    : 2
Name                          : ITTasks
XmlRenderingType              : text
Capability                    : {Shell}
RunAsPassword                 :
MaxProcessesPerShell          : 15
Enabled                       : True
MaxShellsPerUser              : 25
Permission                    :
```

The first command uses the **New-PSTransportOption** cmdlet to create a transport options object,
which it saves in the $t variable. The command uses the *MaxSessions* parameter to increase the
maximum number of sessions to 40.

The second command uses the **Register-PSSessionConfiguration** cmdlet create the ITTasks session
configuration. The command uses the *TransportOption* parameter to specify the transport options
object in the $t variable.

The third command uses the Get-PSSessionConfiguration cmdlet to get the ITTasks session
configurations and the Format-List cmdlet to display all of the properties of the session
configuration object in a list. The output shows that the value of the **MaxShells** property of the
session configuration is 40.

### Example 3: Setting a transport option

This command shows the effect of setting a transport option in a session configuration on the sessions that use the session configuration.

```powershell
$t = New-PSTransportOption -IdleTimeoutSec 3600
Set-PSSessionConfiguration -Name ITTasks -TransportOption $t
$s = New-PSSession -Name MyITTasks -ConfigurationName ITTasks
$s | Format-List -Property *
```

```Output
State                  : Opened
IdleTimeout            : 3600000
OutputBufferingMode    : Block
ComputerName           : localhost
ConfigurationName      : ITTasks
InstanceId             : 4110c3f5-68ea-40fa-9bbf-04a433dbb02d
Id                     : 1
Name                   : MyITTasks
Availability           : Available
ApplicationPrivateData : {PSVersionTable}
Runspace               : System.Management.Automation.RemoteRunspace
```

The first command uses the **New-PSTransportOption** cmdlet to create a transport option object. The
command uses the *IdleTimeoutSec* parameter to set the **IdleTimeoutSec** property value of the
object to one hour (3600 seconds). The command saves the transport objects object in the $t
variable.

The second command uses the Set-PSSessionConfiguration cmdlet to change the transport options of the
ITTasks session configuration. The command uses the *TransportOption* parameter to specify the
transport options object in the $t variable.

The third command uses the New-PSSession cmdlet to create the MyITTasks session on the local
computer. The command uses the **ConfigurationName** property to specify the ITTasks session
configuration. The command saves the session in the $s variable.Notice that the command does not use
the *SessionOption* parameter of **New-PSSession** to set a custom idle time-out for the session. If
it did, the idle time-out value set in the session option would take precedence over the idle
time-out set in the session configuration.

The fourth command uses the Format-List cmdlet to display all properties of the session in the $s
variable in a list. The output shows that the session has an idle time-out of one hour (360,000
milliseconds).

## PARAMETERS

### -IdleTimeoutSec

Determines how long each session stays open if the remote computer does not receive any communication from the local computer.
This includes the heartbeat signal.
When the interval expires, the session closes.

The idle time-out value is of significant importance when the user intends to disconnect and reconnect to a session.
The user can reconnect only if the session has not timed out.

The *IdleTimeoutSec* parameter corresponds to the **IdleTimeoutMs** property of a session configuration.

Enter a value in seconds.
The default value is 7200 (2 hours).
The minimum value is 60 (1 minute).
The maximum is the value of the **IdleTimeout** property of Shell objects in the WSMan configuration (`WSMan:\\\<ComputerName\>\Shell\IdleTimeout`).
The default value is 7200000 milliseconds (2 hours).

If an idle time-out value is set in the session options and in the session configuration, value set in the session options takes precedence, but it cannot exceed the value of the **MaxIdleTimeoutMs** property of the session configuration.
To set the value of the **MaxIdleTimeoutMs** property, use the *MaxIdleTimeoutSec* parameter.

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaxConcurrentCommandsPerSession

Limits the number of commands that can run at the same time in each session to the specified value.
The default value is 1000.

The *MaxConcurrentCommandsPerSession* parameter corresponds to the **MaxConcurrentCommandsPerShell** property of a session configuration.

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaxConcurrentUsers

Limits the number of users who can run commands at the same time in each session to the specified value.
The default value is 5.

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaxIdleTimeoutSec

Limits the idle time-out set for each session to the specified value.
The default value is \[Int\]::MaxValue (~25 days).

The idle time-out value is of significant importance when the user intends to disconnect and reconnect to a session.
The user can reconnect only if the session has not timed out.

The *MaxIdleTimeoutSec* parameter corresponds to the **MaxIdleTimeoutMs** property of a session configuration.

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaxMemoryPerSessionMB

Limits the memory used by each session to the specified value.
Enter a value in megabytes.
The default value is 1024 megabytes (1 GB).

The *MaxMemoryPerSessionMB* parameter corresponds to the **MaxMemoryPerShellMB** property of a session configuration.

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaxProcessesPerSession

Limits the number of processes running in each session to the specified value.
The default value is 15.

The *MaxProcessesPerSession* parameter corresponds to the **MaxProcessesPerShell** property of a session configuration.

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaxSessions

Limits the number of sessions that use the session configuration.
The default value is 25.

The *MaxSessions* parameter corresponds to the **MaxShells** property of a session configuration.

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaxSessionsPerUser

Limits the number of sessions that use the session configuration and run with the credentials of a given user to the specified value.
The default value is 25.

When you specify this value, consider that many users might be using the credentials of a run as user.

The *MaxSessionsPerUser* parameter corresponds to the **MaxShellsPerUser** property of a session configuration.

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OutputBufferingMode

Determines how command output is managed in disconnected sessions when the output buffer becomes full.
The acceptable values for this parameter are:

- Block.
When the output buffer is full, execution is suspended until the buffer is clear.
- Drop.
When the output buffer is full, execution continues.
As new output is saved, the oldest output is discarded.
- None.
No output buffering mode is specified.

The default value of the **OutputBufferingMode** property of sessions is Block.

```yaml
Type: System.Nullable`1[System.Management.Automation.Runspaces.OutputBufferingMode]
Parameter Sets: (All)
Aliases:
Accepted values: None, Drop, Block

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProcessIdleTimeoutSec

Limits the time-out for each host process to the specified value.
The default value, 0, means that there is no time-out value for the process.

Other session configurations have per-process time-out values.
For example, the **Microsoft.PowerShell.Workflow** session configuration has a per-process time-out value of 28800 seconds (8 hours).

```yaml
Type: System.Nullable`1[System.Int32]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.WSManConfigurationOption

## NOTES

- The properties of a session configuration object vary with the options set for the session configuration and the values of those options. Also, session configurations that use a session configuration file have additional properties.

## RELATED LINKS

[New-PSSession](New-PSSession.md)

[New-PSSessionOption](New-PSSessionOption.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

