---
title: "Creating a Management OData Web Service | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 06b1b050-0bf7-48f5-ba05-43f489d597c0
caps.latest.revision: 10
---
# Creating a Management OData Web Service

Management ODATA IIS Extension is an infrastructure for creating an ASP.NET web service end point that exposes your management data, accessed through Windows PowerShell cmdlets and scripts, as OData Web service entities. It does that by processing OData requests and converting them into a Windows PowerShell invocation. Product teams can build on top of this infrastructure to create endpoints that expose specific sets of management data.

Download and install the [PswsRoleBasedPlugins](https://code.msdn.microsoft.com:443/windowsdesktop/PswsRoleBasedPlugins-9c79b75a) sample. Follow the instructions to deploy the web service. This web service exposes Services and Processes through Create, Read, Update, and Delete (CRUD) operations. CRUD requests made to the web service invoke  Windows PowerShell commands that perform the requested operations. A mapping between the CRUD operations and the underlying Windows PowerShell commands is implemented by two schema files, schema.mof and schema.xml. The schema.mof file uses the [Distributed Management  Task Force](https://www.dmtf.org/) (DMTF) Managed Object (MOF) standard. The schema.xml file uses an XML schema that is described in [Resource Mapping Schema](./resource-mapping-schema.md).

> [!IMPORTANT]
> Before you enabling Management ODATA IIS Extension on Windows Server 2008 R2 SP1, the following features must be enabled.
>
> 1. IIS-WebServerRole
> 2. IIS-WebServer
> 3. IIS-HttpTracing
> 4. IIS-ManagementOData

## Steps for creating a Management OData web service

The following topics describe how to create and deploy a Management OData web service.

- [Adding Resources to a Management OData Web Service](./adding-resources-to-a-management-odata-web-service.md)

- [Implementing Custom Authorization for a Management OData web service](./implementing-custom-authorization-for-a-management-odata-web-service.md)

- [Implementing SessionConfiguration for a Management OData web service](./implementing-sessionconfiguration-for-a-management-odata-web-service.md)

- [Authoring the MOF schema file for a Management OData web service](./authoring-the-mof-schema-file-for-a-management-odata-web-service.md)

- [Authoring the XML schema file for a Management OData web service](./authoring-the-xml-schema-file-for-a-management-odata-web-service.md)

- [Authoring the Web.config file for a Management OData web service](./authoring-the-web-config-file-for-a-management-odata-web-service.md)

- [Deploying a Management OData web service](./deploying-a-management-odata-web-service.md)

- [Associating Management OData Entities](./associating-management-odata-entities.md)

## See Also

[Management ODATA IIS Extension Schema Files](./management-odata-iis-extension-schema-files.md)
