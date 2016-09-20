---
# required metadata

title: Allowed and blocked apps for KNOX | Microsoft Intune
description: Custom profile to create a list of allowed and blocked apps for KNOX.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/09/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: bbc8e0df-7bf3-494e-8bc4-dac59a98ab41

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisbal
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:


---
# Use custom policies to allow and block apps for Samsung KNOX devices

Use the procedures in this topic to create a Microsoft Intune custom policy that creates one of the following:

- A list of apps that are blocked from running on the device. No other apps will be allowed to run. Apps in this list are blocked from being run, even if they were already installed when the policy was applied.
- A list of apps that users of the device are allowed to install from the Google Play store. Only the apps you list can be installed. No other apps can be installed from the store.

These settings can only be used by devices that run Samsung KNOX.

## To create an allowed or blocked app list

1. In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Policy** &gt; **Configuration Policies** &gt; **Add**.
2. In the **Create a New Policy** dialog box, expand **Android**, choose **Custom Configuration**, and then choose **Create Policy**.
3. Provide a name and optional description for the policy and then, in the **OMA-URI Settings** section, choose **Add**.
4. In the **Add or Edit OMA-URI Setting** dialog box, specify the following:
	For a list of apps that are blocked from running on the device:
	
	- **Setting name.** Enter **PreventStartPackages**.
	- **Setting description.** Enter an optional description like 'List of apps that are blocked from running.'
	- 	**Data type.** From the drop-down list, choose **String**.
	- 	**OMA-URI.** Enter **./Vendor/MSFT/PolicyManager/My/ApplicationManagement/PreventStartPackages**
	- 	**Value.** Enter a list of the app package names you want to allow. You can use **; : ,** or **|** as a delimiter. (Example: package1;package2;)

	For a list of apps that users are allowed to install from the Google Play store while excluding all other apps:

	- **Setting name.** Enter **AllowInstallPackages**.
	- **Setting description.** Enter an optional description like 'List of apps that users can install from Google Play.'
	- **Data type.** From the drop-down list, choose **String**.
	- **OMA-URI.** Enter **./Vendor/MSFT/PolicyManager/My/ApplicationManagement/AllowInstallPackages**
	- **Value.** Enter a list of the app package names you want to allow. You can use **; : ,** or **|** as a delimiter. (Example: package1;package2;)

4. Click **OK**, and then click **Save Policy**. 

>[TIP]
>You can find the package ID of an app by browsing to the app on the Google Play store. The package ID is contained in the URL of the app's page. For example, the package ID of the Microsoft Word app is **com.microsoft.office.word**.

The next time each targeted device checks in, the app settings will be applied.


## Deploy the policy

1.  In the **Policy** workspace, select the policy you want to deploy, then click **Manage Deployment**.

2.  In the **Manage Deployment** dialog box, select one or more groups to which you want to deploy the policy, then click **Add** &gt; **OK**.

 
When you select a deployed policy, you can view further information about the deployment in the lower part of the policies list.

### See also
[Android and Samsung KNOX policy settings in Microsoft Intune](android-policy-settings-in-microsoft-intune.md)
