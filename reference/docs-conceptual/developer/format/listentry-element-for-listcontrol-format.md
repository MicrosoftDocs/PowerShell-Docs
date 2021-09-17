---
description: ListEntry Element
ms.date: 08/23/2021
ms.topic: reference
title: ListEntry Element
---
# ListEntry Element

Provides a definition of the list view.

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element
- ListEntry Element

## Syntax

```xml
<ListEntry>
  <EntrySelectedBy>...</EntrySelectedBy>
  <ListItems>...</ListItems>
</ListEntry>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`ListEntry` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for ListEntry](./entryselectedby-element-for-listentry-for-listcontrol-format.md)|Optional element.<br /><br /> Defines the .NET objects that use this list view definition or the condition that must exist for this definition to be used.|
|[ListItems Element](./listitems-element-for-listentry-for-listcontrol-format.md)|Required element.<br /><br /> Defines the properties and scripts whose values are displayed by the list view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListEntries Element](./listentries-element-for-listcontrol-format.md)|Provides the definitions of the list view.|

## Remarks

A list view is a list format that displays property values or script values for each object. For
more information about list views, see [Creating a List View](./creating-a-list-view.md).

## Example

This example shows the XML elements that define the list view for the [System.Serviceprocess.Servicecontroller](/dotnet/api/System.ServiceProcess.ServiceController)
object.

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

[Creating a List View](./creating-a-list-view.md)

[EntrySelectedBy Element for ListEntry](./entryselectedby-element-for-listentry-for-listcontrol-format.md)

[ListEntries Element](./listentries-element-for-listcontrol-format.md)

[ListItems Element](./listitems-element-for-listentry-for-listcontrol-format.md)

[Writing a Windows PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)
