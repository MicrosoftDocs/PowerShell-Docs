---
description: PropertyName Element for TableColumnItem for TableControl
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for TableColumnItem for TableControl
---
# PropertyName Element for TableColumnItem for TableControl

Specifies the property whose value is displayed in the column of the row.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- TableControl Element
- TableRowEntries Element
- TableRowEntry Element
- TableColumnItems Element
- TableColumnItem Element
- PropertyName Element

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent element of the `PropertyName`
element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableColumnItem Element](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)|Defines the property or script whose value is displayed in the column of the row.|

## Text Value

Specify the name of the property whose value is displayed.

## Remarks

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## Example

This example shows a `TableColumnItem` element that specifies the `Status` property of the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process)
object.

```xml
<TableColumnItem>
   <Alignment>Centered</Alignment>
  <PropertyName>Status</PropertyName>
</TableColumnItem>

```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[TableColumnItem Element](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
