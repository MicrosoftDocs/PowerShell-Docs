---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294013
schema: 2.0.0
---

# Set-PSBreakpoint
## SYNOPSIS
Sets a breakpoint on a line, command, or variable.

## SYNTAX

### Line (Default)
```
Set-PSBreakpoint [-Action <ScriptBlock>] [[-Column] <Int32>] [-Line] <Int32[]> [-Script] <String[]>
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

### Command
```
Set-PSBreakpoint [-Action <ScriptBlock>] -Command <String[]> [[-Script] <String[]>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

### Variable
```
Set-PSBreakpoint [-Action <ScriptBlock>] [[-Script] <String[]>] -Variable <String[]>
 [-Mode <VariableAccessMode>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Set-PSBreakpoint cmdlet sets a breakpoint in a script or in any command run in the current session. 
You can use Set-PSBreakpoint to set a breakpoint before executing a script or running a command, or during debugging, when stopped at another breakpoint.

Note: Set-PSBreakpoint cannot set a breakpoint on a remote computer.
To debug a script on a remote computer, copy the script to the local computer and then debug it locally.

Each Set-PSBreakpoint command creates one of the following three types of breakpoints:

-- Line breakpoint:  Sets breakpoints at particular line and column coordinates.
-- Command breakpoint:  Sets breakpoints on commands and functions.
-- Variable breakpoint: Sets breakpoints on variables.

You can set a breakpoint on multiple lines, commands, or variables in a single Set-PSBreakpoint command, but each Set-PSBreakpoint command sets only one type of breakpoint.

At a breakpoint, Windows PowerShell temporarily stops executing and gives control to the debugger.
The command prompt changes to "DBG\>", and a set of debugger commands become available for use.
However, you can use the Action parameter to specify an alternate response, such as conditions for the breakpoint or instructions to perform additional tasks such as logging or diagnostics.

The Set-PSBreakpoint cmdlet is one of several cmdlets designed for debugging Windows PowerShell scripts.
For more information about the Windows PowerShell debugger, see about_Debuggers.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>set-psbreakpoint -script sample.ps1 -line 5
Column     : 0
Line       : 5
Action     :
Enabled    : True
HitCount   : 0
Id         : 0
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1
```

This command sets a breakpoint at line 5 in the Sample.ps1 script.
As a result, when the script runs, execution stops immediately before line 5 would execute.

When you set a new breakpoint by line number, the Set-PSBreakpoint cmdlet generates a line breakpoint object (System.Management.Automation.LineBreakpoint) that includes the breakpoint ID and hit count, as shown in the following sample output.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>set-psbreakpoint -command Increment -script sample.ps1
Command    : Increment
Action     :
Enabled    : True
HitCount   : 0
Id         : 1
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1
```

This command creates a command breakpoint on the Increment function in the Sample.ps1 cmdlet.
The script stops executing immediately before each call to the specified function.

The result is a command breakpoint object.
Before the script runs, the value of the HitCount property is 0.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>set-psbreakpoint -script sample.ps1 -variable Server -Mode ReadWrite
```

This command sets a breakpoint on the Server variable in the Sample.ps1 script.
It uses the Mode parameter with a value of ReadWrite to stop execution when the value of the variable is read and just before the value changes.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>set-psbreakpoint -script Sample.ps1 -command "write*"
```

This command sets a breakpoint on every command in the Sample.ps1 script that begins with "write", such as "write-host".

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>set-psbreakpoint -script test.ps1 -command DiskTest `
-action { if ($disk -gt 2) { break } }
```

This command stops execution at the DiskTest function in the Test.ps1 script only when the value of the $disk variable is greater than 2.

It uses the Set-PSBreakpoint cmdlet to set a command breakpoint on the DiskTest function.
The value of the action is a script block that tests the value of the $disk variable in the function.

The action uses the BREAK keyword to stop execution if the condition is met.
The alternative (and the default) is CONTINUE.

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>set-psbreakpoint -command checklog

Id       : 0
Command  : checkkog
Enabled  : True
HitCount : 0
Action   :

PS C:\>function CheckLog {
>> get-eventlog -log Application |
>> where {($_.source -like "TestApp") -and ($_.Message -like "*failed*")}
>>}
>>
PS C:\>Checklog
DEBUG: Hit breakpoint(s)
DEBUG:  Function breakpoint on 'prompt:Checklog'
PS C:\>>>
```

This command sets a breakpoint on the CheckLog function.
Because the command does not specify a script, the breakpoint is set on anything that runs in the current session.
The debugger breaks when the function is called, not when it is declared.

### -------------------------- EXAMPLE 7 --------------------------
```
PS C:\>set-psbreakpoint -script sample.ps1 -line 1, 14, 19 -column 2 -action {&(log.ps1)}

Column     : 2
Line       : 1
Action     :
Enabled    : True
HitCount   : 0
Id         : 6
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1

Column     : 2
Line       : 14
Action     :
Enabled    : True
HitCount   : 0
Id         : 7
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1

Column     : 2
Line       : 19
Action     :
Enabled    : True
HitCount   : 0
Id         : 8
Script     : C:\ps-test\sample.ps1
ScriptName : C:\ps-test\sample.ps1
```

This command sets three line breakpoints in the Sample.ps1 script.
It sets one breakpoint at column 2 on each of the lines specified in the script.
The action specified in the Action parameter applies to all breakpoints.

## PARAMETERS

### -Action
Specifies commands that run at each breakpoint instead of breaking.
Enter a script block that contains the commands.
You can use this parameter to set conditional breakpoints or to perform other tasks, such as testing or logging.

If this parameter is omitted, or no action is specified, execution stops at the breakpoint, and the debugger starts.

When the Action parameter is used, the Action script block runs at each breakpoint.
Execution does not stop unless the script block includes the Break keyword.
If you use the Continue keyword in the script block, execution resumes until the next breakpoint.

For more information, see about_Script_Blocks, about_Break, and about_Continue.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Column
Specifies the column number of the column in the script file on which execution stops.
Enter only one column number.
The default is column 1.

The Column value is used with the value of the Line parameter to specify the breakpoint.
If the Line parameter specifies multiple lines, the Column parameter sets a breakpoint at the specified column on each of the specified lines.
Windows PowerShell stops executing before the statement or expression that includes the character at the specified line and column position.

Columns are counted from the top left margin beginning with column number 1 (not 0).
If you specify a column that does not exist in the script, an error is not declared, but the breakpoint is never executed.

```yaml
Type: Int32
Parameter Sets: Line
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Command
Sets a command breakpoint.
Enter cmdlet names, such as "Get-Process" or function names.
Wildcards are permitted.

Execution stops just before each instance of each command is executed.
If the command is a function, execution stops each time the function is called and at each BEGIN, PROCESS, and END section.

```yaml
Type: String[]
Parameter Sets: Command
Aliases: C

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
If this parameter is omitted, or no action is specified, execution stops at the breakpoint, and the debugger starts.

When the Action parameter is used, the Action script block runs at each breakpoint.
Execution does not stop unless the script block includes the Break keyword.
If you use the Continue keyword in the script block, execution resumes until the next breakpoint.

For more information, see about_Script_Blocks, about_Break, and about_Continue.

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
If this parameter is omitted, or no action is specified, execution stops at the breakpoint, and the debugger starts.

When the Action parameter is used, the Action script block runs at each breakpoint.
Execution does not stop unless the script block includes the Break keyword.
If you use the Continue keyword in the script block, execution resumes until the next breakpoint.

For more information, see about_Script_Blocks, about_Break, and about_Continue.

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

### -Line
Sets a line breakpoint in a script.
Enter one or more line numbers, separated by commas.
Windows PowerShell stops immediately before executing the statement that begins on each of the specified lines.

Lines are counted from the top left margin of the script file beginning with line number 1 (not 0).
If you specify a blank line, execution stops before the next non-blank line.
If the line is out of range, the breakpoint is never hit.

```yaml
Type: Int32[]
Parameter Sets: Line
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mode
Determines the mode of access that triggers variable breakpoints.
The default is Write.

This parameter is valid only when the Variable parameter is used in the command.
The mode applies to all breakpoints set in the command.

Valid values are:

-- Write: Stops execution immediately before a new value is written to the variable.
--  Read: Stops execution when the variable is read, that is, when its value is accessed, either to be assigned, displayed, or used. In read mode, execution does not stop when the value of the variable changes.
--  ReadWrite: Stops execution when the variable is read or written.

```yaml
Type: VariableAccessMode
Parameter Sets: Variable
Aliases: 
Accepted values: Read, Write, ReadWrite

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Script
Sets a breakpoint in each of the specified script files.
Enter the paths and file names of one or more script files.
If the files are in the current directory, you can omit the path.
Wildcards are permitted.

By default, variable breakpoints and command breakpoints are set on any command that runs in the current session.
This parameter is required only when setting a line breakpoint.

```yaml
Type: String[]
Parameter Sets: Line
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String[]
Parameter Sets: Command, Variable
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Variable
Sets a variable breakpoint.
Enter a comma-separated list of variables without dollar signs ($).

Use the Mode parameters to determine the mode of access that triggers the breakpoints.
The default mode, Write, stops execution just before a new value is written to the variable.

```yaml
Type: String[]
Parameter Sets: Variable
Aliases: V

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to Set-PSBreakpoint.

## OUTPUTS

### Breakpoint object (System.Management.Automation.LineBreakpoint, System.Management.Automation.VariableBreakpoint, System.Management.Automation.CommandBreakpoint)
Set-PSBreakpoint returns an object that represents each breakpoint that it sets.

## NOTES
Set-PSBreakpoint cannot set a breakpoint on a remote computer.
To debug a script on a remote computer, copy the script to the local computer and then debug it locally.

When you set a breakpoint on more than one line, command, or variable, Set-PSBreakpoint generates a breakpoint object for each entry.

When setting a breakpoint on a function or variable at the command prompt, you can set the breakpoint before or after you create the function or variable.

## RELATED LINKS

[Disable-PSBreakpoint]()

[Enable-PSBreakpoint]()

[Get-PSBreakpoint]()

[Get-PSCallStack]()

[Remove-PSBreakpoint]()

[about_Debuggers]()

