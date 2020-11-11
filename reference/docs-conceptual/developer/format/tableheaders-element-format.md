---
ms.date: 09/13/2016
ms.topic: reference
title: TableHeaders Element (Format)
description: TableHeaders Element (Format)
---
# TableHeaders Element (Format)

Defines the headers for the columns of a table.

ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableHeaders Element for TableControl (Format)

## Syntax

```xml
<TableHeaders>
  <TableColumnHeader>...</TableColumnHeader>
</TableHeaders>

```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent elements of the `TableHeaders` element. There must be a child element for each property of the object that is to be displayed. The column header information is displayed in the order that the child elements are specified.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[TableColumnHeader Element (Format)](./tablecolumnheader-element-format.md)|Optional element.<br /><br /> Defines the label, the width, and the alignment of the data for a column of a table view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableControl Element (Format)](./tablecontrol-element-format.md)|Defines a table format for a view.|

## Remarks

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

This example shows a `TableHeaders` element that defines two column headers.

```xml
<TableHeaders>
  <TableColumnHeader>
    <Label>Column 1</Label)
    <Width>16</Width>
    <Alignment>Left</Alignment>
  </TableColumnHeader>
  <TableColumnHeader>
    <Label>Column 2</Label)
    <Width>10</Width>
    <Alignment>Centered</Alignment>
  </TableColumnHeader>
</TableHeaders>
```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[TableColumnHeader Element (Format)](./tablecolumnheader-element-format.md)

[TableControl Element (Format)](./tablecontrol-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
