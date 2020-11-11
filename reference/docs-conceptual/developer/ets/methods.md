---
ms.date: 07/09/2020
ms.topic: reference
title: Extended Type System class methods
description: Extended Type System class methods
---
# ETS class methods

ETS methods are members that can take arguments, may return results, and cannot appear on the
left-hand side of an expression. The methods that are available within ETS include code, Windows
PowerShell, and script methods.

> [!NOTE]
> From scripts, methods are accessed using the same syntax as other members with the addition of
> parenthesis at the end of the method name.

## Code Methods

A code method is an extended member that is defined in a CLR language. It provides similar
functionality to a method defined on a base object; however, a code method may be added dynamically
to an **PSObject** object. In order for a code method to become available, a developer must write
the property in some CLR language, compile, and ship the resultant assembly. This assembly must be
available in the runspace where the code method is desired. Be aware that a code method
implementation must be thread safe. Access to these methods is done through
[PSCodeMethod](/dotnet/api/system.management.automation.pscodemethod) objects that provides the
following public methods and properties.

- `PSCodeMethod.Copy` method: Makes an exact copy of the **PSCodeMethod** object.
- `PSCodeMethod.Invoke(System.Object[])` method: Invokes the underlying code method.
- `PSCodeMethod.ToString` method: Converts the **PSCodeMethod** object to a string.
- `PSCodeMethod.CodeReference` property: Gets the underlying method that the code method is based
  on.
- **PSMemberInfo.IsInstance** property: Gets a **Boolean** value that indicates the source of the
  member.
- **PSCodeMethod.MemberType** property: Gets an **PSMemberTypes.CodeMethod** enumeration constant
  that identifies this method as a code method.
- **PSMemberInfo.Name** property: Gets the name of the underlying code method.
- **PSCodeMethod.OverloadDefinitions** property: Gets a definition of all the overloads of the
  underlying code method.
- **PSCodeMethod.TypeNameOfValue** property: Gets the full name of the code method.
- **PSMemberInfo.Value** property: Gets the **PSCodeMethod** object.

## Windows PowerShell Methods

A PowerShell method is a CLR method defined on the base object or is made accessible through an
adapter. Access to these methods is done through **PSMethod** objects that provides the following
public methods and properties.

- `PSMethod.Copy` method: Makes an exact copy of the **PSMethod** object.
- `PSMethod.Invoke(System.Object[])` method: Invokes the underlying method.
- `PSMethod.ToString` method: Converts the **PSMethod** object to a string.
- **PSMemberInfo.IsInstance** property: Gets a **Boolean** value that indicates the source of the
  member.
- **PSMethod.MemberType** property: Gets an **PSMemberTypes.Method** enumeration constant that
  identifies this method as a PowerShell method.
- **PSMemberInfo.Name** property: Gets the name of the underlying method.
- **PSMethod.OverloadDefinitions** property: Gets the definitions of all the overloads of the
  underlying method.
- **PSMethod.TypeNameOfValue** property: Gets the ETS type of this method.
- **PSMemberInfo.Value** property: Gets the **PSMethod** object.

## Script Methods

A script method is an extended member that is defined in the PowerShell language. It provides
similar functionality to a method defined on a base object; however, a script method may be added
dynamically to an **PSObject** object. Access to these methods is done through
[PSScriptMethod](/dotnet/api/system.management.automation.psscriptmethod) objects that provides the
following public methods and properties.

- `PSScriptMethod.Copy` method: Makes an exact copy of the **PSScriptMethod** object.
- `PSScriptMethod.Invoke(System.Object[])` method: Invokes the underlying script method.
- `PSScriptMethod.ToString` method: Converts the **PSScriptMethod** object to a string.
- **PSMemberInfo.IsInstance** property: Gets a **Boolean** value that indicates the source of the
  member.
- **PSScriptMethod.MemberType** property: Gets a **PSMemberTypes.ScriptMethod** enumeration constant
  that identifies this method as a script method.
- **PSMemberInfo.Name** property: Gets the name of the underlying code method.
- **PSScriptMethod.OverloadDefinitions** property: Gets the definitions of all the overloads of the
  underlying script method.
- **PSScriptMethod.TypeNameOfValue** property: Gets the ETS type of this method.
- **PSScriptMethod.Script** property: Gets the script used to invoke the method.
- **PSMemberInfo.Value** property: Gets the **PSScriptMethod** object.
