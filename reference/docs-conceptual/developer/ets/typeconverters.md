---
ms.date: 07/09/2020
ms.topic: reference
title: Extended Type System type converters
description: Extended Type System type converters
---
# ETS type converters

ETS uses two basic types of type converters when a call is made to the
`LanguagePrimitives.ConvertTo(System.Object, System.Type)` method. When this method is called,
PowerShell attempts to perform the type conversion using its standard PowerShell language converters
or a custom converter. If PowerShell cannot perform the conversion, it throws an
**PSInvalidCastException** exception.

## Standard Windows PowerShell Language Converters

These standard conversions are checked before any custom conversions and cannot be overridden. The
following table lists the type conversions performed by PowerShell when the
`ConvertTo(System.Object, System.Type)` method is called. Be aware that references to the
**valueToConvert** and **resultType** parameters refer to parameters of the
`ConvertTo(System.Object,System.Type)` method.

| From (valueToConvert) |  To (resultType)  |                                                                               Returns                                                                               |
| --------------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Null                  | String            | ""                                                                                                                                                                  |
| Null                  | Char              | '\0'                                                                                                                                                                |
| Null                  | Numeric           | `0` of the type specified in the **resultType** parameter.                                                                                                          |
| Null                  | Boolean           | Results of call to the `IsTrue(System.Object)(Null)` method.                                                                                                        |
| Null                  | PSObject          | New object of type **PSObject**.                                                                                                                                    |
| Null                  | Non-value-type    | Null.                                                                                                                                                               |
| Null                  | Nullable&lt;T&gt; | Null.                                                                                                                                                               |
| Derived Class         | Base class        | **valueToConvert**                                                                                                                                                  |
| Anything              | Void              | **AutomationNull.Value**                                                                                                                                            |
| Anything              | String            | Calls `ToString` mechanism.                                                                                                                                         |
| Anything              | Boolean           | `IsTrue(System.Object) (valueToConvert)`                                                                                                                            |
| Anything              | PSObject          | Results of call to the `AsPSObject(System.Object) (valueToConvert)` method.                                                                                         |
| Anything              | Xml Document      | Converts **valueToConvert** to string, then calls **XMLDocument** constructor.                                                                                      |
| Array                 | Array             | Attempts to convert each element of the array.                                                                                                                      |
| Singleton             | Array             | `Array[0]` equals **valueToConvert** that is converted to the element type of the array.                                                                            |
| IDictionary           | Hash table        | Results of call to Hashtable(valueToConvert).                                                                                                                       |
| String                | Char[]            | `valueToConvert.ToCharArray`                                                                                                                                        |
| String                | RegEx             | Results of call to `Regx(valueToConvert)`.                                                                                                                          |
| String                | Type              | Returns the appropriate type using the **valueToConvert** parameter to search **RunspaceConfiguration.Assemblies**.                                                 |
| String                | Numeric           | If **valueToConvert** is "", returns `0` of the **resultType**. Otherwise the culture "culture invariant" is used to produce a numeric value.                       |
| Integer               | System.Enum       | Converts the integer to the constant if the integer is defined by the enumeration. If the integer is not defined an **PSInvalidCastException** exception is thrown. |

## Custom conversions

If PowerShell cannot convert the type using a standard PowerShell language converter, it then checks
for custom converters. PowerShell looks for several types of custom converters in the order
described in this section. Be aware that references to the **valueToConvert** and **resultType**
parameters refer to parameters of the `ConvertTo(System.Object, System.Type)` method. If a custom
converter throws an exception, then no further attempt is made to convert the object and that
exception is wrapped in a **PSInvalidCastException** exception which is then thrown.

## PowerShell type converter

PowerShell type converters are used to convert a single type or a family of types, such as all types
that derive from the **System.Enum** class. To create a PowerShell type converter you must implement
an PSTypeConverter class and associate that implementation with the target class. There are two ways
of associating the PowerShell type converter with its target class.

- Through the type configuration file
- By applying the **TypeConverterAttribute** attribute to the target class

PowerShell type converters, derived from the
[PSTypeConverter](/dotnet/api/system.management.automation.pstypeconverter) abstract class, provide
methods for converting an object to a specific type or from a specific type. If the
**valueToConvert** parameter contains an object that has a PowerShell Type converter associated with
it, PowerShell calls the
`PSTypeConverter.ConvertTo(System.Object, System.Type,System.IFormatProvider, System.Boolean)`
method of the associated converter to convert the object to the type specified by the **resultType**
parameter. If the **resultType** parameter references a type that has a PowerShell type converter
associated with it, PowerShell calls the
`PSTypeConverter.ConvertFrom(System.Object,System.Type, System.IFormatProvider, System.Boolean)`
method of the associated converter to convert the object from the type specified by the
**resultType** parameter.

## System type converter

System type converters are used to convert a specific target class. This type of converter cannot be
used to convert a family of classes. To create an system type converter you must implement an
[TypeConverter](/dotnet/api/system.management.automation.runspaces.typedata.typeconverter#System_Management_Automation_Runspaces_TypeData_TypeConverter)
class and associate that implementation with the target class. There are two ways of associating the
system type converter with its target class.

- Through the type configuration file
- By applying the TypeConverterAttribute attribute to the target class

## Parse converter

If the **valueToConvert** parameter is a string, and the object type of the **resultType** parameter
has a `Parse` method, then the `Parse` method is called to convert the string.

## Constructor converter

If the object type of the **resultType** parameter has a constructor that has a single parameter
that is the same type as the object of the **valueToConvert** parameter, then this constructor is
called.

## Implicit cast operator converter

If the **valueToConvert** parameter has an implicit cast operator that converts to **resultType**,
then its cast operator is called. If the **resultType** parameter has an implicit cast operator that
converts from **valueToConvert**, then its cast operator is called.

## Explicit cast operator converter

If the **valueToConvert** parameter has an explicit cast operator that converts to **resultType**,
then its cast operator is called. If the **resultType** parameter has an explicit cast operator that
converts from **valueToConvert**, then its cast operator is called.
