---
# required metadata

title: Restrict email access to Exchange On-premises | Microsoft Intune
description: Protect and control access to company email on Exchange On-premises with conditional access.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/18/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: a55071f5-101e-4829-908d-07d3414011fc

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Restrict email access to Exchange on-premises and legacy Exchange Online Dedicated with Intune


If you have an Exchange Online Dedicated environment and need to find out whether it is in the new or the legacy configuration, please contact your account manager.


To control email access to Exchange on-premises or to your legacy Exchange Online Dedicated environment, configure conditional access to Exchange on-premises in Intune.
To learn more about how conditional access works, read the [restrict access to email and O365 services]( restrict-access-to-email-and-o365-services-with-microsoft-intune.md) article.

**Before** you can configure conditional access verify the following:

-   Your Exchange version must be **Exchange 2010 or later**. Exchange server Client Access Server (CAS) array is supported.

-   You must use the **on-premises Exchange connector**, which connects [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] to Microsoft Exchange on-premises. This lets you manage devices through the [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] console. For details on the connector, see [Intune on-premises Exchange connector](intune-on-premises-exchange-connector.md).

    -   The on-premises Exchange connector available to you in the Intune console is specific to your Intune tenant and cannot be used with any other tenant. You should also ensure that the exchange connector for your tenant is installed **on only one machine**.

        This connector should be downloaded from the Intune admin console.  For a walkthrough on how to configure the on-premises Exchange connector, see [configure Exchange on-premises connector for on-premises or hosted Exchange](intune-on-premises-exchange-connector.md).

    -   The connector can be installed on any machine as long as that machine is able to communicate with the Exchange server.

    -   The connector supports **Exchange CAS environment**. You can technically install the connector on the Exchange CAS server directly if you wish to, but it is not recommended, as it will increase the load on the server.
    When configuring the connector, you must set it up to communicate to one of the Exchange CAS servers.

-   **Exchange ActiveSync** must be configured with certificate based authentication, or user credential entry.

When conditional access policies are configured and targeted to a user, before a user can connect to their email, the **device** they use must be:

-  Either **enrolled** with [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] or is a domain joined PC.

-  **Registered in Azure Active Directory**. Additionally, the client Exchange ActiveSync ID must be registered with Azure Active Directory.

  AAD DRS will be activated automatically for Intune and Office 365 customers. Customers who have already deployed the ADFS Device Registration Service will not see registered devices in their on-premises Active Directory. **This does not apply to Windows PCs and Windows Phone devices**.

-   **Compliant** with any [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] compliance policies deployed to that device.

The following diagram illustrates the  flow that is used by conditional access policies for Exchange on-premises to evaluate whether to allow or block devices.

![Diagram that shows the decision points that determine if a device is allowed access to Exchange on-premises or blocked](../media/ConditionalAccess8-2.png)
If a conditional access policy is not met, the user is presented with one of the following messages when they log in:

- If the device is not enrolled with [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)], or is not registered in Azure Active Directory, a message is displayed with instructions about how to install the Company Portal  app, enroll the device, and activate email. This process also associates the device’s Exchange ActiveSync ID with the device record in Azure Active Directory.

-   If the device is not compliant, a message is displayed that directs the user to the [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] Company Portal   website, or the Company Portal   app where they can find information about the problem and how to remediate it.

## Support for mobile devices
-   Windows Phone 8 and later

-   Native email app on iOS.

-   Native email app on Android 4 or later
> [!NOTE]
> Microsoft Outlook app for Android and iOS is not supported.

## Support for PCs

The **Mail** application on Windows 8 and later (when enrolled with [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)])

##  Configure a conditional access policy

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Policy** > **Conditional Access** > **Exchange on-premises policy**.
![IntuneSA5aSelectExchOnPremPolicy](../media/IntuneSA5aSelectExchOnPremPolicy.png)

