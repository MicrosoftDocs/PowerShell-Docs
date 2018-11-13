---
ms.date:  11/13/2018
keywords:  dsc,powershell,configuration,setup
title:  Create Configurations from Servers
---
# Create Configurations from Servers

> Applies To: Windows PowerShell 5.1

Creating configurations from existing servers can be a challenging task.
You might not want *all* settings,
just those that you care about.
Even then you need to know in what order the settings
must be applied in order for the configuration to apply successfully.

A community maintained solution named
[ReverseDSC](https://github.com/microsoft/reversedsc)
has been created to work in this area starting SharePoint.

The solution builds on the
[SharePointDSC resource](https://github.com/powershell/sharepointdsc)
and extends it to orchestrate
[gathering information](https://github.com/Microsoft/sharepointDSC.reverse#how-to-use)
from existing SharePoint servers.
The latest version has multiple
[extraction modes](https://github.com/Microsoft/SharePointDSC.Reverse/wiki/Extraction-Modes)
to determine what level of information to include.

The result of using the solution is generating
[Configuration Data](https://github.com/Microsoft/sharepointDSC.reverse#configuration-data)
to be used with SharePointDSC configuration scripts.

Once the data files have been generated,
you can use them with
[DSC Configuration scripts](configurations.md)
to generate MOF files
and
[upload the MOF files to Azure Automation](https://docs.microsoft.com/en-us/azure/automation/tutorial-configure-servers-desired-state#create-and-upload-a-configuration-to-azure-automation).
Then register your servers from either
[on-premises](https://docs.microsoft.com/en-us/azure/automation/automation-dsc-onboarding#physicalvirtual-windows-machines-on-premises-or-in-a-cloud-other-than-azureaws)
or [in Azure](https://docs.microsoft.com/en-us/azure/automation/automation-dsc-onboarding#azure-virtual-machines)
to pull configurations.

To try out ReverseDSC, visit the
[PowerShell Gallery](http://www.powershellgallery.com)
and download the solution or click "Project Site"
to view the
[documentation](https://github.com/Microsoft/sharepointDSC.reverse).

## See Also

- [Windows PowerShell Desired State Configuration Overview](overview.md)
- [DSC Resources](resources.md)
- [Configuring The Local Configuration Manager](metaConfig.md)