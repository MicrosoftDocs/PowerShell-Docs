---
description: ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion
---
# ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion

Specifies the script that triggers the condition.

## Schema

- Configuration Element
- DefaultSettings Element
- EnumerableExpansions Element
- EnumerableExpansion Element
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
|[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)|Defines the condition that must exist to expand the collection objects of this definition.|

## Text Value

Specify the script that is evaluated.

## Remarks

The selection condition must specify at least one script or property name to evaluate, but cannot
specify both. For more information about how to use selection conditions, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

## See Also

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[PropertyName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion](./propertyname-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)

[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
