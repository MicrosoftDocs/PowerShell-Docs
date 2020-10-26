---
ms.date: 09/13/2016
ms.topic: reference
title: EntrySelectedBy Element for CustomEntry for Controls for View (Format)
description: EntrySelectedBy Element for CustomEntry for Controls for View (Format)
---
# EntrySelectedBy Element for CustomEntry for Controls for View (Format)

Defines the .NET types that use this control definition or the condition that must exist for this definition to be used. This element is used when defining controls that can be used by a view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
Controls Element (Format)
Control Element for Controls for View (Format)
CustomControl Element for Control for Controls for View (Format)
CustomEntries Element for CustomControl for Controls for View (Format)
CustomEntry Element for CustomEntries for Controls for View (Format)
EntrySelectedBy Element for CustomEntry for Controls for View (Format)

## Syntax

```xml
<EntrySelectedBy>
  <TypeName>Nameof.NetType</TypeName>
  <SelectionSetName>NameofSelectionSet</SelectionSetName>
  <SelectionCondition>...</SelectionCondition>
</EntrySelectedBy>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent element of the `EntrySelectedBy` element. You must specify at least one type, selection set, or selection condition for a definition. There is no maximum limit to the number of child elements that you can use.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for Controls for View (Format)](./selectioncondition-element-for-entryselectedby-for-controls-for-view-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this definition to be used.|
|[SelectionSetName Element for EntrySelectedBy for Controls for View (Format)](./selectionsetname-element-for-entryselectedby-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies a set of .NET types that use this definition of the control.|
|[TypeName Element for EntrySelectedBy for Controls for View (Format)](./typename-element-for-entryselectedby-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies a .NET type that uses this definition of the control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomEntries for Controls for View (Format)](./customentry-element-for-customentries-for-controls-for-view-format.md)|Provides a definition of the control.|

## Remarks

Selection conditions are used to define a condition that must exist for the definition to be used, such as when an object has a specific property or when a specific property value or script evaluates to `true`. For more information about selection conditions, see [Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md).

## See Also

[CustomEntry Element for CustomEntries for Controls for View (Format)](./customentry-element-for-customentries-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
