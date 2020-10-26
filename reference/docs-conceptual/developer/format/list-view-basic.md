---
ms.date: 09/13/2016
ms.topic: reference
title: List View (Basic)
description: List View (Basic)
---
# List View (Basic)

This example shows how to implement a basic list view that displays the [System.Serviceprocess.Servicecontroller?Displayproperty=Fullname](/dotnet/api/System.ServiceProcess.ServiceController) objects returned by the [Get-Service](/powershell/module/microsoft.powershell.management/get-service) cmdlet. For more information about the components of a list view, see [Creating a List View](./creating-a-list-view.md).

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

- The [ListControl](./listcontrol-element-format.md) element that defines what property is displayed by the view.

- The [ListItem](./listitem-element-for-listitems-for-listcontrol-format.md) element that defines what is displayed in a row of the list view.

- The [PropertyName](./propertyname-element-for-listitem-for-listcontrol-format.md) element that defines which property is displayed.

## Example

The following XML defines a list view that displays four properties of the [System.Serviceprocess.Servicecontroller?Displayproperty=Fullname](/dotnet/api/System.ServiceProcess.ServiceController) object. In each row, the name of the property is displayed followed by the value of the property.

```xml
<Configuration>
  <View>
    <Name>System.ServiceProcess.ServiceController</Name>
    <ViewSelectedBy>
      <TypeName>System.ServiceProcess.ServiceController</TypeName>
    </ViewSelectedBy>
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
              <PropertyName>Status</PropertyName>
            </ListItem>
            <ListItem>
              <PropertyName>ServiceType</PropertyName>
            </ListItem>
          </ListItems>
        </ListEntry>
      </ListEntries>
    </ListControl>
  </View>
</Configuration>
```

The following example shows how Windows PowerShell displays the [System.Serviceprocess.Servicecontroller?Displayproperty=Fullname](/dotnet/api/System.ServiceProcess.ServiceController) objects after this format file is loaded.

```powershell
Get-Service f*
```

```output
Name        : Fax
DisplayName : Fax
Status      : Stopped
ServiceType : Win32OwnProcess

Name        : FCSAM
DisplayName : Microsoft Antimalware Service
Status      : Running
ServiceType : Win32OwnProcess

Name        : fdPHost
DisplayName : Function Discovery Provider Host
Status      : Stopped
ServiceType : Win32ShareProcess

Name        : FDResPub
DisplayName : Function Discovery Resource Publication
Status      : Running
ServiceType : Win32ShareProcess

Name        : FontCache
DisplayName : Windows Font Cache Service
Status      : Running
ServiceType : Win32ShareProcess

Name        : FontCache3.0.0.0
DisplayName : Windows Presentation Foundation Font Cache 3.0.0.0
Status      : Stopped
ServiceType : Win32OwnProcess

Name        : FSysAgent
DisplayName : Microsoft Forefront System Agent
Status      : Running
ServiceType : Win32OwnProcess

Name        : FwcAgent
DisplayName : Firewall Client Agent
Status      : Running
ServiceType : Win32OwnProcess
```

## See Also

[Examples of Formatting Files](./examples-of-formatting-files.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
