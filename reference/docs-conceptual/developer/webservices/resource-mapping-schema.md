---
title: "Resource Mapping Schema | Microsoft Docs"
ms.custom: ""
ms.date: "09/12/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: a7b2cc4d-292f-4714-888b-3b81536bef5d
caps.latest.revision: 7
---
# Resource Mapping Schema

Management OData IIS Extension uses XML files to define resource mapping. The following XSD defines the schema used for these files.

## Resource Mapping File XSD

The following XSD defines the schema for Management OData IIS Extension resource mapping files.

```xml
<?xml version="1.0" encoding="utf-8"?>
<xs:schema xmlns="https://schemas.microsoft.com/powershell-web-services/2010/09" targetNamespace="https://schemas.microsoft.com/powershell-web-services/2010/09" xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified">
  <xs:element name="ResourceMetadata">
    <xs:complexType>
      <xs:all>
        <xs:element name="SchemaNamespace" type="xs:string" />
        <xs:element name="ContainerName" type="xs:string" />
        <xs:element name="Resources">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="Resource" minOccurs="0" maxOccurs="unbounded">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element name="RelativeUrl" type="xs:string" />
                    <xs:element name="Class" type="xs:string" />
                  </xs:sequence>
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
        <xs:element name="ClassImplementations">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="Class" minOccurs="0" maxOccurs="unbounded">
                <xs:complexType>
                  <xs:all>
                    <xs:element name="Name" type="xs:string" />
                    <xs:element name="ClrType" type="xs:string" minOccurs="0" />
                    <xs:element name="CmdletImplementation" type="CmdletImplementationType" minOccurs="0" />
                    <xs:element name="RenamedFields" minOccurs="0">
                      <xs:complexType>
                        <xs:sequence>
                          <xs:element name="Field" minOccurs="0" maxOccurs="unbounded">
                            <xs:complexType>
                              <xs:all>
                                <xs:element name="SchemaProperty" type="xs:string" />
                                <xs:element name="PowerShellProperty" type="xs:string" />
                              </xs:all>
                            </xs:complexType>
                          </xs:element>
                        </xs:sequence>
                      </xs:complexType>
                    </xs:element>
                  </xs:all>
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:all>
    </xs:complexType>
  </xs:element>
  <xs:complexType name="CmdletImplementationType">
    <xs:all>
      <xs:element name="Query" minOccurs="0">
        <xs:complexType>
          <xs:all>
            <xs:element name="Cmdlet" type="xs:string" />
            <xs:element name="ImmutableParameters" type="ParameterValuesType" minOccurs="0" />
            <xs:element name="FieldParameterMap" type="FieldParameterMapType" minOccurs="0" />
            <xs:element name="Options" type="OptionsType" minOccurs="0" />
            <xs:element name="ParameterSets" type="ParameterSetsType" minOccurs="0" />
          </xs:all>
        </xs:complexType>
      </xs:element>
      <xs:element name="Create" minOccurs="0">
        <xs:complexType>
          <xs:all>
            <xs:element name="Cmdlet" type="xs:string" />
            <xs:element name="ImmutableParameters" type="ParameterValuesType" minOccurs="0" />
            <xs:element name="FieldParameterMap" type="FieldParameterMapType" minOccurs="0" />
            <xs:element name="Options" type="OptionsType" minOccurs="0" />
            <xs:element name="ParameterSets" type="ParameterSetsType" minOccurs="0" />
          </xs:all>
        </xs:complexType>
      </xs:element>
      <xs:element name="Update" minOccurs="0">
        <xs:complexType>
          <xs:all>
            <xs:element name="Cmdlet" type="xs:string" />
            <xs:element name="ImmutableParameters" type="ParameterValuesType" minOccurs="0" />
            <xs:element name="FieldParameterMap" type="FieldParameterMapType" minOccurs="0" />
            <xs:element name="Options" type="OptionsType" minOccurs="0" />
            <xs:element name="ParameterSets" type="ParameterSetsType" minOccurs="0" />
          </xs:all>
        </xs:complexType>
      </xs:element>
      <xs:element name="Delete" minOccurs="0">
        <xs:complexType>
          <xs:all>
            <xs:element name="Cmdlet" type="xs:string" />
            <xs:element name="ImmutableParameters" type="ParameterValuesType" minOccurs="0" />
            <xs:element name="FieldParameterMap" type="FieldParameterMapType" />
            <xs:element name="Options" type="OptionsType" minOccurs="0" />
            <xs:element name="ParameterSets" type="ParameterSetsType" minOccurs="0" />
          </xs:all>
        </xs:complexType>
      </xs:element>
      <xs:element name="Associations" minOccurs="0">
        <xs:complexType>
          <xs:sequence>
            <xs:element name="Field" type="AssociationFieldType" maxOccurs="unbounded" />
          </xs:sequence>
        </xs:complexType>
      </xs:element>
    </xs:all>
  </xs:complexType>
  <xs:complexType name="FieldParameterMapType">
    <xs:sequence>
      <xs:element name="Field" minOccurs="0" maxOccurs="unbounded">
        <xs:complexType>
          <xs:sequence>
            <xs:element name="FieldName" type="xs:string" />
            <xs:element name="ParameterName" type="xs:string" />
          </xs:sequence>
        </xs:complexType>
      </xs:element>
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="ParameterSetsType">
    <xs:sequence>
      <xs:element name="ParameterSet" minOccurs="0" maxOccurs="unbounded">
        <xs:complexType>
          <xs:sequence>
            <xs:element name="Name" type="xs:string" />
            <xs:element name="Parameter" maxOccurs="unbounded">
              <xs:complexType>
                <xs:all>
                  <xs:element name="Name" type="xs:string" />
                  <xs:element name="Type" type="xs:string" minOccurs="0" />
                  <xs:element name="IsSwitch" type="xs:string" minOccurs="0" />
                  <xs:element name="IsMandatory" type="xs:string" minOccurs="0" />
                </xs:all>
              </xs:complexType>
            </xs:element>
          </xs:sequence>
        </xs:complexType>
      </xs:element>
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="ParameterValuesType">
    <xs:sequence>
      <xs:element name="ParameterValue" minOccurs="0" maxOccurs="unbounded">
        <xs:complexType>
          <xs:all>
            <xs:element name="ParameterName" type="xs:string" />
            <xs:element name="Value" type="xs:string" />
          </xs:all>
        </xs:complexType>
      </xs:element>
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="OptionsType">
    <xs:sequence>
      <xs:element name="ParameterName" type="xs:string" minOccurs="0" maxOccurs="unbounded" />
    </xs:sequence>
  </xs:complexType>
  <xs:complexType name="AssociationFieldType">
    <xs:all>
      <xs:element name="Name" type="xs:string" />
      <xs:element name="GetReference" type="GetAssociationReferenceType" minOccurs="0" />
      <xs:element name="AddReference" type="AssociationReferenceType" />
      <xs:element name="RemoveReference" type="AssociationReferenceType" />
    </xs:all>
  </xs:complexType>
  <xs:complexType name="AssociationReferenceType">
    <xs:all>
      <xs:element name="Cmdlet" type="xs:string" />
      <xs:element name="ParameterForThisObject" type="xs:string" />
      <xs:element name="ParameterForReferredObject" type="xs:string" />
    </xs:all>
  </xs:complexType>
  <xs:complexType name="GetAssociationReferenceType">
    <xs:all>
      <xs:element name="Cmdlet" type="xs:string" />
      <xs:element name="ParameterForThisObject" type="xs:string" />
    </xs:all>
  </xs:complexType>
</xs:schema>
```
