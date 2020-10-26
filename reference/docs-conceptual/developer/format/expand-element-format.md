---
ms.date: 09/13/2016
ms.topic: reference
title: Expand Element (Format)
description: Expand Element (Format)
---
# Expand Element (Format)

Specifies how the collection object is expanded for this definition.

Configuration Element (Format)
DefaultSettings Element (Format)
EnumerableExpansions Element (Format)
EnumerableExpansion Element (Format)
Expand Element (Format)

## Syntax

```xml
<Expand>EnumOnly, CoreOnly, Both</Expand>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `Expand` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EnumerableExpansion Element (Format)](./enumerableexpansion-element-format.md)|Defines how specific .NET collection objects are expanded when they are displayed in a view.|

## Text Value

Specify one of the following values:

- EnumOnly: Displays only the properties of the objects in the collection.

- CoreOnly: Displays only the properties of the collection object.

- Both: Displays the properties of the objects in the collection and the properties of the collection object.

## Remarks

This element is used to define how collection objects and the objects in the collection are displayed. In this case, a collection object refers to any object that supports the  **System.Collections.ICollection** interface.

The default behavior is to display only the properties of the objects in the collection.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
