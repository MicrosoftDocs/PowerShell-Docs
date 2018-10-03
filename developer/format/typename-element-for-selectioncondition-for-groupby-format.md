---
title: "TypeName Element for SelectionCondition for GroupBy (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 290d38e3-b9bd-4382-9671-2e28b32b7260
caps.latest.revision: 6
---
# TypeName Element for SelectionCondition for GroupBy (Format)

Specifies a .NET type that triggers the condition. This element is used when defining how a new group of objects is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
GroupBy Element for View (Format)
CustomControl Element for GroupBy (Format)
CustomEntries Element for CustomControl for GroupBy (Format)
CustomEntry Element for CustomControl for GroupBy (Format)
EntrySelectedBy Element for CustomEntry for GroupBy (Format)
SelectionCondition Element for EntrySelectedBy for GroupBy (Format)
TypeName Element for SelectionCondition for GroupBy  (Format)

## Syntax

```xml
<TypeName>Nameof.NetType</TypeName>

```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `TypeName` Element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for GroupBy (Format)](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

When this element is specified, you cannot specify the `SelectionSetName` element. For more information about defining selection conditions, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[SelectionCondition Element for EntrySelectedBy for GroupBy (Format)](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
