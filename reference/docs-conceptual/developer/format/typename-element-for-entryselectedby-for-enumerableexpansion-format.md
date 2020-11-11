---
ms.date: 09/13/2016
ms.topic: reference
title: TypeName Element for EntrySelectedBy for EnumerableExpansion (Format)
description: TypeName Element for EntrySelectedBy for EnumerableExpansion (Format)
---
# TypeName Element for EntrySelectedBy for EnumerableExpansion (Format)

Specifies a .NET type that is expanded by this definition. This element is used when defining a default settings.

Configuration Element (Format)
DefaultSettings Element (Format)
EnumerableExpansions Element (Format)
EnumerableExpansion Element (Format)
EntrySelectedBy Element for EnumerableExpansion (Format)
TypeName Element for EntrySelectedBy for EnumerableExpansion (Format)

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
|[EntrySelectedBy Element for EnumerableExpansion (Format)](./entryselectedby-element-for-enumerableexpansion-format.md)|Defines the .NET types that use this definition or the condition that must exist for this definition to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

## See Also

[EntrySelectedBy Element for EnumerableExpansion (Format)](./entryselectedby-element-for-enumerableexpansion-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
