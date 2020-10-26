---
ms.date: 07/09/2020
ms.topic: reference
title: Extended Type System properties
description: Extended Type System properties
---
# ETS properties

Properties are members that can be treated as a property. Essentially, they can appear on the
left-hand side of an expression. The properties that are available include alias, code, note, and
script properties.

## Alias Property

An alias property is a property that references another property that the **PSObject** object
contains. It is used primarily to rename the referenced property. However, it may also be used to
convert the referenced property's value to another type. With respect to ETS, this type of property
is always an extended-member and is defined by the
[PSAliasProperty](/dotnet/api/system.management.automation.psaliasproperty) class. The class includes the following properties.

- **ConversionType** property: The CLR type used to convert the referenced member's value.
- **IsGettable** property: Indicates whether the value of the referenced property can be retrieved.
  This property is dynamically determined by examining the **IsGettable** property of the referenced
  property.
- **IsSettable** property: Indicates whether the value of the referenced property can be set. This
  property is dynamically determined by examining the **IsSettable** property of the referenced
  property.
- **MemberType** property: An **AliasProperty** enumeration constant that defines this property as
  an alias property.
- **ReferencedMemberName** property: The name of the referenced property that this alias refers to.
- **TypeNameOfValue** property: The full name of the CLR type of the referenced property's value.
- **Value** property: The value of the referenced property.

## Code Property

A code property is a property that is a getter and setter that is defined in a CLR language. In
order for a code property to become available, a developer must write the property in some CLR
language, compile, and ship the resultant assembly. This assembly must be available in the runspace
where the code property is desired. With respect to ETS, this type of property is always an
extended-member and is defined by the
[PSCodeProperty](/dotnet/api/system.management.automation.pscodeproperty) class. The class includes
the following properties.

- **GetterCodeReference** property: The method used to get the value of the code property.
- **IsGettable** property: Indicates whether the value of the code property can be retrieved, that
  the **SetterCodeReference** property: The method used to set the value of the code property.
- **IsSettable** property: Indicates whether the value of the code property can be set, that the
  **SetterCodeReference** property is not null.
- **MemberType** property: A **CodeProperty** enumeration constant that defines this property as a
  code property.
- **SetterCodeReference** property: The method used to get the value of the code property.
- **TypeNameOfValue** property: The CLR type of the code property value that is returned by the
  properties get operation.
- **Value** property: The value of the code property. When this property is retrieved, the getter
  code in the GetterCodeReference property is invoked, passing the current **PSObject** object and
  returning the value returned by the invocation. When this property is set, the setter code in the
  **SetterCodeReference** property is invoked, passing the current **PSObject** object as the first
  argument and the object used to set the value as the second argument.

## Note Property

A Note property is a property that has a name/value pairing. With respect to ETS, this type of
property is always an extended-member and is defined by the
[PSNoteProperty](/dotnet/api/system.management.automation.psnoteproperty) class. The class includes
the following properties.

- **IsGettable** property: Indicates whether the value of the note property can be retrieved.
- **IsSettable** property: Indicates whether the value of the note property can be set.
- **MemberType** property: A **NoteProperty** enumeration constant that defines this property as a
  note property.
- **TypeNameOfValue** property: The fully-qualified type name of the object returned by the note
  property's get operation.
- **Value**: The value of the note property.

## PowerShell property

A PowerShell property is a property defined on the base object or a property that is made available
through an adapter. It can refer to both CLR fields as well as CLR properties. With respect to ETS,
this type of property can be either a base-member or an adapter-member and is defined by the
[PSProperty](/dotnet/api/system.management.automation.psproperty) class. The class includes the
following properties.

- **IsGettable** property: Indicates whether the value of the base or adapted property can be
  retrieved.
- **IsSettable** property: Indicates whether the value of the base or adapted property can be set.
- **MemberType** property: A Property enumeration constant that defines this property as a
  PowerShell property.
- **TypeNameOfValue** property: The fully-qualified name of the property value type. For example,
  for a property whose value is a string, its property value type is **System.String**.
- **Value** property: The value of the property. If the get or set operation is called on a property
  that does not support that operation, an **GetValueException** or **SetValueException** exception
  is thrown

## PowerShell Script property

A Script property is a property that has getter and setter scripts. With respect to ETS, this type
of property is always an extended-member and is defined by the
[PSScriptProperty](/dotnet/api/system.management.automation.psscriptproperty) class. The class
includes the following properties.

- **GetterScript** property: The script used to retrieve the script property value.
- **IsGettable** property: Indicates whether the **GetterScript** property exposes a script block.
- **IsSettable** property: Indicates whether the **SetterScript** property exposes a script block.
- **MemberType** property: An ScriptProperty enumeration constant that identifies this property as a
  script property.
- **SetterScript** property: The script used to set the script property value.
- **TypeNameOfValue** property: The fully-qualified type name of the object returned by the getter
  script. In this case **System.Object** is always returned.
- **Value** property: The value of the script property. A get invokes the getter script and returns
  the value provided. A set invokes the setter script.
