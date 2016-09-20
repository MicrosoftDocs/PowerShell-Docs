---
# required metadata

title: Firewall policies for Windows PCs | Microsoft Intune
description: Intune can help you to secure PCs you manage with the Intune client in a number of ways, including helping you to configure Windows Firewall settings.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 9549c072-ac3d-4d14-a931-a2eda8846217

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: owenyen
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Help protect Windows PCs using Windows Firewall policies in Microsoft Intune
Microsoft Intune can help you to secure Windows PCs that you manage with the Intune client in a number of ways. One way in which it does this is to provide policies that enable you to configure Windows Firewall settings on PCs.

If you have not yet installed the Intune Windows PC client on your computers, see [Install the Windows PC client with Microsoft Intune](install-the-windows-pc-client-with-microsoft-intune.md).

Use the information in the following sections to help you configure, deploy, and monitor Windows Firewall policies on Windows PCs.

## Use Intune policies to manage Windows Firewall
The Windows Firewall policy lets you create and deploy settings that control Windows Firewall on managed PCs. You cannot manage custom exceptions for Windows Firewall, and these settings do not affect third-party firewalls.

> [!NOTE]
> If Microsoft Intune policy and Group Policy are configured to manage the same setting on the PC, the Group Policy setting overrides the Microsoft Intune policy. For information about how to avoid conflicts between Intune policy and Group Policy, see [Resolve GPO and Microsoft Intune policy conflicts](resolve-gpo-and-microsoft-intune-policy-conflicts.md).
>
> If you want to deploy Windows Firewall settings to computers that run Windows Vista, you must first install [Hotfix KB971800](http://support2.microsoft.com/kb/971800) on these computers.

> [!IMPORTANT]
> To manage Windows Firewall by using Intune, ensure that the following two services are enabled on the computers that you manage:
>
> -   Windows Firewall
> -   IPsec Policy Agent

## Configure a Windows Firewall policy

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Policy** &gt; **Add Policy**.

2.  Configure and deploy a **Windows Firewall Settings** policy. You can use the recommended settings or customize the settings. If you need more information about how to create and deploy policies, see [Common Windows PC management tasks with the Microsoft Intune computer client](common-windows-pc-management-tasks-with-the-microsoft-intune-computer-client.md).

    The following section lists the values that you can configure in the policy and also the default values that will be used if you don’t customize the policy.

After you deploy a Windows Firewall policy, you can view its status on the **All Policies** page of the **Policy** workspace.

## Specify policy settings for Windows Firewall

### Turn on Windows Firewall

These policy settings enable Windows Firewall on managed computers that are:
- Connected to a domain (for example, at the workplace)
- Connected to a private (trusted) network (such as a home network)
- Connected to an untrusted public network (such as a coffee shop)

The default value for each of these settings is **Yes**, which is the most secure value.



### Block all incoming connections, including those in the list of allowed programs

These policy settings configure Windows Firewall to block incoming network traffic on managed computers that are:
- Connected to a domain (for example, at the workplace)
- Connected to a private (trusted) network (such as a home network)
- Connected to an untrusted public network (such as a coffee shop)

The default value for each of these settings is **Yes**, which is the most secure value.

> [!IMPORTANT]
> If your environment includes managed computers that are running Windows Vista with no service packs installed, you must either install the update that's associated with [article 971800](http://go.microsoft.com/fwlink/?LinkId=188405) in the Microsoft Knowledge Base or disable the **Block all incoming connections** policy settings in policies that are deployed to those computers.

### Notify the user when Windows Firewall blocks a new program

These policy settings determine whether Windows Firewall notifies a PC user when it blocks incoming network traffic when the managed computer is:
- Connected to a domain (for example, at the workplace)
- Connected to a private (trusted) network (such as a home network)
- Connected to an untrusted public network (such as a coffee shop)

The default value for each of these settings is **Yes**.


### Configure predefined exceptions

You can configure exceptions that allow specific types of network traffic through the firewall regardless of the values that you configured earlier. None of these settings are configured by default.

|Setting name|Details|
|------------------|--------------------|
|**BranchCache - Content Retrieval**<br>(Windows 7 or later)|Lets BranchCache clients use HTTP to retrieve content from other BranchCache clients while in distributed mode and from the hosted cache while in hosted cache mode. This setting uses HTTP.|
|**BranchCache - Hosted Cache Client**<br>(Windows 7 or later)|Lets BranchCache clients use a hosted cache. This setting uses HTTPS.|
|**BranchCache - Hosted Cache Server**|Lets BranchCache clients use a hosted cache to communicate with other clients. This setting uses HTTPS.|
|**BranchCache - Peer Discovery**<br>(Windows 7 or later)|Lets BranchCache clients use the Web Services Dynamic Discovery (WS-Discovery)  protocol to look up content availability on the local subnet.|
|**BITS Peercaching**|Lets clients use Background Intelligent Transfer Service (BITS) to find and share files that are stored in the BITS cache on clients in the same subnet. This setting uses Web Services on Devices (WSDAPI) and Remote Procedure Call (RPC).|
|**Connect to a Network Projector**|Lets users connect to projectors over wired or wireless networks to project presentations. This setting uses WSDAPI.|
|**Core Networking**|Lets clients use IPv4 and IPv6 to connect to network resources.|
|**Distributed Transaction Coordinator**|Enables managed computers to coordinate transactions that update transaction-protected resources, such as databases, message queues, and file systems.|
|**File and Printer Sharing**|Enables users to share local files and printers with other users on the network. This setting uses NetBIOS, Link Local Multicast Name Resolution (LLMNR), Server Message Block (SMB) protocol, and RPC.|
|**HomeGroup**<br>(Windows 7 or later)|Enables managed computers to participate in a HomeGroup network.|
|**iSCSI Service**|Enables managed computers to connect to iSCSI servers and devices.|
|**Key Management Service**|Lets computers be counted for license compliance in enterprise environments.|
|**Media Center Extenders**|Enables Media Center Extenders to communicate with computers that are running Windows Media Center. This setting uses Simple Service Discovery Protocol (SSDP) and qWave.|
|**Netlogon Service**|Configures a security channel between domain clients and a domain controller for authenticating users and services. This setting uses RPC.|
|**Network Discovery**|Lets computers discover other devices and be discovered by other devices on the network. This setting uses Function Discovery Host and Publication Services and SSDP, NetBIOS, LLMNR, and UPnP network protocols.|
|**Performance Logs and Alerts**|Enables the Performance Logs and Alerts service to be remotely managed. This setting uses RPC.|
|**Remote Administration**|Enables remote administration of the computer.|
|**Remote Assistance**|Lets users of managed computers request remote assistance from other users on the network. This setting uses SSDP, Peer Name Resolution Protocol (PNRP), Teredo, and UPnP network protocols.|
|**Remote Desktop**|Lets the computer use Remote Desktop to access other computers.|
|**Remote Event Log Management**|Lets client event logs be viewed and managed remotely. This setting uses Named Pipes and RPC.|
|**Remote Scheduled Tasks Management**|Enables remote management of the task scheduling service. This setting uses RPC.|
|**Remote Service Management**|Enables remote management of local services on clients. This setting uses Named Pipes and RPC.|
|**Remote Volume Management**|Enables remote software and hardware disk volume management. This setting uses RPC.|
|**Routing and Remote Access**|Enables incoming VPN and remote access connections to computers.|
|**Secure Socket Tunneling Protocol**|Enables incoming VPN connections to managed computers with Secure Socket Tunneling Protocol (SSTP). This setting uses HTTPS.|
|**SNMP Trap**|Lets managed computers receive Simple Network Management Protocol (SNMP) Trap service traffic.|
|**UPnP Framework**|Configures the UPnP Framework service on computers to let them discover and use UPnP certified devices.|
|**Windows Collaboration Computer Name Registration Service**|Lets computers find and communicate with other computers by using SSDP and PNRP.|
|**Windows Media Player**|Lets users receive streaming media over User Datagram Protocol (UDP).|
|**Windows Media Player Network Sharing Service**|Lets users share media over a network. This setting uses the SSDP, qWave, and UPnP network protocols.|
|**Windows Media Player Network Sharing Service (Internet)**<br>(Windows 7 or later)|Lets users share home media over the Internet.|
|**Windows Meeting Space**|Lets users collaborate over a network to share documents, programs, and their desktops. This setting uses Distributed File System Replication (DFSR) and P2P.|
|**Windows Peer to Peer Collaboration Foundation**|Configures various peer-to-peer programs and technologies to enable them to connect. This setting uses SSDP and PNRP.|
|**Windows Remote Management (Compatibility)**|Enables remote management of managed computers with WS-Management, a Web services-based protocol for remote management of operating systems and devices.|
|**Windows Remote Management**<br>(Windows 8 or later)|Enables remote management of managed computers with WS-Management, a Web services-based protocol for remote management of operating systems and devices.|
|**Windows Virtual PC**<br>(Windows 7 or later)|Lets virtual machines communicate with other computers.|
|**Wireless Portable Devices**|Enables the transfer of media from a network-enabled camera or media device to managed computers with Media Transfer Protocol (MTP). This setting uses SSDP and UPnP network protocols.|

### See also
[Policies to protect Windows PCs](policies-to-protect-windows-pcs-in-microsoft-intune.md)
