---
ms.date: 09/13/2016
ms.topic: reference
title: Alignment Element for TableColumnHeader for TableControl (Format)
description: Alignment Element for TableColumnHeader for TableControl (Format)
---
# Alignment Element for TableColumnHeader for TableControl (Format)

Defines how the data in a column header is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableHeaders Element (Format)
TableColumnHeader Element (Format)
Alignment Element for TableColumnHeader (Format)

## Syntax

```xml
<Alignment>AlignmentType</Alignment>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the `Alignment` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableColumnHeader Element (Format)](./tablecolumnheader-element-format.md)|Defines a label, the width, and the alignment of the data for a column of the table.|

## Text Value

Specify one of the following values. These values are not case-sensitive.

Left
Aligns the data displayed in the column on the left This is the default if this element is not specified.

Right
Aligns the data displayed in the column on the right.

Center
Centers the data displayed in the column.

## Remarks

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

This example shows a `TableColumnHeader` element whose data is aligned on the left.

```xml
<TableColumnHeader>
  <Label>Column 1</Label)
  <Width>16</Width>
  <Alignment>Left</Alignment>
</TableColumnHeader>
```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[TableColumnHeader Element (Format)](./tablecolumnheader-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
