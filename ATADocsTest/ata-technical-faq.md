---
# required metadata

title: ATA Frequently asked questions | Microsoft ATA
description: Provides a list of frequently asked questions about ATA and the associated answers
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: a7d378ec-68ed-4a7b-a0db-f5e439c3e852

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

# ATA frequently asked questions
This article provides a list of frequently asked questions about ATA and provides insight and answers.


## How is ATA licensed?
For licensing information, see [How to buy Advanced Threat Analytics](https://www.microsoft.com/cloud-platform/advanced-threat-analytics-pricing)


## What should I do if the ATA Gateway won’t start?
Look at the most recent error in the current error log (Where ATA is installed under the "Logs" folder).
## How can I test ATA?
You can simulate suspicious activities which is an end to end test by doing one of the following:

1.  DNS reconnaissance by using Nslookup.exe
2.  Remote execution by using psexec.exe


This needs to run remotely against the domain controller being monitored and not from the ATA Gateway.

## How do I verify Windows Event Forwarding?
You can place the the following code into a file and then execute it from a command prompt in the directory:  **\Program Files\Microsoft Advanced Threat Analytics\Center\MongoDB\bin** as follows:

mongo.exe ATA filename

        db.getCollectionNames().forEach(function(collection) {
        if (collection.substring(0,10)=="NtlmEvent_") {
                if (db[collection].count() > 0) {
                                  print ("Found "+db[collection].count()+" NTLM events") 
                                }
                }
        });

## Does ATA work with encrypted traffic?
ATA relies on analyzing multiple network protocols, as well as events collected from the SIEM or via Windows Event Forwarding so that even though encrypted traffic will not be analyzed (for example, LDAPS and IPSEC ESP) ATA will still work and most of the detections will not be affected

## Does ATA work with Kerberos Armoring?
Enabling Kerberos Armoring, also known as Flexible Authentication Secure Tunneling (FAST), is supported by ATA, with the exception of over-pass the hash detection which will not work.
## How many ATA Gateways do I need?

The number of ATA Gateways depend on your network layout, volume of packets and volume of events captured by ATA. To determine the exact number, see [ATA Lightweight Gateway Sizing](/advanced-threat-analytics/plan-design/ata-capacity-planning#ata-lightweight-gateway-sizing). 

## How much storage do I need for ATA?
For every one full day with an average of 1000 packets/sec you need 0.3 GB of storage.<br /><br />For more information about ATA Center sizing see, [ATA Capacity Planning](/advanced-threat-analytics/plan-design/ata-capacity-planning).


## Why are certain accounts considered sensitive?
This happens when an account is a member of certain groups which we designate as sensitive (for example: "Domain Admins").

To understand why an account is sensitive you can review its group membership to understand which sensitive groups it belongs to (the group that it belongs to can also be sensitive due to another group, so the same process should be performed until you locate the highest level sensitive group).

## How do I monitor a virtual domain controller using ATA?
Most virtual domain controllers can be covered by the ATA Lightweight Gateway, to determine whether the ATA Lightweight Gateway is appropriate for your environment, see [ATA Capacity Planning](/advanced-threat-analytics/plan-design/ata-capacity-planning).

If a virtual domain controller can't be covered by the ATA Lightweight Gateway, you can have either a virtual or physical ATA Gateways as described in [Configure port mirroring](/advanced-threat-analytics/deploy-use/configure-port-mirroring).  <br />The easiest way is to have a virtual ATA Gateway on every host where a virtual domain controller exists.<br />If your virtual domain controllers move between hosts, you need to perform one of the following:

-   When the virtual domain controller moves to another host, preconfigure the ATA Gateway in that host to receive the traffic from the recently moved virtual domain controller.
-   Make sure that you affiliate the virtual ATA Gateway with the virtual domain controller so that if it is moved, the ATA Gateway moves with it.
-   There are some virtual switches that can send traffic between hosts.

## How do I back up ATA?
There are 2 things to back up:

-   The traffic and events stored by ATA, which can be backed using any supported database backup procedure, for more information see [ATA database management](/advanced-threat-analytics/deploy-use/ata-database-management). 
-   The configuration of ATA. This is stored in the database and is automatically backed up every hour in the **Backup** folder in the ATA Center deployment location.  See [ATA database management](https://docs.microsoft.com/en-us/advanced-threat-analytics/deploy-use/ata-database-management) for more information.
## What can ATA detect?
ATA detects known malicious attacks and techniques, security issues, and risks.
For the full list of ATA detections, see [What detections does ATA perform?](ata-threats.md).

## What kind of storage do I need for ATA?
We recommend fast storage (7200 RPM disks are not recommended) with low latency disk access (less than 10 ms). The RAID configuration should support heavy write loads (RAID-5/6 and their derivatives are not recommended).

## How many NICs does the ATA Gateway require?
The ATA Gateway needs a minimum of two network adapters:<br>1. A NIC to connect to the internal network and the ATA Center<br>2. A NIC that will be used to capture the domain controller network traffic via port mirroring.<br>* This does not apply to the ATA Lightweight Gateway, which natively uses all of the network adapters that the domain controller uses.

## What kind of integration does ATA have with SIEMs?
ATA has a bi-directional integration with SIEMs as follows:

1. ATA can be configured to send a Syslog alert in the event of a suspicious activity to any SIEM server using the CEF format.
2. ATA can be configured to receive Syslog messages for each Windows event with the ID 4776, from  [these SIEMs](/advanced-threat-analytics/deploy-use/configure-event-collection#siem-support).

## Can ATA monitor domain controllers virtualized on your IaaS solution?

Yes, you can use the ATA Lightweight Gateway to monitor domain controllers that are in any IaaS solution.

## Is this an on-premises or in-cloud offering?
Microsoft Advanced Threat Analytics is an on-premises product.

## Is this going to be a part of Azure Active Directory or on-premises Active Directory?
This solution is currently a standalone offering—it is not a part of Azure Active Directory or on-premises Active Directory.

## Do you have to write your own rules and create a threshold/baseline?
With Microsoft Advanced Threat Analytics, there is no need to create rules, thresholds, or baselines and then fine-tune. ATA analyzes the behaviors among users, devices, and resources—as well as their relationship to one another—and can detect suspicious activity and known attacks fast. Three weeks after deployment, ATA starts to detect behavioral suspicious activities. On the other hand, ATA will start detecting known malicious attacks and security issues immediately after deployment.

## If you are already breached, will Microsoft Advanced Threat Analytics be able to identify abnormal behavior?
Yes, even when ATA is installed after you have been breached, ATA can still detect suspicious activities of the hacker. ATA is not only looking at the user’s behavior but also against the other users in the organization security map. During the initial analysis time, if the attacker’s behavior is abnormal, then it is identified as an “outlier” and ATA keeps reporting on the abnormal behavior. Additionally ATA can detect the suspicious activity if the hacker attempts to steal another users credentials, such as Pass-the-Ticket, or attempts to perform a remote execution on one of the domain controllers.

## Does this only leverage traffic from Active Directory?
In addition to analyzing Active Directory traffic using deep packet inspection technology, ATA can also collect relevant events from your Security Information and Event Management (SIEM) and create entity profiles based on information from Active Directory Domain Services. ATA can also collect events from the event logs if the organization configures Windows Event Log forwarding.

## What is port mirroring?
Also known as SPAN (Switched Port Analyzer), port mirroring is a method of monitoring network traffic. With port mirroring enabled, the switch sends a copy of all network packets seen on one port (or an entire VLAN) to another port, where the packet can be analyzed.

## Does ATA monitor only domain-joined devices?
No. ATA monitors all devices in the network performing authentication and authorization requests against Active Directory, including non-Windows and mobile devices.

## Does ATA monitor computer accounts as well as user accounts?
Yes. Since computer accounts (as well as any other entities) can be used to perform malicious activities ATA monitors all computer accounts behavior and all other entities in the environment.

## Can ATA support multi-domain and multi-forest?
Microsoft Advanced Threat Analytics supports multi-domain environments within the same forest boundary. Multiple forests require an ATA deployment for each forest.
## Can you see the overall health of the deployment?
Yes, you can view the overall health of the deployment as well as specific issues related to configuration, connectivity etc., and you will be alerted as they occur.


## See Also
- [ATA prerequisites](/advanced-threat-analytics/plan-design/ata-prerequisites)
- [ATA capacity planning](/advanced-threat-analytics/plan-design/ata-capacity-planning)
- [Configure event collection](/advanced-threat-analytics/deploy-use/configure-event-collection)
- [Configuring Windows event forwarding](/advanced-threat-analytics/deploy-use/configure-event-collection#Configuring-Windows-Event-Forwarding)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)

