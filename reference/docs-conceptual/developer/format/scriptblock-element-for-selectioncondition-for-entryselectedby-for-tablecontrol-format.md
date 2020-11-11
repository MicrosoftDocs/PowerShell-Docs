---
ms.date: 09/13/2016
ms.topic: reference
title: ScriptBlock Element for SelectionCondition for EntrySelectedBy for TableControl (Format)
description: ScriptBlock Element for SelectionCondition for EntrySelectedBy for TableControl (Format)
---
# ScriptBlock Element for SelectionCondition for EntrySelectedBy for TableControl (Format)

Specifies the script block that triggers the condition. When this script is evaluated to `true`, the condition is met, and the table entry is used.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableRowEntries Element (Format)
TableRowEntry Element (Format)
EntrySelectedBy Element for TableRowEntry (Format)
SelectionCondition Element for EntrySelectedBy for TableRowEntry (Format)
ScriptBlock Element for SelectionCondition for EntrySelectedBy for TableRowEntry (Format)

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for TableRowEntry (Format)](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)|Defines the condition that must exist for this table entry to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

The selection condition must specify at least one script block or property name, but cannot specify both. For more information about how to use selection conditions, see [Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md).

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## See Also

[Creating a Table View](./creating-a-table-view.md)

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[PropertyName Element for SelectionCondition for EntrySelectedBy for TableRowEntry (Format)](./propertyname-element-for-selectioncondition-for-entryselectedby-for-tablerowentry-format.md)

[SelectionCondition Element for EntrySelectedBy for TableRowEntry (Format)](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
