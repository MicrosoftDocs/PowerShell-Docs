---
# required metadata

title: What threats does ATA detect? | Microsoft ATA
description: Lists the threats that Advanced Threat Analytics detects 
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 283e7b4e-996a-4491-b7f6-ff06e73790d2

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

## What threats does ATA look for?

ATA provides detection for the following various phases of an advanced attack: reconnaissance, credential compromise, lateral movement, privilege escalation, domain dominance and others. These detections are aimed at detecting advanced attacks and insider threats before they cause damage to your organization.
The detection of each phase results in several suspicious activities relevant for the phase in question, where each suspicious activity correlates to different flavors of possible attacks.
These phases in the kill-chain where ATA currently provides detections are highlighted in the image below.

![ATA focus on lateral activity in attack kill chain](media/attack-kill-chain-small.jpg)


### Reconnaissance
ATA provides multiple reconnaissance detections. These detections include:
-	**Reconnaissance using account enumeration**
Detects attempts by attackers using the Kerberos protocol to discover if a user exists, even if the activity was not logged as an event on the domain controller.
-	**Net Session Enumeration**
As part of the reconnaissance phase, attackers may query the DC for all active SMB sessions on the server, allowing them to gain access to all the users and IP addresses associated with those SMB sessions. SMB session enumeration can be used by attackers for targeting sensitive accounts, helping them move laterally across the network.
-	**Reconnaissance using DNS**
DNS information in the target network is often very useful reconnaissance information. DNS information contains a list of all the servers and often all the clients and the mapping to their IP addresses. Viewing DNS information may provide attackers with a detailed view of these entities in your environment allowing attackers to focus their efforts on the relevant entities for the campaign.
-   **Reconnaissance using directory services enumeration**
Detecting reconnaissance for entities (users, groups, etc.) performed using the SAM-remote protocol to run queries against the domain controllers. This reconnaissance method is prevalent in many types of malware seen in real-world attack scenarios. 


### Compromised credentials
To provide detection of compromised credentials, ATA leverages both machine-learning based behavioral analytics as well as known malicious attacks and technique detection.
Using behavioral analytics and machine learning, ATA is able to detect suspicious activities such as anomalous logins, abnormal resource access, and abnormal working hours which would point to credential compromise. To protect against compromised credentials, ATA detects the following known malicious attacks and techniques:
-	**Brute force**
In brute-force attacks, attackers try to guess user credentials by trying multiple users and pairing them with multiple password attempts. The attackers often use complex algorithms or dictionaries to try as many values as a system allows.
-	**Sensitive account exposed in plain text authentication**
If high-privileged account credentials are sent in plain text, ATA alerts you so that you can update the computer configuration.
-	**Service exposing accounts in plain text authentication** 
If a service on a computer is sending multiple account credentials in plain text, ATA alerts you so that you can update the service configuration.
-	**Honey Token account suspicious activities**
Honey Token accounts are dummy accounts set up to trap, identify, and track malicious activity that attempts to use these dummy accounts. ATA alerts you to any activities across these Honey Tokens accounts.
-	**Unusual protocol implementation**
Authentication requests (Kerberos or NTLM) are usually performed using a normal set of methods and protocols. However, in order to successfully authenticate, the request only has to meet a specific set of requirements. Attackers can implement these protocols with minor deviations from the normal implementation in the environment. These deviations may indicate the presence of an attacker attempting to leverage or successfully leveraging compromised credentials.
-	**Malicious Data Protection Private Information Request**
Data Protection API (DPAPI) is a password-based data protection service. This protection service is used by various applications that stores user’s secrets, such as website passwords and file share credentials. In order to support password-loss scenarios, users can decrypt protected data by using a recovery key which does not involve their password. In a domain environment, attackers may remotely steal the recovery key and use it to decrypt protected data in all the domain joined computers.
-	**Abnormal Behavior**
Often in cases of insider threats, as well as advanced attacks, the account credentials may be compromised using social engineering methods or new and not-yet-known methods and techniques. ATA is able to detect these types of compromises by analyzing the entity’s behavior and detecting and alerting on abnormalities of the operations performed by the entity.

