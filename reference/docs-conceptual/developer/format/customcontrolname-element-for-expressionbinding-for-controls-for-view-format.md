---
description: CustomControlName Element for ExpressionBinding for Controls for View
ms.date: 08/20/2021
ms.topic: reference
title: CustomControlName Element for ExpressionBinding for Controls for View
---
# CustomControlName Element for ExpressionBinding for Controls for View

Specifies the name of a common control or a view control. This element is used when defining
controls that can be used by a view.

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
- CustomControlName Element

## Syntax

```xml
<CustomControlName>NameofCustomControl</CustomControlName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`CustomControlName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ExpressionBinding Element for CustomItem for Controls for View](./expressionbinding-element-for-customitem-for-controls-for-view-format.md)|Defines the data that is displayed by the control.|

## Text Value

Specify the name of the control.

## Remarks

You can create common controls that can be used by all the views of a formatting file, and you can
create view controls that can be used by a specific view. The following elements specify the names
of these controls:

- [Name Element for Control for Controls for Configuration](./name-element-for-control-for-controls-for-configuration-format.md)

- [Name Element for Control for Controls for View](./name-element-for-control-for-controls-for-view-format.md)

## See Also

[Name Element for Control for Controls for Configuration](./name-element-for-control-for-controls-for-configuration-format.md)

[Name Element for Control for Controls for View](./name-element-for-control-for-controls-for-view-format.md)

[ExpressionBinding Element for CustomItem for Controls for View](./expressionbinding-element-for-customitem-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
