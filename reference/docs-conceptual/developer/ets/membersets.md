---
ms.date: 07/09/2020
ms.topic: reference
title: Extended Type System member sets
description: Extended Type System member sets
---
# ETS member sets

Member sets allow you to partition the members of the **PSObject** object into two subsets so that
the members of the subsets can be referenced together by their subset name. The two types of subsets
include property sets and member sets. For example of how PowerShell uses member sets, there is a
specific property set named **DefaultDisplayPropertySet** that is used to determine, at runtime,
which properties to display for a given **PSObject** object.

## Property Sets

Property sets can include any number of properties of an **PSObject** type. In general, a property
set can be used whenever a collection of properties (of the same type) is needed. The property set
is created by calling the
`PSPropertySet(System.String,System.Collections.Generic.IEnumerable{System.String})` constructor
with the name of the property set and the names of the referenced properties. The created
**PSPropertySet** object can then be used as an alias that points to the properties in the set. The
[PSPropertySet](/dotnet/api/system.management.automation.pspropertyset) class has the following
properties and methods.

- **IsInstance** property: Gets a **Boolean** value that indicates the source of the property.
- **MemberType** property: Gets the type of properties in the property set.
- **Name** property: Gets the name of the property set.
- **ReferencedPropertyNames** property: Gets the names of the properties in the property set.
- **TypeNameOfValue** property: Gets a **PropertySet** enumeration constant that defines this set as
  a property set.
- **Value** property: Gets or sets the **PSPropertySet** object.
- `PSPropertySet.Copy` method: Makes an exact copy of the **PSPropertySet** object.
- `PSMemberSet.ToString` method: Converts the **PSPropertySet** object to a string.

## Member Sets

Member sets can include any number of extended members of any type. The member set is created by
calling the
`PSMemberSet(System.String,System.Collections.Generic.IEnumerable{System.Management.Automation.PSMemberInfo})`
constructor with the name of the member set and the names of the referenced members. The created
**PSPropertySet** object can then be used as an alias that points to the members in the set. The
[PSMemberSet](/dotnet/api/system.management.automation.psmemberset) class has the following
properties and methods.

- **IsInstance** property: Gets a **Boolean** value that indicates the source of the member.
- **Members** property: Gets all the members of the member set.
- **MemberType** property: Gets a **MemberSet** enumeration constant that defines this set as a
  member set.
- **Methods** property: Gets the methods included in the member set.
- **Properties** property: Gets the properties included in the member set.
- **TypeNameOfValue** property: Gets a **MemberSet** enumeration constant that defines this set as a
  member set.
- **Value** property: Gets the **PSMemberSet** object.
- `PSMemberSet.Copy` method: Makes an exact copy of the **PSMemberSet** object.
- `PSMemberSet.ToString` method: Converts the **PSMemberSet** object to a string.
