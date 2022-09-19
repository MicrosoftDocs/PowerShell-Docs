---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 09/11/2019
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-controlpanelitem?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-ControlPanelItem
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

The `Get-ControlPanelItem` cmdlet gets control panel items on the local computer. You can use it
to find control panel items by name, category, or description, even on systems that do not have a
user interface.

This cmdlet gets only the control panel items that can be opened on the system. On computers that do
not have Control Panel or File Explorer, this cmdlet gets only control panel items that can open
without these components.

This cmdlet was introduced in Windows PowerShell 3.0. It works only on Windows 8 and Windows Server
2012 and newer.

## EXAMPLES

### Example 1: Get all control panel items

This command gets all control panel items on the local computer.

```powershell
Get-ControlPanelItem
```

```Output
Name                          CanonicalName                 Category                      Description
----                          -------------                 --------                      -----------
Action Center                 Microsoft.ActionCenter        {System and Security}         Review recent messages and...
Administrative Tools          Microsoft.AdministrativeTools {System and Security}         Configure administrative s...
AutoPlay                      Microsoft.AutoPlay            {Hardware}                    Change default settings fo...
BitLocker Drive Encryption    Microsoft.BitLockerDriveEn... {System and Security}         Protect your computer usin...
Color Management              Microsoft.ColorManagement     {All Control Panel Items}     Change advanced color mana...
Credential Manager            Microsoft.CredentialManager   {User Accounts}               Manage your Windows Creden...
Date and Time                 Microsoft.DateAndTime         {Clock, Language, and Region} Set the date, time, and ti...
...
```

### Example 2: Get control panel items by name

This example gets control panel items that have Program or App in their names.

```powershell
Get-ControlPanelItem -Name "*Program*", "*App*"
```

### Example 3: Get control panel items by category

This command gets all control panel items in categories that have Security in their names.

```powershell
Get-ControlPanelItem -Category "*Security*"
```

### Example 4: Open a control panel item

This example opens the Windows Firewall control panel item on the local computer.

```powershell
Get-ControlPanelItem -Name "Windows Firewall" | Show-ControlPanelItem
```

The `Get-ControlPanelItem` cmdlet gets the control panel item. The `Show-ControlPanelItem` cmdlet
opens it.

### Example 5: Get control panel items on a remote computer

This example gets the BitLocker Drive Encryption control panel item on the Server01 remote computer.
The `Invoke-Command` cmdlet runs the `Get-ControlPanelItem` cmdlet remotely.

```powershell
Invoke-Command -ComputerName "Server01" {Get-ControlPanelItem -Name "BitLocker*" }
```

### Example 6: Search the descriptions of control panel items

This example searches the **Description** property of the control panel items to get only those that
contain the name **Device**.

```powershell
Get-ControlPanelItem | Where-Object {$_.Description -like "*Device*"}
```

```Output
Name                    CanonicalName                 Category    Description
----                    -------------                 --------    -----------
AutoPlay                Microsoft.AutoPlay            {Hardware}  Change default settings fo...
Devices and Printers    Microsoft.DevicesAndPrinters  {Hardware}  View and manage devices, p...
Sound                   Microsoft.Sound               {Hardware}  Configure your audio devic...
```

The `Get-ControlPanelItem` cmdlet gets all control panel items. The `Where-Object` cmdlet filters
the items by the value of the **Description** property.

## PARAMETERS

### -CanonicalName

Specifies, as a string array, the control panel items by their canonical names or name patterns that
this cmdlet gets. Wildcards are permitted. If you enter multiple names, this cmdlet gets control
panel items that match any of the names, as though the items in the name list were separated by an
"or" operator.

By default, this cmdlet gets all control panel items in the system.

```yaml
Type: System.String[]
Parameter Sets: CanonicalName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Category

Specifies, as a string array, the categories of the control panel items in the specified categories
that this cmdlet gets. Enter a category name or name pattern. Wildcards are permitted. If you enter
multiple names, this cmdlet gets control panel items that match any of the names, as though the
items in the name list were separated by an "or" operator. By default, this cmdlet gets all control
panel items in the system.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Name

Specifies, as a string array, the names or name patterns of the control panel that this cmdlet gets.
Wildcards are permitted. You can also pipe a name or name pattern to this cmdlet.

```yaml
Type: System.String[]
Parameter Sets: RegularName
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a name or name pattern to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.ControlPanelItem

This cmdlet gets control panel items on the local computer.

## NOTES

## RELATED LINKS

[Show-ControlPanelItem](Show-ControlPanelItem.md)
