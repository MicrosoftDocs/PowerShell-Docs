---
description: EntrySelectedBy Element for EnumerableExpansion
ms.date: 08/23/2021
ms.topic: reference
title: EntrySelectedBy Element for EnumerableExpansion
---
# EntrySelectedBy Element for EnumerableExpansion

Defines the .NET types that use this definition or the condition that must exist for this definition
to be used.

## Schema

- Configuration Element
- DefaultSettings Element
- EnumerableExpansions Element
- EnumerableExpansion Element
- EntrySelectedBy Element for EnumerableExpansion

## Syntax

```xml
<EntrySelectedBy>
  <TypeName>Nameof.NetType</TypeName>
  <SelectionSetName>NameofSelectionSet</SelectionSetName>
  <SelectionCondition>...</SelectionCondition>
</EntrySelectedBy>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`EntrySelectedBy` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)|Optional element.<br /><br /> Defines the condition that must exist to expand the collection objects of this definition.|
|[SelectionSetName Element for EntrySelectedBy for EnumerableExpansion](./selectionsetname-element-for-entryselectedby-for-enumerableexpansion-format.md)|Optional element.<br /><br /> Specifies a set of .NET types that use this definition of how collection objects are expanded.|
|[TypeName Element for EntrySelectedBy for EnumerableExpansion](./typename-element-for-entryselectedby-for-enumerableexpansion-format.md)|Optional element.<br /><br /> Specifies a .NET type that uses this definition of how collection objects are expanded.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EnumerableExpansion Element](./enumerableexpansion-element-format.md)|Defines how specific .NET collection objects are expanded when they are displayed in a view.|

## Remarks

You must specify at least one type, selection set, or selection condition for a definition entry.
There is no maximum limit to the number of child elements that you can use.

Selection conditions are used to define a condition that must exist for the definition to be used,
such as when an object has a specific property or that a specific property value or script evaluates
to `true`. For more information about selection conditions, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md)

[EnumerableExpansion Element](./enumerableexpansion-element-format.md)

[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)

[SelectionSetName Element for EntrySelectedBy for EnumerableExpansion](./selectionsetname-element-for-entryselectedby-for-enumerableexpansion-format.md)

[TypeName Element for EntrySelectedBy for EnumerableExpansion](./typename-element-for-entryselectedby-for-enumerableexpansion-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
