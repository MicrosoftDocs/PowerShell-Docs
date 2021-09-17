---
description: ScriptBlock Element for ItemSelectionCondition for ListControl
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for ItemSelectionCondition for ListControl
---
# ScriptBlock Element for ItemSelectionCondition for ListControl

Specifies the script that triggers the condition. When this script is evaluated to `true`, the
condition is met, and the list item is used. This element is used when defining a list view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element for ListControl
- ListEntry Element for ListEntries for ListControl
- ListItems Element for ListEntry for ListControl
- ListItem Element for ListItems for List Control
- ItemSelectionCondition Element for ListItem for ListControl
- ScriptBlock Element for ItemSelectionCondition for ListControl

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent elements of the
`ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ItemSelectionCondition Element for ListItem for ListControl](./itemselectioncondition-element-for-listitem-for-listcontrol-format.md)|Defines the condition that must exist for this list item to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

If this element is used, you cannot specify the `PropertyName` element when defining the selection
condition.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
