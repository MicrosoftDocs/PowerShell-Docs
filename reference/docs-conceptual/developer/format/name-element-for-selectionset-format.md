---
description: Name Element for SelectionSet
ms.date: 08/23/2021
ms.topic: reference
title: Name Element for SelectionSet
---
# Name Element for SelectionSet

Specifies the name used to reference the selection set.

## Schema

- Configuration Element
- SelectionSets Element
- SelectionSet Element
- Name Element

## Syntax

```xml
<Name>Name of selection set</Name>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the `Name`
Element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionSet Element](./selectionset-element-format.md)|Defines a single set of .NET objects that can be referenced by the name of the set.|

## Text Value

Specify the name to reference the selection set. There are no restrictions as to what characters can
be used.

## Remarks

The name specified here is used in the `SelectionSetName` element. The selection set that can be
used by a view, by a definition of a view (views can have multiple definitions), or when specifying
a selection condition. For more information about selection sets, see [Defining Sets of Objects](./defining-selection-sets.md).

## Example

This example shows a `SelectionSet` element that defines four .NET types. The name of the selection
set is "FileSystemTypes".

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

[Defining Selection Sets](./defining-selection-sets.md)

[SelectionSet Element](./selectionset-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
