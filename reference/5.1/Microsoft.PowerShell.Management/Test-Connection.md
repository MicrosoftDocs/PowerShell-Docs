---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 07/31/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/test-connection?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Test-Connection
---

# Test-Connection

## SYNOPSIS
Sends ICMP echo request packets, or pings, to one or more computers.

## SYNTAX

### Default (Default)

```
Test-Connection [-AsJob] [-DcomAuthentication <AuthenticationLevel>] [-WsmanAuthentication <String>]
 [-Protocol <String>] [-BufferSize <Int32>] [-ComputerName] <String[]> [-Count <Int32>]
 [-Impersonation <ImpersonationLevel>] [-ThrottleLimit <Int32>] [-TimeToLive <Int32>]
 [-Delay <Int32>] [<CommonParameters>]
```

### Source

```
Test-Connection [-AsJob] [-DcomAuthentication <AuthenticationLevel>] [-WsmanAuthentication <String>]
 [-Protocol <String>] [-BufferSize <Int32>] [-ComputerName] <String[]> [-Count <Int32>]
 [-Credential <PSCredential>] [-Source] <String[]> [-Impersonation <ImpersonationLevel>]
 [-ThrottleLimit <Int32>] [-TimeToLive <Int32>] [-Delay <Int32>] [<CommonParameters>]
```

### Quiet

```
Test-Connection [-DcomAuthentication <AuthenticationLevel>] [-WsmanAuthentication <String>]
 [-Protocol <String>] [-BufferSize <Int32>] [-ComputerName] <String[]> [-Count <Int32>]
 [-Impersonation <ImpersonationLevel>] [-TimeToLive <Int32>] [-Delay <Int32>] [-Quiet]
 [<CommonParameters>]
```

## DESCRIPTION

The `Test-Connection` cmdlet sends Internet Control Message Protocol (ICMP) echo request packets,
or pings, to one or more remote computers and returns the echo response replies. You can use this
cmdlet to determine whether a particular computer can be contacted across an IP network.

You can use the parameters of `Test-Connection` to specify both the sending and receiving
computers, to run the command as a background job, to set a time-out and number of pings, and to
configure the connection and authentication.

Unlike the familiar **ping** command, `Test-Connection` returns a **Win32_PingStatus** object that
you can investigate in PowerShell. The **Quiet** parameter returns a **Boolean** value in a
**System.Boolean** object for each tested connection. If multiple connections are tested, an array
of **Boolean** values is returned.

## EXAMPLES

### Example 1: Send echo requests to a remote computer

This example sends echo request packets from the local computer to the Server01 computer.

```powershell
Test-Connection -ComputerName Server01
```

```Output
Source        Destination     IPV4Address     IPV6Address  Bytes    Time(ms)
------        -----------     -----------     -----------  -----    --------
ADMIN1        Server01         10.59.137.44                32       0
ADMIN1        Server01         10.59.137.44                32       0
ADMIN1        Server01         10.59.137.44                32       0
ADMIN1        Server01         10.59.137.44                32       1
```

`Test-Connection` uses the **ComputerName** parameter to specify the Server01 computer.

### Example 2: Send echo requests to several computers

This example sends pings from the local computer to several remote computers.

```powershell
Test-Connection -ComputerName Server01, Server02, Server12
```

### Example 3: Send echo requests from several computers to a computer

This example sends pings from different source computers to a single remote computer, Server01.

```powershell
Test-Connection -Source Server02, Server12, localhost -ComputerName Server01 -Credential Domain01\Admin01
```

`Test-Connection` uses the **Credential** parameter to specify the credentials of a user who has
permission to send a ping request from the source computers. Use this command format to test the
latency of connections from multiple points.

### Example 4: Use parameters to customize the test command

This example uses the parameters of `Test-Connection` to customize the command. The local computer
sends a ping test to a remote computer.

```powershell
Test-Connection -ComputerName Server01 -Count 3 -Delay 2 -TTL 255 -BufferSize 256 -ThrottleLimit 32
```

