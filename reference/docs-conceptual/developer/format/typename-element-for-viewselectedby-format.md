---
ms.date: 09/13/2016
ms.topic: reference
title: TypeName Element for ViewSelectedBy (Format)
description: TypeName Element for ViewSelectedBy (Format)
---
# TypeName Element for ViewSelectedBy (Format)

Specifies a .NET object that is displayed by the view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ViewSelectedBy Element (Format)
TypeName Element for ViewSelectedBy (Format)

## Syntax

```xml
<TypeName>FullyQualifiedTypeName</TypeName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent elements of the `TypeName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ViewSelectedBy Element (Format)](./viewselectedby-element-format.md)|Defines the .NET objects that are displayed by the view.|

## Text Value

Specify the fully qualified name of the .NET type, such as `System.IO.DirectoryInfo`.

## Remarks

For more information about how this element is used in different views, see [Creating a Table View](./creating-a-table-view.md), [Creating a List View](./creating-a-list-view.md), [Creating a Wide View](./creating-a-wide-view.md), and [Custom View Components](./creating-custom-controls.md).

## Example

The following example shows how to specify the [System.Serviceprocess.Servicecontroller](/dotnet/api/System.ServiceProcess.ServiceController) object for a list view. The same schema is used for table, wide, and custom views.

```xml
<View>
  <Name>System.ServiceProcess.ServiceController</Name>
  <ViewSelectedBy>
    <TypeName>System.ServiceProcess.ServiceController</TypeName>
  </ViewSelectedBy>
  <ListControl>...</ListControl>
</View>
```

## See Also

[Creating a List View](./creating-a-list-view.md)

[Creating a Table View](./creating-a-table-view.md)

[Creating a Wide View](./creating-a-wide-view.md)

[Creating Custom Controls](./creating-custom-controls.md)

[ViewSelectedBy Element (Format)](./viewselectedby-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
