---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Show ControlPanelItem
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=293915
schema:  2.0.0
---


# Show-ControlPanelItem
## SYNOPSIS
Opens control panel items.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Show-ControlPanelItem [-Name] <String[]>
```

### UNNAMED_PARAMETER_SET_2
```
Show-ControlPanelItem -CanonicalName <String[]>
```

### UNNAMED_PARAMETER_SET_3
```
Show-ControlPanelItem [[-InputObject] <ControlPanelItem[]>]
```

## DESCRIPTION
The Show-ControlPanelItem cmdlet opens control panel items on the local computer.
You can use it to open control panel items by name, category, or description, even on systems that do not have a user interface, and you can pipe control panel items from Get-ControlPanelItem to Show-ControlPanelItem.

Show-ControlPanelItem searches only the control panel items that can be opened on the system.
On computers that do not have Control Panel or File Explorer, Show-ControlPanelItem searches only control panel items that can open without these components.

This cmdlet is introduced in Windows PowerShell 3.0.
It works only on Windows 8 and Windows Server 2012.
Because this cmdlet requires a user interface, it does not work on Server Core installations of Windows Server.

## EXAMPLES

### Example 1: Open a Control Panel Item
```
PS C:\>Show-ControlPanelItem -Name AutoPlay
```

### Example 2: Pipe a control panel item to Show-ControlPanelItem
```
PS C:\>Get-ControlPanelItem -Name "Windows Firewall" | Show-ControlPanelItem
```

This command opens the Windows Firewall control panel item on the local computer.
It uses the Get-ControlPanelItem cmdlet to get the control panel item and the Show-ControlPanelItem cmdlet to open it.

### Example 3: Use a file name to open a control panel item
```
PS C:\>appwiz
```

This command opens the Programs and Features control panel item by using its application name.
The .cpl file name extension is not required in the command.

This method is an alternative to using a Show-ControlPanelItem command.

In Windows PowerShell 3.0, you can omit the .cpl file name extension for control panel item files because it is included in the value of the PathExt environment variable.

## PARAMETERS

### -CanonicalName
Opens control panel items with the specified canonical names or name patterns.
Wildcards are permitted.
If you enter multiple names, Get-ControlPanelItem opens the control panel items that match any of the names, as though the items in the name list were separated by an "or" operator.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -InputObject
Specifies the control panel items to open by submitting control panel item objects.
Enter a variable that contains the control panel item objects, or type a command or expression that gets the control panel item objects, such as a Get-ControlPanelItem command.

```yaml
Type: ControlPanelItem[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Opens control panel items with the specified names or name patterns.
Wildcards are permitted.
If you enter multiple names, Get-ControlPanelItem opens the control panel items that match any of the names, as though the items in the name list were separated by an "or" operator.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: True
```

## INPUTS

### System.String,  Microsoft.PowerShell.Commands.ControlPanelItem
You can pipe a name or control panel item object to Show-ControlPanelItem.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES

## RELATED LINKS

[Get-ControlPanelItem](Get-ControlPanelItem.md)

