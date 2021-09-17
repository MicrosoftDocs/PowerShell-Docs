---
description: Control Element for Controls for View
ms.date: 08/20/2021
ms.topic: reference
title: Control Element for Controls for View
---
# Control Element for Controls for View

Defines a control that can be used by the view and the name that is used to reference the control.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- Controls Element
- Control Element

## Syntax

```xml
<Control>
  <Name>NameOfControl</Name>
  <CustomControl>...</CustomControl>
</Control>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`Control` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[Name Element for Control for View](./name-element-for-control-for-controls-for-view-format.md)|Required element.<br /><br /> Specifies the name of the control.|
|[CustomControl Element for Control for Controls for View](./customcontrol-element-for-control-for-controls-for-view-format.md)|Required element.<br /><br /> Defines the control used by this view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Controls Element](./controls-element-for-view-format.md)|Defines the view controls that can be used by a specific view.|

## Remarks

This control can be specified by the following elements:

- [CustomControlName Element for ExpressionBinding for Controls for View](./customcontrolname-element-for-expressionbinding-for-controls-for-view-format.md)

- [CustomControlName Element for ExpressionBinding for CustomControl for View](./customcontrolname-element-for-expressionbinding-for-customcontrol-for-view-format.md)

- [CustomControlName Element for ExpressionBinding for GroupBy](./customcontrolname-element-for-expressionbinding-for-groupby-format.md)

- [CustomControlName Element for GroupBy](./customcontrolname-element-for-groupby-format.md)

## See Also

[CustomControl Element for Control for Controls for View](./customcontrol-element-for-control-for-controls-for-view-format.md)

[CustomControlName Element for ExpressionBinding for Controls for View](./customcontrolname-element-for-expressionbinding-for-controls-for-view-format.md)

[CustomControlName Element for ExpressionBinding for CustomControl for View](./customcontrolname-element-for-expressionbinding-for-customcontrol-for-view-format.md)

[CustomControlName Element for ExpressionBinding for GroupBy](./customcontrolname-element-for-expressionbinding-for-groupby-format.md)

[CustomControlName Element for ExpressionBinding for GroupBy](./customcontrolname-element-for-expressionbinding-for-groupby-format.md)

[Controls Element](./controls-element-for-view-format.md)

[Name Element for Control for Controls for View](./name-element-for-control-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
