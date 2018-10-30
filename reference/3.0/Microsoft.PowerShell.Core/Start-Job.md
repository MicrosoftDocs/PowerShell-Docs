---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113405
external help file:  System.Management.Automation.dll-Help.xml
title:  Start-Job
---
# Start-Job

## SYNOPSIS

Starts a Windows PowerShell background job.

## SYNTAX

### ComputerName (Default)

```
Start-Job [-Name <String>] [-ScriptBlock] <ScriptBlock> [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [[-InitializationScript] <ScriptBlock>] [-RunAs32]
 [-PSVersion <Version>] [-InputObject <PSObject>] [-ArgumentList <Object[]>] [<CommonParameters>]
```

### DefinitionName

```
Start-Job [-DefinitionName] <String> [[-DefinitionPath] <String>] [[-Type] <String>] [<CommonParameters>]
```

### LiteralFilePathComputerName

```
Start-Job [-Name <String>] [-Credential <PSCredential>] -LiteralPath <String>
 [-Authentication <AuthenticationMechanism>] [[-InitializationScript] <ScriptBlock>] [-RunAs32]
 [-PSVersion <Version>] [-InputObject <PSObject>] [-ArgumentList <Object[]>] [<CommonParameters>]
```

### FilePathComputerName

```
Start-Job [-Name <String>] [-Credential <PSCredential>] [-FilePath] <String>
 [-Authentication <AuthenticationMechanism>] [[-InitializationScript] <ScriptBlock>] [-RunAs32]
 [-PSVersion <Version>] [-InputObject <PSObject>] [-ArgumentList <Object[]>] [<CommonParameters>]
```

## DESCRIPTION

The **Start-Job** cmdlet starts a Windows PowerShell background job on the local computer.

A Windows PowerShell background job runs a command "in the background" without interacting with the current session.
When you start a background job, a job object is returned immediately, even if the job takes an extended time to complete.
You can continue to work in the session without interruption while the job runs.

The job object contains useful information about the job, but it does not contain the job results.
When the job completes, use the Receive-Job cmdlet to get the results of the job.
For more information about background jobs, see [about_Jobs](./About/about_Jobs.md).

To run a background job on a remote computer, use the AsJob parameter that is available on many cmdlets, or use the Invoke-Command cmdlet to run a **Start-Job** command on the remote computer.
For more information, see [about_Remote_Jobs](./About/about_Remote_Jobs.md).

Beginning in Windows PowerShell 3.0, **Start-Job** can start instances of custom job types, such as scheduled jobs.
For information about using **Start-Job** to start jobs with custom types, see the help topics for the job type feature.

## EXAMPLES

### Example 1

```
PS> start-job -scriptblock {get-process}

Id    Name  State    HasMoreData  Location   Command
---   ----  -----    -----------  --------   -------
1     Job1  Running  True         localhost  get-process
```

This command starts a background job that runs a Get-Process command.
The command returns a job object with information about the job.
The command prompt returns immediately so that you can work in the session while the job runs in the background.

### Example 2

```
PS> $jobWRM = invoke-command -computerName (get-content servers.txt) -scriptblock {get-service winrm} -jobname WinRM -throttlelimit 16 -AsJob
```

This command uses the Invoke-Command cmdlet and its AsJob parameter to start a background job that runs a "get-service winrm" command on numerous computers.
Because the command is running on a server with substantial network traffic, the command uses the ThrottleLimit parameter of Invoke-Command to limit the number of concurrent commands to 16.

The command uses the ComputerName parameter to specify the computers on which the job runs.
The value of the ComputerName parameter is a Get-Content command that gets the text in the Servers.txt file, a file of computer names in a domain.

The command uses the ScriptBlock parameter to specify the command and the JobName parameter to specify a friendly name for the job.

### Example 3

