---
ms.date:  11/13/2018
keywords:  dsc,powershell,configuration,community
title:  Configuration Based On STIG
---
# Configuration Based On STIG

> Applies To: Windows PowerShell 5.1

Creating configuration content for the first time can be challenging.
In many cases the goal is to automate configuration of servers
following a "baseline" that hopefully aligns to an industry recommendation.

A community project named
[PowerSTIG](https://github.com/microsoft/powerstig)
aims to resolve this by generating DSC content based on
[public information](https://iase.disa.mil/stigs/Pages/index.aspx)
provided about STIG (Security Technical Implementation Guide),

Dealing with baselines is actually more complicated than it sounds.
Many organizations need to
[document exceptions](https://github.com/microsoft/powerstig#powerstigdata)
to rules and manage that data at scale.
PowerSTIG includes solutions to this problem and
[Composite Resources](https://github.com/microsoft/powerstig#powerstigdsc)
to address automating different areas of the configuration
rather than trying to address the entire range of settings
in one large file.

Once the configurations have been generated,
you can use the
[DSC Configuration scripts](configurations.md)
to generate MOF files
and
[upload the MOF files to Azure Automation](https://docs.microsoft.com/en-us/azure/automation/tutorial-configure-servers-desired-state#create-and-upload-a-configuration-to-azure-automation).
Then register your servers from either
[on-premises](https://docs.microsoft.com/en-us/azure/automation/automation-dsc-onboarding#physicalvirtual-windows-machines-on-premises-or-in-a-cloud-other-than-azureaws)
or [in Azure](https://docs.microsoft.com/en-us/azure/automation/automation-dsc-onboarding#azure-virtual-machines)
to pull configurations.

To try out PowerSTIG, visit the
[PowerShell Gallery](http://www.powershellgallery.com)
and download the solution or click "Project Site"
to view the
[documentation](https://github.com/microsoft/powerstig).

## See Also

- [Windows PowerShell Desired State Configuration Overview](overview.md)
- [DSC Resources](resources.md)
- [Configuring The Local Configuration Manager](metaConfig.md)