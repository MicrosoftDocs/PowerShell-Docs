---
# required metadata

title: How to deploy apps | Microsoft Intune
description: Use the information in this topic to help you deploy apps with Microsoft Intune.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 3b42019e-73da-4538-a496-212f11d5bf9b

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:
---
# Deploy apps in Microsoft Intune

Use the information in this topic to help you deploy apps with Microsoft Intune.


## Deploy an app
In this procedure, you'll deploy an app to selected groups of devices or users.

### To deploy an app

1. In the [Microsoft Intune administration console](https://manage.microsoft.com), click **Apps** &gt; **Apps** to view the list of apps that you manage.

2.  Select the app that you want to deploy, and then click **Manage Deployment**.

3.  In the *&lt;app name&gt;* dialog box, on the **Select Groups** page, choose the user or device groups to which you want to deploy the app.

4.  On the **Deployment Action** page, configure the following:

	- **Approval** - Choose whether the deployment is:
		- **Required** (mandatory install)
		- **Available** (users install from the company portal on demand)
		- **Not Applicable** (the app is not installed or shown in the company portal)
		- **Uninstall** (the app is uninstalled from targeted devices)
	- **Deadline** - For required installations, choose how soon to deploy the app. You can choose from the predefined values, or you can select **Custom** to configure your own deadline.

5. If the app you are deploying can be configured by a mobile application management policy, the **Mobile App Management** page is displayed. On this page, choose the mobile application management policy that you want to associate with this app.

	[See which Microsoft apps are compatible with mobile application management policies.](https://www.microsoft.com/en-us/server-cloud/products/microsoft-intune/partners.aspx)

6. If the app you are deploying is compatible with Intune VPN profiles, the **VPN Profile** page is displayed. On this page, you can choose to associate iOS apps with a VPN profile that you have deployed. The VPN connection automatically opens when the app is launched. To make a VPN profile available, it must have the **Per-app VPN** profile setting enabled.
 For information about how to configure VPN profiles, including information about how to associate profiles with apps, see [VPN connections in Microsoft Intune](vpn-connections-in-microsoft-intune.md).

## Example

In this example, you deployed the app as **Available** to an iOS device.
The app displays on users' devices in the company portal, and users can install it from there.

For example, in this screenshot, the Bing for iOS app was deployed by using the **External Link** installation type with a custom icon. The option **Display this as a featured app and highlight it in the company portal** was selected.  
![iOS available app](./media/available-install-on-iOS.png)

If you deployed the app as **Required** to an iOS device, the user will get a notification that an app is ready to install. For example, in this screenshot, the Work Folders for iOS app was deployed by using the **Managed iOS app from the app store** installation type.  
![iOS required app](./media/iOS-Required-install.PNG)

## Next steps

After you deploy an app, you'll want to monitor its progress. For more information, see [Monitor apps in Microsoft Intune](monitor-apps-in-microsoft-intune.md).
