---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821571
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Clear-RecycleBin
---
# Clear-RecycleBin

## SYNOPSIS
Clears the contents of a recycle bin.

## SYNTAX

```
Clear-RecycleBin [[-DriveLetter] <String[]>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The Clear-RecycleBin cmdlet deletes the content of a recycle bin. Running this cmdlet is equivalent to the "Empty Recycle Bin" action.

## EXAMPLES

### 1: Clear all recycle bins

```
PS C:\> Clear-RecycleBin
```
This command will clear all recycle bins present on the local computer.
the command will prompt for user confirmation before execution.

### 2: Clear single recycle bin

```
PS C:\> Clear-RecycleBin -DriveLetter C
```
This command will clear the recycle bin on the volume with the C drive letter.
This command will not work on 
The command will prompt for user confirmation before execution.

### 3: Clear all recycle bins without confirmation

```
PS C:\> Clear-RecycleBin -Force
```
This command will clear the recycle bin on the volume with the C drive letter.
The command will NOT prompt for user confirmation before execution.

### 3: Clear all recycle bins without confirmation (alternative)

```
PS C:\> Clear-RecycleBin -Confirm:$false
```
This command will clear the recycle bin on the volume with the C drive letter.
The command will NOT prompt for user confirmation before execution.

## PARAMETERS

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

### -DriveLetter

Specifies an array of drive letters for which this cmdlet clears the recycle bin.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force

Forces the command to run without asking for user confirmation.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS