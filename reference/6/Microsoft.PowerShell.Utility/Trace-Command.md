---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821866
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Trace-Command
---

# Trace-Command

## SYNOPSIS
Configures and starts a trace of the specified expression or command.

## SYNTAX

### expressionSet (Default)
```powershell
Trace-Command [-Name] <String[]> [-Expression] <ScriptBlock>
 [[-Option] <PSTraceSourceOptions>] [-InputObject <PSObject>]
 [-ListenerOption <TraceOptions>] [-FilePath <String>] [-Force]
 [-Debugger] [-PSHost] [<CommonParameters>]
```

### commandSet
```powershell
Trace-Command [-Name] <String[]> [-Command] <String>
 [[-Option] <PSTraceSourceOptions>] [-InputObject <PSObject>]
 [-ArgumentList <Object[]>]
 [-ListenerOption <TraceOptions>] [-FilePath <String>] [-Force]
 [-Debugger] [-PSHost] [<CommonParameters>]
```

## DESCRIPTION
The **Trace-Command** cmdlet configures and starts a trace of the specified expression or command.
It works like Set-TraceSource, except that it applies only to the specified command.

## EXAMPLES

### Example 1: Trace metadata processing, parameter binding, and an expression
```
PS C:\> Trace-Command -Name metadata,parameterbinding,cmdlet -Expression {Get-Process Notepad} -PSHost
```

This command starts a trace of metadata processing, parameter binding, and cmdlet creation and destruction of the `Get-Process Notepad` expression.
It uses the *Name* parameter to specify the trace sources, the *Expression* parameter to specify the command, and the *PSHost* parameter to send the output to the console.
Because it does not specify any tracing options or listener options, the command uses the defaults--All for the tracing options, and None for the listener options.

### Example 2: Trace the actions of ParameterBinding operations
```
PS C:\> $A = "i*"
PS C:\> Trace-Command ParameterBinding {Get-Alias $Input} -PSHost -InputObject $A
```

These commands trace the actions of the ParameterBinding operations of Windows PowerShell while it processes a Get-Alias expression that takes input from the pipeline.

In **Trace-Command**, the *InputObject* parameter passes an object to the expression that is being processed during the trace.

The first command stores the string "i*" in the $A variable.
The second command uses the **Trace-Command** cmdlet with the ParameterBinding trace source.
The *PSHost* parameter sends the output to the console.

The expression being processed is `Get-Alias $Input`, where the $Input variable is associated with the *InputObject* parameter.
The *InputObject* parameter passes the variable $A to the expression.
In effect, the command being processed during the trace is `Get-Alias -InputObject $A" or "$A | Get-Alias`.

## PARAMETERS

### -ArgumentList
Specifies the parameters and parameter values for the command being traced.
The alias for *ArgumentList* is *Args*.
This feature is especially useful for debugging dynamic parameters.

```yaml
Type: Object[]
Parameter Sets: commandSet
Aliases: Args

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Command
Specifies a command that is being processed during the trace.

```yaml
Type: String
Parameter Sets: commandSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Debugger
Indicates that the cmdlet sends the trace output to the debugger.
You can view the output in any user-mode or kernel mode debugger or in Visual Studio.
This parameter also selects the default trace listener.

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

### -Expression
Specifies the expression that is being processed during the trace.
Enclose the expression in braces ({}).

```yaml
Type: ScriptBlock
Parameter Sets: expressionSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Specifies a file that the cmdlet sends the trace output to.
This parameter also selects the file trace listener.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PSPath

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the command to run without asking for user confirmation.
Used with the *FilePath* parameter.
Even using the *Force* parameter, the cmdlet cannot override security restrictions.

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

### -InputObject
Specifies input to the expression that is being processed during the trace.

You can enter a variable that represents the input that the expression accepts, or pass an object through the pipeline.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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
Type: TraceOptions
Parameter Sets: (All)
Aliases:
Accepted values: None, LogicalOperationStack, DateTime, Timestamp, ProcessId, ThreadId, Callstack

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies an array of Windows PowerShell components that are traced.
Enter the name of the trace source of each component.
Wildcards are permitted.
To find the trace sources on your computer, type `Get-TraceSource`.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Option
Determines the type of events that are traced.
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
Type: PSTraceSourceOptions
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PSHost
Indicates that the cmdlet sends the trace output to the Windows PowerShell host.
This parameter also selects the PSHost trace listener.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject
You can pipe objects that represent input to the expression to **Trace-Command**.

## OUTPUTS

### System.Management.Automation.PSObject
Returns the command trace in the debug stream.

## NOTES
* Tracing is a method that developers use to debug and refine programs. When tracing, the program generates detailed messages about each step in its internal processing.
* The Windows PowerShell tracing cmdlets are designed to help Windows PowerShell developers, but they are available to all users. They let you monitor nearly every aspect of the functionality of the shell.
* To find the Windows PowerShell components that are enabled for tracing, type `Get-Help Get-TraceSource`.

  A trace source is the part of each Windows PowerShell component that manages tracing and generates trace messages for the component.
To trace a component, you identify its trace source.

  A trace listener receives the output of the trace and displays it to the user.
You can elect to send the trace data to a user-mode or kernel-mode debugger, to the host or console, to a file, or to a custom listener derived from the **System.Diagnostics.TraceListener** class.

* When you use the commandSet parameter set, Windows PowerShell processes the command just as it would be processed in a pipeline. For example, command discovery is not repeated for each incoming object.
* The names of the *Name*, *Expression*, *Option*, and *Command* parameters are optional. If you omit the parameter names, the unnamed parameter values must appear in this order: *Name*, *Expression*, *Option* or *Name*, *Command*, *Option*. If you include the parameter names, the parameters can appear in any order.

## RELATED LINKS

[Get-TraceSource](Get-TraceSource.md)

[Measure-Command](Measure-Command.md)

[Set-TraceSource](Set-TraceSource.md)

[Show-Command](https://msdn.microsoft.com/en-us/powershell/reference/5.1/Microsoft.PowerShell.Utility/Show-Command)