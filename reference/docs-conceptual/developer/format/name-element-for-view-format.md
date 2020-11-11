---
ms.date: 09/13/2016
ms.topic: reference
title: Name Element for View (Format)
description: Name Element for View (Format)
---
# Name Element for View (Format)

Specifies the name that is used to identify the view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
Name Element (Format)

## Syntax

```xml
<Name>ViewName</Name>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `Name` element. Only one `Name` element is allowed for each view.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[View Element (Format)](./view-element-format.md)|Defines a view that is used to display the members of one or more .NET objects.|

## Text Value

Specify a unique friendly name for the view. This name can include a reference to the type of the view (such as a table view or list view), which object or set of objects use the view, what command returns the objects, or a combination of these.

## Remarks

For more information about the different types of views, see the following topics: [Table View](./creating-a-table-view.md), [List View](./creating-a-list-view.md), [Wide View](./creating-a-wide-view.md), and [Custom View](./creating-custom-controls.md).

## Example

The following example shows a `View` element that defines a table view for the [System.Serviceprocess.Servicecontroller](/dotnet/api/System.ServiceProcess.ServiceController) object. The name of the view is "service".

```xml
<View>
  <Name>service</Name>
  <ViewSelectedBy>
    <TypeName>System.ServiceProcess.ServiceController</TypeName>
  </ViewSelectedBy>
  <TableControl>...</TableControl>
</View>

```

## See Also

[Creating a List View](./creating-a-list-view.md)

[Creating a Table View](./creating-a-table-view.md)

[Creating a Wide View](./creating-a-wide-view.md)

[Creating Custom Controls](./creating-custom-controls.md)

[View Element (Format)](./view-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
