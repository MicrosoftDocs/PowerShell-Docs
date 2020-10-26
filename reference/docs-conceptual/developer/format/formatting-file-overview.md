---
ms.date: 09/13/2016
ms.topic: reference
title: Formatting File Overview
description: Formatting File Overview
---
# Formatting File Overview

The display format for the objects that are returned by commands (cmdlets, functions, and scripts) are defined by using formatting files (format.ps1xml files). Several of these files are provided by PowerShell to define the display format for those objects returned by PowerShell-provided commands, such as the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) object returned by the `Get-Process` cmdlet. However, you can also create your own custom formatting files to overwrite the default display formats or you can write a custom formatting file to define the display of objects returned by your own commands.

> [!IMPORTANT]
> Formatting files do not determine the elements of an object that are returned to the pipeline. When an object is returned to the pipeline, all members of that object are available even if some are not displayed.

PowerShell uses the data in these formatting files to determine what is displayed and how the displayed data is formatted. The displayed data can include the properties of an object or the value of a script. Scripts are used if you want to display some value that is not available directly from the properties of an object, such as adding the value of two properties of an object and then displaying the sum as a piece of data. Formatting of the displayed data is done by defining views for the objects that you want to display. You can define a single view for each object, you can define a single view for multiple objects, or you can define multiple views for the same object. There is no limit to the number of views that you can define.

## Common Features of Formatting Files

Each formatting file can define the following components that can be shared across all the views defined by the file:

- Default configuration setting, such as whether the data displayed in the rows of tables will be displayed on the next line if the data is longer than the width of the column. For more information about these settings, see [Defining Common Configuration Settings](./defining-common-configuration-features.md).

- Sets of objects that can be displayed by any of the views of the formatting file. For more information about these sets (referred to as *selection sets*), see [Defining Sets of Objects](./defining-selection-sets.md).

- Common controls that can be used by all the views of the formatting file. Controls give you finer control on how data is displayed. For more information about controls, see [Defining Custom Controls](./creating-custom-controls.md).

## Formatting Views

Formatting views can display objects in a table format, list format, wide format, and custom format. For the most part, each formatting definition is described by a set of XML tags that describe the view. Each view contains the name of the view, the objects that use the view, and the elements of the view, such as the column and row information for a table view.

Table View
Lists the properties of an object or a script block value in one or more columns. Each column represents a single property of the object or a script value. You can define a table view that displays all the properties of an object, a subset of the properties of an object, or a combination of properties and script values. Each row of the table represents a returned object. Creating a table view is very similar to when you pipe an object to the `Format-Table` cmdlet. For more information about this view, see [Table View](./creating-a-table-view.md).

List View
Lists the properties of an object or a script value in a single column. Each row of the list displays an optional label or the property name followed by the value of the property or script. Creating a list view is very similar to piping an object to the `Format-List` cmdlet. For more information about this view, see [List View](./creating-a-list-view.md).

Wide View
Lists a single property of an object or a script value in one or more columns. There is no label or header for this view. Creating a wide view is very similar to piping an object to the `Format-Wide` cmdlet. For more information about this view, see [Wide View](./creating-a-wide-view.md).

Custom View
Displays a customizable view of object properties or script values that does not adhere to the rigid structure of table views, list views, or wide views. You can define a stand-alone custom view, or you can define a custom view that is used by another view, such as a table view or list view. Creating a custom view is very similar to piping an object to the `Format-Custom` cmdlet. For more information about this view, see [Custom View](./creating-custom-controls.md).

## Components of a View

The following XML examples show the basic XML components of a view. The individual XML elements vary depending on which view you want to create, but the basic components of the views are all the same.

To start with, each view has a `Name` element that specifies a user friendly name that is used to reference the view. a `ViewSelectedBy` element that defines which .NET objects are displayed by the view, and a *control* element that defines the view.

```xml
<ViewDefinitions>
  <View>
    <Name>NameOfView</Name>
    <ViewSelectedBy>...</ViewSelectedBy>
    <TableControl>...</TableControl>
  </View>
  <View>
    <Name>NameOfView</Name>
    <ViewSelectedBy>...</ViewSelectedBy>
    <ListControl>...</ListControl>
  <View>
  <View>
    <Name>NameOfView</Name>
    <ViewSelectedBy>...</ViewSelectedBy>
    <WideControl>...</WideControl>
  <View>
  <View>
    <Name>NameOfView</Name>
    <ViewSelectedBy>...</ViewSelectedBy>
    <CustomControl>...</CustomControl>
  </View>
</ViewDefinitions>

```

Within the control element, you can define one or more *entry* elements. If you use multiple definitions, you must specify which .NET objects use each definition. Typically only one entry, with only one definition, is needed for each control.

```xml
<ListControl>
  <ListEntries>
    <ListEntry>
      <EntrySelectedBy>...</EntrySelectedBy>
      <ListItems>...</ListItems>
    <ListEntry>
    <ListEntry>
        <EntrySelectedBy>...</EntrySelectedBy>
      <ListItems>...</ListItems>
    <ListEntry>
    <ListEntry>
        <EntrySelectedBy>...</EntrySelectedBy>
      <ListItems>...</ListItems>
    <ListEntry>
  </ListEntries>
</ListControl>

```

Within each entry element of a view, you specify the *item* elements that define the .NET properties or scripts that are displayed by that view.

```xml

<ListItems>
  <ListItem>...</ListItem>
  <ListItem>...</ListItem>
  <ListItem>...</ListItem>
</ListItems>

```

As shown in the preceding examples, the formatting file can contain multiple views, a view can contain multiple definitions, and each definition can contain multiple items.

## Example of a Table View

The following example shows the XML tags used to define a table view that contains two columns. The [ViewDefinitions](./viewdefinitions-element-format.md) element is the container element for all the views defined in the formatting file. The [View](./view-element-format.md) element defines the specific table, list, wide, or custom view. Within each [View](./view-element-format.md) element, the [Name](./name-element-for-view-format.md) element specifies the name of the view, the [ViewSelectedBy](./viewselectedby-element-format.md) element defines the objects that use the view, and the different control elements (such as the `TableControl` element shown in the following example) define the type of the view.

```xml
<ViewDefinitions>
  <View>
    <Name>Name of View</Name>
    <ViewSelectedBy>
      <TypeName>Object to display using this view</TypeName>
      <TypeName>Object to display using this view</TypeName>
    </ViewSelectedBy>
    <TableControl>
      <TableHeaders>
        <TableColumnHeader>
          <Width></Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Width></Width>
        </TableColumnHeader>
      </TableHeaders>
      <TableRowEntries>
        <TableRowEntry>
          <TableColumnItems>
            <TableColumnItem>
              <PropertyName>Header for column 1</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>Header for column 2</PropertyName>
            </TableColumnItem>
          </TableColumnItems>
        </TableRowEntry>
      </TableRowEntries>
    </TableControl)
  </View>
</ViewDefinitions>

```

## See Also

[Creating a List View](./creating-a-list-view.md)

[Creating a Table View](./creating-a-table-view.md)

[Creating a Wide View](./creating-a-wide-view.md)

[Creating Custom Controls](./creating-custom-controls.md)

[Writing a PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)
