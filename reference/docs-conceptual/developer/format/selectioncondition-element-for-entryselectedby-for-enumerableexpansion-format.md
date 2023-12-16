---
description: SelectionCondition Element for EntrySelectedBy for EnumerableExpansion
ms.date: 08/25/2021
ms.topic: reference
title: SelectionCondition Element for EntrySelectedBy for EnumerableExpansion
---
# SelectionCondition Element for EntrySelectedBy for EnumerableExpansion

Defines the condition that must exist to expand the collection objects of this definition.

## Schema

- Configuration Element
- DefaultSettings Element
- EnumerableExpansions Element
- EnumerableExpansion Element
- EntrySelectedBy Element
- SelectionCondition Element

## Syntax

```xml
<SelectionCondition>
  <TypeName>Nameof.NetType</TypeName>
  <SelectionSetName>NameofSelectionSet</SelectionSetName>
  <PropertyName>.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate</ScriptBlock>
</SelectionCondition>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`SelectionCondition` element. You must specify a single `PropertyName` or `ScriptBlock` element. The
`SelectionSetName` and `TypeName` elements are optional. You can specify one of either element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[PropertyName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion](./propertyname-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)|Optional element.<br /><br /> Specifies the .NET property that triggers the condition.|
|[ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|
|[SelectionSetName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)|Optional element.<br /><br /> Specifies the set of .NET types that triggers the condition.|
|[TypeName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion](./typename-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)|Optional element.<br /><br /> Specifies a .NET type that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for EnumerableExpansion](./entryselectedby-element-for-enumerableexpansion-format.md)|Defines which .NET collection objects are expanded by this definition.|

## Remarks

Each definition must have at least one type name, selection set, or selection condition defined.

When you are defining a selection condition, the following requirements apply:

- The selection condition must specify a least one property name or a script block, but cannot
  specify both.
- The selection condition can specify any number of .NET types or selection sets, but cannot specify
  both.

For more information about how to use selection conditions, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

For more information about other components of a wide view, see [Wide View](./creating-a-wide-view.md).

## See Also

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
