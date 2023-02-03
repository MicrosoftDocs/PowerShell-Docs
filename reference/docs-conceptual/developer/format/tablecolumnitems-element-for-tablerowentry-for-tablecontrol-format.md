---
description: TableColumnItems Element
ms.date: 08/25/2021
ms.topic: reference
title: TableColumnItems
---
# TableColumnItems Element

Defines the properties or scripts whose values are displayed in a row.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- TableControl Element
- TableRowEntries Element for TableControl
- TableRowEntry Element for TableRowEntries for TableControl
- TableColumnItems Element for TableControlEntry for TableControl

## Syntax

```xml
<TableColumnItems>
  <TableColumnItem>...</TableColumnItem>
</TableColumnItems>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the
`TableColumnItems` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[TableColumnItem Element for TableColumnItems for TableControl](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)|Required element.<br /><br /> Defines the property or script whose value is displayed in a column of the row.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableRowEntry Element for TableRowEntries for TableControl](./tablerowentry-element-for-tablerowentries-for-tablecontrol-format.md)|Defines the data that is displayed in a row of the table.|

## Remarks

A `TableColumnItem` element is required for each column of the row. The first entry is displayed in
first column, the second entry in the second column, and so on.

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

The following example shows a `TableColumnItems` element that defines three properties of the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process)
object.

```xml
<TableColumnItems>
  <TableColumnItem>
    <PropertyName>Status</PropertyName>
  </TableColumnItem>
  <TableColumnItem>
    <PropertyName>Name</PropertyName>
  </TableColumnItem>
  <TableColumnItem>
    <PropertyName>DisplayName</PropertyName>
  </TableColumnItem>
</TableColumnItems>

```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[TableColumnItem Element](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)

[TableRowEntry Element](./tablerowentry-element-for-tablerowentries-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
