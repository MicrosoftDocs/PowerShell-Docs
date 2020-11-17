---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 12/12/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/test-connection?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Test-Connection
---

# Test-Connection

## SYNOPSIS
Sends ICMP echo request packets, or pings, to one or more computers.

## SYNTAX

### DefaultPing (Default)

```
Test-Connection [-TargetName] <string[]> [-Ping] [-IPv4] [-IPv6] [-ResolveDestination]
 [-Source <string>] [-MaxHops <int>] [-Count <int>] [-Delay <int>] [-BufferSize <int>]
 [-DontFragment] [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

### RepeatPing

```
Test-Connection [-TargetName] <string[]> -Repeat [-Ping] [-IPv4] [-IPv6] [-ResolveDestination]
 [-Source <string>] [-MaxHops <int>] [-Delay <int>] [-BufferSize <int>] [-DontFragment]
 [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

### MtuSizeDetect

```
Test-Connection [-TargetName] <string[]> -MtuSize [-IPv4] [-IPv6] [-ResolveDestination]
 [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

### TraceRoute

```
Test-Connection [-TargetName] <string[]> -Traceroute [-IPv4] [-IPv6] [-ResolveDestination]
 [-Source <string>] [-MaxHops <int>] [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

### TcpPort

```
Test-Connection [-TargetName] <string[]> -TcpPort <int> [-IPv4] [-IPv6] [-ResolveDestination]
 [-Source <string>] [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

## DESCRIPTION

The `Test-Connection` cmdlet sends Internet Control Message Protocol (ICMP) echo request packets, or
pings, to one or more remote computers and returns the echo response replies. You can use this
cmdlet to determine whether a particular computer can be contacted across an IP network.

You can use the parameters of `Test-Connection` to specify both the sending and receiving computers,
to run the command as a background job, to set a time-out and number of pings, and to configure the
connection and authentication.

Unlike the familiar **ping** command, `Test-Connection` returns a
**TestConnectionCommand+PingStatus** object that you can investigate in PowerShell. The **Quiet**
parameter returns a **Boolean** value in a **System.Boolean** object for each tested connection. If
multiple connections are tested, an array of **Boolean** values is returned.

## EXAMPLES

### Example 1: Send echo requests to a remote computer

This example sends echo request packets from the local computer to the Server01 computer.

```powershell
Test-Connection -TargetName Server01 -IPv4
```

```Output
   Destination: Server01

Ping Source           Address                   Latency BufferSize Status
                                                   (ms)        (B)
---- ------           -------                   ------- ---------- ------
   1 ADMIN1           10.59.137.44                   24         32 Success
   2 ADMIN1           10.59.137.44                   39         32 Success
   3 ADMIN1           *                               *          * TimedOut
   4 ADMIN1           10.59.137.44                   28         32 Success
```

`Test-Connection` uses the **TargetName** parameter to specify the Server01 computer. The **IPv4**
parameter specifies the protocol for the test.

A series of **TestConnectionCommand+PingStatus** objects are sent to the output stream, one
object per ping reply from the target machine.

### Example 2: Send echo requests to several computers

This example sends pings from the local computer to several remote computers.

```powershell
Test-Connection -TargetName Server01, Server02, Server12
```

### Example 3: Use parameters to customize the test command

This example uses the parameters of `Test-Connection` to customize the command. The local computer
sends a ping test to a remote computer.

```powershell
Test-Connection -TargetName Server01 -Count 3 -Delay 2 -MaxHops 255 -BufferSize 256
```

`Test-Connection` uses the **TargetName** parameter to specify Server01. The **Count** parameter
specifies three pings are sent to the Server01 computer with a **Delay** of 2-second intervals.

You might use these options when the ping response is expected to take longer than usual, either
because of an extended number of hops or a high-traffic network condition.

### Example 4: Run a test as a background job

This example shows how to run a `Test-Connection` command as a PowerShell background job.

```powershell
$job = Start-Job -ScriptBlock { Test-Connection -TargetName (Get-Content -Path "Servers.txt") }
$Results = Receive-Job $job -Wait
```

The `Start-Job` command uses the `Test-Connection` cmdlet to ping many computers in an enterprise.
The value of the **TargetName** parameter is a `Get-Content` command that reads a list of computer
names from the `Servers.txt` file. The command uses the `Start-Job` cmdlet to run the command as a
background job and it saves the job in the `$job` variable.

The `Receive-Job` command is instructed to `-Wait` until the job is completed, and then gets the
results and stores them in the `$Results` variable.

### Example 5: Create a session only if a connection test succeeds

This example creates a session on the Server01 computer only if at least one of the pings sent to
the computer succeeds.

```powershell
if (Test-Connection -TargetName Server01 -Quiet) { New-PSSession -ComputerName Server01 }
```

The `Test-Connection` cmdlet pings the `Server01` computer, with the **Quiet** parameter provided.
The resulting value is `$True` if any of the four pings succeed. If none of the pings succeed,
the value is `$False`.

If the `Test-Connection` command returns a value of `$True`, the command uses the `New-PSSession`
cmdlet to create the **PSSession**.

### Example 6: Use the Traceroute parameter

Introduced in PowerShell 6.0, the **Traceroute** parameter maps a route between the local computer
and the remote destination you specify with the **TargetName** parameter.

```powershell
Test-Connection -TargetName www.google.com -Traceroute
```

```Output
   Target: google.com

Hop Hostname                  Ping Latency Status           Source       TargetAddress
                                      (ms)
--- --------                  ---- ------- ------           ------       -------------
  1 172.20.0.1                   1       4 Success          Lira         172.217.9.174
  1 172.20.0.1                   2       3 Success          Lira         172.217.9.174
  1 172.20.0.1                   3       2 Success          Lira         172.217.9.174
  2 12.108.153.193               1       3 Success          Lira         172.217.9.174
  2 12.108.153.193               2       3 Success          Lira         172.217.9.174
  2 12.108.153.193               3       2 Success          Lira         172.217.9.174
  3 12.244.85.177                1      11 Success          Lira         172.217.9.174
  3 12.244.85.177                2      12 Success          Lira         172.217.9.174
  3 12.244.85.177                3      12 Success          Lira         172.217.9.174
  4 *                            1      14 DestinationNetw… Lira         172.217.9.174
  4 *                            2       * TimedOut         Lira         172.217.9.174
  4 *                            3      20 DestinationNetw… Lira         172.217.9.174
  5 *                            1       * TimedOut         Lira         172.217.9.174
  5 *                            2      15 DestinationNetw… Lira         172.217.9.174
  5 *                            3       * TimedOut         Lira         172.217.9.174
  6 *                            1      18 DestinationNetw… Lira         172.217.9.174
  6 *                            2       * TimedOut         Lira         172.217.9.174
  6 *                            3      16 DestinationNetw… Lira         172.217.9.174
  7 *                            1       * TimedOut         Lira         172.217.9.174
  7 *                            2       * TimedOut         Lira         172.217.9.174
  7 *                            3       * TimedOut         Lira         172.217.9.174
  8 *                            1       * TimedOut         Lira         172.217.9.174
  8 *                            2       * TimedOut         Lira         172.217.9.174
  8 *                            3       * TimedOut         Lira         172.217.9.174
  9 *                            1       * TimedOut         Lira         172.217.9.174
  9 *                            2       * TimedOut         Lira         172.217.9.174
  9 *                            3       * TimedOut         Lira         172.217.9.174
 10 *                            1       * TimedOut         Lira         172.217.9.174
 10 *                            2       * TimedOut         Lira         172.217.9.174
 10 *                            3       * TimedOut         Lira         172.217.9.174
 11 172.217.9.174                1      23 Success          Lira         172.217.9.174
 11 172.217.9.174                2      21 Success          Lira         172.217.9.174
 11 172.217.9.174                3      22 Success          Lira         172.217.9.174
```

The `Test-Connection` command is called with the **Traceroute** parameter. The results, which are
`[Microsoft.PowerShell.Commands.TestConnectionCommand+TraceStatus]` objects, are output to
the **Success** output stream.

## PARAMETERS

### -BufferSize

Specifies the size, in bytes, of the buffer sent with this command. The default value is 32.

```yaml
Type: System.Int32
Parameter Sets: DefaultPing, RepeatPing
Aliases: Size, Bytes, BS

Required: False
Position: Named
Default value: 32
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repeat

Causes the cmdlet to send ping requests continuously. This parameter can't be used with the
**Count** parameter.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: RepeatPing
Aliases: Continuous

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Count

Specifies the number of echo requests to send. The default value is 4.

```yaml
Type: System.Int32
Parameter Sets: DefaultPing
Aliases:

Required: False
Position: Named
Default value: 4
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delay

Specifies the interval between pings, in seconds.

```yaml
Type: System.Int32
Parameter Sets: DefaultPing, RepeatPing
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DontFragment

This parameter sets the **Don't Fragment** flag in the IP header. You can use this parameter with
the **BufferSize** parameter to test the Path MTU size. For more information about Path MTU, see the
[Path MTU Discovery](https://wikipedia.org/wiki/Path_MTU_Discovery) article in wikipedia.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: DefaultPing, RepeatPing
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPv4

Forces the cmdlet to use the IPv4 protocol for the test.

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

### -IPv6

Forces the cmdlet to use the IPv6 protocol for the test.

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

### -MaxHops

Sets the maximum number of hops that an ICMP request message can be sent. The default value is
controlled by the operating system. The default value for Windows 10 is 128 hops.

```yaml
Type: System.Int32
Parameter Sets: DefaultPing, RepeatPing, TraceRoute
Aliases: Ttl, TimeToLive, Hops

Required: False
Position: Named
Default value: 128 hops in Windows 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ping

Causes the cmdlet to do a ping test. This is the default mode for the `Test-Connection` cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: DefaultPing, RepeatPing
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quiet

The **Quiet** parameter returns a **Boolean** value. Using this parameter suppresses all
errors.

Each connection that's tested returns a **Boolean** value. If the **TargetName** parameter
specifies multiple computers, an array of **Boolean** values is returned.

If **any** ping to a given target succeeds, `$True` is returned.

If **all** pings to a given target fail, `$False` is returned.

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

### -ResolveDestination

Causes the cmdlet to attempt to resolve the DNS name of the target. When used in conjunction
with the **Traceroute** parameter, the DNS names of all intermediate hosts will also be
retrieved, if possible.

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

### -Source

Specifies the names of the computers where the ping originates. Enter a comma-separated list of
computer names. The default is the local computer.

**NOTE:** This parameter is not functional in PowerShell versions 6 and up.
Supplying this parameter will have no effect on the command.

```yaml
Type: System.String
Parameter Sets: DefaultPing, RepeatPing, TraceRoute, TcpPort
Aliases:

Required: False
Position: Named
Default value: Local computer
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetName

Specifies the computer(s) to test. Type the computer names or type IP addresses in IPv4 or IPv6
format.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: ComputerName

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TimeoutSeconds

Sets the timeout value for the test. The test fails if a response isn't received before the timeout
expires. The default is five seconds.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 5 seconds
Accept pipeline input: False
Accept wildcard characters: False
```

### -Traceroute

Causes the cmdlet to do a traceroute test. When this parameter is used, the cmdlet returns a
`TestConnectionCommand+TraceStatus` object.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: TraceRoute
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MtuSize

This parameter is used to discover the Path MTU size. The cmdlet returns a **PingReply#MTUSize**
object that contains the Path MTU size to the target. For more information about Path MTU, see the
[Path MTU Discovery](https://wikipedia.org/wiki/Path_MTU_Discovery) article in wikipedia.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: MtuSizeDetect
Aliases: MtuSizeDetect

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TcpPort

Specifies the TCP port number on the target to be used in the TCP connection test. The cmdlet will
attempt to make a TCP connection to the specified port on the target.

If a connection can be made, `$True` will be returned.

If a connection cannot be made, `$False` will be returned.

```yaml
Type: System.Int32
Parameter Sets: TcpPort
Aliases:

Required: True
Position: Named
Default value: None
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

You can't pipe input to this cmdlet.

## OUTPUTS

### TestConnectionCommand+PingStatus, TestConnectionCommand+TraceStatus, Boolean, TestConnectionCommand+PingMtuStatus

By default, `Test-Connection` returns a **TestConnectionCommand+PingStatus** object for each
ping reply.

If you specify the **Traceroute** parameter, the cmdlet will return a
**TestConnectionCommand+TraceStatus** object for each ping reply along the route.

If you specify the **Quiet** or **TcpPort** parameters, it returns a **Boolean** value. If
multiple connections are tested, an array of **Boolean** values is returned.

## NOTES

## RELATED LINKS

[Restart-Computer](Restart-Computer.md)

[Stop-Computer](Stop-Computer.md)

