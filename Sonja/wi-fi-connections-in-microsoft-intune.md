---
# required metadata

title: Wi-Fi connections | Microsoft Intune
description: Use Wi-Fi profiles to help users connect to your Wi-Fi networks.
keywords:
author: Nbigman
manager: angrobe
ms.date: 09/01/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 0b1b86ed-2e80-474d-8437-17dd4bc07b55

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: karanda
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Configure devices to connect to your corporate Wi-Fi networks

Use Microsoft Intune Wi-Fi profiles to deploy wireless network settings to users and devices in your organization. When you deploy a Wi-Fi profile, your users will have access to your corporate Wi-Fi without having to configure it themselves.

For example, you install a new Wi-Fi network named **Contoso Wi-Fi** and want to set up all iOS devices to connect to this network. Here's the process:

![Wi-Fi profile process summary](..\media\wi-fi-process-diagram.png) 

1.   Create a Wi-Fi profile containing the settings necessary to connect to the **Contoso Wi-Fi** wireless network.

2. Deploy the profile to the group of users with iOS devices.

3.   Users find the new **Contoso Wi-Fi** network in the list of wireless networks and can easily connect to this network.


## How to create a Wi-Fi profile

You can deploy Wi-Fi profiles to the following platforms:

-   Android 4.0 and later

-   iOS 8.0 and later

-   Mac OS X 10.9 and later

For devices that run Windows 8.1 or Windows 10 desktop or mobile, you can import a Wi-Fi configuration profile that was previously exported to a file. For details, see [Export or Import a Wi-Fi configuration profile for Windows devices](#export-or-import-a-wi-fi-configuration-profile-for-windows-devices).

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), click **Policy** &gt; **Add Policy**.

2.  Select one of the following policy types, and then click **Create Policy**:

    -   Wi-Fi Profile (Android 4 and later)

    -   Wi-Fi Profile (iOS 8.0 and later)

    -   Wi-Fi Profile (Mac OS X 10.9 and later)

    There are no recommended settings for this policy type. You must create a custom policy.

3.  Provide the name and description for the profile.

4. Specify the **Network Connections** values.
 - **SSID (Service Set Identifier)**: Users see the network name, not the SSID.
 - **Connect when the network is not broadcasting its name (SSID)**: Select this option to allow devices to connect to the network when it is not visible in the list of networks (because it is hidden and not broadcasting its name).
 
5. Configure the **Security Settings** for the selected platform. The available settings depend on the security types you select, and are described in [Security settings](#security-settings).

6. (iOS and MAC OS X only) Configure **Proxy Settings**

    |Setting name|More information|Use when:|
    |----------------|-------------------|-------------|
    |**Proxy settings for this Wi-Fi connection**|Choose the proxy settings type:<br /><br />-   **None** (default)<br />-   **Manual** -   Manually specify the URL and port number of the proxy server.<br />-   **Automatic** – Use a configuration file to configure the proxy server.|Always|
    |**Proxy server address** and **Port number**|Specify the URL and port number of the proxy server.|**Proxy settings for this Wi-Fi connection** is set to **Manual**|
    |**Proxy Server URL**|Specify the URL of the file containing the proxy server settings.|**Proxy settings for this Wi-Fi connection** is set to **Automatic**|

7.  Save the Wi-Fi profile

The new policy is displayed in the **Configuration Policies** node of the **Policy** workspace. See **Next steps** for information about deploying the profile.

## Export or Import a Wi-Fi configuration profile for Windows devices
 
For devices that run Windows 8.1 or Windows 10 desktop or mobile, you can import a Wi-Fi configuration profile that was previously exported to a file. 

### Export a Wi-Fi profile
In Windows, you can use the **netsh wlan** utility to export an existing Wi-Fi profile to an XML file readable by Intune. On a Windows computer that already has the required WiFi profile installed, follow this following procedure.

1.  Create a local folder for the exported W-Fi- profiles, such as c:\WiFi

2.  Open up a Command Prompt as an Administrator.

3.  Run the command `netsh wlan show profiles`, and note the name of the profile you'd like to export.  In this example, the profile name is *WiFiName*.

4.  Run this command: `netsh wlan export profile name="ProfileName" folder=c:\Wifi`.This will create a Wi-Fi profile file named “Wi-Fi-WiFiName.xml in your target folder ”.

### Import a Wi-Fi profile
Use the **Windows Wi-Fi Import Policy** to import a set of Wi-Fi settings that you can then deploy to the required user or device groups.


1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), click **Policy** &gt; **Add Policy**.

