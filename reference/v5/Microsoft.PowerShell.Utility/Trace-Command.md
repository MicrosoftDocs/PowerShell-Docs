---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294020
schema: 2.0.0
---

# Trace-Command
## SYNOPSIS
Configures and starts a trace of the specified expression or command.

## SYNTAX

### expressionSet (Default)
```
Trace-Command [-InputObject <PSObject>] [-Name] <String[]> [[-Option] <PSTraceSourceOptions>]
 [-Expression] <ScriptBlock> [-ListenerOption <TraceOptions>] [-FilePath <String>] [-Force] [-Debugger]
 [-PSHost] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

### commandSet
```
Trace-Command [-InputObject <PSObject>] [-Name] <String[]> [[-Option] <PSTraceSourceOptions>]
 [-Command] <String> [-ArgumentList <Object[]>] [-ListenerOption <TraceOptions>] [-FilePath <String>] [-Force]
 [-Debugger] [-PSHost] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Trace-Command cmdlet configures and starts a trace of the specified expression or command.
It works like Set-TraceSource, except that it applies only to the specified command.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>trace-command -name metadata,parameterbinding,cmdlet -expression {get-process notepad} -pshost
```

This command starts a trace of metadata processing, parameter binding, and cmdlet creation and destruction of the "get-process notepad" expression.
It uses the Name parameter to specify the trace sources, the Expression parameter to specify the command, and the PSHost parameter to send the output to the console.
Because it does not specify any tracing options or listener options, the command uses the defaults, "All" for the tracing options, and "None" for the listener options.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$a = "i*"
PS C:\>trace-command parameterbinding {get-alias $input} -pshost -inputobject $a
```

These commands trace the actions of the ParameterBinding operations of Windows PowerShell while it processes a Get-Alias expression that takes input from the pipeline.

In Trace-Command, the InputObject parameter passes an object to the expression that is being processed during the trace.

The first command stores the string "i*" in the $a variable.
The second command uses the Trace-Command cmdlet with the ParameterBinding trace source.
The PSHost parameter sends the output to the console.

The expression being processed is "get-alias $input", where the $input variable is associated with the InputObject parameter.
The InputObject parameter passes the variable $a to the expression.
In effect, the command being processed during the trace is "get-alias -inputobject $a" or "$a | get-alias".

## PARAMETERS

### -ArgumentList
Specifies the parameters and parameter values for the command being traced.
The alias for ArgumentList is Args.
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Debugger
Sends the trace output to the debugger.
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Sends the trace output to the specified file.
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
Allows the cmdlet to append trace information to a read-only file.
Used with the FilePath parameter.
Even using the Force parameter, the cmdlet cannot override security restrictions.

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

### -InputObject
Provides input to the expression that is being processed during the trace.

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
Adds optional data to the prefix of each trace message in the output.
The valid values are None, LogicalOperationStack, DateTime, Timestamp, ProcessId, ThreadId, and Callstack.
"None" is the default.

To specify multiple options, separate them with commas, but with no spaces, and enclose them in quotation marks, such as "ProcessID,ThreadID".

```yaml
Type: TraceOptions
Parameter Sets: (All)
Aliases: 
Accepted values: None, Constructor, Dispose, Finalizer, Method, Property, Delegates, Events, Exception, Lock, Error, Errors, Warning, Verbose, WriteLine, Data, Scope, ExecutionFlow, Assert, All

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Determines which Windows PowerShell components are traced.
Enter the name of the trace source of each component.
Wildcards are permitted.
To find the trace sources on your computer, type "Get-TraceSource".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Option
Determines the type of events that are traced.

The valid values are None, Constructor, Dispose, Finalizer, Method, Property, Delegates, Events, Exception, Lock, Error, Errors, Warning, Verbose, WriteLine, Data, Scope, ExecutionFlow, Assert, and All.
"All" is the default.

The following values are combinations of other values:

-- ExecutionFlow: (Constructor, Dispose, Finalizer, Method, Delegates, Events, and Scope)
-- Data: (Constructor, Dispose, Finalizer, Property, Verbose, and WriteLine)
-- Errors: (Error and Exception).

To specify multiple options, separate them with commas, but with no spaces, and enclose them in quotation marks, such as "Constructor,Dispose".

```yaml
Type: PSTraceSourceOptions
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PSHost
Sends the trace output to the Windows PowerShell host.
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

## INPUTS

### System.Management.Automation.PSObject
You can pipe objects that represent input to the expression to Trace-Command.

## OUTPUTS

### System.Management.Automation.PSObject
Returns the command trace in the debug stream.

## NOTES
Tracing is a method that developers use to debug and refine programs.
When tracing, the program generates detailed messages about each step in its internal processing.

The Windows PowerShell tracing cmdlets are designed to help Windows PowerShell developers, but they are available to all users.
They let you monitor nearly every aspect of the functionality of the shell.

To find the Windows PowerShell components that are enabled for tracing, type "Get-Help Get-TraceSource."

A "trace source" is the part of each Windows PowerShell component that manages tracing and generates trace messages for the component.
To trace a component, you identify its trace source.

A "trace listener" receives the output of the trace and displays it to the user.
You can elect to send the trace data to a user-mode or kernel-mode debugger, to the host or console, to a file, or to a custom listener derived from the System.Diagnostics.TraceListener class.

When you use the Command parameter set, Windows PowerShell processes the command just as it would be processed in a pipeline.
For example, command discovery is not repeated for each incoming object.

The names of the Name, Expression, Option, and Command parameters are optional.
If you omit the parameter names, the unnamed parameter values must appear in this order: Name, Expression, Option or Name, Command,-Option .
If you include the parameter names, the parameters can appear in any order.

## RELATED LINKS

[Get-TraceSource]()

[Set-TraceSource]()

