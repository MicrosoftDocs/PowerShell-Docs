---
# required metadata

title: Setup your subscription with Lookout MTP | Microsoft Intune
description: This topics provides details on how to configure Lookout MTP.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 09/13/2016
ms.topic: article
ms.prod:
ms.service:
ms.technology:
ms.assetid: 8477a2f1-2e1d-4d42-8bcb-e1181cc900bb

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: sandera
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Set up your subscription for  Lookout mobile threat protection
To get your subscription ready for the Lookout MTP service, Lookout support (enterprisesupport@lookout.com) will need the following information about your Azure Active Directory (Azure AD). 

* Azure AD Tenant ID
* Azure AD Group Object ID for full Lookout MTP console access
* Azure AD Group Object ID for restricted Lookout MTP console access (optional)

Use the information in the following section to gather the information you need to give to the Lookout support team.  

## Getting your Azure AD information
### Getting you Azure AD tenant ID
Log into the Azure AD management portal: https://manage.windowsazure.com and select your subscription. 

![screenshot of the Azure AD page showing the name of the tenant](../media/mtp/aad_tenant_name.png)
When you choose the name of your subscription, the resulting URL  includes the subscription ID.  If you have any issues finding your subscription ID, the [Microsoft support article](https://support.office.com/en-us/article/Find-your-Office-365-tenant-ID-6891b561-a52d-4ade-9f39-b492285e2c9b?ui=en-US&rs=en-US&ad=US) provides additional tips.   
### Getting your Azure AD Group ID
The Lookout MTP console supports 2 levels of access:  
* **Full Access:** Azure AD admin can create a group for users that will have Full Access and optionally they may create a group for users that will have Restricted Access.  Only users in these groups will be able to login to the **Lookout MTP Console**.
* **Restricted Access:** No access to several configuration and enrollment related modules of the Lookout MTP console; read-only access to the **Security Policy** module of the Lookout MTP console.  

For more details on the permissions, read [this article](https://personal.support.lookout.com/hc/en-us/articles/114094105653) on the Lookout website.

The **Group Object ID** can be found on the properties page of the group in the Azure AD management console.

![screenshot of the properties page with GroupID field highlighted](../media/mtp/aad_group_object_id.png)

Once you have gathered this information, contact Lookout support (email: enterprisesupport@lookout.com).

Lookout support will work with your primary contact to onboard your subscription and create your Lookout MTP Enterprise account, using the information that you collected.


## Configure your subscription with Lookout MTP
### Step 1: Setup your MTP
After Lookout support creates your Lookout MTP Enterprise account, you can login to the Lookout MTP Console.   An email from Lookout is sent to the primary contact for your company  with a link to the login url:https://aad.lookout.com/les?action=consent

You must use a user account with the Azure AD role of Global Admin when you first log in to the Lookout MTP console, since the Lookout MTP requires this to register your Azure AD tenant.   Subsequent logins will not require the user to have this level of Azure AD privilege.  In this first login, a consent page will be displayed. Choose **accept** to complete the registration.

![screenshot of the first time login page of the Lookout MTP console](../media/mtp/lookout_mtp_initial_login.png)
Once you have accepted and consented, you are redirected to the Lookout MTP Console. Subsequent logins after the initial registration, can be done using the URL:  https://aad.lookout.com

See the [troubleshooting article](https://docs.microsoft.com/en-us/intune/troubleshoot/troubleshooting-lookout-integration)  if you run into login issues.

The next steps outline the tasks that must be done to complete the Lookout MTP set up within the [Lookout MTP Console](https://aad.lookout.com).

### Step 2: Configure the Intune connector

In the Lookout MTP console, go to the **System** module, choose the **Connectors** tab, and select **Intune**.

![screenshot of the Lookout MTP console with the connectors tab open, and Intune option highlighted](../media/mtp/lookout_mtp_setup-intune-connector.png)

In the connection settings option, configure the heartbeat frequency in minutes.  With completion of this step, your Intune connector is now ready.  

![screenshot of the connection settings tab with showing heartbeat frequency configured](../media/mtp/lookout-mtp-connection-settings.png)

### Step 3: Configure enrollment groups
On the **Enrollment Management** option, define a set of users whose devices should be enrolled with Lookout.   Best practice is to start with a small group of users to test and become familiar with how the integration works.  Once you are satisfied with your test results, you may extend the enrollment to additional groups of users.

To get started with enrollments groups,  first define an Azure AD security group that would be a good first set of users to enroll in Lookout MTP. Once you have the group created in Azure, AD, in the Lookout MTP Console, go to the **Enrollement Management** option and add the Azure AD security group **Display Name(s)** for enrollment.

When a user is in an enrollment group, any of their devices that are identified and supported in Azure AD is enrolled and is eligible for activation in Lookout MTP.  The first time they open the Lookout for Work app on their supported device, it is activated in Lookout MTP.
![screenshot of the Intune connector enrollment page](../media/mtp/lookout-mtp-enrollment.png)

Best practice is to leave the increment to check for new devices to be the default 5 minutes.

>[!IMPORTANT]
> The display name is case sensitive.  Use the **Display Name** as shown the in the **Properties** page of the security group in the Azure portal. Note in the picture below that the **Properties** page of the security group, the Display Name is camel case.  The title however is displayed in all lower case and should not be used to enter into the Lookout MTP console.
>![screenshot of the Azure portal, Azure Active Directory service, properties page](../media/mtp/aad-group-display-name.png)

The current release has the following limitations:  
* There is no validation for the group diplay names.  Make sure to use the value in the **DISPLAY NAME** field shown in Azure portal for the Azure AD security group.
* Creating groups within groups is not currently supported.  Azure AD security groups specified should only contain users and not nested groups.


### Step 4: Configure state sync
In the **State Sync** option, specify the type of data should be sent to Intune.  Currently, you must enable both device status and threat status in order for the Lookout Intune integration to work correctly.  These are enabled by default.
### Step 5: Configure error report email recipient information
In the **Error Management** option, enter the email address that should receive the error reports.

![screenshot of the Intune connector error management page](../media/mtp/lookout-mtp-connector-error-notifications.png)

### Step 6: Configure email notifications
If you would like to receive email alerts for threats, sign in to the [Lookout MTP console](https://aad.lookout.com)with the user account that should receive the notifications.  Go to the  **System** module, and on the **Preferences** tab, choose the desired notifications and set them to **ON**. Save your changes.

![screenshot of the preferences page with the user account displayed](../media/mtp/lookout-mtp-email-notifications.png)
If you no longer wish to receive email notifications, set the notifications to **OFF** and save your changes.
### Step 7: Configure threat classification
Lookout MTP classifies mobile threats of various types. The [Lookout MTP threat classifications](http://personal.support.lookout.com/hc/en-us/articles/114094130693) have default risk levels associated with them. These can be changed at any time to suite your company requirements.

![screenshot of the policy page showing threat and classifications](../media/mtp/lookout-mtp-threat-classification.png)

>[!IMPORTANT]
> The risk levels specified here is an important aspect of MTP because the Intune integration calculates device compliance according to these risk levels at runtime. In other words, Intune Admin sets a rule in policy to determine a device is non-compliant if it has an active threat with a minimum level of: high, medium, or low. The threat classification policy in MTP directly drives the device compliance calculation in Intune.

## Watching enrollment
Once the setup is complete, Lookout MTP starts to poll Azure AD for devices that correspond to the specified enrollment groups.  Information about the devices enrolled can be found on the Devices module.  The initial status for devices is shown as pending.  The device status will change once the Lookout for work app is installed, opened, and activated on the device.  Details on how to get the Lookout for work app pushed to the device can be found in [configure and deploy Lookout for work apps](configure-and-deploy-lookout-for-work-apps.md) topic.
## Next steps
[Enable Lookout MTP connection Intune](enable-lookout-mtp-connection-in-intune.md)
