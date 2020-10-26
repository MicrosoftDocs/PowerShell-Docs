---
ms.date: 09/13/2016
ms.topic: reference
title: Defining Selection Sets
description: Defining Selection Sets
---
# Defining Selection Sets

When creating multiple views and controls, you can define sets of objects that are referred to as selection sets. A selection set enables you to define the objects one time, without having to define them repeatedly for each view or control. Typically, selection sets are used when you have a set of related .NET objects. For example, The `FileSystem` formatting file (FileSystem.format.ps1xml) defines a selection set of the file system types that several views use.

## Where Selection Sets are Defined and Referenced

You define selection sets as part of the common data that can be used by all the views and controls defined in the formatting file. The following example shows how to define three selection sets.

```xml
<Configuration>
  <SelectionSets>
    <SelectionSet>...</SelectionSet>
    <SelectionSet>...</SelectionSet>
    <SelectionSet>...</SelectionSet>
  </SelectionSets>
</Configuration>
```

You can reference a selection sets in the following ways:

- Each view has a `ViewSelectedBy` element that defines which objects are displayed by using the view. The `ViewSelectedBy` element has a `SelectionSetName` child element that specifies the selection set that all the definitions of the view use. There is no restriction on the number of selection sets that you can reference from a view.

- In each definition of a view or control, the `EntrySelectedBy` element defines which objects are displayed by using that definition. Typically a view or control has only one definition so the objects are defined by the `ViewSelectedBy` element. The `EntrySelectedBy` element of the definition has a `SelectionSetName` child element that specifies the selection set. If you specify the selection set for a definition, you cannot specify any of the other child elements of the `EntrySelectedBy` element.

- In each definition of a view or control, the `SelectionCondition` element can be used to specify a condition for when the definition is used. The `SelectionCondition` element has a `SelectionSetName` child element that specifies the selection set that triggers the condition. The condition is triggered when any of the objects defined in the selection set are displayed. For more information about how to set these conditions, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

## Selection Set Example

The following example shows a selection set that is taken directly from the `FileSystem` formatting file provided by Windows PowerShell. For more information about other Windows PowerShell formatting files, see [Windows PowerShell Formatting Files](./powershell-formatting-files.md).

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

The previous selection set is referenced in the `ViewSelectedBy` element of a table view.

```xml
<ViewDefinitions>
  <View>
    <Name>Files</Name>
    <ViewSelectedBy>
      <SelectionSetName>FileSystemTypes</SelectionSetName>
    </ViewSelectedBy>
    <TableControl>...</TableControl>
  </View>
</ViewDefinitions>

```

## XML Elements

 There is no limit to the number of selection sets that you can define. The following XML elements are used to create a selection set.

- The [SelectionSets](./selectionsets-element-format.md) element defines the sets of .NET objects that are referenced by the views and controls of the formatting file.

- The [SelectionSet](./selectionset-element-format.md) element defines a single set of .NET objects.

- The [Name](./name-element-for-selectionset-format.md) element specifies the name that is used to reference the selection set.

- The [Types](./types-element-for-selectionset-format.md) element specifies the .NET types of the objects of the selection set. (Within formatting files, objects are specified by their .NET type.)

 The following XML elements are used to specify a selection set.

- The following element specifies the selection set to use in all the definitions of the view:

  - [SelectionSetName Element for ViewSelectedBy (Format)](./selectionsetname-element-for-viewselectedby-format.md)

  - [SelectionSetName Element for EntrySelectedBy for GroupBy (Format)](./selectionsetname-element-for-entryselectedby-for-groupby-format.md)

- The following elements specify the selection set used by a single view definition:

  - [SelectionSetName Element for EntrySelectedBy for ListControl (Format)](./selectionsetname-element-for-entryselectedby-for-listcontrol-format.md)

  - [SelectionSetName Element for EntrySelectedBy for TableControl (Format)](./selectionsetname-element-for-entryselectedby-for-tablecontrol-format.md)

  - [SelectionSetName Element for EntrySelectedBy for WideControl (Format)](./selectionsetname-element-for-entryselectedby-for-widecontrol-format.md)

  - [SelectionSetName Element for EntrySelectedBy for CustomControl for View (Format)](./selectionsetname-element-for-entryselectedby-for-customcontrol-for-view-format.md)

- The following elements specify the selection set used by common and view control definitions:

  - [SelectionSetName Element for EntrySelectedBy for Controls for View (Format)](./selectionsetname-element-for-entryselectedby-for-controls-for-view-format.md)

  - [SelectionSetName Element for EntrySelectedBy for Controls for Configuration (Format)](./selectionsetname-element-for-entryselectedby-for-controls-for-configuration-format.md)

- The following elements specify the selection set used when you define which object to expand:

  - [SelectionSetName Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectionsetname-element-for-entryselectedby-for-enumerableexpansion-format.md)

- The following elements specify the selection set used by selection conditions.

  - [SelectionSetName Element for SelectionCondition for Controls for Configuration (Format)](./selectionsetname-element-for-selectioncondition-for-controls-for-configuration-format.md)

  - [SelectionSetName Element for SelectionCondition for Controls for View (Format)](./selectionsetname-element-for-selectioncondition-for-controls-for-view-format.md)

  - [SelectionSetName Element for SelectionCondition for CustomControl for View (Format)](./selectionsetname-element-for-selectioncondition-for-customcontrol-for-view-format.md)

  - [SelectionSetName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)

  - [SelectionSetName Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-listentry-format.md)

  - [SelectionSetName Element for SelectionCondition for EntrySelectedBy for TableControl (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-tablecontrol-format.md)

  - [SelectionSetName Element for SelectionCondition for EntrySelectedBy for WideEntry (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-wideentry-format.md)

  - [SelectionSetName Element for SelectionCondition for GroupBy (Format)](./selectionsetname-element-for-selectioncondition-for-groupby-format.md)

## See Also

[SelectionSets](./selectionsets-element-format.md)

[SelectionSet](./selectionset-element-format.md)

[Name](./name-element-for-selectionset-format.md)

[Types](./types-element-for-selectionset-format.md)

[PowerShell Formatting Files](./powershell-formatting-files.md)

[Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md)

[Writing a PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)
