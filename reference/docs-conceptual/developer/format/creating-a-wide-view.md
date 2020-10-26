---
ms.date: 09/13/2016
ms.topic: reference
title: Creating a Wide View
description: Creating a Wide View
---
# Creating a Wide View

A wide view displays a single value for each object that is displayed. The displayed value can be the value of a .NET object property or the value of a script. By default, there is no label or header for this view.

## A Wide View Display

The following example shows how Windows PowerShell displays the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) object that is returned by the [Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) cmdlet when its output is piped to the [Format-Wide](/powershell/module/Microsoft.PowerShell.Utility/Format-Wide) cmdlet. (By default, the [Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) cmdlet returns a table view.) In this example, the two columns are used to display the name of the process for each returned object. The name of the object's property is not displayed, only the value of the property.

```
Get-Process | format-wide
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

The following XML shows the wide view schema for the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) object.

```xml
View>
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

- The [View](./view-element-format.md) element is the parent element of the wide view. (This is the same parent element for the table, list, and custom control views.)

- The [Name](./name-element-for-view-format.md) element specifies the name of the view. This element is required for all views.

- The [ViewSelectedBy](./viewselectedby-element-format.md) element defines the objects that use the view. This element is required.

- The [GroupBy](./groupby-element-for-view-format.md) element defines when a new group of objects is displayed. A new group is started whenever the value of a specific property or script changes. This element is optional.

- The [Controls](./controls-element-for-view-format.md) elements defines the custom controls that are defined by the wide view. Controls give you a way to further specify how the data is displayed. This element is optional. A view can define its own custom controls, or it can use common controls that can be used by any view in the formatting file. For more information about custom controls, see [Creating Custom Controls](./creating-custom-controls.md).

- The [WideControl](./widecontrol-element-format.md) element and its child elements define what is displayed in the view. In the preceding example, the view is designed to display the [System.Diagnostics.Process.Processname](/dotnet/api/System.Diagnostics.Process.ProcessName) property.

For an example of a complete formatting file that defines a simple wide view, see [Wide View (Basic)](./wide-view-basic.md).

## Providing Definitions for Your Wide View

Wide views can provide one or more definitions by using the child elements of the [WideControl](./widecontrol-element-format.md) element. Typically, a view will have only one definition. In the following example, the view provides a single definition that displays the value of the [System.Diagnostics.Process.Processname](/dotnet/api/System.Diagnostics.Process.ProcessName) property. A wide view can display the value of a property or the value of a script (not shown in the example).

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

- The [WideControl](./widecontrol-element-format.md) element and its child elements define what is displayed in the view.

- The [AutoSize](./autosize-element-for-widecontrol-format.md) element specifies whether the column size and the number of columns are adjusted based on the size of the data. This element is optional.

- The [ColumnNumber](./columnnumber-element-for-widecontrol-format.md) element specifies the number of columns displayed in the wide view. This element is optional.

- The [WideEntries](./wideentries-element-for-widecontrol-format.md) element provides the definitions of the view. In most cases, a view will have only one definition. This element is required.

- The [WideEntry](./wideentry-element-for-widecontrol-format.md) element provides a definition of the view. At least one [WideEntry](./wideentry-element-for-widecontrol-format.md) is required; however, there is no maximum limit to the number of elements that you can add. In most cases, a view will have only one definition.

- The [EntrySelectedBy](./entryselectedby-element-for-wideentry-format.md) element specifies the objects that are displayed by a specific definition. This element is optional and is needed only when you define multiple [WideEntry](./wideentry-element-for-widecontrol-format.md) elements that display different objects.

- The [WideItem](./wideitem-element-for-widecontrol-format.md) element specifies the data that is displayed by the view. In contrast to other types of views, a wide control can display only one item.

- The [PropertyName](./propertyname-element-for-wideitem-for-widecontrol-format.md) element specifies the property whose value is displayed by the view. You must specify either a property or a script, but you cannot specify both.

- The [ScriptBlock](./scriptblock-element-for-wideitem-for-widecontrol-format.md) element specifies the script whose value is displayed by the view. You must specify either a script or a property, but you cannot specify both.

- The [FormatString](./formatstring-element-for-wideitem-for-widecontrol-format.md) element specifies a pattern that is used to display the data. This element is optional.

For an example of a complete formatting file that defines a wide view definition, see [Wide View (Basic)](./wide-view-basic.md).

## Defining the Objects That Use the Wide View

There are two ways to define which .NET objects use the wide view. You can use the [ViewSelectedBy](./viewselectedby-element-format.md) element to define the objects that can be displayed by all the definitions of the view, or you can use the [EntrySelectedBy](./entryselectedby-element-for-wideentry-format.md) element to define which objects are displayed by a specific definition of the view. In most cases, a view has only one definition, so objects are typically defined by the [ViewSelectedBy](./viewselectedby-element-format.md) element.

The following example shows how to define the objects that are displayed by the wide view using the [ViewSelectedBy](./viewselectedby-element-format.md) and [TypeName](./typename-element-for-viewselectedby-format.md) elements. There is no limit to the number of [TypeName](./typename-element-for-viewselectedby-format.md) elements that you can specify, and their order is not significant.

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

- The [ViewSelectedBy](./viewselectedby-element-format.md) element defines which objects are displayed by the wide view.

- The [TypeName](./typename-element-for-viewselectedby-format.md) element specifies the .NET that is displayed by the view. The fully qualified .NET type name is required. You must specify at least one type or selection set for the view, but there is no maximum number of elements that can be specified.

For an example of a complete formatting file, see [Wide View (Basic)](./wide-view-basic.md).

