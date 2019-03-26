---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821487
schema: 2.0.0
title: Get-PSHostProcessInfo
---
# Get-PSHostProcessInfo

## SYNOPSIS
Gets process information about the PowerShell host.

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

### 1: Get a list of PowerShell hosts running on the system

```powershell
Get-PSHostProcessInfo
```

```Output
ProcessName ProcessId AppDomainName
----------- --------- -------------
powershell       6956 DefaultAppDomain
powershell       4856 DefaultAppDomain
wsmprovhost      1780 DefaultAppDomain
```

### 2: Get PowerShell host information for a specific process

```powershell
Get-PSHostProcessInfo -Id 6956
```

```Output
ProcessName ProcessId AppDomainName
----------- --------- -------------
powershell       6956 DefaultAppDomain
```

## PARAMETERS

### -Id

Specifies a process by the process ID. To get a process ID, run the `Get-Process` cmdlet.

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

Specifies a process by the process name. To get a process name, run the `Get-Process` cmdlet. You
can also get process names from the Properties dialog box of a process in Task Manager.

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

Specifies a process by the process object. The simplest way to use this parameter is to save the
results of a `Get-Process` command that returns process that you want to enter in a variable, and
then specify the variable as the value of this parameter.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Diagnostics.Process

You can pipe a **Process** object from `Get-Process` to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.PSHostProcessInfo

## NOTES

## RELATED LINKS

[Get-Process](../Microsoft.PowerShell.Management/get-process.md)