2.  Configure the policy with the settings you require:
![Screenshot of the Exchange on-premises policy page](../media/IntuneSA5bExchangeOnPremPolicy.png)

  - **Block email apps from accessing Exchange on-premises if the device is noncompliant or not enrolled to Microsoft Intune:** When you select this option, devices that are not managed by [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)], or not compliant with a compliance policy are blocked from accessing Exchange services.

  - **Default rule override - Always allow  enrolled and compliant devices to access Exchange:** When you check this option, devices that are enrolled in Intune and compliant with the compliant policies are allowed to access Exchange.  
  This rule overrides the **Default Rule**, which means that even if you set the **Default Rule** to quarantine or block access, enrolled and compliant devices will still be able to access Exchange.

  - **Targeted Groups:** Select the [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] user groups that must enroll their device with [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] before they can access Exchange.

  - **Exempted Groups:** Select the [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] user groups that are exempt from the conditional access policy. Users in this list will be exempt even if they are also in the **Targeted Groups** list.

  - **Platform Exceptions:** Choose **Add Rule** to configure a rule that defines access levels for specified mobile device families and models. Because these devices can be of any type, you can also configure device types that are unsupported by [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)].

  - **Default Rule:** For a device that is not covered by any of the other rules, you can choose to allow it to access Exchange, block it, or quarantine it. When you set the rule to allow access, for devices that are enrolled and compliant, email access is granted automatically for iOS, Windows, and Samsung KNOX devices. The end user does not have to go through any process to get their email.  On Android devices that do not run Samsung KNOX, end users will get a quarantine email which includes a guided walkthrough to verify enrollment and compliance before they can access email. If you set the rule to block access or quarantine it, all devices are blocked from getting access to exchange regardless of whether they are already enrolled in Intune or not. To prevent enrolled and compliant devices from being affected by this rule, check the **Default Rule Override.**
>[!TIP]
>If your intention is to first block all devices before granting access to email, choose the Block access, or the Quarantine rule. The default rule will apply to all device types, so device types you configure as platform exceptions and that are unsupported by [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] are also affected.

  - **User Notification:** In addition to the notification email sent from Exchange, Intune sends an email which contains steps to unblock the device. You can edit the default message to customize it to your needs. Because the Intune notification email containing remediation instructions is delivered to the user’s Exchange mailbox, in the event that the user’s device is blocked before they receive the email message, they can use an unblocked device or other method to access Exchange and view the message. This is especially true when the **Default Rule** is set to block or quarantine.  In this case, the end user will have to go to their app store, download the Microsoft Company Portal   app and enroll their device. This is applicable to iOS, Windows, and Samsung KNOX devices.  For devices that do not run Samsung KNOX, you will need to send the quarantine email to an alternate email account, which then  the end user has to copy to their blocked device to complete the enrollment and compliance process.|
  > [!NOTE]
  > In order for Exchange to be able to send the notification email, you must specify the account that should be used to send the notification email.
  >
  > For details, see [configure Exchange on-premises connector for on-premises or hosted Exchange](intune-on-premises-exchange-connector.md).

3.  When you are done, choose **Save**.

-   You do not have to deploy the conditional access policy, it takes effect immediately.

-   After a user sets up an Exchange ActiveSync profile, it might take from 1-3 hours for the device to be blocked (if it is not managed by [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)]).

-   If a blocked user then enrolls the device with [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] and remediates noncompliance), email access will be unblocked within 2 minutes.

-   If the user un-enrolls from [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] it might take from 1-3 hours for the device to be blocked.

**To see some example scenarios of how you would configure conditional access policy to restrict device access, see [restrict email access example scenarios](restrict-email-access-example-scenarios.md).**

## Next steps
[Restrict access to SharePoint Online](restrict-access-to-sharepoint-online-with-microsoft-intune.md)

[Restrict access to Skype for Business Online](restrict-access-to-skype-for-business-online-with-microsoft-intune.md)
