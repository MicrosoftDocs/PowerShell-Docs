---
description: PropertyName Element for ItemSelectionCondition for ListControl
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for ItemSelectionCondition for ListControl
---
# PropertyName Element for ItemSelectionCondition for ListControl

Specifies the .NET property that triggers the condition. When this property is present or when it
evaluates to `true`, the condition is met, and the view is used. This element is used when defining
a list view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element
- ListEntry Element
- ListItems Element
- ListItem Element
- ItemSelectionCondition Element
- PropertyName Element

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent elements of the
`PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ItemSelectionCondition Element for ListItem for ListControl](./itemselectioncondition-element-for-listitem-for-listcontrol-format.md)||

## Text Value

Specify the name of the property whose value is displayed.

## Remarks

If this element is used, you cannot specify the [ScriptBlock](./scriptblock-element-for-itemselectioncondition-for-listcontrol-format.md)
element when defining the selection condition.

## See Also

[ScriptBlock Element for ItemSelectionCondition for ListIControl](./scriptblock-element-for-itemselectioncondition-for-listcontrol-format.md)

[ItemSelectionCondition Element for ListItem for ListControl](./itemselectioncondition-element-for-listitem-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
