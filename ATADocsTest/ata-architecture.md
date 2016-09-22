---
# required metadata

title: ATA Architecture | Microsoft ATA
description: Describes the architecture of Microsoft Advance Threat Analytics (ATA)
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 892b16d2-58a6-49f9-8693-1e5f69d8299c

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




# ATA Architecture
The Advanced Threat Analytics architecture is detailed in this diagram:

![ATA architcture topology diagram](media/ATA-architecture-topology.jpg)

ATA monitors your domain controller network traffic by utilizing port mirroring to an ATA Gateway using physical or virtual switches, or by deploying the ATA Lightweight Gateway directly on your domain controllers, which removes the requirement for port mirroring. In addition, ATA can leverage Windows events (forwarded directly from your domain controllers or from a SIEM server) and analyze the data for attacks and threats.
This section describes the flow of network and event capturing and drills down to describe the functionality of the main components of ATA: the ATA Gateway, ATA Lightweight Gateway (which has the same core functionality as the ATA Gateway) and the ATA Center.


![ATA traffic flow diagram](media/ATA-traffic-flow.jpg)

## ATA Components
ATA consists of the following:

-   **ATA Center** <br>
The ATA Center receives data from any ATA Gateways and/or ATA Lightweight Gateways you deploy.
-   **ATA Gateway**<br>
The ATA Gateway is installed on a dedicated server that monitors the traffic from your domain controllers using either port mirroring or a network TAP.
-   **ATA Lightweight Gateway**<br>
The ATA Lightweight Gateway is installed directly on your domain controllers and monitors their traffic directly, without the need for a dedicated server or configuration of port mirroring. It is an alternative to the ATA Gateway.

An ATA deployment can consist of a single ATA Center connected to all ATA Gateways, all ATA Lightweight Gateways or a combination of ATA Gateways and ATA Lightweight Gateways.


## Deployment options
You can deploy ATA using the following combination of gateways:

-	**Using only ATA Gateways** <br>
If your ATA deployment contains only ATA Gateways, without any ATA Lightweight Gateways, all the domain controllers must be configured to enable port mirroring to an ATA Gateway or network TAPs must be in place.
-	**Using only ATA Lightweight Gateways**<br>
If your ATA deployment contains only ATA Lightweight Gateways, the ATA Lightweight Gateways are deployed on each domain controller and no additional servers or port mirroring configuration is necessary.
-	**Using both ATA Gateways and ATA Lightweight Gateways**<br>
If your ATA deployment includes both ATA Gateways and ATA Lightweight Gateways, where the ATA Lightweight Gateway is installed on some of your domain controllers (for example, all domain controllers in your branch sites) while other domain controllers are monitored by ATA Gateways (for example, the larger domain controllers in your main data centers).

In all 3 scenarios, all the gateways send their data to the ATA Center.




## ATA Center
The **ATA Center** performs the following functions:

-   Manages ATA Gateway and ATA Lightweight Gateway configuration settings

-   Receives data from ATA Gateways and ATA Lightweight Gateways 

-   Detects suspicious activities

-   Runs ATA behavioral machine learning algorithms to detect abnormal behavior

-   Runs various deterministic algorithms to detect advanced attacks based on the attack kill chain

-   Runs the ATA Console

-   Optional: The ATA Center can be configured to send emails and events when a suspicious activity is detected.

The ATA Center receives parsed traffic from the ATA Gateway and ATA Lightweight Gateway, performs profiling, runs deterministic detection and runs machine learning and behavioral algorithms to learn about your network to enable detection of anomalies and warn you of suspicious activities.