```
PS> $j = start-job -scriptblock {get-eventlog -log system} -credential domain01\user01
PS> $j | format-list -property *

HasMoreData   : True
StatusMessage :
Location      : localhost
Command       : get-eventlog -log system
JobStateInfo  : Running
Finished      : System.Threading.ManualResetEvent
InstanceId    : 2d9d775f-63e0-4d48-b4bc-c05d0e177f34
Id            : 1
Name          : Job1
ChildJobs     : {Job2}
Output        : {}
Error         : {}
Progress      : {}
Verbose       : {}
Debug         : {}
Warning       : {}
StateChanged  :

PS> $j.JobStateInfo.state
Completed
PS> $results = receive-job -job $j
PS> $results

Index Time          Type        Source                EventID Message
----- ----          ----        ------                ------- -------
84366 Feb 18 19:20  Information Service Control M...     7036 The description...
84365 Feb 18 19:16  Information Service Control M...     7036 The description...
84364 Feb 18 19:10  Information Service Control M...     7036 The description...
...
```

These commands manage a background job that gets all of the events from the System log in Event Viewer.
The job runs on the local computer.

The first command uses the **Start-Job** cmdlet to start the job.
It uses the Credential parameter to specify the user account of a user who has permission to run the job on the computer.
Then it saves the job object that **Start-Job** returns in the $j variable.

At this point, you can resume your other work while the job completes.

The second command uses a pipeline operator (|) to pass the job object in $j to the Format-List cmdlet.
The Format-List command uses the Property parameter with a value of all (*) to display all of the properties of the job object in a list.

The third command displays the value of the JobStateInfo property.
This contains the status of the job.

The fourth command uses the Receive-Job cmdlet to get the results of the job.
It stores the results in the $results variable.

The final command displays the contents of the $results variable.

### Example 4

```
PS> start-job -filepath c:\scripts\sample.ps1
```

This command runs the Sample.ps1 script as a background job.

### Example 5

```
PS> start-job -name WinRm -scriptblock {get-process winrm}
```

This command runs a background job that gets the WinRM process on the local computer.
The command uses the ScriptBlock parameter to specify the command that runs in the background job.
It uses the Name parameter to specify a friendly name for the new job.

### Example 6

```
PS> start-job -name GetMappingFiles -initializationScript {import-module MapFunctions} -scriptblock {Get-Map -name * | set-content D:\Maps.tif} -runAs32
```

This command starts a job that collects a large amount of data and saves it in a .tif file.
The command uses the InitializationScript parameter to run a script block that imports a required module.
It also uses the RunAs32 parameter to run the job in a 32-bit process even if the computer has a 64-bit operating system.

## PARAMETERS

### -ArgumentList

Specifies the arguments (parameter values) for the script that is specified by the **FilePath** parameter.

Because all of the values that follow the ArgumentList parameter name are interpreted as being values of ArgumentList, the ArgumentList parameter should be the last parameter in the command.

```yaml
Type: Object[]
Parameter Sets: ComputerName, LiteralFilePathComputerName, FilePathComputerName
Aliases: Args

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authentication

Specifies the mechanism that is used to authenticate the user's credentials.
Valid values are **Default**, **Basic**, **Credssp**, **Digest**, **Kerberos**, **Negotiate**, and **NegotiateWithImplicitCredential**.
The default value is **Default**.

CredSSP authentication is available only in Windows Vista, Windows Server 2008, and later versions of Windows.

For more information about the values of this parameter, see [AuthenticationMechanism Enumeration](/dotnet/api/system.management.automation.runspaces.authenticationmechanism) in the MSDN library.

CAUTION: Credential Security Support Provider (CredSSP) authentication, in which the user's credentials are passed to a remote computer to be authenticated, is designed for commands that require authentication on more than one resource, such as accessing a remote network share.
This mechanism increases the security risk of the remote operation.
If the remote computer is compromised, the credentials that are passed to it can be used to control the network session.

```yaml
Type: AuthenticationMechanism
Parameter Sets: ComputerName, LiteralFilePathComputerName, FilePathComputerName
Aliases:

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one from the Get-Credential cmdlet.

```yaml
Type: PSCredential
Parameter Sets: ComputerName, LiteralFilePathComputerName, FilePathComputerName
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Runs the specified local script as a background job.
Enter the path and file name of the script or pipe a script path to **Start-Job**.
The script must reside on the local computer or in a directory that the local computer can access.

When you use this parameter, Windows PowerShell converts the contents of the specified script file to a script block and runs the script block as a background job.

```yaml
Type: String
Parameter Sets: FilePathComputerName
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InitializationScript

Specifies commands that run before the job starts.
Enclose the commands in braces ( { } ) to create a script block.

Use this parameter to prepare the session in which the job runs.
For example, you can use it to add functions, snap-ins, and modules to the session.

