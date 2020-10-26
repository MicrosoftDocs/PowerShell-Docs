---
ms.date: 09/13/2016
ms.topic: reference
title: TypeName Element for EntrySelectedBy for Controls for Configuration (Format)
description: TypeName Element for EntrySelectedBy for Controls for Configuration (Format)
---
# TypeName Element for EntrySelectedBy for Controls for Configuration (Format)

Specifies a .NET type that uses this definition of the control. This element is used when defining a common control that can be used by all the views in the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)
Control Element for Controls for Configuration (Format)
CustomControl Element for Control for Configuration (Format)
CustomEntries Element for CustomControl for Configuration (Format)
CustomEntry Element for CustomControl for Controls for Configuration (Format)
EntrySelectedBy Element for CustomEntry for Controls for Configuration (Format)
TypeName Element for EntrySelectedBy for Controls for Configuration (Format)

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
|[EntrySelectedBy Element for CustomEntry for Controls for Configuration (Format)](./entryselectedby-element-for-customentry-for-controls-for-configuration-format.md)|Defines the .NET types that use this control definition or the condition that must exist for this definition to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

## See Also

[EntrySelectedBy Element for CustomEntry for Controls for Configuration (Format)](./entryselectedby-element-for-customentry-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
