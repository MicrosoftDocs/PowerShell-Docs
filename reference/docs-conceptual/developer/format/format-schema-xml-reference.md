---
ms.date: 09/13/2016
ms.topic: reference
title: Format Schema XML Reference
description: Format Schema XML Reference
---
# Format Schema XML Reference

The topics in this section describe the XML elements used by formatting files (Format.ps1xml files). Formatting files define how the .NET object is displayed; they do not change the object itself.

## In This Section

[Alignment Element for TableColumnHeader for TableControl (Format)](./alignment-element-for-tablecolumnheader-for-tablecontrol-format.md)
Defines how the data in a column header is displayed.

[Alignment Element for TableColumnItem for TableControl (Format)](./alignment-element-for-tablecolumnitem-for-tablecontrol-format.md)
Defines how the data in the row is displayed.

[AutoSize Element for TableControl (Format)](./autosize-element-for-tablecontrol-format.md)
Specifies whether the column size and the number of columns are adjusted based on the size of the data.

[Autosize Element for WideControl (Format)](./autosize-element-for-widecontrol-format.md)
Specifies whether the column size and the number of columns are adjusted based on the size of the data.

[ColumnNumber Element for WideControl (Format)](./columnnumber-element-for-widecontrol-format.md)
Specifies the number of columns displayed in the wide view.

[Configuration Element (Format)](./configuration-element-format.md)
Represents the top-level element of the formatting file.

[Control Element for Controls for Configuration (Format)](./control-element-for-controls-for-configuration-format.md)
Defines a common control that can be used by all the views of the formatting file and the name that is used to reference the control.

[Control Element for Controls for View  (Format)](./control-element-for-controls-for-view-format.md)
Defines a control that can be used by the view and the name that is used to reference the control.

[Controls Element for Configuration (Format)](./controls-element-for-configuration-format.md)
Defines the common controls that can be used by all views of the formatting file.

[Controls Element for View (Format)](./controls-element-for-view-format.md)
Defines the view controls that can be used by a specific view.

[CustomControl Element for Control for Configuration (Format)](./customcontrol-element-for-control-for-controls-for-configuration-format.md)
Defines a control. This element is used when defining a common control that can be used by all the views in the formatting file.

[CustomControl Element for Control for Controls for View (Format)](./customcontrol-element-for-control-for-controls-for-view-format.md)
Defines a control that is used by the view.

[CustomControl Element for GroupBy (Format)](./customcontrol-element-for-groupby-format.md)
Defines the custom control that displays the new group.

[CustomControl Element (Format)](./customcontrol-element-for-groupby-format.md)
Defines a custom control format for the view.

[CustomControlName Element for ExpressionBinding for Controls for Configuration (Format)](./customcontrolname-element-for-expressionbinding-for-controls-for-configuration-format.md)
Specifies the name of a common control. This element is used when defining a common control that can be used by all the views in the formatting file.

[CustomControlName Element for ExpressionBindine for Controls for View (Format)](./customcontrolname-element-for-expressionbinding-for-controls-for-view-format.md)
Specifies the name of a common control or a view control. This element is used when defining controls that can be used by a view.

[CustomControlName Element of GroupBy (Format)](./customcontrolname-element-for-groupby-format.md)
Specifies the name of a custom control that is used to display the new group. This element is used when defining a table, list, wide or custom control view.

[CustomEntry Element for CustomControl for Controls for Configuration (Format)](./customentry-element-for-customcontrol-for-controls-for-configuration-format.md)
Provides a definition of the common control. This element is used when defining a common control that can be used by all the views in the formatting file.

[CustomEntry Element for CustomEntries for Controls for View (Format)](./customentry-element-for-customentries-for-controls-for-view-format.md)
Provides a definition of the control. This element is used when defining controls that can be used by a view.

[CustomEntry Element for CustomEntries for View (Format)](./customentry-element-for-customentries-for-customcontrol-for-view-format.md)
Provides a definition of the custom control view.

[CustomEntry Element for CustomControl for GroupBy (Format)](./customentry-element-for-customcontrol-for-groupby-format.md)
Provides a definition of the control. This element is used when defining how a new group of objects is displayed.

[CustomEntries Element for CustomControl for Configuration (Format)](./customentries-element-for-customcontrol-for-controls-for-configuration-format.md)
Provides the definitions of a common control. This element is used when defining a common control that can be used by all the views in the formatting file.

[CustomEntries Element for CustomControl for Controls for View (Format)](./customentries-element-for-customcontrol-for-controls-for-view-format.md)
Provides the definitions for the control. This element is used when defining controls that can be used by a view.

[CustomEntries Element for CustomControl for GroupBy (Format)](./customentries-element-for-customcontrol-for-groupby-format.md)
Provides the definitions for the control. This element is used when defining how a new group of objects is displayed.

[CustomEntries Element for CustomControl for View (Format)](./customentries-element-for-customcontrol-for-view-format.md)
Provides the definitions of the custom control view. The custom control view must specify one or more definitions.

[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)
Defines what data is displayed by the control and how it is displayed. This element is used when defining a common control that can be used by all the views in the formatting file.

[CustomItem Element for CustomEntry for Controls for View (Format)](./customitem-element-for-customentry-for-controls-for-view-format.md)
Defines what data is displayed by the control and how it is displayed. This element is used when defining controls that can be used by a view.

