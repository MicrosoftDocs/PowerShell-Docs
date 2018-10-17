---
title: "SelectionSetName Element for EntrySelectedBy for CustomControl for View (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 859d2335-7fcd-4efd-b1cc-3d171e334c6b
caps.latest.revision: 7
---
# SelectionSetName Element for EntrySelectedBy for CustomControl for View (Format)

Specifies a set of .NET objects for the list entry. There is no limit to the number of selection sets that can be specified for an entry.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for View (Format)
EntrySelectedBy Element for CustomEntry for View (Format)
SelectionSetName Element for EntrySelectedBy for CustomEntry (Format)

## Syntax

```xml
<SelectionSetName>NameofSelectionSet</SelectionSetName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `SelectionSetName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for CustomEntry for View (Format)](./entryselectedby-element-for-customentry-for-customcontrol-for-view-format.md)|Defines the .NET types that use this custom entry or the condition that must exist for this entry to be used.|

## Text Value

Specify the name of the selection set.

## Remarks

Each custom control entry must have at least one type name, selection set, or selection condition defined.

Selection sets are typically used when you want to define a group of objects that are used in multiple views. For example, you might want to create a table view and a list view for the same set of objects. For more information about defining selection sets, see [Defining Selection Sets](./defining-selection-sets.md).

For more information about the components of a custom control view, see [Creating Custom Controls](./creating-custom-controls.md).

## See Also

[EntrySelectedBy Element for CustomEntry for View (Format)](./entryselectedby-element-for-customentry-for-customcontrol-for-view-format.md)

[Custom Control View](./creating-custom-controls.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
