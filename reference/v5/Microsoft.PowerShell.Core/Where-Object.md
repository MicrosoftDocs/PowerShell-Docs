---
external help file: PSITPro5_Core.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289623
schema: 2.0.0
---

# Where-Object
## SYNOPSIS
Selects objects from a collection based on their property values.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Where-Object [-Property] <String> [[-Value] <Object>] [-EQ] [-InputObject <PSObject>]
```

### UNNAMED_PARAMETER_SET_2
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-Contains]
```

### UNNAMED_PARAMETER_SET_3
```
Where-Object [-FilterScript] <ScriptBlock> [-InputObject <PSObject>]
```

### UNNAMED_PARAMETER_SET_4
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-GE]
```

### UNNAMED_PARAMETER_SET_5
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-GT]
```

### UNNAMED_PARAMETER_SET_6
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-In]
```

### UNNAMED_PARAMETER_SET_7
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CContains]
```

### UNNAMED_PARAMETER_SET_8
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CEQ]
```

### UNNAMED_PARAMETER_SET_9
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CGE]
```

### UNNAMED_PARAMETER_SET_10
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CGT]
```

### UNNAMED_PARAMETER_SET_11
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CIn]
```

### UNNAMED_PARAMETER_SET_12
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CLE]
```

### UNNAMED_PARAMETER_SET_13
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CLike]
```

### UNNAMED_PARAMETER_SET_14
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CLT]
```

### UNNAMED_PARAMETER_SET_15
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CMatch]
```

### UNNAMED_PARAMETER_SET_16
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CNE]
```

### UNNAMED_PARAMETER_SET_17
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CNotContains]
```

### UNNAMED_PARAMETER_SET_18
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CNotIn]
```

### UNNAMED_PARAMETER_SET_19
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CNotLike]
```

### UNNAMED_PARAMETER_SET_20
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-CNotMatch]
```

### UNNAMED_PARAMETER_SET_21
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-Is]
```

### UNNAMED_PARAMETER_SET_22
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-IsNot]
```

### UNNAMED_PARAMETER_SET_23
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-LE]
```

### UNNAMED_PARAMETER_SET_24
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-Like]
```

### UNNAMED_PARAMETER_SET_25
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-LT]
```

### UNNAMED_PARAMETER_SET_26
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-Match]
```

### UNNAMED_PARAMETER_SET_27
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-NE]
```

### UNNAMED_PARAMETER_SET_28
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-NotContains]
```

### UNNAMED_PARAMETER_SET_29
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-NotIn]
```

