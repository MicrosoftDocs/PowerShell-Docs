---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Where Object
ms.technology:  powershell
external help file:  PSITPro4_Core.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=289623
schema:  2.0.0
---


# Where-Object
## SYNOPSIS
Selects objects from a collection based on their property values.
## SYNTAX

### EqualSet (Default)
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-EQ] [<CommonParameters>]
```

### ScriptBlockSet
```
Where-Object [-InputObject <PSObject>] [-FilterScript] <ScriptBlock> [<CommonParameters>]
```

### CaseSensitiveLessThanSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CLT] [<CommonParameters>]
```

### LessOrEqualSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-LE] [<CommonParameters>]
```

### NotContainsSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-NotContains]
 [<CommonParameters>]
```

### CaseSensitiveNotContainsSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CNotContains]
 [<CommonParameters>]
```

### CaseSensitiveLessOrEqualSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CLE] [<CommonParameters>]
```

### InSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-In] [<CommonParameters>]
```

### CaseSensitiveInSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CIn] [<CommonParameters>]
```

### NotInSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-NotIn] [<CommonParameters>]
```

### CaseSensitiveNotInSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CNotIn] [<CommonParameters>]
```

### IsSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-Is] [<CommonParameters>]
```

### LikeSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-Like] [<CommonParameters>]
```

### CaseSensitiveEqualSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CEQ] [<CommonParameters>]
```

### NotEqualSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-NE] [<CommonParameters>]
```

### CaseSensitiveNotEqualSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CNE] [<CommonParameters>]
```

### GreaterThanSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-GT] [<CommonParameters>]
```

### CaseSensitiveGreaterThanSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CGT] [<CommonParameters>]
```

### MatchSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-Match] [<CommonParameters>]
```

### CaseSensitiveLikeSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CLike] [<CommonParameters>]
```

### CaseSensitiveMatchSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CMatch] [<CommonParameters>]
```

### IsNotSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-IsNot] [<CommonParameters>]
```

### NotLikeSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-NotLike] [<CommonParameters>]
```

### CaseSensitiveNotMatchSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CNotMatch]
 [<CommonParameters>]
```

### ContainsSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-Contains]
 [<CommonParameters>]
```

### CaseSensitiveContainsSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CContains]
 [<CommonParameters>]
```

### LessThanSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-LT] [<CommonParameters>]
```

### CaseSensitiveNotLikeSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CNotLike]
 [<CommonParameters>]
```

### NotMatchSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-NotMatch]
 [<CommonParameters>]
```

### GreaterOrEqualSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-GE] [<CommonParameters>]
```

### CaseSensitiveGreaterOrEqualSet
```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-CGE] [<CommonParameters>]
```

## DESCRIPTION
The Where-Object cmdlet selects objects that have particular property values from the collection of objects that are passed to it.
For example you can use the Where-Object cmdlet to select files that were created after a certain date, events with a particular ID, or computers with a particular version of Windows.

Beginning in Windows PowerShell 3.0, there are two different ways to construct a Where-Object command.

Script block.
You can use a script block to specify the property name, a comparison operator, and a property value.
Where-Object returns all objects for which the script block statement is true.

For example, the following command gets processes in the Normal priority class, that is, processes where the value of the PriorityClass property equals "Normal".

Get-Process | Where-Object {$_.PriorityClass -eq "Normal"}

All Windows PowerShell comparison operators are valid in the script block format.
For more information about comparison operators, see about_Comparison_Operators (http://go.microsoft.com/fwlink/?LinkID=113217).

Comparison statement.
You can also write a comparison statement, which is much more like natural language.
Comparison statements were introduced in Windows PowerShell 3.0.

For example, the following commands also get processes that have a priority class of "Normal".
These commands are equivalent and can be used interchangeably.

Get-Process | Where-Object -Property PriorityClass -eq -Value "Normal"

Get-Process | Where-Object PriorityClass -eq "Normal"

Beginning in Windows PowerShell 3.0, Where-Object adds comparison operators as parameters in a Where-Object command.
Unless specified, all operators are case-insensitive.
Prior to Windows PowerShell 3.0, the comparison operators in the Windows PowerShell language could be used only in script blocks.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Get-Service | Where-Object {$_.Status -eq "Stopped"}
PS C:\>Get-Service | where Status -eq "Stopped"
```

