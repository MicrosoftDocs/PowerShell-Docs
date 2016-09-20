---
# required metadata

title: Find a package family name (PFN) for per-app VPN | Microsoft Intune
description: Find a PFN so that you can configure a per-app VPN.
keywords:
author: nbigman
manager: angrobe
ms.date: 07/20/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 74643d1d-4fd9-4cff-ac79-1a42281d2f76

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: tycast
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Find a package family name (PFN) for per-app VPN configuration

There are two ways to find a PFN so that you can set up a per-app VPN.

## Find a PFN for an app that's installed on a Windows 10 computer

If the app that you are working with is already installed on a Windows 10 computer, you can use the [Get-AppxPackage](https://technet.microsoft.com/library/hh856044.aspx) PowerShell cmdlet to get the PFN.

The syntax for Get-AppxPackage is:

` Parameter Set: __AllParameterSets`
` Get-AppxPackage [[-Name] <String> ] [[-Publisher] <String> ] [-AllUsers] [-User <String> ] [ <CommonParameters>]`

> [!NOTE]
You may have to run PowerShell as an admin to retrieve the PFN.

For example, to get info about all the universal apps installed on the computer, use `Get-AppxPackage`.

To get info about an app when you know the name or part of the name, use `Get-AppxPackage *<app_name>`. Note the use of the wildcard character, which is particularly helpful if you're not sure of the full name of the app. For example, to get the info for OneNote, use `Get-AppxPackage *OneNote`.


Here is the information retrieved for OneNote:

`Name                   : Microsoft.Office.OneNote`

`Publisher              : CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US`

`Architecture           : X64`

`ResourceId             :`

`Version                : 17.6769.57631.0`

`PackageFullName        : Microsoft.Office.OneNote_17.6769.57631.0_x64__8wekyb3d8bbwe`

`InstallLocation        : C:\Program Files\WindowsApps`

`\Microsoft.Office.OneNote_17.6769.57631.0_x64__8wekyb3d8bbwe`

`IsFramework            : False`

**`PackageFamilyName      : Microsoft.Office.OneNote_8wekyb3d8bbwe`**

`PublisherId            : 8wekyb3d8bbwe`



## Find a PFN if the app is not installed on a computer

1.	Go to https://www.microsoft.com/en-us/store/apps.
2.	Enter the name of the app in the search bar. In our example, search for OneNote.
3.	Choose the link to the app. Note that the URL has a series of letters at the end. In our example, the URL looks like this:
`https://www.microsoft.com/en-us/store/apps/onenote/9wzdncrfhvjl`.
4.	In a different tab, paste the following URL, `https://bspmts.mp.microsoft.com/v1/public/catalog/Retail/Products/<app id>/applockerdata`. Replace `<app id>` with the app id that you got from https://www.microsoft.com/en-us/store/apps - that series of letters at the end of the URL in step 3. In our example of OneNote, you'd paste: `https://bspmts.mp.microsoft.com/v1/public/catalog/Retail/Products/9wzdncrfhvjl/applockerdata`.

Microsoft Edge shows the information that you want; in Internet Explorer, choose **Open** to see the information. The PFN value is given on the first line. Here are the results for our example:


`{`
`  "packageFamilyName": "Microsoft.Office.OneNote_8wekyb3d8bbwe",`
`  "packageIdentityName": "Microsoft.Office.OneNote",`
`  "windowsPhoneLegacyId": "ca05b3ab-f157-450c-8c49-a1f127f5e71d",`
`  "publisherCertificateName": "CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US"`
`}`
