---
ms.date: 09/12/2016
ms.topic: reference
title: HelpInfo XML Schema
description: HelpInfo XML Schema
---
# HelpInfo XML Schema

This topic contains the XML schema for Updatable Help Information files, commonly known as "HelpInfo
XML files."

## HelpInfo XML Schema

HelpInfo XML files are based on the following XML schema.

```xml
<?xml version="1.0" encoding="utf-8"?>
<schema targetNamespace="http://schemas.microsoft.com/powershell/help/2010/05" xmlns="http://www.w3.org/2001/XMLSchema">
  <element name="HelpInfo">
    <complexType>
      <sequence>
        <element name="HelpContentURI" type="anyURI" minOccurs="1" maxOccurs="1" />
        <element name="SupportedUICultures" minOccurs="1" maxOccurs="1">
          <complexType>
            <sequence>
              <element name="UICulture" minOccurs="1" maxOccurs="unbounded">
                <complexType>
                  <sequence>
                    <element name="UICultureName" type="language" minOccurs="1" maxOccurs="1" />
                    <element name="UICultureVersion" type="string" minOccurs="1" maxOccurs="1" />
                  </sequence>
                </complexType>
              </element>
            </sequence>
          </complexType>
        </element>
      </sequence>
    </complexType>
  </element>
</schema>
```

## HelpInfo XML Elements

The HelpInfo XML file includes the following elements.

- **HelpContentURI** - Contains the URI of the location of the help CAB files for the module. The
  URI must begin with "http" or "https". The URI should specify an internet location, but must not
  include the CAB filename. The **HelpContentURI** value can be the same or different from the
  **HelpInfoURI** value.

- **SupportedUICultures** - Represents the module help files in all UI cultures. Contains
  **UICulture** elements, each of which represents a set of help files for the module in a specified
  UI culture.

- **UICulture** - Represents a set of help files for the module in a specified UI culture. Add a
  **UICulture** element for each UI culture in which the help files are written.

- **UICultureName** - Contains the language code for the UI culture in which the help files are
  written.

- **UICultureVersion** - Contains a 4-part version number in "N1.N2.N3.N4" format that represents
  the version of the help CAB file in the UI culture. Increment this version number whenever you
  upload new help CAB files in the UI culture that is specified by **UICultureName**. For more
  information about this value, see [Version Class](/dotnet/api/system.version).