This command gets a list of all services that are currently stopped.
The "$_" symbol represents each object that is passed to the Where-Object cmdlet.

The first command uses the script block format.
The second command uses the comparison statement format.
The commands are equivalent and can be used interchangeably.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Get-Process | Where-Object {$_.WorkingSet -gt 25000*1024}
PS C:\>Get-Process | Where-Object WorkingSet -gt (25000*1024)
```

This command lists processes that have a working set greater than 25,000 kilobytes (KB).
Because the value of the WorkingSet property is stored in bytes, the value of 25,000 is multiplied by 1,024.

The first command uses the script block format.
The second command uses the comparison statement format.
The commands are equivalent and can be used interchangeably.
### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>Get-Process | Where-Object {$_.ProcessName -Match "^p.*"}
PS C:\>Get-Process | Where-Object ProcessName -Match "^p.*"
```

This command gets the processes that have a ProcessName property value that begins with the letter "p".
The match operator lets you use regular expression matches.

The first command uses the script block format.
The second command uses the comparison statement format.
The commands are equivalent and can be used interchangeably.
### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>Get-Process | Where-Object -Property Handles -ge -Value 1000
PS C:\>Get-Process | where Handles -ge 1000
```

This example shows how to use the new comparison statement  format of the Where-Object cmdlet.

The first command uses the comparison statement format.
In this command, no aliases are used and all parameters include the parameter name.

The second command is the more natural use of the comparison command format.
The "where" alias is substituted for the "Where-Object" cmdlet name and all optional parameter names are omitted.
### -------------------------- EXAMPLE 6 --------------------------
```
The first pair of commands gets commands that have any value for the OutputType property of the command. They omit commands that do not have an OutputType property and those that have an OutputType property, but no property value.
PS C:\>Get-Command | where OutputType
PS C:\>Get-Command | where {$_.OutputType}

The second pair of commands gets objects that are containers. It gets objects that have the PSIsContainer property with a value of True ($true) and excludes all others.The "equals $True" (-eq $true) part of the command is assumed by the language. You do not need to specify it explicitly.
PS C:\>Get-ChildItem | where PSIsContainer
PS C:\>Get-ChildItem | where {$_.PSIsContainer}

