---
ms.date: 09/13/2016
ms.topic: reference
title: TypeName Element for SelectionCondition for CustomControl for View  (Format)
description: TypeName Element for SelectionCondition for CustomControl for View  (Format)
---
# TypeName Element for SelectionCondition for CustomControl for View  (Format)

Specifies a .NET type that triggers the condition. This element is used when defining a custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element for View (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for CustomControl for View (Format)
CustomItem Element for CustomEntry for CustomControl for View (Format)
SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)
TypeName Element for SelectionCondition for CustomControl for View  (Format)

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
|[SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

## See Also

[SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
