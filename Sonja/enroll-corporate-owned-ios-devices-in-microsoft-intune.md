---
# required metadata

title: Enroll corporate-owned iOS devices | Microsoft Intune
description: Enrollment of corporate-owned iOS devices by using the Apple Device Enrollment Program (DEP) or Apple Configurator
keywords:
author: NathBarn
manager: angrobe
ms.date: 09/07/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 2d3ca4ab-f20c-4d56-9413-f8ef19cf0722

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: dagerrit
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Enroll corporate-owned iOS devices in Microsoft Intune
Microsoft Intune supports the enrollment of corporate-owned iOS devices through the Apple Device Enrollment Program (DEP) or the [Apple Configurator](http://go.microsoft.com/fwlink/?LinkId=518017) tool running on a Mac computer.

**Prerequisite:** An [Apple Push Notification service  certificate](set-up-ios-and-mac-management-with-microsoft-intune.md) is required.

You can enroll corporate-enrolled iOS devices in three ways: by using Apple Configurator, DEP, or the Company Portal.

## Use Apple Configurator

You can enroll iOS devices by exporting a Corporate Enrollment profile and then connecting those mobile devices to a Mac that is running Apple Configurator. Apple Configurator supports two forms of enrollment:

- **Setup Assistant enrollment**: Resets the device to factory settings and prepares it for setup by the device's new user. This method requires the admin to connect the iOS device through USB to a Mac computer running [Apple Configurator](http://go.microsoft.com/fwlink/?LinkId=518017) to preconfigure the enrollment. Devices are then delivered to their users, who run the Setup Assistant process. This process configures the device with their work or school credentials and completes the enrollment process. For more information, see [Enroll iOS devices using Apple Configurator and Setup Assistant](ios-setup-assistant-enrollment-in-microsoft-intune.md).

- **Direct enrollment**: Creates an Apple Configurator–compliant file for use during device preparation. The enrolled device isn’t factory reset, but it has no user affiliation. This method requires the admin to connect the iOS device through USB to a Mac computer running [Apple Configurator](http://go.microsoft.com/fwlink/?LinkId=518017) to enroll the device. For more information, see [Enroll iOS devices using Apple Configurator Direct Enrollment](ios-direct-enrollment-in-microsoft-intune.md).

## Use the Device Enrollment Program (DEP)
DEP deploys an enrollment profile “over the air” to devices that are purchased through DEP. When a user runs Setup Assistant on the device, the device is enrolled in Intune.  Devices enrolled through DEP cannot be unenrolled by users. For more information, see [Enroll Device Enrollment Program iOS devices](ios-device-enrollment-program-in-microsoft-intune.md).

## Use the Company Portal on DEP-enrolled or Apple Configurator-enrolled devices

Devices that are configured with user affinity can install and run the Company Portal app to download apps and manage devices. After users receive their devices, they must complete a number of additional steps to complete the Setup Assistant and install the Company Portal app.

User affinity is required to support the following:
  - Mobile application management (MAM) apps
  -	Conditional access to email and company data
  -	Company Portal app

**How users enroll corporate-owned iOS devices with user affinity**
1. When users turn on their device, they are prompted to complete the Setup Assistant. During setup, users are prompted for their credentials. They must use the credentials (i.e. the unique personal name or UPN) that are associated with their subscription in Intune.

2. During setup, users are prompted for an Apple ID. They must provide an Apple ID to allow the device to install the Company Portal. They can also provide the ID from the iOS settings menu after setup is finished.

3. After completing setup, the iOS device must install the Company Portal app from the App Store.

4. The user can now sign in to the Company Portal by using the UPN that they used when setting up the device.

5. After logging in, the user is prompted to enroll their device. The first step is to identify their device. The app presents a list of iOS devices that have already been corporate enrolled and assigned to the user’s Intune account. They should choose the matching device.

  If this device is not already corporate enrolled, they should choose **new device** to continue with the standard enrollment flow.

6. On the next screen, the user must confirm the serial number of the new device. The user can tap the link **confirm the Serial Number** to launch the Settings app to verify the serial number. The user must then enter the last four characters of the serial number into the Company Portal app.

  This step verifies that the device is the corporate device enrolled in Intune. If the serial number on the device does not match, the wrong device was selected. The user should go back to the previous screen and select a different device.

7. After the serial number is verified, the Company Portal app redirects to the Company Portal website to finalize enrollment. Then the website prompts the user to return to the app.

8. Enrollment is now complete. The user can now use this device with the full set of capabilities.

### About corporate-owned managed devices with no user affinity

Devices that are configured with no user affinity do not support the Company Portal and should not have the app installed. The Company Portal is designed for users who have corporate credentials and require access to personalized corporate resources (e.g. email). Devices that are enrolled with no user affinity are not intended to have a dedicated user sign in. Kiosk, point of sale (POS), or shared-utility devices are typical use cases for devices that are enrolled with no user affinity.

If user affinity is required, be sure that the device’s enrollment profile has **User Affinity** selected before enrolling the device. To change the affinity status on a device, you must retire the device and reenroll it.



### See also
[Get ready to enroll devices in Microsoft Intune](get-ready-to-enroll-devices-in-microsoft-intune.md)
