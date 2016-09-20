---
# required metadata

title: Wipe for Exchange managed mobile devices | Microsoft Intune
description: Microsoft Intune allows you to wipe or reset mobile devices that are managed using Exchange ActiveSync (EAS) with the Intune Exchange Connector
keywords:
author: nathbarn
manager: angrobe
ms.date: 07/25/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: e116b620-1e12-4b5c-9905-2f7acf2ae530

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: lancecra
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---


# Wipe for Exchange-managed mobile devices
Microsoft Intune allows you to wipe or reset mobile devices that are managed using Exchange ActiveSync (EAS) with the Intune Exchange Connector. The following table describes the retire/wipe capabilities available through Exchange ActiveSync:

|Type of Wipe|Windows 8.1 and Windows RT 8.1|Windows RT|Windows Phone 8|iOS|Android|
|----------------|----------------------------------|--------------|-------------------|-------|-----------|
|Full Wipe|Removes mail account and cached mail|Removes mail account and cached mail|Factory Reset|Factory Reset|Factory Reset|
|Selective Wipe/Email|Removes email account|Removes email account|Not supported|Not supported|Not supported|
|Selective Wipe/policies|Policy enforcement removed, but settings are not changed|Policy enforcement removed, but settings are not changed|Policy enforcement removed, but settings are not changed|Policy enforcement removed, but  settings are not changed|Policy enforcement removed, but settings are not changed|
