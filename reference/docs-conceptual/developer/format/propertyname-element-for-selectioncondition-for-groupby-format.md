---
description: PropertyName Element for SelectionCondition for GroupBy
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for SelectionCondition for GroupBy
---
# PropertyName Element for SelectionCondition for GroupBy

Specifies the .NET property that triggers the condition. When this property is present or when it
evaluates to `true`, the condition is met, and the definition is used. This element is used when
defining how a new group of objects is displayed.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- GroupBy Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
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
|[SelectionCondition Element for EntrySelectedBy for GroupBy](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the .NET property name.

## Remarks

The selection condition must specify a least one property name or a script, but cannot specify both.
For more information about how selection conditions can be used, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[SelectionCondition Element for EntrySelectedBy for GroupBy](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
