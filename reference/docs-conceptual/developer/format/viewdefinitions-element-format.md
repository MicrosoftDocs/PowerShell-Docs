---
ms.date: 09/13/2016
ms.topic: reference
title: ViewDefinitions Element (Format)
description: ViewDefinitions Element (Format)
---
# ViewDefinitions Element (Format)

Defines the views used to display .NET objects. These views can display the properties and script values of an object  in a table format, list format, wide format, and custom control format.

Configuration Element (Format)
ViewDefinitions (Format XML) Element

## Syntax

```xml

<ViewDefinitions>
  <View>...</View>
</ViewDefinitions>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the `ViewDefinitions` element. There is no limit to the number of views that can be defined in a formatting file, and they can be added in any order.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[View Element (Format)](./view-element-format.md)|Defines a view that is used to display one or more .NET objects.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Configuration Element (Format)](./configuration-element-format.md)|Represents the top-level element of a formatting file.|

## Remarks

For more information about the components of the different types of views, see the following topics:

- [Creating a Table View](./creating-a-table-view.md)

- [Creating a List View](./creating-a-list-view.md)

- [Creating a Wide View](./creating-a-wide-view.md)

- [Custom Controls](./creating-custom-controls.md)

## Example

This example shows a `ViewDefinitions` element that contains the parent elements for a table view and a list view.

```xml
<Configuration>
  <ViewDefinitions>
    <View>
      <TableControl>...</TableControl>
    </View>
    <View>
      <ListControl>...</ListControl>
    </View>
  </ViewDefinitions>
</Configuration>
```

## See Also

[Configuration Element (Format)](./configuration-element-format.md)

[View Element (Format)](./view-element-format.md)

[Creating a Table View](./creating-a-table-view.md)

[Creating a List View](./creating-a-list-view.md)

[Creating a Wide View](./creating-a-wide-view.md)

[Custom Controls](./creating-custom-controls.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
