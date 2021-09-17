---
description: TypeName Element for SelectionCondition for Controls for Configuration
ms.date: 08/25/2021
ms.topic: reference
title: TypeName Element for SelectionCondition for Controls for Configuration
---
# TypeName Element for SelectionCondition for Controls for Configuration

Specifies a .NET type that triggers the condition. This element is used when defining a common
control that can be used by all the views in the formatting file.

## Schema

- Configuration Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
- EntrySelectedBy Element
- SelectionCondition Element
- TypeName Element

## Syntax

```xml
<TypeName>Nameof.NetType</TypeName>

```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `TypeName`
Element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for CustomEntry for Configuration](./selectioncondition-element-for-entryselectedby-for-controls-for-configuration-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

## See Also

[SelectionCondition Element for EntrySelectedBy for CustomEntry for Configuration](./selectioncondition-element-for-entryselectedby-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
