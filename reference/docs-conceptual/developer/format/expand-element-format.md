---
description: Expand Element
ms.date: 08/23/2021
ms.topic: reference
title: Expand Element
---
# Expand Element

Specifies how the collection object is expanded for this definition.

## Schema

- Configuration Element
- DefaultSettings Element
- EnumerableExpansions Element
- EnumerableExpansion Element
- Expand Element

## Syntax

```xml
<Expand>EnumOnly, CoreOnly, Both</Expand>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `Expand`
element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EnumerableExpansion Element](./enumerableexpansion-element-format.md)|Defines how specific .NET collection objects are expanded when they are displayed in a view.|

## Text Value

Specify one of the following values:

- EnumOnly: Displays only the properties of the objects in the collection.

- CoreOnly: Displays only the properties of the collection object.

- Both: Displays the properties of the objects in the collection and the properties of the
  collection object.

## Remarks

This element is used to define how collection objects and the objects in the collection are
displayed. In this case, a collection object refers to any object that supports the
**System.Collections.ICollection** interface.

The default behavior is to display only the properties of the objects in the collection.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