### Lateral movement
To provide detection of lateral movement, when users take advantage of credentials that provide access to some resources to gain access resources that they are not meant to have access to, ATA leverages both machine-learning based behavioral analytics as well as known malicious attacks and technique detection.
Using behavioral analytics and machine learning, ATA detects abnormal resource access, abnormal devices used and other indicators that are evidence of lateral movement.
In addition, ATA is able to detect lateral movement by detecting the techniques used by attackers to perform lateral movement, such as:
-	**Pass the ticket** 
In pass the ticket attacks, attackers steal a Kerberos ticket from one computer and use it to gain access to another computer by impersonating an entity on your network.
-	**Pass the hash** 
In pass the hash attacks, attackers steal the NTLM hash of an entity, and use it to authenticate with NTLM and impersonate that entity and gain access to resources on your network.
-	**Over-pass the hash**
Over-pass the hash are attacks in which the attacker uses a stolen NTLM hash to authenticate with Kerberos, and obtain a valid Kerberos TGT ticket, which is then used to authenticate as a valid user and gain access to resources on your network.
-	**Abnormal behavior**
Lateral movement is a technique often used by attackers, to move between devices and areas in the victim’s network to gain access to privileged credentials or sensitive information of interest to the attacker. ATA is able to detect lateral movement by analyzing the behavior of users, devices and their relationship inside the corporate network, and detect on any abnormal access patterns which may indicate a lateral movement performed by an attacker.

### Privilege escalation
ATA detects successful and attempted privilege escalation attacks, in which attackers attempt to increase existing privileges and use them multiple times in order to eventually gain full control over the victim’s environment.
ATA enables privilege escalation detection by combining behavioral analytics to detect anomalous behavior of privileged accounts as well as detecting known and malicious attacks and techniques that are often used to escalate privileges such as:
-	**MS14-068 exploit (Forged PAC)**
Forged PAC are attacks in which the attacker plants authorization data in their valid TGT ticket in the form of a forged authorization header that grants them additional permissions that they weren't granted by their organization. In this scenario the attacker leverages previously compromised credentials, or credentials harvested during lateral movement operations.
-	**MS11-013 exploit (Silver PAC)**
MS11-013 exploit attacks are an elevation of privilege vulnerability in Kerberos which allows for certain aspects of a Kerberos service ticket to be forged. A malicious user or attacker who successfully exploited this vulnerability could obtain a token with elevated privileges on the Domain Controller. In this scenario the attacker leverages previously compromised credentials, or credentials harvested during lateral movement operations.

### Domain dominance
ATA detects attackers attempting or successfully achieving total control and dominance over the victim’s environment by performing detection over known techniques used by attackers, which include:
-	**Skeleton key malware**
In skeleton key attacks, malware is installed on your domain controller that allows attackers to authenticate as any user, while still enabling legitimate users to log on.
-	**Golden ticket**
In golden ticket attacks, an attacker steals the KBTGT's credentials, the Kerberos Golden Ticket. That ticket enables the attacker to create a TGT ticket offline, to be used to gain access to resources in the network.
-	**Remote execution**
Attackers can attempt to control your network by running code remotely on your domain controller.
-	**Malicious replication requests** In Active Directory (AD) environments replication happens regularly between Domain Controllers. An attacker can spoof AD replication request (sometimes impersonating as a Domain Controller) allowing the attacker to retrieve the data stored in AD, including password hashes, without utilizing more intrusive techniques like Volume Shadow Copy.


## What's next?

-   For more information about how ATA fits into your network: [ATA architecture](/advanced-threat-analytics/plan-design/ata-architecture)

-   To get started deploying ATA: [Install ATA](/advanced-threat-analytics/deploy-use/install-ata)

## See Also
[Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
