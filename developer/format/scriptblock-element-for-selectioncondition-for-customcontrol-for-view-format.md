---
title: "ScriptBlock Element for SelectionCondition for CustomControl for View (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 7031fa8b-3e2b-4ea8-89cb-95171f467b5a
caps.latest.revision: 6
---
# ScriptBlock Element for SelectionCondition for CustomControl for View (Format)

Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the definition is used. This element is used when defining a custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element for View (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for CustomControl for View (Format)
CustomItem Element for CustomEntry for CustomControl for View (Format)
SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)
ScriptBlock Element for SelectionCondition for CustomControl for View (Format)

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

The selection condition must specify a least one script or property name to evaluate, but cannot specify both. For more information about how selection conditions can be used, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
