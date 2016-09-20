---
# required metadata

title: Use remote wipe to help protect data | Microsoft Intune
description: Intune provides selective wipe and full wipe capabilities to remove sensitive corporate data and remove access to many corporate resources.
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/25/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 8519e411-3d48-44eb-9b41-3e4fd6a93112

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: lancecra
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Help protect your data with full or selective wipe using Microsoft Intune
Whether because a device is no longer needed, is being repurposed, or has gone missing, you can wipe apps and data from devices managed with Intune. To do this, Intune provides selective wipe and full wipe capabilities. Also, users can issue a remote device wipe command from the Intune Company Portal on privately owned devices enrolled in Intune.

  > [!NOTE]
  > This topic is only about wiping devices managed by Intune mobile device management. You can also use [the Azure preview portal](https://portal.azure.com) to [wipe company data from apps](wipe-managed-company-app-data-with-microsoft-intune.md). You can also [retire computers managed with the Intune client software](common-windows-pc-management-tasks-with-the-microsoft-intune-computer-client#retire-a-computer.md).

## Full wipe

**Full wipe** restores a device to its factory default settings, removing all company and user data and settings. The device is removed from Intune. Full wipe is useful for resetting a device before giving it to a new user or instances where the device has been lost or stolen.  **Be careful about selecting full wipe. Data on the device cannot be recovered**.


> [!Warning]
> Windows 10 RTM devices (i.e. devices earlier than the Windows 10 version 1511) with less than 4 GB of RAM might become inaccessible if wiped. To access a Windows 10 device that has become unresponsive, you can boot the device from a USB drive or similar workaround.

### Remotely wipe a device from the Intune administrator console

1.  Select devices to be wiped. You can find them either by user or by device.

    -   **By user:**

        1.  In the [Intune administrator console](https://manage.microsoft.com/), choose **Groups** &gt; **All Users**.

        2.  Choose the name of the user whose mobile device you want to wipe. Choose **View Properties**.

        3.  On the user's **Properties**  page, choose **Devices**, and then choose the name of the mobile device you want to wipe. Use Ctrl+click to multi-select devices.

    -   **By device:**

        1.  In the [Intune administrator console](https://manage.microsoft.com/), choose **Groups** &gt; **All Mobile Devices**.

      ![Starting a retire or wipe operation](../media/dev-sa-wipe.png)

        2.  Choose **Devices**, and then choose the name of the mobile device you want to wipe. Use Ctrl+click to multi-select devices.

2.  Choose **Retire/Wipe**.

3.  A message appears, prompting you to confirm whether you want to retire the device.

    -   To perform a **Selective wipe** which only removes company apps and data, choose **Yes**.

    -   To perform a **Full wipe** that erases all apps and data and returns the device to factory default settings, select **Wipe the device before retiring**. This action applies to all platforms except Windows 8.1. **You cannot recover data removed by a full wipe**.

Given the device is on and connected, it takes less than 15 minutes for a wipe command to propagate across all device types.

## Selective wipe

**Selective wipe** removes company data including mobile app management (MAM) data where applicable, settings, and email profiles from a device. Selective wipe leaves the user's personal data on the device. The device is removed from Intune. The following tables describe by platform what data is removed and the effect on data that remains on the device after a selective wipe.

**iOS**

|Data type|iOS|
|-------------|-------|
|Company apps and associated data installed by Intune.|Apps are uninstalled. Company app data is removed.<br /><br />App data from Microsoft apps that use mobile app management is removed. The app is not removed.|
|Settings|Configurations that were set by Intune policy are no longer enforced and users can change the settings.|
|Wi-Fi and VPN profile settings|Removed|
|Certificate profile settings|Certificates removed and revoked.|
|Management Agent|Management profile is removed.|
|Email|Email profiles that are provisioned through Intune are removed and cached email on the device is deleted.|
|Azure Active Directory (AAD) Unjoin|AAD Record removed|
|Contacts | Contacts synced directly from the app to the native address book are removed.  Any contacts synced from the native address book to another external source cannot be wiped. <br /> <br />Currently, only Outlook app is supported.

**Android**

|Data type|Android|Android Samsung KNOX|
|-------------|-----------|------------------------|
|Web links|Removed.|Removed|
|Unmanaged Google Play apps|Apps and data remain installed|Apps and data remain installed|
|Unmanaged line of business apps|Apps and data remain installed|Apps are uninstalled and data local to app is removed as a result. No data outside the app (SD card, etc.) is removed.|
|Managed Google Play apps|App data is removed. App is not removed. Data protected by MAM encryption outside the app (SD card, etc.) remain encrypted and unusable, but aren't removed.|App data is removed. App is not removed. Data protected by MAM encryption outside the app (SD card, etc.) remain encrypted but aren't removed.|
|Managed line of business apps|App data is removed. App is not removed. Data protected by MAM encryption outside the app (SD card, etc.) remain encrypted and unusable, but aren't removed.|App data is removed. App is not removed. Data protected by MAM encryption outside the app (SD card, etc.) remain encrypted and unusable, but aren't removed.|
|Settings|Configurations that were set by Intune policy are no longer enforced and users can change the settings.|Configurations that were set by Intune policy are no longer enforced and users can change the settings.|
|Wi-Fi and VPN profile settings|Removed|Removed|
|Certificate profile settings|Certificates revoked, but not removed.|Certificates removed and revoked.|
|Management Agent|Device Administrator privilege is revoked.|Device Administrator privilege is revoked.|
|Email|Email  received by the Microsoft Outlook app for Android  app is removed.|Email profiles that are provisioned through Intune are removed and cached email on the device is deleted.|
|Azure Active Directory (AAD) Unjoin|AAD Record removed|AAD Record removed|
|Contacts | Contacts synced directly from the app to the native address book are removed.  Any contacts synced from the native address book to another external source cannot be wiped. <br /> <br />Currently, only Outlook app is supported.|Contacts synced directly from the app to the native address book are removed.  Any contacts synced from the native address book to another external source cannot be wiped. <br /> <br />Currently, only Outlook app is supported.

**Windows**

|Data type|Windows 8.1 (MDM) and Windows RT 8.1|Windows RT|Windows Phone 8 and Windows Phone 8.1|Windows 10|
|-------------|----------------------------------------------------------------|--------------|-----------------------------------------|--------|
|Company apps and associated data installed by Intune.|Files protected by EFS will have their key revoked and the user will not be able to open the files.|Will not remove company apps.|Apps originally installed through the company portal are uninstalled. Company app data is removed.|Apps are uninstalled and sideloading keys are removed.|
|Settings|Configurations that were set by Intune policy are no longer enforced and users can change the settings.|Configurations that were set by Intune policy are no longer enforced and users can change the settings.|Configurations that were set by Intune policy are no longer enforced and users can change the settings.|Configurations that were set by Intune policy are no longer enforced and users can change the settings.|
|Wi-Fi and VPN profile settings|Removed|Removed|Not supported|Removed|
|Certificate profile settings|Certificates removed and revoked.|Certificates removed and revoked.|Not supported|Certificates removed and revoked.|
|Email|Removes email that is EFS enabled which includes the Mail app for Windows email and attachments.|Not supported|Email profiles that are provisioned through Intune are removed and cached email on the device is deleted.|Removes email that is EFS enabled which includes the Mail app for Windows email and attachments. Removes mail accounts that were provisioned by Intune.|
|Azure Active Directory (AAD) Unjoin|No|No|AAD Record removed|Not applicable. Windows 10 does not support selective wipe for Azure Active Directory joined devices|

## Wipe encryption file system (EFS)-enabled content
Selective wipe of EFS-encrypted content is supported by Windows 8.1 and Windows RT 8.1. The following apply to a selective wipe of EFS-enabled content:

-   Only apps and data that are protected by EFS using the same Internet domain as the Intune account are selectively wiped. For more information, see [Windows Selective Wipe for Device Data Management](http://technet.microsoft.com/library/dn486874.aspx).

-   If there are any changes are made to the domain associated with EFS, the changes can take up to 48 hours before apps and data using the new domain can be selectively wiped.

-   Each domain that is registered with Intune will be wiped.

The data and apps that are currently supported by EFS selective wipe are:

-   Mail app for Windows

-   Work Folders

-   Files and folders encrypted by EFS. For more information, see [Best practices for the Encrypting File System](http://support.microsoft.com/kb/223316).

-   If your organization maintains its identity in Active Directory, it must use the Directory Sync (DirSync) tool to sync information into AAD for EFS selective wipe to work correctly.  For more information on DirSync, see [Directory Sync Scenario](http://technet.microsoft.com/library/dn441212.aspx) in the Azure Active Directory documentation.

## Monitor retire, wipe, and delete actions
To get a report of devices that have been retired, wiped, or deleted, and who performed the action:

1.  In the [Intune administrator  console](https://manage.microsoft.com/), choose **Reports** &gt; **Device History Reports**.

2.  Provide a start and end date for the report, then choose **View Report**.


### See also
[Retire devices](retire-devices-from-microsoft-intune-management.md)

[Windows Selective Wipe for Device Data Management](http://technet.microsoft.com/library/dn486874.aspx)
