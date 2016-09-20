---
# required metadata

title: Exchange ActiveSync policy settings | Microsoft Intune
description: Use the Intune Exchange ActiveSync policy to configure settings that let you control features and functionality on devices managed by Exchange ActiveSync.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: e9cbb826-b155-4df6-abf3-60c6f05b2783

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: heenamac
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Exchange ActiveSync policy settings in Microsoft Intune
Use the Microsoft Intune **Exchange ActiveSync** policy to configure settings that control a range of features and functionality on devices that are managed by Exchange ActiveSync.


## Password settings

|Setting name|Details
|----------------|---|
|**Require a password to unlock mobile devices**|Specifies whether devices must be locked by using a password.<br>(not applicable to devices running Windows RT).|
|**Required password type**|Specifies the type of password that will be required, such as numeric only or alphanumeric.|
|**Minimum password length**|Specifies the minimum number of required characters in the device password.|
|**Allow simple passwords**|Specifies whether you can use simple passwords, which include ‘0000’ and ‘1234’.|
|**Number of repeated sign-in failures to allow before the device is wiped**|Specifies the number of times that a user can enter an incorrect password before the device is wiped.|
|**Password expiration (days)**|Specifies the number of days after which the device password must be changed.
|**Remember password history**|Specifies whether to not allow the use of previously used passwords.|
|**Remember password history** – **Prevent reuse of previous passwords**|Specifies the number of previously used passwords that can't be used again.|
|**Minutes of inactivity before password is required**|Specifies the amount of time that a device must be idle before the screen is locked.

## Encryption settings

|Setting name|Details|
|----------------|---|
|**Require encryption on mobile device**<sup>1</sup>|Requires the data on a device to be encrypted when supported.<br><br>For Windows Phone 8 devices, you must set this to **Yes**.<br /><br />To enable encryption on iOS devices, enable the **Require a password to unlock mobile devices** setting.|
|**Require encryption on storage cards**|Requires data that is stored on external storage such as an SD card to be encrypted (on supported devices).
<sup>1</sup> Additional information for devices that run Windows 8.1

-   If you want to enforce encryption on devices that run Windows 8.1, you must install the [December 2014 MDM client update for Windows](http://support.microsoft.com/kb/3013816) on each device.

-   If you enable this setting for Windows 8.1 devices, all users of the device must have a Microsoft account.

-   If you want encryption to work for Windows 8.1 devices, the device must meet the Microsoft [InstantGo](http://blogs.windows.com/bloggingwindows/2014/06/19/instantgo-a-better-way-to-sleep/) hardware certification requirements.

-   If you enforce encryption on a Windows 8.1 device, the recovery key is only accessible from the user's Microsoft account, which is accessed from the user's OneDrive account. You cannot recover this key on behalf of a user.

## Email settings

|Setting name|Details
|----------------|---|
|**Allow users to download email attachments**|Specifies whether email attachments can be downloaded to the device.|
|**Email synchronization period**|Specifies the number of days of received email that will be synchronized to the device.
|**Allow mobile devices that don’t fully support Exchange ActiveSync settings to synchronize with Exchange**|Specifies whether to allow Exchange access on devices that don't support one or more Exchange ActiveSync settings.

## Browser settings

|Setting name|Details
|----------------|---|
|**Allow web browser**|Specifies whether the web browser on the device can be used.<br>(Not available for Windows RT or Windows Phone).

## Hardware settings

|Setting name|Details
|----------------|---|
|**Allow camera**|Specifies whether the camera on the device can be used.<br>(Not available for Windows RT or Windows Phone).



### See also
[Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md)
