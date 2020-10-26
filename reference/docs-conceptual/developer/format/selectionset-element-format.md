---
ms.date: 09/13/2016
ms.topic: reference
title: SelectionSet Element (Format)
description: SelectionSet Element (Format)
---
# SelectionSet Element (Format)

Defines a set of .NET objects that can be referenced by the name of the set.

Configuration Element (Format)
SelectionSets Element (Format)
SelectionSet Element (Format)

## Syntax

```xml
<SelectionSet>
  <Name>SelectionSetName</Name>
  <Types>...</Types>
</SelectionSet>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `SelectionSet` element. Each selection set must have a name, and it must specify the .NET objects of the set.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[Name Element for SelectionSet (Format)](./name-element-for-selectionset-format.md)|Required element.<br /><br /> Specifies the name used to reference the selection set.|
|[Types Element (Format)](./types-element-for-selectionset-format.md)|Required element.<br /><br /> Defines the .NET objects that are in the selection set.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionSets Element Format](./selectionsets-element-format.md)|Defines the common sets of .NET objects that can be used by all views of the formatting file.|

## Remarks

You can use selection sets when you have a set of related objects that you want to reference by using a single name, such as a set of objects that are related through inheritance. When defining your views, you can specify the set of objects by using the name of the selection set instead of listing all the objects within each view.

Common selection sets are specified by their name when defining the views of the formatting file or the definitions of the views. In these cases, the `SelectionSetName` child element of the `ViewSelectedBy` and `EntrySelectedBy` elements specifies the set to be used. For more information about selection sets, see [Defining Sets of Objects](./defining-selection-sets.md).

## Example

The following example shows a `SelectionSet` element that defines four .NET types.

```xml
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

[Name Element of SelectionSet (Format)](./name-element-for-selectionset-format.md)

[SelectionSets Element (Format)](./selectionsets-element-format.md)

[Types Element (Format)](./types-element-for-selectionset-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
