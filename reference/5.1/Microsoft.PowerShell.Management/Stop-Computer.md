---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 05/15/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/stop-computer?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Stop-Computer
---

# Stop-Computer

## SYNOPSIS
Stops (shuts down) local and remote computers.

## SYNTAX

### All

```
Stop-Computer [-AsJob] [-DcomAuthentication <AuthenticationLevel>] [-WsmanAuthentication <String>]
 [-Protocol <String>] [[-ComputerName] <String[]>] [[-Credential] <PSCredential>]
 [-Impersonation <ImpersonationLevel>] [-ThrottleLimit <Int32>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Stop-Computer` cmdlet shuts down the local computer and remote computers.

You can use the parameters of `Stop-Computer` to run the shutdown operations as a background job, to
specify the authentication levels and alternate credentials, to limit the concurrent connections
that are created to run the command, and to force an immediate shut down.

This cmdlet doesn't require PowerShell remoting unless you use the **AsJob** parameter.

## EXAMPLES

### Example 1: Shut down the local computer

This example shuts down the local computer.

```powershell
Stop-Computer -ComputerName localhost
```

### Example 2: Shut down two remote computers and the local computer

This example stops two remote computers and the local computer.

```powershell
Stop-Computer -ComputerName "Server01", "Server02", "localhost"
```

`Stop-Computer` uses the **ComputerName** parameter to specify two remote computers and the local
computer. Each computer is shut down.

### Example 3: Shut down remote computers as a background job

In this example, `Stop-Computer` runs as a background job on two remote computers.

```powershell
$j = Stop-Computer -ComputerName "Server01", "Server02" -AsJob
$results = $j | Receive-Job
$results
```

`Stop-Computer` uses the **ComputerName** parameter to specify two remote computers. The **AsJob**
parameter runs the command as a background job. The job objects are stored in the `$j` variable.

The job objects in the `$j` variable are sent down the pipeline to `Receive-Job`, which gets the job
results. The objects are stored in the `$results` variable. The `$results` variable displays the job
information in the PowerShell console.

Because **AsJob** creates the job on the local computer and automatically returns the results to the
local computer, you can run `Receive-Job` as a local command.

### Example 4: Shut down a remote computer

This example shuts down a remote computer using specified authentication.

```powershell
Stop-Computer -ComputerName "Server01" -Impersonation Anonymous -DcomAuthentication PacketIntegrity
```

`Stop-Computer` uses the **ComputerName** parameter to specify the remote computer. The
**Impersonation** parameter specifies a customized impersonation and the **DcomAuthentication**
parameter specifies authentication-level settings.

### Example 5: Shut down computers in a domain

In this example, the commands force an immediate shut down of all computers in a specified domain.

```powershell
$s = Get-Content -Path ./Domain01.txt
$c = Get-Credential -Credential Domain01\Admin01
Stop-Computer -ComputerName $s -Force -ThrottleLimit 10 -Credential $c
```

`Get-Content` uses the **Path** parameter to get a file in the current directory with the list of
domain computers. The objects are stored in the `$s` variable.

`Get-Credential` uses the **Credential** parameter to specify the credentials of a domain
administrator. The credentials are stored in the `$c` variable.

`Stop-Computer` shuts down the computers specified with the **ComputerName** parameter's list of
computers in the `$s` variable. The **Force** parameter forces an immediate shutdown. The
**ThrottleLimit** parameter limits the command to 10 concurrent connections. The **Credential**
parameter submits the credentials saved in the `$c` variable.

## PARAMETERS

### -AsJob

Indicates that this cmdlet runs as a background job.

