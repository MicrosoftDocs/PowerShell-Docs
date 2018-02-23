---
ms.date:  2017-06-12
contributor:  JKeithB
ms.topic:  conceptual
keywords:  gallery,powershell,cmdlet,psgallery
title:  psgallery_deploy_to_azure_automation
---

Deploy to Azure Automation
===========================

The Deploy to Azure Automation button on the item details page will deploy the item from the PowerShell Gallery to Azure Automation.

![Deploy to Azure Automation Button](Images/DeployToAzureAutomationButton.png)

When clicked, it will redirect you to the Azure Management Portal, where you sign in using your Azure account credentials.
If the item includes dependencies, all the dependencies will be deployed to Azure Automation as well.

WARNING:  If the same item and version already exist in your Automation account, deploying it again from the PowerShell Gallery will overwrite the item in your Automation account.

If you deploy a module, it will appear in the Modules section of Azure Automation.  If you deploy a script, it will appear in the Runbooks section of Azure Automation.

The Deploy to Azure Automation button can be disabled by adding the AzureAutomationNotSupported tag to the item metadata.

To learn more about Azure Automation, see the Azure Automation website [Azure Automation website](http://azure.microsoft.com/services/automation/).

