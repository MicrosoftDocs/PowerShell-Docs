---
description: PropertyName Element for ItemSelectionCondition for GroupBy
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for ItemSelectionCondition for GroupBy
---
# PropertyName Element for ItemSelectionCondition for GroupBy

Specifies the .NET property that triggers the condition. When this property is present or when it
evaluates to `true`, the condition is met, and the control is used. This element is used when
defining how a new group of objects is displayed.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- GroupBy Element
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
|[ItemSelectionCondition Element for ExpressionBinding for GroupBy](./itemselectioncondition-element-for-expressionbinding-for-groupby-format.md)|Defines the condition that must exist for this control to be used.|

## Text Value

Specify the name of the .NET property that triggers the condition.

## Remarks

If this element is used, you cannot specify the [ScriptBlock](./scriptblock-element-for-itemselectioncondition-for-groupby-format.md)
element when defining the selection condition.

## See Also

[ScriptBlock Element for ItemSelectionCondition for GroupBy](./scriptblock-element-for-itemselectioncondition-for-groupby-format.md)

[ItemSelectionCondition Element for ExpressionBinding for GroupBy](./itemselectioncondition-element-for-expressionbinding-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
