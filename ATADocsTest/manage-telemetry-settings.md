---
# required metadata

title: Manage Telemetry Settings | Microsoft ATA
description: Describes the data collected by ATA and provides steps to turn off data collection.
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 8c1c7a1b-a3de-4105-9fd0-08a061952172

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



# Manage Telemetry Settings
Advanced Threat Analytics (ATA) collects anonymized telemetry data about ATA and transmits the data over an HTTPS connection to Microsoft servers.  This data is used by Microsoft to help improve future versions of ATA.

## Data collected
Collected anonymized data includes the following:

-   Performance counters from both the ATA Center and the ATA Gateway

-   Product ID from licensed copies of ATA

-   Deployment date of the ATA Center

-   Number of deployed ATA Gateways

-   The following anonymized Active Directory information:

    -   Domain ID for the domain whose name would be the first domain when sorted alphabetically

    -   Number of domain controllers

    -   Number of domain controllers monitored by ATA via port mirroring

    -   Number of Sites

    -   Number of Computers

    -   Number of Groups

    -   Number of Users

-   Suspicious Activities  – The following anonymized data is collected for each suspicious activity:

    (Computer names, user names, and IP addresses are **not** collected)

    -   Suspicious activity type

    -   Suspicious activity ID

    -   Status

    -   Start and End Time

    -   Input provided

- Health issues – The following anonymized data is collected for each health issue:

    (Computer names, user names, and IP addresses are not collected)

    -   Health issue type

    -   Health issue ID

    -   Status

    -   Start and End Time

- ATA Console URL addresses - URL addresses when using the ATA Console i.e. which pages in the ATA Console are visited.


### Disable data collection
Perform the following steps to stop collecting and sending telemetry data to Microsoft:

1.  Log in to the ATA Console, click the three dots in the toolbar and select **About**.

2.  Uncheck the box for **Send us usage information to help improve your customer experience in the future**.

## See Also
- [What's new in version 1.6](/advanced-threat-analytics/understand-explore/whats-new-version-1.6)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
