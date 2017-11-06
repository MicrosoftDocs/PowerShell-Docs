---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821641
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Stop-Computer
---

# Stop-Computer

## SYNOPSIS
Stops (shuts down) local and remote computers.

## SYNTAX

```
Stop-Computer [-AsJob] [-DcomAuthentication <AuthenticationLevel>] [-WsmanAuthentication <String>]
 [-Protocol <String>] [[-ComputerName] <String[]>] [[-Credential] <PSCredential>]
 [-Impersonation <ImpersonationLevel>] [-ThrottleLimit <Int32>] [-Force]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Stop-Computer** cmdlet shuts down computers remotely.
It can also shut down the local computer.

You can use the parameters of **Stop-Computer** to run the shutdown operations as a background job, to specify the authentication levels and alternate credentials, to limit the concurrent connections that are created to run the command, and to force an immediate shut down.

This cmdlet does not require Windows PowerShell remoting unless you use the *AsJob* parameter.

## EXAMPLES

### Example 1: Shut down the local computer
```
PS C:\> Stop-Computer
```

This command shuts down the local computer.

### Example 2: Shut down two remote computers and the local computer
```
PS C:\> Stop-Computer -ComputerName "Server01", "Server02", "localhost"
```

This command stops two remote computers, Server01 and Server02, and the local computer, identified as localhost.

### Example 3: Shut down remote computers as a background job
```
PS C:\> $j = Stop-Computer -ComputerName "Server01", "Server02" -AsJob
PS C:\> $results = $j | Receive-Job
PS C:\> $results
```

These commands run **Stop-Computer** as a background job on two remote computers, and then get the results.

The first command specifies the *AsJob* parameter to run the command as a background job.
The command saves the resulting job object in the $j variable.

The second command uses a pipeline operator to send the job object in $j to **Receive-Job**, which gets the job results.
The command saves the results in the $results variable.

The third command displays the result saved in the $results variable.

Because *AsJob* creates the job on the local computer and automatically returns the results to the local computer, you can run **Receive-Job** as a local command.

### Example 4: Shut down a remote computer
```
PS C:\> Stop-Computer -CompupterName "Server01" -Impersonation anonymous -Authentication PacketIntegrity
```

This command stops the Server01 remote computer.
The command uses customized impersonation and authentication settings.

### Example 5:
```
PS C:\> $s = Get-Content Domain01.txt
PS C:\> $c = Get-Credential domain01\admin01
PS C:\> Stop-Computer -ComputerName $s -Force -ThrottleLimit 10 -Credential $c
```

These commands force an immediate shut down of all of the computers in Domain01.

The first command gets a list of computers in the domain, and then stores them in the $s variable.

The second command gets the credentials of a domain administrator, and then stores them in the $c variable.

The third command shuts down the computers.
It uses *ComputerName* parameter to submit the list of computers in the $s variable, the *Force* parameter to force an immediate shutdown, and the *Credential* parameter to submit the credentials saved in the $c variable.
It also uses the *ThrottleLimit* parameter to limit the command to 10 concurrent connections.

## PARAMETERS

### -AsJob
Indicates that this cmdlet runs as a background job.

To use this parameter, the local and remote computers must be configured for remoting and, on Windows Vista and later versions of the Windows operating system, you must open Windows PowerShell by using the Run as administrator option.
For more information, see about_Remote_Requirements.

When you specify the *AsJob* parameter, the command immediately returns an object that represents the background job.
You can continue to work in the session while the job finishes.
The job is created on the local computer and the results from remote computers are automatically returned to the local computer.
To get the job results, use the Receive-Job cmdlet.

For more information about Windows PowerShell background jobs, see [about_Jobs](../Microsoft.PowerShell.Core/About/about_Jobs.md) and [about_Remote_Jobs](../Microsoft.PowerShell.Core/About/about_Remote_Jobs.md).

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

### -ComputerName
Specifies the computers to stop.
The default is the local computer.

Type the NETBIOS name, IP address, or fully qualified domain name of one or more computers in a comma-separated list.
To specify the local computer, type the computer name or localhost.

This parameter does not rely on Windows PowerShell remoting.
You can use the *ComputerName* parameter even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: CN, __SERVER, Server, IPAddress

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one from the Get-Credential cmdlet.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces an immediate shut down of the computers.

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

### -Impersonation
Specifies the impersonation level to use when this cmdlet calls WMI.
**Stop-Computer** uses WMI.
The acceptable values for this parameter are:

- Default.
Default impersonation. 
- Anonymous.
Hides the identity of the caller. 
- Identify.
Allows objects to query the credentials of the caller. 
- Impersonate.
Allows objects to use the credentials of the caller. 

The default value is Impersonate.

```yaml
Type: ImpersonationLevel
Parameter Sets: (All)
Aliases: 
Accepted values: Default, Anonymous, Identify, Impersonate, Delegate

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit
Specifies the maximum number of concurrent connections that can be established to run this command.
If you omit this parameter or enter a value of 0, the default value, 32, is used.

