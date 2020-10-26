---
ms.date: 09/13/2016
ms.topic: reference
title: ScriptBlock Element for ItemSelectionCondition for CustomControl for View (Format)
description: ScriptBlock Element for ItemSelectionCondition for CustomControl for View (Format)
---
# ScriptBlock Element for ItemSelectionCondition for CustomControl for View (Format)

Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the control is used. This element is used when defining a custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for View (Format)
CustomItem Element for CustomEntry for View (Format)
ExpressionBinding Element for CustomItem for CustomControl for View (Format)
ItemSelectionCondition Element for Expression Binding for CustomControl for View (Format)
ScriptBlock Element for ItemSelectionCondition for CustomControl for View (Format)

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ItemSelectionCondition Element for Expression Binding for CustomControl for View (Format)](./itemselectioncondition-element-for-expressionbinding-for-customcontrol-format.md)|Defines the condition that must exist for this control to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

If this element is used, you cannot specify the [PropertyName](./propertyname-element-for-itemselectioncondition-for-customcontrol-for-view-format.md) element when defining the selection condition.

## See Also

[PropertyName Element for ItemSelectionCondition for CustomControl for View (Format)](./propertyname-element-for-itemselectioncondition-for-customcontrol-for-view-format.md)

[ItemSelectionCondition Element for Expression Binding for CustomControl for View (Format)](./itemselectioncondition-element-for-expressionbinding-for-customcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
