---
description: View Element
ms.date: 08/25/2021
ms.topic: reference
title: View Element
---
# View Element

Defines a view that displays one or more .NET objects. There is no limit to the number of views that
can be defined in a formatting file.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element

## Syntax

```xml
<View>
  <Name>Friendly name of view.</Name>
  <OutOfBand />
  <ViewSelectedBy>...</ViewSelectedBy>
  <Controls>...</Controls>
  <GroupBy>...</GroupBy>
  <TableControl>...</TableControl>
  <ListControl>...</ListControl>
  <WideControl>...</WideControl>
  <CustomControl>...</CustomControl>
</View>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `View`
element. You must specify one and only one of the control child elements, and you must specify the
name of the view and the objects that use the view. Defining custom controls, how to group objects,
and specifying if the view is out-of-band are optional.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[Controls Element for View](./controls-element-for-view-format.md)|Optional element.<br /><br /> Defines a set of controls that can be referenced by their name from within the view.|
|[CustomControl Element](./customcontrol-element-for-view-format.md)|Optional element.<br /><br /> Defines a custom control format for the view.|
|[GroupBy Element for View](./groupby-element-for-view-format.md)|Optional element.<br /><br /> Defines how the members of the .NET objects are grouped.|
|[ListControl Element](./listcontrol-element-format.md)|Optional element.<br /><br /> Defines a list format for the view.|
|[Name Element for View](./name-element-for-view-format.md)|Required element.<br /><br /> Specifies the name used to reference the view.|
|[OutOfBand](./outofband-element-for-view-format.md)|Optional element<br /><br />When OutOfBand is true, the view applies regardless of previous objects that may have selected a different view.|
|[TableControl Element](./tablecontrol-element-format.md)|Optional element.<br /><br /> Defines a table format for the view.|
|[ViewSelectedBy Element for View](./viewselectedby-element-format.md)|Required element.<br /><br /> Defines the .NET objects that this view displays.|
|[WideControl Element](./widecontrol-element-format.md)|Optional element.<br /><br /> Defines a wide (single value) list format for the view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ViewDefinitions Element](./viewdefinitions-element-format.md)|Defines the views used to display objects.|

## Remarks

For more information about the components of different views and custom controls, see the following
topics:

- [Table View Components](./creating-a-table-view.md)

- [List View Components](./creating-a-list-view.md)

- [Wide View Components](./creating-a-wide-view.md)

- [Custom Controls](./creating-custom-controls.md)

## Example

This example shows a `View` element that defines a table view for the [System.Serviceprocess.Servicecontroller](/dotnet/api/System.ServiceProcess.ServiceController)
object.

```xml
<ViewDefinitions>
  <View>
    <Name>service</Name>
    <ViewSelectedBy>
      <TypeName>System.ServiceProcess.ServiceController</TypeName>
    </ViewSelectedBy>
    <TableControl>...</TableControl>
  </View>
</ViewDefinitions>

```

## See Also

[ViewDefinitions Element](./viewdefinitions-element-format.md)

[Name Element for View](./name-element-for-view-format.md)

[ViewSelectedBy Element](./viewselectedby-element-format.md)

[Controls Element for View](./controls-element-for-view-format.md)

[GroupBy Element for View](./groupby-element-for-view-format.md)

[TableControl Element](./tablecontrol-element-format.md)

[ListControl Element](./listcontrol-element-format.md)

[WideControl Element](./widecontrol-element-format.md)

[CustomControl Element](./customcontrol-element-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
