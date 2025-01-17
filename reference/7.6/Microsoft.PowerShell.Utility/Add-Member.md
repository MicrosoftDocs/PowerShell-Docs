---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 03/06/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/add-member?view=powershell-7.6&WT.mc_id=ps-gethelp
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
Add-Member -InputObject <PSObject> [-TypeName <String>] [-Force] [-PassThru]
 [-NotePropertyName] <String> [-NotePropertyValue] <Object> [<CommonParameters>]
```

### MemberSet

```
Add-Member -InputObject <PSObject> [-MemberType] <PSMemberTypes> [-Name] <String>
 [[-Value] <Object>] [[-SecondValue] <Object>] [-TypeName <String>] [-Force] [-PassThru]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-Member` cmdlet lets you add members (properties and methods) to an instance of a PowerShell
object. For instance, you can add a **NoteProperty** member that contains a description of the
object or a **ScriptMethod** member that runs a script to change the object.

To use `Add-Member`, pipe the object to `Add-Member`, or use the **InputObject** parameter to
specify the object.

The **MemberType** parameter indicates the type of member that you want to add. The **Name**
parameter assigns a name to the new member, and the **Value** parameter sets the value of the
member.

The properties and methods that you add are added only to the particular instance of the object that
you specify. `Add-Member` doesn't change the object type. To create a new object type, use the
`Add-Type` cmdlet.

You can also use the `Export-Clixml` cmdlet to save the instance of the object, including the
additional members, in a file. Then you can use the `Import-Clixml` cmdlet to re-create the instance
of the object from the information that's stored in the exported file.

Beginning in Windows PowerShell 3.0, `Add-Member` has new features that make it easier to add note
properties to objects. You can use the **NotePropertyName** and **NotePropertyValue** parameters to
define a note property or use the **NotePropertyMembers** parameter, which takes a hash table of
note property names and values.

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
`$a`. As the output shows, the value is `Done`.

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

The second command adds the **Size** alias property. The third command uses dot notation to get the
value of the new **Size** property.

```powershell
$A = Get-ChildItem C:\Temp\test.txt
$A | Add-Member -MemberType AliasProperty -Name Size -Value Length
$A.Size
```

```Output
2394
```

### Example 3: Add a StringUse note property to a string

This example adds the **StringUse** note property to a string. Because `Add-Member` can't add types
to **String** input objects, you can specify the **PassThru** parameter to generate an output
object. The last command in the example displays the new property.

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

This example adds the **SizeInMB** script method to a **FileInfo** object that calculates the file
size to the nearest MegaByte. The second command creates a **ScriptBlock** that uses the **Round**
static method from the `[math]` type to round the file size to the second decimal place.

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

### Example 5: Create a custom object

This example creates an **Asset** custom object.

The `New-Object` cmdlet creates a **PSObject** that's saved in the `$Asset` variable. The
`[ordered]` type accelerator creates an ordered dictionary that's stored in the `$d` variable.
Piping `$Asset` to `Add-Member` adds the key-value pairs in the dictionary to the object as
**NoteProperty** members. **TypeName** parameter assigns the type `Asset` to the **PSObject**. The
`Get-Member` cmdlet shows the type and properties of the object. However, the properties are listed
in alphabetical order, not in the order that they were added.

```powershell
$Asset = New-Object -TypeName PSObject
$d = [ordered]@{Name="Server30"; System="Server Core"; PSVersion="4.0"}
$Asset | Add-Member -NotePropertyMembers $d -TypeName Asset
$Asset | Get-Member -MemberType Properties
```

```Output
   TypeName: Asset

