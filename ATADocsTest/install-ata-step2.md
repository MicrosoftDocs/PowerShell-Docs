---
# required metadata

title: Install ATA - Step 2 | Microsoft ATA
description: Step two of installing ATA helps you configure the domain connectivity settings on your ATA Center server
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: get-started-article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: e1c5ff41-d989-46cb-aa38-5a3938f03c0f

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: bennyl
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

*Applies to: Advanced Threat Analytics version 1.7*



# Install ATA - Step 2

>[!div class="step-by-step"]
[« Step 1](install-ata-step1.md)
[Step 3 »](install-ata-step3.md)

## Step 2. Provide a Username and Password to connect to your Active Directory Forest

The first time you open the ATA Console, the following screen appears:

![ATA welcome stage 1](media/ATA_1.7-welcome-provide-username.png)

1.  Enter the following information and click **Save**:

    |Field|Comments|
    |---------|------------|
    |**Username** (required)|Enter the read-only user name, for example: **ATAuser**.|
    |**Password** (required)|Enter the password for the read-only user, for example: **Pencil1**.|
    |**Domain** (required)|Enter the domain for the read-only user, for example, **contoso.com**. **Note:** It is important that you enter the complete FQDN of the domain where the user is located. For example, if the user’s account is in domain corp.contoso.com, you need to enter `corp.contoso.com` not contoso.com|
	|Update all ATA Gateways automatically |If you enable this setting, in upcoming version releases when you update the ATA Center, all ATA Gateways will be automatically updated.|

    After it is saved, the welcome message in the Console will change to the following:
![ATA welcome stage 1 finished](media/ATA_1.7-welcome-provide-username-finished.png)

2. In the Console, click **Download Gateway setup and install the first Gateway** to continue.


>[!div class="step-by-step"]
[« Step 1](install-ata-step1.md)
[Step 3 »](install-ata-step3.md)


## See Also

- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
- [Configure event collection](configure-event-collection.md)
- [ATA prerequisites](/advanced-threat-analytics/plan-design/ata-prerequisites)
