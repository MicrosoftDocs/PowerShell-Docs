---
ms.date: 09/13/2016
ms.topic: reference
title: ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)
description: ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)
---
# ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)

Defines the condition that must exist for this control to be used. This element is used when defining a common control that can be used by all the views in the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)
Control Element for Controls for Configuration (Format)
CustomControl Element for Control for Configuration (Format)
CustomEntries Element for CustomControl for Configuration (Format)
CustomEntry Element for CustomControl for Controls for Configuration (Format)
CustomItem Element for CustomEntry for Controls for Configuration
ExpressionBinding Element for CustomItem for Controls for Configuration (Format)
ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)

## Syntax

```xml
<ItemSelectionCondition>
  <PropertyName>.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate</ScriptBlock>
</ItemSelectionCondition>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `ItemSelectionCondition` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[PropertyName Element for ItemSelectionCondition for Controls for Configuration (Format)](./propertyname-element-for-itemseclectioncondition-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the .NET property that triggers the condition.|
|[ScriptBlock Element for ItemSelectionCondition for Controls for Configuration (Format)](./scriptblock-element-for-itemseclectioncondition-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ExpressionBinding Element for CustomItem for Controls for Configuration (Format)](./expressionbinding-element-for-customitem-for-controls-for-configuration-format.md)|Defines the data that is displayed by the control.|

## Remarks

You can specify one property name or a script for this condition but cannot specify both.

## See Also

[PropertyName Element for ItemSelectionCondition for Controls for Configuration (Format)](./propertyname-element-for-itemseclectioncondition-for-controls-for-configuration-format.md)

[ScriptBlock Element for ItemSelectionCondition for Controls for Configuration (Format)](./scriptblock-element-for-itemseclectioncondition-for-controls-for-configuration-format.md)

[ExpressionBinding Element for CustomItem for Controls for Configuration (Format)](./expressionbinding-element-for-customitem-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
