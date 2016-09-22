---
# required metadata

title: Install ATA Silently | Microsoft ATA
description: This describes how to silently install ATA.
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 04/28/2016
ms.topic: get-started-article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: b3cceb18-0f3c-42ac-8630-bdc6b310f1d6

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



# ATA Silent Installation
This article provides instructions for silently installing ATA.
## Prerequisites

Microsoft ATA v1.7 requires the installation of Microsoft .NET Framework 4.6.1. 

When you install or update ATA, .Net Framework 4.6.1 will be automatically installed as part of the deployment of Microsoft ATA.

> [!Note] 
> The installation of .Net framework 4.6.1 may require rebooting the server. When installing ATA Gateway on Domain Controllers, consider scheduling a maintenance window for these Domain Controllers.
When using ATA silent installation method, the installer is configured to automatically restart the server at the end of the installation (if necessary). To avoid restarting the server as part of the installation, use the `-NoRestart` flag. When using the `-NoRestart` flag and restart will be required as part of the installation, the installer will pause until the server is restarted. To track the progress of the deployment, monitor ATA installer logs which are located in **%AppData%\Local\Temp**.


## Install the ATA Center

Use the following command to install the ATA Center:

**Syntax**:

    “Microsoft ATA Center Setup.exe” [/quiet] [/NoRestart] [/Help] [--LicenseAccepted] [NetFrameworkCommandLineArguments=”/q”] [InstallationPath=“<InstallPath>”] [DatabaseDataPath= “<DBPath>”] [CenterIpAddress=<CenterIPAddress>] [CenterPort=<CenterPort>] [CenterCertificateThumbprint=“<CertThumbprint>”] 
    [ConsoleIpAddress=<ConsoleIPAddress>] [ConsoleCertificateThumbprint=”<CertThumbprint >”]
    
**Installation options**:

|Name|Syntax|Mandatory for silent installation?|Description|
|-------------|----------|---------|---------|
|Quiet|/quiet|Yes|Runs the installer displaying no UI and no prompts.|
|NoRestart|/norestart|No|Suppresses any attempts to restart. By default, UI will prompt before restart.|
|Help|/help|No|Provides help and quick reference. Displays the correct use of the setup command including a list of all options and behaviors.|
|NetFrameworkCommandLineArguments="/q"|NetFrameworkCommandLineArguments="/q"|Yes|Specifies the parameters for the .Net Framework installation. Must be set to enforce the silent installation of .Net Framework.|
|LicenseAccepted|--LicenseAccepted|Yes|Indicates that the license was read and approved. Must be set on silent installation.|

**Installation parameters**:

|Name|Syntax|Mandatory for silent installation?|Description|
|-------------|----------|---------|---------|
|InstallationPath|InstallationPath=“<InstallPath>”|No|Sets the path for the installation of ATA binaries. Default path: C:\Program Files\Microsoft Advanced Threat Analytics\Center|
|DatabaseDataPath|DatabaseDataPath= “<DBPath>”|No|Sets the path for the ATA Database data folder. Default path: C:\Program Files\Microsoft Advanced Threat Analytics\Center\MongoDB\bin\data|
|CenterIpAddress|CenterIpAddress=<CenterIPAddress>|Yes|Sets the IP address of the ATA Center Service|
|CenterPort|CenterPort=<CenterPort>|Yes|Sets the network port of the ATA Center Service|
|CenterCertificateThumbprint|CenterCertificateThumbprint=“<CertThumbprint>”|No|Sets the certificate thumbprint for the ATA Center Service. This Certificate is used to secure communication between the ATA Center and the ATA Gateway. If not set, the installation will generate a self-signed certificate.|
|ConsoleIpAddress|ConsoleIpAddress=<ConsoleIPAddress>|Yes|Sets the IP address of the ATA Console|
|ConsoleCertificateThumbprint|ConsoleCertificateThumbprint=”<CertThumbprint >”|No|Specifies the certificate thumbprint for the ATA Console. This Certificate is used to validate the identity of the ATA Console website.If not specified, the installation will generate a self-signed certificate|

