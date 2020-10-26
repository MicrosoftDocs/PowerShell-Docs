---
ms.date: 09/13/2016
ms.topic: reference
title: TableColumnItem Element for TableColumnItems for TableControl (Format)
description: TableColumnItem Element for TableColumnItems for TableControl (Format)
---
# TableColumnItem Element for TableColumnItems for TableControl (Format)

Defines the property or script whose value is displayed in the column of the row.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableRowEntries Element for TableControl (Format)
TableRowEntry Element for TableRowEntries for TableControl (Format)
TableColumnItems Element for TableControlEntry for TableControl (Format)
TableColumnItem Element for TableColumnItems for TableControl (Format)

## Syntax

```xml
<TableColumnItem>
  <Alignment>Left, Right, or Center</Alignment>
  <FormatString>FormatPattern</FormatString>
  <PropertyName>Nameof.NetProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate</ScriptBlock>
</TableColumnItem>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the `TableColumnItem` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[Alignment Element for TableColumnItem for TableControl (Format)](./alignment-element-for-tablecolumnitem-for-tablecontrol-format.md)|Optional element.<br /><br /> Defines how the data in a column of the row is displayed.|
|[FormatString Element for TableColumnItem for TableControl (Format)](./formatstring-element-for-tablecolumnitem-for-tablecontrol-format.md)|Specifies a format pattern that is used to format the data in the column of the row.|
|[PropertyName Element for TableColumnItem for TableControl (Format)](./propertyname-element-for-tablecolumnitem-for-tablecontrol-format.md)|Optional element.<br /><br /> Specifies the name of the property whose value is displayed.|
|[ScriptBlock Element for TableColumnItem for TableControl (Format)](./scriptblock-element-for-tablecolumnitem-for-tablecontrol-format.md)|Optional element.<br /><br /> Specifies the script whose value is displayed in the column of a row.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableColumnItems Element for TableControlEntry for TableControl (Format)](./tablecolumnitems-element-for-tablerowentry-for-tablecontrol-format.md)|Defines the properties or scripts whose values are displayed in the row.|

## Remarks

You can specify a property of an object or a script in each column of the row. If no child elements are specified, the item is a placeholder, and no data is displayed.

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

This example shows a `TableColumnItem` element that displays the value of the `Status` property of the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) object.

```xml
<TableColumnItem>
   <Alignment>Centered</Alignment>
  <PropertyName>Status</PropertyName>
</TableColumnItem>

```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[Alignment Element for TableColumnItem for TableControl (Format)](./alignment-element-for-tablecolumnitem-for-tablecontrol-format.md)

[TableColumnItems Element (Format)](./tablecolumnitems-element-for-tablerowentry-for-tablecontrol-format.md)

[FormatString Element for TableColumnItem for TableControl (Format)](./formatstring-element-for-tablecolumnitem-for-tablecontrol-format.md)

[PropertyName Element for TableColumnItem for TableControl (Format)](./propertyname-element-for-tablecolumnitem-for-tablecontrol-format.md)

[ScriptBlock Element for TableColumnItem for TableControl (Format)](./scriptblock-element-for-tablecolumnitem-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
