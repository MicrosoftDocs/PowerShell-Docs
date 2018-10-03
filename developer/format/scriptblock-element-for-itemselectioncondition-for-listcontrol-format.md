---
title: "ScriptBlock Element for ItemSelectionCondition for ListControl (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: c929a6df-d050-416a-9de0-e913dd5a035c
caps.latest.revision: 8
---
# ScriptBlock Element for ItemSelectionCondition for ListControl (Format)

Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the list item is used. This element is used when defining a list view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element for ListControl (Format)
ListEntry Element for ListEntries for ListControl (Format)
ListItems Element for ListEntry for ListControl (Format)
ListItem Element for ListItems for List Control (Format)
ItemSelectionCondition Element for ListItem for ListControl (Format)
ScriptBlock Element for ItemSelectionCondition for ListControl  (Format)

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent elements of the `ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ItemSelectionCondition Element for ListItem for ListControl (Format)](./itemselectioncondition-element-for-listitem-for-listcontrol-format.md)|Defines the condition that must exist for this list item to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

If this element is used, you cannot specify the `PropertyName` element when defining the selection condition.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
