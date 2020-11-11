---
ms.date: 09/13/2016
ms.topic: reference
title: Name Element for Control for Controls for View (Format)
description: Name Element for Control for Controls for View (Format)
---
# Name Element for Control for Controls for View (Format)

Specifies the name of the control.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
Controls Element (Format)
Control Element for Controls for View (Format)
Name Element for Control for View (Format)

## Syntax

```xml
<Name>ControlName</Name>
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
|[Control Element for Controls for View (Format)](./control-element-for-controls-for-view-format.md)|Defines a control that can be used by the view and the name that is used to reference the control.|

## Text Value

Specify the name that is used to reference the control.

## Remarks

The name specified here can be used in the following elements to reference this control.

- When creating a table, list, wide or custom control view, the control can be specified by the following element: [GroupBy Element for View (Format)](./groupby-element-for-view-format.md)

- When creating another control that can be used by a view, this control can be specified by the following element: [ExpressionBinding Element for CustomItem for Controls for View (Format)](./expressionbinding-element-for-customitem-for-controls-for-view-format.md)

## See Also

[GroupBy Element for View (Format)](./groupby-element-for-view-format.md)

[ExpressionBinding Element for CustomItem for Controls for View (Format)](./expressionbinding-element-for-customitem-for-controls-for-view-format.md)

[Control Element for Controls for View (Format)](./control-element-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
