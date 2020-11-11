---
ms.date: 09/13/2016
ms.topic: reference
title: ScriptBlock Element for ItemSeclectionCondition for Controls for Configuration (Format)
description: ScriptBlock Element for ItemSeclectionCondition for Controls for Configuration (Format)
---
# ScriptBlock Element for ItemSeclectionCondition for Controls for Configuration (Format)

Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the control is used. This element is used when defining a common control that can be used by all the views in the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)
Control Element for Controls for Configuration (Format)
CustomControl Element for Control for Configuration (Format)
CustomEntries Element for CustomControl for Configuration (Format)
CustomEntry Element for CustomControl for Controls for Configuration (Format)
CustomItem Element for CustomEntry for Controls for Configuration
ExpressionBinding Element for CustomItem for Controls for Configuration (Format)
ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)
ScriptBlock Element for ItemSelectionCondition for Controls for Configuration (Format)

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
|[ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)|Defines the condition that must exist for this control to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

If this element is used, you cannot specify the [PropertyName](./propertyname-element-for-itemseclectioncondition-for-controls-for-configuration-format.md) element when defining the selection condition.

## See Also

[PropertyName Element for ItemSeclectionCondition for Controls for Configuration (Format)](./propertyname-element-for-itemseclectioncondition-for-controls-for-configuration-format.md)

[ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
