---
description: SelectionSetName Element for SelectionCondition for GroupBy
ms.date: 08/25/2021
ms.topic: reference
title: SelectionSetName Element for SelectionCondition for GroupBy
---
# SelectionSetName Element for SelectionCondition for GroupBy

Specifies the set of .NET types that trigger the condition. When any of the types in this set are
present, the condition is met, and the object is displayed by using this control. This element is
used when defining how a new group of objects is displayed.

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
- SelectionSetName Element

## Syntax

```xml
<SelectionSetName>NameofSelectionSet</SelectionSetName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`SelectionSetName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for GroupBy](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the name of the selection set.

## Remarks

Selection sets are common groups of .NET objects that can be used by any view that the formatting
file defines. For more information about creating and referencing selection sets, see [Defining Selection Sets](./defining-selection-sets.md).

When this element is specified, you cannot specify the [TypeName](./typename-element-for-selectioncondition-for-groupby-format.md)
element. For more information about defining selection conditions, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[TypeName Element for SelectionCondition for GroupBy](./typename-element-for-selectioncondition-for-groupby-format.md)

[SelectionCondition Element for EntrySelectedBy for GroupBy](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[Defining Selection Sets](./defining-selection-sets.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
