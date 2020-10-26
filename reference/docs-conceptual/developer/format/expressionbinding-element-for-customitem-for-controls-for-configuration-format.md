---
ms.date: 09/13/2016
ms.topic: reference
title: ExpressionBinding Element for CustomItem for Controls for Configuration (Format)
description: ExpressionBinding Element for CustomItem for Controls for Configuration (Format)
---
# ExpressionBinding Element for CustomItem for Controls for Configuration (Format)

Defines the data that is displayed by the control. This element is used when defining a common control that can be used by all the views in the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)
Control Element for Controls for Configuration (Format)
CustomControl Element for Control for Configuration (Format)
CustomEntries Element for CustomControl for Configuration (Format)
CustomEntry Element for CustomControl for Controls for Configuration (Format)
CustomItem Element for CustomEntry for Controls for Configuration
ExpressionBinding Element for CustomItem for Controls for Configuration (Format)

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
|[CustomControlName Element for ExpressionBinding for Controls for Configuration (Format)](./customcontrolname-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the name of a common control or a view control.|
|[EnumerateCollection Element for ExpressionBinding for Controls for Configuration (Format)](./enumeratecollection-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specified that the elements of collections are displayed by the control.|
|[ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this common control to be used.|
|[PropertyName Element for ExpressionBinding for Controls for Configuration (Format)](./propertyname-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the .NET property whose value is displayed by the common control.|
|[ScriptBlock Element for ExpressionBinding for Controls for Configuration (Format)](./scriptblock-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the script whose value is displayed by the common control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)|Defines what data is displayed by the custom control view and how it is displayed.|

## Remarks

## See Also

[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
