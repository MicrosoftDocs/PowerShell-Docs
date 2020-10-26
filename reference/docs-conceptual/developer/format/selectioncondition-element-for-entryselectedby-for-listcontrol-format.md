---
ms.date: 09/13/2016
ms.topic: reference
title: SelectionCondition Element for EntrySelectedBy for ListControl (Format)
description: SelectionCondition Element for EntrySelectedBy for ListControl (Format)
---
# SelectionCondition Element for EntrySelectedBy for ListControl (Format)

Defines the condition that must exist to use this definition of the list view. There is no limit to the number of selection conditions that can be specified for a list definition.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element (Format)
ListEntry Element (Format)
EntrySelectedBy Element for ListEntry (Format)
SelectionCondition Element for EntrySelectedBy for ListEntry (Format)

## Syntax

```xml
<SelectionCondition>
  <TypeName>Nameof.NetType</TypeName>
  <SelectionSetName>NameofSelectionSet</SelectionSetName>
  <PropertyName>.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate</ScriptBlock>
</SelectionCondition>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `SelectionCondition` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[PropertyName Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./propertyname-element-for-selectioncondition-for-entryselectedby-for-listcontrol-format.md)|Optional element.<br /><br /> Specifies the .NET property that triggers the condition.|
|[ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-listcontrol-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|
|[SelectionSetName Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-listentry-format.md)|Optional element.<br /><br /> Specifies the set of .NET types that trigger the condition.|
|[TypeName Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./typename-element-for-selectioncondition-for-entryselectedby-for-listcontrol-format.md)|Optional element.<br /><br /> Specifies a .NET type that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for TableRowEntry (Format)](./entryselectedby-element-for-tablerowentry-for-tablecontrol-format.md)|Defines the .NET types that use this table entry or the condition that must exist for this entry to be used.|

## Remarks

lWhen you are defining a selection condition, the following requirements apply:

- The selection condition must specify a least one property name or a script block, but cannot specify both.

- The selection condition can specify any number of .NET types or selection sets, but cannot specify both.

For more information about how to use selection conditions, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

For more information about other components of a list view, see [Creating a List View](./creating-a-list-view.md).

## See Also

[Creating a List View](./creating-a-list-view.md)

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[ListEntry Element (Format)](./listentry-element-for-listcontrol-format.md)

[SelectionSetName Element for EntrySelectedBy for ListEntry (Format)](./selectionsetname-element-for-entryselectedby-for-listcontrol-format.md)

[TypeName Element for EntrySelectedBy for ListEntry (Format)](/powershell/scripting/developer/format/typename-element-for-entryselectedby-for-listcontrol-format)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