### UNNAMED_PARAMETER_SET_30
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-NotLike]
```

### UNNAMED_PARAMETER_SET_31
```
Where-Object [-Property] <String> [[-Value] <Object>] [-InputObject <PSObject>] [-NotMatch]
```

## DESCRIPTION
The Where-Object cmdlet selects objects that have particular property values from the collection of objects that are passed to it.
For example, you can use the Where-Object cmdlet to select files that were created after a certain date, events with a particular ID, or computers that use a particular version of Windows.

Starting in Windows PowerShell 3.0, there are two different ways to construct a Where-Object command.

Script block.
You can use a script block to specify the property name, a comparison operator, and a property value.
Where-Object returns all objects for which the script block statement is true.

For example, the following command gets processes in the Normal priority class, that is, processes where the value of the PriorityClass property equals Normal.

Get-Process | Where-Object {$_.PriorityClass -eq "Normal"}

All Windows PowerShell comparison operators are valid in the script block format.
For more information about comparison operators, see about_Comparison_Operators (http://go.microsoft.com/fwlink/?LinkID=113217).

Comparison statement.
You can also write a comparison statement, which is much more like natural language.
Comparison statements were introduced in Windows PowerShell 3.0.

For example, the following commands also get processes that have a priority class of Normal.
These commands are equivalent and can be used interchangeably.

Get-Process | Where-Object -Property PriorityClass -eq -Value "Normal"

Get-Process | Where-Object PriorityClass -eq "Normal"

Starting in Windows PowerShell 3.0, Where-Object adds comparison operators as parameters in a Where-Object command.
Unless specified, all operators are case-insensitive.
Prior to Windows PowerShell 3.0, the comparison operators in the Windows PowerShell language could be used only in script blocks.

## EXAMPLES

### Example 1: Get stopped services
```
PS C:\>Get-Service | Where-Object {$_.Status -eq "Stopped"}
PS C:\> Get-Service | where Status -eq "Stopped"
```

This command gets a list of all services that are currently stopped.
The $_ symbol represents each object that is passed to the Where-Object cmdlet.

The first command uses the script block format.
The second command uses the comparison statement format.
The commands are equivalent and can be used interchangeably.

### Example2: Get processes based on working set
```
PS C:\>Get-Process | Where-Object {$_.WorkingSet -gt 25000*1024}
PS C:\> Get-Process | Where-Object WorkingSet -gt (25000*1024)
```

This command lists processes that have a working set greater than 25,000 kilobytes (KB).
Because the value of the WorkingSet property is stored in bytes, the value of 25,000 is multiplied by 1,024.

The first command uses the script block format.
The second command uses the comparison statement format.
The commands are equivalent and can be used interchangeably.

### Example 3: Get processes based on process name
```
PS C:\>Get-Process | Where-Object {$_.ProcessName -Match "^p.*"}
PS C:\> Get-Process | Where-Object ProcessName -Match "^p.*"
```

This command gets the processes that have a ProcessName property value that begins with the letter p.
The match operator lets you use regular expression matches.

The first command uses the script block format.
The second command uses the comparison statement format.
The commands are equivalent and can be used interchangeably.

### Example 4: Use the comparison statement format
```
PS C:\>Get-Process | Where-Object -Property Handles -GE -Value 1000
PS C:\> Get-Process | where Handles -GEe 1000
```

This example shows how to use the new comparison statement format of the Where-Object cmdlet.

The first command uses the comparison statement format.
In this command, no aliases are used and all parameters include the parameter name.

The second command is the more natural use of the comparison command format.
The where alias is substituted for the Where-Object cmdlet name and all optional parameter names are omitted.

### Example 5: Get commands based on properties
```
The first pair of commands gets commands that have any value for the OutputType property of the command. They omit commands that do not have an OutputType property and those that have an OutputType property, but no property value.
PS C:\>Get-Command | where OutputType
PS C:\> Get-Command | where {$_.OutputType}

The second pair of commands gets objects that are containers. It gets objects that have the PSIsContainer property with a value of $True and excludes all others.The "equals $True" (-eq $True) part of the command is assumed by the language. You do not need to specify it explicitly.
PS C:\>Get-ChildItem | where PSIsContainer
PS C:\> Get-ChildItem | where {$_.PSIsContainer}

