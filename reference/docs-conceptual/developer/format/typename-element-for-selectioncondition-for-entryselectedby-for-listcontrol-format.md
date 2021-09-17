---
description: TypeName Element for SelectionCondition for EntrySelectedBy for ListControl
ms.date: 08/25/2021
ms.topic: reference
title: TypeName Element for SelectionCondition for EntrySelectedBy for ListControl
---
# TypeName Element for SelectionCondition for EntrySelectedBy for ListControl

Specifies a .NET type that triggers the condition. When this type is present, the list entry is used.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element
- ListEntry Element
- EntrySelectedBy Element
- SelectionCondition Element
- TypeName Element

## Syntax

```xml
<TypeName>Nameof.NetType</TypeName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `TypeName`
element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for ListControl](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)|Defines the condition that must exist for this list entry to be used.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

The selection condition can specify any number of .NET types or selection sets, but cannot specify
both. For more information about how to use selection conditions, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

For more information about other the components of a list view, see [Creating a List View](./creating-a-list-view.md).

## See Also

[Creating a List View](./creating-a-list-view.md)

[Defining Conditions for When Data Is Displayed](./defining-conditions-for-displaying-data.md)

[SelectionCondition Element for EntrySelectedBy for ListControl](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
