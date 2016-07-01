---
external help file: PSITPro5_Core.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289615
schema: 2.0.0
---

# Start-Job
## SYNOPSIS
Starts a Windows PowerShell background job.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Start-Job [-ScriptBlock] <ScriptBlock> [[-InitializationScript] <ScriptBlock>] [-ArgumentList <Object[]>]
 [-Authentication] [-Credential <PSCredential>] [-InputObject <PSObject>] [-Name <String>]
 [-PSVersion <Version>] [-RunAs32]
```

### UNNAMED_PARAMETER_SET_2
```
Start-Job [-FilePath] <String> [[-InitializationScript] <ScriptBlock>] [-ArgumentList <Object[]>]
 [-Authentication] [-Credential <PSCredential>] [-InputObject <PSObject>] [-Name <String>]
 [-PSVersion <Version>] [-RunAs32]
```

### UNNAMED_PARAMETER_SET_3
```
Start-Job [[-InitializationScript] <ScriptBlock>] [-ArgumentList <Object[]>] [-Authentication]
 [-Credential <PSCredential>] [-InputObject <PSObject>] [-Name <String>] [-PSVersion <Version>] [-RunAs32]
 -LiteralPath <String>
```

### UNNAMED_PARAMETER_SET_4
```
Start-Job [-DefinitionName] <String> [[-DefinitionPath] <String>] [[-Type] <String>]
```

## DESCRIPTION
The Start-Job cmdlet starts a Windows PowerShell background job on the local computer.

A Windows PowerShell background job runs a command without interacting with the current session.
When you start a background job, a job object returns immediately, even if the job takes an extended time to finish.
You can continue to work in the session without interruption while the job runs.

The job object contains useful information about the job, but it does not contain the job results.
When the job finishes, use the Receive-Job cmdlet to get the results of the job.
For more information about background jobs, see about_Jobs.

To run a background job on a remote computer, use the AsJob parameter that is available on many cmdlets, or use the Invoke-Command cmdlet to run a Start-Job command on the remote computer.
For more information, see about_Remote_Jobs.

Starting in Windows PowerShell 3.0, Start-Job can start instances of custom job types, such as scheduled jobs.
For information about how to use Start-Job to start jobs with custom types, see the help topics for the job type feature.

## EXAMPLES

### Example 1: Start a background job
```
PS C:\>Start-Job -ScriptBlock {Get-Process}
Id    Name  State    HasMoreData  Location   Command
---   ----  -----    -----------  --------   -------
1     Job1  Running  True         localhost  get-process
```

This command starts a background job that runs a Get-Process command.
The command returns a job object that has information about the job.
The command prompt returns immediately so that you can work in the session while the job runs in the background.

### Example 2: Start a job by using Invoke-Command
```
PS C:\>$jobWRM = Invoke-Command -ComputerName (Get-Content servers.txt) -ScriptBlock {Get-Service winrm} -JobName "WinRM" -ThrottleLimit 16 -AsJob
```

This command uses the Invoke-Command cmdlet and its AsJob parameter to start a background job that runs a command on many computers.
Because the command is running on a server that has significant network traffic, the command uses the ThrottleLimit parameter of Invoke-Command to limit the number of concurrent commands to 16.

The command uses the ComputerName parameter to specify the computers on which the job runs.
The value of the ComputerName parameter is a Get-Content command that gets the text in the Servers.txt file, a file of computer names in a domain.

The command uses the ScriptBlock parameter to specify the command and the JobName parameter to specify a friendly name for the job.

### Example 3: Get events from the System log on the local computer
```
PS C:\>$j = Start-Job -ScriptBlock {Get-EventLog -Log system} -Credential domain01\user01
PS C:\> $j | Format-List -Property *

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

PS C:\> $j.JobStateInfo.state
Completed
PS C:\> $results = Receive-Job -Job $j
PS C:\> $results

