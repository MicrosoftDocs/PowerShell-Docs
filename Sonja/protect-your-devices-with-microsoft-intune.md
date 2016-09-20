---
# required metadata

title: Protect devices | Microsoft Intune
description: Learn about some of the ways that Intune can help you protect your devices against unauthorized access and other threats.
keywords:
author: Robstackmsft
manager: angrobe
ms.date: 09/01/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 71e0cbf3-2bfb-412e-8a12-8503df08b4cf

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Protect devices with Microsoft Intune

Microsoft Intune offers a full set of capabilities to help you protect the devices you manage, and the data stored on those devices. Read this topic to learn the basics of these capabilities and to find out how to learn more.

## General ways to protect all devices

### Device configuration
Intune [configuration policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md), help you protect and configure devices by controlling a multitude of settings and features. For example:
- You can restrict use of hardware features on the device such as the camera, or Bluetooth.
- You can configure compliant and noncompliant apps. You will be alerted if a noncompliant app is installed (and some platforms can actually block the install).

### Reset passcodes when users are locked out of their devices
Since the first step in protecting company data on mobile devices is to require a passcode to use the device, sometimes you have to [reset a passcode](use-remote-lock-and-passcode-reset-in-microsoft-intune.md) or help an employee do so, either by removing the passcode or setting a temporary passcode remotely. You can also [lock a device remotely](use-remote-lock-and-passcode-reset-in-microsoft-intune.md) if it is lost or stolen.

### Retire devices and remove data
When a device needs to be [removed from Intune management](retire-devices-from-microsoft-intune-management) (for example, a user leaves, or the device is lost or stolen), it's likely that you will want to remove data from that device. Intune provides a range of methods to ensure your company data remains secure.

### Require devices to be compliant
Intune features [device compliance policies](introduction-to-device-compliance-policies-in-microsoft-intune) that let you evaluate (and in some cases remediate) devices that are not compliant with rules you specify. For example, you can report about iOS devices that are jailbroken, whether devices are encrypted, or whether Windows 10 devices are reported as healthy by the Health Attestation Service.

### Protect apps and the data they use
Intune gives you a range of features to help you protect apps and their data. For example, mobile application management (MAM) policies can prevent data from being backed up from a protected app, restrict copy and paste to other apps, require a PIN to access an app, and more. For more details about protecting apps, see [Protect apps and data with Microsoft Intune](protect-apps-and-data-with-microsoft-intune)

## Further capabilities for Windows devices

### Add an additional layer of protection to Windows devices
[Multi-factor authentication (MFA)](protect-windows-devices-with-multi-factor-authentication.md) is a more secure way of authenticating the users of Windows and Windows Phone devices on the network.  With MFA, users need to confirm their identity beyond user name and password, through a phone call, or text message.

### Control Windows Hello for Business settings on Windows devices
Intune lets you integrate with [Windows Hello for Business](control-microsoft-passport-settings-on-devices-with-microsoft-intune.md) (formerly Microsoft Passport) which is an alternative sign-in method for Windows 10 and later that uses Active Directory, or an Azure Active Directory account to replace a password, smart card, or virtual smart card.

## Further capabilities for iOS devices

### Bypass Activation Lock on iOS devices
Activation Lock is a feature that help protect users' devices by requiring their Apple ID and password to be entered before anyone can erase, or reactivate the device. However, this can lead to problems, for example if the user leaves the company without removing the lock. [iOS Activation Lock bypass](help-protect-ios-devices-with-activation-lock-bypass-for-microsoft-intune.md) can help by removing the lock from supervised iOS devices allowing you to reallocate, or erase them.



## Protect Windows PCs managed with the Intune client
Intune continues to support security policies for Windows PCs that you don't enroll, but manage with the Intune computer client software. To find out how these policies can help you secure your Windows PCs, see [Use policies to help protect Windows PCs that run the Intune client software](policies-to-protect-windows-pcs-in-microsoft-intune.md).
