---
description: PropertyName Element for ItemSelectionCondition for Controls for Configuration
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for ItemSelectionCondition for Controls for Configuration
---
# PropertyName Element for ItemSelectionCondition for Controls for Configuration

Specifies the .NET property that triggers the condition. When this property is present or when it
evaluates to `true`, the condition is met, and the control is used. This element is used when
defining a common control that can be used by all the views in the formatting file.

## Schema

- Configuration Element
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
|[ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)|Defines the condition that must exist for this control to be used.|

## Text Value

Specify the name of the .NET property that triggers the condition.

## Remarks

If this element is used, you cannot specify the [ScriptBlock](./scriptblock-element-for-itemselectioncondition-for-controls-for-configuration-format.md)
element when defining the selection condition.

## See Also

[ScriptBlock Element for ItemSelectionCondition for Controls for Configuration](./scriptblock-element-for-itemselectioncondition-for-controls-for-configuration-format.md)

[ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