2.  Configure a policy of the type **Windows** &gt; **Wi-Fi Import (Windows 8.1 and later)**.

    This policy can be applied to Windows 8.1 and Windows 10 desktop and mobile devices.

	You can only create and deploy a *custom* Windows Wi-Fi import policy. Recommended settings are not available.

3.  Specify the following general values for the Windows Wi-Fi Import Policy:

    |Setting name|More information|
    |----------------|--------------------|
    |**Name**|Enter a unique name for the Wi-Fi profile to identify it in the Intune console.|
    |**Description**|Provide a description w of the Wi-Fi profile and other relevant information that helps you to locate it.|

4.  Specify the following values under the **Custom Wi-Fi Profile** heading:

    |Setting name|More information|
    |----------------|--------------------|
    |**Configuration profile file**|Click **Import** to select the XML file containing the Wi-Fi profile settings that you want to import into Intune.|
    |**Custom configuration profile name (displayed to users)**|Displays the name of the Wi-Fi configuration profile as it will be shown to users on their device.|
    |**Configuration profile details**|Displays the XML code for the configuration profile you selected.|

5.  When you are finished, click **Save Policy**.

6.  The new policy displays in the **Configuration Policies** node of the **Policy** workspace.

## Deploy the profile

A profile is a type of policy, so use the Policy workspace to deploy it.

1.  In the **Policy** workspace, select the policy you want to deploy, then click **Manage Deployment**.

2.  In the **Manage Deployment** dialog box:

    -   **To deploy the policy** - Select one or more groups to which you want to deploy the policy, then click **Add** &gt; **OK**.

    -   **To close the dialog box without deploying it** - Click **Cancel**.


A status summary and alerts on the **Overview** page of the **Policy** workspace identify issues with the policy that require your attention. Additionally, a status summary appears in the Dashboard workspace.

## Security settings
These tables have the details for the security settings that are available for Android, iOS, and Mac OS X Wi-Fi profiles. 

### Security settings for Android devices

  |Setting name|More information|Use when:|
|----------------|--------------------|-------------|
|**Security type**|Select the security protocol for the wireless network:<br /><br />-   **WPA-Enterprise/WPA2-Enterprise**<br />-   **No authentication (Open)** if the network is unsecured.|Always|
|**EAP Type**|Choose the Extensible Authentication Protocol (EAP) type used to authenticate secured wireless connections:<br /><br />-   **EAP-TLS**<br />-   **PEAP**<br />-   **EAP-TTLS**|You selected the **WPA-Enterprise/WPA2-Enterprise** security type.|
|**Select root certificates for server validation**|Click **Select**, then choose the trusted root certificate profile used to authenticate the connection. **Important:** To create the trusted root certificate profile, see [Secure resource access with certificate profiles](secure-resource-access-with-certificate-profiles.md).|Any **EAP Type** is selected.|
|**Authentication method**|Select the authentication method for the connection:<br /><br />-   **Certificates** to specify the client certificate<br />-   **Username and Password** to specify a different method for authentication|The **EAP type** is **PEAP** or **EAP-TTLS**.|
|**Select a non-EAP method for authentication (Inner identity)**|Select how you will authenticate the connection:<br /><br />-   **None**<br />-   **Unencrypted password (PAP)**<br />-   **Challenge Handshake Authentication Protocol (CHAP)**<br />-   **Microsoft CHAP (MS-CHAP)**<br />-   **Microsoft CHAP Version 2 (MS-CHAP v2)**<br /><br />The available options depend on the EAP type you selected.|The **Authentication method** is **Username and Password**.|
|**Enable identity privacy (Outer Identity)**|Specify the text sent in response to an EAP identity request. This text can be any value. During authentication, this anonymous identity is initially sent, and then followed by the real identification sent in a secure tunnel.|The **EAP type** is **PEAP** or **EAP-TTLS**.|
|**Select a client certificate for client authentication (Identity Certificate)**|Click **Select**, then choose the SCEP certificate profile used to authenticate the connection. **Important:** To create a SCEP certificate profile, see [Secure resource access with certificate profiles](secure-resource-access-with-certificate-profiles.md).|The security type is **WPA-Enterprise/WPA2-Enterprise**, and any **EAP type** is selected.|

