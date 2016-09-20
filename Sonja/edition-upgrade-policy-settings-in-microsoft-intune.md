---
# required metadata

title: Windows edition upgrade policy settings | Microsoft Intune
description: Learn how to automatically upgrade Windows 10 devices to the latest version with Intune.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 8589866a-3f13-489b-a5cd-cee017d16d54

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Windows edition upgrade policy settings in Microsoft Intune
The Microsoft Intune **Edition Upgrade Policy** lets you automatically upgrade devices that run one of the following Windows 10 versions to a newer edition:
* Windows 10 Desktop
* Windows 10 Holographic
* Windows 10 Mobile

## Before you start
Before you begin to upgrade devices to the latest version, you will need one of the following:
* A product key that is valid to install the new version of Windows on all devices that you target with the policy (for Windows 10 Desktop editions). You can use either Multiple Activation Keys (MAK) or Key Management Server (KMS) keys.
**or**
A license file from Microsoft that contains the licensing information to install the new version of Windows on all devices that you target with the policy (for Windows 10 Mobile and Windows 10 Holographic editions).
* The Windows 10 devices that you target must be enrolled in Microsoft Intune. You cannot use the edition upgrade policy with PCs that run the Intune PC client software.

## Edition upgrade policy settings

|Setting name|Details|
|-|-|
|**Name**|Enter a name for the edition upgrade policy.|
|**Description**|Optionally, enter a description for the policy that helps you identify it in the Intune console.
|**Edition to upgrade to**|From the drop-down list, select the version of Windows 10 Desktop, Windows 10 Holographic, or Windows 10 Mobile that you want to upgrade targeted devices to.
|**Product Key**|Specify the product key that you obtained from Microsoft, which can be used to upgrade all targeted Windows 10 Desktop devices.<br>After you create a policy that contains a product key, you cannot edit the product key later. This is because the key is obscured for security reasons. To change the product key, you must enter the entire key again.
|**License File**|Choose **Browse** to select the license file you obtained from Microsoft that contains license information for the Windows Holographic, or Windows 10 Mobile edition that you want to upgrade targeted devices to.

### See also
[Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md)
