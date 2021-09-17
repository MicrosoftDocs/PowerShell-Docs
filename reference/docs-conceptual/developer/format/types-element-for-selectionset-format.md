---
description: Types Element for SelectionSet
ms.date: 08/25/2021
ms.topic: reference
title: Types Element for SelectionSet
---
# Types Element for SelectionSet

Defines the .NET objects that are in the selection set.

## Schema

- Configuration Element
- SelectionSets Element
- SelectionSet Element
- Types Element

## Syntax

```xml
<Types>
  <TypeName>Nameof.NetType</TypeName>
</Types>

```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`Types` element. There must be at least one child element, but there is no maximum limit to the
number of child elements that can be added.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[TypeName Element of Types](./typename-element-for-types-format.md)|Required element.<br /><br /> Specifies the .NET object that belongs to the selection set.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionSet Element](./selectionset-element-format.md)|Defines a set of .NET objects that can be referenced by the name of the set.|

## Remarks

The objects defined by this element make up a selection set that can be used by a view, by a
definition of a view (views can have multiple definitions), or when specifying a selection
condition. For more information about selection sets, see [Defining Sets of Objects](./defining-selection-sets.md).

## Example

This example shows a `SelectionSet` element that defines four .NET types.

```xml
<SelectionSets>
  <SelectionSet>
    <Name>FileSystemTypes</Name>
    <Types>
     <TypeName>System.IO.DirectoryInfo</TypeName>
     <TypeName>System.IO.FileInfo</TypeName>
     <TypeName>Deserialized.System.IO.DirectoryInfo</TypeName>
     <TypeName>Deserialized.System.IO.FileInfo</TypeName>
    </Types>
  </SelectionSet>
</SelectionSets>
```

## See Also

[Defining Sets of Objects](./defining-selection-sets.md)

[SelectionSet Element](./selectionset-element-format.md)

[TypeName Element of Types](./typename-element-for-types-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