Name        MemberType   Definition
----        ----------   ----------
Name        NoteProperty string Name=Server30
PSVersion   NoteProperty string PSVersion=4.0
System      NoteProperty string System=Server Core
```

```powershell
$Asset.PSObject.Properties | Format-Table Name, MemberType, TypeNameOfValue, Value
```

```Output
Name        MemberType TypeNameOfValue Value
----        ---------- --------------- -----
Name      NoteProperty System.String   Server30
System    NoteProperty System.String   Server Core
PSVersion NoteProperty System.String   4.0
```

Inspecting the raw list of properties shows the properties in the order that they were added to
the object. `Format-Table` is used in this example to create output similar to `Get-Member`.

### Example 6: Add an AliasProperty to an object

In this example we create a custom object that contains two **NoteProperty** members. The type for a
**NoteProperty** reflects the type of the value stored in the property. In this case, the **Age**
property is a string.

```powershell
PS> $obj = [pscustomobject]@{
      Name = 'Doris'
      Age = '20'
}
PS> $obj | Add-Member -MemberType AliasProperty -Name 'intAge' -Value age -SecondValue uint32
PS> $obj | Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType    Definition
----        ----------    ----------
intAge      AliasProperty intAge = (System.UInt32)age
Equals      Method        bool Equals(System.Object obj)
GetHashCode Method        int GetHashCode()
GetType     Method        type GetType()
ToString    Method        string ToString()
Age         NoteProperty  string Age=20
Name        NoteProperty  string Name=Doris

PS> $obj

Name  Age intAge
----  --- ------
Doris 20      20

PS> $obj.Age + 1

201

PS> $obj.intAge + 1

21
```

The **intAge** property is an **AliasProperty** for the **Age** property, but the type is guaranteed
to be **uint32**.

### Example 7: Add get and set methods to a custom object

This examples shows how to define **Get** and **Set** methods that access a deeply nested property.

```powershell
$user = [pscustomobject]@{
    Name      = 'User1'
    Age       = 29
    StartDate = [datetime]'2019-05-05'
    Position  = [pscustomobject]@{
        DepartmentName = 'IT'
        Role = 'Manager'
    }
}
$addMemberSplat = @{
    MemberType = 'ScriptProperty'
    Name = 'Title'
    Value = { $this.Position.Role }                  # getter
    SecondValue = { $this.Position.Role = $args[0] } # setter
}
$user | Add-Member @addMemberSplat
$user | Get-Member
```

```Output
   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType     Definition
----        ----------     ----------
Equals      Method         bool Equals(System.Object obj)
GetHashCode Method         int GetHashCode()
GetType     Method         type GetType()
ToString    Method         string ToString()
Age         NoteProperty   int Age=29
Name        NoteProperty   string Name=User1
Position    NoteProperty   System.Management.Automation.PSCustomObject Position=@{DepartmentName=IT; Role=Manager}
StartDate   NoteProperty   datetime StartDate=5/5/2019 12:00:00 AM
Title       ScriptProperty System.Object Title {get= $this.Position.Role ;set= $this.Position.Role = $args[0] ;}
```

```powershell
$user.Title = 'Dev Manager'
```

```Output
Name      : User1
Age       : 29
StartDate : 5/5/2019 12:00:00 AM
Position  : @{DepartmentName=IT; Role=Dev Manager}
Title     : Dev Manager
```

Notice that the **Title** property is a **ScriptProperty** that has a **Get** and **Set** method.
When we assign a new value to the **Title** property, the **Set** method is called and changes the
value of the **Role** property in the **Position** property.

## PARAMETERS

### -Force

By default, `Add-Member` can't add a new member if the object already has a member with the same.
When you use the **Force** parameter, `Add-Member` replaces the existing member with the new member.
You can't use the **Force** parameter to replace a standard member of a type.

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

Specifies the object to which the new member is added. Enter a variable that contains the objects,
or type a command or expression that gets the objects.

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

Specifies the type of the member to add. This parameter is required. The acceptable values for this
parameter are:

- AliasProperty
- CodeMethod
- CodeProperty
- NoteProperty
- ScriptMethod
- ScriptProperty

For information about these values, see
[PSMemberTypes Enumeration](xref:System.Management.Automation.PSMemberTypes) in the PowerShell SDK.

Not all objects have every type of member. If you specify a member type that the object doesn't
have, PowerShell returns an error.

```yaml
Type: System.Management.Automation.PSMemberTypes
Parameter Sets: MemberSet
Aliases: Type
Accepted values: AliasProperty, CodeMethod, CodeProperty, NoteProperty, ScriptMethod, ScriptProperty

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

