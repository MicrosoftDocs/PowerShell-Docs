---
# required metadata

title: Windows 10 policy settings | Microsoft Intune
description: Use the policy settings listed in this topic to help you configure built-in and custom settings for enrolled Windows 10 desktop, and Windows 10 Mobile devices.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/31/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 00a602d9-b339-4fd8-ab70-defbf6686855

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: heenamac
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Intune policy settings for Windows 10 devices in Microsoft Intune

This topic contains information to help you to understand the Intune policy settings you can use to manage Windows 10 devices. Read this topic alongside the procedures in [Manage settings and features on your-devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies) to configure built-in and custom settings for enrolled Windows 10 desktop, and Windows 10 Mobile devices. You cannot use these policies with PCs that run the [Intune PC client software](/intune/get-started/windows-pc-management-capabilities-in-microsoft-intune).

You can choose from two policy types:

- **Custom policy** - Use the Microsoft Intune **custom policy** for Windows 10 and Windows 10 Mobile to deploy OMA-URI (Open Mobile Alliance Uniform Resource Identifier) settings that can be used to control features on devices. Windows 10 makes many settings available through the [Policy Configuration Service Provider (Policy CSP)](https://technet.microsoft.com/itpro/windows/manage/how-it-pros-can-use-configuration-service-providers).
- **General configuration policy** - Use this policy type when you want to select settings from the built-in list supplied with Microsoft Intune.

## Custom policy settings

Supply the following settings in a custom policy:

## &nbsp;&nbsp;&nbsp;General

Enter a name and optionally, a description for this policy to help you identify it in the Intune console.

## &nbsp;&nbsp;&nbsp;OMA-URI settings

For each OMA-URI setting you want to add, enter the following information. Use the [Windows 10 URI settings reference](/intune/deploy-use/windows-10-policy-settings-in-microsoft-intune#Windows-10-URI-settings) in this topic to learn about the settings you can use: 

- **Setting name** - Enter a unique name for the OMA-URI setting to help you identify it in the list of settings.
- **Setting description** - Optionally, enter a description for the setting.
- **Data type** - Choose from:
	- **String**
	- **String (XML)**
	- **Date and time**
	- **Integer**
	- **Floating point**
	- **Boolean**
- **OMA-URI (case sensitive)** - Specify the OMA-URI you want to supply a setting for.
- **Value** - Specify the value to associate with the OMA-URI you entered.

### Example
In the screenshot below, the setting **Conectivity/AllowVPNOverCellular** has been enabled. This lets a Windows 10 device open a VPN connection when on a cellular network.

> ![Example of a custom policy containing VPN settings](./media/custom-policy-example.png)

## Windows 10 URI settings
Use this section to learn about the OMA-URI settings you can configure with a **Windows 10 Custom Policy**.

## &nbsp;&nbsp;&nbsp;Policy

|Policy name and URI|Details|
|---------------|------------|-----------|
|**​Allow Auto Update**<br>./Vendor/MSFT/Policy/Config/Update/AllowAutoUpdate|Desktop only<br>**Data type:** Integer<br />**Values:** **0** - **5** (default: **1**)|
|**Schedule Install Day**<br>./Vendor/MSFT/Policy/Config/Update/ScheduledInstallDay|Mobile only<br>**Data type:** Integer<br />**Values:**<br>**0** - Every day (default)<br>**1** - Sunday<br>**2** - Monday<br>**3** - Tuesday<br>**4** - Wednesday<br>**5** - Thursday<br>**6** - Friday<br>**7** - Saturday|
|**Schedule Install Time**<br>./Vendor/MSFT/Policy/Config/Update/ScheduledInstallTime|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – **23** hours (**0** is midnight) (default: **3**)|
|**DeviceLock/AllowIdleReturnWithoutPassword**<br>./Vendor/MSFT/Policy/Config/DeviceLock/AllowIdleReturnWithoutPassword|Mobile only<br />**Data type:** Integer<br />**Values:**<br>**0** - user cannot set the password grace period timer; value is set as “each time”<br>**1** - user can set the password grace period timer (default)|
|**WiFi/AllowWiFi**<br>./Vendor/MSFT/Policy/Config/WiFi/AllowWiFi|Mobile only<br />**Data type:** Integer<br />**Values:**<br>**0** – Do not allow **use Wi-Fi connection**.<br>**1** –**Allow use Wi-Fi connection** (default)|
|**WiFi/AllowInternetSharing**<br>./Vendor/MSFT/Policy/Config/WiFi/AllowInternetSharing|Desktop and mobile<br>**Data type:** Integer<br />**Values:** **0** – Don't allow Internet Sharing, **1** – Allow Internet Sharing (default)|
|**WiFi/AllowAutoConnectToWiFiSenseHotspots**<br>./Vendor/MSFT/Policy/Config/WiFi/AllowAutoConnectToWiFiSenseHotspots|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**WiFi/AllowManualWiFiConfiguration**<br>./Vendor/MSFT/Policy/Config/WiFi/AllowManualWiFiConfiguration|Mobile only<br />**Data type:** Integer<br />**Values:**<br>**0** – No Wi-Fi connection outside of MDM provisioned is allowed.<br>**1** – Adding new network SSIDs beyond the already MDM provisioned ones is allowed (default)|
|**System/AllowLocation**<br>./Vendor/MSFT/Policy/Config/System/AllowLocation|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**System/AllowTelemetry**<br>./Vendor/MSFT/Policy/Config/System/AllowTelemetry|Desktop and mobile<br>**Data type:** Integer<br />**Values:**<br>**0** – Not allowed (Enterprise only setting)<br>**1** – Limited<br>**2** – Full (default)<br>**3** - Full and  diagnostics information|
|**System/AllowExperimentation**<br>./Vendor/MSFT/Policy/Config/System/AllowExperimentation|Desktop and mobile<br />**Data type:** Integer<br />**Values:**<br>**0** – Not allowed<br>**1**- Settings only (default)<br>**2**- Settings and experimentation|
|**Security/AntiTheftMode**<br>./Vendor/MSFT/Policy/Config/Security/AntiTheftMode|Mobile only<br />**Data type:** Integer<br />**Values:**<br>**0** - don't allow Anti Theft mode<br>**1** User preference (default)|
|**Connectivity/AllowUSBConnection**<br>./Vendor/MSFT/Policy/Config/Connectivity/AllowUSBConnection|Mobile only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**System/AllowUserToResetPhone**<br>./Vendor/MSFT/Policy/Config/System/AllowUserToResetPhone|Mobile only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Connectivity/AllowCellularDataRoaming**<br>./Vendor/MSFT/Policy/Config/Connectivity/AllowCellularDataRoaming|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Connectivity/AllowVPNOverCellular**<br>./Vendor/MSFT/Policy/Config/Connectivity/AllowVPNOverCellular|Desktop and mobile<br />**Data type:** Integer<br />**Values:**<br>**0** - VPN is not allowed over cellular<br>**1** – VPN could use any connection including cellular (default)|
|**Connectivity/AllowVPNRoamingOverCellular**<br>./Vendor/MSFT/Policy/Config/Connectivity/AllowVPNRoamingOverCellular|Mobile only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Connectivity/AllowVPNRoamingOverCellular**<br>./Vendor/MSFT/Policy/Config/Connectivity/AllowVPNRoamingOverCellular|Mobile only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Connectivity/AllowBluetooth**<br>./Vendor/MSFT/Policy/Config/Connectivity/AllowBluetooth|Desktop and mobile<br />**Data type:** Integer<br />**Values:**<br>**0** – Don’t allow the user to turn Bluetooth on.<br>**1** – Reserved. The user can turn on and configure Bluetooth (not supported in Windows Phone 8.1 for MDM, EAS, Windows 10 desktop or Windows 10 Mobile)<br>**2** - Allowed. The user can turn on and configure Bluetooth (default)|
|**Experience/AllowScreenCapture**<br>./Vendor/MSFT/Policy/Config/Experience/AllowScreenCapture|Mobile only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Experience/AllowTaskSwitcher**<br>./Vendor/MSFT/Policy/Config/Experience/AllowTaskSwitcher|Mobile only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Experience/AllowVoiceRecording**<br>./Vendor/MSFT/Policy/Config/Experience/AllowVoiceRecording|Mobile only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Experience/AllowSyncMySettings**<br>./Vendor/MSFT/Policy/Config/Experience/AllowSyncMySettings|Mobile only<br />**Data type:** Integer<br />**Values:** **0** – Don’t allow roaming, **1** – Allow roaming (default)|
|**Experience/AllowManualMDMUnenrollment**<br>./Vendor/MSFT/Policy/Config/Experience/AllowManualMDMUnenrollment|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Accounts/AllowMicrosoftAccountConnection**<br>./Vendor/MSFT/Policy/Config/Accounts/AllowMicrosoftAccountConnection|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Accounts/AllowAddingNonMicrosoftAccountsManually**<br>./Vendor/MSFT/Policy/Config/Accounts/AllowAddingNonMicrosoftAccountsManually|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Security/AllowManualRootCertificateInstallation**<br>./Vendor/MSFT/Policy/Config/Security/AllowManualRootCertificateInstallation|Mobile only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Security/AllowAddProvisioningPackages**<br>./Vendor/MSFT/Policy/Config/Security/AllowAddProvisioningPackages|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Search/DisableBackoff**<br>./Vendor/MSFT/Policy/Config/Search/DisableBackoff|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** (default), **1**|
|**Search/PreventRemoteQueries**<br>./Vendor/MSFT/Policy/Config/Search/PreventRemoteQueries|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0**, **1** (default)|
|**Search/AllowUsingDiacritics**<br>./Vendor/MSFT/Policy/Config/Search/AllowUsingDiacritics|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** (default), **1**|
|**Search/AlwaysUseAutoLangDetection**<br>./Vendor/MSFT/Policy/Config/Search/AlwaysUseAutoLangDetection|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** (default), **1**|
|**Search/DisableRemovableDriveIndexing**<br>./Vendor/MSFT/Policy/Config/Search/DisableRemovableDriveIndexing|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** (default), **1**|
|**Search/PreventIndexingLowDiskSpaceMB**<br>./Vendor/MSFT/Policy/Config/Search/PreventIndexingLowDiskSpaceMB|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0**, **1** (default)|
|**Search/AllowIndexingEncryptedStoresOrItems**<br>./Vendor/MSFT/Policy/Config/Search/AllowIndexingEncryptedStoresOrItems|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** (default), **1**|
|**Security/AllowRemoveProvisioningPackage**<br>./Vendor/MSFT/Policy/Config/Security/AllowRemoveProvisioningPackage|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Security/RequireProvisioningPackageSignature**<br>./Vendor/MSFT/Policy/Config/Security/RequireProvisioningPackageSignature|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** (default), **1**|
|**AboveLock/AllowActionCenterNotifications**<br>./Vendor/MSFT/Policy/Config/AboveLock/AllowActionCenterNotifications|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**TextInput/AllowIMENetworkAccess**<br>./Vendor/MSFT/Policy/Config/TextInput/AllowIMENetworkAccess|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** – Don’t allow<br>Open Extended Dictionary is turned off.<br>A user cannot:<br>-Add a new Open Extended Dictionary<br />-Add a new search integration configuration file<br>-Use the cloud candidate feature<br>-Send user registered word.<br>**1** - Allow<br>Open Extended Dictionary can be added and used by default. Also, the search integration function can be used by default.<br>A user can:<br>Use the cloud candidate feature.|
|**TextInput/AllowIMELogging**<br>./Vendor/MSFT/Policy/Config/TextInput/AllowIMELogging|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** - Misconversion logging off.<br>**1** - Misconversion logging on (default)|
|**TextInput/AllowJapaneseNonPublishingStandardGlyph**<br>./Vendor/MSFT/Policy/Config/TextInput/AllowJapaneseNonPublishingStandardGlyph|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**TextInput/AllowJapaneseIVSCharacters**<br>./Vendor/MSFT/Policy/Config/TextInput/AllowJapaneseIVSCharacters|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**TextInput/AllowJapaneseUserDictionary**<br>./Vendor/MSFT/Policy/Config/TextInput/AllowJapaneseUserDictionary|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed **1** – allowed (default)|
|**TextInput/AllowJapaneseIMESurrogatePairCharacters**<br>./Vendor/MSFT/Policy/Config/TextInput/AllowJapaneseIMESurrogatePairCharacters|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**TextInput/ExcludeJapaneseIMEExceptShiftJIS**<br>./Vendor/MSFT/Policy/Config/TextInput/ExcludeJapaneseIMEExceptShiftJIS|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** - No characters are filtered (default)<br>**1** - All Except Shift JIS characters are filtered|
|**TextInput/ExcludeJapaneseIMEExceptJIS0208**<br>./Vendor/MSFT/Policy/Config/TextInput/ExcludeJapaneseIMEExceptJIS0208|Desktop only<br />**Data type:** Integer<br />**Values:**<br />**0** - No characters are filtered (default)<br>**1** - All except JIS0208 characters are filtered|
|**TextInput/ExcludeJapaneseIMEExceptJIS0208andEUDC**<br>./Vendor/MSFT/Policy/Config/TextInput/ExcludeJapaneseIMEExceptJIS0208andEUDC|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** - No characters are filtered (default)<br>**1** - All except JIS0208 characters or EUDC characters are filtered|
|**TextInput/AllowInputPanel**<br>./Vendor/MSFT/Policy/Config/TextInput/AllowInputPanel|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Bluetooth/AllowDiscoverableMode**<br>./Vendor/MSFT/Policy/Config/Bluetooth/AllowDiscoverableMode|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Bluetooth/AllowAdvertising**<br>./Vendor/MSFT/Policy/Config/Bluetooth/AllowAdvertising|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowDataSense**<br>./Vendor/MSFT/Policy/Config/Settings/AllowDataSense|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowVPN**<br>./Vendor/MSFT/Policy/Config/Settings/AllowVPN|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowWorkplace**<br>./Vendor/MSFT/Policy/Config/Settings/AllowWorkplace|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowDateTime**<br>./Vendor/MSFT/Policy/Config/Settings/AllowDateTime|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowLanguage**<br>./Vendor/MSFT/Policy/Config/Settings/AllowLanguage|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowRegion**<br>./Vendor/MSFT/Policy/Config/Settings/AllowRegion|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowSignInOptions**<br>./Vendor/MSFT/Policy/Config/Settings/AllowSignInOptions|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowYourAccount**<br>./Vendor/MSFT/Policy/Config/Settings/AllowYourAccount|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowPowerSleep**<br>./Vendor/MSFT/Policy/Config/Settings/AllowPowerSleep|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Settings/AllowAutoPlay**<br>./Vendor/MSFT/Policy/Config/Settings/AllowAutoPlay|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Experience/AllowCortana**<br>./Vendor/MSFT/Policy/Config/Experience/AllowCortana|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Search/SafeSearchPermissions**<br>./Vendor/MSFT/Policy/Config/Search/SafeSearchPermissions|Mobile only<br />**Data type:** Integer<br />**Values:**<br>**0** – Strict, highest filtering against adult content<br>**1** – Moderate, moderate filtering against adult content (valid search results will not be filtered - default)|
|**Experience/AllowCopyPaste**<br>./Vendor/MSFT/Policy/Config/Experience/AllowCopyPaste|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**Force Start Size**<br>./Vendor/MSFT/Policy/Config/Start/ForceStartSize|Mobile only<br />**Data type:** Integer<br />**Values:**<br>**0** - allow user change size (default)<br>**1** - force non-full screen<br>**2** - force full screen|
|**Update/RequireDeferUpgrade**<br>./Vendor/MSFT/Policy/Config/Update/RequireDeferUpgrade|Desktop and mobile<br />**Data type:** Integer<br />**Values:**<br>**0**: do not defer upgrade (stay in current branch, CB - default)<br>**1**: Enable updates and upgrades to be deferred (Device follows current branch for business, CBB, rules)<br />For details, see:<br>[Introduction to Windows 10 servicing](https://technet.microsoft.com/library/mt598226.aspx)<br>[Plan for Windows 10 deployment](https://technet.microsoft.com/library/mt574241.aspx)|
|**Update/DeferUpdatePeriod**<br>./Vendor/MSFT/Policy/Config/Update/DeferUpdatePeriod|Desktop and mobile<br>**Description:** Policy to defer software updates for up to 4 weeks<br />**Data type:** Integer<br />**Values:**<br> **0**: Apply updates immediately (default)<br>**1**-**4**: number of weeks to defer software updates.<br />For details, see:<br>[Introduction to Windows 10 servicing](https://technet.microsoft.com/library/mt598226.aspx)<br>[Plan for Windows 10 deployment](https://technet.microsoft.com/library/mt574241.aspx)|
|**Update/DeferUpgradePeriod**<br>./Vendor/MSFT/Policy/Config/Update/DeferUpgradePeriod|Desktop and mobile<br>**Description:** Policy to defer feature upgrades for up to 8 months<br />**Data type:** Integer<br />**Values:**<br>**0**: Apply updates immediately (default)<br>**1**-**8**: number of months to defer feature upgrades.<br />For details, see:<br>[Introduction to Windows 10 servicing](https://technet.microsoft.com/library/mt598226.aspx)<br>[Plan for Windows 10 deployment](https://technet.microsoft.com/library/mt574241.aspx)|
|**Update/PauseDeferrals**<br>./Vendor/MSFT/Policy/Config/Update/PauseDeferrals|Desktop and mobile<br>**Description:** Allows a device to stop receiving updates and upgrades for 5 weeks.<br />**Data type:** Integer<br />**Values:**<br>**0**: Apply updates immediately (default)<br>**1**: Pause updates and upgrades (expires after 5 weeks)|

## &nbsp;&nbsp;&nbsp;Windows Defender

|Policy name and URI|Details|
|---------------|-----------|
|**AllowRealtimeMonitoring**<br>./Vendor/MSFT/Policy/Config/Defender/AllowRealtimeMonitoring|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**AllowBehaviorMonitoring**<br>./Vendor/MSFT/Policy/Config/Defender/AllowBehaviorMonitoring|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**AllowIntrusionPreventionSystem**<br>./Vendor/MSFT/Policy/Config/Defender/AllowIntrusionPreventionSystem|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**AllowIOAVProtection**<br>./Vendor/MSFT/Policy/Config/Defender/AllowIOAVProtection|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**AllowScriptScanning**<br>./Vendor/MSFT/Policy/Config/Defender/AllowScriptScanning|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**AllowOnAccessProtection**<br>./Vendor/MSFT/Policy/Config/Defender/AllowOnAccessProtection|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**RealTimeScanDirection**<br>./Vendor/MSFT/Policy/Config/Defender/RealTimeScanDirection|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** – Monitor all files (default)<br>**1** – Monitor incoming files<br>**2** – Monitor outgoing files|
|**DaysToRetainCleanedMalware**<br>./Vendor/MSFT/Policy/Config/Defender/DaysToRetainCleanedMalware|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** - **90** – Represents what how long malware will be retained<br>**Default:** **0** – keeps in the quarantine folder forever, and doesn’t automatically remove|
|**AllowUserUIAccess**<br>./Vendor/MSFT/Policy/Config/Defender/AllowUserUIAccess|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**ScanParameter**<br>./Vendor/MSFT/Policy/Config/Defender/ScanParameter|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**1** – Quick scan (default)<br>**2** - Full scan|
|**ScheduleScanDay**<br>./Vendor/MSFT/Policy/Config/Defender/ScheduleScanDay|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** - Everyday (default)<br>**1** - Monday<br>**2** - Tuesday<br>**3** - Wednesday<br>**4** - Thursday<br>**5** - Friday<br>**6** - Saturday<br>**7** - Sunday<br>**8** – No scheduled scan|
|**ScheduleScanTime**<br>./Vendor/MSFT/Policy/Config/Defender/ScheduleScanTime|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** - 12:00 am<br>**60** – 1:00 am<br>**120** – 2:00 am (default)<br>**180** – 3:00 am<br>**240** – 4:00 am<br>**300** – 5:00 am<br>**360** – 6:00 am<br>**420** – 7:00 am<br>**480** – 8:00 am<br>**540** – 9:00 am<br>**600** – 10:00 am<br>**660** – 11:00 am<br>**720** – 12:00 pm<br>**780** – 1:00 pm<br>**840** – 2:00 pm<br>**900** – 3:00 pm<br>**960** – 4:00 pm<br>**1020** – 5:00 pm<br>**1080** – 6:00 pm<br>**1140** – 7:00 pm<br>**1200** – 8:00 pm<br>**1260** – 9:00 pm<br>**1320** – 10:00 pm<br>**1381** – Maintenance window|
|**ScheduleQuickScanTime**<br>./Vendor/MSFT/Policy/Config/Defender/ScheduleQuickScanTime|Desktop only<br>**Data type:** Integer<br />**Values:**<br>**0** - 12:00 am<br>**60** – 1:00 am<br>**120** – 2:00 am (default)<br>**180** – 3:00 am<br>**240** – 4:00 am<br>**300** – 5:00 am<br>**360** – 6:00 am<br>**420** – 7:00 am<br>**480** – 8:00 am<br>**540** – 9:00 am<br>**600** – 10:00 am<br>**660** – 11:00 am<br>**720** – 12:00 pm<br>**780** – 1:00 pm<br>**840** – 2:00 pm<br>**900** – 3:00 pm<br>**960** – 4:00 pm<br>**1020** – 5:00 pm<br>**1080** – 6:00 pm<br>**1140** – 7:00 pm<br>**1200** – 8:00 pm<br>**1260** – 9:00 pm<br>**1320** – 10:00 pm<br>**1380** – 11:00 pm|
|**AVGCPULoadFactor**<br>./Vendor/MSFT/Policy/Config/Defender/AVGCPULoadFactor|Desktop only<br />**Data type:** Integer<br />**Values:** **0** - **100** (default: **50**)|
|**AllowArchiveScanning**<br>./Vendor/MSFT/Policy/Config/Defender/AllowArchiveScanning|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**AllowEmailScanning**<br>./Vendor/MSFT/Policy/Config/Defender/AllowEmailScanning|Desktop only<br />**Data type:** Integer<br>**Values:** **0** – not allowed (default), **1** – allowed|
|**AllowFullScanRemovableDriveScanning**<br>./Vendor/MSFT/Policy/Config/Defender/AllowFullScanRemovableDriveScanning|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed (default), **1** – allowed|
|**AllowFullScanOnMappedNetworkDrives**<br>./Vendor/MSFT/Policy/Config/Defender/AllowFullScanOnMappedNetworkDrives|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**AllowScanningNetworkFiles**<br>./Vendor/MSFT/Policy/Config/Defender/AllowScanningNetworkFiles|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default) – Also runs when RTP is on if set to allowed|
|**SignatureUpdateInterval**<br>./Vendor/MSFT/Policy/Config/Defender/SignatureUpdateInterval|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** – Don't check for signatures on an interval<br>**1** - Check for signatures every hour<br>**2** – Check every 2 hours, etc.<br>**24** – Check every day<br>**Default value:** 8 – Check every 8 hours|
|**AllowCloudProtection**<br>./Vendor/MSFT/Policy/Config/Defender/AllowCloudProtection|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – not allowed, **1** – allowed (default)|
|**SubmitSamplesConsent**<br>./Vendor/MSFT/Policy/Config/Defender/SubmitSamplesConsent|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0** – Always prompt (default)<br>**1** – Send safe samples automatically<br>**2** – Never send<br>**3** – Send all samples automatically|
|**ExcludedExtensions**<br>./Vendor/MSFT/Policy/Config/Defender/ExcludedExtensions|Desktop only<br />**Data type:** String<br />**Values:**<br>*&lt;list of extensions separated by semi-colon&gt;* E.g. **obj;lib**<br>**Default:** No extensions excluded|
|**ExcludedPaths**<br>./Vendor/MSFT/Policy/Config/Defender/ExcludedPaths|Desktop only<br />**Data type:** String<br />**Values:**<br />*&lt;list of paths separated by semi-colon&gt;*<br />Example: **c:\test;c:\test1.exe**<br />**Default value:** No paths are excluded|
|**ExcludedProcesses**<br>./Vendor/MSFT/Policy/Config/Defender/ExcludedProcesses|Desktop only<br />**Data type:** String<br />**Values:**<br>*&lt;list of paths separated by semi-colon&gt;*<br>Example: **c:\test.exe;c:\test1.exe**<br>**Default value:** No processes are excluded|

## &nbsp;&nbsp;&nbsp;Edge browser

|Policy name and URI|Details|
|---------------|------------|-----------|
|**Allow Browser**<br>./Vendor/MSFT/Policy/Config/Browser/AllowBrowser|Mobile only<br />**Data type:** Integer<br />**Values:** **0**: browsing off, **1**: browsing on (default)|
|**AllowSearchSuggestionsinAddressBar**<br>./Vendor/MSFT/Policy/Config/Browser/AllowSearchSuggestionsinAddressBar|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0**: Don't show suggestions, **1**: Show suggestions (default)|
|**SendIntranetTraffictoInternetExplorer**<br>./Vendor/MSFT/Policy/Config/Browser/SendIntranetTraffictoInternetExplorer|Desktop only<br />**Data type:** Integer<br />**Values:**<br>**0**: Disabled (open intranet sites in Edge browser - default))<br>**1** - Enabled (open intranet sites in Internet Explorer).|
|**Allow Do Not Track**<br>./Vendor/MSFT/Policy/Config/Browser/AllowDoNotTrack|Desktop and mobile)<br />**Data type:** Integer<br />**Values:** **0** – Disabled (DNT not sent - default), **1** – Enabled (send DNT)|
|**Configure SmartScreen**<br>./Vendor/MSFT/Policy/Config/Browser/AllowSmartScreen|Desktop and mobile<br />**Data type:** Integer<br />**Values:** **0** – Do not allow, **1** – Allow (default)|
|**Allow Pop-ups**<br>./Vendor/MSFT/Policy/Config/Browser/AllowPopups|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – Block pop-ups (default), **1** – Allow pop-ups|
|**Allow Cookies**<br>./Vendor/MSFT/Policy/Config/Browser/AllowCookies|Desktop and mobile<br />**Data type:** Integer<br />**Values:**<br>**0** – Allow cookies from all web sites (default)<br>**1** – Block only third party cookies<br>**2** – Block all cookies|
|**Allow Save Password**<br>./Vendor/MSFT/Policy/Config/Browser/AllowPasswordManager|Desktop and mobile<br />**Data type:** Integer<br />**Values:**<br>**0** – Password manager is disabled; <br>**1** – Password manager is enabled (default)|
|**Allow Autofill**<br>./Vendor/MSFT/Policy/Config/Browser/AllowAutofill|Desktop only<br />**Data type:** Integer<br />**Values:** **0** – Disabled (default), **1** – Enabled|
|**Configure Enterprise Site List**<br>./Vendor/MSFT/Policy/Config/Browser/EnterpriseModeSiteList|Desktop only<br />**Data type:** String<br />**Values:<br>**0** – Not configured<br>**1** – Use IE’s enterprise mode site list if configured (default)<br>**2** – Specify location of the  enterprise site list|

## General configuration policy settings

Use the Microsoft Intune **general configuration policy** for Windows 10 to configure built-in settings for enrolled Windows 10 desktop, and Windows 10 Mobile devices. 

## &nbsp;&nbsp;&nbsp;Password

|Setting name|Additional information (where required)|
|----------------|----------------------|
|**Require a password to unlock devices**|-|
|**Required password type**|Specifies whether the password must be numeric only, or alphanumeric|
|**Required password type** - **Minimum number of character sets**|There are four character sets, lowercase letters, uppercase letters, numbers, and symbols. This setting specifies how many of these sets must be included in the password.|
|**Minimum password length**|Applies to Windows 10 Mobile only|
|**Number of repeated sign-in failures to allow before the device is wiped**|For devices running Windows 10: If the device has BitLocker enabled, it will be placed into BitLocker recovery mode after sign-in fails the number of times you specify. If the device is not BitLocker enabled, then this setting will not apply.<br>For devices running Windows 10 Mobile: After sign-in fails the number of times you specify, the device will be wiped.|
|**Minutes of inactivity before screen turns off**|Specifies the length of time a device must be idle before the screen is locked.|
|**Password expiration (days)**|Specifies the length of time after which the device password must be changed.|
|**Remember password history**|Specifies whether you want to restrict the end user from creating previously used passwords.|
|**Remember password history** - **Prevent reuse of previous passwords**|Specifies the number of previously used passwords remembered by the device.|
|**Require a password when the device returns from an idle state**|If enabled, the user must enter a password to unlock the device. (Windows 10 Mobile only)|

## &nbsp;&nbsp;&nbsp;Encryption

|Setting name|Additional information (where required)|
|----------------|----------------------|
|**Require encryption on mobile device**|Enable encryption on targeted devices.<br>(Windows 10 Mobile only)|

## &nbsp;&nbsp;&nbsp;System

|Setting name|Additional information (where required)|
|----------------|----------------------|
|**Allow screen capture**|Let's the user capture the device screen as an image. (Windows 10 Mobile only)|
|**Allow manual unenrollment**|Lets the user manually delete the workplace account from the device.|
|**Allow manual root certificate installation**|Applies to Windows 10 Mobile|
|**Allow diagnostic and usage data to be sent to Microsoft**|Possible values are:<br><br>**No** - No data is sent to Microsoft<br>**Basic** - Limited information is sent toto Microsoft<br>**Enhanced** - Enhanced diagnostic data   is sent to Microsoft<br>**Full (recommended)** - Sends the same data as **Enhanced**, plus additional data about the device state|


## &nbsp;&nbsp;&nbsp;Account and synchronization

|Setting name|Additional information (where required)|
|----------------|----------------------|---------------------|
|**Allow Microsoft account**|Lets the user associate a Microsoft account with the device.|
|**Allow adding non-Microsoft accounts manually**|Lets the user add email accounts to the device that are not associated with a Microsoft account.|
|**Allow settings synchronization for Microsoft accounts**|Allow device and app settings associated with a Microsoft account to synchronize between devices.|

## &nbsp;&nbsp;&nbsp;Microsoft Edge

|Setting name|Additional information (where required)|
|----------------|----------------------|
|**Allow web browser**|Allow the use of the Edge web browser on the device.<br>(Windows 10 Mobile only)|
|**Allow search suggestions in address bar**|Lets your search engine suggest sites as you type search phrases.|
|**Allow sending intranet traffic to Internet Explorer**|Lets users open intranet websites in Internet Explorer.<br>(Windows 10 desktop only)|
|**Allow do not track**|Configures the Edge browser to send do not track headers to websites that users visit.|
|**Enable SmartScreen**|-|
|**Allow active scripting**|Allows scripts, like Javascript to be run in the Edge browser.|
|**Allow pop-ups**|Applies to Windows 10 desktop only|
|**Allow cookies**|-|
|**Allow Autofill**|Allow users to change autocomplete settings in the browser.<br>(Windows 10 desktop only)|
|**Allow Password Manager**|Enable or disable the Edge Password Manager feature.|
|**Enterprise Mode site list location**|Specifies where to find the list of web sites that will open in Enterprise mode. Users cannot edit this list.<br>(Windows 10 desktop only)|

## &nbsp;&nbsp;&nbsp;Apps

|Setting name|Additional information (where required)|
|----------------|----------------------|---------------------|
|**Allow application store**|Applies to Windows 10 Mobile only|



## &nbsp;&nbsp;&nbsp;Cellular

|Setting name|Additional information (where required)|
|----------------|----------------------|---------------------|
|**Allow data roaming**|Allow roaming between networks when accessing data.|
|**Allow VPN over cellular**|Controls whether the device can access VPN connections when connected to a cellular network.|
|**Allow VPN roaming over cellular**|Controls whether the device can access VPN connections when roaming on a cellular network.|

## &nbsp;&nbsp;&nbsp;Hardware

|Setting name|Additional information (where required)|
|----------------|----------------------|
|**Allow camera**|-|
|**Allow removable storage**|Specifies whether external storage devices such as an SD card can be used with the device.|
|**Allow Wi-Fi**|Applies to Windows 10 Mobile only|
|**Allow internet sharing**|Allow the use of Internet connection sharing on the device.|
|**Allow manual Wi-Fi configuration**|Controls whether the user can configure their own Wi-Fi connections, or whether they can only use connections configured by a Wi-Fi profile.<br>(Windows 10 Mobile only)|
|**Allow automatic connection to free Wi-Fi hotspots**|Lets the device automatically connect to free Wi-Fi hotspots and automatically accept any terms and conditions for the connection.|
|**Allow geolocation**|Specifies whether the device can use location services information.|
|**Allow NFC**|Allows the device to use it's Near Field Communications capabilities.|
|**Allow Bluetooth**|-|
|**Allow Bluetooth discoverable mode**|Let's this device be discovered by other Bluetooth-enabled devices.|
|**Allow Bluetooth advertising**|Allows devices to receive advertisements over Bluetooth.|
|**Allow phone reset**|Controls whether the user can factory reset their device.|
|**Allow USB connection**|Controls whether devices can access external storage devices through a USB connection.|
|**Allow AntiTheft mode**|Configure whether Windows Antitheft mode is enabled.|

## &nbsp;&nbsp;&nbsp;Features

|Setting name|Additional information (where required)|
|----------------|----------------------|---------------------|
|**Allow copy and paste**|Applies to Windows 10 Mobile only|
|**Allow voice recording**|Applies to Windows 10 Mobile only|
|**Allow Cortana**|Enable or disable the Cortana voice assistant.|
|**Allow action center notifications**|Enable or disable action center notifications on the device lock screen.<br>(Windows 10 Mobile only)|

## &nbsp;&nbsp;&nbsp;Windows Defender

All settings are for Windows 10 desktop only.

|Setting name|Additional information (where required)|
|-|-|
|**Allow real-time monitoring**|Enables real-time scanning for malware, spyware, and other unwanted software.|
|**Allow behavior monitoring**|Lets Defender check for certain known patterns of suspicious activity on devices.|
|**Enable Network Inspection System**|The Network Inspection System (NIS) helps to protect devices against network-based exploits by using the signatures of known vulnerabilities from the Microsoft Endpoint Protection Center to help detect and block malicious traffic.|
|**Scan all downloads**|Controls whether Defender scans all files downloaded from the Internet.|
|**Allow script scanning**|Lets Defender scan scripts that are used in Internet Explorer.|
|**Monitor file and program activity**|Enable this setting to allow Defender to monitor file and program activity on devices.|
|**Days to track resolved malware**|Lets Defender continue to track resolved malware for the number of days you specify so that you can manually check previously affected devices. If you set the number of days to **0**, malware remains in the Quarantine folder and is not automatically removed. |
|**Allow client UI access**|Controls whether the Windows Defender user interface is hidden from end users.<br>When this setting is changed, it will take effect the next time the end user's PC is restarted.|
|**Schedule a daily quick scan**|Lets you schedule a quick scan that occurs daily at the time you select.|
|**Schedule a system scan**|Lets you schedule a full or quick system scan that occurs regularly on the day and time you select.|
|**Limit CPU usage during a scan**|Lets you limit the amount of CPU that scans are allowed to use (from **1** to **100**)|
|**Scan archive files**|Allows Defender to scan archived files such as Zip or Cab files.|
|**Scan email messages**|Allows Defender to scan email messages as they arrive on the device.|
|**Scan removable drives**|Lets Defender scan removable drives like USB sticks.|
|**Scan mapped network drives**|Lets Defender scan files on mapped network drive.<br>If the files on the drive are read-only, Defender will be unable to remove any malware found in them.|
|**Scan files opened from network shared folders**|Lets Defender scan files on shared network drives (for instance, those accessed from a UNC path.<br>If the files on the drive are read-only, Defender will be unable to remove any malware found in them.|
|**Signature update interval**|Specify the interval at which Defender will check for new signature files.|
|**Allow cloud protection**|Allow or block the Microsoft Active Protection Service from receiving information about malware activity from devices you manage. This information is used to improve the service in the future.|
|**Prompt users for samples submission**|Controls whether files that might require further analysis by Microsoft to determine if they are malicious are automatically sent to Microsoft.|
|**Potentially Unwanted Application Detection**|This setting can be used to protect enrolled Windows desktop devices against running software classified by Windows Defender as potentially unwanted. You can protect against these applications running, or use audit mode to report when a potentially unwanted application is installed.|
|**Files and folders to exclude when running a scan or using real-time protection**|Add one or more files and folders like **C:\Path** or **%ProgramFiles%\Path\filename.exe** to the exclusions list. These files and folders will not be included in any real-time, or scheduled scans.|
|**File extensions to exclude when running a scan or using real-time protection**|Add one or more file extensions like **jpg** or **txt** to the exclusions list. Any files with these extensions will not be included in any real-time, or scheduled scans.|
|**Processes to exclude when running a scan or using real-time protection**|Add one or more processes of the type **.exe**, **.com**, or **.scr** to the exclusions list. These processes will not be included in any real-time, or scheduled scans.| 


## &nbsp;&nbsp;&nbsp;Updates

|Setting name|Additional information (where required)|
|----------------|---------------|
|**Allow automatic updates**|Enable this setting to allow automatic updates. Then, configure one of the following settings to control update behavior:<br />**Notify download**<br />**Auto install at maintenance time**<br />**Auto install and reboot at maintenance time**<br />**Auto install and reboot at scheduled time** **Note:** When this option is selected, you can also configure the following settings:  **Suppress notification to end user** and **Define install day for scheduled updates**.<br>(Windows 10 desktop only)|
|**Allow pre-release features**|Lets Microsoft deploy pre-release settings and features to Windows 10 devices. You can select to allow settings only, or all pre-release settings and features to be installed.|

### See also
[Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md)


