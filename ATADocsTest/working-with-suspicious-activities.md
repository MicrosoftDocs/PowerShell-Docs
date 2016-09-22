---
# required metadata

title: Working with Suspicious Activities | Microsoft ATA
description: Describes how to review suspicious activities identified by ATA
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 44d7c899-816c-4f7f-91d3-84a09d291a24

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



# Working with Suspicious Activities
This topic explains the basics of how to work with Advanced Threat Analytics.

## Review suspicious activities on the attack time line
After logging in to the ATA Console, you are automatically taken to the open **Suspicious Activities Time Line**. Suspicious activities are listed in chronological order with the newest suspicious activities on the top of the time line.
Each suspicious activity has the following information:

-   Entities involved, including users, computers, servers, domain controllers, and resources.

-   Times and time frame of the suspicious activities.

-   Severity of the suspicious activity, High, Medium, or Low.

-   Status: Open, resolved, or dismissed.

-   Ability to

    -   Share the suspicious activity with other people in your organization via email.

    -   Export the suspicious activity to Excel.

    -   Add a note to the suspicious activity.

    -   Provide input on the suspicious activity.

-   Provides recommendations for how to respond to the suspicious activity.

> [!NOTE]
> -   When you hover your mouse over a user or computer, an entity mini-profile is displayed that provides additional information about the entity and includes the number of suspicious activities that the entity is linked to.
> -   If you click on an entity, it will take you to the entity profile of the user or computer.

![ATA suspicious activities timeline image](media/ATA-Suspicious-Activity-Timeline.JPG)

## Filter suspicious activities list
To filter the suspicious activities list:

1.  In the **Filter by** pane on the left side of the screen, select one of the following: **All**, **Open**, **Resolved**, or **Dismissed**.

2.  To further filter the list, select **High**, **Medium** or **Low**.

**Suspicious activity severity**

-   **Low**

    Indicates suspicious activities that can lead to attacks designed for malicious users or software to gain access to organizational data.

-   **Medium**

    Indicates suspicious activities that can put specific identities at risk for more severe attacks that could result in identity theft or privileged escalation

-   **High**

    Indicates suspicious activities that can lead to identity theft, privilege escalation or other high-impact attacks

**Suspicious activity status**

-   **Open**

    All new suspicious activities appear in this list

-   **Resolved**

    Is used to track suspicious activities which you identified, researched and fixed for mitigated.

    > [!NOTE]
    > ATA may reopen a resolved activity if it the same activity is detected again within a short period of time.

-   **Dismissed**

    Are activities that you manually dismissed. If ATA detects a similar suspicious activity a new detection will be created.

## Provide input on a suspicious activity
To enable ATA to learn about your network with you, some suspicious activities (DNS reconnaissance, Pass the Ticket, SMB Session Enumeration, Abnormal Behavior and Remote Execution) request your input to will enhance the detection of suspicious activities going forward.

1.  For suspicious activities that enable you to provide input, the input question opens automatically. You will be asked to answer questions about activities on your network and whether or not they should be considered suspicious. In the below example, you are being asked if running scanning tools is allowed from a specific computer.

    ![ATA provide input for suspicious activities image](media/ATA-Input.JPG)

2.  If you answer no, this activity will be considered suspicious and any time ATA encounters this activity from this computer, you will be alerted.

3.  However, if you answer yes, the suspicious activity may be dismissed and future activities of this type from this computer may not generate a suspicious activity or will generate an activity that is automatically dismissed.

4.  If you do not know, you can click **Cancel**.

## Change the status of a suspicious activity
You can change the status of a suspicious activity by clicking the current status of the suspicious activity and selecting one of the following **Open**, **Resolved** or **Dismissed**.

## See Also
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
- [Working with ATA detection settings](working-with-detection-settings.md)
- [Modifying ATA configuration](modifying-ata-configuration.md)
