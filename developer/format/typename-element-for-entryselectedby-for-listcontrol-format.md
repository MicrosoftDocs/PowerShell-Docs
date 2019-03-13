---
title: "TypeName Element for EntrySelectedBy for ListControl (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 33c7345c-b808-4c1e-bd54-cb870b407432
caps.latest.revision: 14
---
# TypeName Element for EntrySelectedBy for ListControl (Format)

Specifies a .NET type that uses this entry of the list view. There is no limit to the number of types that can be specified for a list entry.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element (Format)
ListEntry Element (Format)
EntrySelectedBy Element for ListEntry (Format)
TypeName Element for EntrySelectedBy for ListControl (Format)

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
|[EntrySelectedBy Element for ListEntry (Format)](./entryselectedby-element-for-listentry-for-listcontrol-format.md)|Defines the .NET types that use this list entry or the condition that must exist for this entry to be used.|

## Text Value

Specify the fully-qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

Each list entry must have at least one type name, selection set, or selection condition defined.

For more information about how this element is used in a list view, see [List View](./creating-a-list-view.md).

## Example

The following example shows how to specify a selection set for an entry of a list view.

```xml
<ListEntry>
  <EntrySelectedBy>
    <TypeName>Nameof.NetType</TypeName>
  </EntrySelectedBy>
  <ListItems>...</ListItems>
</ListEntry>
```

## See Also

[Creating a List View](./creating-a-list-view.md)

[EntrySelectedBy Element for ListEntry (Format)](./entryselectedby-element-for-listentry-for-listcontrol-format.md)

[SelectionSetName Element for EntrySelectedBy for ListEntry (Format)](./selectionsetname-element-for-entryselectedby-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
