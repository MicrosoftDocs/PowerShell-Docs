---
ms.date: 07/09/2020
ms.topic: reference
title: Errors and exceptions in the Extended Type System
description: Errors and exceptions in the Extended Type System
---
# Errors and exceptions in the Extended Type System

Errors can occur in ETS during the initialization of type data and when accessing a member of an
**PSObject** object or using one of the utility classes such as **LanguagePrimitives**.

## Runtime errors

With one exception, when casting, all exceptions thrown from ETS during runtime are either an
**ExtendedTypeSystemException** exception or an exception derived from the
**ExtendedTypeSystemException** class. This allows script developers to trap these exceptions using
the `Trap` statement in their script.

## Errors getting member values

All errors that occur when getting the value of an ETS member (property, method, or parameterized
property) cause a **GetValueException** or **GetValueInvocationException** exception to be thrown.
When ETS recognizes that an error occurred a **GetValueException** exception is thrown. When the
underlying getter of a referenced member recognizes that an error occurred, a
**GetValueInvocationException** exception is thrown that may or may not include the inner exception
that caused the get invocation error.

## Errors setting member values

All errors that occur when setting the value of an ETS property cause a **SetValueException** or
**SetValueInvocationException** exception to be thrown. When ETS recognizes that an error occurred a
**SetValueException** exception is thrown. When the underlying setter of a referenced property
recognizes that an error occurred, a **SetValueInvocationException** exception is thrown that may or
may not include the inner exception that caused the set invocation error.

## Errors invoking a method

All errors that occur when invoking an ETS method cause a **MethodException** or
**MethodInvocationException** exception to be thrown. When ETS recognizes that an error occurred a
**MethodException** exception is thrown. When the referenced method recognizes that an error
occurred, a **MethodInvocationException** exception is thrown that may or may not include the inner
exception that caused the invocation error.

## Casting errors

When an invalid cast is attempted, an **PSInvalidCastException** is thrown. Because this exception
derives from **System.InvalidCastException**, it is not able to be directly trapped from script. Be
aware that the entity attempting the cast would need to wrap **PSInvalidCastException** in an
**PSRuntimeException** for this to be trappable by scripts. If an attempt is made to set the value
of an **PSPropertySet**, **PSMemberSet**, **PSMethodInfo**, or a member of the
**ReadOnlyPSMemberInfoCollection`1**, a **NotSupportedException** is thrown.

## Common runtime errors

Any other common runtime errors that occur are of type **ExtendedTypeSystemException** exception
with no additional specific exception types.

## Initialization errors

Errors may occur when initializing `types.ps1xml`. Typically, these errors are displayed when the
PowerShell runtime starts. However, they can also be displayed when a module is loaded.
