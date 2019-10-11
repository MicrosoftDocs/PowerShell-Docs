---
title: "PropertyName Element for TableColumnItem for TableControl (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: fb26d72c-2f77-4801-badf-0537ccc55e31
caps.latest.revision: 10
---
# PropertyName Element for TableColumnItem for TableControl (Format)

Specifies the property whose value is displayed in the column of the row.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableRowEntries Element (Format)
TableRowEntry Element (Format)
TableColumnItems Element (Format)
TableColumnItem Element (Format)
PropertyName Element for TableColumnItem (Format)

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent element of the `PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableColumnItem Element (Format)](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)|Defines the property or script whose value is displayed in the column of the row.|

## Text Value

Specify the name of the property whose value is displayed.

## Remarks

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

This example shows a `TableColumnItem` element that specifies the `Status` property of the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) object.

```xml
<TableColumnItem>
   <Alignment>Centered</Alignment>
  <PropertyName>Status</PropertyName>
</TableColumnItem>

```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[TableColumnItem Element (Format)](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
