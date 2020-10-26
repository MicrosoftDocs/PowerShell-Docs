---
ms.date: 07/09/2020
ms.topic: reference
title: Extended Type System Overview
description: Extended Type System Overview
---
# Extended Type System Overview

PowerShell uses its **PSObject** object to extend the types of objects in two ways. First,
the **PSObject** object provides a way to show different views of specific object types. This is
referred to as showing an adapted view of an object. Second, the **PSObject** object provides a way
to add members to existing object. Together, by wrapping an existing object, referred to as the base
object, the **PSObject** object provides an extended type system (ETS) that script and cmdlet
developers can use to manipulate .NET objects within the shell.

## Cmdlet and Script Development Issues

ETS resolves two fundamental issues:

First, some .NET Objects do not have the necessary default behavior for acting as the data between
cmdlets.

- Some .NET objects are "meta" objects (for example: WMI Objects, ADO objects, and XML objects)
  whose members describe the data they contain. However, in a scripting environment it is the
  contained data that is most interesting, not the description of the contained data. ETS resolves
  this issue by introducing the notion of Adapters that adapt the underlying .NET object to have the
  expected default semantics.
- Some .NET Object members are inconsistently named, provide an insufficient set of public members,
  or provide insufficient capability. ETS resolves this issue by introducing the ability to extend
  the .NET object with additional members.

Second, the PowerShell scripting language is _typeless_ in that a variable does not need to be
declared of a particular type. That is, the variables a script developer creates are by nature
_typeless_. However, the PowerShell system is "type-driven" in that it depends on having a type name
to operate against for basic operations such as outputting results or sorting.

Therefore a script developer must have the ability to state the type of one of their variables and
build up their own set of dynamically typed "objects" that contain properties and methods and can
participate in the type-driven system. ETS solves this problem by providing a common object for the
scripting language that has the ability to state its type dynamically and to add members
dynamically.

Fundamentally, ETS resolves the issue mentioned previously by providing the **PSObject** object,
which acts as the basis of all object access from the scripting language and provides a standard
abstraction for the cmdlet developer.

### Cmdlet Developers

For the cmdlet developers, ETS provides the following support:

- The abstractions to work against objects in a generic way using the **PSObject** object. ETS also
  provides the ability to drill past these abstractions if required.
- The mechanisms to create a default behavior for formatting, sorting, serialization, and other
  system manipulations of their object type using a well-known set of extended members.
- The means to operate against any object using the same semantics as the script language using a
  LanguagePrimitives object.
- The means to dynamically "type" a hash table so that the rest of the system can operate against it
  effectively.

### Script Developers

For the script developers, ETS provides the following support:

- The ability to reference any underlying object type using the same syntax (`$a.x`).
- The ability to access beyond the abstraction provided by the **PSObject** object (such as
  accessing only adapted members, or accessing the base object itself).
- The ability to define well-known members that control the formatting, sorting, serialization, and
  other manipulations of an object instance or type.
- The means to name an object as a specific type and thus control the inheritance of its type-based
  members.
- The ability to add, remove, and modify extended members.
- The ability to manipulate the **PSObject** object itself if required.

## The PSObject class

The **PSObject** object is the basis of all object access from the scripting language and provides a
standard abstraction for the cmdlet developer. It contains a base-object (a .NET object) and any
instance members (members, specifically extended members, that are present on a particular object
instance while not necessarily on other objects of the same type). Depending on the type of the
base-object, the **PSObject** object might also provide implicit and explicit access to adapted
members as well as any type-based extended members.

The **PSObject** object provides the following mechanisms:

- The ability to construct an **PSObject** with or without a base-object.
- The ability to access of all members of each constructed **PSObject** object through a common
  lookup algorithm and the ability to override that algorithm when required.
- The ability to get and set the type-names of the constructed **PSObject** objects so that scripts
  and cmdlets can reference similar **PSObject** objects by the same type-name, regardless of the
  type of their base-object.

### How to Construct a PSObject

The following list describes ways to create a **PSObject** object:

- Calling the **PSObject** .#ctor constructor creates a new **PSObject** object with a base-object
  of PSCustomObject. A base-object of this type indicates that the **PSObject** object has no
  meaningful base-object. However, a **PSObject** object with this type of base-object does provide
  a property bag that cmdlet developers can find helpful by adding extended-members.

Developers can also specify the object type-name, which allows this object to share its
extended-members with other **PSObject** objects of the same type-name.

- Calling the **PSObject** .#ctor(System.Object) constructor creates a new **PSObject** object with
  a base-object of type System.Object.

  In this case, the type-name for the created object is a collection of the derivation hierarchy of
  the base-object. For example, the type-name for the **PSObject** that contains a ProcessInfo
  base-object would include the following names:

  - System.Diagnostics.Process
  - System.ComponentModel.Component
  - System.MarshalByRefObject
  - System.Object

- Calling the **PSObject** .AsPSObject(System.Object) method creates a new **PSObject** object based
  on a supplied object.

  If the supplied object is of type System.Object, the supplied object is used as the base-object
  for the new **PSObject** object. If the supplied object is already an **PSObject** object, the
  supplied object is returned as is.

### Base, adapted, and extended members

Conceptually, ETS uses the following terms to show the relationship between the original members of
the base-object and those members added by PowerShell. For more information about the specific types
of members that are used by the **PSObject** object, see
[PSObject class](/dotnet/api/system.management.automation.psobject).

#### Base-object members

If the base-object is specified when constructing the **PSObject** objects, then the members of the
base-object are made available through the Members property.

#### Adapted members

When a base-object is a meta-object, one that contains data in a generic fashion whose properties
"describe" their contained data, ETS adapts those objects to a view that allows for direct access to
the data through adapted members of the **PSObject** object. Adapted members and base-object members
are accessed through the Members property.

#### Extended members

In addition to the members made available from the base-object or those adapted members created by
PowerShell, an **PSObject** may also define extended members that extend the original base-object
with additional information that is useful in the scripting environment.

For example, all the core cmdlets provided by PowerShell, such as the Get-Content and Set-Content
cmdlets, take a path parameter. To ensure that these cmdlets, and others, can work against objects
of different types, a Path member can be added to those objects so that they all state their
information in a common way. This extended Path member ensures that the cmdlets can work against all
those types even though there base class might not have a Path member.

Extended members, adapted members, and base-object members are all accessed through the
Members property.
