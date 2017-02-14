---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  about_Run_With_PowerShell
ms.technology:  powershell
---

# About Run With PowerShell
## about_Run_With_PowerShell


# SHORT DESCRIPTION

Explains how to use the "Run with PowerShell" feature to run
a script from a file system drive.

# LONG DESCRIPTION

Beginning in Windows PowerShell 3.0, you can use the "Run with
PowerShell" feature to run scripts from File Explorer in Windows 8
and Windows Server 2012 and from Windows Explorer in earlier
versions of Windows.

The "Run with PowerShell" feature is designed to run scripts
that do not have required parameters and do not return output
to the command prompt.

When you use the "Run with PowerShell" feature, the Windows
PowerShell console window appears only briefly, if at all.
You cannot interact with it.

To use the "Run with PowerShell" feature:

In File Explorer (or Windows Explorer), right-click the
script file name and then select "Run with PowerShell".

The "Run with PowerShell" feature starts a Windows PowerShell
session that has an execution policy of Bypass, runs the
script, and closes the session.

It runs a command that has the following format:
PowerShell.exe -File <FileName> -ExecutionPolicy Bypass

"Run with PowerShell" sets the Bypass execution policy only
for the session (the current instance of the PowerShell process)
in which the script runs. This feature does not change the execution
policy for the computer or the user.

The "Run with PowerShell" feature is affected only by the AllSigned
execution policy. If the AllSigned execution policy is effective for
the computer or the user, "Run with PowerShell" runs only signed
scripts. "Run with PowerShell" is not affected by any other execution
policy. For more information, see about_Execution_Policies.

Troubleshooting Note: Run with PowerShell command might prompt you
to confirm the execution policy change.

# SEE ALSO

[about_Execution_Policies](about_Execution_Policies.md)

[about_Group_Policy_Settings](about_Group_Policy_Settings.md)

[about_Scripts](about_Scripts.md)

"Running Scripts" (http://go.microsoft.com/fwlink/?LinkId=257680)
