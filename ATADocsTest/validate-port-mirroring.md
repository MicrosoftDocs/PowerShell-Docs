---
# required metadata

title: Validate Port Mirroring | Microsoft ATA
description: Describes how to validate that port mirroring is configured correctly
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: get-started-article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: ebd41719-c91a-4fdd-bcab-2affa2a2cace

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: bennyl
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

*Applies to: Advanced Threat Analytics version 1.7*



# Validate Port Mirroring
> [!NOTE] 
> This article is relevant only if you deploy ATA Gateways instead of ATA Lightweight Gateways. To determine if you need to use ATA Gateways, see [Choosing the right gateways for your deployment](/advanced-threat-analytics/plan-design/ata-capacity-planning#choosing-the-right-gateway-type-for-your-deployment).
 
The following steps walk you through the process for validating that port mirroring is properly configured. For ATA to work properly, the ATA Gateway must be able to see the traffic to and from the domain controller. The main data source used by ATA is deep packet inspection of the network traffic to and from your domain controllers. For ATA to see the network traffic, port mirroring needs to be configured. Port mirroring copies the traffic from one port (the source port) to another port (the destination port).

## Validate port mirroring using a Windows PowerShell script

1. Save the text of this script into a file called *ATAdiag.ps1*.
2. Run this script on the ATA Gateway that you want to validate.
The script generates ICMP traffic from the ATA Gateway to the domain controller and looks for that traffic on the Capture NIC on the domain controller.
If the ATA Gateway sees ICMP traffic with a destination IP address the same as the DC IP addressed you entered in the ATA Console, it deems port mirroring configured. 

Sample for how to run the script:

    # ATAdiag.ps1 -CaptureIP n.n.n.n -DCIP n.n.n.n -TestCount n
    
    param([parameter(Mandatory=$true)][string]$CaptureIP, [parameter(Mandatory=$true)][string]$DCIP, [int]$PingCount = 10)

    # Set variables
    
        $ErrorActionPreference = "stop"
    $starttime = get-date
    $byteIn = new-object byte[] 4
    $byteOut = new-object byte[] 4
    $byteData = new-object byte[] 4096  # size of data
    
    $byteIn[0] = 1  # for promiscuous mode
    $byteIn[1-3] = 0
    $byteOut[0-3] = 0



    # Convert network data to host format
        function NetworkToHostUInt16 ($value)
    	{
    	[Array]::Reverse($value)
    	[BitConverter]::ToUInt16($value,0)
    	}
    
    function NetworkToHostUInt32 ($value)
    	{
    	[Array]::Reverse($value)
    	[BitConverter]::ToUInt32($value,0)
    	}
    
    function ByteToString ($value)
    	{
    	$AsciiEncoding = new-object system.text.asciiencoding
    	$AsciiEncoding.GetString($value)
        	}
    
    Write-Host "Testing Port Mirroring..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Here is a summary of the connection we will test." -ForegroundColor Yellow

    # Initialize a first ping connection
    Test-Connection -Count 1 -ComputerName $DCIP -ea SilentlyContinue
    Write-Host ""
    
    Write-Host "Press any key to continue..." -ForegroundColor Red
    [void][System.Console]::ReadKey($true)
    Write-Host ""
    Write-Host "Sending ICMP and Capturing data..." -ForegroundColor Yellow
    
    # Open a socket
    
    $socket = new-object system.net.sockets.socket([Net.Sockets.AddressFamily]::InterNetwork,[Net.Sockets.SocketType]::Raw,[Net.Sockets.ProtocolType]::IP)
    
    # Include the IP header
    $socket.setsocketoption("IP","HeaderIncluded",$true)
    
    $socket.ReceiveBufferSize = 10000
    
    $ipendpoint = new-object system.net.ipendpoint([net.ipaddress]"$CaptureIP",0)
    $socket.bind($ipendpoint)
    
    # Enable promiscuous mode
    [void]$socket.iocontrol([net.sockets.iocontrolcode]::ReceiveAll,$byteIn,$byteOut)
    
    # Initialize test variables
    $tests = 0
    $TestResult = "Noise"
    $OneSuccess = 0
    
    while ($tests -le $PingCount)
    	{
    	if (!$socket.Available)  # see if any packets are in the queue
    		{
    		start-sleep -milliseconds 500
    		continue
    		}
    
    # Capture traffic
    	$rcv = $socket.receive($byteData,0,$byteData.length,[net.sockets.socketflags]::None)
    
    # Decode the header so we can read ICMP
    
    	$MemoryStream = new-object System.IO.MemoryStream($byteData,0,$rcv)
    	$BinaryReader = new-object System.IO.BinaryReader($MemoryStream)
    
    # Set IP version & header length
    	$VersionAndHeaderLength = $BinaryReader.ReadByte()
    
    	# TOS
    	$TypeOfService= $BinaryReader.ReadByte()
    
    	# More values, and the Protocol Number for ICMP traffic
    	# Convert network format of big-endian to host format of little-endian 
    	$TotalLength = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
    
    	$Identification = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
    	$FlagsAndOffset = NetworkToHostUInt16 $BinaryReader.ReadBytes(2)
    	$TTL = $BinaryReader.ReadByte()
    	$ProtocolNumber = $BinaryReader.ReadByte()
    	$Checksum = [Net.IPAddress]::NetworkToHostOrder($BinaryReader.ReadInt16())
    
    	# The source and destination IP addresses
    	$SourceIPAddress = $BinaryReader.ReadUInt32()
    	$DestinationIPAddress = $BinaryReader.ReadUInt32()
    
    	# The source and destimation ports
    	$sourcePort = [uint16]0
    	$destPort = [uint16]0
    		
    	# Close the stream reader
    	$BinaryReader.Close()
    	$memorystream.Close()
    
    	# Cast DCIP into an IPaddress type
    	$DCIPP = [ipaddress] $DCIP
    	$DestinationIPAddressP = [ipaddress] $DestinationIPAddress
    
    	#Ping the DC at the end after starting the capture
    	Test-Connection -Count 1 -ComputerName $DCIP -ea SilentlyContinue | Out-Null
    		
    	# This is the match logic - check to see if Destination IP from the Ping sent matches the DCIP entered by in the ATA Console  
    	# The only way the ATA Gateway should see a destination of the DC is if Port Spanning is configured
    	
    		if ($DestinationIPAddressP -eq $DCIPP)  # is the destination IP eq to the DC IP? 
    		{
    		$TestResult = "Port Spanning success!"
    		$OneSuccess = 1
    		} else {
    			$TestResult = "Noise"
    		}
    	
    	# Put source, destination, test result in Powershell object
    	
    	new-object psobject | add-member -pass noteproperty CaptureSource $([system.net.ipaddress]$SourceIPAddress) | add-member -pass noteproperty CaptureDestination $([system.net.ipaddress]$DestinationIPAddress) | Add-Member -pass NoteProperty Result $TestResult | Format-List | Out-Host
    	#Count tests
    	$tests ++
    	}
    
    	If ($OneSuccess -eq 1){
    		Write-Host "Port Spanning Success!" -ForegroundColor Green
    		Write-Host ""
    		Write-Host "At least one packet which was addressed to the DC, was picked up by the Gateway." -ForegroundColor Yellow
    		Write-Host "A little noise is OK, but if you don't see a majority of successes, you might want to re-run." -ForegroundColor Yellow
    	} Else {
    		Write-Host "No joy, all noise.  You may want to re-run, increase the number of Ping Counts, or check your config." -ForegroundColor Red
    	}
    
    Write-Host ""
    Write-Host "Press any key to continue..." -ForegroundColor Red
    [void][System.Console]::ReadKey($true)
    
    
## Validate port mirroring using Net Mon
1.  Install [Microsoft Network Monitor 3.4](http://www.microsoft.com/download/details.aspx?id=4865) on the ATA Gateway that you want to validate..

    > [!IMPORTANT]
    > Do not install Microsoft Message Analyzer, or any other traffic capture software on the ATA Gateway.

2.  Open Network Monitor and create a new capture tab.

    1.  Select only the **Capture** network adapter or the network adapter that is connected to the switch port that is configured as the port mirroring destination.

    2.  Ensure that P-Mode is enabled.

    3.  Click **New Capture**.

        ![Create new capture tab image](media/ATA-Port-Mirroring-Capture.jpg)

3.  In the Display Filter window, enter the following filter: **KerberosV5 OR LDAP** and then click **Apply**.

    ![Apply KerberosV5 or LDAP filter image](media/ATA-Port-Mirroring-filter-settings.jpg)

4.  Click **Start** to start the capture session. If you do not see traffic to and from the domain controller, review your port mirroring configuration.

    ![Start capture session image](media/ATA-Port-Mirroring-Capture-traffic.jpg)

    > [!NOTE]
    > It is important to make sure you see traffic to and from the domain controllers.
    

5.  If you only see traffic in one direction, you should work with your networking or virtualization teams to help troubleshoot your port mirroring configuration.

## See Also

- [Configure port mirroring](configure-port-mirroring.md)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