Specifies a hashtable or ordered dictionary that contains key-value pair representing
**NoteProperty** names and their values. For more information about hash tables and ordered
dictionaries in PowerShell, see
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

Use this parameter with the **NotePropertyValue** parameter. This parameter is optional.

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

Use this parameter with the **NotePropertyName** parameter. This parameter is optional.

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

Returns an object representing the item with which you are working. By default, this cmdlet doesn't
generate any output.

For most objects, `Add-Member` adds the new members to the input object. However, when the input
object is a string, `Add-Member` can't add the member to the input object. For these objects, use
the **PassThru** parameter to create an output object.

In Windows PowerShell 2.0, `Add-Member` added members only to the **PSObject** wrapper of objects,
not to the object. Use the **PassThru** parameter to create an output object for any object that has
a **PSObject** wrapper.

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

Specifies optional additional information about **AliasProperty**, **ScriptProperty**, or
**CodeProperty** members.

If used when adding an **AliasProperty**, this parameter must be a data type. A conversion to the
specified data type is added to the value of the **AliasProperty**. For example, if you add an
**AliasProperty** that provides an alternate name for a string property, you can also specify a
**SecondValue** parameter of **System.Int32** to indicate that the value of that string property
should be converted to an integer when accessed using the corresponding **AliasProperty**.

For a **CodeProperty**, the value must be a reference to a method that implements a **Set**
accessor. Use the `GetMethod()` method of a type reference to get a reference to a method. The
method must take a single parameter that's a **PSObject**. The **Get** accessor is assigned using
the **Value** parameter.

For a **ScriptProperty**, the value must be a script block that implements a **Set** accessor. The
**Get** accessor is assigned using the **Value** parameter.

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

### -TypeName

Specifies a name for the type.

When the type is a class in the **System** namespace or a type that has a type accelerator, you can
enter the short name of the type. Otherwise, the full type name is required. This parameter is
effective only when the **InputObject** is a **PSObject**.

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

### -Value

Specifies the initial value of the added member. If you add an **AliasProperty**, **CodeProperty**,
or **ScriptProperty** member, you can supply additional information using the **SecondValue**
parameter.

- For an **AliasProperty**, the value must be the name of the property being aliased.
- For a **CodeMethod**, the value must be a reference to a method. Use the `GetMethod()` method of
  a type reference to get a reference to a method.
- For a **CodeProperty**, the value must be a reference to a method that implements a **Get**
  accessor. Use the `GetMethod()` method of a type reference to get a reference to a method.
  reference. The method must take a single parameter that's a **PSObject**. The **Set** accessor is
  assigned using the **SecondValue** parameter.
- For a **ScriptMethod**, the value must be a script block.
- For a **ScriptProperty**, the value must be a script block that implements a **Get** accessor. The
  **Set** accessor is assigned using the **SecondValue** parameter.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to this cmdlet.

## OUTPUTS

### None

By default, this cmdlet returns no output.

### System.Object

When you use the **PassThru** parameter, this cmdlet returns the newly extended object.

## NOTES

You can add members only to **PSObject** type objects. To determine whether an object is a
**PSObject** object, use the `-is` operator. For instance, to test an object stored in the `$obj`
variable, type `$obj -is [psobject]`.

**PSObject** type objects maintain their list of members in the order that the members were added to
the object.

The names of the **MemberType**, **Name**, **Value**, and **SecondValue** parameters are optional.
If you omit the parameter names, the unnamed parameter values must appear in this order:
**MemberType**, **Name**, **Value**, and **SecondValue**.

If you include the parameter names, the parameters can appear in any order.

You can use the `$this` automatic variable in script blocks that define the values of new properties
and methods. The `$this` variable refers to the instance of the object to which the properties and
methods are being added. For more information about the `$this` variable, see
[about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md).

## RELATED LINKS

[Export-Clixml](Export-Clixml.md)

[Get-Member](Get-Member.md)

[Import-Clixml](Import-Clixml.md)

[New-Object](New-Object.md)

[about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md)

[System.Type.GetMethod()](/dotnet/api/system.type.getmethod)
