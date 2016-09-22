---
# required metadata

title: Setting ATA Notifications | Microsoft ATA
description: Describes how to set ATA alerts so you are notified when suspicious activities are detected.
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 14cb7513-5dc8-49cb-b3e0-94f469c443dd

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



# Setting ATA Notifications
ATA can notify you when it detects a suspicious activity, either by email or by using ATA event forwarding and forwarding the event to your SIEM/syslog server. Before selecting which notifications you want to receive, you have to [set up your email server and your Syslog server](setting-syslog-email-server-settings.md).

> [!NOTE]
> -   Email notifications include a link that will take the user directly to the suspicious activity that was detected. The host name portion of the link is taken from the setting of the ATA Console URL on the ATA Center page. By default, the ATA Console URL is the IP address selected during the installation  of the ATA Center.  If you are going to configure email notifications it is recommended to use an FQDN as the ATA Console URL.
> -   Notifications are sent from the ATA Center to either the SMTP server and the Syslog server.

## Mail notifications
To receive mail notifications, set the following:


1. In the ATA Console, select the settings option on the toolbar and select **Configuration**.
![ATA configuration settings icon](media/ATA-config-icon.JPG)

2. Under the **Notifications** section, select **Settings**.
3. Under **Mail recipients**, specify the recipients who will receive the notifications via email.

	[!Note:] Email alerts for suspicious activities are only sent when the suspicious activity is created.

4. Under **Notify when:**, use the toggles to select to which notifications should be sent:

	- New suspicious activity is detected
	- New health issue is detected
	- New software update is available

5. Click **Save**.

![ATA mail notification settings image](media/ATA-mail-notification-settings-1.7.png)


## Syslog notification

To receive Syslog notifications, set the following:


1. In the ATA Console, select the settings option on the toolbar and select **Configuration**.
![ATA configuration settings icon](media/ATA-config-icon.JPG)

2. Under the **Notifications** section, select **Settings**.
3. Under **Syslog notifications**, use the toggles to select to which notifications should be sent:


	- New suspicious activity is detected
	- Existing suspicious activity is updated
	- New health issue is detected
5. Click **Save**.
![ATA notification settings image](media/ATA-syslog-notification-settings-1.7.png)




## See Also
[Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
