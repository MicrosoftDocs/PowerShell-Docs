---
description: ScriptBlock Element for SelectionCondition for CustomControl for View
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for SelectionCondition for CustomControl for View
---
# ScriptBlock Element for SelectionCondition for CustomControl for View

Specifies the script that triggers the condition. When this script is evaluated to `true`, the
condition is met, and the definition is used. This element is used when defining a custom control
view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
- CustomItem Element
- SelectionCondition Element
- ScriptBlock Element

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for CustomControl for View](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

The selection condition must specify a least one script or property name to evaluate, but cannot
specify both. For more information about how selection conditions can be used, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[SelectionCondition Element for EntrySelectedBy for CustomControl for View](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
