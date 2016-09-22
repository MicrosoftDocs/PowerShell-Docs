---
# required metadata

title: Change ATA configuration - domain connectivity password | Microsoft ATA
description: Describes how to change the Domain Connectivity Password on the ATA Gateway.
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 4a25561b-a5ed-44aa-9b72-366976b3c72a

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



# Change ATA configuration - domain connectivity password

>[!div class="step-by-step"]
[« ATA Console URL](modifying-ata-config-consoleurl.md)


## Change the domain connectivity password
If you modify the Domain Connectivity Password, make sure that the password you enter is correct. If it is not, the ATA Gateway service will stop running on the ATA Gateways.

If you suspect that this happened, on the ATA Gateway, look at the Microsoft.Tri.Gateway-Errors.log file for the following:
`The supplied credential is invalid.`

To correct this, follow this procedure to update the Domain Connectivity password on the ATA Center:

1.  Open the ATA Console on the ATA Center.

2.  Select the settings option on the toolbar and select **Configuration**.

    ![ATA configuration settings icon](media/ATA-config-icon.JPG)

3.  Select **Directory Services**.

    ![ATAA Gateway change password image](media/ATA-GW-change-DC-password.png)

4.  Under **Password**, change the password.

    If the ATA Center have connectivity to the domain, use the **Test Connection** button to validate the credentials

5.  Click **Save**.

6.  After changing the password, manually check that the ATA Gateway service is running on the ATA Gateway servers.

>[!div class="step-by-step"]
[« ATA Console URL](modifying-ata-config-consoleurl.md)

## See Also
- [Working with the ATA Console](working-with-ata-console.md)
- [Install ATA](install-ata.md)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
