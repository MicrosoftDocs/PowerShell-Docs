---
ms.date: 09/13/2016
ms.topic: reference
title: SelectionSetName Element for EntrySelectedBy for GroupBy (Format)
description: SelectionSetName Element for EntrySelectedBy for GroupBy (Format)
---
# SelectionSetName Element for EntrySelectedBy for GroupBy (Format)

Specifies a set of .NET objects for the list entry. There is no limit to the number of selection sets that can be specified for an entry. This element is used when defining how a new group of objects is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
GroupBy Element for View (Format)
CustomControl Element for GroupBy (Format)
CustomEntries Element for CustomControl for GroupBy (Format)
CustomEntry Element for CustomControl for GroupBy (Format)
EntrySelectedBy Element for CustomEntry for GroupBy (Format)
SelectionSetName Element for EntrySelectedBy for GroupBy (Format)

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
|[EntrySelectedBy Element for CustomEntry for GroupBy (Format)](./entryselectedby-element-for-customentry-for-groupby-format.md)|Defines the .NET types that use this custom entry or the condition that must exist for this entry to be used.|

## Text Value

Specify the name of the selection set.

## Remarks

Each custom control definition must have at least one type name, selection set, or selection condition defined.

Selection sets are typically used when you want to define a group of objects that are used in multiple views. For example, you may want to create a table view and a list view for the same set of objects. For more information about defining selection sets, see [Defining Selection Sets](./defining-selection-sets.md).

For more information about the components of a custom control view, see [Creating Custom Controls](./creating-custom-controls.md).

## See Also

[EntrySelectedBy Element for CustomEntry for GroupBy (Format)](./entryselectedby-element-for-customentry-for-groupby-format.md)

[Creating Custom Controls](./creating-custom-controls.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
