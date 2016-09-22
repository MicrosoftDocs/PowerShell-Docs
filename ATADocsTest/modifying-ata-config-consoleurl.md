---
# required metadata

title: Change ATA configuration - ATA Console IP address | Microsoft Advanced Threat Analytics
description: Describes how to change the IP address of the ATA Console, used to create a shortcut to the ATA Console on the ATA Gateways.
keywords:
author: rkarlin
manager: stevenpo
ms.date: 08/24/2016
ms.topic: article
ms.prod: identity-ata
ms.service: advanced-threat-analytics
ms.technology: security
ms.assetid: 50118465-df34-4e04-b0cc-48808b6a96b1

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



# Change ATA configuration - ATA Console URL

>[!div class="step-by-step"]
[« ATA Center certificate](modifying-ata-config-centercert.md)
[Domain connectivity password »](modifying-ata-config-dcpassword.md)

## Change the ATA Console URL
By default, the ATA Console URL is the IP address selected for the ATA Console IP address when you installed the ATA Center.

The URL is used in the following scenarios:

-   Installation of ATA Gateways – When an ATA Gateway is installed, it registers itself with the ATA Center. This registration process is accomplished by connecting to the ATA Console. If you enter an FQDN for the ATA Console URL, you need to ensure that the ATA Gateway can resolve the FQDN to the IP address that the ATA Console is bound to.

-   Alerts – When ATA sends out a SIEM or email alert, it includes a link to the suspicious activity. The host portion of the link is the ATA Console URL setting.

-   If you installed a certificate from your internal Certification Authority (CA), you will probably want to match the URL to the subject name in the certificate so users will not get a warning message when connecting to the ATA Console.

-   Using an FQDN for the ATA Console URL allows you to modify the IP address that is used by ATA Console without breaking alerts that have been sent out in the past or needing to re-download the ATA Gateway package again. You only need to update the DNS with the new IP address.

> [!NOTE]
> After modifying the ATA Console URL, you should download the ATA Gateway Setup package before installing new ATA Gateways.

If you need to modify the URL for the ATA Console, follow these steps on the ATA Center server.

1.  Open the ATA Console.

2.  Select the settings option on the toolbar and select **Configuration**.

    ![ATA configuration settings icon](media/ATA-config-icon.JPG)

3.  Select **Center**.

4.  Under **Console IP Address**, select one of the existing IP addresses

5.  Under **Console URL**, modify the URL as needed:

    ![ATA Console URL](media/ATA-chge-center-URL.png)
6.  Click **Save**.

>[!div class="step-by-step"]
[« ATA Center certificate](modifying-ata-config-centercert.md)
[Domain connectivity password »](modifying-ata-config-dcpassword.md)


## See Also
- [Working with the ATA Console](working-with-ata-console.md)
- [Install ATA](install-ata.md)
- [Check out the ATA forum!](https://aka.ms/ata-forum)
