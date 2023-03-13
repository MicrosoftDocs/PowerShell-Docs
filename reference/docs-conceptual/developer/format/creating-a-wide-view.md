---
description: Creating a Wide View
ms.date: 03/13/2023
ms.topic: reference
title: Creating a Wide View
---
# Creating a Wide View

A wide view displays a single value for each object that's displayed. The displayed value can be the
value of a .NET object property or the value of a script. By default, there is no label or header
for this view.

## A Wide View Display

The following example shows how Windows PowerShell displays the [System.Diagnostics.Process][32]
object that's returned by the [Get-Process][30] cmdlet when its output is piped to the
[Format-Wide][31] cmdlet. (By default, the [Get-Process][30] cmdlet returns a table view.) In this
example, the two columns are used to display the name of the process for each returned object. The
name of the object's property isn't displayed, only the value of the property.

```powershell
Get-Process | format-wide
```

```Output
AEADISRV                     agrsmsvc
Ati2evxx                     Ati2evxx
audiodg                      CCC
CcmExec                      communicator
Crypserv                     csrss
csrss                        DevDtct2
DM1Service                   dpupdchk
dwm                          DxStudio
EXCEL                        explorer
GoogleToolbarNotifier        GrooveMonitor
hpqwmiex                     hpservice
Idle                         InoRpc
InoRT                        InoTask
ipoint                       lsass
lsm                          MOM
MSASCui                      notepad
...                          ...
```

## Defining the Wide View

The following XML shows the wide view schema for the [System.Diagnostics.Process][32] object.

```xml
<View>
  <Name>process</Name>
  <ViewSelectedBy>
    <TypeName>System.Diagnostics.Process</TypeName>
  </ViewSelectedBy>
  <GroupBy>...</GroupBy>
  <Controls>...</Controls>
  <WideControl>
    <WideEntries>
      <WideEntry>
        <WideItem>
          <PropertyName>ProcessName</PropertyName>
        </WideItem>
      </WideEntry>
    </WideEntries>
  </WideControl>
</View>

```

The following XML elements are used to define a wide view:

- The [View][21] element is the parent element of the wide view. (This is the same parent element
  for the table, list, and custom control views.)
- The [Name][13] element specifies the name of the view. This element is required for all views.
- The [ViewSelectedBy][22] element defines the objects that use the view. This element is required.
- The [GroupBy][11] element defines when a new group of objects is displayed. A new group is started
  whenever the value of a specific property or script changes. This element is optional.
- The [Controls][03] elements defines the custom controls that are defined by the wide view.
  Controls give you a way to further specify how the data is displayed. This element is optional. A
  view can define its own custom controls, or it can use common controls that can be used by any
  view in the formatting file. For more information about custom controls, see
  [Creating Custom Controls][04].
- The [WideControl][25] element and its child elements define what's displayed in the view. In the
  preceding example, the view is designed to display the
  [System.Diagnostics.Process.ProcessName][33] property.

For an example of a complete formatting file that defines a simple wide view, see
[Wide View (Basic)][23].

## Providing Definitions for Your Wide View

Wide views can provide one or more definitions by using the child elements of the [WideControl][25]
element. Typically, a view will have only one definition. In the following example, the view
provides a single definition that displays the [System.Diagnostics.Process.ProcessName][33]
property. A wide view can display the value of a property or the value of a script (not shown in the
example).

```xml
<WideControl>
  <AutoSize/>
  <ColumnNumber></ColumnNumber>
  <WideEntries>
    <WideEntry>
      <WideItem>
        <PropertyName>ProcessName</PropertyName>
      </WideItem>
    </WideEntry>
  </WideEntries>
</WideControl>
```

The following XML elements can be used to provide definitions for a wide view:

- The [WideControl][25] element and its child elements define what's displayed in the view.
- The [AutoSize][01] element specifies whether the column size and the number of columns are
  adjusted based on the size of the data. This element is optional.
- The [ColumnNumber][02] element specifies the number of columns displayed in the wide view. This
  element is optional.
- The [WideEntries][26] element provides the definitions of the view. In most cases, a view will
  have only one definition. This element is required.
- The [WideEntry][27] element provides a definition of the view. At least one [WideEntry][27] is
  required; however, there is no maximum limit to the number of elements that you can add. In most
  cases, a view will have only one definition.
- The [EntrySelectedBy][09] element specifies the objects that are displayed by a specific
  definition. This element is optional and is needed only when you define multiple [WideEntry][27]
  elements that display different objects.
