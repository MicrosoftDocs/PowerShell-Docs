---
ms.date:  01/02/2020
title:  How to Create a PowerShell Tab in Windows PowerShell ISE
description: Tabs in the Windows PowerShell Integrated Scripting Environment (ISE) allow you to simultaneously create and use several execution environments within the same application. Each PowerShell tab corresponds to a separate execution environment or session.
---

# How to Create a PowerShell Tab in Windows PowerShell ISE

Tabs in the Windows PowerShell Integrated Scripting Environment (ISE) allow you to simultaneously
create and use several execution environments within the same application. Each PowerShell tab
corresponds to a separate execution environment or session.

> [!NOTE]
> Variables, functions, and aliases that you create in one tab do not carry over to another. They
> are different Windows PowerShell sessions.

Use the following steps to open or close a tab in Windows PowerShell. To rename a tab, set the [DisplayName](object-model/The-PowerShellTab-Object.md#displayname)
property on the Windows PowerShell Tab scripting object.

## To create and use a new PowerShell Tab

On the **File** menu, click **New PowerShell Tab**. The new PowerShell tab always opens as the
active window. PowerShell tabs are incrementally numbered in the order that they are opened. Each
tab is associated with its own Windows PowerShell console window. You can have up to 32 PowerShell
tabs with their own session open at a time (this is limited to 8 on Windows PowerShell ISE 2.0.)

Note that clicking the **New** or **Open** icons on the toolbar does not create a new tab with a
separate session. Instead, those buttons open a new or existing script file on the currently active
tab with a session. You can have multiple script files open with each tab and session. The script
tabs for a session only appear below the session tabs when the associated session is active.

To make a PowerShell tab active, click the tab. To select from all PowerShell tabs that are open, on
the **View** menu, click the PowerShell tab you want to use.

## To create and use a new Remote PowerShell tab

On the **File** menu, click **New Remote PowerShell Tab** to establish a session on a remote
computer. A dialog box appears and prompts you to enter details required to establish the remote
connection. The remote tab functions just like a local PowerShell tab, but the commands and scripts
are run on the remote computer.

## To close a PowerShell Tab

To close a tab, you can use any of the following techniques:

- Click the tab that you want to close.

- On the **File** menu, click **Close PowerShell Tab**, or click the Close button (**X**) on an
  active tab to close the tab.

If you have unsaved files open in the PowerShell tab that you are closing, you are prompted to save
or discard them. For more information about how to save a script, see [How to Save a Script](How-to-Write-and-Run-Scripts-in-the-Windows-PowerShell-ISE.md#how-to-save-a-script).

## See Also

- [Introducing the Windows PowerShell ISE](Introducing-the-Windows-PowerShell-ISE.md)
- [How to Use the Console Pane in the Windows PowerShell ISE](How-to-Use-the-Console-Pane-in-the-Windows-PowerShell-ISE.md)
