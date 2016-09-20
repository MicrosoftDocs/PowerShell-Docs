---
# required metadata

title: Manage device settings with policies | Microsoft Intune
description: Use Intune to create and deploy policies that control settings and features on enrolled devices that you manage.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 09bae0b9-4f79-4658-8ca1-a71ab992c1b2

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: heenamac
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Manage settings and features on your devices with Microsoft Intune policies
Microsoft Intune *policies* are groups of settings that control features on mobile devices and computers. You create policies by using templates that contain recommended or custom settings, and then you deploy them to device or user groups.

## Types of policies

Intune policies fall into the following categories. The category that you use affects how you create and deploy the policy.


- **Configuration policies**: These are commonly used to manage security settings and features on your devices. Use the information in this topic to learn about how to create and deploy these policies and to explore the available settings.
- **Device compliance policies**: These define the rules and settings that a device must comply with in order to be considered compliant by conditional access polices. You can also use compliance policies to monitor and remediate  the compliance of devices independent of conditional access.
For details, see [Device compliance policies in Microsoft Intune](introduction-to-device-compliance-policies-in-microsoft-intune.md).
- **Conditional access polices**: These policies help you secure email and other services, depending on conditions that you specify.
For details, see [Restrict access to email and O365 services with Microsoft Intune](restrict-access-to-email-and-o365-services-with-microsoft-intune.md).
- **Corporate device enrollment policies**: For information about corporate device enrollment policies, see [Set up iOS and Mac management with Microsoft Intune](set-up-ios-and-mac-management-with-microsoft-intune.md).
- **Resource access policies**: These policies work together to help your users gain access to the files and resources that they need to do their work successfully, wherever they are.
For details, see [Enable access to company resources with Microsoft Intune](enable-access-to-company-resources-with-microsoft-intune.md).


For a complete list of Intune policies, see [Microsoft Intune policy reference](microsoft-intune-policy-reference.md).




## Create a configuration policy

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Policy** &gt; **Configuration Policies** &gt; **Add**.

2.  Choose the policy that you want, choose to use the recommended settings for the policy (if available; you can change these settings later), or choose to create a custom policy with your own settings.

	> [!TIP]
	> For help choosing the right policy, see the [Microsoft Intune policy reference](microsoft-intune-policy-reference.md).

3.  When you are ready, choose **Create Policy**.

4.  On the **Create Policy** page, configure a name and optional description for the policy.

5.  Configure the required policy settings, and then choose **Save Policy**.

	If you need help with any policy settings, choose your policy type from the following list:

	- [Settings for iOS devices](ios-policy-settings-in-microsoft-intune.md)
	- [Settings for Android devices](android-policy-settings-in-microsoft-intune.md)
	- [Settings for Windows 8 and Windows 8.1 devices](windows-configuration-policy-settings-in-microsoft-intune.md)
	- [Settings for Windows Phone 8.1 devices](windows-phone-8-1-policy-settings-in-microsoft-intune.md)
	- [Settings for Windows 10 desktop and mobile devices](windows-10-policy-settings-in-microsoft-intune.md)
	- [Settings for Windows Team devices](windows-team-configuration-policy-settings-in-microsoft-intune.md)
	- [Settings for Windows edition upgrade](edition-upgrade-policy-settings-in-microsoft-intune.md)
	- [Settings for Mac OS X devices](mac-os-x-policy-settings-in-microsoft-intune.md)
	- [Settings for Exchange ActiveSync](exchange-activesync-policy-settings-in-microsoft-intune.md)
	- [Settings for the terms and conditions policy](terms-and-condition-policy-settings-in-microsoft-intune.md)
	- [General settings for mobile devices (legacy)](mobile-device-security-policy-settings-in-microsoft-intune.md)

4.  In the confirmation dialog box, choose **Yes** to deploy the policy now, or choose **No** to create the policy without deploying it.

You can view and edit the new policy by browsing through the sections for each policy type in the **Policy** workspace.

When you create a policy that uses the recommended settings, the name of the new policy is a combination of the template name, date, and time. When you edit the policy, the name is updated with the time and date of the edit.

After you create a policy, you will typically want to deploy it to one or more groups of users or devices.

> [!TIP]
> You don't deploy all policy types. For example, the mobile application management (MAM) policy is not deployed. This policy type is instead associated with an app, which you then deploy.

## Deploy a configuration policy

1.  In the **Policy** workspace, select the policy that you want to deploy, and then choose **Manage Deployment**.

2.  In the **Manage Deployment** dialog box:

    -   To deploy the policy, select one or more groups to which you want to deploy the policy, and then choose **Add** &gt; **OK**.

    -   To close the dialog box without deploying the policy, choose **Cancel**.

When you select a deployed policy, you can view further information about the deployment in the lower part of the policies list.

## Manage policies

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Policy**, and then browse to and select the policy that you want to manage.

2.  Select one of the following actions:

- **Edit**: Open the properties for the selected policy so that you can make changes.
- **Delete**: Delete the selected policy.<br>When you delete a policy, it is removed from all groups to which it was deployed.
- **Manage Deployment**: Select the group that you want to deploy the policy to, and then choose **Add**.


## Frequently asked questions about Intune policies

### How long does it take for mobile devices to get a policy or apps after they have been deployed?
When a policy or an app is deployed, Intune immediately begins attempting to notify the device that it should check in with the Intune service. This typically takes less than five minutes.

If a device doesn't check in to get the policy after the first notification is sent, Intune makes three more attempts.  If the device is offline (for example, it is turned off or not connected to a network), it might not receive the notifications. In this case, the device will get the policy on its next scheduled check-in with the Intune service as follows:

- iOS and Mac OS X: Every 6 hours.
- Android: Every 8 hours.
- Windows Phone: Every 8 hours.
- Enrolled Windows RT devices: Every 24 hours.
- Windows 8.1 and Windows 10 PCs enrolled as devices: Every 8 hours.

If the device has just enrolled, the check-in frequency will be more frequent, as follows:

- iOS and Mac OS X: Every 15 minutes for 6 hours, and then every 6 hours.
- Android: Every 3 minutes for 15 minutes, then every 15 minutes for 2 hours, and then every 8 hours.
- Windows Phone: Every 5 minutes for 15 minutes, then every 15 minutes for 2 hours, and then every 8 hours.
- Windows PCs enrolled as devices: Every 3 minutes for 30 minutes, and then every 8 hours.

Users can also open the Company Portal app and sync the device to immediately check for the policy anytime.

### What actions cause Intune to immediately send a notification  to a device?
Devices check in with Intune either when they receive a notification that tells them to check in or during their regularly scheduled check-in.  When you target a device or user specifically with an action such as a wipe, lock, passcode reset, app deployment, profile deployment (Wi-Fi, VPN, email, etc.), or policy deployment, Intune will immediately begin trying to notify the device that it should check in with the Intune service to receive these updates.

Other changes, such as revising the contact information in the company portal, do not cause an immediate notification to devices.

### If multiple policies are deployed to the same user or device, how do I know which settings will get applied?
When two or more policies are deployed to the same user or device, the evaluation for which setting is applied happens at the individual setting level:

-   Compliance policy settings always have precedence over configuration policy settings.

-   The most restrictive compliance policy setting is applied if it is evaluated against the same setting in a different compliance policy.

-   If a configuration policy setting conflicts with a setting in a different configuration policy, this conflict will be displayed in the Intune console. You must manually resolve such conflicts.

### What happens when mobile application management policies conflict with each other? Which one will be applied to the app?
Conflict values are the most restrictive settings available in a MAM policy, except for the number entry fields (like PIN attempts before reset).  The number entry fields will be set the same as the values, as if you created a MAM policy in the console by using the recommended settings option.

Conflicts occur when two policy settings are the same.  For example, you configured two MAM policies that are identical except for the copy/paste setting.  In this scenario, the copy/paste setting will be set to the most restrictive value, but the rest of the settings will be applied as configured.

If one policy is deployed to the app and takes effect, and then a second one is deployed, the first one will take precedence and stay applied, while the second shows in conflict. If they are both applied at the same time, meaning that there is no preceding policy, then they will both be in conflict. Any conflicting settings will be set to the most restrictive values.

### What happens when iOS custom policies conflict?
Intune does not evaluate the payload of Apple Configuration files or a custom Open Mobile Alliance Uniform Resource Identifier (OMA-URI) policy. It merely serves as the delivery mechanism.

When you deploy a custom policy, ensure that the configured settings do not conflict with compliance, configuration, or other custom policies. In the case of a custom policy with settings conflicts, the order in which settings are applied is random.

### What happens when a policy is deleted or no longer applicable?
When you delete a policy, or you remove a device from a group to which a policy was deployed, the policy and settings will be removed from the device according to the following lists.

#### Enrolled devices

- Wi-Fi, VPN, certificate, and email profiles: These profiles are removed from all supported enrolled devices.
- All other policy types:
	- **Windows and Android devices**: Settings are not removed from the device.
	- **Windows Phone 8.1 devices**: The following settings are removed:
		- Require a password to unlock mobile devices
		- Allow simple passwords
		- Minimum password length
		- Required password type
		- Password expiration (days)
		- Remember password history
		- Number of repeated sign-in failures to allow before the device is wiped
		- Minutes of inactivity before password is required
		- Required password type – minimum number of character sets
		- Allow camera
		- Require encryption on mobile device
		- Allow removable storage
		- Allow web browser
		- Allow application store
		- Allow screen capture
		- Allow geolocation
		- Allow Microsoft account
		- Allow copy and paste
		- Allow Wi-Fi tethering
		- Allow automatic connection to free Wi-Fi hotspots
		- Allow Wi-Fi hotspot reporting
		- Allow factory reset
		- Allow Bluetooth
		- Allow NFC
		- Allow Wi-Fi

	- **iOS**: All settings are removed, except:
		- Allow voice roaming
		- Allow data roaming
		- Allow automatic synchronization while roaming

#### Windows PCs running the Intune client software

- **Endpoint Protection settings**: Settings are restored to their recommended values. The only exception is the **Join Microsoft Active Protection Service** setting, for which the default value is **No**. For details, see [Help secure Windows PCs with Endpoint Protection for Microsoft Intune](help-secure-windows-pcs-with-endpoint-protection-for-microsoft-intune.md).
- **Software updates settings**: Settings are reset to the default state for the operating system. For details, see [Keep Windows PCs up to date with software updates in Microsoft Intune](keep-windows-pcs-up-to-date-with-software-updates-in-microsoft-intune.md).
- **Microsoft Intune Center settings**: Any support contact information that was configured by the policy is deleted from computers.
- **Windows Firewall settings**: Settings are reset to the default for the computer operating system. For details, see [Help secure Windows PCs with Endpoint Protection for Microsoft Intune](help-secure-windows-pcs-with-endpoint-protection-for-microsoft-intune.md).


### How can I refresh the policies on a device to ensure that they are current (applies to Windows PCs running the Intune client software only)?

1.  In any device group, select the devices on which you want to refresh the policies, and then choose **Remote Tasks** &gt; **Refresh Policies**.
2.  Choose **Remote Tasks** in the lower-right corner of the Intune administration console to check the task status.

### Where can I find help troubleshooting policies?

See [Troubleshoot policies in Microsoft Intune](/intune/troubleshoot/troubleshoot-policies-in-microsoft-intune).