`Test-Connection` uses the **ComputerName** parameter to specify Server01. The **Count** parameter
specifies three pings are sent to the Server01 computer with a **Delay** of 2-second intervals.

You might use these options when the ping response is expected to take longer than usual, either
because of an extended number of hops or a high-traffic network condition.

### Example 5: Run a test as a background job

This example shows how to run a `Test-Connection` command as a PowerShell background job.

```powershell
$job = Test-Connection -ComputerName (Get-Content Servers.txt) -AsJob
if ($job.JobStateInfo.State -ne "Running") {$Results = Receive-Job $job}
```

The `Test-Connection` command pings many computers in an enterprise. The value of the
**ComputerName** parameter is a `Get-Content` command that reads a list of computer names from the
`Servers.txt file`. The command uses the **AsJob** parameter to run the command as a background job
and it saves the job in the `$job` variable.

The `if` command checks to see that the job isn't still running. If the job isn't running,
`Receive-Job` gets the results and stores them in the `$Results` variable.

### Example 6: Ping a remote computer with credentials

This command uses the `Test-Connection` cmdlet to ping a remote computer.

```powershell
Test-Connection Server55 -Credential Domain55\User01 -Impersonation Identify
```

The command uses the **Credential** parameter to specify a user account that has permission to ping
the remote computer and the **Impersonation** parameter to change the impersonation level to
**Identify**.

### Example 7: Create a session only if a connection test succeeds

This example creates a session on the Server01 computer only if at least one of the pings sent to
the computer succeeds.

```powershell
if (Test-Connection -ComputerName Server01 -Quiet) {New-PSSession Server01}
```

The `if` command uses the `Test-Connection` cmdlet to ping the Server01 computer. The command uses
the **Quiet** parameter, which returns a **Boolean** value, instead of a **Win32_PingStatus**
object. The value is `$True` if any of the four pings succeed and is, otherwise, `$False`.

If the `Test-Connection` command returns a value of `$True`, the command uses the `New-PSSession`
cmdlet to create the **PSSession**.

## PARAMETERS

### -AsJob

Indicates that this cmdlet runs as a background job. When you specify the **AsJob** parameter, the
command immediately returns an object that represents the background job. You can continue to work
in the session while the job finishes. To get the job results, use the `Receive-Job` cmdlet.

