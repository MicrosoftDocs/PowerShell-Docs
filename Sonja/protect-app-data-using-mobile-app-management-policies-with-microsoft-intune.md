---
# required metadata

title: Protect app data using MAM policies | Microsoft Intune
description: This topic explains how  mobile app management policies can help protect your company data, prevent data loss, and keep personal and work information separate.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/18/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: ab6cd622-b738-4a63-9c91-56044aaafa6d

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: joglocke
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Protect app data using mobile app management policies with Microsoft Intune

## How you can protect app data
Your employees use mobile devices for both personal and work tasks.  While making sure your employees can be productive, you also want to prevent data loss, intentional and unintentional.  In addition, you want to have the ability to protect company data accessed using devices even in the case where they are not managed by you.

You can use Intune mobile app management (MAM) policies to help protect your company’s data. Because Intune MAM policies can be used **independent of any mobile-device management (MDM) solution**, you can use it to protect your company’s data with or without enrolling devices in a device management solution. By implementing **app-level policies**, you can restrict access to company resources and keep data within the purview of your IT department.

MAM policies can be configured for app running on devices that are:

- **Enrolled in Microsoft Intune:** The devices in this category are typically corporate owned devices.

-   **Enrolled in a third-party Mobile device management (MDM)  solution:**   The devices in this category are typically corporate owned devices.

  > [!NOTE]
  > Mobile app management policies should not be used with third party mobile app management  or secure container solutions.

-   **Not enrolled in any mobile device management solution:**  The devices in this category are typically employee owned devices that are not managed or enrolled in Intune or other MDM solutions.

> [!IMPORTANT]
> You can create mobile app management policies for Office mobile apps that connect to Office 365 services. MAM policies are not supported for apps that connect to on-premises Exchange, Skype for Business, or SharePoint services.

**The important benefits of using MAM policies are**

-   Protecting your company data at the app level.  Since mobile app management does not require device management, you can protect company data on both managed and unmanaged devices. The management is centered on the user identity, which removes the requirement for device management.

-   End user productivity is not impacted, and the policies are not applied when using the app in a personal context.  The policies are applied only in a work context, thus giving you the ability to protect company data without touching personal data.

There are additional benefits to using MDM with MAM  policies, and companies can use both MAM with and without MDM at the same time. For example, an employee may use a phone issued by the company as well as a personal tablet.  In this case, the company phone is enrolled in MDM and protected by MAM policies, and the personal device is protected by MAM policies only.

- **MDM makes sure that the device is protected**.  For example, you can require a PIN to access the device, or you can deploy managed apps to the device. You can also deploy apps to devices through your MDM solution, to give you more control over app management.

- **MAM policies makes sure that the app-layer protections are in place**. For example, you can require a PIN to open an app in a work context, or if data can be shared between apps, or preventing company app data from being saved to a personal storage location.


### MAM polices are currently supported on:
-   iOS 8.1 or later

-   Android 4 or later

Windows devices are currently not supported.
##  How MAM policies protect app data

####  Apps without MAM policies:

![Image that shows data can move freely between apps when there are no MAM policies in place](../media/Apps_without_MAM_policies.png)

When apps are used without restrictions, company and personal data can get intermingled.  Company data could end up in locations like personal storage or transferred to apps outside of your  purview,  resulting in data loss. The arrows in the diagram show unrestricted data movement between apps (corporate and personal) and to storage locations.

### Data protection with MAM policies:

![Image that shows how company data is protect when MAM policies are applied ](../media/Apps_with_mobile_app_policies.png)

You can use MAM policies to prevent company data from saving to the local storage of the device, and restrict data movement to other apps that are not protected by MAM policies. MAM policy settings include:
- Data relocation policies like
 **Prevent Save As**, **Restrict cut, copy, and paste**.
- Access policy settings like **Require simple PIN for access**, **Block managed apps from running on jailbroken or rooted devices**.

### Data protection with MAM policies on devices managed by a MDM solution:

![Image that shows how MAM policies work on BYOD devices](../media/MAM_BYOD_November.png)

**For devices enrolled in an MDM solution**-

The illustration above shows the layers of protection that MDM and MAM policies offer together.

The MDM solution:

-   Enrolls the device

-   Deploys the apps to the device

-   Provides ongoing device compliance and management

**MAM policies add value by:**

-   Helping protect  company data from leaking to consumer apps and services

-   Applying restrictions (save-as, clipboard, PIN, etc.) to mobile apps

-   Wipe company data from apps without removing those apps from the device


### Data protection with MAM policies for devices without enrollment

![Image that shows how MAM policies work on managed devices](../media/MAM_ManagedDevices_November.png)

The diagram above illustrates how the data protection policies work at the app level without MDM.

For BYOD devices not enrolled in any MDM solution, MAM policies can help protect company data at the app level.
However, there are some limitations to be aware of, like:

-   You cannot deploy apps to the device.  The end user has to get the apps from the store.

-   You cannot provision certificate profiles on these devices.

-   You cannot provision company Wi-Fi and VPN settings on these devices.


## Multi-identity

Apps that support multi-identity gives you the ability to use different accounts - work and personal, to access the same apps while MAM policies are applied on when the apps are used in the work context.  

For example, when the end user launches the OneDrive app using their work account, they cannot move the files to a personal storage location. However, when the end user uses OneDrive with their personal account, they can copy and move data from their personal OneDrive without restrictions.  

For a detailed explanation of the experience of using apps that are associated with MAM policies, and how apps with Multi-identity support enable applying MAM policies only in work context, read [using apps with multi-identity support](end-user-experience-for-mam-enabled-apps-with-microsoft-intune.md#using-apps-with-multi-identity-support)

All Office mobile apps support multi-identity.

##  Next steps
[Get ready to configure mobile app management policies](get-ready-to-configure-mobile-app-management-policies-with-microsoft-intune.md)

[Create and deploy mobile app management policies with Microsoft Intune](create-and-deploy-mobile-app-management-policies-with-microsoft-intune.md)
