---
description: SelectionSetName Element for EntrySelectedBy for Controls for View
ms.date: 08/25/2021
ms.topic: reference
title: SelectionSetName Element for EntrySelectedBy for Controls for View
---
# SelectionSetName Element for EntrySelectedBy for Controls for View

Specifies a set of .NET types that use this definition of the control. This element is used when
defining controls that can be used by a view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
- EntrySelectedBy Element
- SelectionSetName Element

## Syntax

```xml
<SelectionSetName>NameofSelectionSet</SelectionSetName>

```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`SelectionSetName` element.

### Attributes

None

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for CustomEntry for Controls for View](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)|Defines the .NET types that use this control definition or the condition that must exist for this definition to be used.|

## Text Value

Specify the name of the selection set.

## Remarks

Each control definition must have at least one type name, selection set, or selection condition
defined.

Selection sets are typically used when you want to define a group of objects that are used in
multiple views. For more information about defining selection sets, see [Defining Selection Sets](./defining-selection-sets.md).

## See Also

[EntrySelectedBy Element for CustomEntry for Controls for View](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
