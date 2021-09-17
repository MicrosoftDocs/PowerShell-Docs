---
description: Alignment Element for TableColumnItem
ms.date: 08/20/2021
ms.topic: reference
title: Alignment Element for TableColumnItem
---
# Alignment Element for TableColumnItem

Defines how the data in a column of the row is displayed.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- TableControl Element
- TableRowEntries Element
- TableRowEntry Element
- TableColumnItems Element
- TableColumnItem Element
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
|[TableColumnItem Element](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)|Defines a label, the width, and the alignment of the data for a column of the table.|

## Text Value

Specify one of the following values. (These values are not case-sensitive.)

- Left - Shifts the data displayed in the column to the left. (This is the default if this element
  is not specified.)
- Right - Shifts the data displayed in the column to the right.
- Center - Centers the data displayed in the column.

## Remarks

For more information about the components of a table view, see [Table View](./creating-a-table-view.md).

## See Also

[Table View](./creating-a-table-view.md)

[TableColumnItem Element](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)
