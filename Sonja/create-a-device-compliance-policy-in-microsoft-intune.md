---
# required metadata

title: Create a device compliance policy | Microsoft Intune
description: Create a compliance policy to help secure mobile devices and PCs used to access your company data.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/13/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 5336dac0-a2cc-4cd4-8511-67e4f95bd700

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Create a device compliance policy in Microsoft Intune
This topic outlines the steps you can use to create a compliance policy that a device must follow in order to be considered compliant.

##  Step 1: Add a new policy
  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Policy** &gt; **Compliance Policies** &gt; **Add**.

  ![Screenshot of the compliance policy page in the Intune admin console, showing the add option in the menu at the top of page](./media/intune-sa-3a-add-compliance-policy.png)

##  Step 2:  Configure settings
On the **Create Policy** page, enable the settings you require:
  -   The System security settings like password, and encryption
  -   Device health settings like whether or not a device is jailbroken, or is reported healthy by the Windows device health attestation service.
  -   Device property settings like the minimum OS version required or maximum OS version allowed.
![General tab of the Create Policy page ](./media/intune-sa-3b-create-policy.png)


##  Step 3: Save the policy
When you are finished, choose **Save Policy**.

You will have the option to deploy the policy right after saving the policy, or you can choose to deploy it later. The new policy displays in the **Compliance Policies** node of the **Policy** workspace.

##  Step 4: Set the compliance status validity period
To specify the time the device has to check-in before a device is considered not compliant, go to compliance policy settings and update the time.  The default is set to 30 days.

![compliance policy settings option in the policy menu bar](../media/mdm-compliance-policy-settings.png)

![compliance policy dialog box](../media/mdm-ca-compliance-status-validity-period.png)

## Supported policy settings
The following table lists the compliance policy settings and the platforms on which they are supported.

-------------
|Setting|iOS|Android|Windows|
|-----|----|-----|-----|
|Require a password to unlock mobile devices|iOS 6 and later|Android 4.0 and later <br>Samsung KNOX Standard 4.0 and later|Windows Phone 8 and later|
|Allow simple passwords|iOS 6 and later|Not supported|Windows Phone 8 and later|
|Minimum password length|iOS 6 and later| Android 4.0 and later<br>Samsung KNOX Standard 4.0 and later| Windows Phone 8 and later<br>Windows 8.1|
|Required password type|iOS 6 and later|Not available|Windows Phone 8 and later <br>Windows RT<br> Windows RT 8.1 <br>Windows 8.1|
|Minimum number of character sets|iOS 6 and later|Not available|Windows Phone 8 and later <br>Windows RT<br> Windows RT 8.1 <br>Windows 8.1|
|Password quality|Not available|Android 4.0 and later <br>Samsung KNOX Standard 4.0 and later|Not available|
|Minutes of inactivity before password is required|iOS 6 and later|Android 4.0 and later<br>Samsung KNOX Standard 4.0 and later|Windows Phone 8 and later<br>Windows RT and Windows RT 8.1<br>Windows 8.1|
|Password expiration (days)|iOS 6 and later|Android 4.0 and later<br>Samsung KNOX Standard 4.0 and later|Windows Phone 8 and later<br>Windows RT and Windows RT 8.1<br>Windows 8.1|
|Remember password history|iOS 6 and later|Android 4.0 and later<br>Samsung KNOX Standard 4.0 and later|Windows Phone 8 and later<br>Windows RT and Windows RT 8.1<br>Windows 8.1|
|Prevent reuse of previous passwords|iOS 6 and later|Android 4.0 and later<br>Samsung KNOX Standard 4.0 and later|Windows Phone 8 and later<br>Windows RT and Windows RT 8.1<br>Windows 8.1|
|Require a password when the device returns from an idle state| Not available| Not available|Windows 10 Mobile|
|Require encryption on mobile device|Not applicable|Android 4.0 and later<br>Samsung KNOX Standard 4.0 and later|Windows Phone 8 and later<br> Windows 8.1|
|Require devices to be reported as healthy| Not available| Not available|Windows <br>Windows 10 Mobile|
|Device must Not be jailbroken or rooted|iOS 6 and later|Android 4.0 and later<br>Samsung KNOX Standard 4.0 and later|Not available|
|Email account must be managed by Intune|iOS 6 and later|Not available| Not available|
|Select the email profile that must be managed by Intune|iOS 6 and later|Not available| Not available|
|Minimum OS required|iOS 6 and later|Android 4.0 and later<br>Samsung KNOX Standard 4.0 and later| Windows Phone 8 and later<br>Windows 8.1|
|Maximum OS version allowed|iOS 6 and later|Android 4.0 and later<br>Samsung KNOX Standard 4.0 and later|Windows Phone 8 and later<br>Windows 8.1|

Select one of the following to learn more about compliance settings supported on each platform:
> [!div class="op_single_selector"]
- [Compliance policy settings for iOS devices](ios-compliance-policy-settings-in-microsoft-intune.md)
- [Compliance policy settings for Android devices](android-compliance-policy-settings-in-microsoft-intune.md)
- [Compliance policy settings for Windows and Windows Phones ](windows-compliance-policy-settings-in-microsoft-intune.md)


## Next steps
[Deploy and monitor a compliance policy](deploy-and-monitor-a-device-compliance-policy-in-microsoft-intune.md)

### See also
[Introduction to device compliance policies](introduction-to-device-compliance-policies-in-microsoft-intune.md)
