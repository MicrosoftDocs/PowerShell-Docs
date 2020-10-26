---
ms.date: 07/09/2020
ms.topic: reference
title: Extended Type System class members
description: Extended Type System class members
---
# Extended Type System class members

ETS refers to a number of different kinds of members whose types are defined by the
**PSMemberTypes** enumeration. These member types include properties, methods, members, and member
sets that are each defined by their own CLR type. For example, a **NoteProperty** is defined by its
own **PSNoteProperty** type. These individual CLR types have both their own unique properties and
common properties that are inherited from the
[PSMemberInfo class](/dotnet/api/system.management.automation.psmemberinfo).

## The PSMemberInfo class

The **PSMemberInfo** class serves as a base class for all ETS member types. This class provides the
following base properties to all member CLR types.

- **Name** property: The name of the member. This name can be defined by the base-object or defined
  by PowerShell when adapted members or extended members are exposed.
- **Value** property: The value returned from the particular member. Each member type defines how it
  handles its member value.
- **TypeNameOfValue** property: This is the name of the CLR type of the value that is returned by
  the Value property.

## Accessing members

Collections of members can be accessed through the **Members**, **Methods**, and **Properties**
properties of the **PSObject** object.

## ETS properties

ETS properties are members that can be treated as a property. Essentially, they can appear on the
left-hand side of an expression. They include alias properties, code properties, PowerShell
properties, note properties, and script properties. For more information about these types of
properties, see [ETS properties](properties.md).

## ETS methods

ETS methods are members that can take arguments, may return results, and cannot appear on the
left-hand side of an expression. They include code methods, PowerShell methods, and script methods.
For more information about these types of methods, see [ETS methods](methods.md).
