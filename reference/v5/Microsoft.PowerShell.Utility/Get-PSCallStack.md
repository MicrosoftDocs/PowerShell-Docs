---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293973
schema: 2.0.0
---

# Get-PSCallStack
## SYNOPSIS
Displays the current call stack.

## SYNTAX

```
Get-PSCallStack [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Get-PSCallStack cmdlet displays the current call stack.

Although it is designed to be used with the Windows PowerShell debugger, you can use this cmdlet to display the call stack in a script or function outside of the debugger.

To run a Get-PSCallStack command while in the debugger, type "k" or "get-pscallstack".

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>function my-alias {
$p = $args[0]
get-alias | where {$_.definition -like "*$p"} | ft definition, name -auto
}
PS C:\ps-test> set-psbreakpoint -command my-alias

Command    : my-alias
Action     :
Enabled    : True
HitCount   : 0
Id         : 0
Script     : prompt

PS C:\ps-test> my-alias get-content

Entering debug mode. Use h or ? for help.
Hit Command breakpoint on 'prompt:my-alias'
my-alias get-content
[DBG]: PS C:\ps-test> s
$p = $args[0]
DEBUG: Stepped to ':    $p = $args[0]    '
[DBG]: PS C:\ps-test> s
get-alias | Where {$_.Definition -like "*$p*"} | ft Definition,
[DBG]: PS C:\ps-test>get-pscallstack
Name        CommandLineParameters         UnboundArguments              Location
----        ---------------------         ----------------              --------
prompt      {}                            {}                            prompt
my-alias    {}                            {get-content}                 prompt
prompt      {}                            {}                            prompt
[DBG]: PS C:\ps-test> o
Definition  Name
----------  ----
Get-Content gc
Get-Content cat
Get-Content type
```

Description

-----------

This command uses the Get-PSCallStack cmdlet to display the call stack for My-Alias, a simple function that gets the aliases for a cmdlet name.

The first command enters the function at the Windows PowerShell prompt.
The second command uses the Set-PSBreakpoint cmdlet to set a breakpoint on the My-Alias function.
The third command uses the My-Alias function to get all of the aliases in the current session for the Get-Content cmdlet.

The debugger breaks in at the function call.
Two consecutive step-into (s) commands begin executing the function line by line.
Then, a Get-PSCallStack command is used to retrieve the call stack.

The final command is a Step-Out command (o) that exits the debugger and continues executing the script to completion.

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

## INPUTS

### None
You cannot pipe objects to this cmdlet.

## OUTPUTS

### System.Management.Automation.CallStackFrame
Get-PSCallStack returns an object that represents the items in the call stack.

## NOTES

## RELATED LINKS

[Disable-PSBreakpoint]()

[Enable-PSBreakpoint]()

[Get-PSBreakpoint]()

[Remove-PSBreakpoint]()

[Set-PSBreakpoint]()

[about_Debuggers]()

