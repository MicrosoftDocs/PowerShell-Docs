---
description: ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListControl
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListControl
---
# ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListControl

Specifies the script that triggers the condition. When this script is evaluated to `true`, the
condition is met, and the list entry is used.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element
- ListEntry Element
- EntrySelectedBy Element
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
|[SelectionCondition Element for EntrySelectedBy for ListEntry](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)|Defines the condition that must exist for this list entry to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

The selection condition must specify a least one script or property name to evaluate, but cannot
specify both. (For more information about how selection conditions can be used, see [Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md).)

For more information about the other components of a list view, see [List View](./creating-a-list-view.md).

## See Also

[ListEntry Element](./listentry-element-for-listcontrol-format.md)

[PropertyName Element for SelectionCondition for EntrySelectedBy for ListEntry](./propertyname-element-for-selectioncondition-for-entryselectedby-for-listcontrol-format.md)

[SelectionCondition Element for EntrySelectedBy for ListEntry](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)

[List View](./creating-a-list-view.md)

[Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md)

[Writing a Windows PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)
