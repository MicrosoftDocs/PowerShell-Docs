---
# required metadata

title: Restrict access using mobile threat protection | Microsoft Intune
description: Restrict access to company resources based on device, network and application risk.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 09/13/2016
ms.topic: article
ms.prod:
ms.service:
ms.technology:
ms.assetid: 725d9e40-e70c-461a-9413-72ff1b89a938

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: sandera
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Restrict access to company resource based on device, network, and application risk
You can control access from mobile devices to corporate resources, based on risk assessment conducted by Lookout, a mobile threat protection (MTP) solution that is integrated with Microsoft Intune. The risk is based on telemetry that the Lookout MTP service collects from devices for operating system (OS) vulnerabilities, installed malicious apps, and network profiles. 
Based on the risk assessment you can then configure conditional access policies in Intune and allow or block devices that have been determined to be noncompliant due to threats detected on those devices.  This is currently supported only for **Android** devices running **4.1 and later** and enrolled in Microsoft Intune.  
## What problem does this solve?
Companies and organizations need to protect sensitive data from emerging threats that include physical, app-based, and network-based threats, as well as OS vulnerabilities.

Historically, companies and organizations have taken an active position of protecting PCs against malicious attacks. Mobile is an emerging area that often goes unprotected. Although the mobile platforms have built-in protection of the OS using techniques such as app isolation and vetted consumer app stores, these platforms continue to be vulnerable to sophisticated attacks. As mobile devices are increasingly used by employees to do work and need access to information that can be sensitive and valuable, these devices need to be protected from a variety of sophisticated attacks.

Intune gives you the ability to control the access to company resources and data based on risk assessment that MTP solutions like Lookout provides.

## How do Intune and Lookout mobile threat protection help protect company resources?
Lookout’s mobile app (Lookout for work), running on mobile devices, captures file system, network stack, and device and application telemetry (where available) and send it to the Lookout mobile threat protection (MTP) cloud service to calculate an aggregate device risk for mobile threats. You can also change the classification of the risk level for the threats in the MTP console to suit your requirements.  
The compliance policy in Intune now includes a new rule for Lookout mobile threat protection that is based on the Lookout MTP risk assessment. When this rule is enabled, Microsoft Intune then evaluates the device compliance with the policy that you enabled.

If the device is determined as noncompliant with the compliance policy, access to resources like Exchange Online and SharePoint Online can blocked using conditional access policies. When access is blocked, the end-users are provided with a walkthrough to  help resolve the issue and gain access to company resources. This walkthrough is launched through the Lookout for work app.

## Example scenarios
Following are some common scenarios:
### Threat from malicious apps:
When malicious apps such as malware is detected on the device, you can block such devices from:
* Connecting to corporate e-mail before resolving the threat.
* Synchronizing corporate files using the OneDrive for Work app.
* Accessing business-critical apps.

**Access blocked when malicious apps are detected:**
![diagram showing conditional access policy blocking access when device is determined to be non-compliant due to malicious apps on the device](../media/mtp/malicious-apps-blocked.png)

**Device unblocked and is able to access company resources when the threat is remediated:**

![diagram showing conditional access policy granting access when device is determined to be compliant after remediation](../media/mtp/malicious-apps-unblocked.png)
### Threat to network:
Detect threats to your network such as Man-in-the-middle attacks and restrict access to WiFi networks based on the device risk.

**Access to network through WiFi blocked:**
![diagram showing conditional access blocking WiFi access based on network threats](../media/mtp/network-wifi-blocked.png)

**Access granted on remediation:**

![diagram showing conditional access allowing access on remediation of the threat](../media/mtp/network-wifi-unblocked.png)
### Threat to network (preventing access to SharePoint Online):

Detect threats to your network such as Man-in-the-middle attacks, and prevent synchronization of corporate files based on the device risk.

**Access blocked SharePoint Online based on network threat detected on the device:**

![Diagram showing conditional access blocking device access to SharePoint Online based on threat detection](../media/mtp/network-spo-blocked.png)


**Access granted on remediation:**

![Diagram showing conditional access allowing access after the network threat is remediated](../media/mtp/network-spo-unblocked.png)

## Next steps
Here are the main steps you must do to implement this solution:
1.	[Set up your subscription with Lookout mobile threat protection](set-up-your-subscription-with-lookout-mtp.md)
2.	[Enable Lookout MTP connection in Intune](enable-lookout-mtp-connection-in-intune.md)
3.  [Configure and deploy Lookout for work application](configure-and-deploy-lookout-for-work-apps.md)
4.	[Configure compliance policy](enable-device-threat-protection-rule-in-compliance-policy.md)
5.	[Troubleshoot Lookout Integration](http://docs.microsoft.com/en-us/intune/troubleshoot/troubleshooting-lookout-integration)
