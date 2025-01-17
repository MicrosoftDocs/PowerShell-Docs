---
description: Explains how to use the Run with PowerShell feature to run a script from a file system drive.
Locale: en-US
ms.date: 03/06/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_run_with_powershell?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Run_With_PowerShell
---

# about_Run_With_PowerShell

## Short description

Explains how to use the **Run with PowerShell** feature to run a script from a
file system drive.

## Long description

Beginning in Windows PowerShell 3.0, you can use the **Run with PowerShell**
feature to run scripts from File Explorer. The **Run with PowerShell** feature
is intended to run scripts that don't have required parameters, don't return
output to console, and don't prompt for user input. When you use the **Run with
PowerShell** feature, the PowerShell console window appears only briefly, if at
all.

To use the **Run with PowerShell** feature:

In File Explorer (or Windows Explorer), right-click the script filename and
then select **Run with PowerShell**.

The **Run with PowerShell** feature starts a Windows PowerShell session that has
an execution policy of Bypass, runs the script, and closes the session.

It runs a command that has the following format:

```
pwsh.exe -File <FileName> -ExecutionPolicy Bypass
```

**Run with PowerShell** sets the Bypass execution policy only for the session
(the current instance of the PowerShell process) in which the script runs.
This feature doesn't change the execution policy for the computer or the
user.

The **Run with PowerShell** feature is affected only by the AllSigned execution
policy. If the AllSigned execution policy is effective for the computer or the
user, **Run with PowerShell** runs only signed scripts. **Run with PowerShell**
is not affected by any other execution policy. For more information, see
[about_Execution_Policies][01].

> [!NOTE]
> **Run with PowerShell** feature might prompt you to confirm the execution
> policy change.

## See also

- [about_Execution_Policies][01]
- [about_Group_Policy_Settings][02]
- [about_Scripts][03]

<!-- link references -->
[01]: about_Execution_Policies.md
[02]: about_Group_Policy_Settings.md
[03]: about_Scripts.md