[CustomItem Element for CustomEntry for View (Format)](./customitem-element-for-customentry-for-customcontrol-for-view-format.md)
Defines what data is displayed by the custom control view and how it is displayed. This element is used when defining a custom control view.

[CustomItem Element for CustomEntry for GroupBy (Format)](./customitem-element-for-customentry-for-groupby-format.md)
Defines what data is displayed by the custom control view and how it is displayed. This element is used when defining how a new group of objects is displayed.

[DefaultSettings Element (Format)](./defaultsettings-element-format.md)
Defines common settings that apply to all the views of the formatting file. Common settings include displaying errors, wrapping text in tables, defining how collections are expanded, and more.

[DisplayError Element (Format)](./displayerror-element-format.md)
Specifies that the string #ERR is displayed when an error occurs displaying a piece of data.

[EntrySelectedBy Element for CustomEntry for Controls for Configuration (Format)](./entryselectedby-element-for-customentry-for-controls-for-configuration-format.md)
Defines the .NET types that use the definition of the common control or the condition that must exist for this control to be used. This element is used when defining a common control that can be used by all the views in the formatting file.

[EntrySelectedBy Element for CustomEntry for Controls for View (Format)](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)
Defines the .NET types that use this control definition or the condition that must exist for this definition to be used. This element is used when defining controls that can be used by a view.

[EntrySelectedBy Element for CustomEntry for View (Format)](./entryselectedby-element-for-customentry-for-customcontrol-for-view-format.md)
Defines the .NET types that use this custom entry or the condition that must exist for this entry to be used.

[EntrySelectedBy Element for EnumerableExpansion (Format)](./entryselectedby-element-for-enumerableexpansion-format.md)
Defines the .NET types that use this definition or the condition that must exist for this definition to be used.

[EntrySelectedBy Element for CustomEntry for GroupBy (Format)](./entryselectedby-element-for-customentry-for-groupby-format.md)
Defines the .NET types that use this control definition or the condition that must exist for this definition to be used. This element is used when defining how a new group of objects is displayed.

[EntrySelectedBy Element for ListEntry for ListControl (Format)](./entryselectedby-element-for-listentry-for-listcontrol-format.md)
Defines the .NET types that use this list view definition or the condition that must exist for this definition to be used. In most cases only one definition is needed for a list view. However, you can provide multiple definitions for the list view if you want to use the same list view to display different data for different objects.

[EntrySelectedBy Element for TableRowEntry (Format)](./entryselectedby-element-for-tablerowentry-for-tablecontrol-format.md)
Defines the .NET types whose property values are displayed in the row.

[EntrySelectedBy Element for WideEntry (Format)](./entryselectedby-element-for-wideentry-format.md)
Defines the .NET types that use this definition of the wide view or the condition that must exist for this definition to be used.

[EnumerableExpansion Element (Format)](./enumerableexpansion-element-format.md)
Defines how specific .NET collection objects are expanded when they are displayed in a view.

[EnumerableExpansions Element (Format)](./enumerableexpansions-element-format.md)
Defines how .NET collection objects are expanded when they are displayed in a view.

[EnumerateCollection Element for ExpressionBinding for Controls for Configuration (Format)](./enumeratecollection-element-for-expressionbinding-for-controls-for-configuration-format.md)
Specified that the elements of collections are displayed by the control. This element is used when defining a common control that can be used by all the views in the formatting file.

[EnumerateCollection Element for ExpressionBinding for Controls for View (Format)](./enumeratecollection-element-for-expressionbinding-for-controls-for-view-format.md)
Specified that the elements of collections are displayed. This element is used when defining controls that can be used by a view.

[EnumerateCollection Element for Expression Binding for CustomControl for View (Format)](./enumeratecollection-element-for-expressionbinding-for-customcontrol-for-view-format.md)
Specifies that the elements of collections are displayed. This element is used when defining a custom control view.

[EnumerateCollection Element for ExpressionBinding for GroupBy (Format)](./enumeratecollection-element-for-expressionbinding-for-groupby-format.md)
Specifies that the elements of collections are displayed. This element is used when defining how a new group of objects is displayed.

[Expand Element (Format)](./expand-element-format.md)
Specifies how the collection object is expanded for this definition.

[ExpressionBinding Element for CustomItem for Controls for Configuration (Format)](./expressionbinding-element-for-customitem-for-controls-for-configuration-format.md)
Defines the data that is displayed by the control. This element is used when defining a common control that can be used by all the views in the formatting file.

[ExpressionBinding Element for CustomItem for Controls for View (Format)](./expressionbinding-element-for-customitem-for-controls-for-view-format.md)
Defines the data that is displayed by the control. This element is used when defining controls that can be used by a view.

[ExpressionBinding Element for CustomItem for CustomControl for View (Format)](./expressionbinding-element-for-customitem-for-customcontrol-for-view-format.md)
Defines the data that is displayed by the control. This element is used when defining a custom control view.

[ExpressionBinding Element for CustomItem for GroupBy (Format)](./expressionbinding-element-for-customitem-for-groupby-format.md)
Defines the data that is displayed by the control. This element is used when defining how a new group of objects is displayed.

[FirstLineHanging Element for Frame for Controls for Configuration (Format)](./firstlinehanging-element-for-frame-for-controls-for-configuration-format.md)
Specifies how many characters the first line of data is shifted to the left. This element is used when defining a common control that can be used by all the views in the formatting file.

