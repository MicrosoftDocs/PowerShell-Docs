---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-tracesource?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-TraceSource
---
# Get-TraceSource

## Synopsis
Gets PowerShell components that are instrumented for tracing.

## Syntax

```
Get-TraceSource [[-Name] <String[]>] [<CommonParameters>]
```

## Description

The **Get-TraceSource** cmdlet gets the trace sources for PowerShell components that are currently in use.
You can use the data to determine which PowerShell components you can trace.
When tracing, the component generates detailed messages about each step in its internal processing.
Developers use the trace data to monitor data flow, program execution, and errors.

The tracing cmdlets were designed for PowerShell developers, but they are available to all users.

## Examples

### Example 1: Get trace sources by name

```
PS C:\> Get-TraceSource -Name "*provider*"
```

This command gets all of the trace sources that have names that include provider.

### Example 2: Get all trace sources

```
PS C:\> Get-TraceSource
```

This command gets all of the PowerShell components that can be traced.

## Parameters

### -Name

Specifies the trace sources to get.
Wildcards are permitted.
The parameter name *Name* is optional.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

You can pipe a string that contains the name of a trace source to **Get-TraceSource**.

## Outputs

### System.Management.Automation.PSTraceSource

**Get-TraceSource** returns objects that represent the trace sources.

## Notes

## Related links

[Set-TraceSource](Set-TraceSource.md)

[Trace-Command](Trace-Command.md)

