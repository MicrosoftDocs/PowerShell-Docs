---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 03/19/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/where-object?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Where-Object
---
# Where-Object

## SYNOPSIS
Selects objects from a collection based on their property values.

## SYNTAX

### EqualSet (Default)

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] [-EQ]
 [<CommonParameters>]
```

### ScriptBlockSet

```
Where-Object [-InputObject <PSObject>] [-FilterScript] <ScriptBlock> [<CommonParameters>]
```

### MatchSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -Match
 [<CommonParameters>]
```

### CaseSensitiveEqualSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CEQ
 [<CommonParameters>]
```

### NotEqualSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -NE
 [<CommonParameters>]
```

### CaseSensitiveNotEqualSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CNE
 [<CommonParameters>]
```

### GreaterThanSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -GT
 [<CommonParameters>]
```

### CaseSensitiveGreaterThanSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CGT
 [<CommonParameters>]
```

### LessThanSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -LT
 [<CommonParameters>]
```

### CaseSensitiveLessThanSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CLT
 [<CommonParameters>]
```

### GreaterOrEqualSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -GE
 [<CommonParameters>]
```

### CaseSensitiveGreaterOrEqualSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CGE
 [<CommonParameters>]
```

### LessOrEqualSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -LE
 [<CommonParameters>]
```

### CaseSensitiveLessOrEqualSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CLE
 [<CommonParameters>]
```

### LikeSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -Like
 [<CommonParameters>]
```

### CaseSensitiveLikeSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CLike
 [<CommonParameters>]
```

### NotLikeSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -NotLike
 [<CommonParameters>]
```

### CaseSensitiveNotLikeSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CNotLike
 [<CommonParameters>]
```

### CaseSensitiveMatchSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CMatch
 [<CommonParameters>]
```

### NotMatchSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -NotMatch
 [<CommonParameters>]
```

### CaseSensitiveNotMatchSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CNotMatch
 [<CommonParameters>]
```

### ContainsSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -Contains
 [<CommonParameters>]
```

### CaseSensitiveContainsSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CContains
 [<CommonParameters>]
```

### NotContainsSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -NotContains
 [<CommonParameters>]
```

### CaseSensitiveNotContainsSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CNotContains
 [<CommonParameters>]
```

### InSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -In
 [<CommonParameters>]
```

### CaseSensitiveInSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CIn
 [<CommonParameters>]
```

### NotInSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -NotIn
 [<CommonParameters>]
```

### CaseSensitiveNotInSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -CNotIn
 [<CommonParameters>]
```

### IsSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -Is
 [<CommonParameters>]
```

### IsNotSet

```
Where-Object [-InputObject <PSObject>] [-Property] <String> [[-Value] <Object>] -IsNot
 [<CommonParameters>]
