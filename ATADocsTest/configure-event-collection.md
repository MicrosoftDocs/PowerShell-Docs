---
# required metadata

title: Configure Event Collection | Microsoft ATA
description: Describes your options for configuring event collection with ATA
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 04/28/2016
ms.topic: get-started-article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: 3f0498f9-061d-40e6-ae07-98b8dcad9b20

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: bennyl
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

*Applies to: Advanced Threat Analytics version 1.6 and 1.7*



# Configure Event Collection
To enhance detection capabilities, ATA needs Windows Event log ID 4776. This can be forwarded to the ATA Gateway in one of two ways, by configuring the ATA Gateway to listen for SIEM events or by [Configuring Windows Event Forwarding](#configuring-windows-event-forwarding).

## Event collection
In addition to collecting and analyzing network traffic to and from the domain controllers, ATA can use Windows event 4776 to further enhance ATA Pass-the-Hash detection. This can be received from your SIEM or by  setting Windows Event Forwarding from your domain controller. Events collected provide ATA with additional information that is not available via the domain controller network traffic.

### SIEM/Syslog
For ATA to be able to consume data from a Syslog server, you need to do the following:

-   Configure your ATA Gateway servers to listen to and accept events forwarded from the SIEM/Syslog server.

-   Configure your SIEM/Syslog server to forward specific events to the ATA Gateway.

> [!IMPORTANT]
> -   Do not forward all the Syslog data to the ATA Gateway.
> -   ATA supports UDP traffic from the SIEM/Syslog server.

Refer to your SIEM/Syslog server's product documentation for information on how to configure forwarding of specific events to another server. 

### Windows event forwarding
If you do not use a SIEM/Syslog server, you can configure your Windows domain controllers to forward Windows Event ID 4776 to be collected and analyzed by ATA. Windows Event ID 4776 provides data regarding NTLM authentications.

## Configuring the ATA Gateway to listen for SIEM events

1.  On the ATA configuration, under "Events" tab enable **Syslog** and press **Save**.

    ![Enable syslog listener UDP image](media/ATA-enable-siem-forward-events.png)

2.  Configure your SIEM or Syslog server to forward Windows Event ID 4776 to the IP address of one of the ATA Gateways. For additional information on configuring your SIEM, refer to your SIEM online help or technical support options for specific formatting requirements for each SIEM server.

### SIEM support
ATA supports SIEM events in the following formats:

#### RSA Security Analytics
&lt;Syslog Header&gt;RsaSA\n2015-May-19 09:07:09\n4776\nMicrosoft-Windows-Security-Auditing\nSecurity\XXXXX.subDomain.domain.org.il\nYYYYY$\nMMMMM \n0x0

-   Syslog header is optional.

-   “\n” character separator is required between all fields.

-   The fields, in order, are:

    1.  RsaSA constant (must appear).

    2.  The timestamp of the actual event (make sure it’s not the timestamp of the arrival to the SIEM or when it’s sent to ATA). Preferably  in milliseconds accuracy, this is very important.

    3.  The windows event ID

    4.  The windows event provider name

    5.  The windows event log name

    6.  The name of the computer receiving the event (the DC in this case)

    7.  The name of the user authenticating

    8.  The name of the source host name

    9. The result code of the NTLM

-   The order is important and nothing else should be included in the message.

#### HP Arcsight
CEF:0|Microsoft|Microsoft Windows||Microsoft-Windows-Security-Auditing:4776|The domain controller attempted to validate the credentials for an account.|Low| externalId=4776 cat=Security rt=1426218619000 shost=KKKKKK dhost=YYYYYY.subDomain.domain.com duser=XXXXXX cs2=Security cs3=Microsoft-Windows-Security-Auditing cs4=0x0 cs3Label=EventSource cs4Label=Reason or Error Code

-   Must comply with the protocol definition.

-   No syslog header.

-   The header part (the part that’s separated by a pipe) must exist (as stated in the protocol).

-   The following keys in the _Extension_ part must be present in the event:

    -   externalId = the Windows event ID

    -   rt = the timestamp of the actual event (make sure it’s not the timestamp of the arrival to the SIEM or when it’s sent to us). Preferably  in milliseconds accuracy, this is very important.

    -   cat = the Windows event log name

    -   shost = the source host name

    -   dhost = the computer receiving the event (the DC in this case)

    -   duser = the user authenticating

-   The order is not important for the _Extension_ part

-   There must be a custom key and keyLable for these two fields:

    -   “EventSource”

    -   “Reason or Error Code” = The result code of the NTLM

#### Splunk
&lt;Syslog Header&gt;\r\nEventCode=4776\r\nLogfile=Security\r\nSourceName=Microsoft-Windows-Security-Auditing\r\nTimeGenerated=20150310132717.784882-000\r\ComputerName=YYYYY\r\nMessage=

The computer attempted to validate the credentials for an account.

Authentication Package:              MICROSOFT_AUTHENTICATION_PACKAGE_V1_0

Logon Account: Administrator

Source Workstation:       SIEM

Error Code:         0x0

-   Syslog header is optional.

-   There’s a “\r\n” character separator between all required fields.

-   The fields are in key=value format.

-   The following keys must exists and have a value:

    -   EventCode = the Windows event ID

    -   Logfile = the Windows event log name

    -   SourceName = The Windows event provider name

    -   TimeGenerated = the timestamp of the actual event (make sure it’s not the timestamp of the arrival to the SIEM or when it’s sent to ATA). The format should match yyyyMMddHHmmss.FFFFFF, preferably  in milliseconds accuracy, this is very important.

    -   ComputerName = the source host name

    -   Message = the original event text from the Windows event

-   The Message Key and value MUST be last.

-   The order is not important for the key=value pairs.

#### QRadar
QRadar enables event collection via an agent. If the data is gathered using an agent, the time format is gathered without millisecond data. Because ATA necessitates millisecond data, it is necessary to set QRadar to use agentless Windows event collection. For more information, see [http://www-01.ibm.com/support/docview.wss?uid=swg21700170](http://www-01.ibm.com/support/docview.wss?uid=swg21700170 "QRadar: Agentless Windows Events Collection using the MSRPC Protocol").

    <13>Feb 11 00:00:00 %IPADDRESS% AgentDevice=WindowsLog AgentLogFile=Security Source=Microsoft-Windows-Security-Auditing Computer=%FQDN% User= Domain= EventID=4776 EventIDCode=4776 EventType=8 EventCategory=14336 RecordNumber=1961417 TimeGenerated=1456144380009 TimeWritten=1456144380009 Message=The computer attempted to validate the credentials for an account. Authentication Package: MICROSOFT_AUTHENTICATION_PACKAGE_V1_0 Logon Account: Administrator Source Workstation: HOSTNAME Error Code: 0x0

The fields needed are:

- The agent type for the collection
- The windows event log provider name
- The windows event log source
- The DC fully qualified domain name
- The windows event ID

TimeGenerated is the timestamp of the actual event (make sure it’s not the timestamp of the arrival to the SIEM or when it’s sent to ATA). The format should match yyyyMMddHHmmss.FFFFFF, preferably in milliseconds accuracy, this is very important.

Message is the original event text from the Windows event

Make sure to have \t between the key=value pairs.

>[!NOTE] 
> Using WinCollect for Windows event collection is not supported.

## Configuring Windows Event Forwarding

### WEF configuration for ATA Gateway's with port mirroring

After you configured port mirroring from the domain controllers to the ATA Gateway, follow the instructions below to configure Windows Event forwarding using Source Initiated configuration. This is one way to configure Windows Event forwarding. 

**Step 1: Add the network service account to the domain Event Log Readers Group.** 

In this scenario we are assuming that the ATA Gateway is a member of the domain.

1.	Open Active Directory Users and Computers, navigate to the **BuiltIn** folder and double click **Event Log Readers**. 
2.	Select **Members**.
4.	If **Network Service** is not listed, click **Add**, type **Network Service** in the **Enter the object names to select** field. Then click **Check Names** and click **OK** twice. 

**Step 2: Create a policy on the domain controllers to set the Configure target Subscription Manager setting.** 
> [!Note] 
> You can create a group policy for these settings and apply the group policy to each domain controller monitored by the ATA Gateway. The steps below modify the local policy of the domain controller. 	

1.	Run the following command on each domain controller: *winrm quickconfig*
2.  From a command prompt type *gpedit.msc*.
3.	Expand **Computer Configuration > Administrative Templates > Windows Components > Event Forwarding**

 ![Local policy group editor image](media/wef 1 local group policy editor.png)

4.	Double click **Configure target Subscription Manager**.
   
    1.	Select **Enabled**.
    2.	Under **Options** click **Show**.
    3.	Under **SubscriptionManagers** enter the following value and click **OK**:	*Server=http://<fqdnATAGateway>:5985/wsman/SubscriptionManager/WEC,Refresh=10* (For example: Server=http://atagateway9.contoso.com:5985/wsman/SubscriptionManager/WEC,Refresh=10)
 
   ![Configure target subscription image](media/wef 2 config target sub manager.png)
   
    5.	Click **OK**.
    6.	From an elevated command prompt type *gpupdate /force*. 

**Step 3: Perform the following steps on the ATA Gateway** 

1.	Open an elevated command prompt and type *wecutil qc*
2.	Open **Event Viewer**. 
3.	Right click **Subscriptions** and select **Create Subscription**. 

   1.	Enter a name and description for the subscription. 
   2.	For **Destination Log** confirm that **Forwarded Events** is selected. For ATA to read the events, the destination log must be **Forwarded Events**. 
   3.	Select **Source computer initiated** and click **Select Computers Groups**.
        1.	Click **Add Domain Computer**.
        2.	Enter the name of the domain controller in the **Enter the object name to select** field. Then click **Check Names** and click **OK**. 
       
        ![Event Viewer image](media/wef3 event viewer.png)
   
        
        3.	Click **OK**.
   4.	Click **Select Events**.

        1. Click **By log** and select **Security**.
        2. In the **Includes/Excludes Event ID** field type **4776** and click **OK**. 

 ![Query filter image](media/wef 4 query filter.png)

   5.	Right click the created subscription and select **Runtime Status** to see if there are any issues with the status. 
   6.	After a few minutes, check to see that event 4776 is showing up in the Forwarded Events on the ATA Gateway.


### WEF configuration for the ATA Lightweight Gateway
When you install the ATA Lightweight Gateway on your domain controllers, you can set up your domain controllers to forward the events to itself. 
Perform the following steps to configure the Window Event Forwarding when using the ATA Lightweight Gateway. This is one way to configure Windows Event forwarding.  

**Step 1: Add the network service account to the domain Event Log Readers Group** 

1.	Open Active Directory Users and Computer, navigate to the **BuiltIn** folder and double click **Event Log Readers**. 
2.	Select **Members**.
3.	If **Network Service** is not listed, click **Add** and type **Network Service** in the **Enter the object names to select** field. Then click **Check Names** and click **OK** twice. 

**Step 2: Perform the following steps on the domain controller after the ATA Lightweight Gateway is installed** 

1.	Open an elevated command prompt and type *winrm quickconfig* and *wecutil qc* 
2.	Open **Event Viewer**. 
3.	Right click **Subscriptions** and select **Create Subscription**. 

   1.	Enter a name and description for the subscription. 
   2.	For **Destination Log** confirm that **Forwarded Events** is selected. For ATA to read the events the destination log must be Forwarded Events.

        1.	Select **Collector initiated** and click **Select Computers**. Then click **Add Domain Computer**.
        2.	Enter the name of the domain controller in the **Enter the object name to select**. Then click **Check Names** and click **OK**.

            ![Subscription properties image](media/wef 5 sub properties computers.png)

        3.	Click **OK**.
   3.	Click **Select Events**.

        1.	Click **By log** and select **Security**.
        2.	In the **Includes/Excludes Event ID** type *4776* and click **OK**. 

![Query filter image](media/wef 4 query filter.png)


  4.	Right click the created subscription and select **Runtime Status** to see if there are any issues with the status. 

> [!Note] 
> You may need to reboot the domain controller before the setting take effect. 

After a few minutes, check to see that event 4776 is showing up in the Forwarded Events on the ATA Gateway.



For more information see: [Configure the computers to forward and collect events](https://technet.microsoft.com/library/cc748890)

## See Also
- [Install ATA](install-ata.md)
- [Check out the ATA forum!!](https://social.technet.microsoft.com/Forums/security/en-US/home?forum=mata)
