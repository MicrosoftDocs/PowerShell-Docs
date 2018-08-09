---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821748
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Add-Member
---

# Add-Member

## SYNOPSIS
Adds custom properties and methods to an instance of a PowerShell object.

## SYNTAX

### TypeNameSet (Default)
```powershell
Add-Member -InputObject <PSObject> -TypeName <String> [-PassThru]
 [<CommonParameters>]
```

### MemberSet
```powershell
Add-Member [-MemberType] <PSMemberTypes> [-Name] <String>
 [[-Value] <Object>] [[-SecondValue] <Object>]
 -InputObject <PSObject> [-TypeName <String>] [-Force] [-PassThru]
 [<CommonParameters>]
```

### NotePropertySingleMemberSet
```powershell
Add-Member [-NotePropertyName] <String> [-NotePropertyValue] <Object>
 -InputObject <PSObject> [-TypeName <String>] [-Force] [-PassThru]
 [<CommonParameters>]
```

### NotePropertyMultiMemberSet
```powershell
Add-Member [-NotePropertyMembers] <IDictionary>
 -InputObject <PSObject> [-TypeName <String>] [-Force] [-PassThru]
 [<CommonParameters>]
```

## DESCRIPTION
The **Add-Member** cmdlet lets you add members (properties and methods) to an instance of a PowerShell object.
For instance, you can add a NoteProperty member that contains a description of the object or a ScriptMethod member that runs a script to change the object.

To use **Add-Member**, pipe the object to **Add-Member**, or use the **InputObject** parameter to specify the object.
Use the *MemberType* parameter to specify the type of member that you want to add, use the *Name* parameter to assign a name to the new member, and use the *Value* parameter to set the value of the member.

The properties and methods that you add are added only to the particular instance of the object that you specify.
**Add-Member** does not change the object type.
To create a new object type, use the Add-Type cmdlet.
You can also use the Export-Clixml cmdlet to save the instance of the object, including the additional members, in a file.
Then you can use the Import-Clixml cmdlet to re-create the instance of the object from the information that is stored in the exported file.

Beginning in Windows PowerShell 3.0, **Add-Member** has new features that make it easier to add note properties to objects.
You can use the **NotePropertyName** and **NotePropertyValue** parameters to define a note property or use the **NotePropertyMembers** parameter, which takes a hash table of note property names and values.

Also, beginning in Windows PowerShell 3.0, the *PassThru* parameter, which generates an output object, is needed less frequently.
**Add-Member** now adds the new members directly to the input object of more types.
For more information, see the *PassThru* parameter description.

## EXAMPLES

### Example 1: Add a note property to a PSObject
```
PS C:\> $A = dir c:\ps-test\test.txt
PS C:\> $A | Add-Member -NotePropertyName Status -NotePropertyValue Done
PS C:\> $A | Add-Member Status Done
PS C:\> $A.Status
Done
```

These commands add the Status note property with a value of "Done" to the FileInfo object that represents the Test.txt file.

