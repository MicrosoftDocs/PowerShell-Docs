---
# required metadata

title: Monitor app deployments| Microsoft Intune
description: Learn how to monitor apps you deployed with Intune.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/13/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 5daad56d-71c8-455b-8a55-f8b33e279a8a

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---


# Monitor app deployments in Microsoft Intune

## Monitor an app deployment
You can see the apps that you manage and the status of any deployments in the Intune administration console.

### To view apps that you manage and their status
In the **Apps** workspace, choose the **Apps** node, and then choose **Apps**.

The list of apps that you manage appears. You can choose any app to see an installation status in the lower pane of the console windows. Choose this status to see further details. For example, if the status shows **1 user has this software available**, you can choose the message to see the name of the user.

> [!TIP]
> You can use the **Filters** drop-down list to show only apps that meet the criteria that you specify, like apps that failed to install or apps that were successfully deployed.
>
> ![App filters example](./media/app-filters.png)

Additionally, the **Dashboard** workspace shows an overview of the status of your apps. If you click anywhere in the overview, you'll be taken to the list of apps.

## To view more detailed information about an app
In the list of apps, select any app, and then choose **View Properties**.

On the **Software Properties** page for the app, choose one of these tabs: **General** - Shows general information about the app and its installation status, **Devices** - Shows the devices that successfully installed a targeted deployment of the app, and **Users** - Shows the users whose devices successfully installed a targeted deployment of the app.

As before, you can use the **Filters** drop-down list to configure the values shown on each of the tabs.
