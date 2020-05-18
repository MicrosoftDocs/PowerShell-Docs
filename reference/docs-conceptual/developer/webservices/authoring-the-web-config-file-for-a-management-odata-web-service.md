---
title: "Authoring the Web.config file for a Management OData web service | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: d569f5d5-9746-40c0-be5e-f218bc4560f7
caps.latest.revision: 4
---
# Authoring the Web.config file for a Management OData web service

Before you can deploy your Management OData web service, you must configure the web.config file to
point to the XML schema files and the DLLs that implement the
[Microsoft.Management.Odata.Customauthorization](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization)
and
[System.Management.Automation.Remoting.Pssessionconfiguration](/dotnet/api/System.Management.Automation.Remoting.PSSessionConfiguration)
interfaces.

## Sample config file

The following is an example of what the web.config file for your web service looks like.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <configSections>
      <section name="managementOdata" type="Microsoft.Management.Odata.Core.DSConfiguration, Microsoft.Management.OData, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35, processorArchitecture=MSIL" />
   </configSections>
   <managementOdata schemaFileName="Schema.mof" resourceMappingFileName="Schema.xml">
      <customAuthorization type="Microsoft.Samples.Management.OData.RoleBasedPlugins.CustomAuthorization" assembly=".\Microsoft.Samples.Management.OData.RoleBasedPlugins.dll" />
      <powershell>
         <sessionConfiguration type="Microsoft.Samples.Management.OData.RoleBasedPlugins.SessionConfiguration" assembly=".\Microsoft.Samples.Management.OData.RoleBasedPlugins.dll" />
      </powershell>
      <commandInvocation enabled="true" />
      <wcfDataServicesConfig>
      </wcfDataServicesConfig>
   </managementOdata>
   <system.serviceModel>
      <behaviors>
         <serviceBehaviors>
            <behavior>
                  <serviceAuthorization serviceAuthorizationManagerType="Microsoft.Management.Odata.Core.CustomAuthorizationManager, Microsoft.Management.OData, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" />
            </behavior>
         </serviceBehaviors>
      </behaviors>
      <serviceHostingEnvironment aspNetCompatibilityEnabled="true" />
   </system.serviceModel>
   <system.webServer>
      <security>
         <authentication>
            <anonymousAuthentication enabled="false" />
            <basicAuthentication enabled="true" />
            <windowsAuthentication enabled="false" />
         </authentication>
      </security>
  </system.webServer>
</configuration>

```

## See Also

[Implementing Custom Authorization for a Management OData web service](./implementing-custom-authorization-for-a-management-odata-web-service.md)

[Implementing SessionConfiguration for a Management OData web service](./implementing-sessionconfiguration-for-a-management-odata-web-service.md)

[Authoring the MOF schema file for a Management OData web service](./authoring-the-mof-schema-file-for-a-management-odata-web-service.md)

[Authoring the XML schema file for a Management OData web service](./authoring-the-xml-schema-file-for-a-management-odata-web-service.md)

[Creating a Management OData Web Service](./creating-a-management-odata-web-service.md)
