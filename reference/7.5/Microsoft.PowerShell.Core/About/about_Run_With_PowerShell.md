---
description: Explains how to use the Run with PowerShell feature to run a script from a file system drive.
Locale: en-US
ms.date: 07/29/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_run_with_powershell?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Run_With_PowerShell
---

# about_Run_With_PowerShell

## Short description

Explains how to use the **Run with PowerShell** feature to run a script from a
file system drive.

## Long description

Beginning in Windows PowerShell 3.0, you can use the **Run with PowerShell**
feature to run scripts from File Explorer. PowerShell 7 adds the **Run with
PowerShell 7** feature that allows you to run scripts specifically with
PowerShell 7.

The **Run with PowerShell** feature is intended to run scripts that don't have
parameters, don't return output to console, and don't prompt for user input.

When you use the **Run with PowerShell** feature, the PowerShell console window
appears only briefly, if at all.

To use the **Run with PowerShell** feature:

In File Explorer on Windows, right-click the script filename and then select
**Run with PowerShell** or **Run with PowerShell 7**. Either selection starts a
new PowerShell session, runs the script, and closes the session when the script
exits.

- When you select **Run with PowerShell 7**, the script is invoked using the
  following command:

  ```
  C:\Program Files\PowerShell\7\pwsh.exe -Command "$host.UI.RawUI.WindowTitle = 'PowerShell 7 (x64)'; & '%1'"
  ```

- When you select **Run with PowerShell**, the script is invoked using the
  following command:

  ```
  C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -file "%1"
  ```

Your ability to run scripts is subject to the configured execution policy. For
more information, see [about_Execution_Policies][01].

> [!NOTE]
> There is a known issue with this feature for PowerShell 7 on Windows 11. Due
> to a change in the context menus on Windows 11, the **Run with PowerShell 7**
> menu item does not appear. This issue is being investigated.

## See also

- [about_Execution_Policies][01]
- [about_Group_Policy_Settings][02]
- [about_Scripts][03]

<!-- link references -->
[01]: about_Execution_Policies.md
[02]: about_Group_Policy_Settings.md
[03]: about_Scripts.md
