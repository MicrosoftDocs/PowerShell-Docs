---
# required metadata

title: Custom configurations for VPN profiles | Microsoft Intune
description: Use custom configurations to create VPN profiles in Intune.
keywords:
author: Nbigman
manager: angrobe
ms.date: 07/21/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 4c0bd439-3b58-420b-9a9a-282886986786

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: karanda
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Custom configurations for VPN profiles

## Create a custom configuration
You can use custom configurations to create VPN profiles in Intune. To create a custom configuration:

   1. In the Intune admin console, **Policy** > **Add Policy** > *<Expand platform>* > **Custom configuration** > **Create Policy**.
   2. Provide a name for the policy.
   3. For each URI setting, choose **Add**, and provide the requested information. Here's an example:

   ![VPN profile custom configuration dialog box](./media/Intune_Add_VPN_URI.png)

   4.  After you've entered all of URI settings, choose **Save policy**, and then deploy the policy.

## Deploy a configuration policy

1.  In the **Policy** workspace, choose the policy that you want to deploy, and then click **Manage Deployment**.

2.  In the **Manage Deployment** dialog box:

    -   **To deploy the policy** - Choose one or more groups to which you want to deploy the policy, and then click **Add** &gt; **OK**.

    -   **To close the dialog box without deploying it** - Choose **Cancel**.

When you choose a deployed policy, you can view further information about the deployment in the lower part of the policies list.

##Example of URI settings for a custom VPN profile configuration
Here are example entries for URI values to create a custom configuration for a VPN in a fictitious company called Contoso. For more information, like the data type for each entry, see [VPNv2 CSP](https://msdn.microsoft.com/en-us/library/windows/hardware/dn914776.aspx).

Native Contoso VPN (IKEv2):
./Vendor/MSFT/VPNv2/ContosoVPN/NativeProfile/Servers

vpn.contoso.com
./Vendor/MSFT/VPNv2/ContosoVPN/NativeProfile/NativeProtocolType

Ikev2
./Vendor/MSFT/VPNv2/ContosoVPN/NativeProfile/RoutingPolicyType

SplitTunnel
./Vendor/MSFT/VPNv2/ContosoVPN/NativeProfile/Authentication/UserMethod

Eap
./Vendor/MSFT/VPNv2/ContosoVPN/NativeProfile/Authentication/Eap/Configuration
&lt;EapHostConfig xmlns="http://www.microsoft.com/provisioning/EapHostConfig"&gt;&lt;EapMethod&gt;&lt;Type xmlns="http://www.microsoft.com/provisioning/EapCommon"&gt;13&lt;/Type&gt;&lt;VendorId xmlns="http://www.microsoft.com/provisioning/EapCommon"&gt;0&lt;/VendorId&gt;&lt;VendorType xmlns="http://www.microsoft.com/provisioning/EapCommon"&gt;0&lt;/VendorType&gt;&lt;AuthorId xmlns="http://www.microsoft.com/provisioning/EapCommon"&gt;0&lt;/AuthorId&gt;&lt;/EapMethod&gt;&lt;Config xmlns="http://www.microsoft.com/provisioning/EapHostConfig"&gt;&lt;Eap xmlns="http://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"&gt;&lt;Type&gt;13&lt;/Type&gt;&lt;EapType xmlns="http://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV1"&gt;&lt;CredentialsSource&gt;&lt;CertificateStore&gt;&lt;SimpleCertSelection&gt;true&lt;/SimpleCertSelection&gt;&lt;/CertificateStore&gt;&lt;/CredentialsSource&gt;&lt;ServerValidation&gt;&lt;DisableUserPromptForServerValidation&gt;false&lt;/DisableUserPromptForServerValidation&gt;&lt;ServerNames&gt;&lt;/ServerNames&gt;&lt;/ServerValidation&gt;&lt;DifferentUsername&gt;false&lt;/DifferentUsername&gt;&lt;PerformServerValidation xmlns="http://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2"&gt;false&lt;/PerformServerValidation&gt;&lt;AcceptServerName xmlns="http://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2"&gt;false&lt;/AcceptServerName&gt;&lt;/EapType&gt;&lt;/Eap&gt;&lt;/Config&gt;&lt;/EapHostConfig&gt;

**./Vendor/MSFT/VPNv2/ContosoVPN/ByPassForLocal**
True

**./Vendor/MSFT/VPNv2/ContosoVPN/RememberCredentials**
1

**./Vendor/MSFT/VPNv2/ContosoVPN/DomainNameInformationList/1/DomainName**
Corp.Contoso.com

**./Vendor/MSFT/VPNv2/ContosoVPN/DnsSuffix**
Corp.Contoso.com

**./Vendor/MSFT/VPNv2/ContosoVPN/TrustedNetworkDetection**
Corp.Contoso.com

**./Vendor/MSFT/VPNv2/ContosoVPN/RouteList/1/Address**
10.0.0.0

**./Vendor/MSFT/VPNv2/ContosoVPN/RouteList/1/PrefixSize**
8

**./Vendor/MSFT/VPNv2/ContosoVPN/AlwaysOn**
true

**./Vendor/MSFT/VPNv2/ContosoVPN/AppTriggerList/0/App/Id**
%PROGRAMFILES%\Internet Explorer\iexplore.exe

**./Vendor/MSFT/VPNv2/ContosoVPN/AppTriggerList/1/App/Id**
%PROGRAMFILES% (x86)\Internet Explorer\iexplore.exe

**./Vendor/MSFT/VPNv2/ContosoVPN/AppTriggerList/2/App/Id**
Microsoft.MicrosoftEdge_8wekyb3d8bbwe

**./Vendor/MSFT/VPNv2/ContosoVPN/TrafficFilterList/0/App/Id**
%PROGRAMFILES% (x86)\Internet Explorer\iexplore.exe

**./Vendor/MSFT/VPNv2/ContosoVPN/TrafficFilterList/1/App/Id**
Microsoft.MicrosoftEdge_8wekyb3d8bbwe

For any questions about how these settings should be used or more details about what they do, customers should refer to the configuration service provider (CSP) documentation:
https://msdn.microsoft.com/en-us/library/windows/hardware/dn914776(v=vs.85).aspx.

## URI settings for Android per-app VPN on PulseSecure
### CUSTOM URI FOR PACKAGE LIST
-  Data type = String
-  OMA-URI = ./Vendor/MSFT/VPN/Profile/<Name>/PackageList
-  Value = Delimiter separated package list.
   - Delimiters:  semicolon (;), colon (:), comma (,), Pipe (|)

Examples:
- com.android.chrome
- com.android.chrome;com.android.browser

### CUSTOM URI FOR MODE (OPTIONAL)
- Data Type = String
- OMA-URI = ./Vendor/MSFT/VPN/Profile/NAME/Mode

> Notes
> - Use the same *name* that you assigned to the custom profile
> - Possible values: *GLOBAL*, *WHITELIST*, *BLACKLIST*
> - Defaults to *GLOBAL* if no PackageList is provided (backward compatibility with system-wide profiles)
> - Defaults to *WHITELIST* if a PackageList is provided


### See also
(VPN connections in Microsoft Intune)[vpn-connections-in-microsoft-intune.md]