The throttle limit applies only to the current command, not to the session or to the computer.

```yaml
Type: Int32
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
Type: SwitchParameter
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
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DcomAuthentication
Specifies the authentication level that this cmdlet uses with WMI.
**Stop-Computer** uses WMI.
The acceptable values for this parameter are:

- Default.
Windows Authentication 
- None.
No COM authentication 
- Connect.
Connect-level COM authentication
- Call.
Call-level COM authentication
- Packet .
Packet-level COM authentication
- PacketIntegrity.
Packet Integrity-level COM authentication 
- PacketPrivacy.
Packet Privacy-level COM authentication 
- Unchanged.
Same as the previous command

The default value is Packet.

For more information about the values of this parameter, see [AuthenticationLevel Enumeration](https://msdn.microsoft.com/library/system.management.authenticationlevel) in the MSDN library.

```yaml
Type: AuthenticationLevel
Parameter Sets: (All)
Aliases: Authentication

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Protocol
Specifies which protocol to use to restart the computers.
The acceptable values for this parameter are: WSMan and DCOM.
The default value is DCOM.

This parameter was introduced in Windows PowerShell 3.0.

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

### -WsmanAuthentication
Specifies the mechanism that is used to authenticate the user credentials when this cmdlet uses the WSMan protocol.
The acceptable values for this parameter are:

- Basic 
- CredSSP 
- Default 
- Digest 
- Kerberos 
- Negotiate. 

The default value is Default.

For more information about the values of this parameter, see [AuthenticationMechanism Enumeration](https://msdn.microsoft.com/library/system.management.automation.runspaces.authenticationmechanism) in the MSDN library.

Caution: Credential Security Service Provider (CredSSP) authentication, in which the user credentials are passed to a remote computer to be authenticated, is designed for commands that require authentication on more than one resource, such as accessing a remote network share.
This mechanism increases the security risk of the remote operation.
If the remote computer is compromised, the credentials that are passed to it can be used to control the network session.

This parameter was introduced in Windows PowerShell 3.0.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None or System.Management.Automation.RemotingJob
The cmdlet returns a **System.Management.Automation.RemotingJob** object, if you specify the *AsJob* parameter.
Otherwise, it does not generate any output.

## NOTES
* This cmdlet uses the **Win32Shutdown** method of the **Win32_OperatingSystem** WMI class.
* In Windows PowerShell 2.0, the *AsJob* parameter does not work reliably when you are restarting/stopping remote computers. In Windows PowerShell 3.0, the implementation is changed to resolve this problem.

## RELATED LINKS

[Add-Computer](https://msdn.microsoft.com/en-us/powershell/reference/5.1/Microsoft.PowerShell.Management/Add-Computer)

[Checkpoint-Computer](https://msdn.microsoft.com/en-us/powershell/reference/5.1/Microsoft.PowerShell.Management/Checkpoint-Computer)

[Remove-Computer](https://msdn.microsoft.com/en-us/powershell/reference/5.1/Microsoft.PowerShell.Management/Remove-Computer)

[Rename-Computer](Rename-Computer.md)

[Restart-Computer](Restart-Computer.md)

[Restore-Computer](https://msdn.microsoft.com/en-us/powershell/reference/5.1/Microsoft.PowerShell.Management/Restore-Computer)

[Test-Connection](Test-Connection.md)

