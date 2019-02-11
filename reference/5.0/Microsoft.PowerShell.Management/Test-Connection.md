---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821646
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Test-Connection
---
# Test-Connection

## SYNOPSIS
Sends ICMP echo request packets ("pings") to one or more computers.

## SYNTAX

### Default (Default)

```
Test-Connection [-ComputerName] <string[]> [-AsJob] [-Authentication <AuthenticationLevel>]
  [-BufferSize <int>] [-Count <int>] [-Impersonation <ImpersonationLevel>] [-ThrottleLimit <int>]
  [-TimeToLive <int>] [-Delay <int>] [<CommonParameters>]
```

### Source

```
Test-Connection [-ComputerName] <string[]> [-Source] <string[]> [-AsJob] [-Authentication <AuthenticationLevel>]
  [-BufferSize <int>] [-Count <int>] [-Credential <pscredential>] [-Impersonation <ImpersonationLevel>]
  [-ThrottleLimit <int>] [-TimeToLive <int>] [-Delay <int>] [<CommonParameters>]
```

### Quiet

```
Test-Connection [-ComputerName] <string[]> [-Authentication <AuthenticationLevel>] [-BufferSize<int>]
  [-Count <int>] [-Impersonation <ImpersonationLevel>] [-TimeToLive <int>] [-Delay <int>]
  [-Quiet] [<CommonParameters>]
```

## DESCRIPTION

The `Test-Connection` cmdlet sends Internet Control Message Protocol (ICMP) echo request packets,
or pings, to one or more remote computers and returns the echo response replies. You can use this
cmdlet to determine whether a particular computer can be contacted across an IP network.

You can use the parameters of `Test-Connection` to specify both the sending and receiving
computers, to run the command as a background job, to set a time-out and number of pings, and to
configure the connection and authentication.

Unlike the familiar **ping** command, `Test-Connection` returns a **Win32_PingStatus** object
that you can investigate in Windows PowerShell. You can use the **Quiet** parameter to force it to
return only a **Boolean** value.

## EXAMPLES

### Example 1: Send echo requests to a remote computer

This command sends echo request packets from the local computer to the Server01 computer.

```powershell
Test-Connection Server01
```

```Output
Source        Destination     IPV4Address     IPV6Address  Bytes    Time(ms)
------        -----------     -----------     -----------  -----    --------
ADMIN1        Server01         10.59.137.44                32       0
ADMIN1        Server01         10.59.137.44                32       0
ADMIN1        Server01         10.59.137.44                32       0
ADMIN1        Server01         10.59.137.44                32       1
```

This command uses the **ComputerName** parameter to specify the Server01 computer, but omits the
optional parameter name.

### Example 2: Send echo requests to several computers

This command sends pings from the local computer to several remote computers.

```powershell
Test-Connection -ComputerName Server01, Server02, Server12
```

### Example 3: Send echo requests from several computers to a computer

This command sends pings from different source computers to a single remote computer, Server01.

```powershell
Test-Connection -Source Server02, Server12, localhost -ComputerName Server01 -Credential Domain01\Admin01
```

It uses the **Credential** parameter to specify the credentials of a user who has permission to
send a ping request from the source computers. Use this command format to test the latency of
connections from multiple points.

### Example 4: Customize the test command

It uses the parameters of `Test-Connection` to customize the command.

```powershell
Test-Connection -ComputerName Server01 -Count 3 -Delay 2 -TTL 255 -BufferSize 256 -ThrottleLimit 32
```

This command sends three pings from the local computer to the Server01 computer.

Use this command format when the ping response is expected to take longer than usual, either
because of an extended number of hops or a high-traffic network condition.

### Example 5: Run a test as a background job

This example shows how to run a `Test-Connection` command as a PowerShell background job.

```powershell
$job = Test-Connection -ComputerName (Get-Content Servers.txt) -AsJob
if ($job.JobStateInfo.State -ne "Running") {$Results = Receive-Job $job}
```

The first command uses the `Test-Connection` cmdlet to ping many computers in an enterprise. The
value of the **ComputerName** parameter is a Get-Content command that reads a list of computer names
from the Servers.txt file. The command uses the **AsJob** parameter to run the command as a
background job and it saves the job in the `$job` variable.

The second command checks to see that the job is not still running, and if it is not, it uses a
`Receive-Job` command to get the results and store them in the `$Results` variable.

### Example 6: Ping a remote computer with credentials

This command uses the `Test-Connection` cmdlet to ping a remote computer.

```powershell
Test-Connection Server55 -Credential Domain55\User01 -Impersonation Identify
```

The command uses the **Credential** parameter to specify a user account that has permission to ping
the remote computer and the **Impersonation** parameter to change the impersonation level to
**Identify**.

### Example 7: Create a session only if a connection test succeeds

This command creates a session on the Server01 computer only if at least one of the pings sent to
the computer succeeds.

