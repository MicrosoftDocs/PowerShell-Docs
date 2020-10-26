---
ms.date: 09/13/2016
ms.topic: reference
title: TypeName Element for SelectionCondition for EntrySelectedBy for TableControl (Format)
description: TypeName Element for SelectionCondition for EntrySelectedBy for TableControl (Format)
---
# TypeName Element for SelectionCondition for EntrySelectedBy for TableControl (Format)

Specifies a .NET type that triggers the condition. When this type is present, the condition is met, and the table row is used.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableRowEntries Element (Format)
TableRowEntry Element (Format)
EntrySelectedBy Element for TableRowEntry (Format)
SelectionCondition Element for EntrySelectedBy for TableRowEntry (Format)
TypeName Element for SelectionCondition for EntrySelectedBy for TableRowEntry (Format)

## Syntax

```xml
<TypeName>Nameof.NetType</TypeName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `TypeName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for TableRowEntry (Format)](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)|Defines the condition that must exist for this table row to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

The selection condition can specify any number of .NET types or selection sets, but cannot specify both. For more information about how to use selection conditions, see [Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md).

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## See Also

[Creating a Table View](./creating-a-table-view.md)

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[SelectionCondition Element for EntrySelectedBy for TableRowEntry (Format)](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)

[SelectionSetName Element for SelectionCondition for EntrySelectedBy for TableRowEntry (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
