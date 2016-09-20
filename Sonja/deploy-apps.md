---
# required metadata

title: Deploy apps | Microsoft Intune
description: This topic explains concepts you'll need to understand before you start deploying apps with Intune.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: ad5ea85c-aa2e-4110-a184-172cd0b8f270

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Deploy apps with Microsoft Intune

This topic explains some of the concepts you need to understand before you start deploying apps with Microsoft Intune.


## App deployment actions
When you deploy apps, you can choose from one of the following deployment actions:

-   **Required install** – The app is installed onto the device with no user intervention required.

    > [!TIP]
    > For iOS devices that are not in supervised mode, and for all Android devices, the user must accept the app offer before it is installed.
    >
	>  If a user uninstalls an app that you deployed as a required install, Intune automatically reinstalls the app after the next inventory cycle, which typically occurs every seven days.

-   **Available install** – The app is displayed in the company portal, and users can install it on demand.

-   **Uninstall** – The app is uninstalled from the device.

-   **Not applicable** – The app is not displayed in the company portal and is not installed on any devices.

#### Understand which deployment actions are available for each installer type

|Installer type|Required install|Available install|Uninstall|Not applicable|
|------------------|--------------------|---------------------|-------------|------------------|
|Windows app package (deployed to a user group)|Yes|Yes|Yes|Yes|
|Windows app package (deployed to a device group)|Yes|No|Yes|Yes|
|App package for mobile devices (deployed to a user group)|Yes|Yes|Yes|Yes|
|App package for mobile devices (deployed to a device group)|Yes|No|Yes|Yes|
|Windows Installer (deployed to a user group)|No|Yes|No|Yes|
|Windows Installer (deployed to a device group)|Yes|No|Yes|Yes|
|External link (deployed to a user group)|No|Yes|No|Yes|
|External link (deployed to a device group)|No|No|No|No|
|Managed iOS app from the app store (deployed to a user group)|Yes|Yes|Yes|Yes|
|Managed iOS app from the app store (deployed to a device group)|Yes|No|Yes|Yes|
> [!TIP]
> When you deploy apps, if you select both user and device groups, you can only deploy the app as an **Available install**.

## Deployment conflicts
When two deployments with the same deployment action are received by a device, the following rules apply:

-   Deployments to a device group take precedence over deployments to a user group. However, if an app is deployed to a user group with a deployment action of **Available**, and the same app is also deployed to a device group with a deployment action of **Not Applicable**, the app will be made available in the company portal for users to install.

-   An install action takes precedence over an uninstall action.

-   If both a required and an available install are received by a device, the actions are combined. In other words, the user can install the available app from the company portal before the required install begins.


## Next steps

Learn how to [deploy apps in Microsoft Intune](deploy-apps-in-microsoft-intune.md).
