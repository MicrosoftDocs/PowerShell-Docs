---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293973
schema: 2.0.0
---

# Get-PSCallStack
## SYNOPSIS
Displays the current call stack.

## SYNTAX

```
Get-PSCallStack
```

## DESCRIPTION
The Get-PSCallStack cmdlet displays the current call stack.

Although it is designed to be used with the Windows PowerShell debugger, you can use this cmdlet to display the call stack in a script or function outside of the debugger.

To run a Get-PSCallStack command while in the debugger, type k or get-pscallstack.

## EXAMPLES

### Example 1: Get the call stack for a function
```
PS C:\>function my-alias {
$p = $args[0]
Get-Alias | where {$_.definition -like "*$p"} | format-table definition, name -auto
}
PS C:\ps-test> Set-PSBreakpoint -Command my-alias
Command    : my-alias
Action     : 
Enabled    : True
HitCount   : 0
Id         : 0
Script     : prompt PS C:\>my-alias Get-Content

Entering debug mode. Use h or ? for help.
Hit Command breakpoint on 'prompt:my-alias'
my-alias get-content
[DBG]: PS C:\ps-test> s
$p = $args[0]
DEBUG: Stepped to ':    $p = $args[0]    '
[DBG]: PS C:\ps-test> s
get-alias | Where {$_.Definition -like "*$p*"} | format-table Definition,
[DBG]: PS C:\ps-test>get-pscallstack

Name        CommandLineParameters         UnboundArguments              Location
----        ---------------------         ----------------              --------
prompt      {}                            {}                            prompt
my-alias    {}                            {get-content}                 prompt
prompt      {}                            {}                            prompt PS C:\>[DBG]: PS C:\ps-test> o
Definition  Name
----------  ----
Get-Content gc
Get-Content cat
Get-Content type
```

This command uses the Get-PSCallStack cmdlet to display the call stack for My-Alias, a simple function that gets the aliases for a cmdlet name.

The first command enters the function at the Windows PowerShell prompt.
The second command uses the Set-PSBreakpoint cmdlet to set a breakpoint on the My-Alias function.
The third command uses the My-Alias function to get all of the aliases in the current session for the Get-Content cmdlet.

The debugger breaks in at the function call.
Two consecutive step-into (s) commands begin executing the function line by line.
Then, a Get-PSCallStack command is used to retrieve the call stack.

The final command is a Step-Out command (o) that exits the debugger and continues executing the script to completion.

## PARAMETERS

## INPUTS

### None
You cannot pipe objects to this cmdlet.

## OUTPUTS

### System.Management.Automation.CallStackFrame
Get-PSCallStack returns an object that represents the items in the call stack.

## NOTES

## RELATED LINKS

[Disable-PSBreakpoint](d4974e9b-0aaa-4e20-b87f-f599a413e4e8)

[Enable-PSBreakpoint](739e1091-3b3f-405f-a428-bec7543e5df0)

[Format-Table](2b56a2d0-c067-40e4-b744-979fbaf847e2)

[Get-PSBreakpoint](0bf48936-00ab-411c-b5e0-9b10a812a3c6)

[Remove-PSBreakpoint](4c877a80-0ea0-4790-9281-88c08ef0ddd6)

[Set-PSBreakpoint](6afd5d2c-a285-4796-8607-3cbf49471420)

[Where-Object](6a70160b-cf62-48df-ae5b-0a9b173013b4)

[about_Debuggers](2b2ce8b3-f881-4528-bd30-f453dea06755)

