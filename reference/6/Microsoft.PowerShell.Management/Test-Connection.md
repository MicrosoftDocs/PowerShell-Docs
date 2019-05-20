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

### PingCount (Default)

```
Test-Connection [-TargetName] <string[]> [-Ping] [-IPv4] [-IPv6] [-ResolveDestination]
  [-Source <string>] [-MaxHops <int>] [-Count <int>] [-Delay <int>] [-BufferSize <int>]
  [-DontFragment] [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

### PingContinues

```
Test-Connection [-TargetName] <string[]> [-Ping] [-IPv4] [-IPv6] [-ResolveDestination]
  [-Source <string>] [-MaxHops <int>] [-Delay <int>] [-BufferSize <int>] [-DontFragment]
  [-Continues] [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

### DetectionOfMTUSize

```
Test-Connection [-TargetName] <string[]> -MTUSizeDetect [-IPv4] [-IPv6] [-ResolveDestination]
  [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

### TraceRoute

```
Test-Connection [-TargetName] <string[]> -Traceroute [-IPv4] [-IPv6] [-ResolveDestination]
  [-Source <string>] [-MaxHops <int>] [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

### ConnectionByTCPPort

```
Test-Connection [-TargetName] <string[]> -TCPPort <int> [-IPv4] [-IPv6] [-ResolveDestination]
  [-Source <string>] [-TimeoutSeconds <int>] [-Quiet] [<CommonParameters>]
```

## DESCRIPTION

The `Test-Connection` cmdlet sends Internet Control Message Protocol (ICMP) echo request packets,
or pings, to one or more remote computers and returns the echo response replies. You can use this
cmdlet to determine whether a particular computer can be contacted across an IP network.

You can use the parameters of `Test-Connection` to specify both the sending and receiving
computers, to run the command as a background job, to set a time-out and number of pings, and to
configure the connection and authentication.

Unlike the familiar **ping** command, `Test-Connection` returns a
**TestConnectionCommand+PingReport**. You can use the **Quiet** parameter to force it to return
only a **Boolean** value.

## EXAMPLES

### Example 1: Send echo requests to a remote computer

This command sends echo request packets from the local computer to the Server01 computer.

```powershell
Test-Connection Server01 -IPv4
```

```Output
Pinging Server01 [10.59.137.44] with 32 bytes of data:
Reply from 10.59.137.44: bytes=32 time=0ms TTL=128
Reply from 10.59.137.44: bytes=32 time=0ms TTL=128
Reply from 10.59.137.44: bytes=32 time=0ms TTL=128
Reply from 10.59.137.44: bytes=32 time=0ms TTL=128
Ping complete.

Source     Destination Replies
------     ----------- -------
Server01   Server01    {System.Net.NetworkInformation.PingReply, System.Net.NetworkInformation.PingReply, System.Ne...
```

This command uses the **TargetName** parameter to specify the Server01 computer, but omits the
optional parameter name. In the example above, the ping output is sent to the **Information**
stream while the **TestConnectionCommand+PingReport** object sent to the **Success** stream. For
more information about the output streams, see
[about_Redirection](../microsoft.powershell.core/about/about_redirection.md).

### Example 2: Send echo requests to several computers

This command sends pings from the local computer to several remote computers.

```powershell
Test-Connection -ComputerName Server01, Server02, Server12
```

### Example 3: Send echo requests from several computers to a computer

This command sends pings from different source computers to a single remote computer, Server01.

```powershell
Test-Connection -Source "Server02", "Server12", "localhost" -ComputerName "Server01"
```

Use this command format to test the latency of connections from multiple points.

### Example 4: Customize the test command

It uses the parameters of `Test-Connection` to customize the command.

```powershell
Test-Connection -ComputerName Server01 -Count 3 -Delay 2 -MaxHops 255 -BufferSize 256 -ThrottleLimit 32
```

This command sends three pings from the local computer to the Server01 computer at 2-second
intervals.

You might use these options when the ping response is expected to take longer than usual, either
because of an extended number of hops or a high-traffic network condition.

### Example 5: Run a test as a background job

This example shows how to run a `Test-Connection` command as a PowerShell background job.

```powershell
$job = Start-Job -ScriptBlock { Test-Connection -TargetName (Get-Content "Servers.txt") }
if ($job.JobStateInfo.State -ne "Running") { $Results = Receive-Job $job }
```

The first command uses the `Test-Connection` cmdlet to ping many computers in an enterprise. The
value of the **TargetName** parameter is a `Get-Content` command that reads a list of computer
names from the Servers.txt file. The command uses the `Start-Job` cmdlet to run the command as a
background job and it saves the job in the `$job` variable.

The second command checks to see that the job is not still running, and if it is not, it uses a
`Receive-Job` command to get the results and store them in the `$Results` variable.

### Example 6: Create a session only if a connection test succeeds

This command creates a session on the Server01 computer only if at least one of the pings sent to
the computer succeeds.

```powershell
if (Test-Connection -TargetName Server01 -Quiet) {New-PSSession Server01}
```

The command uses the `Test-Connection` cmdlet to ping the Server01 computer. The command uses the
**Quiet** parameter, which returns a **Boolean** value, instead of a
**TestConnectionCommand+PingReport** object.

The value is `$True` if any of the four pings succeed. If none of the pings succeed, the value is
`$False`.

If the `Test-Connection` command returns a value of `$True`, the command uses the `New-PSSession` cmdlet to create the **PSSession**.

### Example 7: Use the Traceroute parameter

Beginning in PowerShell 6.0, the **Traceroute** parameter maps a route between the local computer
and the remote destination you specify to **TargetName**.

```powershell
Test-Connection -TargetName www.microsoft.com -Traceroute | ForEach-Object {
  $_ | Format-Table Source, DestinationAddress, DestinationHost
  $_.Replies | ForEach-Object {
      $_ | Format-Table Hop, ReplyRouterAddress
      $_.PingReplies | Format-Table
  }
}
```

```Output
Tracing route to www.microsoft.com [96.6.27.90] over a maximum of 128 hops:
  1   0 ms   0 ms   0 ms   192.168.0.3 [192.168.0.3]
  2   0 ms   0 ms   0 ms   192.168.1.1 [192.168.1.1]
  3   3 ms   29 ms   4 ms   96.6.27.90 [96.6.27.90]
Trace complete.

Source      DestinationAddress DestinationHost   Replies
------      ------------------ ---------------   -------
SERVER01    96.6.27.90         www.microsoft.com {, , }

Hop ReplyRouterAddress
--- ------------------
  1 192.168.0.3

    Status Address      RoundtripTime Options Buffer
    ------ -------      ------------- ------- ------
TtlExpired 192.168.86.1             0         {}
TtlExpired 192.168.86.1             0         {}
TtlExpired 192.168.86.1             0         {}

Hop ReplyRouterAddress
--- ------------------
  2 192.168.1.1

    Status Address     RoundtripTime Options Buffer
    ------ -------     ------------- ------- ------
TtlExpired 192.168.1.1             0         {}
TtlExpired 192.168.1.1             0         {}
TtlExpired 192.168.1.1             0         {}

Hop ReplyRouterAddress
--- ------------------
  3 96.6.27.90

 Status Address    RoundtripTime Options                                   Buffer
 ------ -------    ------------- -------                                   ------
Success 96.6.27.90             3 System.Net.NetworkInformation.PingOptions {97, 98, 99, 100…}
Success 96.6.27.90             2 System.Net.NetworkInformation.PingOptions {97, 98, 99, 100…}
Success 96.6.27.90             4 System.Net.NetworkInformation.PingOptions {97, 98, 99, 100…}
```

The first command calls the `Test-Connection` cmdlet with the **Traceroute** parameter. The results,
which are `[Microsoft.PowerShell.Commands.TestConnectionCommand+TraceRouteResult]` objects are piped
to the `ForEach-Object` cmdlet, which creates a structured output of the contained
`[Microsoft.PowerShell.Commands.TestConnectionCommand+TraceRouteReply]` objects and subsequent
`[System.Net.NetworkInformation.PingReply]` objects.

## PARAMETERS

### -BufferSize

Specifies the size, in bytes, of the buffer sent with this command.
The default value is 32.

```yaml
Type: Int32
Parameter Sets: PingCount, PingContinues
Aliases: Size, Bytes, BS

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Continues

Causes the cmdlet to send ping requests continuously. This parameter cannot be used with the
**Count** parameter.

```yaml
Type: SwitchParameter
Parameter Sets: PingContinues
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Count

Specifies the number of echo requests to send.
The default value is 4.

```yaml
Type: Int32
Parameter Sets: PingCount
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
Parameter Sets: PingCount, PingContinues
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DontFragment

This parameter sets the "Don't Fragment" flag in the IP header. You can use this parameter with the
**BufferSize** parameter to test the Path MTU size. For more information about Path MTU, see the
[Path MTU Discovery](https://wikipedia.org/wiki/Path_MTU_Discovery) article in wikipedia.

```yaml
Type: SwitchParameter
Parameter Sets: PingCount, PingContinues
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPv4

Forces the cmdlet to use the IPv4 protocol for the test.

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

### -IPv6

Forces the cmdlet to use the IPv6 protocol for the test.

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

### -MaxHops

Sets the maximum number of hops that an ICMP request message can be sent. The default value is
controlled by the operating system. The default value for Windows 10 is 128 hops.

```yaml
Type: Int32
Parameter Sets: PingCount, PingContinues, TraceRoute
Aliases: Ttl

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MTUSizeDetect

This parameter is used to discover the Path MTU size. The cmdlet returns a **PingReply#MTUSize**
object that contains the Path MTU size to the target. For more information about Path MTU, see the
[Path MTU Discovery](https://wikipedia.org/wiki/Path_MTU_Discovery) article in wikipedia.

```yaml
Type: SwitchParameter
Parameter Sets: DetectionOfMTUSize
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ping

Causes the cmdlet to do a ping test. This is the default action.

```yaml
Type: SwitchParameter
Parameter Sets: PingCount, PingContinues
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quiet

Indicates that this cmdlet suppresses errors.
If any ping succeeds, this cmdlet returns `$True`.
If all pings fail, this cmdlet returns `$False`.

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

### -ResolveDestination

Causes the cmdlet to attempt to resolve the DNS name of the target.

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

### -Source

The **Source** is not currently implemented.

```yaml
Type: String
Parameter Sets: PingCount, PingContinues, TraceRoute, ConnectionByTCPPort
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetName

Specifies the computers to test. Type the computer names or type IP addresses in IPv4 or IPv6
format. Wildcard characters are not permitted. This parameter is required.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: ComputerName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TCPPort

Specifies the TCP port number on the target to be used in the TCP connection test. The cmdlet will
attempt to make a TCP connection to the specified port on the target.

```yaml
Type: Int32
Parameter Sets: ConnectionByTCPPort
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeoutSeconds

Sets the timeout value for the test. The test fails if a response is not received before the
timeout expires.

```yaml
Type: Int32
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
`TestConnectionCommand+TraceRouteResult` object.

```yaml
Type: SwitchParameter
Parameter Sets: TraceRoute
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

You cannot pipe input to this cmdlet.

## OUTPUTS

### TestConnectionCommand+PingReport, TestConnectionCommand+TraceRouteResult, Boolean, PingReply#MTUSize

If you specify the **Quiet** parameter, the cmdlet returns a **Boolean** object.
Otherwise, this cmdlet returns the object type specific to the test.

## NOTES

## RELATED LINKS

[Restart-Computer](Restart-Computer.md)

[Stop-Computer](Stop-Computer.md)
