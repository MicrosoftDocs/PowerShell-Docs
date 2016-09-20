---
# required metadata

title: Use iOS mobile app configuration policies | Microsoft Intune
description: Use mobile app configuration policies in Intune to supply settings that might be required when users run an iOS app.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 09/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: fc6b645a-e837-4b2a-a10f-144065cbd8dd

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Configure iOS apps with mobile app configuration policies in Microsoft Intune
Use mobile app configuration policies in Microsoft Intune to supply settings that might be required when users run an app. For example, an app might require users to specify:

-   A custom port number.

-   Language settings.

-   Security settings.

-   Branding settings such as a company logo.

If users enter these settings incorrectly, this can increase the burden on your help desk and slow the adoption of new apps.

Mobile app configuration policies can help you eliminate these problems by letting you deploy these settings to users in a policy before they run the app. The settings are then supplied automatically, and users need to take no action.

You do not deploy these policies directly to users and devices. Instead, you associate a policy with an app, and then deploy the app. The policy settings will be used whenever the app checks for them (typically, the first time it is run).

> [!TIP]
> This policy type is currently available only for devices running iOS 8.0 and later. It supports the following app installation types:
>
> -   **Managed iOS app from the app store**
> -   **App package for iOS**
>
> For more information about app installation types, see [Deploy apps with Microsoft Intune](deploy-apps.md).

## Configure a mobile app configuration policy

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Policy** &gt; **Overview** &gt; **Add Policy**.

2.  In the list of policies, expand **iOS**, choose **Mobile App Configuration**, and then choose **Create Policy**.

    > [!TIP]
    > You can configure only custom settings for this policy type. Recommended settings are not available.

3.  In the **General** section of the **Create Policy** page, supply a name and an optional description for the mobile app configuration policy.

4.  In the **Mobile App Configuration Policy** section of the page, in the box, enter or paste an  XML property list that contains the app configuration settings that you want. The format of the XML property list will vary depending on the app you are configuring. Contact the supplier of the app for details about the exact format to use.

	> [!TIP]
	> To find out more about XML property lists, see [Understanding XML Property Lists](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/PropertyLists/UnderstandXMLPlist/UnderstandXMLPlist.html) in the iOS Developer Library.

5.  Click **Validate** to ensure that the XML that you entered is in a valid property list format.

    > [!IMPORTANT]
    > When you click **Validate**, Intune checks that the XML you entered is in a valid format. It does not check that the XML property list will work with the app that it is associated with.

6.  When you are done, click **Save Policy**.

The new policy is displayed in the **Configuration Policies** node.

## Information about the XML file format

Intune supports the following data types in a property list:
	
- &lt;integer&gt;
- &lt;real&gt;
- &lt;string&gt;
- &lt;array&gt;
- &lt;dict&gt;
- &lt;true /&gt; or &lt;false /&gt;
	 
For more information about data types, see [About Property Lists](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/PropertyLists/AboutPropertyLists/AboutPropertyLists.html) in the iOS Developer Library.

Additionally, Intune supports the following token types in the property list:
- \{\{userprincipalname\}\} - (Example: **John@contoso.com**)
- \{\{mail\}\} - (Example: **John@contoso.com**)
- \{\{partialupn\}\} - (Example: **John**)
- \{\{accountid\}\} - (Example: **fc0dc142-71d8-4b12-bbea-bae2a8514c81**)
- \{\{deviceid\}\} - (Example: **b9841cd9-9843-405f-be28-b2265c59ef97**)
- \{\{userid\}\} - (Example: **3ec2c00f-b125-4519-acf0-302ac3761822**)
- \{\{username\}\} - (Example: **John Doe**)
- \{\{serialnumber\}\} - (Example: **F4KN99ZUG5V2**) for iOS devices
- \{\{serialnumberlast4digits\}\} - (Example: **G5V2**) for iOS devices
	
The \{\{ and \}\} characters are used by token types only and must not be used for other purposes.

## Associate a mobile app configuration policy with an app
After you have created a mobile app configuration policy, you must associate it with the iOS app to which you want the settings in the configuration policy to apply.

To do this, follow the steps to create an app deployment in [Add apps for mobile devices in Microsoft Intune](add-apps-for-mobile-devices-in-microsoft-intune.md) and [Deploy apps with Microsoft Intune](deploy-apps-in-microsoft-intune.md). When you reach the **Mobile App Configuration** page of the wizard, select the policy that you want to associate with the app from the **App Configuration Policy** drop-down list.

Then, continue to deploy and monitor the app deployment as usual.

When the deployed app is run on a device, it will run with the settings that you configured in the mobile app configuration policy.

> [!TIP]
> If one or more mobile app configuration policies conflict, neither policy is enforced. The conflict will be reported in the Intune administration console **Dashboard**.

## Example format for a mobile app configuration XML file

When you create a mobile app configuration file, you can specify one or more of the following values by using this format:

```
<dict>
  <key>userprincipalname</key>
  <string>{{userprincipalname}}</string>
  <key>mail</key>
  <string>{{mail}}</string>
  <key>partialupn</key>
  <string>{{partialupn}}</string>
  <key>accountid</key>
  <string>{{accountid}}</string>
  <key>deviceid</key>
  <string>{{deviceid}}</string>
  <key>userid</key>
  <string>{{userid}}</string>
  <key>username</key>
  <string>{{username}}</string>
  <key>serialnumber</key>
  <string>{{serialnumber}}</string>
  <key>serialnumberlast4digits</key>
  <string>{{serialnumberlast4digits}}</string>
  <key>udidlast4digits</key>
  <string>{{udidlast4digits}}</string>
</dict>

```
