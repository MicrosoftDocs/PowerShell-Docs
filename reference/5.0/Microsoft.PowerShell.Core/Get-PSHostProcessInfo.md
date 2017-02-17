---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Get PSHostProcessInfo
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821487
external help file:   System.Management.Automation.dll-Help.xml
---


# Get-PSHostProcessInfo

## SYNOPSIS

## SYNTAX

### ProcessNameParameterSet (Default)
```
Get-PSHostProcessInfo [[-Name] <String[]>] [<CommonParameters>]
```

### ProcessParameterSet
```
Get-PSHostProcessInfo [-Process] <Process[]> [<CommonParameters>]
```

### ProcessIdParameterSet
```
Get-PSHostProcessInfo [-Id] <Int32[]> [<CommonParameters>]
```

## DESCRIPTION

## EXAMPLES

### 1:
```
PS C:\>
```

### 2:
```
PS C:\>
```

## PARAMETERS

### -Id
Specifies a process by the process ID. To get a process ID, run the Get-Process cmdlet.

```yaml
Type: Int32[]
Parameter Sets: ProcessIdParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies a process by the process name. To get a process name, run the Get-Process cmdlet. You can also get process names from the Properties dialog box of a process in Task Manager.

```yaml
Type: String[]
Parameter Sets: ProcessNameParameterSet
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Process
Specifies a process by the process object. The simplest way to use this parameter is to save the results of a Get-Process command that returns process that you want to enter in a variable, and then specify the variable as the value of this parameter.

```yaml
Type: Process[]
Parameter Sets: ProcessParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

