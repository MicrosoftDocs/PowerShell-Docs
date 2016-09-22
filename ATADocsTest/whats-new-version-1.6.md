---
# required metadata

title: What's new in ATA version 1.6 | Microsoft ATA
description: Lists what was new in ATA version 1.6 along with known issues
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 04/28/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: a0d64aff-ca9e-4300-b3f8-eb3c8b8ae045

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: bennyl
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# What's new in ATA version 1.6
These release notes provide information about known issues in this version of  Advanced Threat Analytics.

## What's new in the ATA 1.6 update?
The update to ATA 1.6 provides improvements in the following areas:

-   New detections

-   Improvements to existing detections

-   The ATA Lightweight Gateway

-   Automatic updates

-   Improved ATA Center performance

-   Lower storage requirements

-   Support for IBM QRadar

### New detections


- **Malicious Data Protection Private Information Request**
Data Protection API (DPAPI) is a password-based data protection service. This protection service is used by various applications that store user’s secrets, such as website passwords and file-share credentials. In order to support password-loss scenarios, users can decrypt protected data by using a recovery key which does not involve their password. In a domain environment, attackers can remotely steal the recovery key and use it to decrypt protected data on all domain joined computers.


- **Net Session Enumeration**
Reconnaissance is a key stage within the advanced attack kill chain. Domain Controllers (DCs) function as file servers for the purpose of Group Policy Object distribution, using the Server Message Block (SMB) protocol. As part of the reconnaissance phase, attackers can query the DC for all active SMB sessions on the server, allowing them to gain access to all users and IP addresses associated with those SMB sessions. SMB session enumeration can be used by attackers for targeting sensitive accounts, helping them move laterally across the network.


- **Malicious replication requests**
In Active Directory environments, replication happens regularly between Domain Controllers. An attacker can spoof an Active Directory replication request (sometimes impersonating a Domain Controller) allowing the attacker to retrieve the data stored in Active Directory, including password hashes, without utilizing more intrusive techniques like Volume Shadow Copy.


- **Detection of MS11-013 vulnerability**
There is an elevation of privilege vulnerability in Kerberos which allows for certain aspects of a Kerberos service ticket to be forged. A malicious user or attacker who successfully exploits this vulnerability can obtain a token with elevated privileges on the Domain Controller.


- **Unusual protocol implementation**
Authentication requests (Kerberos or NTLM) are usually performed using a standard set of methods and protocols. However, in order to successfully authenticate, the request must meet only a specific set of requirements. Attackers might implement these protocols with minor deviations from the standard implementation in the environment. These deviations might indicate the presence of an attacker attempting to execute attacks such as Pass-The-Hash, Brute Force and others.


### Improvements to existing detections
ATA 1.6 includes improved detection logic that reduces false-positive and false-negative scenarios for existing detections such as Golden Ticket, Honey Token, Brute Force and Remote Execution.

