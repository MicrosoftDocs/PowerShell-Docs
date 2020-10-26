---
ms.date:  06/12/2017
title:  Require license acceptance
description: How to view the package license on the item details page
---
# Require license acceptance

Require License Acceptance text shows up on item details page for modules that require license
acceptance. License for module can be viewed by clicking on **View License.txt** link.

![Require License Acceptance](media/packages-that-require-license-acceptance/RequireLicenseAcceptance.png)

Users will be prompted to accept the license when installing, saving or updating the module through
PowerShellGet or when deploying to Azure Automation.

## Require License Acceptance on Deploy to Azure Automation

If the module being deployed to Azure Automation requires license acceptance, portal UI will show a
disclaimer saying 'This module requires license acceptance. By clicking OK, you are accepting
license terms.'

![Deploy to Azure Automation Requires License Acceptance](media/packages-that-require-license-acceptance/DeployToAzureAutomationRequireLicenseAcceptanceDisclaimer.png)

## More details

[Require License Acceptance in PowerShellGet](../../concepts/module-license-acceptance.md)
[Azure Automation website](/azure/automation)