### Security settings for iOS and Mac OS X devices

  |Setting name|More information|Use when:|
|----------------|--------------------|-------------|
|**Security type**|Select the wireless network security protocol:<br /><br />-   **WPA-Personal/WPA2-Personal**<br />-   **WPA-Enterprise/WPA2-Enterprise**<br />-   **WEP**<br />-   **No authentication (Open)** if the network is unsecured.|Always|
|**EAP Type**|Choose the Extensible Authentication Protocol (EAP) type used to authenticate secured wireless connections:<br /><br />-   **EAP-TLS**<br />-   **PEAP**<br />-   **EAP-TLS**<br />-   **EAP-AST**<br />-   **LEAP**<br />-   **EAP-SIM**|You selected a security type of **WPA-Enterprise/WPA2-Enterprise**.|
|**Trusted server certificate names**|Select the trusted root certificate profile used to authenticate the connection. **Important:** To create the trusted root certificate profile, see [Secure resource access with certificate profiles](secure-resource-access-with-certificate-profiles.md).|You selected an EAP type of **EAP-TLS**, **PEAP**, **EAP-TTLS** or **EAP-FAST**.|
|**Use Protected Access Credential (PAC)**|Select to use protected access credentials to establish an authenticated tunnel between the client and the authentication server. An existing PAC file is used if present.|The **EAP-type** is **EAP-FAST**.|
|**Provision PAC**|Provisions the PAC file to your devices.<br /><br />When used, you can also select **Provision PAC Anonymously** to ensure that the PAC file is provisioned without authenticating the server.|**Use Protected Access Credential (PAC)** is selected.|
|**Authentication method**|Select the authentication method used for the connection:<br /><br /><ul><li>**Certificates** to specify the client certificate</li><li>**Username and Password** to specify one of the following non-EAP methods for authentication (also known as Inner identity):<br /><br /><ul><li>**None**</li><li>**Unencrypted password (PAP)**</li><li>**Challenge Handshake Authentication Protocol (CHAP)**</li><li>**Microsoft CHAP (MS-CHAP)**</li><li>**Microsoft CHAP Version 2 (MS-CHAP v2)**</li><li>**EAP-TLS**</li></ul></li></ul>|The **EAP type** is **PEAP**, or **EAP-TTLS**.|
|**Select a client certificate for client authentication (Identity Certificate)**|Select the SCEP certificate profile used to authenticate the connection. **Important:** To create a SCEP certificate profile, see [Secure resource access with certificate profiles](secure-resource-access-with-certificate-profiles.md).|When the security type is **WPA-Enterprise/WPA2-Enterprise** and the **EAP type** is **EAP-TLS**, **PEAP** or **EAP-TTLS**.|
|**Enable identity privacy (Outer Identity)**|Specify text that sent in response to an EAP identity request. This text can be any value.<br /><br />During authentication, this anonymous identity is initially sent, followed by the real identification sent in a secure tunnel.|When the **EAP type** is set to **PEAP**, **EAP-TTLS** or **EAP-FAST**.|


### See also
Learn how to create a Wi-Fi profile with a pre-shared key in [Pre-shared key Wi-Fi profile](pre-shared-key-wi-fi-profile.md)
