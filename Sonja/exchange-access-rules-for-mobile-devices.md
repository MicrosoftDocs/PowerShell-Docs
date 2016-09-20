---
# required metadata

title: Exchange access rules for mobile devices | Microsoft Intune
description: Exchange ActiveSync access rules to allow or block device connections with EAS
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 208b9f45-02d9-413a-b86a-8bad9b5008fa

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: muhosabe
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Exchange access rules for mobile devices
Exchange access rules for mobile devices determine the level of access that those devices have to Exchange ActiveSync. These settings affect all mobile devices, including those that aren't enrolled in Microsoft Intune. You can start off by defining a **Default Rule**, which applies to any mobile device that does not have a custom rule applied to it.

The following table contains the access levels that are managed by Exchange ActiveSync:

|Access level|Description|
|----------------|---------------|
|**Allow the devices to access Exchange**|In the *allow access* state, mobile devices can sync through Exchange ActiveSync and connect to the Exchange server to retrieve email and manage Calendar, Contacts, Tasks, and Notes. This continues as long as the device complies with any Exchange ActiveSync mailbox policy that you have configured in Exchange, unless the user or the specific mobile device has been blocked by the Exchange administrator.|
|**Block the devices from accessing Exchange**|In the *block access* state, mobile devices are blocked and aren't allowed to connect to the Exchange server. Devices receive an HTTP 403 Forbidden error. The user receives an email message from the Exchange server telling them that the mobile device was blocked from accessing their mailbox. This message cannot be on the blocked mobile device. By using the **Set User Notification** task, you can add customized text to this message to provide instructions for users whose devices are blocked. |
|**Quarantine the devices so that you can allow or block them later**|When a mobile device is quarantined, the mobile device is allowed to connect to the Exchange server. However, it is given only limited access to data. The user can add content to their own Calendar, Contacts, Tasks, and Notes folders but the server doesn't allow the device to retrieve any content from the user's mailbox. The user receives a single email message stating that the mobile device is quarantined. This message is sent to the device and to the user's mailbox. By using the **Set User Notification** task, you can add customized text to this message to provide instructions for users whose devices are quarantined.|

An access strategy is a combination of a **Default Rule** and **Platform Exceptions** that apply to all mobile devices that are connected to Exchange. The following table lists some example access strategies.

|Access strategy|Description|
|-------------------|---------------|
|Allow list|You can use an *allow list* to grant access to a list of known devices and restrict access for all other devices. To do this, you must create custom rules for device platforms that are allowed to access a user's mailbox. As soon as you create such a rule, you must set the default access rule to block or quarantine all other devices. To add a new device to the allow list, create a new custom rule.|
|Block list|You can use a *block list* to grant access to all devices by default, but to block access for a set of devices that you do not want to access your organization. Create a block list by creating custom rules to block device platforms that you do not want to sync with the organization’s mailboxes. We recommend setting the default rule to allow access to all devices that are not explicitly blocked by the existing rules. To add a new device or set of devices to the block list, create a new custom rule.|
|Mixed allow and block|In addition to creating allow and block lists, you can quarantine new mobile devices as they are introduced into the organization while you evaluate them. For example, if you have a block list for mobile devices that are not allowed within your organization, and an allow list for mobile devices that are allowed within the organization, you can set the default rule to quarantine. All other devices are automatically quarantined. This lets you discover new devices as they are introduced to the organization and decide whether to add them to the allow or block lists.|
The following procedure describes how to create a custom rule.

## Create a default access rule

1.  In the [Microsoft Intune administration console](http://manage.microsoft.com), choose **Policy** &gt; **Exchange ActiveSync**.

2.  In the **Default Rule** list, select the Access Rule that you want to apply to all mobile devices that aren't covered by a rule or personal exemption. Choose **Save**.

The following procedure describes how to create a custom rule:

## Create a custom access rule

1. In the [Microsoft Intune administration console](http://manage.microsoft.com), choose **Policy** &gt; **Exchange ActiveSync**.

2.  In the **Platform Exceptions** list, Choose **Add Rule**, and then create a custom rule. Choose **Save**.
