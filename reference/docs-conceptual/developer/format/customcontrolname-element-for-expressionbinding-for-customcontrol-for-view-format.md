---
ms.date: 09/13/2016
ms.topic: reference
title: CustomControlName Element for ExpressionBinding for CustomControl for View (Format)
description: CustomControlName Element for ExpressionBinding for CustomControl for View (Format)
---
# CustomControlName Element for ExpressionBinding for CustomControl for View (Format)

Specifies the name of a common control or a view control. This element is used when defining a custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element for View (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for View (Format)
CustomItem Element for CustomEntry for View (Format)
ExpressionBinding Element for CustomItem (Format)
CustomControlName Element for Expression Binding for CustomItem (Format)

## Syntax

```xml
<CustomControlName>NameofCustomControl</CustomControlName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `CustomControlName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ExpressionBinding Element for CustomItem (Format)](./expressionbinding-element-for-customitem-for-controls-for-configuration-format.md)|Defines the data that is displayed by the control.|

## Text Value

Specify the name of the control.

## Remarks

You can create common controls that can be used by all the views of a formatting file and you can create view controls that can be used by a specific view. The names of these controls are specified by the following elements.

- [Name Element for Control for Controls for Configuration (Format)](./name-element-for-control-for-controls-for-configuration-format.md)

- [Name Element for Control for Controls for View (Format)](./name-element-for-control-for-controls-for-view-format.md)

## See Also

[Name Element for Control for Controls for Configuration (Format)](./name-element-for-control-for-controls-for-configuration-format.md)

[Name Element for Control for Controls for View (Format)](./name-element-for-control-for-controls-for-view-format.md)

[ExpressionBinding Element for CustomItem (Format)](./expressionbinding-element-for-customitem-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