|||
|-|-|
|Entity Receiver|Receives batches of entities from all ATA Gateways and ATA Lightweight Gateways .|
|Network Activity Processor|Processes all the network activities within each batch received. For example, matching between the various Kerberos steps performed from potentially different computers|
|Entity Profiler|Profiles all the Unique Entities according to the traffic and events. For example, this is where ATA updates the list of logged-on computers for each user profile.|
|Center Database|Manages the writing process of the Network Activities and events into the database. |
|Database|ATA utilizes MongoDB for purposes of storing all the data in the system:<br /><br />-   Network activities<br />-   Event activities<br />-   Unique entities<br />-   Suspicious activities<br />-   ATA configuration|
|Detectors|The Detectors use machine learning algorithms and deterministic rules to find suspicious activities and abnormal user behavior in your network.|
|ATA Console|The ATA Console is for configuring ATA and monitoring suspicious activities detected by ATA on your network. The ATA Console is not dependent on the ATA Center service and will run even when the service is stopped, as long as it can communicate with the database.|
Consider the following when deciding how many ATA Centers to deploy on your network:

-   One ATA Center can monitor a single Active Directory forest. If you have more than one Active Directory forest you will need a minimum of one ATA Center per Active Directory forest.

-    In very large Active Directory deployments, a single ATA Center might not be able to handle all of the traffic of all your domain controllers. In this case, multiple ATA Centers will be required. The number of ATA Centers should be dictated by [ATA capacity planning](ata-capacity-planning.md).

## ATA Gateway and ATA Lightweight Gateway

### Gateway core functionality
The **ATA Gateway** and **ATA Lightweight Gateway** both have the same core functionality:

-   Capture and inspect domain controller network traffic (port mirrored traffic in the case of an ATA Gateway and local traffic of the domain controller in the case of an ATA Lightweight Gateway) 

-   Receive Windows events from SIEM or Syslog servers, or from domain controllers using Windows Event Forwarding

-   Retrieve data about users and computers from the Active Directory domain

-   Perform resolution of network entities (users, groups and computers)

-   Transfer relevant data to the ATA Center

-   Monitor multiple domain controllers from a single ATA Gateway, or monitor a single domain controller for an ATA Lightweight Gateway.

The ATA Gateway receives network traffic and Windows Events from your network and processes it in the following main components:

|||
|-|-|
|Network Listener|The Network Listener is responsible for capturing network traffic and parsing the traffic. This is a CPU-heavy task, so  it is especially important to check [ATA Prerequisites](ata-prerequisites.md) when planning your ATA Gateway or ATA Lightweight Gateway.|
|Event Listener|The Event Listener is responsible for capturing and parsing Windows Events forwarded from a SIEM server on your network.|
|Windows Event Log Reader|The Windows Event Log Reader is responsible for reading and parsing Windows Events forwarded to the ATA Gateway's Windows Event Log from the domain controllers.|
|Network Activity Translator | Translates parsed traffic into a logical representation of the traffic used by ATA (NetworkActivity).
|Entity Resolver|The Entity Resolver takes the parsed data (network traffic and events) and resolves it data with Active Directory to find account and identity information. It is then matched with the IP addresses found in the parsed data. The Entity Resolver inspects the packet headers efficiently, to enable parsing of authentication packets for machine names, properties, and identities. The Entity Resolver combines the parsed authentication packets with the data in the actual packet.|
|Entity Sender|The Entity Sender is responsible for sending the parsed and matched data to the ATA Center.|

## ATA Lightweight Gateway features

The following features work differently depending on whether you are running an ATA Gateway or an ATA Lightweight Gateway.

-	**Domain synchronizer candidate**<br>
The domain synchronizer gateway is responsible for synchronizing all entities from a specific Active Directory domain proactively (similar to the mechanism used by the domain controllers themselves for replication). One gateway is chosen randomly, from the list of candidates, to serve as the domain synchronizer. <br><br>
If the synchronizer is offline for more than 30 minutes, another candidate is chosen instead. If there is no domain synchronizer available for a specific domain, ATA will not be able to proactively synchronize entities and their changes, however ATA will reactively retrieve new entities as they are detected in the monitored traffic. 
<br>If there is no domain synchronizer available, and you search for an entity that did not have any traffic related to it, no search results will be displayed.<br><br>
By default, all ATA Gateways are synchronizer candidates.<br><br>
Because all ATA Lightweight Gateways are more likely to be deployed in branch sites and on small domain controllers, they are not synchronizer candidates by default.


