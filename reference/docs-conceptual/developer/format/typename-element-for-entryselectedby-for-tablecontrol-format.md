---
ms.date: 09/13/2016
ms.topic: reference
title: TypeName Element for EntrySelectedBy for TableControl (Format)
description: TypeName Element for EntrySelectedBy for TableControl (Format)
---
# TypeName Element for EntrySelectedBy for TableControl (Format)

Specifies a .NET type that uses this entry of the table view. There is no limit to the number of types that can be specified for a table entry.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
TableControl Element (Format)
TableRowEntries Element (Format)
TableRowEntry Element (Format)
EntrySelectedBy Element (Format)
TypeName Element for EntrySelectedBy for TableRowEntry (Format)

## Syntax

```xml
<TypeName>Nameof.NetType</TypeName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `TypeName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element (Format)](./entryselectedby-element-for-tablerowentry-for-tablecontrol-format.md)|Defines the .NET types that use this entry or the condition that must exist for this entry to be used.|

## Text Value

Specify the name of the .NET type.

## Remarks

Each list entry must have at least one type name, selection set, or selection condition defined.

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## See Also

[Creating a Table View](./creating-a-table-view.md)

[EntrySelectedBy Element (Format)](./entryselectedby-element-for-tablerowentry-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
