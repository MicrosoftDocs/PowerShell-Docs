---
ms.date: 09/13/2016
ms.topic: reference
title: EntrySelectedBy Element for WideEntry (Format)
description: EntrySelectedBy Element for WideEntry (Format)
---
# EntrySelectedBy Element for WideEntry (Format)

Defines the .NET types that use this definition of the wide view or the condition that must exist for this definition to be used.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
WideControl Element (Format)
WideEntries Element (Format)
WideEntry Element (Format)
EntrySelectedBy Element for WideEntry (Format)

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
|[SelectionCondition Element for EntrySelectedBy for WideEntry (Format)](./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this wide view definition to be used.|
|[SelectionSetName Element for EntrySelectedBy for WideEntry (Format)](./selectionsetname-element-for-entryselectedby-for-widecontrol-format.md)|Optional element.<br /><br /> Specifies a set of .NET types that use this wide view definition.|
|[TypeName Element for EntrySelectedBy for WideEntry (Format)](./typename-element-for-entryselectedby-for-wideentry-format.md)|Optional element.<br /><br /> Specifies a .NET type that uses this wide view definition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[WideEntry Element (Format)](./wideentry-element-for-widecontrol-format.md)|Provides a definition of the wide view.|

## Remarks

You must specify at least one type, selection set, or selection condition for a wide view definition. There is no maximum limit to the number of child elements that you can use.

Selection conditions are used to define a condition that must exist for the definition to be used, such as when an object has a specific property or that a specific property value or script value evaluates to `true`. For more information about selection conditions, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

For more information about other components of a wide view, see [Creating a Wide View](./creating-a-wide-view.md).

## See Also

[WideEntry Element (Format)](./wideentry-element-for-widecontrol-format.md)

[SelectionCondition Element for EntrySelectedBy for WideEntry (Format)](./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md)

[SelectionSetName Element for EntrySelectedBy for WideEntry (Format)](./selectionsetname-element-for-entryselectedby-for-widecontrol-format.md)

[TypeName Element for EntrySelectedBy for WideEntry (Format)](./typename-element-for-entryselectedby-for-wideentry-format.md)

[Creating a Wide View](./creating-a-wide-view.md)

[Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
