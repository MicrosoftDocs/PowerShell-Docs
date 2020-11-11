---
ms.date: 09/13/2016
ms.topic: reference
title: SelectionSetName Element for EntrySelectedBy for EnumerableExpansion (Format)
description: SelectionSetName Element for EntrySelectedBy for EnumerableExpansion (Format)
---
# SelectionSetName Element for EntrySelectedBy for EnumerableExpansion (Format)

Specifies the set of .NET types that are expanded by this definition.

Configuration Element (Format)
DefaultSettings Element (Format)
EnumerableExpansions Element (Format)
EnumerableExpansion Element (Format)
EntrySelectedBy Element for EnumerableExpansion (Format)
SelectionSetName Element for EntrySelectedBy for EnumerableExpansion (Format)

## Syntax

```xml
<SelectionSetName>NameofSelectionSet</SelectionSetName>

```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `SelectionSetName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for EnumerableExpansion (Format)](./entryselectedby-element-for-enumerableexpansion-format.md)|Defines the .NET collection objects that are expanded by this definition.|

## Text Value

Specify the name of the selection set.

## Remarks

Each definition must specify one or more type names, a selection set, or a selection condition.

Selection sets are typically used when you want to define a group of objects that are used in multiple views. For example, you might want to create a table view and a list view for the same set of objects. For more information about defining selection sets, see [Defining Sets of Objects for a View](./defining-selection-sets.md).

## See Also

[Defining Selection Sets](./defining-selection-sets.md)

[EntrySelectedBy Element for EnumerableExpansion (Format)](./entryselectedby-element-for-enumerableexpansion-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