**Examples**:
To install the ATA Center with default installation paths and a single IP address:

    “Microsoft ATA Center Setup.exe” /quiet --LicenseAccepted NetFrameworkCommandLineArguments="/q" CenterIpAddress=192.168.0.10
    CenterPort=444 ConsoleIpAddress=192.168.0.10

To install the ATA Center with default installation paths, two IP addresses, and user-defined certificate thumbprints:

    “Microsoft ATA Center Setup.exe” /quiet --LicenseAccepted NetFrameworkCommandLineArguments ="/q" CenterIpAddress=192.168.0.10 CenterPort=443 CenterCertificateThumbprint= ‎"1E2079739F624148ABDF502BF9C799FCB8C7212F”
    ConsoleIpAddress=192.168.0.11  ConsoleCertificateThumbprint=”G9530253C976BFA9342FD1A716C0EC94207BFD5A”

## Update the ATA Center

Use the following command to update the ATA Center:

**Syntax**:

    Microsoft ATA Center Setup.exe” [/quiet] [-NoRestart] /Help] [NetFrameworkCommandLineArguments=”/q”]


**Installation options**:

|Name|Syntax|Mandatory for silent installation?|Description|
|-------------|----------|---------|---------|
|Quiet|/quiet|Yes|Runs the installer displaying no UI and no prompts.|
|NoRestart|/norestart|No|Suppresses any attempts to restart. By default, the UI will prompt before restart.|
|Help|/help|No|Provides help and quick reference. Displays the correct use of the setup command including a list of all options and behaviors.|
|NetFrameworkCommandLineArguments="/q"|NetFrameworkCommandLineArguments="/q"|Yes|Specifies the parameters for the .Net Framework installation. Must be set to enforce the silent installation of .Net Framework.|


When updating ATA, the installer automatically detects that ATA is already installed on the server, and no update installation option is required.

**Examples**:
To update the ATA Center silently. In large environments, the ATA Center update can take a while to complete. Monitor ATA logs to track the progress of the update.

    	“Microsoft ATA Center Setup.exe” /quiet NetFrameworkCommandLineArguments="/q"

## Uninstall the ATA Center silently

Use the following command to perform a silent uninstall of the ATA Center:
**Syntax**:

    Microsoft ATA Center Setup.exe [/quiet] [/Uninstall] [/NoRestart] [/Help]
     [--DeleteExistingDatabaseData]

**Installation options**:

|Name|Syntax|Mandatory for silent uninstallation?|Description|
|-------------|----------|---------|---------|
|Quiet|/quiet|Yes|Runs the uninstaller displaying no UI and no prompts.|
|Uninstall|/uninstall|Yes|Runs the silent uninstallation of the ATA Center from the server.|
|NoRestart|/norestart|No|Suppresses any attempts to restart. By default, the UI will prompt before restart.|
|Help|/help|No|Provides help and quick reference. Displays the correct use of the setup command including a list of all options and behaviors.|

**Installation parameters**:

|Name|Syntax|Mandatory for silent uninstallation?|Description|
|-------------|----------|---------|---------|
|DeleteExistingDatabaseData|DeleteExistingDatabaseData|No|Deletes all the files in the existing database.|

**Examples**:
To silently uninstall the ATA Center from the server, removing all existing database data:


    “Microsoft ATA Center Setup.exe” /quiet /uninstall --DeleteExistingDatabaseData

## ATA Gateway Silent Installation
Use the following command to silently install the ATA Gateway:

**Syntax**:

    Microsoft ATA Gateway Setup.exe [/quiet] [/NoRestart] [/Help] [NetFrameworkCommandLineArguments ="/q"] 
    [GatewayCertificateThumbprint=”<CertThumbprint >”] [ConsoleAccountName=”<AccountName>”] 
    [ConsoleAccountPassword=”<AccountPassword>”]

**Installation options**:

