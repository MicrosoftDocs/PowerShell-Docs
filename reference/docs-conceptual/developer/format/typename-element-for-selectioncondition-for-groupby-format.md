---
description: TypeName Element for SelectionCondition for GroupBy
ms.date: 08/25/2021
ms.topic: reference
title: TypeName Element for SelectionCondition for GroupBy
---
# TypeName Element for SelectionCondition for GroupBy

Specifies a .NET type that triggers the condition. This element is used when defining how a new
group of objects is displayed.

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
- TypeName Element

## Syntax

```xml
<TypeName>Nameof.NetType</TypeName>

```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `TypeName`
Element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for GroupBy](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

When this element is specified, you cannot specify the `SelectionSetName` element. For more
information about defining selection conditions, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[SelectionCondition Element for EntrySelectedBy for GroupBy](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
