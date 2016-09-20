---

# required metadata

title: Android and Samsung KNOX policy settings | Microsoft Intune
description: Create policies that control settings and features on Android devices that you manage with Intune.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 71cc39cf-e726-40fd-8d08-78776e099a4b

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: heenamac
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Android and Samsung KNOX policy settings in Microsoft Intune

Intune supplies a range of built-in general settings that you can configure on Android devices. Additionally, you can specify Open Mobile Alliance Uniform Resource Identifier (OMA-URI) values to create custom settings that are not available from Intune.

## General configuration policy

Use the Intune **Android general configuration policy** to configure settings for:

-   **Mobile device security settings** - Choose from a list of predefined settings that let you control a range of features and functionality on the device.

-   **Kiosk mode** (for Samsung KNOX devices only) - Lock a device to allow only certain features to work. For example, you can allow a device to run only one managed app that you specify, or you can disable the volume buttons on a device. These settings might be used for a demonstration model of a device or a device that is dedicated to performing only one function, such as a point-of-sale device.

-   **Compliant and noncompliant apps** - Specify a list of apps that are compliant or noncompliant in your company. On Android and iOS devices, the **Noncompliant Apps Report** can be used to view the compliance of apps that you specified in the list against the apps that users have installed. The report can't actually block the installation of the app.

> [!TIP]
> You can configure terms and conditions for users to ensure that they acknowledge that all apps on their device, including personal apps, will be evaluated, and that noncompliant apps will either be blocked or reported as noncompliant. Users must accept these terms and conditions before they can enroll their device and use the company portal to get apps. For more information about using terms and conditions, see [Terms and condition policy settings in Microsoft Intune](terms-and-condition-policy-settings-in-microsoft-intune.md).