```

### Not

```
Where-Object [-InputObject <PSObject>] [-Property] <String> -Not [<CommonParameters>]
```

## DESCRIPTION

The `Where-Object` cmdlet selects objects that have particular property values from the collection
of objects that are passed to it. For example, you can use the `Where-Object` cmdlet to select files
that were created after a certain date, events with a particular ID, or computers that use a
particular version of Windows.

Starting in Windows PowerShell 3.0, there are two different ways to construct a `Where-Object`
command.

- **Script block**. You can use a script block to specify the property name, a comparison operator,
  and a property value. `Where-Object` returns all objects for which the script block statement is
  true.

  For example, the following command gets processes in the Normal priority class, that is, processes
  where the value of the **PriorityClass** property equals Normal.

  `Get-Process | Where-Object {$_.PriorityClass -eq "Normal"}`

  All PowerShell comparison operators are valid in the script block format. For more information
  about comparison operators, see
  [about_Comparison_Operators](./About/about_Comparison_Operators.md).

- **Comparison statement**. You can also write a comparison statement, which is much more like
  natural language. Comparison statements were introduced in Windows PowerShell 3.0.

  For example, the following commands also get processes that have a priority class of Normal. These
  commands are equivalent and can be used interchangeably.

  `Get-Process | Where-Object -Property PriorityClass -eq -Value "Normal"`

  `Get-Process | Where-Object PriorityClass -eq "Normal"`

  Starting in Windows PowerShell 3.0, `Where-Object` adds comparison operators as parameters in a
  `Where-Object` command. Unless specified, all operators are case-insensitive. Prior to Windows
  PowerShell 3.0, the comparison operators in the PowerShell language could be used only in script
  blocks.

When you provide a single **Property** to `Where-Object`, the value of the property is treated as
a boolean expression. When the value of **Length** is not zero, the expression evaluates to
**True**. For example: `('hi', '', 'there') | Where-Object Length`

The previous example is functionally equivalent to:

- `('hi', '', 'there') | Where-Object Length -GT 0`
- `('hi', '', 'there') | Where-Object {$_.Length -gt 0}`

## EXAMPLES

### Example 1: Get stopped services

These commands get a list of all services that are currently stopped. The `$_` automatic variable
represents each object that is passed to the `Where-Object` cmdlet.

The first command uses the script block format, the second command uses the comparison statement
format. The commands are equivalent and can be used interchangeably.

```powershell
Get-Service | Where-Object {$_.Status -eq "Stopped"}
Get-Service | where Status -eq "Stopped"
```

### Example 2: Get processes based on working set

These commands list processes that have a working set greater than 250 megabytes (KB). The
scriptblock and statement syntax are equivalent and can be used interchangeably.

```powershell
Get-Process | Where-Object {$_.WorkingSet -GT 250MB}
Get-Process | Where-Object WorkingSet -GT (250MB)
```

### Example 3: Get processes based on process name

These commands get the processes that have a **ProcessName** property value that begins with the
letter `p`. The **Match** operator lets you use regular expression matches.

The scriptblock and statement syntax are equivalent and can be used interchangeably.

```powershell
Get-Process | Where-Object {$_.ProcessName -Match "^p.*"}
Get-Process | Where-Object ProcessName -Match "^p.*"
```

### Example 4: Use the comparison statement format

This example shows how to use the new comparison statement format of the `Where-Object` cmdlet.

The first command uses the comparison statement format.
In this command, no aliases are used and all parameters include the parameter name.

The second command is the more natural use of the comparison command format. The `where` alias is
substituted for the `Where-Object` cmdlet name and all optional parameter names are omitted.

```powershell
Get-Process | Where-Object -Property Handles -GE -Value 1000
Get-Process | where Handles -GE 1000
```

### Example 5: Get commands based on properties

This example shows how to write commands that return items that are true or false or have any value
for a specified property. Each example shows both the script block and comparison statement formats
for the command.

```powershell
# Use Where-Object to get commands that have any value for the OutputType property of the command.
# This omits commands that do not have an OutputType property and those that have an OutputType property, but no property value.
Get-Command | where OutputType
Get-Command | where {$_.OutputType}
```

```powershell
# Use Where-Object to get objects that are containers.
# This gets objects that have the **PSIsContainer** property with a value of $True and excludes all others.
Get-ChildItem | where PSIsContainer
Get-ChildItem | where {$_.PSIsContainer}
```

```powershell
# Finally, use the Not operator (!) to get objects that are not containers.
# This gets objects that do have the **PSIsContainer** property and those that have a value of $False for the **PSIsContainer** property.
Get-ChildItem | where {!$_.PSIsContainer}
# You cannot use the Not operator (!) in the comparison statement format of the command.
Get-ChildItem | where PSIsContainer -eq $False
```

### Example 6: Use multiple conditions

```powershell
Get-Module -ListAvailable | where {($_.Name -notlike "Microsoft*" -and $_.Name -notlike "PS*") -and $_.HelpInfoUri}
```

This example shows how to create a `Where-Object` command with multiple conditions.

This command gets non-core modules that support the Updatable Help feature. The command uses the
**ListAvailable** parameter of the `Get-Module` cmdlet to get all modules on the computer. A
pipeline operator (`|`) sends the modules to the `Where-Object` cmdlet, which gets modules whose
names do not begin with Microsoft or PS, and have a value for the **HelpInfoURI** property, which
tells PowerShell where to find updated help files for the module. The comparison statements are
connected by the **And** logical operator.

The example uses the script block command format. Logical operators, such as **And** and **Or**, are
valid only in script blocks. You cannot use them in the comparison statement format of a
`Where-Object` command.

- For more information about PowerShell logical operators, see [about_Logical_Operators](./About/about_logical_operators.md).
- For more information about the Updatable Help feature, see [about_Updatable_Help](./About/about_Updatable_Help.md).

## PARAMETERS

### -CContains

Indicates that this cmdlet gets objects from a collection if the property value of the object is an
exact match for the specified value. This operation is case-sensitive.

For example: `Get-Process | where ProcessName -CContains "svchost"`

**CContains** refers to a collection of values and is true if the collection contains an item that
is an exact match for the specified value. If the input is a single object, PowerShell converts it
to a collection of one object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveContainsSet
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveEqualSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CGE

Indicates that this cmdlet gets objects if the property value is greater than or equal to the
specified value. This operation is case-sensitive.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveGreaterOrEqualSet
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveGreaterThanSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CIn

Indicates that this cmdlet gets objects if the property value includes the specified value. This
operation is case-sensitive.

For example: `Get-Process | where -Value "svchost" -CIn ProcessName`

**CIn** resembles **CContains**, except that the property and value positions are reversed. For
example, the following statements are both true.

`"abc", "def" -CContains "abc"`

`"abc" -CIn "abc", "def"`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveInSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CLE

Indicates that this cmdlet gets objects if the property value is less-than or equal to the specified
value. This operation is case-sensitive.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveLessOrEqualSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CLike

Indicates that this cmdlet gets objects if the property value matches a value that includes wildcard
characters. This operation is case-sensitive.

For example: `Get-Process | where ProcessName -CLike "*host"`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveLikeSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CLT

Indicates that this cmdlet gets objects if the property value is less-than the specified value. This
operation is case-sensitive.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveLessThanSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CMatch

Indicates that this cmdlet gets objects if the property value matches the specified regular
expression. This operation is case-sensitive. When the input is scalar, the matched value is saved
in `$Matches` automatic variable.

For example: `Get-Process | where ProcessName -CMatch "Shell"`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveMatchSet
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveNotEqualSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotContains

Indicates that this cmdlet gets objects if the property value of the object is not an exact match
for the specified value. This operation is case-sensitive.

For example: `Get-Process | where ProcessName -CNotContains "svchost"`

**NotContains** and **CNotContains** refer to a collection of values and are true when the
collection does not contains any items that are an exact match for the specified value. If the input
is a single object, PowerShell converts it to a collection of one object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveNotContainsSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotIn

Indicates that this cmdlet gets objects if the property value is not an exact match for the
specified value. This operation is case-sensitive.

For example: `Get-Process | where -Value "svchost" -CNotIn -Property ProcessName`

**NotIn** and **CNotIn** operators resemble **NotContains** and **CNotContains**, except that the
property and value positions are reversed. For example, the following statements are true.

`"abc", "def" -CNotContains "Abc"`

`"abc" -CNotIn "Abc", "def"`

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveNotInSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotLike

Indicates that this cmdlet gets objects if the property value does not match a value that includes
wildcard characters. This operation is case-sensitive.

For example: `Get-Process | where ProcessName -CNotLike "*host"`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveNotLikeSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CNotMatch

Indicates that this cmdlet gets objects if the property value does not match the specified regular
expression. This operation is case-sensitive. When the input is scalar, the matched value is saved
in `$Matches` automatic variable.

For example: `Get-Process | where ProcessName -CNotMatch "Shell"`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: CaseSensitiveNotMatchSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Contains

Indicates that this cmdlet gets objects if any item in the property value of the object is an exact
match for the specified value.

For example: `Get-Process | where ProcessName -Contains "Svchost"`

If the property value contains a single object, PowerShell converts it to a collection of one
object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ContainsSet
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: EqualSet
Aliases: IEQ

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterScript

Specifies the script block that is used to filter the objects. Enclose the script block in braces
(`{}`).

The parameter name, **FilterScript**, is optional.

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: ScriptBlockSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GE

Indicates that this cmdlet gets objects if the property value is greater than or equal to the
specified value.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: GreaterOrEqualSet
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: GreaterThanSet
Aliases: IGT

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -In

Indicates that this cmdlet gets objects if the property value matches any of the specified values.
For example:

`Get-Process | where -Property ProcessName -in -Value "Svchost", "TaskHost", "WsmProvHost"`

If the value of the **Value** parameter is a single object, PowerShell converts it to a collection of
one object.

If the property value of an object is an array, PowerShell uses reference equality to determine a
match. `Where-Object` returns the object only if the value of the **Property** parameter and any
value of **Value** are the same instance of an object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: InSet
Aliases: IIn

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects to be filtered. You can also pipe the objects to `Where-Object`.

When you use the **InputObject** parameter with `Where-Object`, instead of piping command results to
`Where-Object`, the **InputObject** value is treated as a single object. This is true even if the
value is a collection that is the result of a command, such as `-InputObject (Get-Process)`. Because
**InputObject** cannot return individual properties from an array or collection of objects, we
recommend that, if you use `Where-Object` to filter a collection of objects for those objects that
have specific values in defined properties, you use `Where-Object` in the pipeline, as shown in the
examples in this topic.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Is

Indicates that this cmdlet gets objects if the property value is an instance of the specified .NET
type. Enclose the type name in square brackets.

For example, `Get-Process | where StartTime -Is [DateTime]`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: IsSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsNot

Indicates that this cmdlet gets objects if the property value is not an instance of the specified
.NET type.

For example, `Get-Process | where StartTime -IsNot [DateTime]`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: IsNotSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LE

Indicates that this cmdlet gets objects if the property value is less than or equal to the specified
value.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: LessOrEqualSet
Aliases: ILE

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Like

Indicates that this cmdlet gets objects if the property value matches a value that includes wildcard
characters.

For example: `Get-Process | where ProcessName -Like "*host"`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: LikeSet
Aliases: ILike

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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: LessThanSet
Aliases: ILT

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Match

Indicates that this cmdlet gets objects if the property value matches the specified regular
expression. When the input is scalar, the matched value is saved in `$Matches` automatic variable.

For example: `Get-Process | where ProcessName -Match "shell"`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: MatchSet
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NotEqualSet
Aliases: INE

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Not

Indicates that this cmdlet gets objects if the property does not exist or has a value of null or
false.

For example: `Get-Service | where -Not "DependentServices"`

This parameter was introduced in Windows PowerShell 6.1.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Not
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotContains

Indicates that this cmdlet gets objects if none of the items in the property value is an exact match
for the specified value.

For example: `Get-Process | where ProcessName -NotContains "Svchost"`

**NotContains** refers to a collection of values and is true if the collection does not contain any
items that are an exact match for the specified value. If the input is a single object, PowerShell
converts it to a collection of one object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NotContainsSet
Aliases: INotContains

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotIn

Indicates that this cmdlet gets objects if the property value is not an exact match for any of the
specified values.

For example: `Get-Process | where -Value "svchost" -NotIn -Property ProcessName`

If the value of **Value** is a single object, PowerShell converts it to a collection of one object.

If the property value of an object is an array, PowerShell uses reference equality to determine a
match. `Where-Object` returns the object only if the value of **Property** and any value of
**Value** are not the same instance of an object.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NotInSet
Aliases: INotIn

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotLike

Indicates that this cmdlet gets objects if the property value does not match a value that includes
wildcard characters.

For example: `Get-Process | where ProcessName -NotLike "*host"`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NotLikeSet
Aliases: INotLike

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotMatch

Indicates that this cmdlet gets objects when the property value does not match the specified regular
expression. When the input is scalar, the matched value is saved in `$Matches` automatic variable.

For example: `Get-Process | where ProcessName -NotMatch "PowerShell"`

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NotMatchSet
Aliases: INotMatch

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

Specifies the name of an object property. The parameter name, **Property**, is optional.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: EqualSet, LessOrEqualSet, CaseSensitiveEqualSet, NotEqualSet, CaseSensitiveNotEqualSet, GreaterThanSet, CaseSensitiveGreaterThanSet, LessThanSet, CaseSensitiveLessThanSet, GreaterOrEqualSet, CaseSensitiveGreaterOrEqualSet, CaseSensitiveLessOrEqualSet, LikeSet, CaseSensitiveLikeSet, NotLikeSet, CaseSensitiveNotLikeSet, MatchSet, CaseSensitiveMatchSet, NotMatchSet, CaseSensitiveNotMatchSet, ContainsSet, CaseSensitiveContainsSet, NotContainsSet, CaseSensitiveNotContainsSet, InSet, CaseSensitiveInSet, NotInSet, CaseSensitiveNotInSet, IsSet, IsNotSet, Not
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value

Specifies a property value. The parameter name, **Value**, is optional. This parameter accepts
wildcard characters when used with the following comparison parameters:

- **CLike**
- **CNotLike**
- **Like**
- **NotLike**

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Object
Parameter Sets: EqualSet, LessOrEqualSet, CaseSensitiveEqualSet, NotEqualSet, CaseSensitiveNotEqualSet, GreaterThanSet, CaseSensitiveGreaterThanSet, LessThanSet, CaseSensitiveLessThanSet, GreaterOrEqualSet, CaseSensitiveGreaterOrEqualSet, CaseSensitiveLessOrEqualSet, LikeSet, CaseSensitiveLikeSet, NotLikeSet, CaseSensitiveNotLikeSet, MatchSet, CaseSensitiveMatchSet, NotMatchSet, CaseSensitiveNotMatchSet, ContainsSet, CaseSensitiveContainsSet, NotContainsSet, CaseSensitiveNotContainsSet, InSet, CaseSensitiveInSet, NotInSet, CaseSensitiveNotInSet, IsSet, IsNotSet
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe the objects to this cmdlet.

## OUTPUTS

### Object

This cmdlet returns selected items from the input object set.

## NOTES

Starting in Windows PowerShell 4.0, `Where` and `ForEach` methods were added for use with collections.

You can read more about these new methods here [about_arrays](./About/about_Arrays.md)

## RELATED LINKS

[Compare-Object](../Microsoft.PowerShell.Utility/Compare-Object.md)

[ForEach-Object](ForEach-Object.md)

[Group-Object](../Microsoft.PowerShell.Utility/Group-Object.md)

[Measure-Object](../Microsoft.PowerShell.Utility/Measure-Object.md)

[New-Object](../Microsoft.PowerShell.Utility/New-Object.md)

[Select-Object](../Microsoft.PowerShell.Utility/Select-Object.md)

[Sort-Object](../Microsoft.PowerShell.Utility/Sort-Object.md)

[Tee-Object](../Microsoft.PowerShell.Utility/Tee-Object.md)

