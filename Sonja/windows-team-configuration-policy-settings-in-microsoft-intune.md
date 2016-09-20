---
# required metadata

title: Windows Team configuration policy settings| Microsoft Intune
description: Use the Microsoft Intune **Windows 10 Team general configuration policy** to configure settings for enrolled Windows 10 Team devices such as the Microsoft Surface Hub.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 38194ef3-e26e-4682-958d-14b395fccba1

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Windows Team configuration policy settings in Microsoft Intune
Use the Microsoft Intune **Windows 10 Team general configuration policy** to configure settings for enrolled Windows 10 Team devices such as the Microsoft Surface Hub.

|Setting name|Details|
|----------------|-----------|
|**Allow screen to wake automatically when someone in the room**|Allows the device to wake automatically when its sensor detects someone in the room.|
|**Require PIN for wireless projection**|Specifies whether you must enter a PIN before you can use the wireless projection capabilities of the device.|
|**Set a maintenance window for device updates**|Configures the window when updates can take place to the device. You can configure the start time of the window and the duration (from 1-5 hours).|
|**Enable Azure Operational Insights**|Azure Operational Insights , part of the Microsoft Operations Manager suite collects, stores, and analyzes log file data from Windows 10 Team devices.<br /><br />To connect to Azure Operational insights, you must specify a **Workspace ID** and a **Workspace Key**.|
|**Enable Miracast wireless projection**|Enable this option if you want to let the Windows 10 Team device use Miracast enabled devices to project.<br /><br />If you enable this option, from **Choose Miracast channel** select the Miracast channel used to project content.|
|**Choose the meeting information displayed on the welcome screen**|If you enable this option, you can choose the information that will be displayed on the **Meetings** tile of the **Welcome** screen. You can:<br /><br />-   **Show organizer and time only**<br />-   **Show organizer, time and subject (subject hidden for private meetings)**|
|**Lockscreen background image URL**|Enable this setting to display a custom background on the **Welcome** screen of Windows 10 Team devices from the URL you specify.<br /><br />The image must be in PNG format and the URL must begin with **https://**.|


### See also
[Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md)

