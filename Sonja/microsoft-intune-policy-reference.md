---
# required metadata


title: Configuration policy reference | Microsoft Intune
description: Use the information in this topic to help you decide which Microsoft Intune policy you need to use to manage your devices.

keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: d27f2739-9791-4aae-a9db-01a4e59ccfe5

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: heenamac
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Microsoft Intune configuration policy reference

Use the information in this topic to help you decide which Microsoft Intune configuration policy you need to use to manage your devices.

> [!TIP]
> For more detailed information about how to use policies, see [Manage settings and features on your devices with Microsoft Intune Policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md).


## Android configuration policies

|Policy name|Use when you want to|
|---------------|------------------------|
|**Custom Configuration (Android 4 and later, Samsung KNOX Standard 4.0 and later)**|Deploy Open Mobile Alliance Uniform Resource Identifier (OMA-URI) settings, such as Wi-Fi settings that can be used to control device features. This is useful when the setting that you need is not available in a configuration policy.<br /><br />For details, see [Android policy settings in Microsoft Intune](android-policy-settings-in-microsoft-intune.md).|
|**Email Profile (Samsung KNOX Standard 4.0 and later)**|Create, deploy, and monitor Exchange ActiveSync email settings on managed devices. This lets users access corporate email on their personal devices without any required setup on their part.<br /><br />For details, see [Configure access to corporate email using email profiles with Microsoft Intune](configure-access-to-corporate-email-using-email-profiles-with-microsoft-intune.md).|
|**General Configuration (Android 4 and later, Samsung KNOX Standard 4.0 and later)**|Configure mobile device security and functional settings.<br />Specify apps that are compliant or noncompliant, and report when they are used.<br />Configure kiosk mode that locks devices to allow only certain features to work, for example, allow the device to run only one app, or disable the volume buttons.<br /><br />For details, see [Android policy settings in Microsoft Intune](android-policy-settings-in-microsoft-intune.md).|
|**PKCS #12 (.PFX) Certificate Profile (Android 4 and later)**|Use this profile to create and deploy .PFX settings for device certificate requests.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**SCEP Certificate Profile (Android 4 and later)**|Configure a Simple Certificate Enrollment Protocol certificate which can be used with a trusted mobile device certificate to authenticate mobile devices to allow them to access network resources such as those configured by Wi-Fi and VPN profiles.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**Trusted Certificate Profile (Android 4 and later)**|Configure a trusted mobile device certificate which can be used to authenticate mobile devices to allow them to access network resources such as those configured by Wi-Fi and VPN profiles.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**VPN Profile (Android 4 and later)**|Configure and deploy settings that give users secure access to your company network from their mobile device. By deploying these settings, you simplify connections for end-users to their work.<br /><br />For details, see [VPN connections in Microsoft Intune.md](vpn-connections-in-microsoft-intune.md).|
|**Wi-Fi Profile (Android 4 and later)**|Configure and deploy wireless network settings to users in your organization. By deploying these settings, you simplify connections for end-users to the wireless network.<br /><br />For details, see [Wi-Fi connections in Microsoft Intune](wi-fi-connections-in-microsoft-intune.md).|

## iOS configuration policies

