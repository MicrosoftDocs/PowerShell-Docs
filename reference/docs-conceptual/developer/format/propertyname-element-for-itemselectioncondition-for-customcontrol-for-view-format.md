---
description: PropertyName Element for ItemSelectionCondition for CustomControl for View
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for ItemSelectionCondition for CustomControl for View
---
# PropertyName Element for ItemSelectionCondition for CustomControl for View

Specifies the .NET property that triggers the condition. When this property is present or when it
evaluates to `true`, the condition is met, and the control is used. This element is used when
defining a custom control view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- CustomControl Element
- CustomEntries Element for CustomControl for View
- CustomEntry Element for CustomEntries for View
- CustomItem Element for CustomEntry for View
- ExpressionBinding Element for CustomItem for CustomControl for View
- ItemSelectionCondition Element for Expression Binding for CustomControl for View
- PropertyName Element for ItemSelectionCondition for CustomControl for View (Format

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ItemSelectionCondition Element for Expression Binding for CustomControl for View](./itemselectioncondition-element-for-expressionbinding-for-customcontrol-format.md)|Defines the condition that must exist for this control to be used.|

## Text Value

Specify the name of the .NET property that triggers the condition.

## Remarks

If this element is used, you cannot specify the [ScriptBlock](./scriptblock-element-for-itemselectioncondition-for-customcontrol-for-view-format.md)
element when defining the selection condition.

## See Also

[ScriptBlock Element for ItemSelectionCondition for CustomControl for View](./scriptblock-element-for-itemselectioncondition-for-customcontrol-for-view-format.md)

[ItemSelectionCondition Element for Expression Binding for CustomControl for View](./itemselectioncondition-element-for-expressionbinding-for-customcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
