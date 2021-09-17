---
description: EnumerableExpansion Element
ms.date: 08/23/2021
ms.topic: reference
title: EnumerableExpansion Element
---
# EnumerableExpansion Element

Defines how specific .NET collection objects are expanded when they are displayed in a view.

## Schema

- Configuration Element
- DefaultSettings Element
- EnumerableExpansions Element
- EnumerableExpansion Element

## Syntax

```xml
<EnumerableExpansion>
  <EntrySelectedBy>...</EntrySelectedBy>
  <Expand>EnumOnly, CoreOnly, Both</Expand>
</EnumerableExpansion>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`EnumerableExpansion` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for EnumerableExpansion](./entryselectedby-element-for-enumerableexpansion-format.md)|Optional element.<br /><br /> Defines which .NET collection objects are expanded by this definition.|
|[Expand Element](./expand-element-format.md)|Specifies how the collection object is expanded for this definition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EnumerableExpansions Element](./enumerableexpansions-element-format.md)|Defines the different ways that .NET collection objects are expanded when they are displayed in a view.|

## Remarks

This element is used to define how collection objects and the objects in the collection are
displayed. In this case, a collection object refers to any object that supports the
**System.Collections.ICollection** interface.

The default behavior is to display only the properties of the objects in the collection.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
