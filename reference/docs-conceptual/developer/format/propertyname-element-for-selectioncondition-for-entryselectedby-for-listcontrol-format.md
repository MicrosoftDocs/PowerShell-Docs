---
description: PropertyName Element for SelectionCondition for EntrySelectedBy for ListControl
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for SelectionCondition for EntrySelectedBy for ListControl
---
# PropertyName Element for SelectionCondition for EntrySelectedBy for ListControl

Specifies the .NET property that triggers the condition. When this property is present or when it
evaluates to `true`, the condition is met, and the list entry is used.

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element
- ListEntry Element
- EntrySelectedBy Element
- SelectionCondition Element
- PropertyName Element

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
|[SelectionCondition Element for EntrySelectedBy for ListEntry](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)|Defines the condition that must exist for this list entry to be used.|

## Text Value

Specify the .NET property name.

## Remarks

The selection condition must specify at least one property name or a script block, but cannot
specify both. For more information about how to use selection conditions, see [Defining Conditions for when a View Entry or Item is Used](./defining-conditions-for-displaying-data.md).

For more information about other components of a list view, see [Creating List View](./creating-a-list-view.md).

## See Also

[Creating a List View](./creating-a-list-view.md)

[Defining Conditions for When Data is Displayed](./defining-conditions-for-displaying-data.md)

[ListEntry Element](./listentry-element-for-listcontrol-format.md)

[ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListEntry](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
