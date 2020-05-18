---
title: "Adding Resources to a Management OData Web Service | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: e620bf6d-76be-47b0-a7a8-f43418f30c60
caps.latest.revision: 6
---
# Adding Resources to a Management OData Web Service

This example demonstrates how to add a resource to an existing Management OData web service by using the Management OData Schema Designer. The [PswsRoleBasedPlugins](https://code.msdn.microsoft.com:443/windowsdesktop/PswsRoleBasedPlugins-9c79b75a) sample creates a web service that exposes the Process and Server resources. In this example, you will add a Virtual Machine (VM) resource to the web service.

## Prerequisites

This topic assumes that you have downloaded and installed the [PswsRoleBasedPlugins](https://code.msdn.microsoft.com:443/windowsdesktop/PswsRoleBasedPlugins-9c79b75a) sample as described in [Creating a Windows PowerShell Web Service](./creating-a-management-odata-web-service.md), and that you have downloaded and installed the [Management OData Schema Designer](https://marketplace.visualstudio.com/items?itemName=jlisc0.ManagementODataSchemaDesigner). This topic also assumes that you have the Hyper-V Windows PowerShell module installed on the computer where you set up the Management Odata endpoint.

## Adding VM as a Resource to the Web Service

The first step is to import the schema from the existing Management OData endpoint into the schema designer. The following procedure describes how to do that.

#### Importing an existing schema into the schema designer

1. Open the Management OData Schema Designer.

2. From the **File** menu, select **File** ; **New** ; **File**. The **New File** dialog appears.

3. Click **Management OData Model**, and then click **Open**.

4. Right-click in the main window, and click **Schema file** ; **Import**. The **Open** dialog appears.

5. Navigate to the folder where you set up the Management OData web service for the [PswsRoleBasedPlugins](https://code.msdn.microsoft.com:443/windowsdesktop/PswsRoleBasedPlugins-9c79b75a) sample. If you used the Windows PowerShell script provided with that sample to set up the endpoint without modifying the script, that folder is **C:\inetpub\wwwroot\Modata**. Select Schema.mof, and click **Open**.

   At this point, open the Schema.mof and Schema.xml files in a text editor, and notice that they contain mappings for the Process and Service resources. The Schema.mof file uses [Distributed Management  Task Force](https://www.dmtf.org/) (DTMF) Managed Object (MOF) standard. The schema.xml file uses an XML schema that is described in [Resource Mapping Schema](./resource-mapping-schema.md).

   The following procedure describes how to import Hyper-V cmdlets in to the schema model.

#### Importing cmdlets into the schema

1. Right-click on a blank area of the schema designer window, and click **Import Cmdlets**. The **Cmdlet Import Wizard** dialog appears.

2. Make sure **Local Computer** is selected, and click **Next**.

3. Make sure that Installed Windows PowerShell Modules is selected, and select Hyper-V from the drop-down list. click **Next**. Click **Next**.

4. In the **Cmdlet Noun** list, select **VM**. Click **Next**

5. For this example, we will bind only the Get and Delete commands with cmdlets. Clear the **CREATE** and **UPDATE** checkboxes, and make sure the **GET** and **DELETE** checkboxes are checked. Make sure that the `Get-VM` cmdlet is selected for **GET**, and the `Remove-VM` cmdlet is selected for **DELETE**.

6. Because the metadata for the VM cmdlets does not specify an output type, you will need to run the cmdlet to specify the output type. Select **Provide output type** and click **Run cmdlet**. The **Run Cmdlet** dialog appears. Click **Run**. The **CLR Type** box is populated with the `VirtualMachine` type. Click **OK**, then click **Next**.

7. By default, all of the properties of the VirtualMachine object are selected. You can clear any properties that you do not want as part of the data returned when you request this resource from the web service. Click **Next**.

8. You must select at least one property to be used as a key. Select **Name** in the list, and click **Next**.

9. The next window allows you to map properties of the Management OData resource to properties of the underlying cmdlets. The wizard maps properties with identical names by default. For example, the `ComputerName` property of the resource is mapped to the `ComputerName` property of the cmdlets.  This allows you to specify the `ComputerName` property in a request to the web service, and have the value you specify be passed to the `Get-VM` cmdlet. `Id` and `Name` are also mapped by default.

   10. Click **Next**, then click **Finish**.

       The VM resource now appears in the schema designer window. You can examine the properties and operations associated with the resource. Next, you will export the updated schema files into the virtual directory for the web service.

#### Exporting schema files from the schema designer

1. Right-click on a blank area of the schema designer window, and click **Schema file** ; **Export**. The **Save As** dialog appears.

2. Navigate to the same directory from where you imported the MOF file. Name the file the same as the original MOF file (Schema.mof by default), and click **Save**. Confirm that you want to overwrite the existing file.

   Although it is not explicitly stated in the **Save As** dialog, this replaces both the Schema.mof and Schema.xml files.

## Next Steps

Before you access the new VM resource from the Management OData web service, you must update the RbacConfiguration.xml file to allow access to the Hyper-V Windows PowerShell module as described in [Configuring Role-based Authorization](./configuring-role-based-authorization.md), and you will also need to restart the web service.
