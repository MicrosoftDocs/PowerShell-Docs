---
# required metadata

title: Per-app VPN for Android using Pulse Secure | Microsoft Intune
description: You can create a per-app VPN profile for Android devices managed by Intune.
keywords:
author: nbigman
manager: angrobe
ms.date: 08/28/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: ac65e906-3922-429f-8d9c-d313d3126645

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisbal
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Use a custom policy to create a per-app VPN profile for Android devices

You can create a per-app VPN profile for Android 5.0 and later devices that are managed by Intune. First, create a VPN profile that uses the Pulse Secure connection type. Then, create a custom configuration policy that associates the VPN profile with specific apps. 

After you deploy the policy to your Android device or user groups, users should start the PulseSecure VPN. PulseSecure will then allow traffic only from the specified apps to use the open VPN connection.

> [!NOTE]
>
> Only the Pulse Secure connection type is supported for this profile.


### Step 1: Create a VPN profile

1. In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Policy** > **Add Policy**.
2. To select a template for the new policy, expand **Android**, and then choose **VPN Profile (Android 4 and later)**.
3. In the template, for **Connection type**, choose **Pulse Secure**.
4. Finish and save the VPN profile. For more details about VPN profiles, see [VPN connections](../deploy-use/vpn-connections-in-microsoft-intune.md).

> [!NOTE]
>
> Take note of the VPN profile name to use in the next step. For example, MyAppVpnProfile.

### Step 2: Create a custom configuration policy

   1. In the Intune admin console, choose **Policy** > **Add Policy** > **Android** > **Custom configuration** > **Create Policy**.
   2. Enter a name for the policy.
   3. Under **OMA-URI settings**, choose **Add**.
   4. Enter a setting name.
   5. For **Data type**, specify **String**.
   6. For **OMA-URI**, specify this string: **./Vendor/MSFT/VPN/Profile/*Name*/PackageList**, where *Name* is the VPN profile name you noted in Step 1. In our example, the string would be **./Vendor/MSFT/VPN/Profile/MyAppVpnProfile/PackageList**.
   7.	For **Value**, create a semicolon-separated list of packages to associate with the profile. For example, if you want Excel and the Google Chrome browser to use the VPN connection, enter **com.microsoft.office.excel;com.android.chrome**.

![Example Android per-app VPN custom policy](./media/android_per_app_vpn_oma_uri.png)

#### Set your app list to blacklist or whitelist (optional)
  You can specify a list of apps that *cannot* use the VPN connection by using the **BLACKLIST** value. All other apps will connect through the VPN.
  Alternatively, you can use the **WHITELIST** value to specify a list of apps that *can* use the VPN connection. Apps that are not on the list will not connect through the VPN.
  1.	Under **OMA-URI** settings, choose **Add**.
  2.	Enter a setting name.
  3.	For **Data type**, specify **String**.
  4.	For **OMA-URI**, use this string: **./Vendor/MSFT/VPN/Profile/*Name*/Mode**, where *Name* is the VPN profile name you noted in Step 1. In our example, the string would be **./Vendor/MSFT/VPN/Profile/MyAppVpnProfile/Mode**.
  5.	For **Value**, enter **BLACKLIST** or **WHITELIST**.



### Step 3: Deploy both policies

You must deploy *both* policies to the *same* Intune groups.

1.  In the **Policy** workspace, select the policy that you want to deploy, and then choose **Manage Deployment**.
2.  In the **Manage Deployment** dialog box:
    -   **To deploy the policy**, select one or more groups to deploy the policy to, then choose **Add** > **OK**.
    -   **To close the dialog box without deploying the policy**, choose **Cancel**.

A status summary and alerts on the **Overview** page of the **Policy** workspace identify issues with the policy that require your attention. A status summary also appears in the **Dashboard** workspace.
