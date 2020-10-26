---
ms.date: 09/13/2016
ms.topic: reference
title: TableControl Element (Format)
description: TableControl Element (Format)
---
# TableControl Element (Format)

Defines a table format for a view.

ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)

## Syntax

```xml
<TableControl>
  <AutoSize/>
  <HideTableHeaders/>
  <TableHeaders>...</TableHeaders>
  <TableRowEntries>...</TableRowEntries>
</TableControl>

```

## Attributes and Elements

The following sections describe attributes, child elements, and parent element of the `TableControl` element. You must specify the rows of the table. All other child elements are optional.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[AutoSize Element for TableControl (Format)](./autosize-element-for-tablecontrol-format.md)|Optional element.<br /><br /> Specifies whether the column size and the number of columns are adjusted based on the size of the data.|
|[HideTableHeaders Element for TableControl (Format)](./hidetableheaders-element-format.md)|Optional element.<br /><br /> Indicates whether the header of the table is not displayed.|
|[TableHeaders Element for TableControl (Format)](./tableheaders-element-format.md)|Required element.<br /><br /> Defines the labels, the widths, and the alignment of the data for the columns of the table view.|
|[TableRowEntries Element for TableControl (Format)](./tablerowentries-element-for-tablecontrol-format.md)|Optional element.<br /><br /> Provides the definitions of the table view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[View Element (Format)](./view-element-format.md)|Defines a view that is used to display the members of one or more objects.|

## Remarks

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

This example shows a `TableControl` element that is used to display the properties of the [System.Serviceprocess.Servicecontroller](/dotnet/api/System.ServiceProcess.ServiceController) object.

```xml
<View>
  <Name>service</Name>
  <ViewSelectedBy>
    <TypeName>System.ServiceProcess.ServiceController</TypeName>
  </ViewSelectedBy>
  <TableControl>
    <TableHeaders>...</TableHeaders>
    <TableRowEntries>...</TableRowEntries>
  </TableControl>
</View>

```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[View Element (Format)](./view-element-format.md)

[AutoSize Element for TableControl (Format)](./autosize-element-for-tablecontrol-format.md)

[HideTableHeaders Element (Format)](./hidetableheaders-element-format.md)

[TableHeaders Element (Format)](./tableheaders-element-format.md)

[TableRowEntries Element (Format)](./tablerowentries-element-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
