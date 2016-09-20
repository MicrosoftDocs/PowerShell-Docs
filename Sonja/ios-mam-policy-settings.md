---
# required metadata

title: iOS MAM policy settings | Microsoft Intune
description: This topic describes the mobile app management policy settings for iOS devices.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/13/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 673ff872-943c-4076-931c-0be90363aea9

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: andcerat
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

#  iOS mobile app management policy settings
The policy settings described below can be [configured](create-and-deploy-mobile-app-management-policies-with-microsoft-intune.md) for a MAM policy on the **Settings** blade on the Azure portal.

There are two categories of policy settings, Data relocation and Access settings:

##  Data relocation settings
The term **Policy managed apps** is used to refer to apps that are configured with MAM policies.

- **Prevent iTunes and iCloud backups:**
  Choose **Yes** to disable, or **No** to allow backup of company data from the policy managed apps.

  **Default value = Yes**

- **Allow app to transfer data to other apps:**   Choose one of the options to indicate the apps that can receive data from policy managed apps:
  - **Policy managed apps**: Allow transfer to only apps that have the MAM policy.
  - **All apps**: Allow transfer to any app
  - **None**: Do not allow data transfer to any app including other policy managed apps.

  Additionally, if you set this option to **Policy Managed Apps** or **None**, the iOS 9 feature that allows Spotlight Search to search data within apps will be blocked.

  **This setting does not control use of the Open In feature on mobile devices. To manage Open In, see [here](manage-data-transfer-between-ios-apps-with-microsoft-intune.md)**.

  **Default value = Policy managed apps**

- **Allow app to receive data from other apps:**  Specify apps that are allowed to transfer data to the policy managed apps:
  -  **Policy managed apps**: Allow data transfers only from other policy managed apps.
  -  **All apps**: Allow data transfer from any app
  -  **None**: Do not allow data transfer from any app.

  **Default value = All apps**

- **Prevent Save As:**
  Choose **Yes** to disable the use of the Save As option in any app that uses this policy. Choose **No** if you want to allow the use of Save As.

  **Default value = Yes**

- **Restrict cut, copy and paste with other apps:**
Specify when  cut, copy, and paste operations should be restricted. Choose from:
  -   **Blocked:** Do not allow cut, copy, and paste operations between policy managed apps.
  -   **Policy Managed Apps**: Only allow cut, copy, and paste operations between policy managed apps.
  -   **Policy Managed Apps with paste In**: Allow cut or copy between policy managed apps. Allow cut or copied data from any app to be pasted into this app.
  - **Any App**: No restrictions for  cut, copy, and paste operations between any apps.

  **Default value =Policy managed apps with paste in**

- **Restrict web content to display in the Managed Browser:** When this setting is enabled, any links in the app will be opened in the Managed Browser.

  For devices that are not enrolled in Intune, the web links in policy-managed apps can only open in the Managed Browser app using the mobile app management policy.

  If you are using Intune to manage your devices, see [manage internet access using managed browser policies with Microsoft Intune](manage-internet-access-using-managed-browser-policies.md).

    **Default value = Yes**

- **Encrypt app data:** For apps that are associated with an [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] mobile app management policy, data is encrypted at rest using device level encryption provided by the OS. When a PIN is required, the data is encrypted per the settings in the mobile app management policy. As stated in Apple documentation, [the modules used by iOS 7 are FIPS 140-2 certified](http://support.apple.com/en-us/HT202739).

  In the policy settings, you can specify PIN encryption values.  These values determine when the data is encrypted. The options are:
  - **When device is locked:** All app data associated with this policy is encrypted while the device is locked.
  -   **When device is locked (except for open files):** All app data associated with this policy is encrypted while the device is locked, except for data that in the files that are currently open in the app.
  -   **After device restart:** All app data associated with this policy is encrypted when the device is restarted, until the device is unlocked for the first time.
  -   **Use device settings:** App data is encrypted based on the default settings on the device.
  When you enable this setting, the end user is required to setup and use a PIN to access their device.  If there is no PIN, the apps will not launch and the end user will be prompted to set a PIN with a message -“Your company has required that you must first enable a device PIN to access this application.”

  **Default value -Encryption option is not selected.**
- **Disable contact sync:**  Choose **Yes** to prevent contact information from synchronizing to the native address book app on the device. If you choose **No**, the app will save the  contact information to the native address book app on the device.

  When you do a selective wipe to remove company data, contacts synced directly from the app to the native address book are removed. Any contacts synced from the native address book to another external source cannot be wiped. Currently this is applicable only to the **Microsoft Outlook** app.

  **Default value = Yes**
##  iOS Access policy settings
The term **Policy managed apps** is used to refer to apps that are configured with MAM policies.
- **Require PIN for access:**  Choose **Yes** to require a PIN to use policy managed apps. The user is prompted to set this up the first time they run the app in a work context.

  **Default value = Yes**
    -  **Allow simple PIN:** Specify whether to allow users to use simple PIN sequences such as 1234 or 1111. **Default value = Yes**.
    - **PIN Length:** Specify the minimum number of digits in a PIN. **Default value = 4**
    - **Number of attempts before PIN reset:** Specify the number of PIN entry attempts that can be made before the user must reset the PIN.
  **There is no default value for this setting**.

  - **Require fingerprint instead of PIN (iOS 8.0+):** Choose **Yes** to require a fingerprint identity instead of a numbered PIN for app access.
On iOS devices, you can allow the user to identify themselves using fingerprint on iOS devices instead of a numbered PIN. When the end user tries to access this app using their work account, they are prompted to provide their fingerprint identity instead of entering a PIN number.

    **Default value = Yes**
- **Require corporate credentials for access:** Choose **Yes** to require corporate credentials instead of a PIN for app access. **If you set this to Yes, this overrides the requirements for PIN or Touch ID.** The user will be prompted to provide their corporate credentials.

  **Default value = No**
- **Block managed apps from running on jailbroken or rooted devices:** Choose **Yes** to block apps from running on jailbroken or rooted devices. The user will continue to be able to use the apps for personal tasks, but will have to use a different device for work.

  **Default value = Yes**
- **Recheck the access requirements after (minutes)**|-   **Timeout:** Time (in minutes) before the access requirements for the app are rechecked.
  -   **Offline grace period:** If the device is offline, specify the time (in minutes) before the access requirements for the app are rechecked.

  **Default value = 30 minute timeout, and 720 minute offline grace period**
  - **Offline interval before app data is wiped (days):** You can choose to wipe the company data if a device has been offline for a certain period.  Specify the number of days a device can be offline before the company data is removed from the device. **Entering a value of  0 will turn this setting off**.

  **Default value = 90 days**
