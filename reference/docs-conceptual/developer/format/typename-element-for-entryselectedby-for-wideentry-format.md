---
description: TypeName Element for EntrySelectedBy for WideEntry
ms.date: 08/25/2021
title: TypeName Element for EntrySelectedBy for WideEntry
---
# TypeName Element for EntrySelectedBy for WideEntry

Specifies a .NET type for the definition. The definition is used whenever this object is displayed.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- WideControl Element
- WideEntries Element
- WideEntry Element
- EntrySelectedBy Element
- TypeName Element

## Syntax

```xml
<TypeName>Nameof.NetType</TypeName>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`TypeName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for WideEntry](./entryselectedby-element-for-wideentry-format.md)|Defines the .NET types that use this wide entry or the condition that must exist for this entry to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

Each wide entry must specify one or more .NET types, a selection set, or the selection condition
that must exist for the definition to be used.

For more information about other components of a wide view, see [Creating a Wide View](./creating-a-wide-view.md).

## See Also

[Creating a Wide View](./creating-a-wide-view.md)

[EntrySelectedBy Element for WideEntry](./entryselectedby-element-for-wideentry-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
