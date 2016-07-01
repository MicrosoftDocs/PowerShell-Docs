---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Remove PSDrive
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=293898
schema:  2.0.0
---


# Remove-PSDrive
## SYNOPSIS
Deletes temporary Windows PowerShell drives and disconnects mapped network drives.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-PSDrive [-Name] <String[]> [-Force] [-PSProvider <String[]>] [-Scope <String>] [-Confirm] [-WhatIf]
 [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-PSDrive [-LiteralName] <String[]> [-Force] [-PSProvider <String[]>] [-Scope <String>] [-Confirm]
 [-WhatIf] [-UseTransaction]
```

## DESCRIPTION
The Remove-PSDrive cmdlet deletes temporary Windows PowerShell drives that were created by using the New-PSDrive cmdlet.

Beginning in Windows PowerShell 3.0, Remove-PSDrive also disconnects mapped network drives, including, but not limited to, drives created by using the Persist parameter of New-PSDrive.

Remove-PSDrive cannot delete Windows physical or logical drives.

Beginning in Windows PowerShell 3.0, when an external drive is connected to the computer, Windows PowerShell automatically adds a PSDrive to the file system that represents the new drive.
You do not need to restart Windows PowerShell.
Similarly, when an external drive is disconnected from the computer, Windows PowerShell automatically deletes the PSDrive that represents the removed drive.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Remove-PSDrive -Name smp
```

This command removes a temporary file system drive named "smp".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Get-PSDrive X, S | Remove-PSDrive
```

This command disconnects the X: mapped network drive that was created in File Explorer and the S: mapped network drive that was created by using the Persist parameter of the New-PSDrive cmdlet.

The command uses the Get-PSDrive cmdlet to get the drives and the Remove-PSDrive cmdlet to disconnect them.

## PARAMETERS

### -Force
Removes the current Windows PowerShell drive.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralName
Specifies the name of the drive.

The value of LiteralName is used exactly as typed.
No characters are interpreted as wildcards.
If the name includes escape characters, enclose it in single quotation marks (').
Single quotation marks instruct Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the names of the drives to remove.
Do not type a colon (:) after the drive name.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSProvider
Removes and disconnects all of the drives associated with the specified Windows PowerShell provider.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Scope
Accepts an index that identifies the scope from which the drive is being removed.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

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
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSDriveInfo
You can pipe a drive object, such as one from the Get-PSDrive cmdlet, to the Remove-PSDrive cmdlet.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
* The Remove-PSDrive cmdlet is designed to work with the data exposed by any Windows PowerShell provider. To list the providers in your session, use the Get-PSProvider cmdlet. For more information, see about_Providers (http://go.microsoft.com/fwlink/?LinkID=113250).

*

## RELATED LINKS

[Get-PSDrive](Get-PSDrive.md)

[New-PSDrive](New-PSDrive.md)

[about_Providers](../About/about_Providers.md)

