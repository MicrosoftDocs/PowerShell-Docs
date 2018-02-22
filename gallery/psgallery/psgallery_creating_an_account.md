---
ms.date:  2017-06-12
contributor:  JKeithB
ms.topic:  conceptual
keywords:  gallery,powershell,cmdlet,psgallery
title:  Creating a PowerShell Gallery Account
---

## Creating a PowerShell Gallery Account

A PowerShell Gallery account must be established before publishing anything to the PowerShell Gallery. 
The PowerShell Gallery accounts must be linked to an Azure Active Directory email-enabled account, or a Microsoft email account (with a domain of outlook.com, hotmail.com, etc.)

To create a PowerShell Gallery account, go to https://PowerShellGallery.com and click on "Register" (see the image below). 

![Register new account](./images/CreatingAccount-Register.png)

In the next page, to use an Azure Active Directory account, select "Work or School Account", and log in with your account. 
To use a Microsoft account - such as one in a Hotmail.com or Outlook.com domain - choose "Personal Account", and log in. 

Once you have logged in, you will be prompted to create a username for the PowerShell Gallery. 
Review the Terms of Use and Privacy Policy that are linked in, enter a username, and then click Register.

Note: This account name cannot be changed once it is created.  
See [Managing Item Owners](https://msdn.microsoft.com/powershell/gallery/psgallery/managing-item-owners) for additional 
details related to this.

## Recommended Practices for PowerShell Gallery Accounts

It is important that the email account used with your PowerShell Gallery account be actively monitored.
All communiction with owners of PowerShell Gallery items is through the email using the address associated with your PowerShell Gallery account.
If we are unable to contact an item owner, the Operations team may be required to delete an item under some circumstances.

Organizations that publish to the PowerShell Gallery often create a unique account for that purpose in Outlook.com, or another Microsoft account domain.
In many cases that account is not regularly monitored. 
A best practice in that case is to use Outlook Forwarding to send email to another account, typically one within the organization, that will be monitored by the item owner(s).

If there are multiple owners associated with an item, all communications that come from the PowerShell Gallery will go to all owners.
See [Managing Item Owners](https://msdn.microsoft.com/powershell/gallery/psgallery/managing-item-owners) for additional 
details on adding owners to an item. 

