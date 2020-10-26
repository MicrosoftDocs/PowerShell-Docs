---
ms.date: 09/13/2016
ms.topic: reference
title: SelectionSets Element (Format)
description: SelectionSets Element (Format)
---
# SelectionSets Element (Format)

Defines the common sets of .NET objects that can be used by all views of the formatting file. The views and controls of the formatting file can reference the complete set of objects by using only the name of the selection set.

Configuration Element
SelectionSets Element Format

## Syntax

```xml
<SelectionSets>
  <SelectionSet>...</SelectionSet>
</SelectionSets>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the `SelectionSets` element. Each child element defines a set of objects that can be referenced by the name of the set. The order of the child elements is not significant.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[SelectionSet Element (Format)](./selectionset-element-format.md)|Required element.<br /><br /> Defines a single set of .NET objects that can be referenced by the name of the set.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Configuration Element](./configuration-element-format.md)|Represents the top-level element of a formatting file.|

## Remarks

You can use selection sets when you have a set of related objects that you want to reference by using a single name, such as a set of objects that are related through inheritance. When defining your views, you can specify the set of objects by using the name of the selection set instead of listing all the objects within each view.

Common selection sets are specified by their name when defining the views of the formatting file or the definitions of the views. In these cases, the `SelectionSetName` child element of the `ViewSelectedBy` and `EntrySelectedBy` elements specifies the set to be used. For more information about selection sets, see [Defining Sets of Objects](./defining-selection-sets.md).

## See Also

[Configuration Element](./configuration-element-format.md)

[Defining Selection Sets](./defining-selection-sets.md)

[SelectionSet Element (Format)](./selectionset-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
