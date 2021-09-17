---
description: TypeName Element for EntrySelectedBy for TableControl
ms.date: 08/25/2021
ms.topic: reference
title: TypeName Element for EntrySelectedBy for TableControl
---
# TypeName Element for EntrySelectedBy for TableControl

Specifies a .NET type that uses this entry of the table view. There is no limit to the number of
types that can be specified for a table entry.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- TableControl Element
- TableRowEntries Element
- TableRowEntry Element
- EntrySelectedBy Element
- TypeName Element

## Syntax

```xml
<TypeName>Nameof.NetType</TypeName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `TypeName`
element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element](./entryselectedby-element-for-tablerowentry-for-tablecontrol-format.md)|Defines the .NET types that use this entry or the condition that must exist for this entry to be used.|

## Text Value

Specify the name of the .NET type.

## Remarks

Each list entry must have at least one type name, selection set, or selection condition defined.

For more information about the components of a table view, see [Creating a Table View](./creating-a-table-view.md).

## See Also

[Creating a Table View](./creating-a-table-view.md)

[EntrySelectedBy Element](./entryselectedby-element-for-tablerowentry-for-tablecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
