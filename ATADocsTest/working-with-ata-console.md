---
# required metadata

title: Working with the ATA Console | Microsoft ATA
description: Describes how to log into the ATA console and the components of the console
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 1bf264d9-9697-44b5-9533-e1c498da4f07

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



# Working with the ATA Console

Use the ATA console to monitor and respond to suspicious activity detected by ATA.

## Enabling access to the ATA Console
To successfully login to the ATA Console, you have to log in with a user who was assigned the proper ATA role to access the ATA Console. 
For more information about role based access control (RBAC) in ATA, see [Working with ATA role groups](ata-role-groups.md).

## Logging into the ATA Console

1. In the ATA Center server, click the **Microsoft ATA Console** icon on the desktop or open a browser and browse to the ATA Console.

    ![ATA server icon](media/ata-server-icon.png)

>[!NOTE]
> You can also open a browser from either the ATA Center or the ATA Gateway and browse to the IP address you configured in the ATA Center installation for the ATA Console.    

2.  Enter your username and password and click **Log in**.

![ATA login screen image](media/ATA-log-in-screen.png)


## The ATA Console

The ATA Console provides you a quick view of all suspicious activities in chronological order. It enables you to drill into details of any activity and perform actions based on those activities. The console also displays alerts and notifications to highlight problems with the ATA network or new activities that are deemed suspicious.

These are the key elements of the ATA console.


### Attack time line

This is the default landing page you are taken to when you log in to the ATA Console. By default, all open suspicious activities are shown on the attack time line. You can filter the attack time line to show All, Open, Dismissed or Resolved suspicious activities. You can also see the severity assigned to each activity.

![ATA attack timeline image](media/attack-timeline-1.7.png)

For more information, see [Working with suspicious activities](/advanced-threat-analytics/deploy-use/working-with-suspicious-activities).

### Notification bar

When a new suspicious activity is detected, the notification bar will open automatically on the right hand side. If there are new suspicious activities since the last time you logged in, the notification bar will open after you have successfully logged in. You can click the arrow on the right at any time to access the notification bar.

![ATA notification bar image](media/notification-bar-1.7.png)

### Filtering panel

You can filter which suspicious activities are displayed in the attack time line or displayed in the entity profile suspicious activities tab based on Status and Severity.

### Search bar

In the top menu, you will find a search bar. You can search for a specific user, computer or groups in ATA. To give it a try, just start typing.

![ATA console search image](media/ATA-console-search.png)

### Health Center

The Health Center provides you with alerts when something isn't working properly in your ATA deployment.

![ATA health center image](media/ATA-Health-Issue.jpg)

Any time your system encounters a problem, such as a connectivity error or a disconnected ATA Gateway, the Health Center icon will let you know by displaying a red dot. ![ATA health center red dot image](media/ATA-Health-Center-Alert-red-dot.png)

Health Center alerts can be dismissed or resolved and are categorized High, Medium or Low depending on their severity. If you resolve an alert that the ATA service detects as still active, it will automatically be moved to the Open list of alerts. If the system detects that there is no longer cause for an alert (the situation has been fixed), it will automatically be moved to the resolved list.

### User and computer profiles

ATA builds a profile for each user and computer in the network. In the user profile ATA displays general information, such as group membership, recent logins, and recently accessed resources.

![User profile](media/user-profile.png)

In the computer profile, ATA displays general information, such as recently logins and recently accessed resources.

![Computer profile](media/computer-profile.png)

ATA provides additional information about entities (computers, devices, users) on the following pages: Summary, Activities, and Suspicious activities.

A profile that ATA has not been able to fully resolve will be identified with half-filled circle icon next to it.


![ATA unresolved profile image](media/ATA-Unresolved-Profile.jpg)

### Mini profile

Anywhere in the console where there is a single entity presented, such as a user or computer, if you hover your mouse over the entity, a mini profile will automatically open displaying the following information if available:

![ATA mini profile image](media/ATA-mini-profile.jpg)

-   Name

-   Picture

-   Email

-   Telephone

-   Number of suspicious activities by severity



## See Also
[Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
