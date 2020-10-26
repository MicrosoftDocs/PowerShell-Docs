---
ms.date: 09/13/2016
ms.topic: reference
title: Label Element for TableColumnHeader for TableControl (Format)
description: Label Element for TableColumnHeader for TableControl (Format)
---
# Label Element for TableColumnHeader for TableControl (Format)

Defines the label that is displayed at the top of a column. This element is used when defining a table view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableHeaders Element for TableControl (Format)
TableColumnHeader Element for TableHeaders for TableControl (Format)
Label Element  for TableColumnHeader for TableControl (Format)

## Syntax

```xml
<Label>DisplayedLabel</Label>

```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `Label` element. Only one label is allowed for each column.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableColumnHeader Element for TableHeaders for TableControl  (Format)](./tablecolumnheader-element-format.md)|Defines a label, the width, and the alignment of the data for a column of the table.|

## Text Value

Specify the text that is displayed at the top of the column of the table. There are no restricted characters for the column label.

## Remarks

If no label is specified, the name of the property whose value is displayed in the rows is used.

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

This example shows a `TableColumnHeader` element whose label is "Column 1".

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
