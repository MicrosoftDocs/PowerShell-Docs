---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/get-pshostprocessinfo?view=powershell-7.2&WT.mc_id=ps-gethelp
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

The `Get-PSHostProcessInfo` cmdlet gets information about PowerShell host processes running on the
local computer.

Beginning in PowerShell 6.2, this cmdlet is supported on non-Windows platforms.

## EXAMPLES

### 1: Get a list of PowerShell hosts running on the system

```powershell
Get-PSHostProcessInfo
```

```Output
ProcessName ProcessId AppDomainName
----------- --------- -------------
powershell      11204 DefaultAppDomain
pwsh            13912 DefaultAppDomain
```

### 2: Get PowerShell host information for a specific process name

```powershell
Get-PSHostProcessInfo -Name pwsh
```

```Output
ProcessName ProcessId AppDomainName
----------- --------- -------------
pwsh            13912 DefaultAppDomain
```

## PARAMETERS

### -Id

Specifies a process by the process ID. To get a process ID, run the `Get-Process` cmdlet.

```yaml
Type: System.Int32[]
Parameter Sets: ProcessIdParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies a process by the process name. To get a process name, run the `Get-Process` cmdlet.

```yaml
Type: System.String[]
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
Type: System.Diagnostics.Process[]
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Diagnostics.Process

You can pipe a **Process** object from `Get-Process` to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.PSHostProcessInfo

## NOTES

## RELATED LINKS

[Get-Process](../Microsoft.PowerShell.Management/get-process.md)