The third pair of commands uses the Not operator (!) to get objects that are not containers. It gets objects that do have the PSIsContainer property and those that have a value of $False for the PSIsContainer property.You cannot use the Not operator (!) in the comparison statement format of the command.
PS C:\>Get-ChildItem | where {!$_.PSIsContainer}
PS C:\> Get-ChildItem | where PSIsContainer -eq $False
```

This example shows how to write commands that return items that are true or false or have any value for a specified property.
The example shows both the script block and comparison statement formats for the command.

### Example 6: Use multiple conditions
```
PS C:\>Get-Module -ListAvailable | where {($_.Name -notlike "Microsoft*" -and $_.Name -notlike "PS*") -and $_.HelpInfoUri}
```

This example shows how to create a Where-Object command with multiple conditions.

This command gets non-core modules that support the Updatable Help feature.
The command uses the ListAvailable parameter of the Get-Module cmdlet to get all modules on the computer.
A pipeline operator (|) sends the modules to the Where-Object cmdlet, which gets modules whose names do not begin with Microsoft or PS, and have a value for the HelpInfoURI property, which tells Windows PowerShell where to find updated help files for the module.
The comparison statements are connected by the And logical operator.

The example uses the script block command format.
Logical operators, such as And and Or, are valid only in script blocks.
You cannot use them in the comparison statement format of a Where-Object command.

For more information about Windows PowerShell logical operators, see about_Logical_Operators (http://go.microsoft.com/fwlink/?LinkID=113238).
For more information about the Updatable Help feature, see about_Updatable_Help (http://go.microsoft.com/fwlink/?LinkID=235801).

## PARAMETERS

### -Contains
Indicates that this cmdlet gets objects if any item in the property value of the object is an exact match for the specified value.

For example: Get-Process | where ProcessName -Contains "Svchost"

If the property value contains a single object, Windows PowerShell converts it to a collection of one object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: IContains

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EQ
Indicates that this cmdlet gets objects if the property value is the same as the specified value.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: IEQ

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterScript
Specifies the script block that is used to filter the objects.
Enclose the script block in braces ( {} ).

The parameter name, FilterScript, is optional.

```yaml
Type: ScriptBlock
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GE
Indicates that this cmdlet gets objects if the property value is greater than or equal to the specified value.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_4
Aliases: IGE

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GT
Indicates that this cmdlet gets objects if the property value is greater than the specified value.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_5
Aliases: IGT

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -In
Indicates that this cmdlet gets objects if the property value matches any of the specified values.

For example: Get-Process | where -Property ProcessName -in -Value "Svchost", "TaskHost", "WsmProvHost"

If the value of the Value parameter is a single object, Windows PowerShell converts it to a collection of one object.

If the property value of an object is an array, Windows PowerShell uses reference equality to determine a match.
Where-Object returns the object only if the value of the Property parameter and any value of Value are the same instance of an object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_6
Aliases: IIn

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to be filtered.
You can also pipe the objects to Where-Object.

When you use the InputObject parameter with Where-Object, instead of piping command results to Where-Object, the InputObject value is treated as a single object.
This is true even if the value is a collection that is the result of a command, such as -InputObject (Get-Process).
Because InputObject cannot return individual properties from an array or collection of objects, we recommend that, if you use Where-Object to filter a collection of objects for those objects that have specific values in defined properties, you use Where-Object in the pipeline, as shown in the examples in this topic.

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

### -Is
Indicates that this cmdlet gets objects if the property value is an instance of the specified .NET Framework type.
Enclose the type name in square brackets.

For example, Get-Process | where StartTime -Is \[DateTime\]

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_21
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsNot
Indicates that this cmdlet gets objects if the property value is not an instance of the specified .NET Framework type.

For example, Get-Process | where StartTime -IsNot \[System.String\]

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_22
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LE
Indicates that this cmdlet gets objects if the property value is less than or equal to the specified value.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_23
Aliases: ILE

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LT
Indicates that this cmdlet gets objects if the property value is less than the specified value.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_25
Aliases: ILT

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Like
Indicates that this cmdlet gets objects if the property value matches a value that includes wildcard characters.

For example: Get-Process | where ProcessName -Like "*host"

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_24
Aliases: ILike

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Match
Indicates that this cmdlet gets objects if the property value matches the specified regular expression.
When the input is scalar, the matched value is saved in $Matches automatic variable.

For example: Get-Process | where ProcessName -Match "shell"

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_26
Aliases: IMatch

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NE
Indicates that this cmdlet gets objects if the property value is different than the specified value.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_27
Aliases: INE

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotContains
Indicates that this cmdlet gets objects if none of the items in the property value is an exact match for the specified value.

For example: Get-Process | where ProcessName -NotContains "Svchost"

NotContains refers to a collection of values and is true if the collection does not contain any items that are an exact match for the specified value.
If the input is a single object, Windows PowerShell converts it to a collection of one object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_28
Aliases: INotContains

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotIn
Indicates that this cmdlet gets objects if the property value is not an exact match for any of the specified values.

For example: Get-Process | where -Value "svchost" -NotIn -Property ProcessName

If the value of Value is a single object, Windows PowerShell converts it to a collection of one object.

