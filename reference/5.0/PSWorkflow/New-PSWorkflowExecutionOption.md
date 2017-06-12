---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821721
external help file:  Microsoft.PowerShell.Workflow.ServiceCore.dll-Help.xml
title:  New-PSWorkflowExecutionOption
---

# New-PSWorkflowExecutionOption

## SYNOPSIS
Creates an object that contains session configuration options for workflow sessions.

## SYNTAX

```
New-PSWorkflowExecutionOption [-PersistencePath <String>] [-MaxPersistenceStoreSizeGB <Int64>]
 [-PersistWithEncryption] [-MaxRunningWorkflows <Int32>] [-AllowedActivity <String[]>]
 [-OutOfProcessActivity <String[]>] [-EnableValidation] [-MaxDisconnectedSessions <Int32>]
 [-MaxConnectedSessions <Int32>] [-MaxSessionsPerWorkflow <Int32>] [-MaxSessionsPerRemoteNode <Int32>]
 [-MaxActivityProcesses <Int32>] [-ActivityProcessIdleTimeoutSec <Int32>]
 [-RemoteNodeSessionIdleTimeoutSec <Int32>] [-SessionThrottleLimit <Int32>]
 [-WorkflowShutdownTimeoutMSec <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The **New-PSWorkflowExecutionOption** cmdlet creates an object that contains advanced options for workflow session configurations, that is session configurations designed to run Windows PowerShell Workflow workflows.

You can use the **PSWorkflowExecutionOption** object that **New-PSWorkflowExecutionOption** generates as the value of the *SessionTypeOption* parameter of cmdlets that create or change a session configuration, such as the Register-PSSessionConfiguration and Set-PSSessionConfiguration cmdlets.

Each parameter of the **New-PSWorkflowExecutionOption** cmdlet represents a property of the workflow session configuration option object that the cmdlet returns.
If you do not specify a parameter, the cmdlet creates the object that has a default value for the property.

The **New-PSWorkflowExecutionOption** cmdlet is part of the Windows PowerShell Workflow feature.

You can also add workflow common parameters to this command.
For more information about workflow common parameters, see about_WorkflowCommonParameters.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Create a workflow options object
```
PS C:\> New-PSWorkflowExecutionOption -MaxSessionsPerWorkflow 10 -MaxDisconnectedSessions 200
SessionThrottleLimit                       : 100
PersistencePath                            : C:\Users\User01\AppData\Local\Microsoft\Windows\PowerShell\WF\PS
MaxPersistenceStoreSizeGB                  : 10
PersistWithEncryption                      : False
MaxRunningWorkflows                        : 30
AllowedActivity                            : {PSDefaultActivities}
OutOfProcessActivity                       : {InlineScript}
EnableValidation                           : True
MaxDisconnectedSessions                    : 200
MaxConnectedSessions                       : 100
MaxSessionsPerWorkflow                     : 10
MaxSessionsPerRemoteNode                   : 5
MaxActivityProcesses                       : 5
ActivityProcessIdleTimeoutSec              : 60
RemoteNodeSessionIdleTimeoutSec            : 60
WorkflowShutdownTimeoutMSec                : 500
```

This command uses the **New-PSWorkflowExecutionOption** cmdlet to increase the *MaxSessionsPerWorkflow* value to 10 and decrease the *MaxDisconnectedSessions* value to 200.

The output shows the object that the cmdlet returns.

### Example 2: Using a workflow options object
```
The first command uses the **New-PSWorkflowExecutionOption** cmdlet to create a workflow options object. The command saves the object in the $wo variable.
PS C:\> $wo = New-PSWorkflowExecutionOption -MaxSessionsPerWorkflow 10 -MaxDisconnectedSessions 200


The second command uses the Register-PSSessionConfiguration cmdlet to create the ITWorkflows session configuration. To set the workflow options in the session configuration, the command uses the *SessionTypeOption* parameter. The value of the *SessionTypeOption* parameter is the workflow options object in the $wo variable. The command also uses the *Force* parameter to suppress confirmations prompts.
PS C:\> Register-PSSessionConfiguration -Name ITWorkflows -SessionTypeOption $wo -Force
    WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Plugin

Type            Keys                                Name
----            ----                                ----
Container       {Name=ITWorkflows}                  ITWorkflows

