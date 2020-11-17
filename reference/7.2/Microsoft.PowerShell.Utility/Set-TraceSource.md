---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/set-tracesource?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-TraceSource
---
# Set-TraceSource

## SYNOPSIS
Configures, starts, and stops a trace of PowerShell components.

## SYNTAX

### optionsSet (Default)

```
Set-TraceSource [-Name] <String[]> [[-Option] <PSTraceSourceOptions>] [-ListenerOption <TraceOptions>]
 [-FilePath <String>] [-Force] [-Debugger] [-PSHost] [-PassThru] [<CommonParameters>]
```

### removeAllListenersSet

```
Set-TraceSource [-Name] <String[]> [-RemoveListener <String[]>] [<CommonParameters>]
```

### removeFileListenersSet

```
Set-TraceSource [-Name] <String[]> [-RemoveFileListener <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The **Set-TraceSource** cmdlet configures, starts, and stops a trace of a PowerShell component.
You can use it to specify which components will be traced and where the tracing output is sent.

## EXAMPLES

### Example 1: Trace the ParameterBinding component

```
PS C:\> Set-TraceSource -Name "ParameterBinding" -Option ExecutionFlow -PSHost -ListenerOption "ProcessId,TimeStamp"
```

This command starts tracing for the ParameterBinding component of PowerShell.
It uses the *Name* parameter to specify the trace source, the *Option* parameter to select the ExecutionFlow trace events, and the *PSHost* parameter to select the PowerShell host listener, which sends the output to the console.
The *ListenerOption* parameter adds the ProcessID and TimeStamp values to the trace message prefix.

### Example 2: Stop a trace

```
PS C:\> Set-TraceSource -Name "ParameterBinding" -RemoveListener "Host"
```

This command stops the trace of the ParameterBinding component of PowerShell.
It uses the *Name* parameter to identify the component that was being traced and the *RemoveListener* parameter to identify the trace listener.

## PARAMETERS

### -Debugger

Indicates that the cmdlet sends the trace output to the debugger.
You can view the output in any user-mode or kernel mode debugger or in Microsoft Visual Studio.
This parameter also selects the default trace listener.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: optionsSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Specifies a file that this cmdlet sends the trace output to.
This parameter also selects the file trace listener.
If you use this parameter to start the trace, use the *RemoveFileListener* parameter to stop the trace.

```yaml
Type: System.String
Parameter Sets: optionsSet
Aliases: PSPath, Path

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Indicates that the cmdlet overwrites a read-only file.
Use with the *FilePath* parameter.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: optionsSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ListenerOption

Specifies optional data to the prefix of each trace message in the output.
The acceptable values for this parameter are:

- None
- LogicalOperationStack
- DateTime
- Timestamp
- ProcessId
- ThreadId
- Callstack

None is the default.

To specify multiple options, separate them with commas, but with no spaces, and enclose them in quotation marks, such as "ProcessID,ThreadID".

```yaml
Type: System.Diagnostics.TraceOptions
Parameter Sets: optionsSet
Aliases:
Accepted values: None, LogicalOperationStack, DateTime, Timestamp, ProcessId, ThreadId, Callstack

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies which components are traced.
Enter the name of the trace source of each component.
Wildcards are permitted.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Option

Specifies the type of events that are traced.
The acceptable values for this parameter are:

- None
- Constructor
- Dispose
- Finalizer
- Method
- Property
- Delegates
- Events
- Exception
- Lock
- Error
- Errors
- Warning
- Verbose
- WriteLine
- Data
- Scope
- ExecutionFlow
- Assert
- All

All is the default.

The following values are combinations of other values:

- ExecutionFlow: (Constructor, Dispose, Finalizer, Method, Delegates, Events, and Scope)
- Data: (Constructor, Dispose, Finalizer, Property, Verbose, and WriteLine)
- Errors: (Error and Exception).

To specify multiple options, separate them with commas, but with no spaces, and enclose them in quotation marks, such as "Constructor,Dispose".

```yaml
Type: System.Management.Automation.PSTraceSourceOptions
Parameter Sets: optionsSet
Aliases:
Accepted values: None, Constructor, Dispose, Finalizer, Method, Property, Delegates, Events, Exception, Lock, Error, Errors, Warning, Verbose, WriteLine, Data, Scope, ExecutionFlow, Assert, All

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: optionsSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PSHost

ndicates that this cmdlet sends the trace output to the PowerShell host.
This parameter also selects the PSHost trace listener.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: optionsSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveFileListener

Stops the trace by removing the file trace listener associated with the specified file.
Enter the path and file name of the trace output file.

```yaml
Type: System.String[]
Parameter Sets: removeFileListenersSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveListener

Stops the trace by removing the trace listener.

Use the following values with *RemoveListener*:

- To remove PSHost (console), type `Host`.
- To remove Debugger, type `Debug`.
- To remove all trace listeners, type `*`.

To remove the file trace listener, use the *RemoveFileListener* parameter.

```yaml
Type: System.String[]
Parameter Sets: removeAllListenersSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a name to **Set-TraceSource**.

## OUTPUTS

### None or System.Management.Automation.PSTraceSource

When you use the *PassThru* parameter, **Set-TraceSource** generates a **System.Management.Automation.PSTraceSource** object representing the trace session.
Otherwise, this cmdlet does not generate any output.

## NOTES

* Tracing is a method that developers use to debug and refine programs. When tracing, the program generates detailed messages about each step in its internal processing.

  The PowerShell tracing cmdlets are designed to help PowerShell developers, but they are available to all users.
They let you monitor nearly every aspect of the functionality of PowerShell.

  A trace source is the part of each PowerShell component that manages tracing and generates trace messages for the component.
To trace a component, you identify its trace source.

  A trace listener receives the output of the trace and displays it to the user.
You can elect to send the trace data to a user-mode or kernel-mode debugger, to the console, to a file, or to a custom listener derived from the **System.Diagnostics.TraceListener** class.

* To start a trace, use the *Name* parameter to specify a trace source and the *FilePath*, *Debugger*, or *PSHost* parameters to specify a listener (a destination for the output). Use the *Options* parameter to determine the types of events that are traced and the *ListenerOption* parameter to configure the trace output.
* To change the configuration of a trace, enter a **Set-TraceSource** command as you would to start a trace. PowerShell recognizes that the trace source is already being traced. It stops the trace, adds the new configuration, and starts or restarts the trace.
* To stop a trace, use the *RemoveListener* parameter. To stop a trace that uses the file listener (a trace started by using the *FilePath* parameter), use the *RemoveFileListener* parameter. When you remove the listener, the trace stops.
* To determine which components can be traced, use Get-TraceSource. The trace sources for each module are loaded automatically when the component is in use, and they appear in the output of **Get-TraceSource**.

## RELATED LINKS

[Get-TraceSource](Get-TraceSource.md)

[Trace-Command](Trace-Command.md)

