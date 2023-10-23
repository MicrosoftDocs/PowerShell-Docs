---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 04/22/2019
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/show-controlpanelitem?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Show-ControlPanelItem
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

The `Show-ControlPanelItem` cmdlet opens control panel items on the local computer. You can use it
to open control panel items by name, category, or description, even on systems that do not have a
user interface. You can pipe control panel items from the `Get-ControlPanelItem` cmdlet to
`Show-ControlPanelItem`.

`Show-ControlPanelItem` searches only control panel items that can be opened on the system. On
computers that do not have **Control Panel** or **File Explorer**, `Show-ControlPanelItem` searches
only control panel items that can open without these components.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Show a control panel item

This example launches the **AutoPlay** control panel item.

```powershell
Show-ControlPanelItem -Name "AutoPlay"
```

### Example 2: Pipe a control panel item to this cmdlet

This example opens the **Windows Defender Firewall** control panel item on the local computer.
The name of the Windows Firewall control panel item has changed over the versions of Windows. This
example uses a wildcard pattern to find the control panel item.

```powershell
Get-ControlPanelItem -Name "*Firewall" | Show-ControlPanelItem
```

`Get-ControlPanelItem` gets the control panel item and the `Show-ControlPanelItem` cmdlet opens
it.

### Example 3: Use a file name to open a control panel item

This example opens the **Programs and Features** control panel item by using its application name.

```powershell
appwiz.cpl
```

This method is an alternative to using a `Show-ControlPanelItem` command.

> [!NOTE]
> In PowerShell, you can omit the .cpl file extension for control panel files because it's included
> in the value of the `$env:PathExt` environment variable.

## PARAMETERS

### -CanonicalName

Specifies control panel items by using the specified canonical names or name patterns. Wildcard
characters are permitted. If you enter multiple names, this cmdlet opens control panel items that
match any of the names, as if the items in the name list were separated by an **OR** operator.

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

### -InputObject

Specifies control panel items to open by submitting control panel item objects. Enter a variable
that contains control panel item objects, or type a command or expression that gets control panel
item objects, such as `Get-ControlPanelItem`.

```yaml
Type: Microsoft.PowerShell.Commands.ControlPanelItem[]
Parameter Sets: ControlPanelItem
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies names of control panel items. Wildcard characters are permitted. If you enter multiple
names, this cmdlet opens control panel items that match any of the names, as if the items in the
name list were separated by an **OR** operator.

```yaml
Type: System.String[]
Parameter Sets: RegularName
Aliases:

Required: True
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

### System.String, Microsoft.PowerShell.Commands.ControlPanelItem

You can pipe a name or control panel item object to this cmdlet.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

## RELATED LINKS

[Get-ControlPanelItem](Get-ControlPanelItem.md)
