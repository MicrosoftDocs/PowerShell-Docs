---
ms.date: 09/13/2016
ms.topic: reference
title: Wide View (Basic)
description: Wide View (Basic)
---
# Wide View (Basic)

This example shows how to implement a basic wide view that displays the [System.Serviceprocess.Servicecontroller?Displayproperty=Fullname](/dotnet/api/System.ServiceProcess.ServiceController) objects returned by the `Get-Service` cmdlet. For more information about the components of a wide view, see [Creating a Wide View](./creating-a-wide-view.md).

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

- The [WideItem](./wideitem-element-for-widecontrol-format.md) element that defines what property is displayed by the view.

## Example

The following XML defines a wide view that displays the value of the [System.Serviceprocess.Servicecontroller.Servicename](/dotnet/api/System.ServiceProcess.ServiceController.ServiceName) property.

```xml
<?xml version="1.0" encoding="utf-8" ?>

<Configuration>
  <ViewDefinitions>
    <View>
      <Name>ServiceWideView</Name>
      <ViewSelectedBy>
        <TypeName>System.ServiceProcess.ServiceController</TypeName>
      </ViewSelectedBy>
      <WideControl>
        <WideEntries>
          <WideEntry>
            <WideItem>
              <PropertyName>ServiceName</PropertyName>
            </WideItem>
          </WideEntry>
        </WideEntries>
      </WideControl>
    </View>
  </ViewDefinitions>
</Configuration>
```

The following example shows how Windows PowerShell displays the [System.Serviceprocess.Servicecontroller?Displayproperty=Fullname](/dotnet/api/System.ServiceProcess.ServiceController) objects after this format file is loaded.

```powershell
Get-Service f*
```

```output
Fax                      FCSAM
fdPHost                  FDResPub
FontCache                FontCache3.0.0.0
FSysAgent                FwcAgent
```

## See Also

[Examples of Formatting Files](./examples-of-formatting-files.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
