---
# required metadata

title: Exchange ActiveSync Device Management | Microsoft Intune
description: Manage mobile devices with Exchange ActiveSync (EAS) management using the Exchange connector
keywords:
author: nathbarn
manager: angrobe
ms.date: 07/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 14f5cf53-6764-4e22-a18b-fa750b3acd41

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Exchange ActiveSync mobile device management with Microsoft Intune
For Microsoft Intune to directly manage mobile devices, devices must be [enrolled in Intune](get-ready-to-enroll-devices-in-microsoft-intune.md). As an alternative, administrators can enable a more limited management solution that uses Exchange ActiveSync (EAS) management with an Exchange connector. Devices can be managed with either on-premises Exchange servers and Exchange Online using Office 365. Intune only supports one Exchange connector connection of any type per subscription.

## Exchange access rules for mobile devices ##

Exchange needs a set of rules that defines what happens when mobile devices attempt to connect to EAS. These rules are managed in the Intune administration console.

[Exchange access rules for mobile devices](exchange-access-rules-for-mobile-devices.md)

## Install the Exchange connector
The Exchange connector lets you manage your Exchange deployment in the Intune console. You must first install and configure the appropriate Intune-to-Exchange connector. Choose the appropriate option based whether your Exchange server is on-premises or hosted as a service in the cloud:

-   [Configure the Intune for Exchange Online or new Exchange Online Dedicated environments](intune-service-to-service-exchange-connector.md)
-   [Install the Intune connector for on-premises Exchange servers and legacy Exchange Online Dedicated environments](intune-on-premises-exchange-connector.md)


## Apply policy for Exchange-managed mobile devices
The Intune console can be used to manage [EAS policy settings](exchange-activesync-policy-settings-in-microsoft-intune.md) and to [restrict access to company resources](restrict-access-to-email-and-o365-services-with-microsoft-intune.md). For a list of Exchange ActiveSync policy settings and features supported by specific mobile devices, see [Exchange ActiveSync Client Comparison Table](http://go.microsoft.com/fwlink/?LinkId=247270).

> [!NOTE]
> After connecting Intune to a Microsoft Exchange environment, the EAS policy for all users managed through Intune will be reset to the current default policy on the Microsoft Exchange server, unless a more specific policy is defined within Intune.

## Wipe company data from mobile devices
Finally, you can [wipe company data from EAS-managed mobile devices](wipe-for-exchange-managed-mobile-devices.md) when they are no longer in use, or if devices are lost or stolen.
