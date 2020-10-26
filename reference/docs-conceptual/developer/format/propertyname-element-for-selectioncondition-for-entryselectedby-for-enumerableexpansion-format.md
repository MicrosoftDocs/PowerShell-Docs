---
ms.date: 09/13/2016
ms.topic: reference
title: PropertyName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)
description: PropertyName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)
---
# PropertyName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)

Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the definition is used.

Configuration Element (Format)
DefaultSettings Element (Format)
EnumerableExpansions Element (Format)
EnumerableExpansion Element (Format)
EntrySelectedBy Element for EnumerableExpansion (Format)
SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)
PropertyName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)|Defines the condition that must exist to expand the collection objects of this definition.|

## Text Value

Specify the .NET property name.

## Remarks

The selection condition must specify at least one property name or a script to evaluate, but cannot specify both. For more information about how to use selection conditions, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

## See Also

[Defining Conditions for When Data is Displayed](./defining-conditions-for-displaying-data.md)

[ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)

[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
