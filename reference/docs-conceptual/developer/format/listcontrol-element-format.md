---
description: ListControl Element
ms.date: 08/23/2021
ms.topic: reference
title: ListControl Element
---
# ListControl Element

Defines a list format for the view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element

## Syntax

```xml
<ListControl>
  <ListEntries>...</ListEntries>
</ListControl>

```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`ListControl` element. This element must contain only a single child element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[ListEntries Element](./listentries-element-for-listcontrol-format.md)|Required element.<br /><br /> Provides the definitions of the list view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[View Element](./view-element-format.md)|Defines a view that is used to display the members of one or more objects.|

## Remarks

For more information about creating a list view, see [Creating a List View](./creating-a-list-view.md).

## Example

This example shows a list view for the [System.Serviceprocess.Servicecontroller](/dotnet/api/System.ServiceProcess.ServiceController)
object.

```
<View>
  <Name>System.ServiceProcess.ServiceController</Name>
  <ViewSelectedBy>
    <TypeName>System.ServiceProcess.ServiceController</TypeName>
  </ViewSelectedBy>
  <ListControl>
    <ListEntries>
      <ListEntry>...</ListEntry>
    </ListEntries>
  </ListControl>
</View>
```

## See Also

[View Element](./view-element-format.md)

[ListEntries Element](./listentries-element-for-listcontrol-format.md)

[Creating a List View](./creating-a-list-view.md)

[Writing a Windows PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)
