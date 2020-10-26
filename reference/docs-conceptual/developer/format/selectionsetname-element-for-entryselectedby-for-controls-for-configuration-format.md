---
ms.date: 09/13/2016
ms.topic: reference
title: SelectionSetName Element for EntrySelectedBy for Controls for Configuration (Format)
description: SelectionSetName Element for EntrySelectedBy for Controls for Configuration (Format)
---
# SelectionSetName Element for EntrySelectedBy for Controls for Configuration (Format)

Specifies a set of .NET types that use this definition of the control. This element is used when defining a common control that can be used by all the views in the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)
Control Element for Controls for Configuration (Format)
CustomControl Element for Control for Configuration (Format)
CustomEntries Element for CustomControl for Configuration (Format)
CustomEntry Element for CustomControl for Controls for Configuration (Format)
EntrySelectedBy Element for CustomEntry for Controls for Configuration (Format)
SelectionSetName Element for EntrySelectedBy for Controls for Configuration (Format)

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
|[EntrySelectedBy Element for CustomEntry for Controls for Configuration (Format)](./entryselectedby-element-for-customentry-for-controls-for-configuration-format.md)|Defines the .NET types that use this control definition or the condition that must exist for this definition to be used.|

## Text Value

Specify the name of the selection set.

## Remarks

Each control definition must have at least one type name, selection set, or selection condition defined.

Selection sets are typically used when you want to define a group of objects that are used in multiple views. For more information about defining selection sets, see [Defining Selection Sets](./defining-selection-sets.md).

## See Also

[EntrySelectedBy Element for CustomEntry for Controls for Configuration (Format)](./entryselectedby-element-for-customentry-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
