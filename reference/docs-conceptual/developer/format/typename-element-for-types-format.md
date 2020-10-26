---
ms.date: 09/13/2016
ms.topic: reference
title: TypeName Element for Types (Format)
description: TypeName Element for Types (Format)
---
# TypeName Element for Types (Format)

Specifies the .NET type of an object that belongs to the selection set.

Configuration Element (Format)
SelectionSets Element (Format)
SelectionSet Element (Format)
Types Element (Format)
TypeName Element of Types (Format)

## Syntax

```xml
<TypeName>Nameof.NetType</Name>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `TypeName` element. At least one `TypeName` element must be included in the selection set.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Types Element (Format)](./types-element-for-selectionset-format.md)|Defines the .NET objects that are in the selection set.|

## Text Value

Specify the fully qualified name for the .NET type.

## Remarks

You can use selection sets when you have a set of related objects that you want to reference by using a single name, such as a set of objects that are related through inheritance. When defining your views, you can specify the set of objects by using the name of the selection set instead of listing all the objects within each view.

Common selection sets are specified by their name when defining the views of the formatting file. In these cases, the `SelectionSetName` child element of the `ViewSelectedBy` element for the view specifies the set. However, different entries of a view can also specify a selection set that applies to only that entry of the view. For more information about selection sets, see [Defining Sets of Objects](./defining-selection-sets.md).

## Example

The following example shows a `SelectionSet` element that defines four .NET types.

```
<SelectionSets>
  <SelectionSet>
    <Name>FileSystemTypes</Name>
    <Types>
     <TypeName>System.IO.DirectoryInfo</TypeName>
     <TypeName>System.IO.FileInfo</TypeName>
     <TypeName>Deserialized.System.IO.DirectoryInfo</TypeName>
     <TypeName>Deserialized.System.IO.FileInfo</TypeName>
    </Types>
  </SelectionSet>
</SelectionSets>
```

## See Also

[Defining Selection Sets](./defining-selection-sets.md)

[SelectionSet Element (Format)](./selectionset-element-format.md)

[SelectionSets Element (Format)](./selectionsets-element-format.md)

[Types Element (Format)](./types-element-for-selectionset-format.md)

[Writing a Windows PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
