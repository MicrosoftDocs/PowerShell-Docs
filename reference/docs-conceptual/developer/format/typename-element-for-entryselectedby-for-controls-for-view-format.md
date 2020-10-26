---
ms.date: 09/13/2016
ms.topic: reference
title: TypeName Element for EntrySelectedBy for Controls for View (Format)
description: TypeName Element for EntrySelectedBy for Controls for View (Format)
---
# TypeName Element for EntrySelectedBy for Controls for View (Format)

Specifies a .NET type that uses this definition of the control. This element is used when defining controls that can be used by a view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
Controls Element (Format)
Control Element for Controls for View (Format)
CustomControl Element for Control for Controls for View (Format)
CustomEntries Element for CustomControl for Controls for View (Format)
CustomEntry Element for CustomEntries for Controls for View (Format)
TypeName Element for EntrySelectedBy for Controls for View (Format)

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
|[EntrySelectedBy Element for CustomEntry for Controls for View (Format)](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)|Defines the .NET types that use this control definition or the condition that must exist for this definition to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

## See Also

[EntrySelectedBy Element for CustomEntry for Controls for View (Format)](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