The first command uses the Get-ChildItem cmdlet (alias = "dir) to get the Test.txt file.
It saves it in the $a variable.

The second and third commands add the note property to the object in $a.
The third command omits the optional parameter names, so the parameter values must be in the correct Name-Value order.
These commands are equivalent and can be used interchangeably.

The fourth command uses dot notation to get the value of the Status property of the object in $a.
As the output shows, the value is "Done".

### Example 2: Add an alias property to a PSObject
```
PS C:\> $A = dir c:\ps-test\test.txt
PS C:\> $A | Add-Member -MemberType AliasProperty -Name FileLength -Value Length
PS C:\> $A.FileLength
2394
```

These commands add the FileLength alias property to the object that represents the Test.txt file.
The new property is an alias for the Length property.

The first command use the Get-ChildItem  cmdlet (alias = "dir") to get the Test.txt file.

The second command adds the FileLength alias property.

The third command uses dot notation to get the value of the new FileLength property.

### Example 3: Add a StringUse note property to a string
```
PS C:\> $A = "A string"
PS C:\>  $A = $A | Add-Member @{StringUse="Display"} -PassThru
PS C:\> $A.StringUse
Display
```

These commands add the **StringUse** note property to a string.
Because Add-Member cannot add types to String input objects, the command uses the  *PassThru* parameter to generate an output object.
The last command in the example displays the new property.

The command uses the *NotePropertyMembers* parameter, but omits the parameter name, which is optional.
The value of the *NotePropertyMembers* parameter is a hash table.
The key is the note property name, **StringUse**, and the value is the note property value, Display.

### Example 4: Add a script method to a string object
```
PS C:\> $A = "This is a string."
PS C:\> $A = Add-Member -InputObject $A -MemberType ScriptMethod -Name "PadBoth" -Value {$P = $this.PadLeft($this.Length + 1); $p.PadRight($p.Length + 1)} -PassThru
PS C:\> $A.Padboth()
This is a string.
```

These commands add the PadBoth script method to a string object.

The first command creates a string and saves it in the $A variable.

The second command adds the Padboth script method to the object in the $A variable.
The *Value* parameter defines the new script method.
It uses the PadRight and PadLeft methods of a string to add one space the left and one space to the right of the string.

The *Value* parameter also uses the $This automatic variable, which represents the current object.
The $This variable is valid only in script blocks that define new properties and methods.

The command includes the *PassThru* parameter, which directs **Add-Member** to return an instance of the object that includes the new script property.
By default, **Add-Member** adds members to **PSObject**s and does not generate any output.

The third command uses dot notation to call the new PadBoth script method on the object in the $A variable.

### Example 5: Add an alias property to an event
```
PS C:\> $Event = Get-EventLog -LogName System -Newest 1
PS C:\> $Event.TimeWritten | Get-MemberTypeName: System.DateTime
Name                 MemberType     Definition
----                 ----------     ----------
Add                  Method         System.DateTime Add(System.TimeSpan value)
AddDays              Method         System.DateTime AddDays(double value)
AddHours             Method         System.DateTime AddHours(double value)
AddMilliseconds      Method         System.DateTime AddMilliseconds(double value)
AddMinutes           Method         System.DateTime AddMinutes(double value)...

PS C:\> Add-Member -InputObject $Event -MemberType AliasProperty -Name When -Value TimeWritten -SecondValue System.String
PS C:\> $Event.When | Get-MemberTypeName: System.String

Name             MemberType            Definition
----             ----------            ----------
Clone            Method                System.Object Clone()
CompareTo        Method                int CompareTo(System.Object value), int CompareTo(string strB)
Contains         Method                bool Contains(string value)
```

These commands add the When alias property to an event in the System event log.
The event is an **EventLogEntry** object that is returned by the Get-EventLog cmdlet.

The When alias property is an alias for the TimeWritten property of the object.
The *SecondValue* parameter is used to specify that the property value should be converted to type System.String when accessed by using the **AliasProperty**.
The TimeWritten property is a **DateTime** object.

The first command uses the Get-EventLog cmdlet to get the newest event in the System event log.
It stores the event in the $Event variable.

To demonstrate that the TimeWritten property is a **DateTime** type, the second command uses dot notation to get the TimeWritten property of that event and pipes it to the Get-Member cmdlet.

The third command uses the **Add-Member** cmdlet to add the When alias property to the object instance in the $Event variable.
The *Name* parameter assigns the name, When, and the *Value* parameter specifies that When is an alias for the TimeWritten property.
The *SecondValue* parameter indicates that the value that the When method returns should be cast to a **System.String** type.

The fourth command uses dot notation to call the new When method.
The command pipes the method value to the **Get-Member** cmdlet to confirm that it has returned a string.

### Example 6: Copy all properties of an object to another
```
PS C:\> function Copy-Property ($From, $To)
{     foreach ($p in Get-Member -InputObject $From -MemberType Property)
  {     Add-Member -InputObject $To -MemberType NoteProperty -Name $p.Name
     -Value $From.$($p.Name) -Force     $To.$($p.Name) = $From.$($p.Name)
  }
}
```

This function copies all of the properties of one object to another object.

The first command in the function declares the function name and lists its parameters.

The ForEach loop uses the Get-Member cmdlet to get each of the properties of the **From** object.
The commands within the ForEach loop are performed in series on each of the properties.

The **Add-Member** command adds the property of the **From** object to the **To** object as a NoteProperty.
It uses the *Force* parameter to add members with the same member name.

The last command in the function gives the new property the same name as the original property.

### Example 7: Create a custom object
```
PS C:\> $Asset = New-Object -TypeName PSObject
PS C:\> $d = [ordered]@{Name="Server30";System="Server Core";PSVersion="4.0"}
PS C:\> $Asset | Add-Member -NotePropertyMembers $d -TypeName Asset
PS C:\> $Asset | Get-Member   TypeName: Asset
Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj) GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
Name        NoteProperty System.String Name=Server30
PSVersion   NoteProperty System.String PSVersion=4.0
System      NoteProperty System.String System=Server Core
```

This example creates the **Asset** custom object.

The first command uses the New-Object cmdlet to create a **PSObject**.
The command saves the **PSObject** in the $Asset variable.

The second command uses the \[ordered\] type accelerator to create an ordered dictionary of names and values.
The command saves the result in the $D variable.

The third command uses the **NotePropertyMembers** parameter of the **Add-Member** cmdlet to add the dictionary in the $D variable to the **PSObject**.
It uses the TypeName property to assign a new name, Asset, to the **PSObject**.

The fourth command sends the new **Asset** object in the $Asset variable to the Get-Member cmdlet.
The output shows that the object has a type name of "Asset" and the note properties that we defined in the ordered dictionary.

## PARAMETERS

### -Force
Indicates that this cmdlet adds a new member even the object has a custom member with the same name.
You cannot use the *Force* parameter to replace a standard member of a type.

```yaml
Type: SwitchParameter
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
Type: PSObject
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
- CopyMethod

For information about these values, see [PSMemberTypes Enumeration](https://msdn.microsoft.com/library/system.management.automation.psmembertypes) in the MSDN library.

Not all objects have every type of member.
If you specify a member type that the object does not have, PowerShell returns an error.

```yaml
Type: PSMemberTypes
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
Type: String
Parameter Sets: MemberSet
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

For most objects, **Add-Member** adds the new members to the input object.
However, when the input object is a string, **Add-Member** cannot add the member to the input object.
For these objects, use the *PassThru* parameter to create an output object.

In Windows PowerShell 2.0, **Add-Member** added members only to the PSObject wrapper of objects, not to the object.
Use the *PassThru* parameter to create an output object for any object that has a PSObject wrapper.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecondValue
Specifies optional additional information about **AliasProperty**, **ScriptProperty**, **CodeProperty**, or **CodeMethod** members.
If used when adding an AliasProperty, this parameter must be a data type.
A conversion to the specified data type is added to the value of the AliasProperty.
For example, if you add an AliasProperty that provides an alternate name for a string property, you can also specify a *SecondValue* parameter of System.Int32 to indicate that the value of that string property should be converted to an integer when accessed by using the corresponding AliasProperty.

You can use the *SecondValue* parameter to specify an additional ScriptBlock when adding a *ScriptProperty* member.
In that case, the first ScriptBlock, specified in the Value parameter, is used to get the value of a variable.
The second ScriptBlock, specified in the *SecondValue* parameter, is used to set the value of a variable.

```yaml
Type: Object
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
If you add an **AliasProperty**, **CodeProperty**, **ScriptProperty** or **CodeMethod** member, you can supply optional, additional information by using the SecondValue parameter.

```yaml
Type: Object
Parameter Sets: MemberSet
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotePropertyMembers
Specifies a hash table or ordered dictionary of note property names and values.
Type a hash table or dictionary in which the keys are note property names and the values are note property values.

For more information about hash tables and ordered dictionaries in PowerShell, see about_Hash_Tables.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: IDictionary
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

Use this parameter with the *NotePropertyValue* parameter.
This parameter is optional.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
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

Use this parameter with the *NotePropertyName* parameter.
This parameter is optional.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: Object
Parameter Sets: NotePropertySingleMemberSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeName
Specifies a name for the type.

When the type is a class in the System namespace or a type that has a type accelerator, you can enter the short name of the type.
Otherwise, the full type name is required.
This parameter is effective only when the input object is a **PSObject**.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: TypeNameSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: MemberSet, NotePropertySingleMemberSet, NotePropertyMultiMemberSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object type to this cmdlet.

## OUTPUTS

### None or System.Object
When you use the *PassThru* parameter, this cmdlet returns the newly-extended object.
Otherwise, this cmdlet does not generate any output.

## NOTES
You can add members only to PSObject objects. To determine whether an object is a PSObject object, use the "is" operator. For instance, to test an object stored in the $obj variable, type `$obj -is \[PSObject\]`.

The names of the *MemberType*, *Name*, *Value*, and *SecondValue* parameters are optional.
If you omit the parameter names, the unnamed parameter values must appear in this order: *MemberType*, *Name*, *Value*, and *SecondValue*.
If you include the parameter names, the parameters can appear in any order.

You can use the $this automatic variable in script blocks that define the values of new properties and methods.
The $this variable refers to the instance of the object to which the properties and methods are being added.
For more information about the $this variable, see about_Automatic_Variables.

## RELATED LINKS

[Export-Clixml](Export-Clixml.md)

[Get-Member](Get-Member.md)

[Import-Clixml](Import-Clixml.md)

[New-Object](New-Object.md)