Index Time          Type        Source                EventID Message
----- ----          ----        ------                ------- -------
84366 Feb 18 19:20  Information Service Control M...     7036 The description...
84365 Feb 18 19:16  Information Service Control M...     7036 The description...
84364 Feb 18 19:10  Information Service Control M...     7036 The description...
...
```

These commands manage a background job that gets all of the events from the System log in Event Viewer.
The job runs on the local computer.

The first command uses the Start-Job cmdlet to start the job.
It uses the Credential parameter to specify the user account of a user who has permission to run the job on the computer.
Then it stores the job object that Start-Job returns in the $j variable.

At this point, you can resume your other work while the job finishes.

The second command uses a pipeline operator (|) to pass the job object in $j to the Format-List cmdlet.
The Format-List command uses the Property parameter with a value of all (*) to display all of the properties of the job object in a list.

The third command displays the value of the JobStateInfo property.
This contains the status of the job.

The fourth command uses the Receive-Job cmdlet to get the results of the job.
It stores the results in the $results variable.

The final command displays the contents of the $results variable.

### Example 4: Run a script as a background job
```
PS C:\>Start-Job -FilePath "c:\scripts\sample.ps1"
```

This command runs the Sample.ps1 script as a background job.

### Example 5: Get a process by name by using a background job
```
PS C:\>Start-Job -Name "WinRm" -ScriptBlock {Get-Process winrm}
```

This command runs a background job that gets the WinRM process on the local computer.
The command uses the ScriptBlock parameter to specify the command that runs in the background job.
It uses the Name parameter to specify a friendly name for the new job.

### Example 6: Collect and save data by using a background job
```
PS C:\>Start-Job -Name GetMappingFiles -InitializationScript {Import-Module MapFunctions} -ScriptBlock {Get-Map -Name * | Set-Content D:\Maps.tif} -RunAs32
```

This command starts a job that collects lots of data, and then saves it in a .tif file.
The command uses the InitializationScript parameter to run a script block that imports a required module.
It also uses the RunAs32 parameter to run the job in a 32-bit process even if the computer has a 64-bit operating system.

## PARAMETERS

### -ArgumentList
Specifies an array of arguments, or parameter values, for the script that is specified by the FilePath parameter.

Because all of the values that follow the ArgumentList parameter name are interpreted as being values of ArgumentList, specify this parameter as the last parameter in the command.

```yaml
Type: Object[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: Args

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authentication
Specifies the mechanism that is used to authenticate user credentials.
The acceptable values for this parameter are:

-- Default 
-- Basic 
-- Credssp 
-- Digest 
-- Kerberos 
-- Negotiate  
-- NegotiateWithImplicitCredential 

The default value is Default.

CredSSP authentication is available only in Windows Vista, Windows Server 2008, and later versions of the Windows operating system.

For information about the values of this parameter, see the description of the AuthenticationMechanism Enumerationhttp://go.microsoft.com/fwlink/?LinkID=144382 (http://go.microsoft.com/fwlink/?LinkID=144382) in the Microsoft Developer Network (MSDN).

Caution: Credential Security Support Provider (CredSSP) authentication, in which the user's credentials are passed to a remote computer to be authenticated, is designed for commands that require authentication on more than one resource, such as accessing a remote network share.
This mechanism increases the security risk of the remote operation.
If the remote computer is compromised, the credentials that are passed to it can be used to control the network session.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 
Accepted values: Default, Basic, Negotiate, NegotiateWithImplicitCredential, Credssp, Digest, Kerberos

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or enter a PSCredential object, such as one from the Get-Credential cmdlet.

```yaml
Type: PSCredential
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Specifies a local script that this cmdlet runs as a background job.
Enter the path and file name of the script or pipe a script path to Start-Job.
The script must be on the local computer or in a folder that the local computer can access.

When you use this parameter, Windows PowerShell converts the contents of the specified script file to a script block and runs the script block as a background job.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
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

In the value of the ScriptBlock parameter, use the $Input automatic variable to represent the input objects.

```yaml
Type: PSObject
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath
Specifies a local script that this cmdlet runs as a background job.
Enter the path of a script on the local computer.

Unlike the FilePath parameter, this cmdlet uses the value of the LiteralPath parameter exactly as it is typed.
No characters are interpreted as wildcard characters.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies a friendly name for the new job.
You can use the name to identify the job to other job cmdlets, such as the Stop-Job cmdlet.

The default friendly name is Job#, where # is an ordinal number that is incremented for each job.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSVersion
Specifies a version.
This cmdlet runs the job with the version of Windows PowerShell.
The acceptable values for this parameter are: 2.0 and 3.0.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunAs32
Indicates that this cmdlet runs the job in a 32-bit process.
Use this parameter to force the job to run in a 32-bit process on a 64-bit operating system.

On 64-bit versions of Windows 7 and Windows Server 2008 R2, when the Start-Job command includes the RunAs32 parameter, you cannot use the Credential parameter to specify the credentials of another user.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock
Specifies the commands to run in the background job.
Enclose the commands in braces ( { } ) to create a script block.
This parameter is required.

```yaml
Type: ScriptBlock
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: Command

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefinitionName
Specifies the definition name of the job that this cmdlet starts.
Use this parameter to start custom job types that have a definition name, such as scheduled jobs.

When you use Start-Job to start an instance of a scheduled job, the job starts immediately, regardless of job triggers or job options.
The resulting job instance is a scheduled job, but it is not saved to disk like triggered scheduled jobs.
Also, you cannot use the ArgumentList parameter of Start-Job to provide values for parameters of scripts that run in a scheduled job.
For more information, see about_Scheduled_Jobs.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_4
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefinitionPath
Specifies path of the definition for the job that this cmdlet starts.
Enter the definition path.
The concatenation of the values of the DefinitionPath and DefinitionName parameters is the fully qualified path of the job definition.
Use this parameter to start custom job types that have a definition path, such as scheduled jobs.

For scheduled jobs, the value of the DefinitionPath parameter is $home\AppData\Local\Windows\PowerShell\ScheduledJob.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_4
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Specifies the custom type for jobs that this cmdlet starts.
Enter a custom job type name, such as PSScheduledJob for scheduled jobs or PSWorkflowJob for workflows jobs.
This parameter is not valid for standard background jobs.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_4
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe an object that has the Name property to the Name parameter.
For example, you can pipe a FileInfo object from Get-ChildItem to Start-Job.

## OUTPUTS

### System.Management.Automation.PSRemotingJob
This cmdlet returns an object that represents the job that it started.

## NOTES
To run in the background, Start-Job runs in its own session in the current session.
When you use the Invoke-Command cmdlet to run a Start-Job command in a session on a remote computer, Start-Job runs in a session in the remote session.

## RELATED LINKS

[Get-Job](1352c534-7193-46ca-9ab1-0c5219a661ad)

[Invoke-Command](906b4b41-7da8-4330-9363-e7164e5e6970)

[Receive-Job](78fcc10b-5cde-4bf2-a901-33f8237f87fe)

[Remove-Job](eaa911ae-3a84-4279-a9db-fead1dfdb8bb)

[Resume-Job](3a22c75a-f0bd-4afd-ac3c-da7ccd22ec45)

[Stop-Job](b998b518-121a-48f4-b062-2b388069de18)

[Suspend-Job](3496f930-2c84-4a90-9c65-ad562f0dc4cf)

[Wait-Job](cb8a2c67-f8a5-45a8-a27f-2ec028c9da8f)

[about_Job_Details](7c86b964-86d2-4bfc-89db-a74f9d926215)

[about_Remote_Jobs](b68c635f-5ee0-44fd-8693-28f8f4ca9fa0)

[about_Jobs](7362512a-8a4e-4575-b2ea-a740e5c4f002)