|Policy name|Use when you want to|
|---------------|------------------------|
|**Custom Configuration (iOS 8.0 and later)**|Deploy configuration profiles to iOS devices that you created using Apple Configurator. This is useful when the setting that you need is not available in a configuration policy.<br /><br />For details, see [iOS policy settings in Microsoft Intune](ios-policy-settings-in-microsoft-intune.md).|
|**Email Profile (iOS 8.0 and later)**|Create, deploy, and monitor Exchange ActiveSync email settings on managed devices. This lets users access corporate email on their personal devices without any required setup on their part.<br /><br />For details, see [Configure access to corporate email using email profiles with Microsoft Intune](configure-access-to-corporate-email-using-email-profiles-with-microsoft-intune.md).|
|**General Configuration (iOS 8.0 and later)**|Configure mobile device security and functional settings.<br />Specify apps that are compliant or noncompliant, and report when they are used.<br />Configure kiosk mode that locks devices to allow only certain features to work, for example, allow the device to run only one app, or disable the volume buttons.<br /><br />For details, see [iOS policy settings in Microsoft Intune](ios-policy-settings-in-microsoft-intune.md).|
|**Mobile App Configuration Policy (iOS 8.0 and later)**|Use mobile app configuration policies to automatically supply settings that might be required when the user runs an iOS app.<br /><br />For details, see [Configure iOS apps with mobile app configuration policies in Microsoft Intune](configure-ios-apps-with-mobile-app-configuration-policies-in-microsoft-intune.md).|
|**Mobile provisioning Profile Policy (iOS 8.0 and later)**|Apple iOS line-of-business mobile apps are built with a provisioning profile that's included and code signed with a certificate. When the app is run on an iOS device, iOS confirms the integrity of the iOS app and enforces policies that the provisioning profile defines.<br><br>The enterprise signing certificate that you use to sign apps typically lasts for three years. However, the provisioning profile expires after one year. Use this policy to proactively deploy a new provisioning profile policy to devices that have apps that are near expiry while the certificate is still valid.<br><br>For details, see [Use iOS mobile provisioning profile policies to prevent your apps from expiring](ios-mobile-app-provisioning-profiles.md).|
|**PKCS #12 (.PFX) Certificate Profile (iOS 8.0 and later)**|Use this profile to create and deploy .PFX settings for device certificate requests.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**SCEP Certificate Profile (iOS 8.0 and later)**|Configure a Simple Certificate Enrollment Protocol certificate that can be used with a trusted mobile device certificate to authenticate mobile devices to allow them to access network resources such as those configured by Wi-Fi and VPN profiles.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**Trusted Certificate Profile (iOS 8.0 and later)**|Configure a trusted mobile device certificate that can be used to authenticate mobile devices to allow them to access network resources such as those configured by Wi-Fi and VPN profiles.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**VPN Profile (iOS 8.0 and later)**|Configure and deploy settings that give users secure access to your company network from their mobile devices. By deploying these settings, you simplify connections for end-users to their work.<br /><br />For details, see [VPN connections in Microsoft Intune.md](vpn-connections-in-microsoft-intune.md).|
|**Wi-Fi Profile (iOS 8.0 and later)**|Configure and deploy wireless network settings to users in your organization. By deploying these settings, you simplify connections for end-users to the wireless network.<br /><br />For details, see [Wi-Fi connections in Microsoft Intune](wi-fi-connections-in-microsoft-intune.md).|


## Mac OS X configuration policies

|Policy name|Use when you want to|
|---------------|------------------------|
|**Custom Configuration (Mac OS X 10.9 and later)**|Deploy configuration profiles to Mac computers that you created using Apple Configurator. This is useful when the setting that you need is not available in a configuration policy.<br /><br />For details, see [Mac OS X policy settings in Microsoft Intune](mac-os-x-policy-settings-in-microsoft-intune.md).|
|**General Configuration (Mac OS X 10.9 and later)**|Configure mobile device security and functional settings.<br />Specify apps that are compliant or noncompliant, and report when they are used.<br /><br />For details, see [Mac OS X policy settings in Microsoft Intune](mac-os-x-policy-settings-in-microsoft-intune.md).|
|**SCEP Certificate Profile  (Mac OS X 10.9 and later)**|Configure a Simple Certificate Enrollment Protocol certificate that can be used with a trusted mobile device certificate to authenticate mobile devices to allow them to access network resources such as those configured by Wi-Fi and VPN profiles.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**Trusted Certificate Profile (Mac OS X 10.9 and later)**|Configure a trusted mobile device certificate that can be used to authenticate mobile devices to allow them to access network resources such as those configured by Wi-Fi and VPN profiles.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**VPN Profile  (Mac OS X 10.9 and later)**|Configure and deploy settings that give users secure access to your company network from their mobile devices. By deploying these settings, you simplify connections for end-users to their work.<br /><br />For details, see [VPN connections in Microsoft Intune.md](vpn-connections-in-microsoft-intune.md).|
|**Wi-Fi Profile (Mac OS X 10.9 and later)**|Configure and deploy wireless network settings to users in your organization. By deploying these settings, you simplify connections for end-users to the wireless network.<br /><br />For details, see [Wi-Fi connections in Microsoft Intune](wi-fi-connections-in-microsoft-intune.md).|

## Windows configuration policies
Applies to Windows Phone and enrolled Windows devices only.

