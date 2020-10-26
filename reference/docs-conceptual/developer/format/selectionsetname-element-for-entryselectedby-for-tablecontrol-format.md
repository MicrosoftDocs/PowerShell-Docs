---
ms.date: 09/13/2016
ms.topic: reference
title: SelectionSetName Element for EntrySelectedBy for TableControl (Format)
description: SelectionSetName Element for EntrySelectedBy for TableControl (Format)
---
# SelectionSetName Element for EntrySelectedBy for TableControl (Format)

Specifies a set of .NET types the use this entry of the table view. There is no limit to the number of selection sets that can be specified for an entry.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableRowEntries Element (Format)
TableRowEntry Element (Format)
EntrySelectedBy Element (Format)
SelectionSetName Element for EntrySelectedBy for TableRowEntry (Format)

## Syntax

```xml
<SelectionSetName>NameofSelectionSet</SelectionSetName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent elements.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element (Format)](./entryselectedby-element-for-tablerowentry-for-tablecontrol-format.md)|Defines the .NET types that use this entry or the condition that must exist for this entry to be used.|

## Text Value

Specify the name of the selection set.

## Remarks

Selection sets are typically used when you want to define a group of objects that are used in multiple views. For example, you might want to create a table view and a list view for the same set of objects. For more information about defining selection sets, see [Defining Sets of objects for a View](./defining-selection-sets.md).

If you specify a selection set for an entry, you cannot specify a type name. For more information about how to specify a .NET type, see [TypeName Element for EntrySelectedBy for TableRowEntry (Format)](./typename-element-for-entryselectedby-for-tablecontrol-format.md).

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## See Also

[EntrySelectedBy Element (Format)](./entryselectedby-element-for-tablerowentry-for-tablecontrol-format.md)

[Defining Sets of objects for a View](./defining-selection-sets.md)

[Creating a Table View](./creating-a-table-view.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
