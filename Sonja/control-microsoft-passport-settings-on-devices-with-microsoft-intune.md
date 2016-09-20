---
# required metadata

title: Control Windows Hello for Business settings on devices | Microsoft Intune
description: Learn how Intune integrates with Windows Hello for Business, an alternative sign-in method that uses Active Directory or an Azure Active Directory account to replace a password, smart card, or virtual smart card.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 09/02/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 402bc5a1-ada3-4c4c-a0de-292d026b4444

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Control Windows Hello for Business settings on devices with Microsoft Intune
Microsoft Intune integrates with Windows Hello for Business (formerly Microsoft Passport for Work), an alternative sign-in method that uses Active Directory or an Azure Active Directory account to replace a password, smart card, or a virtual smart card.

Hello for Business lets you use a *user gesture* to sign in, instead of a password. A user gesture might be a simple PIN, biometric authentication such as Windows Hello, or an external device such as a fingerprint reader.

Intune integrates with Hello for Business in two ways:

-   You can use an Intune policy to control which gestures users can and cannot use to sign in.

-   You can store authentication certificates in the Windows Hello for Business key storage provider (KSP). For more information, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).

## Create a Windows Hello for Business policy

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Admin** &gt; **Mobile Device Management** &gt; **Windows** &gt; **Windows Hello for Business** to open the Windows Hello for Business page.

	![Windows Hello for Business page](../media/passport.png)

2.  Choose one of the following settings:
	- **Disable Windows Hello for Business on enrolled devices**. If you don't want to use Windows Hello for Business, select this setting. All other settings on the screen are then unavailable.
	- **Enable Windows Hello for Business on enrolled devices**. Select this setting if you want to configure Windows Hello for Business settings.
	- **Not configured**. Select this setting if you don't want to use Intune to control Windows Hello for Business settings. Any existing Windows Hello for Business settings on Windows 10 devices will not be changed. All other settings on the screen are unavailable.
3.  If you selected **Enable Windows Hello for Business on enrolled devices**, configure the required settings that will be applied to all enrolled Windows 10 and Windows 10 Mobile devices.
4.  When you are finished, choose **Save**.


## Settings for the Windows Hello for Business policy

- **Use a Trusted Platform Module (TPM)**. A TPM chip provides an additional layer of data security.<br>Choose one of the following values:
	- **Required** (default). Only devices with an accessible TPM can provision Windows Hello for Business.
	- **Preferred**. Devices first attempt to use a TPM. If this is not available, they can use software encryption.
- **Require minimum PIN length**/**Require maximum PIN length**. Configures devices to use the minimum and maximum PIN lengths that you specify to help ensure secure sign-in. The default PIN length is 6 characters, but you can enforce a minimum length of 4 characters. The maximum PIN length is 127 characters.
- **Require lowercase letters in PIN**/**Require uppercase letters in PIN**/**Require special characters in PIN**. You can enforce a stronger PIN by requiring the use of uppercase letters, lowercase letters, and special characters in the PIN. Choose from:
	- **Allowed**. Users can use the character type in their PIN, but it is not mandatory.
	- **Required**. Users must include at least one of the character types in their PIN. For example, it's common practice to require at least one uppercase letter and one special character.
	- **Not allowed** (default). Users must not use these character types in their PIN. (This is also the behavior if the setting is not configured.)<br>Special characters include: **! " # $ % &amp; ' ( ) &#42; + , - . / : ; &lt; = &gt; ? @ [ \ ] ^ _ &#96; { &#124; } ~**.
- **PIN expiration (days)**. It's a good practice to specify an expiration period for a PIN, after which users must change it. The default is 41 days.
- **Remember PIN history**. Restricts the reuse of previously used PINs. By default, the last 5 PINs cannot be reused.
- **Allow biometric authentication**. Enables biometric authentication, such as facial recognition or fingerprint, as an alternative to a PIN for Windows Hello for Business. Users must still configure a work PIN in case biometric authentication fails. Choose from:
	- **Yes**. Windows Hello for Business allows biometric authentication.
	- **No**. Windows Hello for Business prevents biometric authentication (for all account types).
- **Use enhanced anti-spoofing, when available**. Configures whether the anti-spoofing features of Windows Hello are used on devices that support it (for example, detecting a photograph of a face instead of a real face).<br>If this is set to **Yes**, Windows requires all users to use anti-spoofing for facial features when that is supported.
- **Use phone sign-in**. If this option is set to **Yes**, users can use a remote passport to serve as a portable companion device for desktop computer authentication. The desktop computer must be Azure Active Directory joined, and the companion device must be configured with a Windows Hello for Business PIN.

## Further information
For more information about Microsoft Passport, see [the guide](https://technet.microsoft.com/library/mt589441.aspx) in the Windows 10 documentation.