[FirstLineHanging Element of Frame of Controls of View (Format)](./firstlinehanging-element-for-frame-for-controls-for-view-format.md)
Specifies how many characters the first line of data is shifted to the left. This element is used when defining controls that can be used by a view.

[FirstLineHanging Element for Frame for CustomControl for View (Format)](./firstlinehanging-element-for-frame-for-customcontrol-for-view-format.md)
Specifies how many characters the first line of data is shifted to the left. This element is used when defining a custom control view.

[FirstLineHanging Element for Frame for GroupBy (Format)](./firstlinehanging-element-for-frame-for-groupby-format.md)
Specifies how many characters the first line of data is shifted to the left. This element is used when defining how a new group of objects is displayed.

[FirstLineIndent Element for Frame for Controls for Configuration (Format)](./firstlineindent-element-for-frame-for-controls-for-configuration-format.md)
Specifies how many characters the first line of data is shifted to the right. This element is used when defining a common control that can be used by all the views in the formatting file.

[FirstLineIndent Element of Frame of Controls of View (Format)](./firstlineindent-element-for-frame-for-controls-for-view-format.md)
Specifies how many characters the first line of data is shifted to the right. This element is used when defining controls that can be used by a view.

[FirstLineIndent Element](./firstlineindent-element-for-frame-for-customcontrol-for-view-format.md)
Specifies how many characters the first line of data is shifted to the right. This element is used when defining a custom control view.

[FirstLineIndent Element for Frame for GroupBy (Format)](./firstlineindent-element-for-frame-for-groupby-format.md)
Specifies how many characters the first line of data is shifted to the right. This element is used when defining how a new group of objects is displayed.

[FormatString Element for ListItem (Format)](./formatstring-element-for-listitem-for-listcontrol-format.md)
Specifies a format pattern that defines how the property or script value is displayed.

[FormatString Element for TableColumnItem (Format)](./formatstring-element-for-tablecolumnitem-for-tablecontrol-format.md)
Specifies a format pattern that defines how the property or script value of the table is displayed.

[FormatString Element for WideItem for WideControl (Format)](./formatstring-element-for-wideitem-for-widecontrol-format.md)
Specifies a format pattern that defines how the property or script value is displayed in the view.

[Frame Element for CustomItem for Controls for Configuration (Format)](./frame-element-for-customitem-for-controls-for-configuration-format.md)
Defines how the data is displayed, such as shifting the data to the left or right. This element is used when defining a common control that can be used by all the views in the formatting file.

[Frame Element for CustomItem for Controls for View (Format)](./frame-element-for-customitem-for-controls-for-view-format.md)
Defines how the data is displayed, such as shifting the data to the left or right. This element is used when defining controls that can be used by a view.

[Frame Element for CustomItem for CustomControl for View (Format)](./frame-element-for-customitem-for-customcontrol-for-view-format.md)
Defines how the data is displayed, such as shifting the data to the left or right. This element is used when defining a custom control view.

[Frame Element for CustomItem for GroupBy (Format)](./frame-element-for-customitem-for-groupby-format.md)
Defines how the data is displayed, such as shifting the data to the left or right. This element is used when defining how a new group of objects is displayed.

[GroupBy Element for View (Format)](./groupby-element-for-view-format.md)
Defines how Windows PowerShell displays a new group of objects.

[HideTableHeaders Element (Format)](./hidetableheaders-element-format.md)
Specifies that the headers of the table are not displayed.

[ItemSelectionCondition Element for ExpressionBinding for Controls for Configuration (Format)](./itemselectioncondition-element-for-expressionbinding-for-controls-for-configuration-format.md)
Defines the condition that must exist for this control to be used. This element is used when defining a common control that can be used by all the views in the formatting file.

[ItemSelectionCondition Element of ExpressionBinding for Controls for View (Format)](./itemselectioncondition-element-for-expressionbinding-for-controls-for-view-format.md)
Defines the condition that must exist for this control to be used. This element is used when defining controls that can be used by a view.

[ItemSelectionCondition Element for Expression Binding for CustomControl for View (Format)](./itemselectioncondition-element-for-expressionbinding-for-customcontrol-format.md)
Defines the condition that must exist for this control to be used. There is no limit to the number of selection conditions that can be specified for a control item. This element is used when defining a custom control view.

[ItemSelectionCondition Element for ExpressionBinding for GroupBy (Format)](./itemselectioncondition-element-for-expressionbinding-for-groupby-format.md)
Defines the condition that must exist for this control to be used. There is no limit to the number of selection conditions that can be specified for a control item. This element is used when defining how a new group of objects is displayed.

[ItemSelectionCondition Element for ListItem (Format)](./itemselectioncondition-element-for-listitem-for-listcontrol-format.md)
Defines the condition that must exist for this list item to be used.

[Label Element for ListItem for ListControl(Format)](./label-element-for-listitem-for-listcontrol-format.md)
Specifies the label for the property or script value in the row.

[Label Element for GroupBy (Format)](./label-element-for-groupby-format.md)
Specifies a label that is displayed when a new group is encountered.

[Label Element for TableColumnHeader (Format)](./label-element-for-tablecolumnheader-for-tablecontrol-format.md)
Defines the label that is displayed at the top of a column.

