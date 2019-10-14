---
title: "Public Resource Schema | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: e67298ee-a773-4402-8afb-d97ad0e030e5
caps.latest.revision: 4
---
# Public Resource Schema

Management OData uses MOF to define resources and their properties. The properties of a Management OData entity correspond directly to the properties of the managed type returned by the underlying cmdlet.

## Defining a resource

Each resource corresponds to an object returned by a Windows PowerShell cmdlet. In the public resource MOF file, you define a resource by declaring a class. The class consists of properties that correspond to the properties of the object. For example, in the following example, the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) class is represented by the following MOF.

```csharp
class PswsTest_Process
{
    [Key] SInt32 Id;
    [Required] SInt32 BasePriority;
    [Required] SInt32 HandleCount;
    [Required] string MachineName;
    [Required] SInt32 MainWindowHandle;

    ...
};
```

Each property name is preceded by a data type. The data types in this example correspond to primitive CLR data types in the .NET Frameworks, but properties can also be references to other resources or complex types, which are both described later.

The `Key` qualifier indicates that a property is used to uniquely identify a resource instance. A resource can have more than one key.

The `Required` qualifier indicates that the property is required. If a property is labeled with the `Key` qualifier, it is considered to be required, and the `Required` qualifier is not necessary.

### Complex data types

Properties of entities can have complex data types. Complex data types are types that are made up of other types, similar to structs in the C programming language. A complex type is declared in the MOF file as a class with the `ComplexType` qualifier, as in the following example.

```csharp
[ComplexType]
class PswsTest_ProcessModule
{
    String ModuleName;
    String FileName;
};
```

To declare an entity property as a complex type, you declare it as a `string` type with the `EmbeddedInstance` qualifier, including the name of the complex type. The following example shows the declaration of a property of the `PswsTest_ProcessModule` type declared in the previous example.

```csharp
[Required, EmbeddedInstance("PswsTest_ProcessModule")] String Modules[];
```

### Associating entities

You can associate two entities by using the Association and AssociationClass qualifiers. For more information, see [Associating Management OData Entities](./associating-management-odata-entities.md).

### Derived types

You can derive a type from another type. The derived type inherits all of the properties of the type from which it derives in addition to any properties explicitly derived. The following example shows a type declaration and then a declaration of two types derived from that type.

```csharp
Class Product {

    [Key] String ProductName;

};

Class DairyProduct : Product {

    Uint16 PercentFat;
};
Class POPProduct : Product {

    Boolean IsCarbonated;
};
```