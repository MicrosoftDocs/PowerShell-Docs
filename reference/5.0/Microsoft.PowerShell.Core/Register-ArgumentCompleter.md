---
author: jpjofre
description: 
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell, cmdlet
manager: carolz
ms.date: 2016-09-30
ms.prod: powershell
ms.technology: powershell
ms.topic: reference
online version: 1ce19f56-8359-408e-addd-d5635e52a1f5#VerbList
schema: 2.0.0
title: Register-ArgumentCompleter
---

# Register-ArgumentCompleter

## SYNOPSIS
Registers a custom argument completer.

## SYNTAX

### PowerShellSet
```
Register-ArgumentCompleter [-CommandName <String[]>] -ParameterName <String> -ScriptBlock <ScriptBlock>
 [<CommonParameters>]
```

### NativeSet
```
Register-ArgumentCompleter -CommandName <String[]> -ScriptBlock <ScriptBlock> [-Native] [<CommonParameters>]
```

## DESCRIPTION
The **Register-ArgumentCompleter** cmdlet registers a custom argument completer.

## EXAMPLES

### 1:
```
PS C:\>
```

## PARAMETERS

### -CommandName
Specifies the name of the command as an array.
If the command line uses  an alias, this value is the actual command, not the alias.

```yaml
Type: String[]
Parameter Sets: PowerShellSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String[]
Parameter Sets: NativeSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Native
Indicates that custom argument handlers are dispatched based on the command name.

```yaml
Type: SwitchParameter
Parameter Sets: NativeSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParameterName
Specifies the name of the parameter whose argument is being completed.
If the command line uses a parameter alias, this value is the actual parameter, not the alias.

```yaml
Type: String
Parameter Sets: PowerShellSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock
Specifies the commands to run.
Enclose the commands in braces ( { } ) to create a script block.
This parameter is required.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Core Cmdlets](1ce19f56-8359-408e-addd-d5635e52a1f5#VerbList)


