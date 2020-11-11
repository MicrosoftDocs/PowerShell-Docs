---
ms.date: 09/13/2016
ms.topic: reference
title: Defining Conditions for Displaying Data
description: Defining Conditions for Displaying Data
---
# Defining Conditions for Displaying Data

When defining what data is displayed by a view or a control, you can specify a condition that must exist for the data to be displayed. The condition can be triggered by a specific property, or when a script or property value evaluates to `true`. When the selection condition is met, the definition of the view or control is used.

## Specifying a Selection Condition for a Definition

When creating a definition for a view or control, the `EntrySelectedBy` element is used to specify which objects will use the definition or what condition must exist for the definition to be used. The condition is specified by the `SelectionCondition` element.

In the following example, a selection condition is specified for a definition of a table view. In this example, the definition is used only when the specified script is evaluated to `true`.

```xml
<TableRowEntry>
  <EntrySelectedBy>
    <SelectionCondition>
      <ScriptBlock>ScriptToEvaluate</ScriptBlock>
    </SelectionCondition>
  </EntrySelectedBy>
  <TableColumnItems>
  </TableColumnItems>
</TableRowEntry>

```

There is no limit to the number of selection conditions that you can specify for a definition of a view or control. The only requirements are the following:

- The selection condition must specify one property name or script to trigger the condition, but cannot specify both.

- The selection condition can specify any number of .NET types or selection sets, but cannot specify both.

## Specifying a Selection Condition for an Item

You can also specify when an item of a list view or control is used by including the `ItemSelectionCondition` element in the item definition. In the following example, a selection condition is specified for an item of a list view. In this example, the item is used only when the script is evaluated to `true`.

```xml
<ListItem>
  <ItemSelectionCondition>
    <ScriptBlock>ScriptToEvaluate</ScriptBlock>
  </ItemSelectionCondition>
</ListItem>

```

You can specify only one selection condition for an item. And the condition must specify one property name or script to trigger the condition, but cannot specify both.

## XML Elements

 The following XML elements are used to create a selection condition.

- The following elements specify selection conditions for view definitions:

  - [SelectionCondition Element for EntrySelectedBy for TableControl (Format)](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)

  - [SelectionCondition Element for EntrySelectedBy for ListControl (Format)](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)

  - [SelectionCondition Element for EntrySelectedBy for WideControl (Format)](./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md)

  - [SelectionCondition Element for EntrySelectedBy for CustomControl (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)

- The following elements specify selection conditions for common and view control definitions:

  - [SelectionCondition Element for EntrySelectedBy for Controls for Configuration (Format)](./selectioncondition-element-for-entryselectedby-for-controls-for-configuration-format.md)

  - [SelectionCondition Element for EntrySelectedBy for Controls for View (Format)](./selectioncondition-element-for-entryselectedby-for-controls-for-view-format.md)

- The following element specifies the selection condition for expanding collection objects:

  - [SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)

- The following element specifies the selection condition for displaying a new group of data:

  - [SelectionCondition Element for EntrySelectedBy for GroupBy (Format)](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)

- The following element specifies an item selection condition for a list view:

  - [ItemSelectionCondition Element for ListItem for ListControl (Format)](./itemselectioncondition-element-for-listitem-for-listcontrol-format.md)

- The following elements specify an item selection condition for controls:

  - [ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)

  - [ItemSelectionCondition Element for ExpressionBinding for Controls for View (Format)](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)

  - [ItemSelectionCondition Element for ExpressionBinding for CustomControl (Format)](./itemselectioncondition-element-for-expressionbinding-for-customcontrol-format.md)

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
