---
# required metadata

title: Exchange connector for on-premises EAS | Microsoft Intune
description: Use the Connector tool to enable communication between the Intune admin console and on-premises Exchange Server for Exchange ActiveSync MDM.
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 41ff4212-a6f5-4374-8731-631f7560cff1

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: muhosabe
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Install the Intune on-premises Exchange Connector


To set up a connection that enables Microsoft Intune to communicate with the Exchange Server that hosts the mobile devices’ mailboxes, you must download and configure the On-Premises Connector tool from the Intune administrator console. Intune only supports one Exchange connector connection of any type per subscription.

## Requirements for the On-Premises Connector
The following table lists the requirements for the computer where you install the on-premises Exchange Connector.

|Requirement|More information|
|---------------|--------------------|
|Operating systems|Intune supports the on-premises Exchange Connector on a computer that runs any edition of Windows Server 2008 SP2 64 bit, Windows Server 2008 R2, Windows Server 2012, or Windows Server 2012 R2.<br /><br />The connector is not supported on any Server Core installation.|
|Microsoft Exchange version|Either on-premises Connector requires Microsoft Exchange 2010 SP1 or later, or legacy Exchange Online Dedicated. To determine whether your Exchange Online Dedicated environment is in the **new** or **legacy** configuration,  contact your account manager.|
|Mobile device management authority| [Set the mobile device management authority to Intune](get-ready-to-enroll-devices-in-microsoft-intune.md#set-mobile-device-management-authority).|
|Hardware|The computer where you install the connector requires a 1.6 GHz CPU with 2 GB ram and 10 GB of free disk space  minimum hardware.|
|Active Directory Synchronization|Before you can use either Connector to connect Intune to your Exchange Server, you must [set up Active Directory synchronization](/intune/get-started/start-with-a-paid-subscription-to-microsoft-intune-step-3) so that your local users and security groups are synchronized with your instance of Azure Active Directory.|
|Additional software|A full installation of Microsoft .NET Framework 4 and Windows PowerShell 2.0 must be installed on the computer that hosts the connector.|
|Network|The computer where you install the connector must be in a domain that has a trust relationship to the domain that hosts your Exchange Server.<br /><br />The computer requires configurations to enable it to access the Intune service through firewalls and proxy servers over Ports 80 and 443. Domains used by Intune include manage.microsoft.com, &#42;manage.microsoft.com, and &#42;.manage.microsoft.com.|
|Hosted Exchange configured and running|See [Exchange Server 2016](https://technet.microsoft.com/library/mt170645.aspx) for more information. |

### Exchange cmdlet requirements

You must create an Active Directory user account that is used by the Intune Exchange Connector. The account must have permission to run the following required Windows PowerShell Exchange cmdlets:


 -   Get-ActiveSyncOrganizationSettings, Set-ActiveSyncOrganizationSettings
 -   Get-CasMailbox, Set-CasMailbox
 -   Get-ActiveSyncMailboxPolicy, Set-ActiveSyncMailboxPolicy, New-ActiveSyncMailboxPolicy, Remove-ActiveSyncMailboxPolicy
 -   Get-ActiveSyncDeviceAccessRule, Set-ActiveSyncDeviceAccessRule, New-ActiveSyncDeviceAccessRule, Remove-ActiveSyncDeviceAccessRule
 -   Get-ActiveSyncDeviceStatistics
 -   Get-ActiveSyncDevice
 -   Get-ExchangeServer
 -   Get-ActiveSyncDeviceClass
 -   Get-Recipient
 -   Clear-ActiveSyncDevice, Remove-ActiveSyncDevice
 -   Set-ADServerSettings
 -   Get-Command

## Download the on-premises Exchange Connector software installation package

1. On a supported Windows Server operating system for the on-premises Exchange Connector, open the [Microsoft Intune administration console](http://manage.microsoft.com) (http://manage.microsoft.com) with a user account that is an administrator in the Exchange tenant with a license to use Exchange Server.
![Open set up Exchange Connection](../media/ExchangeConnector.gif)

2.  In the workspace shortcuts pane, choose **Admin**, choose **Mobile Device Management** > **Microsoft Exchange**, and then choose **Setup Exchange Connection**.

3.  On the **Setup Exchange Connection** page, choose **Download On-Premises Connector**.

4.  The on-premises Exchange Connector is contained in a compressed (.zip) folder that can be opened or saved. In the **File Download** dialog box, choose **Save** to store the compressed folder to a secure location.

> [!IMPORTANT]
> Do not rename or move the files within the on-premises Exchange Connector folder. Moving or renaming the folder's contents will break the installation.

## Install and configure the Intune on-premises Exchange Connector
Perform the following steps to install the Intune on-premises Exchange Connector. The on-premises Exchange Connector can only be installed once per Intune subscription, and only on one computer. If you try to configure an additional on-premises Exchange Connector, the new connection will replace the original one.

1.  On a supported operating system for the On-Premises Connector, extract the files in **Exchange_Connector_Setup.zip** to a secure location.

2.  After the files are extracted, open the extracted folder and double-click **Exchange_Connector_Setup.exe** to install the on-premises Exchange Connector.

    > [!IMPORTANT]
    > If the destination folder is not a secure location, you should delete the certificate file **WindowsIntune.accountcert** after you install the On-Premises Connector.

3.  In the **Exchange server** field, select your Exchange server environment type, either **On-premises Microsoft Exchange Server** or select **Hosted Microsoft Exchange Server**.

  ![Choose your Exchange Server type](../media/IntuneSA1dconfigureExchConnector.png)

  For an on-premises Exchange server, provide either the server name or the fully qualified domain name of the Exchange server that hosts the **Client Access Server** role.

  For a hosted Exchange server, provide the Exchange server address. To find the hosted Exchange server URL:

      1.  Open the Outlook Web App for Office 365.

      2.  Choose the “?” icon at the top left, and select **About**.

      3.  Locate the **POP External Server** value.

      4.  Choose **Proxy Server** to specify proxy server settings for your hosted Exchange server.
        1.  Select **Use a proxy server when synchronizing mobile device information**.

        2.  Enter the **proxy server name** and the **port number** to be used to access the server.

        3.  If it is necessary to provide user credentials to access the proxy server, select Use credentials to connect to the proxy server and enter the **domain\user** and the **password**.

        4.  Choose **OK**.

5.  Provide the credentials, **User (Domain\user)** and **Password** necessary to connect to your Exchange server.

6.  Provide administrative credentials necessary to send notifications to a user’s Exchange mailbox. These notifications are configurable via Conditional Access policies using Intune.

    Ensure that the Autodiscover service and Exchange Web Services are configured on the Exchange Client Access Server. For more information on that see [Client Access server](https://technet.microsoft.com/library/dd298114.aspx).

7.  In the **Password** field, provide the password for this account to enable Intune to access the Exchange Server.

8. Choose **Connect**.

    It may take a few minutes while the connection is set up.

During configuration, the Exchange Connector stores your proxy settings to enable access to the Internet. If your proxy settings change, you will have to reconfigure the Exchange Connector in order to apply the updated proxy settings to the Exchange Connector.

After the Exchange Connector sets up the connection, mobile devices associated with users that are managed in Exchange Connector are automatically synchronized and added to the Exchange Connector. This synchronization may take some time to complete.

> [!NOTE]
> If you have installed the on-premises Exchange Connector, and if at some point you delete the Exchange connection, you must uninstall the on-premises Exchange Connector from the computer onto which it was installed.

## Validate Exchange connection

After you have successfully configured the Exchange Connector, you can view the status of the connection and the last successful synchronization attempt. In the [Microsoft Intune administration console](http://manage.microsoft.com) choose the **ADMIN** workspace, and under **Mobile Device Management**, choose **Microsoft Exchange**, and validate that the details you provided appear under **Exchange Connection Information**.


You can also check the time and date of the last successful synchronization attempt.
