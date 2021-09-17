---
description: ScriptBlock Element for ItemSelectionCondition for Controls for View
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for ItemSelectionCondition for Controls for View
---
# ScriptBlock Element for ItemSelectionCondition for Controls for View

Specifies the script that triggers the condition. When this script is evaluated to `true`, the
condition is met, and the control is used. This element is used when defining controls that can be
used by a view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
- CustomItem Element
- ExpressionBinding Element
- ItemSelectionCondition Element
- ScriptBlock Element

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ItemSelectionCondition Element of ExpressionBinding for Controls for View](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)|Defines the condition that must exist for this control to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

If this element is used, you cannot specify the [PropertyName](./propertyname-element-for-itemselectioncondition-for-controls-for-view-format.md)
element when defining the selection condition.

## See Also

[PropertyName Element for ItemSelectionCondition for Controls for View](./propertyname-element-for-itemselectioncondition-for-controls-for-view-format.md)

[ItemSelectionCondition Element of ExpressionBinding for Controls for View](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
