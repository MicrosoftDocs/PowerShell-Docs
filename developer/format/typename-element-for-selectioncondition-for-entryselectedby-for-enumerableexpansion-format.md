---
title: "TypeName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: d9100ab7-fbdc-4c0d-bb56-57669ef42b95
caps.latest.revision: 9
---
# TypeName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)

Specifies a .NET type that triggers the condition.

Configuration Element
DefaultSettings Element (Format)
EnumerableExpansions Element (Format)
EnumerableExpansions Element (Format)
EntrySelectedBy Element for EnumerableExpansion (Format)
SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)
TypeName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)

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
|[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)|Defines the condition that must exist to expand the collection objects of this definition.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

## See Also

[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
