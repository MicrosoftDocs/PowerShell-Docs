---
ms.date: 09/13/2016
ms.topic: reference
title: Name Element for Control for Controls for Configuration (Format)
description: Name Element for Control for Controls for Configuration (Format)
---
# Name Element for Control for Controls for Configuration (Format)

Specifies the name of the control. This element is used when defining a common control that can be used by all the views in the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)
Control Element for Controls for Configuration (Format)
Name Element for Control for Controls for Configuration (Format)

## Syntax

```xml
<Name>NameOfControl</Name>

```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `Name` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Control Element for Controls for Configuration (Format)](./control-element-for-controls-for-configuration-format.md)|Defines a common control that can be used by all the views of the formatting file and the name that is used to reference the control.|

## Text Value

Specify the name that is used to reference this control.

## Remarks

The name specified here can be used in the following elements to reference this control.

- When creating a table, list, wide or custom control view, the control can be specified by the following element: [GroupBy Element for View (Format)](./groupby-element-for-view-format.md)

- When creating another common control, this control can be specified by the following element: [ExpressionBinding Element for CustomItem for Controls for Configuration (Format)](./expressionbinding-element-for-customitem-for-controls-for-configuration-format.md)

- When creating a control that can be used by a view, this control can be specified by the following element: [ExpressionBinding Element for CustomItem for Controls for View (Format)](./expressionbinding-element-for-customitem-for-controls-for-view-format.md)

## See Also

[Control Element for Controls for Configuration (Format)](./control-element-for-controls-for-configuration-format.md)

[ExpressionBinding Element for CustomItem for Controls for Configuration (Format)](./expressionbinding-element-for-customitem-for-controls-for-configuration-format.md)

[ExpressionBinding Element for CustomItem for Controls for View (Format)](./expressionbinding-element-for-customitem-for-controls-for-view-format.md)

[GroupBy Element for View (Format)](./groupby-element-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
