---
ms.date: 09/13/2016
ms.topic: reference
title: EntrySelectedBy Element for CustomEntry for CustomControl for View (Format)
description: EntrySelectedBy Element for CustomEntry for CustomControl for View (Format)
---
# EntrySelectedBy Element for CustomEntry for CustomControl for View (Format)

Defines the .NET types that use this custom entry or the condition that must exist for this entry to be used.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for View (Format)
EntrySelectedBy Element for CustomEntry for View (Format)

## Syntax

```xml
<EntrySelectedBy>
  <TypeName>Nameof.NetType</TypeName>
  <SelectionSetName>NameofSelectionSet</SelectionSetName>
  <SelectionCondition>...</SelectionCondition>
</EntrySelectedBy>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `EntrySelectedBy` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for CustomEntry (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this definition to be used.|
|[SelectionSetName Element for EntrySelectedBy for CustomEntry (Format)](./selectionsetname-element-for-entryselectedby-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Specifies a set of .NET types that use this definition of the control view.|
|[TypeName Element for EntrySelectedBy for CustomEntry (Format)](./typename-element-for-selectioncondition-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Specifies a .NET type that uses this definition of the control view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomEntries for View (Format)](./customentry-element-for-customentries-for-customcontrol-for-view-format.md)|Defines the controls used by specific .NET objects.|

## Remarks

You must specify at least one type, selection set, or selection condition for an entry. There is no maximum limit to the number of child elements that you can use.

Selection conditions are used to define a condition that must exist for the entry to be used, such as when an object has a specific property or when a specific property value or script evaluates to `true`. For more information about selection conditions, see [Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md).

For more information about the components of a custom control view, see [Custom Control View](./creating-custom-controls.md).

## See Also

[SelectionCondition Element for EntrySelectedBy for CustomEntry (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)

[SelectionSetName Element for EntrySelectedBy for CustomEntry (Format)](./selectionsetname-element-for-entryselectedby-for-customcontrol-for-view-format.md)

[TypeName Element for EntrySelectedBy for CustomEntry (Format)](./typename-element-for-selectioncondition-for-customcontrol-for-view-format.md)

[CustomEntry Element for CustomEntries for View (Format)](./customentry-element-for-customentries-for-customcontrol-for-view-format.md)

[Custom Control View](./creating-custom-controls.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
