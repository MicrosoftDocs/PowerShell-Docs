---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293915
schema: 2.0.0
---

# Show-ControlPanelItem
## SYNOPSIS
Opens control panel items.

## SYNTAX

### RegularName (Default)
```
Show-ControlPanelItem [-Name] <String[]> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

### CanonicalName
```
Show-ControlPanelItem -CanonicalName <String[]> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

### ControlPanelItem
```
Show-ControlPanelItem [[-InputObject] <ControlPanelItem[]>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
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
Parameter Sets: CanonicalName
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the control panel items to open by submitting control panel item objects.
Enter a variable that contains the control panel item objects, or type a command or expression that gets the control panel item objects, such as a Get-ControlPanelItem command.

```yaml
Type: ControlPanelItem[]
Parameter Sets: ControlPanelItem
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Opens control panel items with the specified names or name patterns.
Wildcards are permitted.
If you enter multiple names, Get-ControlPanelItem opens the control panel items that match any of the names, as though the items in the name list were separated by an "or" operator.

```yaml
Type: String[]
Parameter Sets: RegularName
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.String,  Microsoft.PowerShell.Commands.ControlPanelItem
You can pipe a name or control panel item object to Show-ControlPanelItem.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES

## RELATED LINKS

[Get-ControlPanelItem]()