- The [WideItem][28] element specifies the data that's displayed by the view. In contrast to other
  types of views, a wide control can display only one item.
- The [PropertyName][15] element specifies the property whose value is displayed by the view. You
  must specify either a property or a script, but you can't specify both.
- The [ScriptBlock][17] element specifies the script whose value is displayed by the view. You must
  specify either a script or a property, but you can't specify both.
- The [FormatString][10] element specifies a pattern that's used to display the data. This element
  is optional.

For an example of a complete formatting file that defines a wide view definition, see
[Wide View (Basic)][23].

## Defining the Objects That Use the Wide View

There are two ways to define which .NET objects use the wide view. You can use the
[ViewSelectedBy][22] element to define the objects that can be displayed by all the definitions of
the view, or you can use the [EntrySelectedBy][09] element to define which objects are displayed by
a specific definition of the view. In most cases, a view has only one definition, so objects are
typically defined by the [ViewSelectedBy][22] element.

The following example shows how to define the objects that are displayed by the wide view using the
[ViewSelectedBy][22] and [TypeName][20] elements. There is no limit to the number of [TypeName][20]
elements that you can specify, and their order isn't significant.

```xml
<View>
  <Name>System.ServiceProcess.ServiceController</Name>
  <ViewSelectedBy>
    <TypeName>System.Diagnostics.Process</TypeName>
  </ViewSelectedBy>
  <WideControl>...</WideControl>
</View>
```

The following XML elements can be used to specify the objects that are used by the wide view:

- The [ViewSelectedBy][22] element defines which objects are displayed by the wide view.
- The [TypeName][20] element specifies the .NET that's displayed by the view. The fully qualified
  .NET type name is required. You must specify at least one type or selection set for the view, but
  there is no maximum number of elements that can be specified.

For an example of a complete formatting file, see [Wide View (Basic)][23].

The following example uses the [ViewSelectedBy][22] and [SelectionSetName][19] elements. Use
selection sets where you have a related set of objects that are displayed using multiple views, such
as when you define a wide view and a table view for the same objects. For more information about how
to create a selection set, see [Defining Selection Sets][08].

```xml
<View>
  <Name>System.ServiceProcess.ServiceController</Name>
  <ViewSelectedBy>
    <SelectionSetName>.NET Type Set</SelectionSetName>
  </ViewSelectedBy>
  <WideControl>...</WideControl>
</View>
```

The following XML elements can be used to specify the objects that are used by the wide view:

- The [ViewSelectedBy][22] element defines which objects are displayed by the wide view.
- The [SelectionSetName][19] element specifies a set of objects that can be displayed by the view.
  You must specify at least one selection set or type for the view, but there is no maximum number
  of elements that can be specified.

The following example shows how to define the objects displayed by a specific definition of the wide
view using the [EntrySelectedBy][09] element. Using this element, you can specify the .NET type name
of the object, a selection set of objects, or a selection condition that specifies when the
definition is used. For more information about how to create a selection conditions, see
[Defining Conditions for Displaying Data][07].

```xml
<WideEntry>
  <EntrySelectedBy>
    <TypeName>.NET Type</TypeName>
  </EntrySelectedBy>
</WideEntry>
```

The following XML elements can be used to specify the objects that are used by a specific definition
of the wide view:

- The [EntrySelectedBy][09] element defines which objects are displayed by the definition.
- The [TypeName][20] element specifies the .NET that's displayed by the definition. When using this
  element the fully qualified .NET type name is required. You must specify at least one type,
  selection set, or selection condition for the definition, but there is no maximum number of
  elements that can be specified.
- The [SelectionSetName][19] element (not shown) specifies a set of objects that can be displayed by
  this definition. You must specify at least one type, selection set, or selection condition for the
  definition, but there is no maximum number of elements that can be specified.
- The [SelectionCondition][18] element (not shown) specifies a condition that must exist for this
  definition to be used. You must specify at least one type, selection set, or selection condition
  for the definition, but there is no maximum number of elements that can be specified. For more
  information about defining selection conditions, see
  [Defining Conditions for Displaying Data][07].

## Displaying Groups of objects in a Wide View

You can separate the objects that are displayed by the wide view into groups. This doesn't mean that
you define a group, only that Windows PowerShell starts a new group whenever the value of a specific
property or script changes. In the following example, a new group is started whenever the value of
the [System.Serviceprocess.Servicecontroller.Servicetype][34] property changes.

```xml
<GroupBy>
  <Label>Service Type</Label>
  <PropertyName>ServiceType</PropertyName>
</GroupBy>

```

The following XML elements are used to define when a group is started:

