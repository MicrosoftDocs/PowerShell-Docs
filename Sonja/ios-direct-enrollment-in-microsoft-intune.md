---
# required metadata

title: Direct enrollment for iOS devices | Microsoft Intune
description: Use the Apple Configurator tool to directly enroll corporate-owned iOS devices with a predefined policy by USB-connecting them to a Mac computer.
keywords:
author: NathBarn
manager: arob98
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: a692b90c-72ae-47d1-ba9c-67a2e2576cc2

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: dagerrit
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Directly enroll iOS devices using Apple Configurator
Intune supports the enrollment of corporate-owned iOS devices using the [Apple Configurator](http://go.microsoft.com/fwlink/?LinkId=518017) tool running on a Mac computer. This process does not factory-reset the device and enrolls the device with a predefined policy. This method is for devices with **No user affinity** and requires you to USB-connect the iOS device to a Mac computer to setup corporate enrollment. When directly enrolling iOS devices, you can enroll a device without acquiring the device's serial number. You can also name the device for identification purposes before Intune captures the device name during enrollment. The Company Portal app is not supported for direct enrolled devices. This guidance assumes you are using Apple Configurator 2.0 on a Mac computer.

1.  **Create a profile for devices**
    A device enrollment profile defines the settings applied to devices. If you have not already, create a device enrollment profile for iOS devices enrolled using Apple Configurator.

    1.  In the [Microsoft Intune administration console](http://manage.microsoft.com) go **Policy** &gt; **Corporate Device Enrollment**, and then choose **Add…**.

        ![Create device enrollment profile page](../media/pol-sa-corp-enroll.png)

    2.  Enter details for the device profiles:

        -   **Name** – Name of the device enrollment profile. Not visible to users.

        -   **Description** - Description of the device enrollment profile. Not visible to users.

        -   **User affiliation** – Specifies how devices are enrolled. For Direct Enrollment, select **No user affinity**.

        -   **Device group pre-assignment** – All devices deployed this profile will initially belong to this group. You can reassign devices after enrollment.

            [!INCLUDE[groups deprecated](../includes/group-deprecation.md)]

    3.  Choose **Save Profile** to add the profile.

5.  **Export a profile as .mobileconfig to deploy to iOS devices**
	Select the device profile you created. Choose **Export…** in the taskbar. Choose **Download profile** and save the downloaded .mobileconfig file.

6.  **Transfer the file**
    Copy the downloaded .mobileconfig file to a Mac computer.
    > [!NOTE]
    > The enrollment profile URL is valid for two weeks from when it is exported. After two weeks, you must export a new enrollment profile URL to enroll iOS devices with Setup Assistant.
7.  **Prepare the device with Apple Configurator**
    iOS devices are connected to the Mac computer and enrolled for mobile device management.

    1.  On a Mac computer, launch **Apple Configurator 2.0**.

    2.  Connect the iOS device to the Mac computer with a USB cord. Close **Photos**, **iTunes**, and other apps that open for the device when the device is detected.

    3.  In Apple Configurator, single-click the connected iOS device, and then choose the **Add** button. Options that can be added to the device appear in the drop-down list. Choose **Profiles** .

    4.  Use the file picker to select the .mobileconfig file you exported from Intune, and then choose **Add**. The profile is added to the device.  If the device is **Unsupervised**, the installation will require acceptance on the device.

8.  **Install the profile**
    You are ready to install the profile on the iOS device. The device must have already completed the Setup Assistant and be ready to use.  If enrollment entails app deployments, the device should have an Apple ID set up because the app deployments will require that you have an Apple ID signed in for the App Store.

    1.  Unlock the iOS device.

    2.  In the **Install profile** dialog for **Management profile**,  tap **Install**.

    3.  Provide **Device Passcode** or **Apple ID**, if required.

    4.  Accept the **Warning**, and tap **Install**.

    5.  Accept the **Remote Warning**, and tap **Trust**.

    6.  When the **Profile Installed** box confirms the profile has **Installed**, choose **Done**.

9. **Verify profile**
    On the iOS device, launch **Settings** and go **General** &gt; **Device Management** &gt; **Management Profile** &gt;  and confirm the profile installation is listed, check the iOS policy restrictions, and installed apps. Policy restrictions and apps may take up to 10 minutes to appear on the device.

10. **Distribute devices**
    The iOS device is now enrolled with Intune and managed.
