---
ms.date: 09/13/2016
ms.topic: reference
title: SelectionSetName Element for EntrySelectedBy for ListControl (Format)
description: SelectionSetName Element for EntrySelectedBy for ListControl (Format)
---
# SelectionSetName Element for EntrySelectedBy for ListControl (Format)

Specifies a set of .NET objects for the list entry. There is no limit to the number of selection sets that can be specified for an entry.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element (Format)
ListEntry Element (Format)
EntrySelectedBy Element for ListEntry (Format)
SelectionSetName Element for EntrySelectedBy for ListEntry (Format)

## Syntax

```xml
<SelectionSetName>NameofSelectionSet</SelectionSetName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent element of the `SelectionSetName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for ListEntry (Format)](./entryselectedby-element-for-listentry-for-listcontrol-format.md)|Defines the .NET types that use this list entry or the condition that must exist for this entry to be used.|

## Text Value

Specify the name of the selection set.

## Remarks

Each list entry must have at least one type name, selection set, or selection condition defined.

Selection sets are typically used when you want to define a group of objects that are used in multiple views. For example, you might want to create a table view and a list view for the same set of objects. For more information about defining selection sets, see [Defining Sets of objects for a View](./defining-selection-sets.md).

For more information about the components of a list view, see [Creating a List View](./creating-a-list-view.md).

## Example

The following example shows how to specify a selection set for an entry of a list view.

```xml
<ListEntry>
  <EntrySelectedBy>
    <SelectionSetName>NameofSelectionSet</SelectionSetName>
  </EntrySelectedBy>
  <ListItems>...</ListItems>
</ListEntry>
```

## See Also

[Creating a List View](./creating-a-list-view.md)

[EntrySelectedBy Element for ListEntry (Format)](./entryselectedby-element-for-listentry-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