The third pair of commands uses the Not operator (!) to get objects that are not containers. It gets objects that do have the PSIsContainer property and those that have a value of False ($false) for the PSIsContainer property.You cannot use the Not operator (!) in the comparison statement format of the command.
PS C:\>Get-ChildItem | where {!$_.PSIsContainer}
PS C:\>Get-ChildItem | where  PSIsContainer -eq $false
```

This example shows how to write commands that return items that are true or false or have any value for a specified property.
The example shows both the script block and comparison statement formats for the command.
### -------------------------- EXAMPLE 7 --------------------------
```
PS C:\>Get-Module -ListAvailable | where {($_.Name -notlike "Microsoft*" -and $_.Name -notlike "PS*") -and $_.HelpInfoUri}
```

This example shows how to create a Where-Object command with multiple conditions.

This command gets non-core modules that support the Updatable Help feature.
The command uses the ListAvailable parameter of the Get-Module cmdlet to get all modules on the computer.
A pipeline operator sends the modules to the Where-Object cmdlet, which gets modules whose names do not begin with "Microsoft" or "PS" and have  a value for the HelpInfoURI property, which tells Windows PowerShell where to find updated help files for the module.
The comparison statements are connected by the -And logical operator.

The example uses the script block command format.
Logical operators, such as -And and -Or, are valid only in script blocks.
You cannot use them in the comparison statement format of a Where-Object command.

For more information about Windows PowerShell logical operators, see about_Logical_Operators (http://go.microsoft.com/fwlink/?LinkID=113238).
For more information about the Updatable Help feature, see about_Updatable_Help (http://go.microsoft.com/fwlink/?LinkID=235801).
## PARAMETERS

### -Contains
Specifies the Contains operator, which gets objects when any item in the property value of the object is an exact match for the specified value.

For example: Get-Process | where ProcessName -contains "Svchost"

If the property value contains a single object, Windows PowerShell converts it to a collection of one object.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: ContainsSet
Aliases: IContains

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -EQ
Specifies the equals operator, which gets objects when the property value is the same as the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: EqualSet
Aliases: IEQ

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterScript
Specifies the script block that is used to filter the objects.
Enclose the script block in braces ( {} ).

The parameter name (-FilterScript) is optional.

```yaml
Type: ScriptBlock
Parameter Sets: ScriptBlockSet
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GE
Specifies the Greater-than-or-equal operator, which gets objects when the property value is greater than or equal to the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: GreaterOrEqualSet
Aliases: IGE

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -GT
Specifies the Greater-than operator, which gets objects when the property value is greater than the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: GreaterThanSet
Aliases: IGT

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -In
Specifies the In operator, which gets objects when the property value matches any of the specified values.

For example: Get-Process | where -Property ProcessName -in -Value "Svchost", "TaskHost", "WsmProvHost"

If the value of the Value parameter is a single object, Windows PowerShell converts it to a collection of one object.

If the property value of an object is an array, Windows PowerShell uses reference equality to determine a match.
Where-Object returns the object only if the value of the Property parameter and any value of the Value parameter are the same instance of an object.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: InSet
Aliases: IIn

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to be filtered.
You can also pipe the objects to Where-Object.
When you use the InputObject parameter with Where-Object, instead of piping command results to Where-Object, the InputObject value-even if the value is a collection that is the result of a command, such as -InputObject (Get-Process)-is treated as a single object.
Because InputObject cannot return individual properties from an array or collection of objects, it is recommended that if you use Where-Object to filter a collection of objects for those objects that have specific values in defined properties, you use Where-Object in the pipeline, as shown in the examples in this topic.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Is
Specifies the Is operator, which gets objects when the property value is an instance of the specified .NET Framework type.
Enclose the type name in square brackets.

For example, Get-Process | where StartTime -Is \[DateTime\]

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: IsSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsNot
Specifies the Is-Not operator, which gets objects when the property value is not an instance of the specified .NET Framework type.

For example, Get-Process | where StartTime -IsNot \[System.String\]

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: IsNotSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -LE
Specifies the Less-than-or-equals operator.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: LessOrEqualSet
Aliases: ILE

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -LT
Specifies the Less-than operator, which gets objects when the property value is less than the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: LessThanSet
Aliases: ILT

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Like
Specifies the Like operator, which gets objects when the property value matches a value that includes wildcard characters.

For example: Get-Process | where ProcessName -like "*host"

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: LikeSet
Aliases: ILike

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Match
Specifies the Match operator, which gets objects when the property value matches the specified regular expression.
When the input is scalar, the matched value is saved in $Matches automatic variable.

For example: Get-Process | where ProcessName -match "shell"

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: MatchSet
Aliases: IMatch

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -NE
Specifies the Not-equals operator, which gets objects when the property value is different than the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: NotEqualSet
Aliases: INE

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotContains
Specifies the  Not-Contains operator, which gets objects when none of the items in the  property value is an exact match for the specified value.

For example: Get-Process | where ProcessName -NotContains "Svchost"

"NotContains" refers to a collection of values and is true when the collection does not contain any items that are an exact match for the specified value. 
If the input is a single object, Windows PowerShell converts it to a collection of one object.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: NotContainsSet
Aliases: INotContains

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotIn
Specifies the  Not-In operator, which gets objects when the property value is not an exact match for any of the specified values.

