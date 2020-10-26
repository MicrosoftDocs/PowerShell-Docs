---
ms.date: 09/13/2016
ms.topic: reference
title: FormatString Element for TableColumnItem for TableControl (Format)
description: FormatString Element for TableColumnItem for TableControl (Format)
---
# FormatString Element for TableColumnItem for TableControl (Format)

Specifies a format pattern that defines how the property or script value of the table is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableRowEntries Element (Format)
TableRowEntry Element (Format)
TableColumnItems Element (Format)
TableColumnItem Element (Format)
FormatString Element for TableColumnItem (Format)

## Syntax

```xml
<FormatString>FormatPattern</FormatString>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `FormatString` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[TableColumnItem Element (Format)](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)|Defines the property or script whose value is displayed in the column of the row.|

## Text Value

Specify the pattern that is used to format the data. For example, this pattern can be used to format the value of any property that is of type [System.Timespan](/dotnet/api/System.TimeSpan): {0:MMM}{0:dd}{0:HH}:{0:mm}.

## Remarks

Format strings can be used when creating table views, list views, wide views, or custom views. For more information about formatting a value displayed in a view, see [Formatting Displayed Data](./formatting-displayed-data.md).

For more information about the components of a table view, see [Table View](./creating-a-table-view.md).

## Example

The following example shows how to define a formatting string for the value of the `StartTime` property.

```xml
<TableColumnItem>
  <PropertyName>StartTime</PropertyName>
  <FormatString>{0:MMM} (0:DD) (0:HH):(0:MM)</FormatString>
</TableColumnItem>
```

## See Also

[Creating a Table View](./creating-a-table-view.md)

[Formatting Displayed Data](./formatting-displayed-data.md)

[TableColumnItem Element (Format)](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
