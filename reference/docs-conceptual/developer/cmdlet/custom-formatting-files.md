---
ms.date: 09/13/2016
ms.topic: reference
title: Custom Formatting Files
description: Custom Formatting Files
---
# Custom Formatting Files

The display format for the objects returned by cmdlets, functions, and scripts are defined using formatting files (format.ps1xml files). Several of these files are provided by Windows PowerShell to define the default display format for those objects returned by Windows PowerShell cmdlets. However, you can also create your own custom formatting files to overwrite the default display formats or to define the display of objects returned by your own commands.

Windows PowerShell uses the data in these formatting files to determine what is displayed and how the data is formatted. The displayed data can include the properties of an object or the value of a script block.  Script blocks are used if you want to display some value that is not available directly from the properties of an object. For example, you may want to add the value of two properties of an object and display the sum as a separate piece of data. When you write your own formatting file, you will need to define *views* for the objects that you want to display. You can define a single view for each object, you can define a single view for multiple objects, or you can define multiple views for the same object. There is no limit to the number of views that you can define.

> [!IMPORTANT]
> Formatting files do not determine the elements of an object that are returned to the pipeline. When an object is returned to the pipeline, all members of that object are available.

## Format Views

Formatting views can display objects in a table format, a list format, a wide format, and a custom format. For the most part, each formatting definition is described by a set of XML tags that describe a view. Each view contains the name of the view, the objects that use the view, and the elements of the view, such as the column and row information for a table view.

The following views are available.

Table view
Lists the properties of an object or a script block value in one or more columns. Each column represents a property of the object or a script block value. You can define a table view that displays all the properties of an object, a subset of the properties of an object, or a combination of properties and script block values. Each row of the table represents a returned object. For more information about this view, see [Table View](../format/creating-a-table-view.md).

List view
Lists the properties of an object or a script block value in a single column. Each row of the list displays an optional label or the property name followed by the value of the property or script block. For more information about this view, see [List View](../format/creating-a-list-view.md).

Wide view
Lists a single property of an object or a script block value in one or more columns. There is no label or header for this view. For more information about this view, see [Wide View](../format/creating-a-wide-view.md).

Custom view
Displays a customizable view of object properties or script block values that does not adhere to the rigid structure of table views, list views, or wide views. You can define a standalone custom view, or you can define a custom view that is used by another view, such as a table view or list view. For more information about this view, see [Custom View](../format/creating-custom-controls.md).

## View XML Elements

The following example shows the XML tags used to define a table view that contains two columns. The [ViewDefinitions](../format/viewdefinitions-element-format.md) element is the container element for all the views defined in the formatting file. The [View](../format/view-element-format.md) element defines the specific table, list, wide, or custom view. Within each view, the [Name](../format/name-element-for-view-format.md) element specifies the name of the view, the [ViewSelectedBy](../format/viewselectedby-element-format.md) element defines the objects that use the view, and the different control elements (such as the `TableControl` element) define the format of the view.

```xml
ViewDefinitions
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

[Table View](../format/creating-a-table-view.md)

[List View](../format/creating-a-list-view.md)

[Wide View](../format/creating-a-wide-view.md)

[Custom View](../format/creating-custom-controls.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
