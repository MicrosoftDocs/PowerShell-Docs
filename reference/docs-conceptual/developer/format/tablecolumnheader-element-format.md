---
ms.date: 09/13/2016
ms.topic: reference
title: TableColumnHeader Element (Format)
description: TableColumnHeader Element (Format)
---
# TableColumnHeader Element (Format)

Defines the label, the width of the column, and the alignment of the label for a column of the table.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableHeaders Element for TableControl (Format)
TableColumnHeader Element for TableHeaders for TableControl (Format)

## Syntax

```xml
<TableColumnHeader>
  <Label>DisplayedLabel</Label>
  <Width>NumberOfCharacters</Width>
  <Alignment>Left, Right, or Centered</Alignment>
</TableColumnHeader>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `TableColumnHeader` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[Label Element For TableColumnHeader for TableControl (Format)](./label-element-for-tablecolumnheader-for-tablecontrol-format.md)|Optional element.<br /><br /> Defines the label that is displayed at the top of the column. If no label is specified, the name of the property whose value is displayed in the rows is used.|
|[Width Element for TableColumnHeader for TableControl (Format)](./width-element-for-tablecolumnheader-for-tablecontrol-format.md)|Required element.<br /><br /> Specifies the width (in characters) of the column.|
|[Alignment Element for TableColumnHeader for TableControl (Format)](./alignment-element-for-tablecolumnheader-for-tablecontrol-format.md)|Optional element.<br /><br /> Specifies how the label of the column is displayed. If no alignment is specified, the label is aligned on the left.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableHeaders Element (Format)](./tableheaders-element-format.md)|Defines the columns of a table view.|

## Remarks

Specify a header for each column of the table. The columns are displayed in the order in which the `TableColumnHeader` elements are defined.

A table must have the same number of `TableColumnHeader` elements as `TableRowEntry` elements. The column header defines how the text at the top of the table is displayed. The row entries define what data is displayed in the rows of the table.

For more information about the components of a table view, see [Table View](./creating-a-table-view.md).

## Example

The following example shows two `TableColumnHeader` elements. The first element defines a column whose label is "Column 1", has a width of 16 characters, and whose label is aligned on the left. The second element defines a column whose label is "Column 2", has a width of 10 characters, and whose label is centered in the column.

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

[Alignment Element for TableColumnHeader for TableControl (Format)](./alignment-element-for-tablecolumnheader-for-tablecontrol-format.md)

[Creating a Table View](./creating-a-table-view.md)

[Label Element for TableColumnHeader for TableControl (Format)](./label-element-for-tablecolumnheader-for-tablecontrol-format.md)

[TableHeaders Element for TableControl (Format)](./tableheaders-element-format.md)

[Width for TableColumnHeader for TableControl Element (Format)](./width-element-for-tablecolumnheader-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