If the property value of an object is an array, Windows PowerShell uses reference equality to determine a match.
Where-Object returns the object only if the value of Property and any value of Value are not the same instance of an object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_29
Aliases: INotIn

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotLike
Indicates that this cmdlet gets objects if the property value does not match a value that includes wildcard characters.

For example: Get-Process | where ProcessName -NotLike "*host"

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_30
Aliases: INotLike

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotMatch
Indicates that this cmdlet gets objects when the property value does not match the specified regular expression.
When the input is scalar, the matched value is saved in $Matches automatic variable.

For example: Get-Process | where ProcessName -NotMatch "PowerShell"

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_31
Aliases: INotMatch

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property
Specifies the name of an object property.

The parameter name, Property, is optional.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6, UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8, UNNAMED_PARAMETER_SET_9, UNNAMED_PARAMETER_SET_10, UNNAMED_PARAMETER_SET_11, UNNAMED_PARAMETER_SET_12, UNNAMED_PARAMETER_SET_13, UNNAMED_PARAMETER_SET_14, UNNAMED_PARAMETER_SET_15, UNNAMED_PARAMETER_SET_16, UNNAMED_PARAMETER_SET_17, UNNAMED_PARAMETER_SET_18, UNNAMED_PARAMETER_SET_19, UNNAMED_PARAMETER_SET_20, UNNAMED_PARAMETER_SET_21, UNNAMED_PARAMETER_SET_22, UNNAMED_PARAMETER_SET_23, UNNAMED_PARAMETER_SET_24, UNNAMED_PARAMETER_SET_25, UNNAMED_PARAMETER_SET_26, UNNAMED_PARAMETER_SET_27, UNNAMED_PARAMETER_SET_28, UNNAMED_PARAMETER_SET_29, UNNAMED_PARAMETER_SET_30, UNNAMED_PARAMETER_SET_31
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
Specifies a property value.

The parameter name, Value, is optional.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: Object
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6, UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8, UNNAMED_PARAMETER_SET_9, UNNAMED_PARAMETER_SET_10, UNNAMED_PARAMETER_SET_11, UNNAMED_PARAMETER_SET_12, UNNAMED_PARAMETER_SET_13, UNNAMED_PARAMETER_SET_14, UNNAMED_PARAMETER_SET_15, UNNAMED_PARAMETER_SET_16, UNNAMED_PARAMETER_SET_17, UNNAMED_PARAMETER_SET_18, UNNAMED_PARAMETER_SET_19, UNNAMED_PARAMETER_SET_20, UNNAMED_PARAMETER_SET_21, UNNAMED_PARAMETER_SET_22, UNNAMED_PARAMETER_SET_23, UNNAMED_PARAMETER_SET_24, UNNAMED_PARAMETER_SET_25, UNNAMED_PARAMETER_SET_26, UNNAMED_PARAMETER_SET_27, UNNAMED_PARAMETER_SET_28, UNNAMED_PARAMETER_SET_29, UNNAMED_PARAMETER_SET_30, UNNAMED_PARAMETER_SET_31
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CContains
Indicates that this cmdlet gets objects from a collection if the property value of the object is an exact match for the specified value.
This operation is case-sensitive.

For example: Get-Process | where ProcessName -CContains "svchost"

CContains refers to a collection of values and is true if the collection contains an item that is an exact match for the specified value.
If the input is a single object, Windows PowerShell converts it to a collection of one object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_7
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CEQ
Indicates that this cmdlet gets objects if the property value is the same as the specified value.
This operation is case-sensitive.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_8
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CGE
Indicates that this cmdlet gets objects if the property value is greater than or equal to the specified value.
This operation is case-sensitive.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_9
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CGT
Indicates that this cmdlet gets objects if the property value is greater than the specified value.
This operation is case-sensitive.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_10
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CIn
Indicates that this cmdlet gets objects if the property value includes the specified value.
This operation is case-sensitive.

For example: Get-Process | where -Value "svchost" -CIn ProcessName

CIn resembles CContains, except that the property and value positions are reversed.
For example, the following statements are both true.

