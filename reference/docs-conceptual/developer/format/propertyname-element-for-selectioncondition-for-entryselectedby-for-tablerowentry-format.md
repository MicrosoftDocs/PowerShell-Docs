---
description: PropertyName Element for SelectionCondition for EntrySelectedBy for TableRowEntry
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for SelectionCondition for EntrySelectedBy for TableRowEntry
---
# PropertyName Element for SelectionCondition for EntrySelectedBy for TableRowEntry

Specifies the .NET property that triggers the condition. When this property is present or when it
evaluates to `true`, the condition is met, and the table entry is used.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- TableControl Element
- TableRowEntries Element
- TableRowEntry Element
- EntrySelectedBy Element
- SelectionCondition Element
- PropertyName Element

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for TableRowEntry](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)|Defines the condition that must exist for this table entry to be used.|

## Text Value

Specify the .NET property name.

## Remarks

The selection condition must specify at least one property name or a script block, but cannot
specify both. For more information about how selection conditions can be used, see [Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md).

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## See Also

[Creating a Table View](./creating-a-table-view.md)

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[ScriptBlock Element for SelectionCondition for EntrySelectedBy for TableRowEntry](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-tablecontrol-format.md)

[SelectionCondition Element for EntrySelectedBy for TableRowEntry](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
