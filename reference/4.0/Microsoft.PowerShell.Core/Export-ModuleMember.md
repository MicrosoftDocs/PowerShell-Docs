---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=289581
external help file:  System.Management.Automation.dll-Help.xml
title:  Export-ModuleMember
---

# Export-ModuleMember

## SYNOPSIS
Specifies the module members that are exported.

## SYNTAX

```
Export-ModuleMember [[-Function] <String[]>] [-Cmdlet <String[]>] [-Variable <String[]>] [-Alias <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
The Export-ModuleMember cmdlet specifies the module members (such as cmdlets, functions, variables, and aliases) that are exported from a script module (.psm1) file, or from a dynamic module created by using the New-Module cmdlet.
This cmdlet can be used only in a script module file or a dynamic module.

If a script module does not include an Export-ModuleMember command, the functions in the script module are exported, but the variables and aliases are not.
When a script module includes Export-ModuleMember commands, only the members specified in the Export-ModuleMember commands are exported.
You can also use Export-ModuleMember to suppress or export members that the script module imports from other modules.

An Export-ModuleMember command is optional, but it is a best practice.
Even if the command confirms the default values, it demonstrates the intention of the module author.

## EXAMPLES

### Example 1
```
PS C:\> Export-ModuleMember -function * -alias *
```

This command exports the aliases defined in the script module, along with the functions defined in the script module.

To export the aliases, which are not exported by default, you must also explicitly specify the functions.
Otherwise, only the aliases will be exported.

### Example 2
```
PS C:\> Export-ModuleMember -function Get-Test, New-Test, Start-Test -alias gtt, ntt, stt
```

This command exports three aliases and three functions defined in the script module.

You can use this command format to specify the names of module members.

### Example 3
```
PS C:\> Export-ModuleMember
```

This command specifies that no members defined in the script module are exported.

This command prevents the module members from being exported, but it does not hide the members.
Users can read and copy module members or use the call operator (&) to invoke module members that are not exported.

### Example 4
```
PS C:\> Export-ModuleMember -variable increment
```

This command exports only the $increment variable from the script module.
No other members are exported.

If you want to export a variable, in addition to exporting the functions in a module, the Export-ModuleMember command must include the names of all of the functions and the name of the variable.

### Example 5
```
PS C:\> # From TestModule.psm1
function new-test
   { <function code> }
export-modulemember -function new-test
function validate-test
   { <function code> }
function start-test
   { <function code> }
set-alias stt start-test
export-modulemember -function *-test -alias stt
```

These commands show how multiple Export-ModuleMember commands are interpreted in a script module (.psm1) file.

These commands create three functions and one alias, and then they export two of the functions and the alias.

Without the Export-ModuleMember commands, all three of the functions would be exported, but the alias would not be exported.
With the Export-ModuleMember commands, only the Get-Test and Start-Test functions and the STT alias are exported.

### Example 6
```
PS C:\> new-module -script {function SayHello {"Hello!"}; set-alias Hi SayHello; Export-ModuleMember -alias Hi -function SayHello}
```

This command shows how to use Export-ModuleMember in a dynamic module that is created by using the New-Module cmdlet.

In this example, Export-ModuleMember is used to export both the "Hi" alias and the "SayHello" function in the dynamic module.

### Example 7
```
PS C:\> function export
{
  param ([parameter(mandatory=$true)] [validateset("function","variable")] $type,
  [parameter(mandatory=$true)] $name,
  [parameter(mandatory=$true)] $value)
  if ($type -eq "function")
   {
     Set-item "function:script:$name" $value
     Export-ModuleMember $name
   }
else
   {
     Set-Variable -scope Script $name $value
     Export-ModuleMember -variable $name
   }
}
export function New-Test
   {
...
   }
function helper
{
...
}
export variable interval 0
$interval = 2
```

This example includes a function named Export that declares a function or creates a variable, and then writes an Export-ModuleMember command for the function or variable.
This lets you declare and export a function or variable in a single command.

To use the Export function, include it in your script module.
To export a function, type "Export" before the Function keyword.

To export a variable, use the following format to declare the variable and set its value:

export variable \<variable-name\> \<value\>

The commands in the example show the correct format.
In this example, only the New-Test function and the $Interval variable are exported.

## PARAMETERS

### -Alias
Specifies the aliases that are exported from the script module file.
Enter the alias names.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Cmdlet
Specifies the cmdlets that are exported from the script module file.
Enter the cmdlet names.
Wildcards are permitted.

You cannot create cmdlets in a script module file, but you can import cmdlets from a binary module into a script module and re-export them from the script module.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Function
Specifies the functions that are exported from the script module file.
Enter the function names.
Wildcards are permitted.
You can also pipe function name strings to Export-ModuleMember.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Variable
Specifies the variables that are exported from the script module file.
Enter the variable names (without a dollar sign).
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe function name strings to Export-ModuleMember.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
* To exclude a member from the list of exported members, add an Export-ModuleMember command that lists all other members but omits the member that you want to exclude.

*

## RELATED LINKS

[Get-Module](Get-Module.md)

[Import-Module](Import-Module.md)

[Remove-Module](Remove-Module.md)

[about_Modules](About/about_Modules.md)