"abc", "def" -CContains "abc"

"abc" -CIn "abc", "def"

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_11
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CLE
Indicates that this cmdlet gets objects if the property value is less-than or equal to the specified value.
This operation is case-sensitive.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_12
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CLT
Indicates that this cmdlet gets objects if the property value is less-than the specified value.
This operation is case-sensitive.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_14
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CLike
Indicates that this cmdlet gets objects if the property value matches a value that includes wildcard characters.
This operation is case-sensitive.

For example: Get-Process | where ProcessName -CLike "*host"

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_13
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CMatch
Indicates that this cmdlet gets objects if the property value matches the specified regular expression.
This operation is case-sensitive.
When the input is scalar, the matched value is saved in $Matches automatic variable.

For example: Get-Process | where ProcessName -CMatch "Shell"

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_15
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNE
Indicates that this cmdlet gets objects if the property value is different than the specified value.
This operation is case-sensitive.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_16
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotContains
Indicates that this cmdlet gets objects if the property value of the object is not an exact match for the specified value.
This operation is case-sensitive.

For example: Get-Process | where ProcessName -CNotContains "svchost"

"NotContains" and "CNotContains refer to a collection of values and are true when the collection does not contains any items that are an exact match for the specified value.
If the input is a single object, Windows PowerShell converts it to a collection of one object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_17
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotIn
Indicates that this cmdlet gets objects if the property value is not an exact match for the specified value.
This operation is case-sensitive.

For example: Get-Process | where -Value "svchost" -CNotIn -Property ProcessName

NotIn and CNotIn operators resemble NotContains and CNotContains, except that the property and value positions are reversed.
For example, the following statements are true.

"abc", "def" -CNotContains "Abc"

"abc" -CNotIn "Abc", "def"

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_18
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotLike
Indicates that this cmdlet gets objects if the property value does not match a value that includes wildcard characters.
This operation is case-sensitive.

For example: Get-Process | where ProcessName -CNotLike "*host"

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_19
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotMatch
Indicates that this cmdlet gets objects if the property value does not match the specified regular expression.
This operation is case-sensitive.
When the input is scalar, the matched value is saved in $Matches automatic variable.

For example: Get-Process | where ProcessName -CNotMatch "Shell"

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_20
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe the objects to this cmdlet.

## OUTPUTS

### Object
This cmdlet returns selected items from the input object set.

## NOTES
Starting in Windows PowerShell 4.0, Where() operator behavior has changed.
Collection.Where('property -match name') no longer accepts string expressions in the format Property -CompareOperator Value.
However, the Where() operator accepts string expressions in the format of a scriptblock; this is still supported.
The following examples show the behavior that has changed.

The following two examples show Where() object behavior that is no longer supported.

(Get-Process).Where('ProcessName -match PowerShell')

(Get-Process).Where('ProcessName -match PowerShell', 'Last', 1)

The following three examples show Where() object behavior that is supported in Windows PowerShell 4.0 and subsequent versions of Windows PowerShell.

(Get-Process).Where({$_.ProcessName -match "PowerShell"})

(Get-Process).Where{$_.ProcessName -match "PowerShell"}

(Get-Process).Where({$_.ProcessName -match "PowerShell"}, 'Last', 1)

## RELATED LINKS

[Compare-Object](bdc20eac-bff6-44bc-b130-1a986c79fb78)

[ForEach-Object](bea187c1-37b5-4fc7-9422-d29820643a4d)

[Group-Object](494af40a-1315-420f-8bd6-932006576dac)

[Measure-Object](f40a7de5-95a8-47a8-bb7c-8b2a4cdd2daf)

[New-Object](1d5cac3b-9cd0-4efe-be3e-1ee8d4675f51)

[Select-Object](2f182056-7955-4b77-9c58-64ab4a680074)

[Sort-Object](52c4a447-238d-43b4-8d3f-6aee5864b905)

[Tee-Object](ae5c403c-6a21-430e-a94a-74a1edee149a)

