---
description: ExpressionBinding Element for CustomItem for Controls for Configuration
ms.date: 08/23/2021
ms.topic: reference
title: ExpressionBinding Element for CustomItem for Controls for Configuration
---
# ExpressionBinding Element for CustomItem for Controls for Configuration

Defines the data that is displayed by the control. This element is used when defining a common
control that can be used by all the views in the formatting file.

## Schema

- Configuration Element
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
|[CustomControlName Element for ExpressionBinding for Controls for Configuration](./customcontrolname-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the name of a common control or a view control.|
|[EnumerateCollection Element for ExpressionBinding for Controls for Configuration](./enumeratecollection-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specified that the elements of collections are displayed by the control.|
|[ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Defines the condition that must exist for this common control to be used.|
|[PropertyName Element for ExpressionBinding for Controls for Configuration](./propertyname-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the .NET property whose value is displayed by the common control.|
|[ScriptBlock Element for ExpressionBinding for Controls for Configuration](./scriptblock-element-for-expressionbinding-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the script whose value is displayed by the common control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)|Defines what data is displayed by the custom control view and how it is displayed.|

## Remarks

## See Also

[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
