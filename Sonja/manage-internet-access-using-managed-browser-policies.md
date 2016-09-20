---
# required metadata

title: Manage web access with the managed browser | Microsoft Intune
description: Deploy the managed browser application to restrict web browsing and the transfer of web data to other apps.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 09/06/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: dc946303-e09b-4d73-8bf4-87742299bc54

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: maxles
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Manage Internet access using managed browser policies with Microsoft Intune
The managed browser is a web browsing application that you can deploy in your organization by using Microsoft Intune. A managed browser policy configures an allow list or a block list that restricts the websites that users of the managed browser can visit.

Because this app is a managed app, you can also apply mobile application management policies to the app. These policies might include controlling the use of cut, copy, and paste, preventing screen captures, and ensuring that links to content that users select open only in other managed apps. For details, see [Configure and deploy mobile application management policies in the Microsoft Intune console](configure-and-deploy-mobile-application-management-policies-in-the-microsoft-intune-console.md).

> [!IMPORTANT]
>If users install the managed browser from the app store and Intune does not manage it, the following behavior applies:<br /><br />
iOS – The managed browser app can be used as a basic web browser, but some features will not be available, and it will not be able to access data from other Intune-managed apps.<br />
Android – The managed browser app cannot be used.<br /><br />
If users install the managed browser themselves on an iOS device with a version earlier than iOS 9, no policies that you create will manage the browser. To ensure that Intune manages the browser, users must uninstall the app before you can deploy it to them as a managed app. On iOS 9 and later, if users install the managed browser themselves, they will be prompted to allow it to become managed by policy.

You can create managed browser policies for the following device types:

-   Devices that run Android 4 and later

-   Devices that run iOS 8.0 and later

