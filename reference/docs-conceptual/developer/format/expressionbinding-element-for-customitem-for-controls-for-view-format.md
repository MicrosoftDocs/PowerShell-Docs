---
ms.date: 09/13/2016
ms.topic: reference
title: ExpressionBinding Element for CustomItem for Controls for View (Format)
description: ExpressionBinding Element for CustomItem for Controls for View (Format)
---
# ExpressionBinding Element for CustomItem for Controls for View (Format)

Defines the data that is displayed by the control. This element is used when defining controls that can be used by a view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
Controls Element (Format)
Control Element for Controls for View (Format)
CustomControl Element for Control for Controls for View (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for Controls for View (Format)
CustomItem Element for CustomEntry for Controls for View (Format)
ExpressionBinding Element for CustomItem for Controls for View (Format)

## Syntax

```xml
<ExpressionBinding>
  <CustomControl>...</CustomControl>
  <CustomControlName>NameofCommonCustomControl</CustomControlName>
  <EnumerateCollection/>
  <ItemSelectionCondition>...</ItemSelectionCondition>
  <PropertyName>Nameof.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate></ScriptBlock>
</ExpressionBinding>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `ExpressionBinding` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|`CustomControl Element`|Optional element.<br /><br /> Defines a control that is used by this control.|
|[CustomControlName Element for ExpressionBinding for Controls for View (Format)](./customcontrolname-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies the name of a common control or a view control.|
|[EnumerateCollection Element for ExpressionBinding for Controls for View (Format)](./enumeratecollection-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies that the elements of collections are displayed.|
|[ItemSelectionCondition Element of ExpressionBinding for Controls for View (Format)](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this control to be used.|
|[PropertyName Element for ExpressionBinding for Controls for View (Format)](./propertyname-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies the .NET property whose value is displayed by the control.|
|[ScriptBlock Element for ExpressionBinding for Controls for View (Format)](./scriptblock-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies the script whose value is displayed by the control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for Controls for View (Format)](./customitem-element-for-customentry-for-controls-for-view-format.md)|Defines what data is displayed by the control and how it is displayed.|

## Remarks

## See Also

[CustomItem Element for CustomEntry for Controls for View (Format)](./customitem-element-for-customentry-for-controls-for-view-format.md)

[CustomControlName Element for ExpressionBinding for Controls for View (Format)](./customcontrolname-element-for-expressionbinding-for-controls-for-view-format.md)

[EnumerateCollection Element for ExpressionBinding for Controls for View (Format)](./enumeratecollection-element-for-expressionbinding-for-controls-for-view-format.md)

[ItemSelectionCondition Element of ExpressionBinding for Controls for View (Format)](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)

[PropertyName Element for ExpressionBinding for Controls for View (Format)](./propertyname-element-for-expressionbinding-for-controls-for-view-format.md)

[ScriptBlock Element for ExpressionBinding for Controls for View (Format)](./scriptblock-element-for-expressionbinding-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
