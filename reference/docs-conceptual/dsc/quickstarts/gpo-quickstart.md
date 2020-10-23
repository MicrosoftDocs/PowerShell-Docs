---
ms.date:  07/09/2019
keywords:  dsc,gpo,powershell,configuration,setup
title:  Quickstart - Convert Group Policy into DSC
description: This Quickstart shows the steps requires to convert a Windows Group Policy to a DSC configuration.
---
# Quickstart: Convert Group Policy into DSC

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

You can generate a DSC configuration from a Group Policy or Azure Security Center baseline. The
[BaselineManagement](https://www.powershellgallery.com/packages/BaselineManagement) module includes
the following commands for accomplishing this task.

- `ConvertFrom-GPO` - Converts Group Policies, stored as files. You can also specify a directory
  containing multiple policies that will be combined into one Configuration.
  - To export Group Policies in your environment, use the
    [Backup-GPO](/powershell/module/grouppolicy/backup-gpo) cmdlet, or follow the
    instructions in
    [Export a GPO to a File](/microsoft-desktop-optimization-pack/agpm/export-a-gpo-to-a-file).
- `ConvertFrom-SCM` - Converts Security Compliance Manager baselines, stored as `.xml` files.
- `ConvertFrom-ASC` - Converts Azure Security Center baselines, stored as `.json` files.
- `Merge-GPOs` - Converts Group Policies applied to a target computer.

The cmdlets listed above convert a baseline into a DSC `.mof` file. You can also choose to output a
Configuration script (`.ps1`), that you can edit and recompile. The cmdlets detect compilation
errors for missing resources, or duplicate resource blocks. Resource blocks that would cause
compilation errors are commented out.

The following example converts a [Microsoft Security Baseline](https://www.microsoft.com/download/details.aspx?id=55319)
into a DSC configuration script (`.ps1`) and `.mof` file.

```powershell
Install-Module BaselineManagement
Import-Module BaselineManagement
ConvertFrom-GPO -Path '.\Windows 10 Version 1903 and Windows Server Version 1903 Security Baseline\GPOs\' -OutputConfigurationScript
```

After running the commands, you see two files in the default "Output" directory created under your
current path.

```powershell
Get-ChildItem -Path .\Output
```

```Output
    Directory:  C:\Temp

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a----         7/9/2019   9:35 AM   227.37KB DSCFromGPO.ps1
-a----         7/9/2019   9:35 AM   410.03KB localhost.mof
```

Each managed node will also need the following two modules:

- [SecurityPolicyDSC](https://www.powershellgallery.com/packages/SecurityPolicyDsc)
- [AuditPolicyDSC](https://www.powershellgallery.com/packages/AuditPolicyDsc)

> [!NOTE]
> **BaselineManagement** is a solution developed by the community to make DSC more discoverable for
> Support for community solutions come from the project maintainers and not from Microsoft. You can
> open a new issue for **BaselineManagement** on
> [GitHub](https://github.com/microsoft/BaselineManagement).

## Next steps

- To upload your configuration script into Azure Automation State Configuration, see
  [Getting Started](/azure/automation/automation-dsc-getting-started#importing-a-configuration-into-azure-automation).
- Add the **SecurityPolicyDSC** and **AuditPolicyDSC** modules to your
  [Automation Account](/azure/automation/shared-resources/modules).
- Find DSC configurations and resources in the
  [PowerShell Gallery](https://www.powershellgallery.com/).
