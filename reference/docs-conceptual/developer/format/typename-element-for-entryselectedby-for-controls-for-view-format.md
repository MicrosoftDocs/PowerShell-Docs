---
description: TypeName Element for EntrySelectedBy for Controls for View
ms.date: 08/25/2021
ms.topic: reference
title: TypeName Element for EntrySelectedBy for Controls for View
---
# TypeName Element for EntrySelectedBy for Controls for View

Specifies a .NET type that uses this definition of the control. This element is used when defining
controls that can be used by a view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
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
|[EntrySelectedBy Element for CustomEntry for Controls for View](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)|Defines the .NET types that use this control definition or the condition that must exist for this definition to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

## See Also

[EntrySelectedBy Element for CustomEntry for Controls for View](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
