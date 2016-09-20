---
# required metadata

title: Compliance policy settings for iOS devices | Microsoft Intune
description:
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/28/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 4a59d24f-ed58-49b1-b874-b2d4aea3ec76

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---


# Compliance policy settings for iOS devices in Microsoft Intune

The policy settings described in this topic apply to  devices running iOS 8.0 and later.

If you are looking for information about other platforms, select one of the following:
> [!div class="op_single_selector"]
- [Compliance policy settings for Android devices](android-compliance-policy-settings-in-microsoft-intune.md)
- [Compliance policy settings for Windows devices](windows-compliance-policy-settings-in-microsoft-intune.md)

## System security settings
### Password
- **Require a password to unlock mobile devices:**    Set this to **Yes** to require users to enter a password before
  they can access their device. iOS devices that use password are encrypted.

- **Allow simple passwords:**    Set this
   to **Yes** to let users create simple passwords
   such as ‘**1234**’ or ‘**1111**’.

-  **Minimum password length:**
  Specify the minimum number of digits or characters that
  the user’s password must contain.
- **Required password type:** Specify whether users must create
an **Alphanumeric**, or a **Numeric** password.

- **Minimum number of character sets:** If you set **Required password type** to
**Alphanumeric**, use this setting to specify the minimum number of
character sets that the password must contain. The four character sets are:
  -   Lowercase letters
  -   Uppercase letters
  -   Symbols
  -   Numbers

  Setting a higher number for this setting will require users to create passwords that are more complex.

  For iOS devices, this setting refers to the number of special characters (for example, **!**, **#**, **&amp;**) that must be included in the password.
- **Minutes of inactivity before password is required:**  Specify the idle time before the user must re-enter their password.

- **Password expiration (days):** Select the number of days before the user’s password expires and they must create a new one.

- **Remember password history:** Use this setting in conjunction with **Prevent reuse of previous passwords** to restrict the user from creating previously used passwords.

- **Prevent reuse of previous passwords:** If **Remember password history** is selected, specify the number of previously used passwords that cannot be re-used.

- **Require a password when the device returns from an idle state:**
This setting should be used together with the in the **Minutes of inactivity before password is required** setting. The end users are prompted to enter a password to access a device that has been inactive for the time specified in the
**Minutes of inactivity before password is required** setting.

### Email profile
- **Email account must be managed by Intune:** When this option is set to **Yes**, the device must use the email noncompliant deployed to the device. The device is considered noncompliant in the following situations:
  - The email profile must also be deployed to the same user group as user group targeted by the compliance policy, otherwise the users’ devices will be considered noncompliant.
  - The device is reported as noncompliant if the user has already set up an email account on the device that matches the Intune email profile deployed to the device. Intune cannot overwrite the user-provisioned profile, and therefore
  cannot manage it. To ensure compliance, the user must remove the existing email settings, then, Intune can install the managed email profile.


- **Select the email profile that must be managed by Intune:**
     If the **Email account must be managed by Intune** setting is selected, choose **Select** to specify the Intune email profile. The email profile must be present on the device.

     For details about email profiles, see [configure access to corporate email using email profiles with Microsoft Intune](configure-access-to-corporate-email-using-email-profiles-with-microsoft-intune.md).

## Device health settings

- **Device must not be jailbroken or rooted:** If you enable this setting, jailbroken devices will not be compliant.

##  Device properties
- **Minimum OS required:** When a device does not meet the minimum OS version requirement, it is reported as noncompliant.
A link with information on how to upgrade is displayed. The end user can choose to upgrade their device after which they should be able to access company resources.

- **Maximum OS version allowed:** When a device is using an OS version later than the one specified in the rule, access to company resources is blocked and the user is asked to contact their IT admin. Until there is a change in rule to allow the OS version, this device cannot be used to access company resources.
