---
title: How to Create a PowerShell Tab in Windows PowerShell ISE
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c10c18c7-9ece-4fd0-83dc-a19c53d4fd83
---
# How to Create a PowerShell Tab in Windows PowerShell ISE
Tabs in the [!INCLUDE[ise_1](../Token/ise_1_md.md)] allow you to simultaneously create and use several execution environments within the same application. Each PowerShell tab corresponds to a separate execution environment or session.

> [!NOTE]
> Variables, functions, and aliases that you create in one tab do not carry over to another. They are different Windows PowerShell sessions.

Use the following steps to open or close a tab in [!INCLUDE[wps_2](../Token/wps_2_md.md)]. To rename a tab, set the [DisplayName](https://technet.microsoft.com/en-us/library/a9b58556-951b-4f48-b3ae-b351b7564360#Displayname) property on the [!INCLUDE[wps_2](../Token/wps_2_md.md)] Tab scripting object.

## To create and use a new PowerShell Tab
On the **File** menu, click **New PowerShell Tab**. The new PowerShell tab always opens as the active window. PowerShell tabs are incrementally numbered in the order that they are opened. Each tab is associated with its own Windows PowerShell console window. You can have up to 32 PowerShell tabs with their own session open at a time (this is limited to 8 on [!INCLUDE[ise_2](../Token/ise_2_md.md)] 2.0.)

Note that clicking the **New** or **Open** icons on the toolbar does not create a new tab with a separate session.  Instead, those buttons open a new or existing script file on the currently active tab with a session. You can have multiple script files open with each tab and session. The script tabs for a session only appear below the session tabs when the associated session is active.

To make a PowerShell tab active, click the tab. To select from all PowerShell tabs that are open, on the **View** menu, click the PowerShell tab you want to use.

## To create and use a new Remote PowerShell tab
On the **File** menu, click **New Remote PowerShell Tab** to establish a session on a remote computer. A dialog box appears and prompts you to enter details required to establish the remote connection. The remote tab functions just like a local PowerShell tab, but the commands and scripts are run on the remote computer.

## To close a PowerShell Tab
To close a tab, you can use any of the following techniques:

-   Click the tab that you want to close.

-   On the **File** menu, click **Close PowerShell Tab**, or click  the Close button  (**X**) on an active tab to close the tab.

If you have unsaved files open in the PowerShell tab that you are closing, you are prompted to save or discard them. For more information about how to save a script, see [How to Save a Script](https://technet.microsoft.com/en-us/library/162f594d-efd3-4234-9960-45e56e6eadc8).

## See Also
[Using the Windows PowerShell ISE](../Topic/Using-the-Windows-PowerShell-ISE.md)
[How to Use the Console Pane in the Windows PowerShell ISE](../Topic/How-to-Use-the-Console-Pane-in-the-Windows-PowerShell-ISE.md)

