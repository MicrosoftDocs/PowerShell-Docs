---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/26/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/add-member?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Add-Member
---
# Add-Member

## SYNOPSIS
Adds custom properties and methods to an instance of a PowerShell object.

## SYNTAX

### TypeNameSet (Default)

```
Add-Member -InputObject <PSObject> -TypeName <String> [-PassThru] [<CommonParameters>]
```

### NotePropertyMultiMemberSet

```
Add-Member -InputObject <PSObject> [-TypeName <String>] [-Force] [-PassThru]
 [-NotePropertyMembers] <IDictionary> [<CommonParameters>]
```

### NotePropertySingleMemberSet

```
Add-Member -InputObject <PSObject> [-TypeName <String>] [-Force] [-PassThru] [-NotePropertyName] <String>
 [-NotePropertyValue] <Object> [<CommonParameters>]
```

### MemberSet

```
Add-Member -InputObject <PSObject> [-MemberType] <PSMemberTypes> [-Name] <String> [[-Value] <Object>]
 [[-SecondValue] <Object>] [-TypeName <String>] [-Force] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION

The `Add-Member` cmdlet lets you add members (properties and methods) to an instance of a PowerShell
object. For instance, you can add a NoteProperty member that contains a description of the object or
a **ScriptMethod** member that runs a script to change the object.

To use `Add-Member`, pipe the object to `Add-Member`, or use the **InputObject** parameter to
specify the object.

The **MemberType** parameter indicates the type of member that you want to add. The **Name**
parameter assigns a name to the new member, and the **Value** parameter sets the value of the
member.

The properties and methods that you add are added only to the particular instance of the object that
you specify. `Add-Member` does not change the object type. To create a new object type, use the
`Add-Type` cmdlet.

You can also use the `Export-Clixml` cmdlet to save the instance of the object, including the
additional members, in a file. Then you can use the `Import-Clixml` cmdlet to re-create the instance
of the object from the information that is stored in the exported file.

Beginning in Windows PowerShell 3.0, `Add-Member` has new features that make it easier to add note
properties to objects.
You can use the **NotePropertyName** and **NotePropertyValue** parameters to define a note property
or use the **NotePropertyMembers** parameter, which takes a hash table of note property names and
values.

Also, beginning in Windows PowerShell 3.0, the **PassThru** parameter, which generates an output
object, is needed less frequently. `Add-Member` now adds the new members directly to the input
object of more types. For more information, see the **PassThru** parameter description.

## EXAMPLES

### Example 1: Add a note property to a PSObject

The following example adds a **Status** note property with a value of "Done" to the **FileInfo**
object that represents the `Test.txt` file.

The first command uses the `Get-ChildItem` cmdlet to get a **FileInfo** object representing
the `Test.txt` file. It saves it in the `$a` variable.

The second command adds the note property to the object in `$a`.

The third command uses dot notation to get the value of the **Status** property of the object in
`$a`. As the output shows, the value is "Done".

```powershell
$A = Get-ChildItem c:\ps-test\test.txt
$A | Add-Member -NotePropertyName Status -NotePropertyValue Done
$A.Status
```

```Output
Done
```

### Example 2: Add an alias property to a PSObject

The following example adds a **Size** alias property to the object that represents the `Test.txt`
file. The new property is an alias for the **Length** property.

The first command uses the `Get-ChildItem` cmdlet to get the `Test.txt` **FileInfo** object.

The second command adds the **Size** alias property.
The third command uses dot notation to get the value of the new **Size** property.

```powershell
$A = Get-ChildItem C:\Temp\test.txt
$A | Add-Member -MemberType AliasProperty -Name Size -Value Length
$A.Size
```

```Output
2394
```

### Example 3: Add a StringUse note property to a string

This example adds the **StringUse** note property to a string.
Because `Add-Member` cannot add types to **String** input objects, you can specify the **PassThru**
parameter to generate an output object. The last command in the example displays the new property.

This example uses the **NotePropertyMembers** parameter. The value of the **NotePropertyMembers**
parameter is a hash table. The key is the note property name, **StringUse**, and the value is the
note property value, **Display**.

```powershell
$A = "A string"
$A = $A | Add-Member -NotePropertyMembers @{StringUse="Display"} -PassThru
$A.StringUse
```

```Output
Display
```

### Example 4: Add a script method to a FileInfo object

This example adds the **SizeInMB** script method to a **FileInfo** object which calculates the
file size to the nearest MegaByte. The second command creates a **ScriptBlock** that uses the
**Round** static method from the `[math]` type to round the file size to the second decimal place.

The **Value** parameter also uses the `$This` automatic variable, which represents the current
object. The `$This` variable is valid only in script blocks that define new properties and methods.

The last command uses dot notation to call the new **SizeInMB** script method on the object in the
`$A` variable.

```powershell
$A = Get-ChildItem C:\Temp\test.txt
$S = {[math]::Round(($this.Length / 1MB), 2)}
$A | Add-Member -MemberType ScriptMethod -Name "SizeInMB" -Value $S
$A.SizeInMB()
```

```Output
0.43
```

### Example 5: Copy all properties of an object to another

This function copies all of the properties of one object to another object.

The `foreach` loop uses the `Get-Member` cmdlet to get each of the properties of the **From**
object. The commands within the `foreach` loop are performed in series on each of the properties.

The `Add-Member` command adds the property of the **From** object to the **To** object as a
**NoteProperty**. The value is copied using the **Value** parameter. It uses the **Force** parameter
to add members with the same member name.

```powershell
function Copy-Property ($From, $To)
{
    $properties = Get-Member -InputObject $From -MemberType Property
    foreach ($p in $properties)
    {
        $To | Add-Member -MemberType NoteProperty -Name $p.Name -Value $From.$($p.Name) -Force
    }
}
```

### Example 6: Create a custom object

This example creates an **Asset** custom object.

The `New-Object` cmdlet creates a **PSObject**. The example saves the **PSObject** in the `$Asset`
variable.

The second command uses the `[ordered]` type accelerator to create an ordered dictionary of names
and values. The command saves the result in the `$D` variable.

The third command uses the **NotePropertyMembers** parameter of the `Add-Member` cmdlet to add the
dictionary in the `$D` variable to the **PSObject**.
The **TypeName** property assigns a new name, **Asset**, to the **PSObject**.

The last command pipes the new **Asset** object to the `Get-Member`
cmdlet. The output shows that the object has a type name of **Asset** and the note properties that
we defined in the ordered dictionary.

```powershell
$Asset = New-Object -TypeName PSObject
$d = [ordered]@{Name="Server30";System="Server Core";PSVersion="4.0"}
$Asset | Add-Member -NotePropertyMembers $d -TypeName Asset
$Asset | Get-Member
```

```Output
   TypeName: Asset

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
Name        NoteProperty System.String Name=Server30
PSVersion   NoteProperty System.String PSVersion=4.0
System      NoteProperty System.String System=Server Core
```

## PARAMETERS

### -Force

Indicates that this cmdlet adds a new member even the object has a custom member with the same name.
You cannot use the **Force** parameter to replace a standard member of a type.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: MemberSet, NotePropertySingleMemberSet, NotePropertyMultiMemberSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the object to which the new member is added.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -MemberType

Specifies the type of the member to add.
This parameter is required.
The acceptable values for this parameter are:

- NoteProperty
- AliasProperty
- ScriptProperty
- CodeProperty
- ScriptMethod
- CodeMethod

For information about these values, see [PSMemberTypes Enumeration](/dotnet/api/system.management.automation.psmembertypes)
in the PowerShell SDK.

Not all objects have every type of member.
If you specify a member type that the object does not have, PowerShell returns an error.

```yaml
Type: System.Management.Automation.PSMemberTypes
Parameter Sets: MemberSet
Aliases: Type
Accepted values: AliasProperty, CodeProperty, Property, NoteProperty, ScriptProperty, Properties, PropertySet, Method, CodeMethod, ScriptMethod, Methods, ParameterizedProperty, MemberSet, Event, Dynamic, All

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies the name of the member that this cmdlet adds.

