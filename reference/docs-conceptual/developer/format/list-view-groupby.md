---
ms.date: 09/13/2016
ms.topic: reference
title: List View (GroupBy)
description: List View (GroupBy)
---
# List View (GroupBy)

This example shows how to implement a list view that separates the rows of the list into groups. This list view displays the properties of the [System.Serviceprocess.Servicecontroller?Displayproperty=Fullname](/dotnet/api/System.ServiceProcess.ServiceController) objects returned by the [Get-Service](/powershell/module/Microsoft.PowerShell.Management/Get-Service) cmdlet. For more information about the components of a list view, see [Creating a List View](./creating-a-list-view.md).

### To load this formatting file

1. Copy the XML from the Example section of this topic into a text file.

2. Save the text file. Be sure to add the `format.ps1xml` extension to the file to identify it as a formatting file.

3. Open Windows PowerShell, and run the following command to load the formatting file into the current session: `Update-formatdata -prependpath PathToFormattingFile`.

   > [!WARNING]
   > This formatting file defines the display of an object that is already defined by a Windows PowerShell formatting file. You must use the `prependPath` parameter when you run the cmdlet, and you cannot load this formatting file as a module.

## Demonstrates

This formatting file demonstrates the following XML elements:

- The [Name](./name-element-for-view-format.md) element for the view.

- The [ViewSelectedBy](./viewselectedby-element-format.md) element that defines what objects are displayed by the view.

- The [GroupBy](./viewselectedby-element-format.md) element that defines how a new group of objects is displayed.

- The [ListControl](./listcontrol-element-format.md) element that defines what property is displayed by the view.

- The [ListItem](./listitem-element-for-listitems-for-listcontrol-format.md) element that defines what is displayed in a row of the list view.

- The [PropertyName](./propertyname-element-for-listitem-for-listcontrol-format.md) element that defines which property is displayed.

## Example

The following XML defines a list view that starts a new group whenever the value of the [System.Serviceprocess.Servicecontroller.Status](/dotnet/api/System.ServiceProcess.ServiceController.Status) property changes. When each group is started, a custom label is displayed that includes the new value of the property.

```xml
<Configuration>
  <ViewDefinitions>
    <View>
      <Name>System.ServiceProcess.ServiceController</Name>
      <ViewSelectedBy>
        <TypeName>System.ServiceProcess.ServiceController</TypeName>
      </ViewSelectedBy>
      <GroupBy>
        <PropertyName>Status</PropertyName>
        <Label>New Service Status</Label>
      </GroupBy>
      <ListControl>
        <ListEntries>
          <ListEntry>
            <ListItems>
              <ListItem>
                <PropertyName>Name</PropertyName>
              </ListItem>
              <ListItem>
                <PropertyName>DisplayName</PropertyName>
              </ListItem>
              <ListItem>
                <PropertyName>ServiceType</PropertyName>
              </ListItem>
            </ListItems>
          </ListEntry>
        </ListEntries>
      </ListControl>
    </View>
  </ViewDefinitions>
</Configuration>
```

The following example shows how Windows PowerShell displays the [System.Serviceprocess.Servicecontroller?Displayproperty=Fullname](/dotnet/api/System.ServiceProcess.ServiceController) objects after this format file is loaded. The blank lines added before and after the group label are automatically added by Windows PowerShell.

```powershell
Get-Service f*
```

```output
   New Service Status: Stopped

Name        : Fax
DisplayName : Fax
ServiceType : Win32OwnProcess

   New Service Status: Running

Name        : FCSAM
DisplayName : Microsoft Antimalware Service
ServiceType : Win32OwnProcess

   New Service Status: Stopped

Name        : fdPHost
DisplayName : Function Discovery Provider Host
ServiceType : Win32ShareProcess

   New Service Status: Running

Name        : FDResPub
DisplayName : Function Discovery Resource Publication
ServiceType : Win32ShareProcess

Name        : FontCache
DisplayName : Windows Font Cache Service
ServiceType : Win32ShareProcess

   New Service Status: Stopped

Name        : FontCache3.0.0.0
DisplayName : Windows Presentation Foundation Font Cache 3.0.0.0
ServiceType : Win32OwnProcess

   New Service Status: Running

Name        : FSysAgent
DisplayName : Microsoft Forefront System Agent
ServiceType : Win32OwnProcess

Name        : FwcAgent
DisplayName : Firewall Client Agent
ServiceType : Win32OwnProcess
```

## See Also

[Examples of Formatting Files](./examples-of-formatting-files.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
