---
ms.date: 09/13/2016
ms.topic: reference
title: ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)
description: ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)
---
# ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)

Specifies the script that triggers the condition.

Configuration Element (Format)
DefaultSettings Element (Format)
EnumerableExpansions Element (Format)
EnumerableExpansion Element (Format)
EntrySelectedBy Element for EnumerableExpansion (Format)
SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)
ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)

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
|[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)|Defines the condition that must exist to expand the collection objects of this definition.|

## Text Value

Specify the script that is evaluated.

## Remarks

The selection condition must specify at least one script or property name to evaluate, but cannot specify both. For more information about how to use selection conditions, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

## See Also

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[PropertyName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)](./propertyname-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)

[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
