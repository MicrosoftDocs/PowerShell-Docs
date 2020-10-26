---
ms.date: 09/13/2016
ms.topic: reference
title: EntrySelectedBy Element for TableRowEntry  for TableControl (Format)
description: EntrySelectedBy Element for TableRowEntry  for TableControl (Format)
---
# EntrySelectedBy Element for TableRowEntry  for TableControl (Format)

Defines the .NET types that use this definition of the table view or the condition that must exist for this definition to be used.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableRowEntries Element (Format)
TableRowEntry Element (Format)
EntrySelectedBy Element (Format)

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
|[SelectionCondition Element for EntrySelectedBy for TableControl (Format)](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this table view definition to be used.|
|[SelectionSetName Element for EntrySelectedBy for TableControl (Format)](./selectionsetname-element-for-entryselectedby-for-tablecontrol-format.md)|Optional element.<br /><br /> Specifies a set of .NET types that use this table view definition.|
|[TypeName Element for EntrySelectedBy for TableControl (Format)](./typename-element-for-entryselectedby-for-tablecontrol-format.md)|Optional element.<br /><br /> Specifies a .NET type that uses this table view definition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableRowEntry Element for TableControl (Format)](./tablerowentry-element-for-tablerowentries-for-tablecontrol-format.md)|Defines the data that is displayed in a row of the table.|

## Remarks

You must specify at least one type, selection set, or selection condition for a table view definition. There is no maximum limit to the number of child elements that you can use.

Selection conditions are used to define a condition that must exist for the definition to be used, such as when an object has a specific property or that a specific property value or script evaluates to `true`. For more information about selection conditions, see [Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md).

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

The following example shows a `TableRowEntry` element that is used to display the properties of the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) object.

```xml
<TableRowEntry>
  <EntrySelectedBy>
    <TypeName>System.Diagnostics.Process</TypeName>
  </EntrySelectedBy>
  <TableColumnItems>
    <TableColumnItem>
      <PropertyName>PropertyForFirstColumn</PropertyName>
    </TableColumnItem>
    <TableColumnItem>
      <PropertyName>PropertyForSecondColumn</PropertyName>
    </TableColumnItem>
  </TableColumnItems>
</TableRowEntry>
```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[SelectionCondition Element for EntrySelectedBy for TableControl (Format)](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)

[SelectionSetName Element for EntrySelectedBy for TableControl (Format)](./selectionsetname-element-for-entryselectedby-for-tablecontrol-format.md)

[TableRowEntry Element for TableControl (Format)](./tablerowentry-element-for-tablerowentries-for-tablecontrol-format.md)

[TypeName Element for EntrySelectedBy for TableControl (Format)](./typename-element-for-entryselectedby-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
