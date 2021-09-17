---
description: ExpressionBinding Element for CustomItem for Controls for View
ms.date: 08/23/2021
ms.topic: reference
title: ExpressionBinding Element for CustomItem for Controls for View
---
# ExpressionBinding Element for CustomItem for Controls for View

Defines the data that is displayed by the control. This element is used when defining controls that
can be used by a view.

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

The following sections describe attributes, child elements, and the parent element of the
`ExpressionBinding` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|`CustomControl Element`|Optional element.<br /><br /> Defines a control that is used by this control.|
|[CustomControlName Element for ExpressionBinding for Controls for View](./customcontrolname-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies the name of a common control or a view control.|
|[EnumerateCollection Element for ExpressionBinding for Controls for View](./enumeratecollection-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies that the elements of collections are displayed.|
|[ItemSelectionCondition Element of ExpressionBinding for Controls for View](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this control to be used.|
|[PropertyName Element for ExpressionBinding for Controls for View](./propertyname-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies the .NET property whose value is displayed by the control.|
|[ScriptBlock Element for ExpressionBinding for Controls for View](./scriptblock-element-for-expressionbinding-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies the script whose value is displayed by the control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for Controls for View](./customitem-element-for-customentry-for-controls-for-view-format.md)|Defines what data is displayed by the control and how it is displayed.|

## Remarks

## See Also

[CustomItem Element for CustomEntry for Controls for View](./customitem-element-for-customentry-for-controls-for-view-format.md)

[CustomControlName Element for ExpressionBinding for Controls for View](./customcontrolname-element-for-expressionbinding-for-controls-for-view-format.md)

[EnumerateCollection Element for ExpressionBinding for Controls for View](./enumeratecollection-element-for-expressionbinding-for-controls-for-view-format.md)

[ItemSelectionCondition Element of ExpressionBinding for Controls for View](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)

[PropertyName Element for ExpressionBinding for Controls for View](./propertyname-element-for-expressionbinding-for-controls-for-view-format.md)

[ScriptBlock Element for ExpressionBinding for Controls for View](./scriptblock-element-for-expressionbinding-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