For example: Get-Process | where -Value "svchost" -NotIn -Property ProcessName

If the value of the Value parameter is a single object, Windows PowerShell converts it to a collection of one object.

If the property value of an object is an array, Windows PowerShell uses reference equality to determine a match.
Where-Object returns the object only if the value of the Property parameter and any value of the Value parameter are not the same instance of an object.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: NotInSet
Aliases: INotIn

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotLike
Specifies the Not-Like operator, which gets objects when the property value does not match a value that includes wildcard characters.

For example: Get-Process | where ProcessName -NotLike "*host"

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: NotLikeSet
Aliases: INotLike

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotMatch
Specifies the not-match operator, which gets objects when the property value does not match the specified regular expression.
When the input is scalar, the matched value is saved in $Matches automatic variable.

For example: Get-Process | where ProcessName -NotMatch "PowerShell"

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: NotMatchSet
Aliases: INotMatch

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property
Specifies the name of an object property.

The parameter name (-Property) is optional.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: EqualSet, CaseSensitiveLessThanSet, LessOrEqualSet, NotContainsSet, CaseSensitiveNotContainsSet, CaseSensitiveLessOrEqualSet, InSet, CaseSensitiveInSet, NotInSet, CaseSensitiveNotInSet, IsSet, LikeSet, CaseSensitiveEqualSet, NotEqualSet, CaseSensitiveNotEqualSet, GreaterThanSet, CaseSensitiveGreaterThanSet, MatchSet, CaseSensitiveLikeSet, CaseSensitiveMatchSet, IsNotSet, NotLikeSet, CaseSensitiveNotMatchSet, ContainsSet, CaseSensitiveContainsSet, LessThanSet, CaseSensitiveNotLikeSet, NotMatchSet, GreaterOrEqualSet, CaseSensitiveGreaterOrEqualSet
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
Specifies a property value.

The parameter name (-Value) is optional.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: Object
Parameter Sets: EqualSet, CaseSensitiveLessThanSet, LessOrEqualSet, NotContainsSet, CaseSensitiveNotContainsSet, CaseSensitiveLessOrEqualSet, InSet, CaseSensitiveInSet, NotInSet, CaseSensitiveNotInSet, IsSet, LikeSet, CaseSensitiveEqualSet, NotEqualSet, CaseSensitiveNotEqualSet, GreaterThanSet, CaseSensitiveGreaterThanSet, MatchSet, CaseSensitiveLikeSet, CaseSensitiveMatchSet, IsNotSet, NotLikeSet, CaseSensitiveNotMatchSet, ContainsSet, CaseSensitiveContainsSet, LessThanSet, CaseSensitiveNotLikeSet, NotMatchSet, GreaterOrEqualSet, CaseSensitiveGreaterOrEqualSet
Aliases: 

Required: False
Position: 2
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CContains
Specifies the case-sensitive Contains operator, which gets objects from a collection when the property value of the object is an exact match for the specified value

For example: Get-Process | where ProcessName -contains "svchost"

"Contains" refers to a collection of values and is true when the collection contains an item that is an exact match for the specified value. 
If the input is a single object, Windows PowerShell converts it to a collection of one object.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveContainsSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CEQ
Specifies the case-sensitive Equals operator, which gets objects when the property value is the same as the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveEqualSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CGE
Specifies the case-sensitive Greater-than-or-equal value, which gets objects when the property value is greater than or equal to the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveGreaterOrEqualSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CGT
Specifies the case-sensitive Greater-than property, which gets objects when the property value is greater than the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveGreaterThanSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CIn
Specifies the case-sensitive In operator, which gets objects when the property value includes the specified value.

For example: Get-Process | where -Value "svchost" -CIn ProcessName

The In operator is much like the Contains operator, except that the property and value positions are reversed.
For example, the following statements are both true.

"abc", "def" -CContains "abc"

