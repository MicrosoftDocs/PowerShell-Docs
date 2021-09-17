---
description: ScriptBlock Element for ItemSelectionCondition for Controls for Configuration
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for ItemSelectionCondition for Controls for Configuration
---
# ScriptBlock Element for ItemSelectionCondition for Controls for Configuration

Specifies the script that triggers the condition. When this script is evaluated to `true`, the
condition is met, and the control is used. This element is used when defining a common control that
can be used by all the views in the formatting file.

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
|[ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)|Defines the condition that must exist for this control to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

If this element is used, you cannot specify the [PropertyName](./propertyname-element-for-itemselectioncondition-for-controls-for-configuration-format.md)
element when defining the selection condition.

## See Also

[PropertyName Element for ItemSelectionCondition for Controls for Configuration](./propertyname-element-for-itemselectioncondition-for-controls-for-configuration-format.md)

[ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
