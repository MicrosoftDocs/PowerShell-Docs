---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Get ControlPanelItem
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkID=219982
external help file:   Microsoft.PowerShell.Commands.Management.dll-Help.xml
---


# Get-ControlPanelItem
## SYNOPSIS
Gets control panel items.
## SYNTAX

### RegularName (Default)
```
Get-ControlPanelItem [[-Name] <String[]>] [-Category <String[]>] [<CommonParameters>]
```

### CanonicalName
```
Get-ControlPanelItem -CanonicalName <String[]> [-Category <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-ControlPanelItem** cmdlet gets control panel items on the local computer.
You can use it to find control panel items by name, category, or description, even on systems that do not have a user interface.

**Get-ControlPanelItem** gets only the control panel items that can be opened on the system.
On computers that do not have Control Panel or File Explorer, **Get-ControlPanelItem** gets only control panel items that can open without these components.

This cmdlet is introduced in Windows PowerShell 3.0.
It works only on Windows 8 and Windows Server 2012.
## EXAMPLES

### Example 1: Get all control panel items
```
PS C:\> Get-ControlPanelItem
Name                          CanonicalName                 Category                      Description
----                          -------------                 --------                      -----------
Action Center                 Microsoft.ActionCenter        {System and Security}         Review recent messages and... 
Administrative Tools          Microsoft.AdministrativeTools {System and Security}         Configure administrative s... 
AutoPlay                      Microsoft.AutoPlay            {Hardware}                    Change default settings fo... 
BitLocker Drive Encryption    Microsoft.BitLockerDriveEn... {System and Security}         Protect your computer usin... 
Color Management              Microsoft.ColorManagement     {All Control Panel Items}     Change advanced color mana... 
Credential Manager            Microsoft.CredentialManager   {User Accounts}               Manage your Windows Creden... 
Date and Time                 Microsoft.DateAndTime         {Clock, Language, and Region} Set the date, time, and ti...
```

This command gets all control panel items on the local computer.
### Example 2: Get control panel items by name
```
PS C:\> Get-ControlPanelItem -Name *program*, *app*
```

This command gets control panel items that have "program" or "app"  in their names.
### Example 3: Get control panel items by category
```
PS C:\> Get-ControlPanelItem -Category *security*
```

This command gets all control panel items in categories that have "Security" in their names.
### Example 4: Open a control panel item
```
PS C:\> Get-ControlPanelItem -Name "Windows Firewall" | Show-ControlPanelItem
```

This command opens the Windows Firewall control panel item on the local computer.
It uses the **Get-ControlPanelItem** cmdlet to get the control panel item and the Show-ControlPanelItem cmdlet to open it.
### Example 5: Get control panel items on a remote computer
```
PS C:\> Invoke-Command -ComputerName Server01 {Get-ControlPanelItem -Name "BitLocker*" }
```

This command gets the  BitLocker Drive Encryption control panel item on the Server01 remote computer.
It uses the Invoke-Command cmdlet to run the Get-ControlPanelItem cmdlet remotely.
### Example 6: Search the descriptions of control panel items
```
PS C:\> Get-ControlPanelItem | Where-Object {$_.Description -like "*device*"}
Name                          CanonicalName                 Category                      Description
----                          -------------                 --------                      -----------
AutoPlay                      Microsoft.AutoPlay            {Hardware}                    Change default settings fo... 
Devices and Printers          Microsoft.DevicesAndPrinters  {Hardware}                    View and manage devices, p... 
Sound                         Microsoft.Sound               {Hardware}                    Configure your audio devic...
```

This command searches the **Description** property of the control panel item objects and gets only those that contain "device".
The command uses the Get-ControlPanelItem cmdlet to get all control panel items and the Where-Object cmdlet to filter the items by the value of the **Description** property.
## PARAMETERS

### -CanonicalName
Gets control panel items with the specified canonical names or name patterns.
Wildcards are permitted.
If you enter multiple names, **Get-ControlPanelItem** gets control panel items that match any of the names, as though the items in the name list were separated by an "or" operator.

By default, **Get-ControlPanelItem** gets all control panel items in the system.

```yaml
Type: String[]
Parameter Sets: CanonicalName
Aliases: 

Required: True
Position: Named
Default value: All control panel items
Accept pipeline input: False
Accept wildcard characters: True
```

### -Category
Gets control panel items in the specified categories.
Enter a category name or name pattern.
Wildcards are permitted.
If you enter multiple names, Get-ControlPanelItem gets control panel items that match any of the names, as though the items in the name list were separated by an "or" operator.
By default, **Get-ControlPanelItem** gets all control panel items in the system.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: All control panel items
Accept pipeline input: False
Accept wildcard characters: True
```

### -Name
Gets control panel items with the specified names or name patterns.
Wildcards are permitted.
You can also pipe a name or name pattern to the **Get-ControlPanelItem** cmdlet.

```yaml
Type: String[]
Parameter Sets: RegularName
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.String
You can pipe a name or name pattern to the Get-ControlPanelItem cmdlet.
## OUTPUTS

### Microsoft.PowerShell.Commands.ControlPanelItem

## NOTES

## RELATED LINKS

[Show-ControlPanelItem](Show-ControlPanelItem.md)