"abc" -CIn "abc", "def"

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveInSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CLE
Specifies the case-sensitive Less-than-or-equal operator, which gets objects when the property value is less-than or equal to the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveLessOrEqualSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CLT
Specifies the case-sensitive Less-than operator, which gets objects when the property value is less-than the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveLessThanSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CLike
Specifies the case-sensitive Like operator, which gets objects when the property value matches a value that includes wildcard characters.

For example: Get-Process | where ProcessName -CLike "*host"

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveLikeSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CMatch
Specifies the case-sensitive Match operator, which gets objects when the property value matches the specified regular expression.
When the input is scalar, the matched value is saved in $Matches automatic variable.

For example: Get-Process | where ProcessName -CMatch "Shell"

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveMatchSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNE
Specifies the case-sensitive Not-Equals operator, which gets objects when the property value is different than the specified value.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveNotEqualSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotContains
Specifies the case-sensitive Not-Contains operator, which gets objects when the property value of the object is not an exact match for the specified value.

For example: Get-Process | where ProcessName -CNotContains "svchost"

"NotContains" and "CNotContains refer to a collection of values and are true when the collection does not contains any items that are an exact match for the specified value.
If the input is a single object, Windows PowerShell converts it to a collection of one object.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveNotContainsSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotIn
Specifies the case-sensitive Not-In operator, which gets objects when the property value is not an exact match for the specified value.

For example: Get-Process | where -Value "svchost" -CNotIn -Property ProcessName

The Not-In  and CNot-In operators are much like the Not-Contains and CNot-Contains operators, except that the property and value positions are reversed.
For example, the following statements are true.

"abc", "def" -CNotContains "Abc"

"abc" -CNotIn "Abc", "def"

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveNotInSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotLike
Specifies the case-sensitive Not-Like operator, which gets objects when the property value does not match a value that includes wildcard characters.

For example: Get-Process | where ProcessName -CNotLike "*host"

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveNotLikeSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotMatch
Specifies the case-sensitive Not-match operator, which gets objects when the property value does not match the specified regular expression.
When the input is scalar, the matched value is saved in $Matches automatic variable.

For example: Get-Process | where ProcessName -CNotMatch "Shell"

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: CaseSensitiveNotMatchSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.Management.Automation.PSObject
You can pipe the objects to be filtered to Where-Object.
## OUTPUTS

### Object
Where-Object returns selected items from the input object set.
## NOTES
* Beginning in Windows PowerShell 4.0, Where() operator behavior has changed. Collection.Where('property -match name') no longer accepts string expressions in the format "Property -CompareOperator Value". However, the Where() operator accepts string expressions in the format of a scriptblock; this is still supported. The following examples show the behavior that has changed.

  The following two examples show Where() object behavior that is no longer supported.

  (Get-Process).Where('ProcessName -match PowerShell')

  (Get-Process).Where('ProcessName -match PowerShell', 'Last', 1)

  The following three examples show Where() object behavior that is supported in Windows PowerShell 4.0 and forward.

  (Get-Process).Where({$_.ProcessName -match "PowerShell"})

  (Get-Process).Where{$_.ProcessName -match "PowerShell"}

  (Get-Process).Where({$_.ProcessName -match "PowerShell"}, 'Last', 1)
## RELATED LINKS

[Compare-Object](../Microsoft.PowerShell.Utility/Compare-Object.md)

[ForEach-Object](ForEach-Object.md)

[Group-Object](../Microsoft.PowerShell.Utility/Group-Object.md)

[Measure-Object](../Microsoft.PowerShell.Utility/Measure-Object.md)

[New-Object](../Microsoft.PowerShell.Utility/New-Object.md)

[Select-Object](../Microsoft.PowerShell.Utility/Select-Object.md)

[Sort-Object](../Microsoft.PowerShell.Utility/Sort-Object.md)

[Tee-Object](../Microsoft.PowerShell.Utility/Tee-Object.md)

[Where-Object](Where-Object.md)