```yaml
Type: System.String
Parameter Sets: MemberSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotePropertyMembers

Specifies a hash table or ordered dictionary of note property names and values.
Type a hash table or dictionary in which the keys are note property names and the values are note
property values.

For more information about hash tables and ordered dictionaries in PowerShell, see
[about_Hash_Tables](../Microsoft.PowerShell.Core/About/about_Hash_Tables.md).

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Collections.IDictionary
Parameter Sets: NotePropertyMultiMemberSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotePropertyName

Specifies the note property name.

Use this parameter with the **NotePropertyValue** parameter.
This parameter is optional.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: NotePropertySingleMemberSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotePropertyValue

Specifies the note property value.

Use this parameter with the **NotePropertyName** parameter.
This parameter is optional.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Object
Parameter Sets: NotePropertySingleMemberSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

For most objects, `Add-Member` adds the new members to the input object.
However, when the input object is a string, `Add-Member` cannot add the member to the input object.
For these objects, use the **PassThru** parameter to create an output object.

In Windows PowerShell 2.0, `Add-Member` added members only to the **PSObject** wrapper of objects,
not to the object.
Use the **PassThru** parameter to create an output object for any object that has a **PSObject**
wrapper.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecondValue

Specifies optional additional information about **AliasProperty**, **ScriptProperty**,
**CodeProperty**, or **CodeMethod** members.

If used when adding an **AliasProperty**, this parameter must be a data type.
A conversion to the specified data type is added to the value of the **AliasProperty**.

For example, if you add an **AliasProperty** that provides an alternate name for a string property,
you can also specify a **SecondValue** parameter of **System.Int32** to indicate that the value of
that string property should be converted to an integer when accessed by using the corresponding
**AliasProperty**.

You can use the **SecondValue** parameter to specify an additional **ScriptBlock** when adding a
**ScriptProperty** member. The first **ScriptBlock**, specified in the **Value** parameter, is
used to get the value of a variable. The second **ScriptBlock**, specified in the
**SecondValue** parameter, is used to set the value of a variable.

```yaml
Type: System.Object
Parameter Sets: MemberSet
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value

