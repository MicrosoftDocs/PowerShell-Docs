---
description: ItemSelectionCondition Element for ExpressionBinding for GroupBy
ms.date: 08/23/2021
ms.topic: reference
title: ItemSelectionCondition Element for ExpressionBinding for GroupBy
---
# ItemSelectionCondition Element for ExpressionBinding for GroupBy

Defines the condition that must exist for this control to be used. There is no limit to the number
of selection conditions that can be specified for a control item. This element is used when defining
how a new group of objects is displayed.

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

## Syntax

```xml
<ItemSelectionCondition>
  <PropertyName>.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate</ScriptBlock>
</ItemSelectionCondition>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`ItemSelectionCondition` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[PropertyName Element for ItemSelectionCondition for GroupBy](./propertyname-element-for-itemselectioncondition-for-groupby-format.md)|Optional element.<br /><br /> Specifies the .NET property that triggers the condition.|
|[ScriptBlock Element for ItemSelectionCondition for GroupBy](./scriptblock-element-for-itemselectioncondition-for-groupby-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ExpressionBinding Element for CustomItem for GroupBy](./expressionbinding-element-for-customitem-for-groupby-format.md)|Defines the data that is displayed by the control.|

## Remarks

You can specify one property name or a script for this condition but cannot specify both.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

[ExpressionBinding Element for CustomItem for GroupBy](./expressionbinding-element-for-customitem-for-groupby-format.md)
