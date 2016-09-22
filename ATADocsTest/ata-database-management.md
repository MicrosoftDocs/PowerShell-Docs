---
# required metadata

title: ATA Database Management | Microsoft ATA
description: Procedures to help you move, backup, or restore the ATA database.
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 04/28/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 1d27dba8-fb30-4cce-a68a-f0b1df02b977

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



# ATA Database Management
If you need to move, backup or restore the ATA database, use these procedures for working with MongoDB.

## Backing up the ATA database
Refer to the [relevant MongoDB documentation](http://docs.mongodb.org/manual/administration/backup/).

## Restoring the ATA database
Refer to the [relevant MongoDB documentation](http://docs.mongodb.org/manual/administration/backup/).

## Moving the ATA database to another drive

1.  Stop the **Microsoft Advanced Threat Analytics Center** service.

2.  Stop the **MongoDB** service.

3.  Open the Mongo configuration file located by default at: C:\Program Files\Microsoft Advanced Threat Analytics\Center\MongoDB\bin\mongod.cfg.

    Find the parameter `storage: dbPath`

4.  Move the folder listed in the `dbPath` parameter to the new location.

5.  Change the `dbPath` parameter inside the mongo configuration file to the new folder path and save and close the file.

    ![Modify MongoDB configuration image](media/ATA-mongoDB-moveDB.png)

6.  Start the **MongoDB** service.

7. Start the **Microsoft Advanced Threat Analytics Center** service.

## ATA Configuration file
The configuration of ATA is stored in the "SystemProfile" collection in the database.
This collection is backed up every hour by the ATA Center service to files called: "SystemProfile_*timestamp*.json". The most recent 10 versions are stored.
This is located in a subfolder called "Backup". In the default ATA installed location it can be found here:  *C:\Program Files\Microsoft Advanced Threat Analytics\Center\Backup\SystemProfile_*timestamp*.json*. 

**Note**: It is recommended that you back up this file somewhere when making major changes to ATA.

It is possible to restore all the settings by running the following command:

`mongoimport.exe --db ATA --collection SystemProfile --file "<SystemProfile.json backup file>" --upsert`

## See Also
- [ATA architecture](/advanced-threat-analytics/plan-design/ata-architecture)
- [ATA prerequisites](/advanced-threat-analytics/plan-design/ata-prerequisites)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)

