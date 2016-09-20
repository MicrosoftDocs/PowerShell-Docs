---
# required metadata

title: Windows policy settings | Microsoft Intune
description: Use the Intune Windows general configuration policy (Windows 8.1 and later) to configure settings for enrolled Windows 8, and Windows 8.1 devices.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 6982a2bc-aafa-475a-9236-4840b709e5a1

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Windows policy settings in Microsoft Intune
Use the Microsoft Intune **Windows general configuration policy (Windows 8.1 and later)** to configure the following settings for enrolled Windows 8 and Windows 8.1 devices:

## Applicability settings

|Setting name|Details|
|----------------|----------------------------------|
|**Apply all configurations to Windows 10**|Enables settings in this policy to be applied to Windows 10 devices, in addition to Windows 8 and Windows 8.1 devices.|

## Security settings

|Setting name|Details|Windows 8.1 and Windows RT 8.1|Windows RT|
|----------------|------|----------------------------|--------------|
|**Required password type**|Specifies the type of password that's required, such as alphanumeric or numeric only.|Yes|Yes|
|**Required password type – Minimum number of character sets**|Specifies how many different character sets must be included in the password. There are four character sets: lowercase letters, uppercase letters, numbers, and symbols. However, for iOS devices, this setting specifies the number of symbols that must be included in the password.|Yes|Yes|
|**Minimum password length**<sup>1</sup>|Configures the minimum required length (in characters) for the password.|Yes|Yes|
|**Number of repeated sign-in failures to allow before the device is wiped**|Wipes the device if the sign-in attempts fail this number of times.|Yes|Yes|
|**Minutes of inactivity before screen turns off**|Specifies the number of minutes a device must be idle before a password is required to unlock it.| Yes|Yes|
|**Password expiration (days)**|Specifies the number of days before the device password must be changed.|Yes|Yes|
|**Remember password history**|Specifies whether the user can configure previously used passwords.|Yes|Yes|
|**Remember password history** – **Prevent reuse of previous passwords**|Specifies the number of previously used passwords that are remembered by the device.|Yes|Yes|
|**Allow picture password and PIN**|Enables the use of a picture password and PIN. A picture password lets the user sign in with gestures on a picture. A PIN lets users quickly sign in with a four-digit code.|Yes|Yes|
<sup>1</sup> When you deploy a password length policy to devices that run Windows RT, users will be forced to reset their passwords, even if their current password complies with the policy requirements.

## Encryption settings

|Setting name|Details|Windows 8.1 and Windows RT 8.1|Windows RT|
|----------------|-----|-----------------------------|--------------|
|**Require encryption on mobile device**<sup>1</sup>|Requires that files on the device are encrypted.<br>For Windows Phone 8 devices, you must set this to **Yes**.|Yes|No|
<sup>1</sup> Additional information for devices that run Windows 8.1

-   To enforce encryption on devices that run Windows 8.1, you must install the [December 2014 MDM client update for Windows](http://support.microsoft.com/kb/3013816) on each device.

-   If you enable this setting for Windows 8.1 devices, all users of the device must have a Microsoft account.

-   For encryption to work, the device must meet the Microsoft [InstantGo](http://blogs.windows.com/bloggingwindows/2014/06/19/instantgo-a-better-way-to-sleep/) hardware certification requirements.

-   When you enforce encryption on a device, the recovery key is only accessible from the user's Microsoft account, which is accessed from their OneDrive account. You cannot recover this key on behalf of a user.

## Malware settings

|Setting name|Details|Windows 8.1 and Windows RT 8.1|Windows RT|
|----------------|-----|-----------------------------|--------------|
|**Require network firewall**|Requires that the Windows Firewall is turned on.|Yes|No|
|**Enable SmartScreen**|Requires the use of Windows SmartScreen.|Yes|No|

## System settings

|Setting name|Details|Windows 8.1 and Windows RT 8.1|Windows RT|
|----------------|-------|---------------------------|--------------|
|**Require automatic updates**|Turns on the automatic updates setting on devices.|Yes|No|
|**Require automatic updates – Minimum classification of updates to install automatically**|Chooses the classification of updates that will be installed automatically:<br /><br />-   **Important** – Installs all updates that are classified as important.<br />-   **Recommended** – Installs all updates that are classified as important or recommended.|Yes|No|
|**User Account Control**|Requires the use of User Account Control (UAC) on devices.|Yes|No|
|**Allow diagnostic data submission**|Enables the device to submit diagnostic information to Microsoft.|Yes|No|


## Cloud settings – documents and data

|Setting name|Details|Windows 8.1 and Windows RT 8.1|Windows RT|
|----------------|------|----------------------------|--------------|
|**Work Folders URL**|Sets the URL of the work folder to allow documents to be synchronized across devices.|Yes|No|

## Email settings

|Setting name|Details|Windows 8.1 and Windows RT 8.1|Windows RT|
|----------------|-----|-----------------------------|--------------|
|**Make Microsoft account optional in Windows Mail application**|Enables access to the Windows Mail application without a Microsoft account.|Yes|No|

## Application settings - browser

|Setting name|Details|Windows 8.1 and Windows RT 8.1|Windows RT|
|----------------|-----|-----------------------------|--------------|
|**Allow autofill**|Enables users to change autocomplete settings in the browser.|Yes|No|
|**Allow pop-up blocker**|Enables or disables the browser pop-up blocker.|Yes|No|
|**Allow plug-ins**|Enables users to add plug-ins to Internet Explorer.|Yes|No|
|**Allow active scripting**|Enables the browser to run scripts, such as Active X scripts.|Yes|No|
|**Allow fraud warning**|Enables or disables warnings for potential fraudulent websites.|Yes|No|
|**Allow intranet site for single word entry**|Enables use of a single word to direct Internet Explorer to a web site, such as Bing.|Yes|No|
|**Allow automatic detection of intranet network**|Helps configure security for intranet sites in Internet Explorer.|Yes|No|
|**Security level for Internet**|Sets the Internet Explorer security level for Internet sites.|Yes|No|
|**Security level for intranet**|Sets the Internet Explorer security level for intranet sites.|Yes|No|
|**Security level for trusted sites**|Configures the security level for the trusted sites zone.|Yes|No|
|**Security level for restricted sites**|Configures the security level for the restricted sites zone.|Yes|No|
|**Send Do Not Track header**|Sends  a do not track header to visited sites in Internet Explorer.|Yes|No|
|**Allow Enterprise Mode menu access**|Lets users access the Enterprise Mode menu options from Internet Explorer.<br>If you select this setting, you can also specify a **Logging report location**, which contains a URL to a report that shows websites for which users have turned on Enterprise Mode access.|Yes|No|
|**Enterprise Mode site list location**|Specifies the location of the list of websites that will use Enterprise Mode when it is active.|Yes|No|

## Device capabilities settings - cellular

|Setting name|Details|Windows 8.1 and Windows RT 8.1|Windows RT|
|----------------|----|------------------------------|--------------|
|**Allow data roaming**|Enables data roaming when the device is on a cellular network.|Yes|No|



### See also
[Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md)
