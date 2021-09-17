---
description: ItemSelectionCondition Element for ExpressionBinding for Controls for View
ms.date: 08/23/2021
ms.topic: reference
title: ItemSelectionCondition Element for ExpressionBinding for Controls for View
---
# ItemSelectionCondition Element for ExpressionBinding for Controls for View

Defines the condition that must exist for this control to be used. This element is used when
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
|[PropertyName Element for ItemSelectionCondition for Controls for View](./propertyname-element-for-itemselectioncondition-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies the .NET property that triggers the condition.|
|[ScriptBlock Element for ItemSelectionCondition for Controls for View](./scriptblock-element-for-itemselectioncondition-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ExpressionBinding Element for CustomItem for Controls for View](./expressionbinding-element-for-customitem-for-controls-for-view-format.md)|Defines the data that is displayed by the control.|

## Remarks

You can specify one property name or a script for this condition but cannot specify both.

## See Also

[PropertyName Element for ItemSelectionCondition for Controls for View](./propertyname-element-for-itemselectioncondition-for-controls-for-view-format.md)

[ScriptBlock Element for ItemSelectionCondition for Controls for View](./scriptblock-element-for-itemselectioncondition-for-controls-for-view-format.md)

[ExpressionBinding Element for CustomItem for Controls for View](./expressionbinding-element-for-customitem-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
