---
# required metadata

title: Troubleshooting ATA using the ATA logs | Microsoft ATA
description: Describes how you can use the ATA logs to troubleshoot issues
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: b8ad5511-8893-4d1d-81ee-b9a86e378347

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



# Troubleshooting ATA using the ATA logs
The ATA logs provide insight into what each component of ATA is doing at any given point in time.

## ATA Gateway logs
In this section, every reference to the ATA Gateway is relevant also for the ATA Lightweight Gateway. 

The ATA Gateway logs are located in a subfolder called **Logs** where ATA is installed; the default location is:  . In the default installation location, it can be found at: **C:\Program Files\Microsoft Advanced Threat Analytics\Gateway\Logs**.

The ATA Gateway has the following logs:

-   **Microsoft.Tri.Gateway.log** – This log contains everything that happens in the ATA Gateway (including resolution and errors). Its main use is getting the overall status of all operations in the chronological order in which they occurred.

-   **Microsoft.Tri.Gateway-Resolution.log** – This log contains the resolution details of the entities seen in traffic by the ATA Gateway. Its main use is investigating resolution issues of entities.

-   **Microsoft.Tri.Gateway-Errors.log** – This log contains just the errors that are caught by the ATA Gateway. Its main use is performing health checks and investigating issues that need to be correlated to specific times.

-   **Microsoft.Tri.Gateway-ExceptionStatistics.log** – This log groups all similar errors and exceptions, and measures their count.
    This file starts out  empty each time the ATA Gateway service starts and is updated every minute.Its main use is understanding if there are any new errors or issues with the ATA Gateway (because the errors are grouped it is easier to read and quickly understand if there are any new issues).
-	**Microsoft.Tri.Gateway.Updater.log** - This log is used for the gateway updater process, which is responsible for updating the gateway if configured to do so automatically. 
For the ATA Lightweight Gateway, the gateway updater process is also responsible  for the resource limitations of the ATA Lightweight Gateway.
-	**Microsoft.Tri.Gateway.Updater-ExceptionStatistics.log** - This log groups all similar errors and exceptions together, and measures their count. This file starts out empty each time the ATA Updater service starts and is updated every minute. It enables you to understand if there are any new errors or issues with the ATA Updater. The errors are grouped to make it easier to quickly understand if any new errors or issues are detected.

> [!NOTE]
> The first three log files have a maximum size of up to 50 MB. When that size is reached, a new log file is opened and the previous one is renamed to "&lt;original file name&gt;-Archived-00000" where the number increments each time it is renamed. By default, if more than 10 files from the same type already exist, the oldest are deleted.

## ATA Center logs
The ATA Center logs are located in a subfolder called **Logs**. In the default installation location, it can be found at: **C:\Program Files\Microsoft Advanced Threat Analytics\Center\Logs**".
> [!Note]
> The ATA console logs that were formerly under IIS logs are now located under ATA Center logs.

The ATA Center has the following logs:

-   **Microsoft.Tri.Center.log** – This log contains everything that happens in the ATA Center, including detections and errors. Its main use is getting the overall status of all operations in the chronological order in which they occurred.

-   **Microsoft.Tri.Center-Detection.log** – This log contains just the detection details of the ATA Center. Its main use is investigating detection issues.

-   **Microsoft.Tri.Center-Errors.log** – This log contains just the errors that are caught by the ATA Center. Its main use is performing health checks and investigating issues that need to be correlated to specific times.

-   **Microsoft.Tri.Center-ExceptionStatistics.log** – This log groups all similar errors and exceptions, and measures their count.
    This file starts out empty each time the ATA Center service starts and is updated every minute. Its main use is understanding if there are any new errors or issues with the ATA Center - because the errors are grouped it is easier to quickly understand if there is a new errors or issues.

> [!NOTE]
> The first three log files have a maximum size of up to 50 MB. When that size is reached, a new log file is opened and the previous one is renamed to "&lt;original file name&gt;-Archived-00000" where the number increments each time it is renamed. By default, if more than 10 files from the same type already exist, the oldest are deleted.


## ATA Deployment logs
The ATA deployment logs are located in the temp directory for the user who installed the product. In the default installation location, it can be found at: **C:\Users\Administrator\AppData\Local\Temp** (or one directory above %temp%).

ATA Center deployment logs:

-   **Microsoft Advanced Threat Analytics Center_20150601104213.log** - This log lists the steps in the process of the deployment of the ATA Center. Its main use is tracking the ATA Center deployment process.

-   **Microsoft Advanced Threat Analytics Center_20150601104213_0_MongoDBPackage.log** - This log lists the steps in the process of MongoDB deployment on the ATA Center. Its main use is tracking the MongoDB deployment process.

-   **Microsoft Advanced Threat Analytics Center_20150601104213_1_MsiPackage.log** - This log file lists the steps in the process of the deployment of the ATA Center binaries. Its main use is tracking the deployment of the ATA Center binaries.

ATA Gateway and ATA Lightweight Gateway deployment logs:

-   **Microsoft Advanced Threat Analytics Gateway_20151214014801.log** - This log lists the steps in the process of the deployment of the ATA Gateway. Its main use is tracking the ATA Gateway deployment process.

-   **Microsoft Advanced Threat Analytics Gateway_20151214014801_001_MsiPackage.log** - This log file lists the steps in the process of the deployment of the ATA Gateway binaries. Its main use is tracking the deployment of the ATA Gateway binaries.


## See Also
- [ATA prerequisites](/advanced-threat-analytics/plan-design/ata-prerequisites)
- [ATA capacity planning](/advanced-threat-analytics/plan-design/ata-capacity-planning)
- [Configure event collection](/advanced-threat-analytics/deploy-use/configure-event-collection)
- [Configuring Windows event forwarding](/advanced-threat-analytics/deploy-use/configure-event-collection#configuring-windows-event-forwarding)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
