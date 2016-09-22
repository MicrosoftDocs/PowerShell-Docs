---
# required metadata

title: Change ATA configuration - ATA Center certificate  | Microsoft ATA
description: Describes the two-stage process for renewing or replacing the certificate in the local computer store on the ATA Center server. 
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: c8855287-de3b-4cdd-be8f-2128f48a6f27

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



# Change ATA configuration - ATA Center certificate

>[!div class="step-by-step"]
[« ATA Center server IP address](modifying-ata-config-centerip.md)
[ATA Console URL»](modifying-ata-config-consoleurl.md)

## Change the ATA Center certificate
If your certificate is about to expire and need to be renewed or replaced after installing the new certificate in the local computer store on the ATA Center server, replace the certificate by following this two stage process:

-   First stage – Update the certificate you want the ATA Center service to use. At this point the ATA Center service is still bound to the original certificate. When the ATA Gateways sync their configuration they will have two potential certificates that will be valid for mutual authentication. As long as the ATA Gateway can connect using the original certificate, it will not try the new one.

-   Second stage – After all the ATA Gateways synced with the updated configuration, you can activate the new certificate that the ATA Center service is bound to. When you activate the new certificate, the ATA Center service will bind to the certificate. ATA Gateways will not be able to properly mutually authenticate the ATA Center service and will attempt to authenticate the second certificate. After connecting to the ATA Center service, the ATA Gateway will pull down the latest configuration and will have a single certificate for the ATA Center. (Unless you started the process again.)

> [!NOTE]
> -   If an ATA Gateway was offline during the first stage and never got the updated configuration, you will need to manually update the configuration JSON file on the ATA Gateway.
> -   The certificate that you are using must be trusted by the ATA Gateways.
> -   The certificate is also used for the ATA Console, so it should match the ATA Console address to avoid browser warnings
> -   If you need to deploy a new ATA Gateway after activating the new certificate, you need to download the ATA Gateway Setup package again.

1.  Open the ATA Console.

2.  Select the settings option on the toolbar and select **Configuration**.

    ![ATA configuration settings icon](media/ATA-config-icon.JPG)

3.  Select **Center**.

4.  Under **Certificate**, select one of the certificates in the list.

5.  Click **Save**.

6.  You will see a notification of how many ATA Gateways synced to the latest configuration.

7.  After all the ATA Gateways synced, click **Activate** to activate the new certificate.
	>[!IMPORTANT]
	>Before activating the new configuration, validate that all the ATA Gateways are synced with the latest configuration. Activating the new configuration before all the ATA Gateways are synced may cause the ATA Gateway to stop functioning as expected. If any of the ATA Gateways are not synced, you will get this error when you click Activate:
	>
	>    ![ATA Gateway sync error](media/ataGW-not-synced.png)

8.  Ensure that all the ATA Gateways are able to sync their configurations after the change was activated.

>[!div class="step-by-step"]
[« ATA Center server IP address](modifying-ata-config-centerip.md)
[ATA Console URL»](modifying-ata-config-consoleurl.md)

## See Also
- [Working with the ATA Console](working-with-ata-console.md)
- [Install ATA](install-ata.md)
- [Check out the ATA forum!](https://aka.ms/ata-forum)
