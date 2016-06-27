---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293975
schema: 2.0.0
---

# Get-TraceSource
## SYNOPSIS
Gets the Windows PowerShell components that are instrumented for tracing.

## SYNTAX

```
Get-TraceSource [[-Name] <String[]>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Get-TraceSource cmdlet gets the trace sources for Windows PowerShell components that are currently in use.
You can use the data to determine which Windows PowerShell components you can trace.
When tracing, the component generates detailed messages about each step in its internal processing.
Developers use the trace data to monitor data flow, program execution, and errors.
The tracing cmdlets were designed for Windows PowerShell developers, but they are available to all users.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-traceSource  *provider*
```

This command gets all of the trace sources that have names that include "provider".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-tracesource
```

This command gets all of the Windows PowerShell components that can be traced.

## PARAMETERS

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

### -Name
Gets only the specified trace sources.
Wildcards are permitted.
The parameter name ("Name") is optional.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a string that contains the name of a trace source to Get-TraceSource.

## OUTPUTS

### System.Management.Automation.PSTraceSource
Get-TraceSource returns objects that represent the trace sources.

## NOTES

## RELATED LINKS

[Set-TraceSource]()

[Trace-Command]()

