---
ms.date: 09/13/2016
ms.topic: reference
title: SelectionSetName Element for EntrySelectedBy for Controls for View (Format)
description: SelectionSetName Element for EntrySelectedBy for Controls for View (Format)
---
# SelectionSetName Element for EntrySelectedBy for Controls for View (Format)

Specifies a set of .NET types that use this definition of the control. This element is used when defining controls that can be used by a view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
Controls Element (Format)
Control Element for Controls for View (Format)
CustomControl Element for Control for Controls for View (Format)
CustomEntries Element for CustomControl for Controls for View (Format)
CustomEntry Element for CustomEntries for Controls for View (Format)
EntrySelectedBy Element for CustomEntry for Controls for View (Format)
SelectionSetName Element for EntrySelectedBy for Controls for View (Format)

## Syntax

```xml
<SelectionSetName>NameofSelectionSet</SelectionSetName>

```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `SelectionSetName` element.

### Attributes

None

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for CustomEntry for Controls for View (Format)](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)|Defines the .NET types that use this control definition or the condition that must exist for this definition to be used.|

## Text Value

Specify the name of the selection set.

## Remarks

Each control definition must have at least one type name, selection set, or selection condition defined.

Selection sets are typically used when you want to define a group of objects that are used in multiple views. For more information about defining selection sets, see [Defining Selection Sets](./defining-selection-sets.md).

## See Also

[EntrySelectedBy Element for CustomEntry for Controls for View (Format)](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