The third command shows the workflow options in the session configuration. The command uses the Get-PSSessionConfiguration cmdlet to the get the ITWorkflows session configuration and the Format-List cmdlet to display all properties of the session configuration in a list.The output shows that the workflow options in the session configuration. Specifically, the session configuration has a **MaxSessionsPerWorkflow** property that has a value of 10 and a **MaxDisconnectedSessions** property that has a value of 200.
PS C:\> Get-PSSessionConfiguration ITWorkflows | Format-List -Property *
Architecture                  : 64
Filename                      : %windir%\system32\pwrshplugin.dll
ResourceUri                   : http://schemas.microsoft.com/powershell/ITWorkflows
MaxConcurrentCommandsPerShell : 1000
allowedactivity               : PSDefaultActivities
UseSharedProcess              : false
ProcessIdleTimeoutSec         : 0
xmlns                         : http://schemas.microsoft.com/wbem/wsman/1/config/PluginConfiguration
MaxConcurrentUsers            : 5
maxsessionsperworkflow        : 10
lang                          : en-US
sessionconfigurationdata      : <SessionConfigurationData><Param Name='PrivateData'><PrivateData><Param                                Name='enablevalidation' Value='True' /><Param Name='allowedactivity'                                Value='PSDefaultActivities' /><Param Name='outofprocessactivity' Value='InlineScript'                                /><Param Name='maxdisconnectedsessions' Value='200' /><Param                                Name='maxsessionsperworkflow' Value='10'                                /></PrivateData></Param></SessionConfigurationData>
SupportsOptions               : true
ExactMatch                    : true
RunAsUser                     :
IdleTimeoutms                 : 7200000
PSVersion                     : 3.0
OutputBufferingMode           : Block
AutoRestart                   : false
MaxShells                     : 25
MaxMemoryPerShellMB           : 1024
MaxIdleTimeoutms              : 43200000
outofprocessactivity          : InlineScript
SDKVersion                    : 2
Name                          : ITWorkflows
XmlRenderingType              : text
Capability                    : {Shell}
RunAsPassword                 :
MaxProcessesPerShell          : 15
enablevalidation              : True
Enabled                       : True
maxdisconnectedsessions       : 200
MaxShellsPerUser              : 25
Permission                    :
```

This example shows how to use a workflow options object to establish or change the workflow options in a session configuration.

## PARAMETERS

### -ActivityProcessIdleTimeoutSec
Specifies how long each activity host process is maintained after the process becomes idle.
When the interval expires, the process closes.

Enter a value in seconds.
The default value is 60.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 60
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowedActivity
Specifies the activities that are permitted to run in the session.

Enter namespace-qualified activity names, such as `Microsoft.Powershell.HyperV.Activities.*`.
Wildcard characters are supported.
The default value, **PSDefaultActivities**, includes the built-in Windows Workflow Foundation activities and the activities that represent the Windows PowerShell Core cmdlets.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: PSDefaultActivities
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableValidation
Indicates that this cmdlet verifies that all workflow activities in the session are included in the allowed activities list.

To disable validation, use the following command format: `-EnableValidation:$False`.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxActivityProcesses
Specifies the maximum number of processes that can be created in the session to support workflow activities.
The default value is 5.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxConnectedSessions
Specifies the maximum number of remote sessions that are in an operational state.
This quota is applied to sessions connected to all remote nodes, or target computers.
The default value is 100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxDisconnectedSessions
Specifies the maximum number of remote sessions that are in a disconnected state.
This quota is applied to sessions connected to all remote nodes, or target computers.
The default value is 1000.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 1000
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxPersistenceStoreSizeGB
Specifies the maximum size, in gigabytes, of the persistence store allocated to workflows that run in the session.
When the size is exceeded, the persistence store is expanded to save all persisted data, but a warning is displayed and a message is written to the workflow event log.
The default value is 10.

The persistence store contains data for all workflow jobs.
The ability to store data allows for the jobs to resume without losing state.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxRunningWorkflows
Specifies that maximum number of workflows that can run in the session at the same time.
The default value is 30.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxSessionsPerRemoteNode
Specifies the maximum number of sessions that can be connected to each remote node, or target computer.
The default value is 5

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxSessionsPerWorkflow
Specifies the maximum number of session that can be created to support each workflow.
The default value is 5.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutOfProcessActivity
Determines which allowed activities specified by the *AllowedActivities* parameter run out-of-process.
The default value is **InlineScript**.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: InlineScript
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersistWithEncryption
Indicates that the workflow encrypts the data in the persistence store.
Consider using this feature when storing persistence data in a network share.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersistencePath
Specifies the location on disk where workflow state and data are stored.
Storing the workflow state and data allows for workflows to be suspended and resumed, and to recover from interruptions and network failures.

The default value is $env:LocalAppData\Microsoft\Windows\PowerShell\WF\PS

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: $env:LocalAppData\Microsoft\Windows\PowerShell\WF\PS
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoteNodeSessionIdleTimeoutSec
Specifies how long a session that is connected to a remote node, or target computer, is maintained if it is idle.

Enter a value in seconds.
The default value is 60.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 60
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionThrottleLimit
Specifies how many operations are created to support all workflows started in the session.
The default value is 100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -WorkflowShutdownTimeoutMSec
Specifies how long the session is maintained after all workflows in the session are forcibly suspended.
When the time-out expires, Windows PowerShell closes the session, even if all workflows are not yet suspended.

Enter a value in milliseconds.
The default value is 500.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 500
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.PSWorkflowExecutionOption

## NOTES
* When the maximum value set by an option is exceeded, the command to create another instance in the session fails, unless noted in the parameter description. For example, if the value of *MaxConnectedSessions* is 100. The command to create the 101st session to a remote node, or target computer, fails.
* The properties of a session configuration object vary with the options set for the session configuration and the values of those options. Also, session configurations that use a session configuration file have additional properties.

  In particular, the properties of session configurations that include a **PSWorkflowExecutionOptions** object vary based on the workflow option values.
For example, if the session configuration includes a **PSWorkflowExecutionOptions** object that sets a non-default value for the **SessionThrottleLimit** property, the session configuration has a **SessionThrottleLimit** property.
Otherwise, it does not.

## RELATED LINKS

[New-PSWorkflowSession](New-PSWorkflowSession.md)

[about_Workflows](About/about_Workflows.md)

[about_WorkflowCommonParameters](About/about_WorkflowCommonParameters.md)

[PSWorkflow Module](PSWorkflow.md)

[PSWorkflowUtility Module](../PSWorkflowUtility/PSWorkflowUtility.md)

