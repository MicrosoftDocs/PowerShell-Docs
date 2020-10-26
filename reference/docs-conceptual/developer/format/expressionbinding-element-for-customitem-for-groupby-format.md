---
ms.date: 09/13/2016
ms.topic: reference
title: ExpressionBinding Element for CustomItem for GroupBy (Format)
description: ExpressionBinding Element for CustomItem for GroupBy (Format)
---
# ExpressionBinding Element for CustomItem for GroupBy (Format)

Defines the data that is displayed by the control. This element is used when defining how a new group of objects is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
GroupBy Element for View (Format)
CustomControl Element for GroupBy (Format)
CustomEntries Element for CustomControl for GroupBy (Format)
CustomEntry Element for CustomControl for GroupBy (Format)
CustomItem Element for CustomEntry for GroupBy (Format)
ExpressionBinding Element for CustomItem for GroupBy (Format)

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
|[CustomControlName Element for ExpressionBinding for GroupBy (Format)](./customcontrolname-element-for-expressionbinding-for-groupby-format.md)|Optional element.<br /><br /> Specifies the name of a common control or a view control.|
|[EnumerateCollection Element for ExpressionBinding for GroupBy (Format)](./enumeratecollection-element-for-expressionbinding-for-groupby-format.md)EnumerateCollection Element for ExpressionBinding for GroupBy (Format)|Optional element.<br /><br /> Specified that the elements of collections are displayed.|
|[ItemSelectionCondition Element for ExpressionBinding for GroupBy (Format)](./itemselectioncondition-element-for-expressionbinding-for-groupby-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this control to be used.|
|[PropertyName Element for ExpressionBinding for GroupBy (Format)](./propertyname-element-for-expressionbinding-for-groupby-format.md)|Optional element.<br /><br /> Specifies the .NET property whose value is displayed by the control.|
|[ScriptBlock Element for ExpressionBinding for GroupBy (Format)](./scriptblock-element-for-expressionbinding-for-groupby-format.md)|Optional element.<br /><br /> Specifies the script whose value is displayed by the control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for GroupBy (Format)](./customitem-element-for-customentry-for-groupby-format.md)|Defines what data is displayed by the custom control view and how it is displayed.|

## See Also

[CustomControlName Element for ExpressionBinding for GroupBy (Format)](./customcontrolname-element-for-expressionbinding-for-groupby-format.md)

[EnumerateCollection Element for ExpressionBinding for GroupBy (Format)](./enumeratecollection-element-for-expressionbinding-for-groupby-format.md)

[ItemSelectionCondition Element for ExpressionBinding for GroupBy (Format)](./itemselectioncondition-element-for-expressionbinding-for-groupby-format.md)

[PropertyName Element for ExpressionBinding for GroupBy (Format)](./propertyname-element-for-expressionbinding-for-groupby-format.md)

[ScriptBlock Element for ExpressionBinding for GroupBy (Format)](./scriptblock-element-for-expressionbinding-for-groupby-format.md)

[CustomItem Element for CustomEntry for GroupBy (Format)](./customitem-element-for-customentry-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
