---
ms.date: 09/13/2016
ms.topic: reference
title: ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListControl (Format)
description: ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListControl (Format)
---
# ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListControl (Format)

Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the list entry is used.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element (Format)
ListEntry Element (Format)
EntrySelectedBy Element for ListEntry (Format)
SelectionCondition Element for EntrySelectedBy for ListEntry (Format)
ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)

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
|[SelectionCondition Element for EntrySelectedBy for ListEntry (Format)](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)|Defines the condition that must exist for this list entry to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

The selection condition must specify a least one script or property name to evaluate, but cannot specify both. (For more information about how selection conditions can be used, see [Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md).)

For more information about the other components of a list view, see [List View](./creating-a-list-view.md).

## See Also

[ListEntry Element (Format)](./listentry-element-for-listcontrol-format.md)

[PropertyName Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./propertyname-element-for-selectioncondition-for-entryselectedby-for-listcontrol-format.md)

[SelectionCondition Element for EntrySelectedBy for ListEntry (Format)](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)

[List View](./creating-a-list-view.md)

[Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md)

[Writing a Windows PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)
