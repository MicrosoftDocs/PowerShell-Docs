---
title: "TypeName Element for EntrySelectedBy for WideEntry (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 81a91c74-6229-4b64-aa2b-9123e8b7e9e5
caps.latest.revision: 11
---
# TypeName Element for EntrySelectedBy for WideEntry (Format)

Specifies a .NET type for the definition. The definition is used whenever this object is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
WideControl Element (Format)
WideEntries Element (Format)
WideEntry Element (Format)
EntrySelectedBy Element for WideEntry (Format)
TypeName Element for WideEntry (Format)

## Syntax

```xml
<TypeName>Nameof.NetType</TypeName>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `TypeName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for WideEntry (Format)](./entryselectedby-element-for-wideentry-format.md)|Defines the .NET types that use this wide entry or the condition that must exist for this entry to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

Each wide entry must specify one or more .NET types, a selection set, or the selection condition that must exist for the definition to be used.

For more information about other components of a wide view, see [Creating a Wide View](./creating-a-wide-view.md).

## See Also

[Creating a Wide View](./creating-a-wide-view.md)

[EntrySelectedBy Element for WideEntry (Format)](./entryselectedby-element-for-wideentry-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