### The ATA Lightweight Gateway
This version of ATA introduces a new deployment option for the ATA Gateway, which allows an ATA Gateway to be installed directly on the Domain Controller. This deployment option removes non-critical functionality of the ATA Gateway and introduces dynamic resource management based on available resources on the DC, which makes sure the existing operations of the DC are not affected. The ATA Lightweight Gateway reduces the cost of ATA deployment. At the same time it makes deployment easier in branch sites, in which there is limited hardware resource capacity or inability to set up port-mirroring support.
For more information about the ATA Lightweight Gateway, see [ATA architecture](/advanced-threat-analytics/plan-design/ata-architecture#ata-gateway-and-ata-lightweight-gateway)

For more information about deployment considerations and choosing the right type of gateways for you, see [ATA capacity planning](/advanced-threat-analytics/plan-design/ata-capacity-planning#choosing-the-right-gateway-type-for-your-deployment)


### Automatic updates
Starting with version 1.6, it is possible to update the ATA Center using Microsoft Update. In addition, the ATA Gateways can now be automatically updated using their standard communication channel to the ATA Center.
### Improved ATA Center performance
With this version, a lighter database load and a more efficient way of running all detection enables many more domain controllers to be monitored with a single ATA Center.

### Lower storage requirements
ATA 1.6 necessitates ignificantly less storage space to run the ATA Database, now requiring only 20% of the storage space used in previous versions.

### Support for IBM QRadar
ATA now can now receive events from IBM's QRadar SIEM solution, in addition to the previously supported SIEM solutions.

## Known issues
The following known issues exist in this version.

### Failure to recognize new path in manually moved databases

In deployments in which the database path is manually moved, ATA deployment does not use the new database path for the update. This may cause the following issues:


- ATA may use all the free space in the system drive of the ATA Center, without circularly deleting old network activities.


- Updating ATA to version 1.6 may fail the pre-update Readiness Checks, as shown in the image below.
    ![Failed readiness check](media/ata_failed_readinesschecks.png)
	>[!Important]
Before updating ATA to version 1.6, update the following registry key with the correct database path:  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Advanced Threat Analytics\Center\DatabaseDataPath`

### Migration failure when updating from ATA 1.5
When updating to ATA 1.6, the update process may fail with the following error code:

![Update ATA to 1.6 error](http://i.imgur.com/QrLSApr.png)
If you see this error, review the deployment log in: **C:\Users\<User>\AppData\Local\Temp**, and look for the following exception:

    System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> MongoDB.Driver.MongoWriteException: A write operation resulted in an error. E11000 duplicate key error index: ATA.UniqueEntityProfile.$_id_ dup key: { : "<guid>" } ---> MongoDB.Driver.MongoBulkWriteException`1: A bulk write operation resulted in one or more errors.  E11000 duplicate key error index: ATA.UniqueEntityProfile.$_id_ dup key: { : " <guid> " }

You may also see this error: 
    System.ArgumentNullException: Value cannot be null.
    
If you see either of these errors, run the following workaround.

**Workaround**: 

1.	Move the folder "data_old" to a temporary folder (usually located in %ProgramFiles%\Microsoft Advanced Threat Analytics\Center\MongoDB\bin).
2.	Uninstall the ATA Center v1.5, and delete all database data.
![Uninstall ATA 1.5](http://i.imgur.com/x4nJycx.png)
3.	Re-install ATA Center v1.5. Make sure to use the same configuration as the previous ATA 1.5 installation (Certificates, IP addresses, DB path, etc.).
4.	Stop these services in the following order:
	1.	Microsoft Advanced Threat Analytics Center
	2.	MongoDB
5.	Replace the MongoDB database files with the files in the “data_old” folder.
6.	Start these services in the following order:
	1.	MongoDB
	2.	Microsoft Advanced Threat Analytics Center
7.	Review the logs to verify that the product is running without errors.
8.	[Download](http://aka.ms/ataremoveduplicateprofiles "Download") the "RemoveDuplicateProfiles.exe" tool and copy it to the main installation path (%ProgramFiles%\Microsoft Advanced Threat Analytics\Center)
9.	From an elevated command prompt, run “RemoveDuplicateProfiles.exe” and wait until it completes successfully.
10.	From here:  …\Microsoft Advanced Threat Analytics\Center\MongoDB\bin directory: **Mongo ATA**, type the following command:

    db.SuspiciousActivities.remove({ "_t" : "RemoteExecutionSuspiciousActivity", "DetailsRecords" : { "$elemMatch" : { "ReturnCode" : null } } }, { "_id" : 1 });

![Update workaround](http://i.imgur.com/Nj99X2f.png)

This should return a WriteResult({ "nRemoved" : XX }) where “XX” is the number of Suspicious Activities that were deleted. If the number is greater than 0, exit the command prompt, and continue with the update process.


### Net Framework 4.6.1 requires restarting the server

In some cases, the installation of .Net Framework 4.6.1 may require you to restart the server. Notice that clicking OK in the in the **Microsoft Advanced Threat Analytics Center Setup** dialog will automatically restart the server. This is especially important when installing the ATA Lightweight Gateway on a domain controller, as you may want to plan a maintenance window before the installation.
    ![.Net Framework restart](media/ata-net-framework-restart.png)

### Historical network activities no longer migrated
This version of ATA delivers an improved detection engine, which provides more accurate detection and reduces many false positive scenarios, especially for Pass-the-Hash.
The new and improved detection engine utilizes inline detection technology enabling detection without accessing historical network activity, to significantly increase the performance of the ATA Center. This also means that it is unnecessary to migrate historical network activity during the update procedure.
The ATA update procedure exports the data, in case you want it for future investigation, to `<Center Installation Path>\Migration` as a JSON file.

## See Also
[Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)

[Update ATA to version 1.6 - migration guide](ata-update-1.6-migration-guide.md)