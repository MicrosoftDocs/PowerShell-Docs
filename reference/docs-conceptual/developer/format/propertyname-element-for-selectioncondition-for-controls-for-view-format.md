---
description: PropertyName Element for SelectionCondition for Controls for View
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for SelectionCondition for Controls for View
---
# PropertyName Element for SelectionCondition for Controls for View

Specifies the .NET property that triggers the condition. When this property is present or when it
evaluates to `true`, the condition is met, and the entry is used. This element is used when defining
controls that can be used by a view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- Controls Element
- Control Element for Controls for View
- CustomControl Element for Control for Controls for View
- CustomEntries Element for CustomControl for Controls for View
- CustomEntry Element for CustomEntries for Controls for View
- EntrySelectedBy Element for CustomEntry for Controls for View
- SelectionCondition Element for EntrySelectedBy for Controls for View
- PropertyName Element for SelectionCondition for Controls for View

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
|[SelectionCondition Element for EntrySelectedBy for Controls for View](./selectioncondition-element-for-entryselectedby-for-controls-for-view-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the .NET property name.

## Remarks

The selection condition must specify a least one property name or a script, but cannot specify both.
For more information about how selection conditions can be used, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[SelectionCondition Element for EntrySelectedBy for Controls for View](./selectioncondition-element-for-entryselectedby-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