If the setting you are looking for does not appear in this topic, you might be able to create it by using an Android custom policy that lets you use OMA-URI settings to control the device. For more information, go to [Custom policy settings](#custom-policy-settings) later in this topic.

### Password settings

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|-|----------------|----------------|
|**Require a password to unlock mobile devices**|Specifies whether to require a password on supported devices.|Yes|Yes|
|**Minimum password length**|Specifies the minimum length of the password.|Yes|Yes|
|**Number of repeated sign-in failures to allow before the device is wiped**|Specifies the number of sign-in failures to allow before the device is wiped.|Yes|Yes|
|**Minutes of inactivity before screen turns off**|Specifies the number of minutes of inactivity before the device automatically locks.|Yes|Yes|
|**Password expiration (days)**|Specifies the number of days before a password must be changed.|Yes|Yes|
|**Remember password history**|Specifies the number of previously used passwords to remember.|Yes|Yes|
|**Remember password history** - **Prevent reuse of previous passwords**|Prevents reuse of previous passwords.|Yes|Yes|
|**Password quality**|Specifies the password complexity level that's required and whether biometric devices can be used.|Yes|Yes|
|**Allow fingerprint unlock**|Allows the use of a fingerprint to unlock the device.|No|Yes|
|**Allow Smart Lock and other trust agents**<br>(Android 5 and later)|Lets you control the Smart Lock feature on compatible Android devices. This phone capability, sometimes known as a trust agent, lets you disable or bypass the device lock screen password if the device is in a trusted location (for example, when it's connected to a specific Bluetooth device, or when it's close to an NFC tag.) You can use this setting to prevent users from configuring Smart Lock.|Yes|No|

### Encryption settings

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|---|-------------|----------------|
|**Require encryption on mobile device**|Requires that files on the mobile device are encrypted.|Yes|Yes|
|**Require encryption on storage cards**|Specifies whether the device storage card must be encrypted.|No|Yes|

### System settings

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|---|-------------|----------------|
|**Allow screen capture**|Lets the user capture the screen contents as an image.|No|Yes|
|**Allow diagnostic data submission**|Allows the device to submit diagnostic information to Google.|No|Yes|
|**Allow factory reset**|Allows the user to perform a factory reset on the device.|No|Yes|

### Cloud settings - documents and data

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|----|------------------------|----------------|
|**Allow Google backup**|Allows the use of Google backup.|No|Yes|

### Cloud settings - accounts and synchronization

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|-----|-----------|----------------|
|**Allow Google account auto sync**|Allows Google account settings to be automatically synchronized.|No|Yes|

### Application settings - browser

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|-----|-----------|----------------|
|**Allow web browser**|Specifies whether the device's default web browser can be used.|No|Yes|
|**Allow autofill**|Allows the autofill function of the web browser to be used.|No|Yes|
|**Allow pop-up blocker**|Allows the use of the pop-up blocker in the web browser.|No|Yes|
|**Allow cookies**|Allows the device web browser to use cookies.|No|Yes|
|**Allow active scripting**|Allows the device web browser to use active scripting.|No|Yes|

### Application settings - apps

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|----|------------|----------------|
|**Allow Google Play store**|Allows the user to access the Google Play store on the device.|No|Yes|

### Device capabilities settings - hardware

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|-----|-----------|----------------|
|**Allow camera**|Allows the use of the device camera.|Yes|Yes|
|**Allow removable storage**|Allows the device to use removable storage, like an SD card.|No|Yes|
|**Allow Wi-Fi**|Allows the use of the Wi-Fi capabilities of the device.|No|Yes|
|**Allow Wi-Fi tethering**|Allows the use of Wi-Fi tethering on the device.|No|Yes|
|**Allow geolocation**|Allows the device to utilize location information.|No|Yes|
|**Allow NFC**|Allows operations that use near field communication if the device supports it.|No|Yes|
|**Allow Bluetooth**|Allows the use of Bluetooth on the device.|No|Yes|
|**Allow power off**|Allows the user to power off the device.<br /><br />If this setting is disabled, the setting **Number of repeated sign in failures to allow before the device is wiped** for Samsung KNOX devices does not function.|No|Yes|

### Device capabilities settings - cellular

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|---|-------------|----------------|
|**Allow voice roaming**|Allows voice roaming when the device is on a cellular network.|No|Yes|
|**Allow data roaming**|Allows data roaming when the device is on a cellular network.|No|Yes|
|**Allow SMS/MMS messaging**|Allows the use of SMS and MMS messaging on the device.|No|Yes|

### Device capabilities settings - features

|Setting name|Details|Android 4.0+|Samsung KNOX|
|----------------|----|------------|----------------|
|**Allow voice assistant**|Allows the use of voice assistant software on the device.|No|Yes|
|**Allow voice dialing**|Enables or disables the voice dialing feature on the device.|No|Yes|
|**Allow copy and paste**|Allows copy and paste functions on the device.|No|Yes|
|**Allow clipboard share between applications**|Allows use of the clipboard to copy and paste between apps.|No|Yes|
|**Allow YouTube**|Allows the use of YouTube on the device.|No|Yes|

### Settings for compliant and noncompliant apps
In the **Compliant &amp; Noncompliant Apps** list, specify a list of compliant or noncompliant apps that use the following information:

> [!NOTE]
> A single policy can contain only a list of compliant apps or a list of noncompliant apps. You cannot specify both in the same policy.

|Setting name|Details|
|----------------|--------------------|
|**Report noncompliance when users install the listed apps**|Lists the apps that are not managed by Intune and which you do not want users to install and run. If users install one of these apps, it will be listed in the noncompliant apps report.|
|**Do not report noncompliance when users install the listed apps**|Lists the apps that you want to allow. To remain compliant, users must not install any apps that are not listed. Apps that are managed by Intune are automatically allowed.|
|**Add**|Adds an app to the selected list. Specify the name of the app, the app publisher (optional), and the URL of the app in the app store.<br /><br />For more information, see [Specify URLs to app stores](#specify-urls-to-app-stores) later in this topic.|
|**Import Apps**|Imports a list of apps that you have specified in a comma-separated values file. Use the format, application name, publisher, and app URL in the file.|
|**Edit**|Lets you edit the name, publisher, and URL of the selected app.|
|**Delete**|Deletes the selected app from the list.|

### Kiosk mode settings
Specify the following settings for **Samsung KNOX devices**:

|Setting name|Details|
|----------------|--------------------|
|**Select a managed app that can run when the device is in kiosk mode**|Choose **Browse**, and then select the managed app that can run when the device is in kiosk mode (apps specified as a link to the store are not currently supported). No other apps will be allowed to run on the device.|
|**Allow volume buttons**|Enables or disables the use of the volume buttons on the device.|
|**Allow screen sleep wake button**|Enables or disables the screen sleep wake button on the device.|

### Reference information for compliant and noncompliant apps

#### Monitor compliant and noncompliant apps
Use the **Noncompliant Apps Report** to view the compliance of allowed and blocked apps.

###### To run the Noncompliant Apps Report

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Reports** &gt; **Noncompliant Apps Report**.

2.  Select the device groups that you want to check. Then choose whether you want to check for compliant apps, noncompliant apps, or both. Finally, choose **View Report**.

#### Specify URLs to app stores
To specify an app URL in the compliant and noncompliant apps list, take the following steps:

In the [Apps section of Google Play](https://play.google.com/store/apps), search for the app you want to use.

Open the installation page for the app, and then copy the URL to the clipboard. You can now use this as the URL in either the compliant or noncompliant apps list.

Example: Search Google Play for Microsoft Office Mobile. The URL you use will be **https://play.google.com/store/apps/details?id=com.microsoft.office.officehub**.

## Custom policy settings
Use the Microsoft Intune **Android custom configuration policy** to deploy OMA-URI settings that can be used to control features on Android devices. These are standard settings that many mobile device manufacturers use to control device features.

This capability is intended to allow you to deploy Android settings that are not configurable with Intune policies.

> [!NOTE]
> Currently, Android custom policies only support configuring Wi-Fi settings for Android devices that include a pre-shared key.

### General settings

|Setting name|Details|
    |----------------|--------------------|
    |**Name**|Enter a unique name for the Android custom policy to help you identify it in the Intune console.|
    |**Description**|Provide a description that gives an overview of the Android custom policy and other relevant information that helps you to locate it.|

### OMA-URI settings

   |Setting name|Details|
    |--------|--------------------|
    |**Setting name**|Enter a unique name for the OMA-URI setting to help you identify it in the list of settings.|
    |**Setting description**|Provide a description that gives an overview of the setting and other relevant information to help you locate it.|
    |**Data type**|Select the data type in which you will specify this OMA-URI setting. Choose from **String, String (XML), Date and time, Integer, Floating point**, or **Boolean**.|
    |**OMA-URI (case sensitive)**|Specify the OMA-URI you want to supply a setting for.|
    |**Value**|Specify the value to associate with the OMA-URI that you specified previously.|

### Examples

- [Create a Wi-Fi profile with a pre-shared key](pre-shared-key-wi-fi-profile.md)
- [Use a custom policy to create a per-app VPN profile for Android devices](per-app-vpn-for-android-pulse-secure.md)
- [Use custom policies to allow and block apps for Samsung KNOX devices](custom-policy-to-allow-and-block-samsung-knox-apps.md)

### See also
[Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md)