Specifies the initial value of the added member.
If you add an **AliasProperty**, **CodeProperty**, **ScriptProperty** or **CodeMethod** member, you
can supply optional, additional information by using the **SecondValue** parameter.

```yaml
Type: System.Object
Parameter Sets: MemberSet
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeName

Specifies a name for the type.

When the type is a class in the **System** namespace or a type that has a type accelerator, you can
enter the short name of the type. Otherwise, the full type name is required.
This parameter is effective only when the **InputObject** is a **PSObject**.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: TypeNameSet, NotePropertyMultiMemberSet, NotePropertySingleMemberSet, MemberSet
Aliases:

Required: True (TypeNameSet), False (NotePropertyMultiMemberSet, NotePropertySingleMemberSet, MemberSet)
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object type to this cmdlet.

## OUTPUTS

### None or System.Object

When you use the **PassThru** parameter, this cmdlet returns the newly-extended object.
Otherwise, this cmdlet does not generate any output.

## NOTES

You can add members only to **PSObject** objects. To determine whether an object is a **PSObject**
object, use the `-is` operator.

For instance, to test an object stored in the `$obj` variable, type `$obj -is [PSObject]`.

The names of the **MemberType**, **Name**, **Value**, and **SecondValue** parameters are optional.
If you omit the parameter names, the unnamed parameter values must appear in this order:
**MemberType**, **Name**, **Value**, and **SecondValue**.

If you include the parameter names, the parameters can appear in any order.

You can use the `$this` automatic variable in script blocks that define the values of new properties
and methods.
The `$this` variable refers to the instance of the object to which the properties and methods are
being added. For more information about the `$this` variable, see [about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md).

## RELATED LINKS

[Export-Clixml](Export-Clixml.md)

[Get-Member](Get-Member.md)

[Import-Clixml](Import-Clixml.md)

[New-Object](New-Object.md)

[about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md)