[LeftIndent Element for Frame for Controls for Configuration (Format)](./leftindent-element-for-frame-for-controls-for-configuration-format.md)
Specifies how many characters the data is shifted away from the left margin. This element is used when defining a common control that can be used by all the views in the formatting file.

[LeftIndent Element of Frame of Controls of View (Format)](./leftindent-element-for-frame-for-controls-for-view-format.md)
Specifies how many characters the data is shifted away from the left margin. This element is used when defining controls that can be used by a view.

[LeftIndent Element for Frame for CustomControl for View (Format)](./leftindent-element-for-frame-for-customcontrol-for-view-format.md)
Specifies how many characters the data is shifted away from the left margin. This element is used when defining a custom control view.

[LeftIndent Element for Frame for GroupBy (Format)](./leftindent-element-for-frame-for-groupby-format.md)
Specifies how many characters the data is shifted away from the left margin. This element is used when defining how a new group of objects is displayed.

[ListControl Element (Format)](./listcontrol-element-format.md)
Defines a list format for the view.

[ListEntry Element (Format)](./listentry-element-for-listcontrol-format.md)
Provides a definition of the list view.

[ListEntries Element (Format)](./listentries-element-for-listcontrol-format.md)
Defines how the rows of the list view are displayed.

[ListItem Element (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)
Defines the property or script whose value is displayed in a row of the list view.

[ListItems Element (Format)](./listitems-element-for-listentry-for-listcontrol-format.md)
Defines the properties and scripts that are displayed in the list view.

[Name Element for Control for Controls for Configuration (Format)](./name-element-for-control-for-controls-for-configuration-format.md)
Specifies the name of the control. This element is used when defining a common control that can be used by all the views in the formatting file.

[Name Element for SelectionSet (Format)](./name-element-for-selectionset-format.md)
Specifies the name used to reference the selection set.

[Name Element for View (Format)](./name-element-for-view-format.md)
Specifies the name that is used to identify the view.

[NewLine Element for CustomItem for Controls for Configuration (Format)](./newline-element-for-customitem-for-controls-for-configuration-format.md)
Adds a blank line to the display of the control. This element is used when defining a common control that can be used by all the views in the formatting file.

[NewLine Element for CustomItem for Controls for View (Format)](./newline-element-for-customitem-for-controls-for-view-format.md)
Adds a blank line to the display of the control. This element is used when defining controls that can be used by a view.

[NewLine Element for CustomItem for CustomControl for View (Format)](./newline-element-for-customitem-for-customcontrol-for-view-format.md)
Adds a blank line to the display of the control. This element is used when defining a custom control view.

[NewLine Element for CustomItem for GroupBy (Format)](./newline-element-for-customitem-for-groupby-format.md)
Adds a blank line to the display of the control. This element is used when defining how a new group of objects is displayed.

[PropertyName Element for ExpressionBinding for Controls for Configuration (Format)](./propertyname-element-for-expressionbinding-for-controls-for-configuration-format.md)
Specifies the .NET property whose value is displayed by the common control. This element is used when defining a common control that can be used by all the views in the formatting file.

[PropertyName Element for ExpressionBinding for Controls for View (Format)](./propertyname-element-for-expressionbinding-for-controls-for-view-format.md)
Specifies the .NET property whose value is displayed by the control. This element is used when defining controls that can be used by a view.

[PropertyName Element for ExpressionBinding for CustomControl for View (Format)](./propertyname-element-for-expressionbinding-for-customcontrol-for-view-format.md)
Specifies the .NET property whose value is displayed by the control. This element is used when defining a custom control view

[PropertyName Element for ExpressionBinding for GroupBy (Format)](./propertyname-element-for-expressionbinding-for-groupby-format.md)
Specifies the .NET property whose value is displayed by the control. This element is used when defining how a new group of objects is displayed.

[PropertyName Element for GroupBy (Format)](./propertyname-element-for-groupby-format.md)
Specifies the .NET property that starts a new group whenever its value changes.

[PropertyName Element for ItemSeclectionCondition for Controls for Configuration (Format)](./propertyname-element-for-itemseclectioncondition-for-controls-for-configuration-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the control is used. This element is used when defining a common control that can be used by all the views in the formatting file.

[PropertyName Element for ItemSelectionCondition for Controls for View (Format)](./propertyname-element-for-itemselectioncondition-for-controls-for-view-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the control is used. This element is used when defining controls that can be used by a view.

[PropertyName Element for ItemSelectionCondition for CustomControl for View (Format](./propertyname-element-for-itemselectioncondition-for-customcontrol-for-view-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the control is used. This element is used when defining a custom control view.

[PropertyName Element for ItemSelectionCondition for GroupBy (Format)](./propertyname-element-for-itemselectioncondition-for-groupby-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the control is used. This element is used when defining how a new group of objects is displayed.

[PropertyName Element for ItemSelectionCondition for ListItem (Format)](./propertyname-element-for-itemselectioncondition-for-listcontrol-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the view is used. This element is used when defining a list view.

[PropertyName Element for ListItem for ListControl (Format)](./propertyname-element-for-listitem-for-listcontrol-format.md)
Specifies the .NET property whose value is displayed in the list.

[PropertyName Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./propertyname-element-for-selectioncondition-for-controls-for-configuration-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the entry is used. This element is used when defining a common control that can be used by all the views in the formatting file.

[PropertyName Element for SelectionCondition for Controls for View (Format)](./propertyname-element-for-selectioncondition-for-controls-for-view-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the entry is used. This element is used when defining controls that can be used by a view.

[PropertyName Element for SelectionCondition for CustomControl for View (Format)](./propertyname-element-for-selectioncondition-for-customcontrol-for-view-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the definition is used. This element is used when defining a custom control view.

[PropertyName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)](./propertyname-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the definition is used.

[PropertyName Element for SelectionCondition for GroupBy (Format)](./propertyname-element-for-selectioncondition-for-groupby-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the definition is used. This element is used when defining how a new group of objects is displayed.

[PropertyName Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./propertyname-element-for-selectioncondition-for-entryselectedby-for-listcontrol-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the list entry is used.

[PropertyName Element for SelectionCondition for EntrySelectedBy for TableRowEntry (Format)](./propertyname-element-for-selectioncondition-for-entryselectedby-for-tablerowentry-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the table entry is used.

[PropertyName Element for SelectionCondition for EntrySelectedBy for WideEntry (Format)](./propertyname-element-for-selectioncondition-for-entryselectedby-for-wideentry-format.md)
Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the definition is used.

[PropertyName Element for TableColumnItem (Format)](./propertyname-element-for-tablecolumnitem-for-tablecontrol-format.md)
Specifies the property whose value is displayed in the column of the row.

[PropertyName Element for WideItem (Format)](./propertyname-element-for-wideitem-for-widecontrol-format.md)
Specifies the property of the object whose value is displayed in the wide view.

[RightIndent Element for Frame for Controls for Configuration (Format)](./rightindent-element-for-frame-for-controls-for-configuration-format.md)
Specifies how many characters the data is shifted away from the right margin. This element is used when defining a common control that can be used by all the views in the formatting file.

[RightIndent Element of Frame of Controls of View (Format)](./rightindent-element-for-frame-for-controls-for-view-format.md)
Specifies how many characters the data is shifted away from the right margin. This element is used when defining controls that can be used by a view.

[RightIndent Element](./rightindent-element-for-frame-for-customcontrol-for-view-format.md)
Specifies how many characters the data is shifted away from the right margin. This element is used when defining a custom control view.

[RightIndent Element for Frame for GroupBy (Format)](./rightindent-element-for-frame-for-groupby-format.md)
Specifies how many characters the data is shifted away from the right margin. This element is used when defining how a new group of objects is displayed.

[ScriptBlock Element for ExpressionBinding for Controls for Configuration (Format)](./scriptblock-element-for-expressionbinding-for-controls-for-configuration-format.md)
Specifies the script whose value is displayed by the common control. This element is used when defining a common control that can be used by all the views in the formatting file.

[ScriptBlock Element for ExpressionBinding for Controls for View (Format)](./scriptblock-element-for-expressionbinding-for-controls-for-view-format.md)
Specifies the script whose value is displayed by the control. This element is used when defining controls that can be used by a view.

[ScriptBlock Element for ExpressionBinding for CustomCustomControl for View (Format)](./scriptblock-element-for-expressionbinding-for-customcontrol-for-view-format.md)
Specifies the script whose value is displayed by the control. This element is used when defining a custom control view.

[ScriptBlock Element for ExpressionBinding for GroupBy (Format)](./scriptblock-element-for-expressionbinding-for-groupby-format.md)
Specifies the script whose value is displayed by the control. This element is used when defining how a new group of objects is displayed.

[ScriptBlock Element for GroupBy (Format)](./scriptblock-element-for-groupby-format.md)
Specifies the script that starts a new group whenever its value changes.

[ScriptBlock Element for ItemSelectionCondition for Controls for Configuration (Format)](./scriptblock-element-for-itemseclectioncondition-for-controls-for-configuration-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the control is used. This element is used when defining a common control that can be used by all the views in the formatting file.

[ScriptBlock Element for ItemSelectionCondition for Controls for View (Format)](./scriptblock-element-for-itemselectioncondition-for-controls-for-view-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the control is used. This element is used when defining controls that can be used by a view.

[ScriptBlock Element for ItemSelectionCondition for CustomControl for View (Format)](./scriptblock-element-for-itemselectioncondition-for-customcontrol-for-view-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the control is used. This element is used when defining a custom control view.

[ScriptBlock Element for ItemSelectionCondition for GroupBy (Format)](./scriptblock-element-for-itemselectioncondition-for-groupby-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the control is used. This element is used when defining how a new group of objects is displayed.

[ScriptBlock Element for ItemSelectionCondition for ListControl  (Format)](./scriptblock-element-for-itemselectioncondition-for-listcontrol-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the list item is used. This element is used when defining a list view.

[ScriptBlock Element for ListItem (Format)](./scriptblock-element-for-listitem-for-listcontrol-format.md)
Specifies the script whose value is displayed in the row of the list.

[ScriptBlock Element for SelectionCondition for Controls for Configuration (Format)](./scriptblock-element-for-selectioncondition-for-controls-for-configuration-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the definition is used. This element is used when defining a common control that can be used by all the views in the formatting file.

[ScriptBlock Element for SelectionCondition for Controls for View (Format)](./scriptblock-element-for-selectioncondition-for-controls-for-view-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the definition is used. This element is used when defining controls that can be used by a view.

[ScriptBlock Element for SelectionCondition for CustomControl for View (Format)](./scriptblock-element-for-selectioncondition-for-customcontrol-for-view-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the definition is used. This element is used when defining a custom control view.

[ScriptBlock Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)
Specifies the script that triggers the condition.

[ScriptBlock Element for SelectionCondition for GroupBy (Format)](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-groupby-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the definition is used. This element is used when defining how a new group of objects is displayed.

[ScriptBlock Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-listcontrol-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the list entry is used.

[ScriptBlock Element for SelectionCondition for EntrySelectedBy for TableRowEntry (Format)](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-tablecontrol-format.md)
Specifies the script block that triggers the condition. When this script is evaluated to `true`, the condition is met, and the table entry is used.

[ScriptBlock Element for SelectionCondition for EntrySelectedBy for WideEntry (Format)](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-widecontrol-format.md)
Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the wide entry definition is used.

[ScriptBlock Element for TableColumnItem (Format)](./scriptblock-element-for-tablecolumnitem-for-tablecontrol-format.md)
Specifies the script whose value is displayed in the column of the row.

[ScriptBlock Element for WideItem (Format)](./scriptblock-element-for-wideitem-for-widecontrol-format.md)
Specifies the script whose value is displayed in the wide view.

[SelectionCondition Element for EntrySelectedBy for CustomEntry for Configuration (Format)](./selectioncondition-element-for-entryselectedby-for-controls-for-configuration-format.md)
Defines a condition that must exist for a common control definition to be used. This element is used when defining a common control that can be used by all the views in the formatting file.

[SelectionCondition Element for EntrySelectedBy for Controls for View (Format)](./selectioncondition-element-for-entryselectedby-for-controls-for-view-format.md)
Defines a condition that must exist for the control definition to be used. This element is used when defining controls that can be used by a view.

[SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)
Defines a condition that must exist for a control definition to be used. This element is used when defining a custom control view.

[SelectionCondition Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectioncondition-element-for-entryselectedby-for-enumerableexpansion-format.md)
Defines the condition that must exist to expand the collection objects of this definition.

[SelectionCondition Element for EntrySelectedBy for GroupBy (Format)](./selectioncondition-element-for-entryselectedby-for-groupby-format.md)
Defines a condition that must exist for a control definition to be used. This element is used when defining how a new group of objects is displayed.

[SelectionCondition Element for EntrySelectedBy for ListEntry (Format)](./selectioncondition-element-for-entryselectedby-for-listcontrol-format.md)
Defines the condition that must exist to use this definition of the list view. There is no limit to the number of selection conditions that can be specified for a list definition.

[SelectionCondition Element for EntrySelectedBy for TableRowEntry (Format)](./selectioncondition-element-for-entryselectedby-for-tablecontrol-format.md)
Defines the condition that must exist to use for this definition of the table view. There is no limit to the number of selection conditions that can be specified for a table definition.

[SelectionCondition Element for EntrySelectedBy for WideEntry (Format)](./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md)
Defines the condition that must exist for this definition to be used. There is no limit to the number of selection conditions that can be specified for a wide entry definition.

[SelectionSet Element (Format)](./selectionset-element-format.md)
Defines a set of .NET objects that can be referenced by the name of the set.

[SelectionSetName Element for EntrySelectedBy for Controls for Configuration (Format)](./selectionsetname-element-for-selectioncondition-for-controls-for-configuration-format.md)
Specifies a set of .NET types that use this definition of the control. This element is used when defining a common control that can be used by all the views in the formatting file.

[SelectionSetName Element for EntrySelectedBy for Controls for View (Format)](./selectionsetname-element-for-entryselectedby-for-controls-for-view-format.md)
Specifies a set of .NET types that use this definition of the control. This element is used when defining controls that can be used by a view.

[SelectionSetName Element for EntrySelectedBy for CustomEntry (Format)](./selectionsetname-element-for-entryselectedby-for-customcontrol-for-view-format.md)
Specifies a set of .NET objects for the list entry. There is no limit to the number of selection sets that can be specified for an entry.

[SelectionSetName Element for EntrySelectedBy for EnumerableExpansion (Format)](./selectionsetname-element-for-entryselectedby-for-enumerableexpansion-format.md)
Specifies the set of .NET types that are expanded by this definition.

[SelectionSetName Element for EntrySelectedBy for GroupBy (Format)](./selectionsetname-element-for-entryselectedby-for-groupby-format.md)
Specifies a set of .NET objects for the list entry. There is no limit to the number of selection sets that can be specified for an entry. This element is used when defining how a new group of objects is displayed.

[SelectionSetName Element for EntrySelectedBy for ListEntry (Format)](./selectionsetname-element-for-entryselectedby-for-listcontrol-format.md)
Specifies a set of .NET objects for the list entry. There is no limit to the number of selection sets that can be specified for an entry.

[SelectionSetName Element for EntrySelectedBy for TableRowEntry (Format)](./selectionsetname-element-for-entryselectedby-for-tablecontrol-format.md)
Specifies a set of .NET types the use this entry of the table view. There is no limit to the number of selection sets that can be specified for an entry.

[SelectionSetName Element for EntrySelectedBy for WideEntry (Format)](./selectionsetname-element-for-entryselectedby-for-widecontrol-format.md)
Specifies a set of .NET objects for the definition. The definition is used whenever one of these objects is displayed.

[SelectionSetName Element for SelectionCondition for Controls for Configuration (Format)](./selectionsetname-element-for-selectioncondition-for-controls-for-configuration-format.md)
Specifies the set of .NET types that trigger the condition. When any of the types in this set are present, the condition is met, and the object is displayed by using this control. This element is used when defining a common control that can be used by all the views in the formatting file.

[SelectionSetName Element for SelectionCondition for Controls for View (Format)](./selectionsetname-element-for-selectioncondition-for-controls-for-view-format.md)
Specifies the set of .NET types that trigger the condition. When any of the types in this set are present, the condition is met and the object is displayed using this control. This element is used when defining controls that can be used by a view.

[EntrySelectedBy Element for CustomEntry for View (Format)](./entryselectedby-element-for-customentry-for-customcontrol-for-view-format.md)
Specifies the set of .NET types that trigger the condition. When any of the types in this set are present, the condition is met and the object is displayed using this control. This element is used when defining a custom control view.

[SelectionSetName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)
Specifies the set of .NET types that trigger the condition. When any of the types in this set are present, the condition is met.

[SelectionSetName Element for SelectionCondition for GroupBy (Format)](./selectionsetname-element-for-selectioncondition-for-groupby-format.md)
Specifies the set of .NET types that trigger the condition. When any of the types in this set are present, the condition is met, and the object is displayed by using this control. This element is used when defining how a new group of objects is displayed.

[SelectionSetName Element for SelectionCondition for EntrySelectedBy for ListEntry (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-listentry-format.md)
Specifies the set of .NET types that trigger the condition. When any of the types in this set are present, the condition is met, and the object is displayed by using this definition of the list view.

[SelectionSetName Element for SelectionCondition for EntrySelectedBy for TableRowEntry (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-tablecontrol-format.md)
Specifies the set of .NET types that trigger the condition. When any of the types in this set are present, the condition is met, and the object is displayed by using this definition of the table view.

[SelectionSetName Element for SelectionCondition for EntrySelectedBy for WideEntry (Format)](./selectionsetname-element-for-selectioncondition-for-entryselectedby-for-wideentry-format.md)
Specifies the set of .NET types that trigger the condition. When any of the types in this set are present, the condition is met, and the object is displayed by using this definition of the wide view.

[SelectionSetName Element for ViewSelectedBy (Format)](./selectionsetname-element-for-viewselectedby-format.md)
Specifies a set of .NET objects that are displayed by the view.

[SelectionSets Element (Format)](./selectionsets-element-format.md)
Defines the sets of .NET objects that can be used by individual format views.

[ShowError Element (Format)](./showerror-element-format.md)
Specifies that the full error record is displayed when an error occurs while displaying a piece of data.

[TableColumnHeader Element for TableHeaders for TableControl (Format)](./tablecolumnheader-element-format.md)
Defines the label, the width of the column, and the alignment of the label for a column of the table.

[TableColumnItem Element (Format)](./tablecolumnitem-element-for-tablecolumnitems-for-tablecontrol-format.md)
Defines the property or script whose value is displayed in the column of the row.

[TableColumnItems Element (Format)](./tablecolumnitems-element-for-tablerowentry-for-tablecontrol-format.md)
Defines the properties or scripts whose values are displayed in the row.

[TableControl Element (Format)](./tablecontrol-element-format.md)
Defines a table format for a view.

[TableHeaders Element (Format)](./tableheaders-element-format.md)
Defines the headers for the columns of a table.

[TableRowEntries Element (Format)](./tablerowentries-element-for-tablecontrol-format.md)
Defines the rows of the table.

[TableRowEntry Element (Format)](./tablerowentry-element-for-tablerowentries-for-tablecontrol-format.md)
Defines the data that is displayed in a row of the table.

[Text Element for CustomItem for Controls for Configuration (Format)](./text-element-for-customitem-for-controls-for-configuration-format.md)
Specifies text that is added to the data that is displayed by the control, such as a label, brackets to enclose the data, and spaces to indent the data. This element is used when defining a common control that can be used by all the views in the formatting file.

[Text Element for CustomItem for Controls for View (Format)](./text-element-for-customitem-for-controls-for-view-format.md)
Specifies text that is added to the data that is displayed by the control, such as a label, brackets to enclose the data, and spaces to indent the data. This element is used when defining controls that can be used by a view.

[Text Element for CustomItem (Format)](./text-element-for-customitem-for-customview-for-view-format.md)
Specifies text that is added to the data that is displayed by the control, such as a label, brackets to enclose the data, and spaces to indent the data. This element is used when defining a custom control view.

[Text Element for CustomItem for GroupBy (Format)](./text-element-for-customitem-for-groupby-format.md)
Specifies text that is added to the data that is displayed by the control, such as a label, brackets to enclose the data, and spaces to indent the data. This element is used when defining how a new group of objects is displayed.

[TypeName Element for EntrySelectedBy for Controls for Configuration (Format)](./typename-element-for-entryselectedby-for-controls-for-configuration-format.md)
Specifies a .NET type that uses this definition of the control. This element is used when defining a common control that can be used by all the views in the formatting file.

[TypeName Element for EntrySelectedBy for Controls for View (Format)](./typename-element-for-entryselectedby-for-controls-for-view-format.md)
Specifies a .NET type that uses this definition of the control. This element is used when defining controls that can be used by a view.

[TypeName Element for EntrySelectedBy for CustomEntry for View (Format)](./typename-element-for-entryselectedby-for-customentry-for-view-format.md)
Specifies a .NET type that uses this definition of the custom control view. There is no limit to the number of types that can be specified for a definition.

[TypeName Element for EntrySelectedBy for EnumerableExpansion (Format)](./typename-element-for-entryselectedby-for-enumerableexpansion-format.md)
Specifies a .NET type that is expanded by this definition. This element is used when defining a default settings.

[TypeName Element for EntrySelectedBy for GroupBy (Format)](./typename-element-for-entryselectedby-for-groupby-format.md)
Specifies a .NET type that uses this definition of the custom control. This element is used when defining how a new group of objects is displayed.

[TypeName Element for EntrySelectedBy for ListControl (Format)](./typename-element-for-entryselectedby-for-listcontrol-format.md)
Specifies a .NET type that uses this entry of the list view. There is no limit to the number of types that can be specified for a list entry.

[TypeName Element for EntrySelectedBy for TableRowEntry (Format)](./typename-element-for-entryselectedby-for-tablecontrol-format.md)
Specifies a .NET type that uses this entry of the table view. There is no limit to the number of types that can be specified for a table entry.

[TypeName Element for EntrySelectedBy for WideEntry (Format)](./typename-element-for-entryselectedby-for-wideentry-format.md)
Specifies a .NET type for the definition. The definition is used whenever this object is displayed.

[TypeName Element for SelectionCondition for Controls for Configuration (Format)](./typename-element-for-selectioncondition-for-controls-for-configuration-format.md)
Specifies a .NET type that triggers the condition. This element is used when defining a common control that can be used by all the views in the formatting file.

[TypeName Element for SelectionCondition for Controls for View (Format)](./typename-element-for-selectioncondition-for-controls-for-view-format.md)
Specifies a .NET type that triggers the condition. This element is used when defining controls that can be used by a view.

[TypeName Element for SelectionCondition for CustomControl for View  (Format)](./typename-element-for-selectioncondition-for-customcontrol-for-view-format.md)
Specifies a .NET type that triggers the condition. This element is used when defining a custom control view.

[TypeName Element for SelectionCondition for EntrySelectedBy for EnumerableExpansion (Format)](./typename-element-for-selectioncondition-for-entryselectedby-for-enumerableexpansion-format.md)
Specifies a .NET type that triggers the condition.

[TypeName Element for SelectionCondition for GroupBy  (Format)](./typename-element-for-selectioncondition-for-groupby-format.md)
Specifies a .NET type that triggers the condition. This element is used when defining how a new group of objects is displayed.

[TypeName Element for SelectionCondition for EntrySelectedBy for ListControl (Format)](./typename-element-for-selectioncondition-for-entryselectedby-for-listcontrol-format.md)
Specifies a .NET type that triggers the condition. When this type is present, the list entry is used.

[TypeName Element for SelectionCondition for EntrySelectedBy for TableRowEntry (Format)](./typename-element-for-selectioncondition-for-entryselectedby-for-tablecontrol-format.md)
Specifies a .NET type that triggers the condition. When this type is present, the condition is met, and the table row is used.

[TypeName Element for SelectionCondition for EntrySelectedBy for WideEntry (Format)](./typename-element-for-selectioncondition-for-entryselectedby-for-widecontrol-format.md)
Specifies a .NET type that triggers the condition. When this type is present, the definition is used.

[TypeName Element for Types (Format)](./typename-element-for-types-format.md)
Specifies the .NET type of an object that belongs to the selection set.

[TypeName Element for ViewSelectedBy (Format)](./typename-element-for-viewselectedby-format.md)
Specifies a .NET object that is displayed by the view.

[Types Element (Format)](./types-element-for-selectionset-format.md)
Defines the .NET objects that are in the selection set.

[View Element (Format)](./view-element-format.md)
Defines a view that is used to display one or more .NET objects.

[ViewDefinitions Element (Format)](./viewdefinitions-element-format.md)
Defines the views used to display objects.

[ViewSelectedBy Element (Format)](./viewselectedby-element-format.md)
Defines the .NET objects that are displayed by the view.

[WideControl Element (Format)](./widecontrol-element-format.md)
Defines a wide (single value) list format for the view. This view displays a single property value or script value for each object.

[WideEntries Element (Format)](./wideentries-element-for-widecontrol-format.md)
Provides the definitions of the wide view. The wide view must specify one or more definitions.

[WideEntry Element (Format)](./wideentry-element-for-widecontrol-format.md)
Provides a definition of the wide view.

[WideItem Element (Format)](./wideitem-element-for-widecontrol-format.md)
Defines the property or script whose value is displayed.

[Width Element (Format)](./width-element-for-tablecolumnheader-for-tablecontrol-format.md)
Defines the width (in characters) of a column.

[Wrap Element (Format)](./wrap-element-for-tablerowentry-for-tablecontrol-format.md)
Specifies that text that exceeds the column width is displayed on the next line.

[WrapTables Element (Format)](./wraptables-element-format.md)
Specifies that data in a table cell is moved to the next line if the data is longer than the width of the column.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
