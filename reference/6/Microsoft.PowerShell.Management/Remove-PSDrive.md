---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821618
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Remove-PSDrive
---

# Remove-PSDrive

## SYNOPSIS
Deletes temporary PowerShell drives and disconnects mapped network drives.

## SYNTAX

### Name (Default)
```
Remove-PSDrive [-Name] <String[]> [-PSProvider <String[]>] [-Scope <String>] [-Force]
 [-WhatIf] [-Confirm] [-UseTransaction] [<CommonParameters>]
```

### LiteralName
```
Remove-PSDrive [-LiteralName] <String[]> [-PSProvider <String[]>] [-Scope <String>] [-Force]
 [-WhatIf] [-Confirm] [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION
The **Remove-PSDrive** cmdlet deletes temporary PowerShell drives that were created by using the New-PSDrive cmdlet.

Starting in Windows PowerShell 3.0, **Remove-PSDrive** also disconnects mapped network drives, including, but not limited to, drives created by using the *Persist* parameter of **New-PSDrive**.

**Remove-PSDrive** cannot delete Windows physical or logical drives.

Starting in Windows PowerShell 3.0, when an external drive is connected to the computer, Windows PowerShell automatically adds a PSDrive to the file system that represents the new drive.
You do not have to restart PowerShell.
Similarly, when an external drive is disconnected from the computer, PowerShell automatically deletes the PSDrive that represents the removed drive.

## EXAMPLES

### Example 1: Remove a file system drive
```
PS C:\> Remove-PSDrive -Name smp
```

This command removes a temporary file system drive named smp.

### Example 2: Remove mapped network drives
```
PS C:\> Get-PSDrive X, S | Remove-PSDrive
```

This command disconnects the X: mapped network drive that was created in File Explorer and the S: mapped network drive that was created by using the *Persist* parameter of the New-PSDrive cmdlet.

The command uses the Get-PSDrive cmdlet to get the drives and **Remove-PSDrive** to disconnect them.

## PARAMETERS

### -Force
Removes the current PowerShell drive.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralName
Specifies the name of the drive.

The value of *LiteralName* is used exactly as typed.
No characters are interpreted as wildcard characters.
If the name includes escape characters, enclose it in single quotation marks.
Single quotation marks instruct PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralName
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the names of the drives to remove.
Do not type a colon (:) after the drive name.

```yaml
Type: String[]
Parameter Sets: Name
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSProvider
Specifies an array of **PSProvider** objects.
This cmdlet removes and disconnects all of the drives associated with the specified PowerShell provider.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Scope
Specifies an index that identifies the scope from which the drive is being removed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: usetx

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSDriveInfo
You can pipe a drive object, such as one from the Get-PSDrive cmdlet, to the this cmdlet.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
* **Remove-PSDrive** is designed to work with the data exposed by any PowerShell provider. To list the providers in your session, use the Get-PSProvider cmdlet. For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

*

## RELATED LINKS

[Get-PSDrive](Get-PSDrive.md)

[New-PSDrive](New-PSDrive.md)