-	**Resource limitations**<br>
The ATA Lightweight Gateway includes a monitoring component which evaluates the available compute and memory capacity on the domain controller on which it is running. The monitoring process runs every 10 seconds and dynamically updates the CPU and memory utilization quota on the ATA Lightweight Gateway process to make sure that at any given point in time, the domain controller has at least 15% of free compute and memory resources.<br><br>
No matter what happens on the domain controller, this process always frees up resources to make sure the domain controller's core functionality is not affected.<br><br>
If this causes the ATA Lightweight Gateway to run out of resources, only partial traffic is monitored and the monitoring alert "Dropped port mirrored network traffic" will appear in the Health page.

The following table provides an example of a domain controller with enough compute resource available to allow for a larger quota then is currently needed, so that all traffic is monitored:

||||||
|-|-|-|-|-|
|Active Directory (Lsass.exe)|ATA Lightweight Gateway (Microsoft.Tri.Gateway.exe)|Miscellaneous (other processes) |ATA Lightweight Gateway Quota|Gateway dropping|
|30%|20%|10%|45%|No|

If Active Directory needs more compute, the quota needed by the ATA Lightweight Gateway is reduced. In the following example, The ATA Lightweight Gateway needs more than the allocated quota and drops some of the traffic (monitoring only partial traffic):

||||||
|-|-|-|-|-|
|Active Directory (Lsass.exe)|ATA Lightweight Gateway (Microsoft.Tri.Gateway.exe)|Miscellaneous (other processes) |ATA Lightweight Gateway Quota|Is gateway dropping|
|60%|15%|10%|15%|Yes|



## Your network components
In order to work with ATA, make sure of the following:

### Port mirroring
If you are using ATA Gateways, you have to setup port mirroring for the domain controllers that will be monitored and set the ATA Gateway as the destination using the physical or virtual switches. Another option is to use network TAPs. ATA will work if some but not all of your domain controllers are monitored, but detections will be less effective.

While port mirroring mirrors all the domain controller network traffic to the ATA Gateway, only a very small percentage of that traffic is then sent, compressed, to the ATA Center for analysis.

Your domain controllers and the ATA Gateways can be physical or virtual, see [Configure port mirroring](/advanced-threat-analytics/deploy-use/configure-port-mirroring) for more information.


### Events
To enhance ATA detection of Pass-the-Hash, Brute Force and Honey Tokens, ATA needs Windows Event log ID 4776. This can be forwarded to the ATA Gateway in one of two ways, by configuring the ATA Gateway to listen for SIEM events or by using Windows Event Forwarding.

-   Configuring the ATA Gateway to listen for SIEM events <br>Configure your SIEM to forward specific Windows events to ATA. ATA supports a number of SIEM vendors. For more information, see [Configure event collection](/advanced-threat-analytics/deploy-use/configure-event-collection).

-   Configuring Windows Event Forwarding<br>Another way ATA can get your events is by configuring your domain controllers to forward Windows event 4776 to your ATA Gateway. This is especially useful if you don't have a SIEM or if your SIEM is not currently supported by ATA. For more information about Windows Event Forwarding in ATA, see [Configuring Windows event forwarding](/advanced-threat-analytics/deploy-use/configure-event-collection#configuring-windows-event-forwarding).

## See Also
- [ATA prerequisites](ata-prerequisites.md)
- [ATA capacity planning](ata-capacity-planning.md)
- [Configure event collection](/advanced-threat-analytics/deploy-use/configure-event-collection)
- [Configuring Windows event forwarding](/advanced-threat-analytics/deploy-use/configure-event-collection#configuring-windows-event-forwarding)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)

