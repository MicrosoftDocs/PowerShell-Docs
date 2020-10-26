---
ms.date: 09/13/2016
ms.topic: reference
title: ListEntries Element for ListControl (Format)
description: ListEntries Element for ListControl (Format)
---
# ListEntries Element for ListControl (Format)

Provides the definitions of the list view. The list view must specify one or more definitions.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element (Format)

## Syntax

```xml
<ListEntries>
  <ListEntry>...</ListEntry>
</ListEntries>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `ListEntries` element. At least one child element must be specified.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[ListEntry Element (Format)](./listentry-element-for-listcontrol-format.md)|Provides a definition of the list view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListControl Element (Format)](./listcontrol-element-format.md)|Defines a list format for the view.|

## Remarks

For more information about list views, see [List View](./creating-a-list-view.md).

## Example

This example shows the XML elements that define the list view for the [System.Serviceprocess.Servicecontroller](/dotnet/api/System.ServiceProcess.ServiceController) object.

```xml
<View>
  <Name>System.ServiceProcess.ServiceController</Name>
  <ViewSelectedBy>
    <TypeName>System.ServiceProcess.ServiceController</TypeName>
  </ViewSelectedBy>
  <ListControl>
    <ListEntries>
      <ListEntry>
        <ListItems>...</ListItems>
      </ListEntry>
    </ListEntries>
  </ListControl>
</View>
```

## See Also

[ListControl Element (Format)](./listcontrol-element-format.md)

[ListEntry Element (Format)](./listentry-element-for-listcontrol-format.md)

[List View](./creating-a-list-view.md)

[Writing a Windows PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)
