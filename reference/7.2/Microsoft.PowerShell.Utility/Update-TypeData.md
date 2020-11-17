---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/27/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/update-typedata?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Update-TypeData
---

# Update-TypeData

## Synopsis
Updates the extended type data in the session.

## Syntax

### FileSet (Default)

```
Update-TypeData [[-AppendPath] <String[]>] [-PrependPath <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DynamicTypeSet

```
Update-TypeData [-MemberType <PSMemberTypes>] [-MemberName <String>] [-Value <Object>]
 [-SecondValue <Object>] [-TypeConverter <Type>] [-TypeAdapter <Type>]
 [-SerializationMethod <String>] [-TargetTypeForDeserialization <Type>]
 [-SerializationDepth <Int32>] [-DefaultDisplayProperty <String>]
 [-InheritPropertySerializationSet <Nullable`1>] [-StringSerializationSource <String>]
 [-DefaultDisplayPropertySet <String[]>] [-DefaultKeyPropertySet <String[]>]
 [-PropertySerializationSet <String[]>] -TypeName <String> [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### TypeDataSet

```
Update-TypeData [-Force] [-TypeData] <TypeData[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## Description

The `Update-TypeData` cmdlet updates the extended type data in the session by reloading the
`Types.ps1xml` files into memory and adding new extended type data.

By default, PowerShell loads extended type data as it is needed. Without parameters,
`Update-TypeData` reloads all of the `Types.ps1xml` files that it has loaded in the session,
including any type files that you added. You can use the parameters of `Update-TypeData` to add new
type files and add and replace extended type data.

The `Update-TypeData` cmdlet can be used to preload all type data. This feature is particularly
useful when you are developing types and want to load those new types for testing purposes.

Beginning in Windows PowerShell 3.0, you can use `Update-TypeData` to add and replace extended type
data in the session without using a `Types.ps1xml` file. Type data that is added dynamically, that
is, without a file, is added only to the current session. To add the type data to all sessions, add
an `Update-TypeData` command to your PowerShell profile. For more information, see
[about_Profiles](../Microsoft.PowerShell.Core/About/about_Profiles.md).

Also, beginning in Windows PowerShell 3.0, you can use the `Get-TypeData` cmdlet to get the extended
types in the current session and the `Remove-TypeData` cmdlet to delete extended types from the
current session.

Exceptions that occur in properties, or from adding properties to an `Update-TypeData` command, do
not report errors. This is to suppress exceptions that would occur in many common types during
formatting and outputting. If you are getting .NET properties, you can work around the suppression
of exceptions by using method syntax instead, as shown in the following example:

`"hello".get_Length()`

Note that method syntax can only be used with .NET properties. Properties that are added by running
the `Update-TypeData` cmdlet cannot use method syntax.

For more information about the `Types.ps1xml` files in PowerShell, see
[about_Types.ps1xml](../Microsoft.PowerShell.Core/About/about_Types.ps1xml.md).

## Examples

### Example 1: Update extended types

```powershell
Update-TypeData
```

This command updates the extended type configuration from the `Types.ps1xml` files that have already
been used in the session.

### Example 2: Update types multiple times

This example shows how to update the types in a type file multiple times in the same session.

The first command updates the extended type configuration from the `Types.ps1xml` files, processing
the `TypesA.types.ps1xml` and `TypesB.types.ps1xml` files first.

The second command shows how to update the `TypesA.types.ps1xml` again, such as you might do if you
added or changed a type in the file. You can either repeat the previous command for the
`TypesA.types.ps1xml` file, or run an `Update-TypeData` command without parameters, because
`TypesA.types.ps1xml` is already in the type file list for the current session.

```powershell
Update-TypeData -PrependPath TypesA.types.ps1xml, TypesB.types.ps1xml
Update-TypeData -PrependPath TypesA.types.ps1xml
```

### Example 3: Add a script property to DateTime objects

This example uses `Update-TypeData` to add the **Quarter** script property to **System.DateTime**
objects in the current session, such as those returned by the `Get-Date` cmdlet.

```powershell
Update-TypeData -TypeName "System.DateTime" -MemberType ScriptProperty -MemberName "Quarter" -Value {
  if ($this.Month -in @(1,2,3)) {"Q1"}
  elseif ($this.Month -in @(4,5,6)) {"Q2"}
  elseif ($this.Month -in @(7,8,9)) {"Q3"}
  else {"Q4"}
}
(Get-Date).Quarter
```

```Output
Q1
```

The `Update-TypeData` command uses the **TypeName** parameter to specify **the System.DateTime**
type, the **MemberName** parameter to specify a name for the new property, the **MemberType**
property to specify the **ScriptProperty** type, and the **Value** parameter to specify the script
that determines the annual quarter.

The value of the **Value** property is a script that calculates the current annual quarter. The
script block uses the `$this` automatic variable to represent the current instance of the object and
the In operator to determine whether the month value appears in each integer array. For more
information about the `-in` operator, see
[about_Comparison_Operators](../Microsoft.PowerShell.Core/about/about_Comparison_Operators.md).

The second command gets the new Quarter property of the current date.

### Example 4: Update a type that displays in lists by default

This example shows how to set the properties of a type that displays in lists by default, that is,
when no properties are specified. Because the type data is not specified in a `Types.ps1xml` file, it
is effective only in the current session.

```powershell
Update-TypeData -TypeName "System.DateTime" -DefaultDisplayPropertySet "DateTime, DayOfYear, Quarter"
Get-Date | Format-List
```

```Output
Thursday, March 15, 2012 12:00:00 AM
DayOfYear : 75
Quarter   : Q1
```

The first command uses the `Update-TypeData` cmdlet to set the default list properties for the
**System.DateTime** type. The command uses the **TypeName** parameter to specify the type and the
**DefaultDisplayPropertySet** parameter to specify the default properties for a list. The selected
properties include the new **Quarter** script property that was added in a previous example.

The second command uses the `Get-Date` cmdlet to get a **System.DateTime** object that represents
the current date. The command uses a pipeline operator (`|`) to send the **DateTime** object to the
`Format-List` cmdlet. Because the `Format-List` command does not specify the properties to display
in the list, PowerShell uses the default values that were established by the `Update-TypeData`
command.

### Example 5: Update type data for a piped object

```powershell
Get-Module | Update-TypeData -MemberType ScriptProperty -MemberName "SupportsUpdatableHelp" -Value {
  if ($this.HelpInfoUri) {$True} else {$False}
}
Get-Module -ListAvailable | Format-Table Name, SupportsUpdatableHelp
```

```Output
Name                             SupportsUpdatableHelp
----                             ---------------------
Microsoft.PowerShell.Diagnostics                  True
Microsoft.PowerShell.Host                         True
Microsoft.PowerShell.Management                   True
Microsoft.PowerShell.Security                     True
Microsoft.PowerShell.Utility                      True
Microsoft.WSMan.Management                        True
PSDiagnostics                                    False
PSScheduledJob                                    True
PSWorkflow                                        True
ServerManager                                     True
TroubleshootingPack                              False
```

This example demonstrates that when you pipe an object to `Update-TypeData`, `Update-TypeData` adds
extended type data for the object type.

This technique is quicker than using the `Get-Member` cmdlet or the `Get-Type` method to get the
object type. However, if you pipe a collection of objects to `Update-TypeData`, it updates the type
data of the first object type and then returns an error for all other objects in the collection
because the member is already defined on the type.

The first command uses the `Get-Module` cmdlet to get the PSScheduledJob module. The command pipes
the module object to the `Update-TypeData` cmdlet, which updates the type data for the
**System.Management.Automation.PSModuleInfo** type and the types derived from it, such as the
ModuleInfoGrouping type that `Get-Module` returns when you use the **ListAvailable** parameter in
the command.

The `Update-TypeData` commands adds the **SupportsUpdatableHelp** script property to all imported
modules. The value of the **Value** parameter is a script that returns `$True` if the
**HelpInfoUri** property of the module is populated and `$False` otherwise.

The second command pipes the module objects from `Get-Module` to the `Format-Table` cmdlet, which
displays the **Name** and **SupportsUpdatableHelp** properties of all modules in a list.

## Parameters

### -AppendPath

Specifies the path to optional `.ps1xml` files. The specified files are loaded in the order that
they are listed after the built-in files are loaded. You can also pipe an **AppendPath** value to
`Update-TypeData`.

```yaml
Type: System.String[]
Parameter Sets: FileSet
Aliases: PSPath, Path

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DefaultDisplayProperty

Specifies the property of the type that is displayed by the `Format-Wide` cmdlet when no other
properties are specified.

Type the name of a standard or extended property of the type. The value of this parameter can be the
name of a type that is added in the same command.

This value is effective only when there are no wide views defined for the type in a `Format.ps1xml`
file.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultDisplayPropertySet

Specifies one or more properties of the type. These properties are displayed by the `Format-List`
cmdlet when no other properties are specified.

Type the names of standard or extended properties of the type. The value of this parameter can be
the names of types that are added in the same command.

This value is effective only when there are no list views defined for the type in a `Format.ps1xml`
file.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String[]
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultKeyPropertySet

Specifies one or more properties of the type. These properties are used by the `Group-Object` and
`Sort-Object` cmdlets when no other properties are specified.

Type the names of standard or extended properties of the type. The value of this parameter can be
the names of types that are added in the same command.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String[]
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Indicates that the cmdlet uses the specified type data, even if type data has already been specified
for that type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: DynamicTypeSet, TypeDataSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InheritPropertySerializationSet

Indicates whether the set of properties that are serialized is inherited. The default value is
`$Null`. The acceptable values for this parameter are:

- `$True`. The property set is inherited.
- `$False`. The property set is not inherited.
- `$Null`. Inheritance is not defined.

This parameter is valid only when the value of the **SerializationMethod** parameter is
`SpecificProperties`. When the value of this parameter is `$False`, the **PropertySerializationSet**
parameter is required.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Nullable`1[System.Boolean]
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MemberName

Specifies the name of a property or method.

Use this parameter with the **TypeName**, **MemberType**, **Value** and **SecondValue** parameters
to add or change a property or method of a type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MemberType

Specifies the type of the member to add or change.

Use this parameter with the **TypeName**, **MemberType**, **Value** and **SecondValue** parameters
to add or change a property or method of a type. The acceptable values for this parameter are:

- AliasProperty
- CodeMethod
- CodeProperty
- Noteproperty
- ScriptMethod
- ScriptProperty

For information about these values, see
[PSMemberTypes Enumeration](/dotnet/api/system.management.automation.psmembertypes).

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.PSMemberTypes
Parameter Sets: DynamicTypeSet
Aliases:
Accepted values: NoteProperty, AliasProperty, ScriptProperty, CodeProperty, ScriptMethod, CodeMethod

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrependPath

Specifies the path to the optional `.ps1xml` files. The specified files are loaded in the order that
they are listed before the built-in files are loaded.

```yaml
Type: System.String[]
Parameter Sets: FileSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PropertySerializationSet

Specifies the names of properties that are serialized. Use this parameter when the value of the
**SerializationMethod** parameter is **SpecificProperties**.

```yaml
Type: System.String[]
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecondValue

Specifies additional values for **AliasProperty**, **ScriptProperty**, **CodeProperty**, or
**CodeMethod** members.

Use this parameter with the **TypeName**, **MemberType**, **Value**, and **SecondValue** parameters to add
or change a property or method of a type.

When the value of the **MemberType** parameter is `AliasProperty`, the value of the **SecondValue**
parameter must be a data type. PowerShell converts (that is, casts) the value of the alias property
to the specified type. For example, if you add an alias property that provides an alternate name for
a string property, you can also specify a **SecondValue** of **System.Int32** to convert the aliased
string value to an integer.

When the value of the **MemberType** parameter is `ScriptProperty`, you can use the **SecondValue**
parameter to specify an additional script block. The script block in the value of the **Value**
parameter gets the value of a variable. The script block in the value of the **SecondValue** parameter
set the value of the variable.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Object
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SerializationDepth

Specifies how many levels of type objects are serialized as strings. The default value `1`
serializes the object and its properties. A value of `0` serializes the object, but not its
properties. A value of `2` serializes the object, its properties, and any objects in property
values.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Int32
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -SerializationMethod

Specifies a serialization method for the type. A serialization method determines which properties of
the type are serialized and the technique that is used to serialize them. The acceptable values for
this parameter are:

- `AllPublicProperties`. Serialize all public properties of the type. You can use the
  **SerializationDepth** parameter to determine whether child properties are serialized.
- `String`. Serialize the type as a string. You can use the **StringSerializationSource** to specify
  a property of the type to use as the serialization result. Otherwise, the type is serialized by
  using the **ToString** method of the object.
- `SpecificProperties`. Serialize only the specified properties of this type. Use the
  **PropertySerializationSet** parameter to specify the properties of the type that are serialized.
  You can also use the **InheritPropertySerializationSet** parameter to determine whether the
  property set is inherited and the **SerializationDepth** parameter to determine whether child
  properties are serialized.

In PowerShell, serialization methods are stored in **PSStandardMembers** internal objects.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StringSerializationSource

Specifies the name of a property of the type. The value of specified property is used as the
serialization result. This parameter is valid only when the value of the **SerializationMethod**
parameter is String.

```yaml
Type: System.String
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetTypeForDeserialization

Specifies the type to which object of this type are converted when they are deserialized.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Type
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeAdapter

Specifies the type of a type adapter, such as **Microsoft.PowerShell.Cim.CimInstanceAdapter**. A
type adapter enables PowerShell to get the members of a type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Type
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeConverter

Specifies a type converter to convert values between different types. If a type converter is defined
for a type, an instance of the type converter is used for the conversion.

Enter a **System.Type** value that is derived from the **System.ComponentModel.TypeConverter** or
**System.Management.Automation.PSTypeConverter** classes.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Type
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeData

Specifies an array of type data that this cmdlet adds to the session. Enter a variable that contains
a **TypeData** object or a command that gets a **TypeData** object, such as a `Get-TypeData`
command. You can also pipe a **TypeData** object to `Update-TypeData`.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.Runspaces.TypeData[]
Parameter Sets: TypeDataSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TypeName

Specifies the name of the type to extend.

For types in the **System** namespace, enter the short name. Otherwise, the full type name is
required. Wildcards are not supported.

You can pipe type names to `Update-TypeData`. When you pipe an object to `Update-TypeData`,
`Update-TypeData` gets the type name of the object and type data to the object type.

Use this parameter with the **MemberName**, **MemberType**, **Value** and **SecondValue** parameters
to add or change a property or method of a type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: DynamicTypeSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Value

Specifies the value of the property or method.

If you add an `AliasProperty`, `CodeProperty`, `ScriptProperty`, or `CodeMethod` member, you can use
the **SecondValue** parameter to add additional information.

Use this parameter with the **MemberName**, **MemberType**, **Value** and **SecondValue** parameters
to add or change a property or method of a type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Object
Parameter Sets: DynamicTypeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

You can pipe a string that contains the values of the **AppendPath**, **TypeName**, or **TypeData**
parameters to `Update-TypeData`.

## Outputs

### None

This cmdlet does not return any output.

## Notes

## Related links

[about_Types.ps1xml](../Microsoft.PowerShell.Core/About/about_Types.ps1xml.md)

[Get-TypeData](Get-TypeData.md)

[Remove-TypeData](Remove-TypeData.md)