|Name|Syntax|Mandatory for silent installation?|Description|
|-------------|----------|---------|---------|
|Quiet|/quiet|Yes|Runs the installer displaying no UI and no prompts.|
|NoRestart|/norestart|No|Suppresses any attempts to restart. By default, UI will prompt before restart.|
|Help|/help|No|Provides help and quick reference. Displays the correct use of the setup command including a list of all options and behaviors.|
|NetFrameworkCommandLineArguments="/q"|NetFrameworkCommandLineArguments="/q"|Yes|Specifies the parameters for the .Net Framework installation. Must be set to enforce the silent installation of .Net Framework.|
|LicenseAccepted|--LicenseAccepted|Yes|Indicates that the license was read and approved. Must be set on silent installation.|

**Installation parameters**:

|Name|Syntax|Mandatory for silent installation?|Description|
|-------------|----------|---------|---------|
|GatewayCertificateThumbprint|GatewayCertificateThumbprint=”<CertThumbprint >”|No|Sets the certificate thumbprint for the ATA Center service. This certificate is used to secure communication between the ATA Center and the ATA Gateway. If not set, the installation will generate a self-signed certificate.|
|ConsoleAccountName|ConsoleAccountName=”<AccountName>”|Yes|Sets the name of the user account (user@domain.com) that is used to register the ATA Gateway with the ATA Center.|
|ConsoleAccountPassword|ConsoleAccountPassword=”<AccountPassword>”|Yes|Sets the password for the user account (user@domain.com) that is used to register the ATA Gateway with the ATA Center.|

**Examples**:
To silently install the ATA Gateway and register it with the ATA Center using the specified credentials:

    “Microsoft ATA Gateway Setup.exe” /quiet NetFrameworkCommandLineArguments="/q" 
    ConsoleAccountName=”user@contoso.com” ConsoleAccountPassword=“userpwd”
    

## Update the ATA Gateway

Use the following command to silently update the ATA Gateway:

**Syntax**:

    Microsoft ATA Gateway Setup.exe [/quiet] [/NoRestart] /Help] [NetFrameworkCommandLineArguments="/q"]


**Installation options**:

|Name|Syntax|Mandatory for silent installation?|Description|
|-------------|----------|---------|---------|
|Quiet|/quiet|Yes|Runs the installer displaying no UI and no prompts.|
|NoRestart|/norestart|No|Suppresses any attempts to restart. By default, the UI will prompt before restart.|
|Help|/help|No|Provides help and quick reference. Displays the correct use of the setup command including a list of all options and behaviors.|
|NetFrameworkCommandLineArguments="/q"|NetFrameworkCommandLineArguments="/q"|Yes|Specifies the parameters for the .Net Framework installation. Must be set to enforce the silent installation of .Net Framework.|


**Examples**:
To update the ATA Gateway silently:

    	Microsoft ATA Gateway Setup.exe /quiet NetFrameworkCommandLineArguments="/q"

## Uninstall the ATA Gateway silently

Use the following command to perform a silent uninstall of the ATA Gateway:
**Syntax**:

    Microsoft ATA Gateway Setup.exe [/quiet] [/Uninstall] [/NoRestart] [/Help]
    
**Installation options**:

|Name|Syntax|Mandatory for silent uninstallation?|Description|
|-------------|----------|---------|---------|
|Quiet|/quiet|Yes|Runs the uninstaller displaying no UI and no prompts.|
|Uninstall|/uninstall|Yes|Runs the silent uninstallation of the ATA Gateway from the server.|
|NoRestart|/norestart|No|Suppresses any attempts to restart. By default, the UI will prompt before restart.|
|Help|/help|No|Provides help and quick reference. Displays the correct use of the setup command including a list of all options and behaviors.|

**Examples**:
To silently uninstall the ATA Gateway from the server:


    Microsoft ATA Gateway Setup.exe /quiet /uninstall
    









## See Also

- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
- [Configure event collection](configure-event-collection.md)
- [ATA prerequisites](/advanced-threat-analytics/plan-design/ata-prerequisites)