To use this parameter, the local and remote computers must be configured for remoting and, on
Windows Vista and later versions of the Windows operating system, you must open PowerShell by using
the **Run as administrator** option. For more information, see
[about_Remote_Requirements](..//microsoft.powershell.core/about/about_remote_requirements.md).

When you specify the **AsJob** parameter, the command immediately returns an object that represents
the background job. You can continue to work in the session while the job finishes. The job is
created on the local computer and the results from remote computers are automatically returned to
the local computer. To get the job results, use the `Receive-Job` cmdlet.

For more information about PowerShell background jobs, see
[about_Jobs](..//microsoft.powershell.core/about/about_jobs.md) and
[about_Remote_Jobs](../microsoft.powershell.core/about/about_remote_jobs.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName

Specifies the computers to stop. The default is the local computer.

Type the NETBIOS name, IP address, or fully qualified domain name of one or more computers in a
comma-separated list. To specify the local computer, type the computer name or localhost.

This parameter doesn't rely on PowerShell remoting. You can use the **ComputerName** parameter even
if your computer isn't configured to run remote commands.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: CN, __SERVER, Server, IPAddress

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to do this action. The default is the current user.

Type a user name, such as **User01** or **Domain01\User01**, or enter a **PSCredential** object
generated by the `Get-Credential` cmdlet. If you type a user name, you're prompted to enter the
password.

Credentials are stored in a [PSCredential](/dotnet/api/system.management.automation.pscredential)
object and the password is stored as a [SecureString](/dotnet/api/system.security.securestring).

> [!NOTE]
> For more information about **SecureString** data protection, see
> [How secure is SecureString?](/dotnet/api/system.security.securestring#how-secure-is-securestring).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -DcomAuthentication

Specifies the authentication level that this cmdlet uses with WMI. `Stop-Computer` uses WMI. The
default value is **Packet**.

The acceptable values for this parameter are:

- **Default**: Windows Authentication.
- **None**: No COM authentication.
- **Connect**: Connect-level COM authentication.
- **Call**: Call-level COM authentication.
- **Packet**: Packet-level COM authentication.
- **PacketIntegrity**: Packet Integrity-level COM authentication.
- **PacketPrivacy**: Packet Privacy-level COM authentication.
- **Unchanged**: Same as the previous command.

For more information about the values of this parameter, see
[AuthenticationLevel](/dotnet/api/system.management.authenticationlevel).

```yaml
Type: System.Management.AuthenticationLevel
Parameter Sets: (All)
Aliases: Authentication
Accepted values: Default, None, Connect, Call, Packet, PacketIntegrity, PacketPrivacy, Unchanged

Required: False
Position: Named
Default value: Packet
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Forces an immediate shut down of the computer.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Impersonation

Specifies the impersonation level to use when this cmdlet calls WMI. The default value is
**Impersonate**.

`Stop-Computer` uses WMI. The acceptable values for this parameter are:

- **Default**: Default impersonation.
- **Anonymous**: Hides the identity of the caller.
- **Identify**: Allows objects to query the credentials of the caller.
- **Impersonate**: Allows objects to use the credentials of the caller.

```yaml
Type: System.Management.ImpersonationLevel
Parameter Sets: (All)
Aliases:
Accepted values: Default, Anonymous, Identify, Impersonate, Delegate

Required: False
Position: Named
Default value: Impersonate
Accept pipeline input: False
Accept wildcard characters: False
```

### -Protocol

Specifies which protocol to use to restart the computers. The acceptable values for this parameter
are: **WSMan** and **DCOM**. The default value is **DCOM**.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: DCOM, WSMan

Required: False
Position: Named
Default value: DCOM
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit

Specifies the maximum number of concurrent connections that can be established to run this command.
If you omit this parameter or enter a value of 0, the default value, 32, is used.

The throttle limit applies only to the current command, not to the session or to the computer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WsmanAuthentication

Specifies the mechanism that is used to authenticate the user credentials when this cmdlet uses the
WSMan protocol. The default value is **Default**.

The acceptable values for this parameter are:

- Basic
- CredSSP
- Default
- Digest
- Kerberos
- Negotiate.

For more information about the values of this parameter, see
[AuthenticationMechanism](/dotnet/api/system.management.automation.runspaces.authenticationmechanism).

> [!CAUTION]
> Credential Security Service Provider (CredSSP) authentication, in which the user credentials are
> passed to a remote computer to be authenticated, is designed for commands that require
> authentication on more than one resource, such as accessing a remote network share. This mechanism
> increases the security risk of the remote operation. If the remote computer is compromised, the
> credentials that are passed to it can be used to control the network session.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Default, Basic, Negotiate, CredSSP, Digest, Kerberos

Required: False
Position: Named
Default value: Default
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

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

By default, this cmdlet returns no output.

### System.Management.Automation.RemotingJob

When you use the **AsJob** parameter, this cmdlet returns a **RemotingJob** object.

## NOTES

This cmdlet uses the
[`Win32Shutdown`](/windows/desktop/CIMWin32Prov/win32shutdown-method-in-class-win32-operatingsystem)
method of the [`Win32_OperatingSystem`](/windows/desktop/CIMWin32Prov/win32-operatingsystem) WMI
class. This method requires the `SeShutdownPrivilege` privilege be enabled for the user account
used to shutdown the machine.

## RELATED LINKS

[Add-Computer](Add-Computer.md)

[Checkpoint-Computer](Checkpoint-Computer.md)

[Remove-Computer](Remove-Computer.md)

[Rename-Computer](Rename-Computer.md)

[Restart-Computer](Restart-Computer.md)

[Restore-Computer](Restore-Computer.md)

[Test-Connection](Test-Connection.md)
