---
# required metadata

title: Add apps for enrolled devices | Microsoft Intune
description: Before you can deploy an app, you must add it to Intune. Then it’s available in the Intune console, where you can deploy and manage it.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: f5b1f1ae-f177-450a-9af9-936a02d052e3

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Add apps for enrolled devices to Intune

Before you can deploy or manage an app, you must add it to Microsoft Intune. This topic shows you how to add apps for enrolled devices.


> [!IMPORTANT]
> The information in this topic helps you add apps that you want to deploy to enrolled devices and enrolled Windows PCs. If you want to add apps for Windows PCs that you manage by using the Intune client software, see [Add apps for Windows PCs in Microsoft Intune](add-apps-for-windows-pcs-in-microsoft-intune.md).

## Add the app
You use the Intune Software Publisher to configure the properties of the app and, where applicable, upload it to your cloud storage space. Use the following procedure:

1.  In the [Microsoft Intune administrator console](https://manage.microsoft.com), choose **Apps** &gt; **Add Apps** to start the Intune Software Publisher.

    > [!TIP]
    > You might need to enter your Intune user name and password before the publisher starts.

2.  On the **Software setup** page of the publisher, choose one of the following options for **Select how this software is made available to devices**:
	- **Software installer**, for apps with the extension **.msi** or **.exe**:
		- **Select the software installer file type**. This indicates the type of software that you want to deploy. For example, if you want to install an iOS app, choose **App Package for iOS (&#42;.ipa file)**.
        - **Specify the location of the software setup files**. Enter the location of the installation files, or choose **Browse** to select the location from a list.
        - **Include additional files and subfolders from the same folder**. This option is for the **Windows Installer** file type only.<br>Some software that uses Windows Installer requires supporting files that are typically found in the same folder as the installation files. Select this option if you also want to deploy these files.<br>This installation type uses some of your cloud storage space.

  -   **External link**, for apps that you want to create by specifying a link to an app store:

		- **Specify the URL**. Specify the URL of one of the following:
			- The app store URL of the app that you want to deploy. For example, if you want to deploy the Microsoft Remote Desktop app for Android, specify **https://play.google.com/store/apps/details?id=com.microsoft.rdc.android**.<br>To find the URL of the app, use a search engine to find the store page that contains the app. For example, to find the Remote Desktop app, you can search for **Microsoft Remote Desktop Android**.
			- A website. Intune will deploy a shortcut icon to the site on the device (known as a web clip).
			- An app on the web. Intune will deploy a shortcut icon to the app on the device.
        - **Require a managed browser to open this link (Android and iOS only)**. When you deploy a link to a website or web app to users, they will be able to open it only in the Intune managed browser. This browser must be installed on their device.<br>For more details about the managed browser, see [Manage Internet access using managed browser policies with Microsoft Intune](manage-internet-access-using-managed-browser-policies.md).<br>This installation type does not use any of your cloud storage space.

  -   **Managed iOS app from the app store**, for free apps from the iTunes store that you want to manage with mobile application management (MAM) policies:

		- **Specify the URL**. Enter the app store URL of the app that you want to deploy. For example, if you want to deploy the Microsoft Work Folders app for iOS, specify **https://itunes.apple.com/us/app/work-folders/id950878067?mt=8**.<br>This installation type does not use any of your cloud storage space.

		For example, if you want to deploy the Microsoft Word app from the iTunes store to devices, the page would look like this:

		![Intune Software Publisher](./media/publisher-for-mobile.png)

3.  On the **Software description** page, configure the following:

    > [!TIP]
    > Depending on the installer type that you are using, some of these values might have been automatically entered.

	- **Publisher**. Enter the name of the publisher of the app.
    - **Name**. Enter the name of the app as it will be displayed in the company portal.<br>Make sure all app names that you use are unique. If the same app name exists twice, only one of the apps will be displayed to users in the company portal.
    - **Description**. Enter a description for the app. This will be displayed to users in the company portal.
    - **URL for software information**. This is available only if you selected **Software installer**. Optionally, enter the URL of a website that contains information about this app. The URL will be displayed to users in the company portal.
    - **Privacy URL**. This is available only if you selected **Software installer**. Optionally, enter the URL of a website that contains privacy information for this app. The URL will be displayed to users in the company portal.
    - **Category** (optional). Select one of the built-in app categories. This will make it easier for users to find the app when they browse the company portal.
    - **Display this as a featured app and highlight it in the company portal**. Display the app prominently on the main page of the company portal when users browse for apps.
    - **Icon** (optional). Upload an icon that will be associated with the app. This is the icon that will be displayed with the app when users browse the company portal.

		In this example, you configured a description for the Microsoft Word app for iOS:

		![Software description example](./media/ios-software-description.png)

4.  On the **Requirements** page, select the requirements that must be met before the app can be installed on a device. For example, for an app package for iOS, you can select the minimum version of iOS required. Additionally, you can select the type of device that it must be, like an iPhone or an iPad.

    > [!TIP]
    > The **Requirements** page is not displayed for all types of apps.

5.  Further wizard pages are displayed when you choose the **Windows Installer** file type. This file type is used when you deploy software to PCs running Windows 10 or later that are enrolled with Intune.

6.  On the **Summary** page, review the information that you specified. When you are ready, choose **Upload**.

7.  Choose **Close** to finish.

The app is displayed on the **Apps** node of the **Apps** workspace.

## Example - Deploying .msi applications to Windows 10 devices
In this four-minute video, you'll learn about how to deploy Windows Installer (.msi) applications to enrolled devices that run Windows 10.<br><br>

<iframe src="https://channel9.msdn.com/Series/How-to-Control-the-Uncontrolled/6--How-to-Deploy-MSI-Applications-to-Windows-10-Using-Intune-and-Mobile-Device-Management-MDM/player" width="640" height="360" allowFullScreen frameBorder="0"></iframe>

## Next steps

After you've created an app, the next step is to deploy it. To find out more, see [Deploy apps in Microsoft Intune](deploy-apps.md).