```powershell
if (Test-Connection -ComputerName Server01 -Quiet) {New-PSSession Server01}
```

The command uses the `Test-Connection` cmdlet to ping the Server01 computer. The command uses the
**Quiet** parameter, which returns a **Boolean** value, instead of a **Win32_PingStatus** object. The
value is `$True` if any of the four pings succeed and is, otherwise, `$False`.

If the `Test-Connection` command returns a value of `$True`, the command uses the `New-PSSession`
cmdlet to create the **PSSession**.

## PARAMETERS

### -AsJob

Indicates that this cmdlet runs as a background job.

To use this parameter, the local and remote computers must be configured for remoting and, on
Windows Vista and later versions of the Windows operating system, you must open Windows PowerShell
by using the Run as administrator option. For more information, see about_Remote_Requirements.

When you specify the **AsJob** parameter, the command immediately returns an object that represents
the background job. You can continue to work in the session while the job finishes. The job is
created on the local computer and the results from remote computers are automatically returned to
the local computer. To get the job results, use the `Receive-Job` cmdlet.

For more information about Windows PowerShell background jobs, see about_Jobs and about_Remote_Jobs.

```yaml
Type: SwitchParameter
Parameter Sets: Default, Source
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BufferSize

Specifies the size, in bytes, of the buffer sent with this command.
The default value is 32.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Size, Bytes, BS

Required: False
Position: Named
Default value: 32
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName

Specifies the computers to ping.
Type the computer names or type IP addresses in IPv4 or IPv6 format.
Wildcard characters are not permitted.
This parameter is required.

This parameter does not rely on Windows PowerShell remoting.
You can use the **ComputerName** parameter even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: CN, IPAddress, __SERVER, Server, Destination

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Count

Specifies the number of echo requests to send.
The default value is 4.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 4
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to send a ping request from the source computer. Type
a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one
from the `Get-Credential` cmdlet.

The **Credential** parameter is valid only when the **Source** parameter is used in the command.
The credentials do not affect the destination computer.

```yaml
Type: PSCredential
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

- Default. Windows Authentication
- None. No COM authentication
- Connect. Connect-level COM authentication
- Call. Call-level COM authentication
- Packet. Packet-level COM authentication
- PacketIntegrity. Packet Integrity-level COM authentication
- PacketPrivacy. Packet Privacy-level COM authentication
- Unchanged. Same as the previous command

The default value is Packet.

For more information about the values of this parameter, see
[AuthenticationLevel Enumeration](/dotnet/api/system.management.authenticationlevel?view=netframework-4.7.2).

```yaml
Type: AuthenticationLevel
Parameter Sets: (All)
Aliases: Authentication
Accepted values: Default, None, Connect, Call, Packet, PacketIntegrity, PacketPrivacy, Unchanged

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delay

Specifies the interval between pings, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1 (second)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Impersonation

Specifies the impersonation level to use when this cmdlet calls WMI.
`Test-Connection` uses WMI.
The acceptable values for this parameter are:

- Default. Default impersonation.
- Anonymous. Hides the identity of the caller.
- Identify. Allows objects to query the credentials of the caller.
- Impersonate. Allows objects to use the credentials of the caller.

The default value is Impersonate.

```yaml
Type: ImpersonationLevel
Parameter Sets: (All)
Aliases:
Accepted values: Default, Anonymous, Identify, Impersonate, Delegate

Required: False
Position: Named
Default value: Impersonate
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quiet

Indicates that this cmdlet suppresses all errors.
If any pings succeed, this cmdlet returns `$True`.
If all pings fail, this cmdlet returns `$False`.

```yaml
Type: SwitchParameter
Parameter Sets: Quiet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

Specifies the names of the computers where the ping originates.
Enter a comma-separated list of computer names.
The default is the local computer.

```yaml
Type: String[]
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
Type: Int32
Parameter Sets: Default, Source
Aliases:

Required: False
Position: Named
Default value: 32
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeToLive

Specifies the maximum times a packet can be forwarded. For every hop in gateways, routers etc.
the **TimeToLive** value is decreased by one. At zero the packet is discarded and an error is returned.
The default value (in Windows) is 128.
The alias of the **TimeToLive** parameter is **TTL**.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TTL

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.ManagementObject#root\cimv2\Win32_PingStatus, System.Management.Automation.RemotingJob, System.Boolean

This cmdlet returns a job object, if you specify the **AsJob** parameter.
If you specify the **Quiet** parameter, it returns a **Boolean**.
Otherwise, this cmdlet returns a **Win32_PingStatus** object for each ping.

## NOTES

This cmdlet uses the **Win32_PingStatus** class. A `Get-WMIObject Win32_PingStatus` command is
equivalent to a `Test-Connection` command.

The **Source** parameter set was introduced in Windows PowerShell 3.0.

## RELATED LINKS

[Add-Computer](Add-Computer.md)

[Restart-Computer](Restart-Computer.md)

[Stop-Computer](Stop-Computer.md)