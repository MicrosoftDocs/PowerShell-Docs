---
# required metadata

title: Configure Port Mirroring | Microsoft ATA
description: Describes port mirroring options and how to configure them for ATA
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/28/2016
ms.topic: get-started-article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: cdaddca3-e26e-4137-b553-8ed3f389c460

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



# Configure Port Mirroring
> [!NOTE] 
> This article is relevant only if you deploy ATA Gateways instead of ATA Lightweight Gateways. To determine if you need to use ATA Gateways, see [Choosing the right gateways for your deployment](/advanced-threat-analytics/plan-design/ata-capacity-planning#choosing-the-right-gateway-type-for-your-deployment).
 
The main data source used by ATA is deep packet inspection of the network traffic to and from your domain controllers. For ATA to see the network traffic, you must either configure port mirroring, or use a Network TAP.

For port mirroring, configure **port mirroring** for each domain controller to be monitored, as the **source** of the network traffic. Typically, you will need to work with the networking or virtualization team to configure port mirroring.
For more information, refer to your vendor's documentation.

Your domain controllers and ATA Gateways can be either physical or virtual. The following are common methods for port mirroring and some considerations. Refer to your switch or virtualization server product documentation for additional information. Your switch manufacturer might use different terminology.

**Switched Port Analyzer (SPAN)** – Copies network traffic from one or more switch ports to another switch port on the same switch. Both the ATA Gateway and domain controllers must be connected to the same physical switch.

**Remote Switch Port Analyzer (RSPAN)**  – Allows you to monitor network traffic from source ports distributed over multiple physical switches. RSPAN copies the source traffic into a special RSPAN configured VLAN. This VLAN needs to be trunked to the other switches involved. RSPAN works at Layer 2.

**Encapsulated Remote Switch Port Analyzer (ERSPAN)** – Is a Cisco proprietary technology working at Layer 3. ERSPAN allows you to monitor traffic across switches without the need for VLAN trunks. ERSPAN uses generic routing encapsulation (GRE) to copy monitored network traffic. ATA currently cannot directly receive ERSPAN traffic. For ATA to work with ERSPAN traffic, a switch or router that can decapsulate the traffic needs to be configured as the destination of ERSPAN where the traffic will be decapsulated. The switch or router will then need to be configured to forward it to the ATA Gateway using either SPAN or RSPAN.

> [!NOTE]
> If the domain controller being port mirrored is connected over a WAN link, make sure the WAN link can handle the additional load of the ERSPAN traffic.

## Supported port mirroring options

|ATA Gateway|Domain Controller|Considerations|
|---------------|---------------------|------------------|
|Virtual|Virtual on same host|The virtual switch needs to support port mirroring.<br /><br />Moving one of the virtual machines to another host by itself may break the port mirroring.|
|Virtual|Virtual on different hosts|Make sure your virtual switch supports this scenario.|
|Virtual|Physical|Requires a dedicated network adapter otherwise ATA will see all of the traffic coming in and out of the host, even the traffic it sends to the ATA Center.|
|Physical|Virtual|Make sure your virtual switch supports this scenario - and port mirroring configuration on your physical switches based on the scenario:<br /><br />If the virtual host is on the same physical switch, you will need to configure a switch level span.<br /><br />If the virtual host is on a different switch, you will need to configure RSPAN or ERSPAN&#42;.|
|Physical|Physical on the same switch|Physical switch must support SPAN/Port Mirroring.|
|Physical|Physical on a different switch|Requires physical switches to support RSPAN or ERSPAN&#42;.|
&#42; ERSPAN is only supported when decapsulation is performed before the traffic is analyzed by ATA.

> [!NOTE]
> Make sure that domain controllers and the ATA Gateways to which they connect have time synchronized to within 5 minutes of each other.

**If you are working with virtualization clusters:**

-   For each domain controller running on the virtualization cluster in a virtual machine with the ATA Gateway,  configure affinity between the domain controller and the ATA Gateway. This way when the domain controller moves to another host in the cluster the ATA Gateway will follow it. This works well when there are a few domain controllers.
> [!NOTE]
> If your environment supports Virtual to Virtual on different hosts (RSPAN) you do not need to worry about affinity.
> 
-   To make sure the ATA Gateways are properly sized to handle monitoring all of the DCs by themselves, try this option: Install a virtual machine on each virtualization host and install an ATA Gateway on each host. Configure each ATA Gateway to monitor all of the domain controllers  that run on the cluster. This way, any host the domain controllers run on will be monitored.

After configuring port mirroring, validate that port mirroring is working before installing the ATA Gateway.

## See Also
- [Validate port mirroring](validate-port-mirroring.md)
- [Install ATA](install-ata.md)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
