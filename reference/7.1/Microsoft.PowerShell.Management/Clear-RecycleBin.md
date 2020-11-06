---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 10/28/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/clear-recyclebin?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Clear-RecycleBin
---

# Clear-RecycleBin

## SYNOPSIS
Clears the contents of a recycle bin.

## SYNTAX

### All

```
Clear-RecycleBin [[-DriveLetter] <String[]>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Clear-RecycleBin` cmdlet deletes the content of a computer's recycle bin. This action is like
using Windows **Empty Recycle Bin**.

This cmdlet was readded in PowerShell 7.

## EXAMPLES

### 1: Clear all recycle bins

In this example, all the local computer's recycle bins are cleared.

```powershell
Clear-RecycleBin
```

```Output
Confirm
Are you sure you want to perform this action?
Performing the operation "Clear-RecycleBin" on target "All of the contents of the Recycle Bin".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
```

`Clear-RecycleBin` prompts the user for confirmation to clear all recycle bins on the local
computer.

### 2: Clear a specified recycle bin

This example clears the recycle bin for a specified drive letter.

```powershell
Clear-RecycleBin -DriveLetter C
```

`Clear-RecycleBin` uses the **DriveLetter** parameter to specify the recycle bin on the **C**
volume. The user is prompted for confirmation to run the command.

### 3: Clear all recycle bins without confirmation

This example doesn't prompt for confirmation to clear the local computer's recycle bins.

```powershell
Clear-RecycleBin -Force
```

`Clear-RecycleBin` uses the **Force** parameter and doesn't prompt the user for confirmation to
clear all recycle bins on the local computer.

An alternative is to replace `-Force` with `-Confirm:$false`.

## PARAMETERS

### -DriveLetter

Specifies the recycle bin to clear for a single drive letter or an array of drive letters.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force

Specifies that the user isn't prompted for confirmation to clear a recycle bin.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts for user confirmation before running the cmdlet. The user is prompted for confirmation even
if the **Confirm** parameter isn't specified.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if `Clear-RecycleBin` runs. The cmdlet isn't run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### None

## NOTES

This cmdlet is only available on Windows platforms.

## RELATED LINKS
