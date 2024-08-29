---
description: Alignment Element for TableColumnHeader
ms.date: 08/20/2021
ms.topic: reference
title: Alignment Element for TableColumnHeader
---
# Alignment Element for TableColumnHeader

Defines how the data in a column header is displayed.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- TableControl Element
- TableHeaders Element
- TableColumnHeader Element
- Alignment Element

## Syntax

```xml
<Alignment>AlignmentType</Alignment>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the
`Alignment` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableColumnHeader Element](./tablecolumnheader-element-format.md)|Defines a label, the width, and the alignment of the data for a column of the table.|

## Text Value

Specify one of the following values. These values are not case-sensitive.

- Left - Aligns the data displayed in the column on the left This is the default if this element is
  not specified.
- Right - Aligns the data displayed in the column on the right.
- Center - Centers the data displayed in the column.

## Remarks

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

This example shows a `TableColumnHeader` element whose data is aligned on the center.

```xml
<TableColumnHeader>
  <Label>Column 1</Label>
  <Width>16</Width>
  <Alignment>Center</Alignment>
</TableColumnHeader>
```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[TableColumnHeader Element](./tablecolumnheader-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
