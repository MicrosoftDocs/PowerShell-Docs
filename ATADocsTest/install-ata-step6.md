---
# required metadata

title: Install ATA | Microsoft ATA
description: In the final step of installing ATA, you configure the short-term lease subnets and the Honeytoken user.
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/28/2016
ms.topic: get-started-article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 8980e724-06a6-40b0-8477-27d4cc29fd2b

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



# Install ATA - Step 6

>[!div class="step-by-step"]
[« Step 5](install-ata-step5.md)

## Step 6. Configure  IP address exclusions and Honeytoken user
ATA enables the exclusion of specific IP addresses and IP subnets from two types of detections: **DNS Reconnaissance** and **Pass-the-Ticket**. 

For example, a **DNS Reconnaissance exclusion** could be a security scanner that uses DNS as a scanning mechanism. The exclusion helps ATA ignore such scanners. An example of a *Pass-the-Ticket* exclusion is a NAT device.    

ATA also enables the configuration of a Honeytoken user, which is used as a trap for malicious actors - any authentication associated with this (normally dormant) account will trigger an alert.

To configure the above, follow these steps:

1.  From the ATA Console, click on the settings icon and select **Configuration**.

    ![ATA configuration settings](media/ATA-config-icon.JPG)

2.  Under **Detection exclusions**, enter the following for either *DNS Reconnaissance* or *Pass-the-Ticket* IP addresses. Use CIDR format, for example:  `192.168.1.0/24` and click the *plus* sign.

    ![Save changes](media/ATA-exclusions.png)

3.  Under **Detection settings** enter the Honeytoken account SIDs and click the plus sign. For example: `S-1-5-21-72081277-1610778489-2625714895-10511`.

    ![ATA configuration settings](media/ATA-honeytoken.png)

    > [!NOTE]
    > To find the SID for a user, search for the user in the ATA Console, and then click on the **Account Info** tab. 

4.  Click **Save**.


Congratulations, you have successfully deployed Microsoft Advanced Threat Analytics!

Check the attack time line to view detected suspicious activities and search for users or computers and view their profiles.

ATA will start scanning for suspicious activities immediately. Some activities, such as some of the suspicious behavior activities, will not be available until ATA has had time to build behavioral profiles (minimum of three weeks).


>[!div class="step-by-step"]
[« Step 5](install-ata-step5.md)


## See Also

- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
- [Configure event collection](configure-event-collection.md)
- [ATA prerequisites](/advanced-threat-analytics/plan-design/ata-prerequisites)