```yaml
Type: ScriptBlock
Parameter Sets: ComputerName, LiteralFilePathComputerName, FilePathComputerName
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies input to the command.
Enter a variable that contains the objects, or type a command or expression that generates the objects.

In the value of the **ScriptBlock** parameter, use the $input automatic variable to represent the input objects.

```yaml
Type: PSObject
Parameter Sets: ComputerName, LiteralFilePathComputerName, FilePathComputerName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Runs the specified local script as a background job.
Enter the path to a script on the local computer.

Unlike the **FilePath** parameter, the value of **LiteralPath** is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: LiteralFilePathComputerName
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies a friendly name for the new job.
You can use the name to identify the job to other job cmdlets, such as Stop-Job.

The default friendly name is Job#, where "#" is an ordinal number that is incremented for each job.

```yaml
Type: String
Parameter Sets: ComputerName, LiteralFilePathComputerName, FilePathComputerName
Aliases:

Required: False
Position: Named
Default value: Job<number>
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSVersion

Runs the job with the specified version of Windows PowerShell.
Valid values are 2.0 and 3.0.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: Version
Parameter Sets: ComputerName, LiteralFilePathComputerName, FilePathComputerName
Aliases:

Required: False
Position: Named
Default value: 3.0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunAs32

Runs the job in a 32-bit process.
Use this parameter to force the job to run in a 32-bit process on a 64-bit operating system.

NOTE: On 64-bit versions of Windows 7 and Windows Server 2008 R2, when the **Start-Job** command includes the **RunAs32** parameter, you cannot use the **Credential** parameter to specify the credentials of another user.

```yaml
Type: SwitchParameter
Parameter Sets: ComputerName, LiteralFilePathComputerName, FilePathComputerName
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock

Specifies the commands to run in the background job.
Enclose the commands in braces ( { } ) to create a script block.
This parameter is required.

```yaml
Type: ScriptBlock
Parameter Sets: ComputerName
Aliases: Command

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefinitionName

Starts the job with the specified job definition name.
Use this parameter to start custom job types that have a definition name, such as scheduled jobs.

When you use **Start-Job** to start an instance of a scheduled job, the job starts immediately, regardless of job triggers or job options.
The resulting job instance is a scheduled job, but it is not saved to disk like triggered scheduled jobs.
Also, you cannot use the **ArgumentList** parameter of **Start-Job** to provide values for parameters of scripts that run in a scheduled job.
For more information, see [about_Scheduled_Jobs](../PSScheduledJob/About/about_Scheduled_Jobs.md).

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: DefinitionName
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefinitionPath

Starts the job at the specified path location.
Enter the definition path.
The concatenation of the values of the **DefinitionPath** and **DefinitionName** parameters should be the fully-qualified path to the job definition.
Use this parameter to start custom job types that have a definition path, such as scheduled jobs.

For scheduled jobs, the value of the **DefinitionPath** parameter is "$home\AppData\Local\Windows\PowerShell\ScheduledJob".

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: DefinitionName
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type

Starts only jobs of the specified custom type.
Enter a custom job type name, such as PSScheduledJob for scheduled jobs or PSWorkflowJob for workflows jobs.
This parameter is not valid for standard background jobs.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: DefinitionName
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.String

You can pipe an object with the Name property to the Name parameter.
For example, you can pipe a FileInfo object from Get-ChildItem to **Start-Job**.

## OUTPUTS

### System.Management.Automation.PSRemotingJob

**Start-Job** returns an object that represents the job that it started.

## NOTES

- To run in the background, **Start-Job** runs in its own session within the current session. When you use the Invoke-Command cmdlet to run a **Start-Job** command in a session on a remote computer, **Start-Job** runs in a session within the remote session.

- 

## RELATED LINKS

[Get-Job](Get-Job.md)

[Invoke-Command](Invoke-Command.md)

[Receive-Job](Receive-Job.md)

[Remove-Job](Remove-Job.md)

[Resume-Job](Resume-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Suspend-Job](Suspend-Job.md)

[Wait-Job](Wait-Job.md)

[about_Job_Details](About/about_Job_Details.md)

[about_Remote_Jobs](About/about_Remote_Jobs.md)

[about_Jobs](About/about_Jobs.md)