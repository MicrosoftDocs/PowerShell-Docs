---
description: TypeName Element for EntrySelectedBy for EnumerableExpansion
ms.date: 08/25/2021
ms.topic: reference
title: TypeName Element for EntrySelectedBy for EnumerableExpansion
---
# TypeName Element for EntrySelectedBy for EnumerableExpansion

Specifies a .NET type that is expanded by this definition. This element is used when defining a
default settings.

## Schema

- Configuration Element
- DefaultSettings Element
- EnumerableExpansions Element
- EnumerableExpansion Element
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
|[EntrySelectedBy Element for EnumerableExpansion](./entryselectedby-element-for-enumerableexpansion-format.md)|Defines the .NET types that use this definition or the condition that must exist for this definition to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

## See Also

[EntrySelectedBy Element for EnumerableExpansion](./entryselectedby-element-for-enumerableexpansion-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
