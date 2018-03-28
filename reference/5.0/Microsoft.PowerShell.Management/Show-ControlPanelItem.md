---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821635
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Show-ControlPanelItem
---

# Show-ControlPanelItem

## SYNOPSIS
Opens control panel items.

## SYNTAX

### RegularName (Default)
```
Show-ControlPanelItem [-Name] <String[]> [<CommonParameters>]
```

### CanonicalName
```
Show-ControlPanelItem -CanonicalName <String[]> [<CommonParameters>]
```

### ControlPanelItem
```
Show-ControlPanelItem [[-InputObject] <ControlPanelItem[]>] [<CommonParameters>]
```

## DESCRIPTION
The **Show-ControlPanelItem** cmdlet opens control panel items on the local computer.
You can use it to open control panel items by name, category, or description, even on systems that do not have a user interface.
You can pipe control panel items from the Get-ControlPanelItem cmdlet to **Show-ControlPanelItem**.

**Show-ControlPanelItem** searches only control panel items that can be opened on the system.
On computers that do not have **Control Panel** or **File Explorer**, **Show-ControlPanelItem** searches only control panel items that can open without these components.

This cmdlet was introduced in Windows PowerShell 3.0.
It works only on Windows 8 and Windows Server 2012.
Because this cmdlet requires a user interface, it does not work on Server Core installations of Windows Server.

## EXAMPLES

### Example 1: Show a control panel item
```
PS C:\> Show-ControlPanelItem -Name "AutoPlay"
```

This command shows the AutoPlay item.

### Example 2: Pipe a control panel item to this cmldet
```
PS C:\> Get-ControlPanelItem -Name "Windows Firewall" | Show-ControlPanelItem
```

This command opens the Windows Firewall control panel item on the local computer.
It uses the Get-ControlPanelItem cmdlet to get the control panel item and the **Show-ControlPanelItem** cmdlet to open it.

### Example 3: Use a file name to open a control panel item
```
PS C:\> appwiz
```

This command opens the Programs and Features control panel item by using its application name.
The .cpl file name extension is not required in the command.

This method is an alternative to using a **Show-ControlPanelItem** command.

In Windows PowerShell 3.0, you can omit the .cpl file name extension for control panel item files because it is included in the value of the PathExt environment variable.

## PARAMETERS

### -CanonicalName
Specifies control panel items by using the specified canonical names or name patterns.
Wildcard characters are permitted.
If you enter multiple names, this cmdlet opens control panel items that match any of the names, as if the items in the name list were separated by an **OR** operator.

```yaml
Type: String[]
Parameter Sets: CanonicalName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies control panel items to open by submitting control panel item objects.
Enter a variable that contains control panel item objects, or type a command or expression that gets control panel item objects, such as **Get-ControlPanelItem**.

```yaml
Type: ControlPanelItem[]
Parameter Sets: ControlPanelItem
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies names of control panel items.
Wildcard characters are permitted.
If you enter multiple names, this cmdlet opens control panel items that match any of the names, as if the items in the name list were separated by an **OR** operator.

```yaml
Type: String[]
Parameter Sets: RegularName
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String, Microsoft.PowerShell.Commands.ControlPanelItem
You can pipe a name or control panel item object to this cmdlet.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES

## RELATED LINKS

[Get-ControlPanelItem](Get-ControlPanelItem.md)