The following example uses the [ViewSelectedBy](./viewselectedby-element-format.md) and [SelectionSetName](./selectionsetname-element-for-viewselectedby-format.md) elements. Use selection sets where you have a related set of objects that are displayed using multiple views, such as when you define a wide view and a table view for the same objects. For more information about how to create a selection set, see [Defining Selection Sets](./defining-selection-sets.md).

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

- The [ViewSelectedBy](./viewselectedby-element-format.md) element defines which objects are displayed by the wide view.

- The [SelectionSetName](./selectionsetname-element-for-viewselectedby-format.md) element specifies a set of objects that can be displayed by the view. You must specify at least one selection set or type for the view, but there is no maximum number of elements that can be specified.

The following example shows how to define the objects displayed by a specific definition of the wide view using the [EntrySelectedBy](./entryselectedby-element-for-wideentry-format.md) element. Using this element, you can specify the .NET type name of the object, a selection set of objects, or a selection condition that specifies when the definition is used. For more information about how to create a selection conditions, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

```xml
<WideEntry>
  <EntrySelectedBy>
    <TypeName>.NET Type</TypeName>
  </EntrySelectedBy>
</WideEntry>
```

The following XML elements can be used to specify the objects that are used by a specific definition of the wide view:

- The [EntrySelectedBy](./entryselectedby-element-for-wideentry-format.md) element defines which objects are displayed by the definition.

- The [TypeName](./typename-element-for-viewselectedby-format.md) element specifies the .NET that is displayed by the definition. When using this element the fully qualified .NET type name is required. You must specify at least one type, selection set, or selection condition for the definition, but there is no maximum number of elements that can be specified.

- The [SelectionSetName](./selectionsetname-element-for-viewselectedby-format.md) element (not shown) specifies a set of objects that can be displayed by this definition. You must specify at least one type, selection set, or selection condition for the definition, but there is no maximum number of elements that can be specified.

- The [SelectionCondition](./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md) element (not shown) specifies a condition that must exist for this definition to be used. You must specify at least one type, selection set, or selection condition for the definition, but there is no maximum number of elements that can be specified. For more information about defining selection conditions, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## Displaying Groups of objects in a Wide View

You can separate the objects that are displayed by the wide view into groups. This does not mean that you define a group, only that Windows PowerShell starts a new group whenever the value of a specific property or script changes. In the following example, a new group is started whenever the value of the [System.Serviceprocess.Servicecontroller.Servicetype](/dotnet/api/System.ServiceProcess.ServiceController.ServiceType) property changes.

```xml
<GroupBy>
  <Label>Service Type</Label>
  <PropertyName>ServiceType</PropertyName>
</GroupBy>

```

The following XML elements are used to define when a group is started:

- The [GroupBy](./groupby-element-for-view-format.md) element defines the property or script that starts the new group and defines how the group is displayed.

- The [PropertyName](./propertyname-element-for-groupby-format.md) element specifies the property that starts a new group whenever its value changes. You must specify a property or script to start the group, but you cannot specify both.

- The [ScriptBlock](./scriptblock-element-for-groupby-format.md) element specifies the script that starts a new group whenever its value changes. You must specify a script or property to start the group, but you cannot specify both.

- The [Label](./label-element-for-groupby-format.md) element defines a label that is displayed at the beginning of each group. In addition to the text specified by this element, Windows PowerShell displays the value that triggered the new group and adds a blank line before and after the label. This element is optional.

- The [CustomControl](./customcontrol-element-for-groupby-format.md) element defines a control that is used to display the data. This element is optional.

- The [CustomControlName](./customcontrolname-element-for-groupby-format.md) element specifies a common or view control that is used to display the data. This element is optional.

For an example of a complete formatting file that defines groups, see [Wide View (GroupBy)](./wide-view-groupby.md).

## Using Format Strings

Formatting strings can be added to a wide view to further define how the data is displayed. The following example shows how to define a formatting string for the value of the `StartTime` property.

```xml
<WideItem>
  <PropertyName>StartTime</PropertyName>
  <FormatString>{0:MMM} (0:DD) (0:HH):(0:MM)</FormatString>
</WideItem>
```

The following XML elements can be used to specify a format pattern:

- The [WideItem](./wideitem-element-for-widecontrol-format.md) element specifies the data that is displayed by the view.

- The [PropertyName](./propertyname-element-for-wideitem-for-widecontrol-format.md) element specifies the property whose value is displayed by the view. You must specify either a property or a script, but you cannot specify both.

- The [FormatString](./formatstring-element-for-wideitem-for-widecontrol-format.md) element specifies a format pattern that defines how the property or script value is displayed in the view

- The [ScriptBlock](./scriptblock-element-for-wideitem-for-widecontrol-format.md) element (not shown) specifies the script whose value is displayed by the view. You must specify either a script or a property, but you cannot specify both.

In the following example, the `ToString` method is called to format the value of the script. Scripts can call any method of an object. Therefore, if an object has a method, such as `ToString`, that has formatting parameters, the script can call that method to format the output value of the script.

```xml
<WideItem>
  <ScriptBlock>
    [String}::Format("(0,10) (1,8)", .LastWriteTime.ToString("d"),
    $_.LastWriteTime.Totring("t"))
  </ScriptBlock>
</WideItem>
```

The following XML element can be used to calling the `ToString` method:

- The [WideItem](./wideitem-element-for-widecontrol-format.md) element specifies the data that is displayed by the view.

- The [ScriptBlock](./scriptblock-element-for-wideitem-for-widecontrol-format.md) element (not shown) specifies the script whose value is displayed by the view. You must specify either a script or a property, but you cannot specify both.

## See Also

[Wide View (Basic)](./wide-view-basic.md)

[Wide View (GroupBy)](./wide-view-groupby.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