The Intune managed browser supports opening web content from [Microsoft Intune application partners](https://www.microsoft.com/en-us/server-cloud/products/microsoft-intune/partners.aspx).

## Create a managed browser policy

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Policy** &gt; **Add Policy**.

2.  Configure one of the following **Software** policy types:

    -   **Managed Browser (Android 4 and later)**

    -   **Managed Browser (iOS 8.0 and later)**

    For more information about how to create and deploy policies, see the [Manage settings and features on your devices with Microsoft Intune Policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md) topic.

3.  Use the following to help you configure the managed browser policy settings:

	- **Name**. Enter a unique name for the managed browser policy to help you identify it in the Intune console.
	- **Description**. Provide a description that gives an overview of the managed browser policy and other relevant information that helps you to locate it.
	- **Enable an allow list or block list to restrict the URLs the Managed Browser can open**. Select one of the following options:
		- **Allow the managed browser to open only the URLs listed below**. Specify a list of URLs that the managed browser can open.
		- **Block the managed browser from opening the URLs listed below**. Specify a list of URLs that the managed browser will be blocked from opening.
**Note:** You cannot include both allowed and blocked URLs in the same managed browser policy.
For more information about the URL formats you can specify, see **URL format for allowed and blocked URLs** in this topic.

4.  When you are finished, choose **Save Policy**.

The new policy appears in the **Configuration Policies** node of the **Policy** workspace.

## Create a deployment for the managed browser app
After you have created the managed browser policy, you can then create a software deployment for the managed browser app, and associate it with the managed browser policy that you created.

> [!IMPORTANT]
> Managed browser policies are not deployed in the same way as other Intune polices. This type of policy must be associated with the managed browser software package.

Deploy the app, ensuring that you select the managed browser policy on the **Mobile App Management** page to associate the policy with the app.

For more information about how to deploy apps, see [Deploy apps in Microsoft Intune](deploy-apps-in-microsoft-intune.md).

## Security and privacy for the managed browser

-   On iOS devices, websites that users visit that have an expired or untrusted certificate cannot be opened.

-   The managed browser does not use settings that users make for the built-in browser on their devices. This is because the managed browser does not have access to these settings.

-   If you configure the option **Require simple PIN for access** or **Require corporate credentials for access** in a mobile application management policy associated with the managed browser, and a user selects the help link on the authentication page, they can then browse any Internet sites regardless of whether they were added to a block list in the managed browser policy.

-   The managed browser can block access to sites only when they are accessed directly. It cannot block access when intermediate services (such as a translation service) are used to access the site.

-   To allow authentication, and to ensure that the Intune documentation can be accessed,**&#42;.microsoft.com** is exempt from the allow or block list settings. It is always allowed.

### Turn off usage data
Microsoft automatically collects anonymous data about the performance and use of the managed browser to improve Microsoft products and services. Users can turn off data collection by using the **Usage Data** setting on their devices. You have no control over the collection of this data.

## Reference information

### URL format for allowed and blocked URLs
Use the following information to learn about the allowed formats and wildcards that you can use when specifying URLs in the allowed and blocked lists:

-   You can use the wildcard symbol (**&#42;**) according to the rules in the following permitted patterns list.

-   Ensure that you prefix all URLs with **http** or **https** when entering them into the list.

-   You can specify port numbers in the address. If you do not specify a port number, the values used will be:

    -   Port 80 for http

    -   Port 443 for https

    Using wildcards for the port number is not supported. For example, **http&colon;//www&period;contoso&period;com:*;** and **http&colon;//www&period;contoso&period;com: /*;** are not supported.

-   Use the following table to learn about the permitted patterns that you can use when you specify URLs:

|URL|Details|Matches|Does not match|
    |-------|---------------|-----------|------------------|
    |http://www.contoso.com|Matches a single page|www.contoso.com|host.contoso.com<br /><br />www.contoso.com/images<br /><br />contoso.com/|
    |http://contoso.com|Matches a single page|contoso.com/|host.contoso.com<br /><br />www.contoso.com/images<br /><br />www.contoso.com|
    |http://www.contoso.com/&#42;|Matches all URLs that begin with www.contoso.com|www.contoso.com<br /><br />www.contoso.com/images<br /><br />www.contoso.com/videos/tvshows|host.contoso.com<br /><br />host.contoso.com/images|
    |http://&#42;.contoso.com/&#42;|Matches all subdomains under contoso.com|developer.contoso.com/resources<br /><br />news.contoso.com/images<br /><br />news.contoso.com/videos|contoso.host.com|
    |http://www.contoso.com/images|Matches a single folder|www.contoso.com/images|www.contoso.com/images/dogs|
    |http://www.contoso.com:80|Matches a single page, by using a port number|http://www.contoso.com:80||
    |https://www.contoso.com|Matches a single, secure page|https://www.contoso.com|http://www.contoso.com|
    |http://www.contoso.com/images/&#42;|Matches a single folder and all subfolders|www.contoso.com/images/dogs<br /><br />www.contoso.com/images/cats|www.contoso.com/videos|

-   The following are examples of some of the inputs that you cannot specify:

    -   &#42;.com

    -   &#42;.contoso/&#42;

    -   www.contoso.com/&#42;images

    -   www.contoso.com/&#42;images&#42;pigs

    -   www.contoso.com/page&#42;

    -   IP addresses

    -   https://&#42;

    -   http://&#42;

    -   http://www.contoso.com:&#42;

    -   http://www.contoso.com: /&#42;

### How conflicts between the allow and block list are resolved
If multiple managed browser policies are deployed to a device and the settings conflict, both the mode (allow or block) and the URL lists are evaluated for conflicts. In case of a conflict, the following behavior applies:

-   If the modes in each policy are the same, but the URL lists are different, the URLs will not be enforced on the device.

-   If the modes in each policy are different, but the URL lists are the same, the URLs will not be enforced on the device.

-   If a device is receiving managed browser policies for the first time and two policies conflict, the URLs will not be enforced on the device. Use the **Policy Conflicts** node of the **Policy** workspace to view the conflicts.

-   If a device has already received a managed browser policy and a second policy is deployed with conflicting settings, the original settings remain on the device. Use the **Policy Conflicts** node of the **Policy** workspace to view the conflicts.