- The [GroupBy][11] element defines the property or script that starts the new group and defines how
  the group is displayed.
- The [PropertyName][14] element specifies the property that starts a new group whenever its value
  changes. You must specify a property or script to start the group, but you can't specify both.
- The [ScriptBlock][16] element specifies the script that starts a new group whenever its value
  changes. You must specify a script or property to start the group, but you can't specify both.
- The [Label][12] element defines a label that's displayed at the beginning of each group. In
  addition to the text specified by this element, Windows PowerShell displays the value that
  triggered the new group and adds a blank line before and after the label. This element is
  optional.
- The [CustomControl][05] element defines a control that's used to display the data. This element is
  optional.
- The [CustomControlName][06] element specifies a common or view control that's used to display the
  data. This element is optional.

For an example of a complete formatting file that defines groups, see [Wide View (GroupBy)][24].

## Using Format Strings

Formatting strings can be added to a wide view to further define how the data is displayed. The
following example shows how to define a formatting string for the value of the `StartTime` property.

```xml
<WideItem>
  <PropertyName>StartTime</PropertyName>
  <FormatString>{0:MMM} {0:DD} {0:HH}:{0:MM}</FormatString>
</WideItem>
```

The following XML elements can be used to specify a format pattern:

- The [WideItem][28] element specifies the data that's displayed by the view.
- The [PropertyName][15] element specifies the property whose value is displayed by the view. You
  must specify either a property or a script, but you can't specify both.
- The [FormatString][10] element specifies a format pattern that defines how the property or script
  value is displayed in the view
- The [ScriptBlock][17] element (not shown) specifies the script whose value is displayed by the
  view. You must specify either a script or a property, but you can't specify both.

In the following example, the `ToString` method is called to format the value of the script. Scripts
can call any method of an object. Therefore, if an object has a method, such as `ToString`, that has
formatting parameters, the script can call that method to format the output value of the script.

```xml
<WideItem>
  <ScriptBlock>
    [String]::Format("{0,-10} {1,-8}", $_.LastWriteTime.ToString("d"), $_.LastWriteTime.ToString("t"))
  </ScriptBlock>
</WideItem>
```

The following XML element can be used to calling the `ToString` method:

- The [WideItem][28] element specifies the data that's displayed by the view.
- The [ScriptBlock][17] element (not shown) specifies the script whose value is displayed by the
  view. You must specify either a script or a property, but you can't specify both.

## See Also

- [Wide View (Basic)][23]
- [Wide View (GroupBy)][24]
- [Writing a PowerShell Formatting File][29]

<!-- link references -->
[01]: ./autosize-element-for-widecontrol-format.md
[02]: ./columnnumber-element-for-widecontrol-format.md
[03]: ./controls-element-for-view-format.md
[04]: ./creating-custom-controls.md
[05]: ./customcontrol-element-for-groupby-format.md
[06]: ./customcontrolname-element-for-groupby-format.md
[07]: ./defining-conditions-for-displaying-data.md
[08]: ./defining-selection-sets.md
[09]: ./entryselectedby-element-for-wideentry-format.md
[10]: ./formatstring-element-for-wideitem-for-widecontrol-format.md
[11]: ./groupby-element-for-view-format.md
[12]: ./label-element-for-groupby-format.md
[13]: ./name-element-for-view-format.md
[14]: ./propertyname-element-for-groupby-format.md
[15]: ./propertyname-element-for-wideitem-for-widecontrol-format.md
[16]: ./scriptblock-element-for-groupby-format.md
[17]: ./scriptblock-element-for-wideitem-for-widecontrol-format.md
[18]: ./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md
[19]: ./selectionsetname-element-for-viewselectedby-format.md
[20]: ./typename-element-for-viewselectedby-format.md
[21]: ./view-element-format.md
[22]: ./viewselectedby-element-format.md
[23]: ./wide-view-basic.md
[24]: ./wide-view-groupby.md
[25]: ./widecontrol-element-format.md
[26]: ./wideentries-element-for-widecontrol-format.md
[27]: ./wideentry-element-for-widecontrol-format.md
[28]: ./wideitem-element-for-widecontrol-format.md
[29]: ./writing-a-powershell-formatting-file.md
[30]: xref:Microsoft.PowerShell.Management.Get-Process
[31]: xref:Microsoft.PowerShell.Utility.Format-Wide
[32]: xref:System.Diagnostics.Process
[33]: xref:System.Diagnostics.Process.ProcessName
[34]: xref:System.ServiceProcess.ServiceController.ServiceType
