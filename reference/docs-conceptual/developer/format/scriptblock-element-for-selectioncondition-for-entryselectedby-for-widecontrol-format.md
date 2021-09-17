---
description: ScriptBlock Element for SelectionCondition for EntrySelectedBy for WideControl
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for SelectionCondition for EntrySelectedBy for WideControl
---
# ScriptBlock Element for SelectionCondition for EntrySelectedBy for WideControl

Specifies the script that triggers the condition. When this script is evaluated to `true`, the
condition is met, and the wide entry definition is used.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- WideControl Element
- WideEntries Element
- WideEntry Element
- EntrySelectedBy Element
- SelectionCondition
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
|[SelectionCondition Element for EntrySelectedBy for WideEntry](./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md)|Defines the condition that must exist for this definition to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

The selection condition must specify at least one script or property name to evaluate, but cannot
specify both. For more information about how to use selection conditions, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

For more information about other components of a wide view, see [Wide View](./creating-a-wide-view.md).

## See Also

[Creating a Wide View](./creating-a-wide-view.md)

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[PropertyName Element for SelectionCondition for EntrySelectedBy for WideEntry](./propertyname-element-for-selectioncondition-for-entryselectedby-for-wideentry-format.md)

[SelectionCondition Element for EntrySelectedBy for WideEntry](./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
