---
description: PropertyName Element for ItemSelectionCondition for Controls for View
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for ItemSelectionCondition for Controls for View
---
# PropertyName Element for ItemSelectionCondition for Controls for View

Specifies the .NET property that triggers the condition. When this property is present or when it
evaluates to `true`, the condition is met, and the control is used. This element is used when
defining controls that can be used by a view.

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
- PropertyName Element

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ItemSelectionCondition Element of ExpressionBinding for Controls for View](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)|Defines the condition that must exist for this control to be used.|

## Text Value

Specify the name of the .NET property that triggers the condition.

## Remarks

If this element is used, you cannot specify the [ScriptBlock](./scriptblock-element-for-itemselectioncondition-for-controls-for-view-format.md)
element when defining the selection condition.

## See Also

[ScriptBlock Element for ItemSelectionCondition for Controls for View](./scriptblock-element-for-itemselectioncondition-for-controls-for-view-format.md)

[ItemSelectionCondition Element of ExpressionBinding for Controls for View](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
