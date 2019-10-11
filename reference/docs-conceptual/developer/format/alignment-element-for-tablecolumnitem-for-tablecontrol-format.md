---
title: "Alignment Element for TableColumnItem for TableControl (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: b07a53df-64f1-49b0-8cea-c993b3f1f76b
caps.latest.revision: 10
---
# Alignment Element for TableColumnItem for TableControl (Format)

Defines how the data in a column of the row is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableRowEntries Element (Format)
TableRowEntry Element (Format)
TableColumnItems Element (Format)
TableColumnItem Element (Format)
Alignment Element for TableColumnItem (Format)

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
|[TableColumnItem Element (Format)](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)|Defines a label, the width, and the alignment of the data for a column of the table.|

## Text Value

Specify one of the following values. (These values are not case-sensitive.)

Left
Shifts the data displayed in the column to the left. (This is the default if this element is not specified.)

Right
Shifts the data displayed in the column to the right.

Center
Centers the data displayed in the column.

## Remarks

For more information about the components of a table view, see [Table View](./creating-a-table-view.md).

## See Also

[Table View](./creating-a-table-view.md)

[TableColumnItem Element (Format)](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)
