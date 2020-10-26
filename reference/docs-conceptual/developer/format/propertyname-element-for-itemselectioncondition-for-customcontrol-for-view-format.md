---
ms.date: 09/13/2016
ms.topic: reference
title: PropertyName Element for ItemSelectionCondition for CustomControl for View (Format)
description: PropertyName Element for ItemSelectionCondition for CustomControl for View (Format)
---
# PropertyName Element for ItemSelectionCondition for CustomControl for View (Format)

Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the control is used. This element is used when defining a custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for View (Format)
CustomItem Element for CustomEntry for View (Format)
ExpressionBinding Element for CustomItem for CustomControl for View (Format)
ItemSelectionCondition Element for Expression Binding for CustomControl for View (Format)
PropertyName Element for ItemSelectionCondition for CustomControl for View (Format

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ItemSelectionCondition Element for Expression Binding for CustomControl for View (Format)](./itemselectioncondition-element-for-expressionbinding-for-customcontrol-format.md)|Defines the condition that must exist for this control to be used.|

## Text Value

Specify the name of the .NET property that triggers the condition.

## Remarks

If this element is used, you cannot specify the [ScriptBlock](./scriptblock-element-for-itemselectioncondition-for-customcontrol-for-view-format.md) element when defining the selection condition.

## See Also

[ScriptBlock Element for ItemSelectionCondition for CustomControl for View (Format)](./scriptblock-element-for-itemselectioncondition-for-customcontrol-for-view-format.md)

[ItemSelectionCondition Element for Expression Binding for CustomControl for View (Format)](./itemselectioncondition-element-for-expressionbinding-for-customcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