For more information about PowerShell background jobs, see
[about_Jobs](../Microsoft.PowerShell.Core/About/about_jobs.md) and
[about_Remote_Jobs](../Microsoft.PowerShell.Core/About/about_remote_jobs.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Default, Source
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BufferSize

Specifies the size, in bytes, of the buffer sent with this command. The default value is 32.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: Size, Bytes, BS

Required: False
Position: Named
Default value: 32
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName

Specifies the computers to ping. Type the computer names or type IP addresses in IPv4 or IPv6
format. Wildcard characters are not permitted. This parameter is required.

This parameter doesn't rely on PowerShell remoting. You can use the **ComputerName** parameter even
if your computer isn't configured to run remote commands.

> [!NOTE]
> The **ComputerName** parameter is renamed to **TargetName** in PowerShell 6.0 and above.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: CN, IPAddress, __SERVER, Server, Destination

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Count

Specifies the number of echo requests to send. The default value is 4.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 4
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to send a ping request from the source computer. Type a
user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one from
the `Get-Credential` cmdlet.

The **Credential** parameter is valid only when the **Source** parameter is used in the command. The
credentials don't affect the destination computer.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: Source
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -DcomAuthentication

Specifies the authentication level that this cmdlet uses with WMI.
`Test-Connection` uses WMI.
The acceptable values for this parameter are:

- **Default**. Windows Authentication
- **None**. No COM authentication
- **Connect**. Connect-level COM authentication
- **Call**. Call-level COM authentication
- **Packet**. Packet-level COM authentication
- **PacketIntegrity**. Packet Integrity-level COM authentication
- **PacketPrivacy**. Packet Privacy-level COM authentication
- **Unchanged**. Same as the previous command

The default value is **Packet** that has an enumerated value of **4**. For more information about
the values of this parameter, see
[AuthenticationLevel](/dotnet/api/system.management.authenticationlevel) enumeration.

```yaml
Type: System.Management.AuthenticationLevel
Parameter Sets: (All)
Aliases: Authentication
Accepted values: Default, None, Connect, Call, Packet, PacketIntegrity, PacketPrivacy, Unchanged

Required: False
Position: Named
Default value: Packet (enumerated value of 4)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delay

Specifies the interval between pings, in seconds.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1 (second)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Impersonation

Specifies the impersonation level to use when this cmdlet calls WMI. `Test-Connection` uses WMI.

The acceptable values for this parameter are as follows:

- **Default**. Default impersonation.
- **Anonymous**. Hides the identity of the caller.
- **Identify**. Allows objects to query the credentials of the caller.
- **Impersonate**. Allows objects to use the credentials of the caller.

The default value is **Impersonate**.

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

Specifies a protocol. The acceptable values for this parameter are DCOM and WSMan.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: DCOM, WSMan

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quiet

The **Quiet** parameter returns a **Boolean** value in a **System.Boolean** object. Using this
parameter suppresses all errors.

Each connection that's tested returns a **Boolean** value. If the **ComputerName** parameter
specifies multiple computers, an array of **Boolean** values is returned.

If **any** ping succeeds, `$True` is returned.

If **all** pings fail, `$False` is returned.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Quiet
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

Specifies the names of the computers where the ping originates. Enter a comma-separated list of
computer names. The default is the local computer.

```yaml
Type: System.String[]
Parameter Sets: Source
Aliases: FCN, SRC

Required: True
Position: 1
Default value: Local computer
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit

Specifies the maximum number of concurrent connections that can be established to run this command.
If you omit this parameter or enter a value of 0, the default value, 32, is used.

The throttle limit applies only to the current command, not to the session or to the computer.

```yaml
Type: System.Int32
Parameter Sets: Default, Source
Aliases:

Required: False
Position: Named
Default value: 32
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeToLive

Specifies the maximum times a packet can be forwarded. For every hop in gateways, routers etc. the
**TimeToLive** value is decreased by one. At zero the packet is discarded and an error is returned.
In **Windows**, The default value is **128**. The alias of the **TimeToLive** parameter is **TTL**.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: TTL

Required: False
Position: Named
Default value: 128 in Windows
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

For more information about the values of this parameter, see
[AuthenticationMechanism Enumeration](/dotnet/api/system.management.automation.runspaces.authenticationmechanism?view=powershellsdk-1.1.0).

Caution: Credential Security Service Provider (CredSSP) authentication, in which the user credentials are passed to a remote computer to be authenticated, is designed for commands that require authentication on more than one resource, such as accessing a remote network share.
This mechanism increases the security risk of the remote operation.
If the remote computer is compromised, the credentials that are passed to it can be used to control the network session.

This parameter was introduced in Windows PowerShell 3.0.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### System.Management.ManagementObject#root\cimv2\Win32_PingStatus

By default, this cmdlet returns a **Win32_PingStatus** object for each ping reply.

### System.Management.Automation.RemotingJob

This cmdlet returns a job object, if you specify the **AsJob** parameter.

### System.Boolean

When you use the **Quiet** parameter, this returns a **Boolean** value. If the cmdlet tests
multiple connections, it returns an array of **Boolean** values.

## NOTES

This cmdlet uses the **Win32_PingStatus** class. A `Get-WMIObject Win32_PingStatus` command is
equivalent to a `Test-Connection` command.

The **Source** parameter set was introduced in PowerShell 3.0.

## RELATED LINKS

[Add-Computer](Add-Computer.md)

[Restart-Computer](Restart-Computer.md)

[Stop-Computer](Stop-Computer.md)
