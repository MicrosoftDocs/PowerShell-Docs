---
ms.date: 09/13/2016
ms.topic: reference
title: EntrySelectedBy Element for ListEntry for ListControl (Format)
description: EntrySelectedBy Element for ListEntry for ListControl (Format)
---
# EntrySelectedBy Element for ListEntry for ListControl (Format)

Defines the .NET types that use this list view definition or the condition that must exist for this definition to be used. In most cases only one definition is needed for a list view. However, you can provide multiple definitions for the list view if you want to use the same list view to display different data for different objects.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element for ListControl (Format)
ListEntry Element for ListEntry for ListControl (Format)
EntrySelectedBy Element for ListEntry for ListControl (Format)

## Syntax

```xml
<EntrySelectedBy>
  <TypeName>Nameof.NetType</TypeName>
  <SelectionSetName>NameofSelectionSet</SelectionSetName>
  <SelectionCondition>...</SelectionCondition>
</EntrySelectedBy>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `EntrySelectedBy` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for ListControl  (Format)](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this list view definition to be used.|
|[SelectionSetName Element for EntrySelectedBy for ListControl (Format)](./selectionsetname-element-for-entryselectedby-for-listcontrol-format.md)|Optional element.<br /><br /> Specifies a set of .NET types that use this list view definition.|
|[TypeName Element for EntrySelectedBy for ListControl (Format)](./typename-element-for-entryselectedby-for-listcontrol-format.md)|Optional element.<br /><br /> Specifies a .NET type that uses this list view definition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListEntry Element for ListControl (Format)](./listentry-element-for-listcontrol-format.md)|Defines how the rows of the list are displayed.|

## Remarks

You must specify at least one type, selection set, or selection condition for a list view definition. There is no maximum limit to the number of child elements that you can use.

Selection conditions are used to define a condition that must exist for the definition to be used, such as when an object has a specific property or that a specific property value or script evaluates to `true`. For more information about selection conditions, see [Defining Conditions for when Data is displayed](./defining-conditions-for-displaying-data.md).

For more information about the components of a list view, see [Creating a List View](./creating-a-list-view.md).

## Example

The following example shows how to define the objects for a list view using their .NET type name.

```xml
<ListEntry>
  <EntrySelectedBy>
    <TypeName>NameofDotNetType</TypeName>>
  </EntrySelectedBy>
</ListEntry>
```

## See Also

[ListEntry Element for ListControl (Format)](./listentry-element-for-listcontrol-format.md)

[SelectionCondition Element for EntrySelectedBy for ListControl (Format)](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)

[SelectionSetName Element for EntrySelectedBy for ListControl (Format)](./selectionsetname-element-for-entryselectedby-for-listcontrol-format.md)

[TypeName Element for EntrySelectedBy for ListControl (Format)](./typename-element-for-entryselectedby-for-listcontrol-format.md)

[Creating a List View](./creating-a-list-view.md)

[Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