|Policy name|Use when you want to|
|---------------|------------------------|
|**Custom Configuration  (Windows 10 Desktop and Mobile and later)**|Deploy OMA-URI settings that can be used to control device features. This is useful when the setting that you need is not available in a configuration policy.<br />    For details, see [Windows 10 policy settings in Microsoft Intune](windows-10-policy-settings-in-microsoft-intune.md).|
|**Custom Configuration (Windows Phone 8.1 and later)**|Deploy OMA-URI settings that can be used to control device features. This is useful when the setting that you need is not available in a configuration policy.<br /><br />For details, see [Windows Phone 8.1 settings in Microsoft Intune](windows-phone-8-1-policy-settings-in-microsoft-intune.md).|
|**Edition Upgrade Policy (Windows 10 Desktop and later)**<br><br>**Edition Upgrade Policy (Windows 10 Holographic and later)**<br><br>**Edition Upgrade Policy (Windows 10 Mobile and later)**|Configure and deploy policies that contain license or product key information that is used to update Windows 10 devices to a newer version.<br><br>For details, see [Edition upgrade policy settings in Microsoft Intune](edition-upgrade-policy-settings-in-microsoft-intune.md).|  
|**Email Profile (Windows Phone 8 and later)**<br /><br />**Email Profile (Windows 10 Desktop and Mobile and later)**|Create, deploy, and monitor Exchange ActiveSync email settings on managed devices. This lets users access corporate email on their personal devices without any required setup on their part.<br /><br />For details, see [Configure access to corporate email using email profiles with Microsoft Intune](configure-access-to-corporate-email-using-email-profiles-with-microsoft-intune.md).|
|**General Configuration (Windows 10 Desktop and Mobile and later)**|Configure mobile device security and functional settings for enrolled Windows 10 desktop and Mobile devices.<br /><br />For details, see [Windows 10 policy settings in Microsoft Intune](windows-10-policy-settings-in-microsoft-intune.md).|
|**General Configuration (Windows 10 Team and later)**|Configure device security and functional settings for enrolled Windows 10 Team devices (for example, a Surface Hub device).<br /><br />For details, see [Windows Team configuration policy settings in Microsoft Intune](windows-team-configuration-policy-settings-in-microsoft-intune.md).|
|**General Configuration (Windows 8.1 and later)**|Configure mobile device security and functional settings for enrolled Windows devices.<br /><br />For details, see [Windows policy settings in Microsoft Intune](windows-configuration-policy-settings-in-microsoft-intune.md).|
|**General Configuration (Windows Phone 8.1 and later)**|Configure mobile device security and functional settings.<br />Specify apps that users can or cannot use, and block noncompliant apps from being installed or used.<br /><br />For details, see [Windows Phone 8.1 settings in Microsoft Intune](windows-phone-8-1-policy-settings-in-microsoft-intune.md).|
|**PKCS #12 (.PFX) Certificate Profile (Windows 10 Desktop and Mobile and later)**|Use this profile to create and deploy .PFX settings for device certificate requests.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**SCEP Certificate Profile (Windows 8.1 and later)**<br /><br />**SCEP Certificate Profile (Windows Phone 8.1 and later)**|Configure a Simple Certificate Enrollment Protocol certificate that can be used with a trusted mobile device certificate to authenticate mobile devices to allow them to access network resources such as those configured by Wi-Fi and VPN profiles.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**Trusted Certificate Profile (Windows 8.1 and later)**<br /><br />**Trusted Certificate Profile (Windows Phone 8.1 and later)**|Configure a trusted mobile device certificate which can be used to authenticate mobile devices to allow them to access network resources such as those configured by Wi-Fi and VPN profiles.<br /><br />For details, see [Secure resource access with certificate profiles in Microsoft Intune](secure-resource-access-with-certificate-profiles.md).|
|**VPN Profile (Windows 10 Desktop and Mobile and later)**<br /><br />**VPN Profile (Windows 8.1 and later)**<br /><br />**VPN Profile (Windows Phone 8.1 and later)**|Configure and deploy settings that give users secure access to your company network from their mobile devices. By deploying these settings, you simplify connections for end-users to their work.<br /><br />For details, see [VPN connections in Microsoft Intune](vpn-connections-in-microsoft-intune.md).|
|**Wi-Fi Import**|Import and deploy Windows Wi-Fi configurations that you have previously exported to a file.<br /><br />For details, see [Wi-Fi connections in Microsoft Intune](wi-fi-connections-in-microsoft-intune.md).|
|**Windows Information Protection**<br>(formerly known as enterprise data protection)|With the increase of employee-owned devices in the enterprise, there’s also an increasing risk of accidental data leaks through apps and services, like email, social media, and the public cloud, which are outside of the enterprise’s control. For example, an employee sends the latest engineering pictures from a personal email account, copies and pastes product info into a tweet, or saves an in-progress sales report to public cloud storage.<br><br>Windows Information Protection helps to protect against this potential data leakage without otherwise interfering with the employee experience. It also helps to protect enterprise apps and data against accidental data leaks on enterprise-owned devices and personal devices that employees bring to work without requiring changes to your environment or other apps.<br><br>This Intune policy manages the list of apps protected by Windows Information Protection, enterprise network locations, protection level, and encryption settings.<br><br>For more information, see [Protect your enterprise data using Windows Information Protection](https://technet.microsoft.com/itpro/windows/keep-secure/protect-enterprise-data-using-edp).|


## Software policies

|Policy name|Use when you want to|
|---------------|------------------------|
|**Managed Browser Policy (Android 4 and later)**<br /><br />**Managed Browser Policy (iOS 8.0 and later)**|Specify the websites that users can and cannot access when they are using the managed browser app.<br /><br />For details, see [Manage Internet access using managed browser policies with Microsoft Intune](manage-internet-access-using-managed-browser-policies.md).|
|**Mobile Application Management (Android 4 and later)**<br /><br />**Mobile Application Management Policy (iOS 8.0 and later)**|Modify the functionality of apps that you deploy to help bring them into line with your company compliance and security policies. For example, you can restrict cut, copy, and paste operations within a restricted app, or configure an app to open all web links inside the managed browser.<br /><br />For details, see [Configure and deploy mobile application management policies in the Microsoft Intune console](configure-and-deploy-mobile-application-management-policies-in-the-microsoft-intune-console.md)|

## Common Mobile Device Settings

|Policy name|Use when you want to|
|---------------|------------------------|
|**Exchange ActiveSync Policy**|Configure mobile device security and functional settings for devices that are managed by Exchange ActiveSync.<br /><br />For details, see [Exchange ActiveSync policy settings in Microsoft Intune](exchange-activesync-policy-settings-in-microsoft-intune.md).|
|**Mobile Device Security Policy**|<ul><li>Configures settings for mobile devices (all platforms) including:<br /><br /><ul><li>Security</li><li>Encryption</li><li>System</li><li>Email</li><li>Applications</li></ul></li></ul>
> [!IMPORTANT]
Microsoft Intune now features separate **configuration policies** for each device platform, and these policies contain the most up-to-date settings that you can use. You can continue to use the mobile device security policy and any existing deployments will still work, but you should plan to migrate to the new configuration policies as soon as possible.<br />For details, see [Mobile device security policy settings in Microsoft Intune](mobile-device-security-policy-settings-in-microsoft-intune.md).|

## Policies for Windows PCs managed by the Intune software client

|Policy name|Use when you want to|
|---------------|------------------------|
|**Microsoft Intune Agent Settings**|Configure the Intune PC client on computers, including settings for:<br /><br />-   Endpoint Protection<br />-   Software updates<br />-   Policy check schedule<br /><br />This type of policy can be deployed only to groups of devices.<br /><br />Intune clients download new and updated policy according to the **Update and application detection frequency** setting, which defaults to eight hours. However, you can force a refresh of policy on computers at any time.<br /><br />For details, see [Keep Windows PCs up to date with software updates in Microsoft Intune](keep-windows-pcs-up-to-date-with-software-updates-in-microsoft-intune.md).|
|**Microsoft Intune Center Settings**|Configure details that appear in the Microsoft Intune Center on managed computers.<br /><br />This type of policy can be deployed only to groups of devices.<br /><br />For details, see [Common Windows PC management tasks with the Microsoft Intune computer client](common-windows-pc-management-tasks-with-the-microsoft-intune-computer-client.md).|
|**Windows Firewall Settings**|Configures Windows Firewall settings and exceptions for common network communications on computers, including:<br /><br />-   BranchCache<br />-   Remote assistance<br />-   Media sharing<br /><br />This type of policy can be deployed only to groups of devices.<br /><br />For details, see [Help secure Windows PCs with Endpoint Protection for Microsoft Intune](help-secure-windows-pcs-with-endpoint-protection-for-microsoft-intune.md).|

### See also

[Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md)
