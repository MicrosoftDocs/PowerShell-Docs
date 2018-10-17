---
title: "ItemSelectionCondition Element for ExpressionBinding for CustomControl (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: f4bea9d8-27ad-410e-ad48-287f807d3e4e
caps.latest.revision: 7
---
# ItemSelectionCondition Element for ExpressionBinding for CustomControl (Format)

Defines the condition that must exist for this control to be used. There is no limit to the number of selection conditions that can be specified for a control item. This element is used when defining a custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for View (Format)
CustomItem Element for CustomEntry for View (Format)
ExpressionBinding Element for CustomItem for CustomControl for View (Format)
ItemSelectionCondition Element for Expression Binding for CustomControl for View (Format)

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
|[PropertyName Element for ItemSelectionCondition for CustomControl for View (Format](./propertyname-element-for-itemselectioncondition-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Specifies the .NET property that triggers the condition.|
|[ScriptBlock Element for ItemSelectionCondition for CustomControl for View (Format)](./scriptblock-element-for-itemselectioncondition-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ExpressionBinding Element for CustomItem for CustomControl for View (Format)](./expressionbinding-element-for-customitem-for-customcontrol-for-view-format.md)|Defines the data that is displayed by the control.|

## Remarks

You can specify one property name or a script for this condition but cannot specify both.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

[ExpressionBinding Element for CustomItem for CustomControl for View (Format)](./expressionbinding-element-for-customitem-for-customcontrol-for-view-format.md)
