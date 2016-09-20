---
# required metadata

title: Prepare apps for mobile application management | Microsoft Intune
description: The information in this topic helps you decide when you should use the App wrapping tool and the App SDK to enable your custom line of business apps to use the mobile app management policies.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 09/13/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 29e22121-8268-48b5-a671-f940a6be1d24

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: oldang
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Decide how to prepare apps for mobile application management with Microsoft Intune
You can enable your apps to use mobile application management (MAM) policies by using either the Intune App Wrapping Tool or the Intune App SDK. Use this information to learn about these two methods and when to use them.

## Intune App Wrapping Tool
The App Wrapping Tool is used primarily for internal line-of-business (LOB) apps. The tool is a command line application that creates a wrapper around the app, which then allows the app to be managed by an Intune mobile application management policy. You don't need the source code to use the tool, but you do need signing credentials.  For more about signing credentials, see the [Intune blog](https://blogs.technet.microsoft.com/enterprisemobility/2015/02/25/how-to-obtain-the-prerequisites-for-the-intune-app-wrapping-tool-for-ios/). For the App Wrapping Tool documentation, see [Android App Wrapping Tool ](prepare-android-apps-for-mobile-application-management-with-the-microsoft-intune-app-wrapping-tool.md) and [iOS App Wrapping Tool](prepare-ios-apps-for-mobile-application-management-with-the-microsoft-intune-app-wrapping-tool.md).

The App Wrapping Tool does not support Apps in the App or Play Store or features that require development time integration (see the following feature comparison table).

You should use the App Wrapping Tool, rather than the SDK, if the  app has already been written or if the source code isn't available.

**The App Wrapping Tool for MAM on devices that are not enrolled in Intune is currently supported in public preview. For more information, see [Protect LOB apps on devices not enrolled in Intune](protect-line-of-business-apps-and-data-on-devices-not-enrolled-in-microsoft-intune.md) topic**.

### Supported Platforms

|**App Wrapping Tool** | **Xamarin** |**Cordova** |
|------|----|----|
|**iOS** |Yes|Yes|
|**Android**| No |Yes|
## Intune App SDK
The App SDK is designed mainly for customers who have apps in the App or Play stores and want to be able to manage the apps with Intune. However, any app can take advantage of integrating the SDK, even if it’s a LOB app.

To learn more about the SDK, see the [Overview](/intune/develop/intune-app-sdk). To get started with the SDK, see [Getting Started With the Microsoft Intune App SDK](/intune/develop/intune-app-sdk-get-started).

### Supported Platforms
|**Intune App SDK** |**Xamarin** |**Cordova**
|------|----|----|
|**iOS**|Yes – use the Intune App SDK Xamarin component|Yes – use the Intune App SDK Cordova plugin|
|**Android**| Yes – use the Intune App SDK Xamarin Component|Yes – use the Intune App SDK Cordova plugin|

## Feature comparison
This table lists the settings that you can use for the App SDK and App Wrapping Tool.

> [!NOTE]
> The App Wrapping Tool can be used with Intune Standalone or Intune with Configuration Manager.

|Feature|App SDK|App Wrapping Tool|
|-----------|---------------------|-----------|
|Restrict web content to display in a corporate managed browser|X|X|
|Prevent Android, iTunes or iCloud backups|X|X|
|Allow app to transfer data to other apps|X|X|
|Allow app to receive data from other apps|X|X|
|Restrict cut, copy and paste with other apps|X|X|
|Require simple PIN for access|X|X|
|Replace built-in app PIN with Intune PIN|X||
|Specify the number of attempts before PIN reset|X|X|
|Require fingerprint instead of PIN (iOS only)<br></br>**Note:** Only available in MAM-only environments.|X||
|Require corporate credentials for access|X|X|
|Block managed apps from running on jailbroken or rooted devices|X|X|
|Encrypt app data|X|X|
|Recheck the access requirements after a specified number of minutes|X|X|
|Specify the offline grace period|X|X|
|Block screen capture (Android only)|X|X|
|Full Wipe|X|X|
|Selective Wipe <br></br>**Note:** For iOS, when the management profile is removed, the app is also removed.|X||
|Prevent “Save as” |X||
|Support for Multi-Identity|X||
### See also

[Android app wrapping tool](prepare-android-apps-for-mobile-application-management-with-the-microsoft-intune-app-wrapping-tool.md)</br>
[iOS app wrapping tool](prepare-ios-apps-for-mobile-application-management-with-the-microsoft-intune-app-wrapping-tool.md)</br>
[Use the SDK to enable apps for mobile application management](use-the-sdk-to-enable-apps-for-mobile-application-management.md)
