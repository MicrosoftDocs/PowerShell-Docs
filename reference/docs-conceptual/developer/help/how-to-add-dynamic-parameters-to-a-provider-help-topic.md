---
ms.date: 09/13/2016
ms.topic: reference
title: How to Add Dynamic Parameters to a Provider Help Topic
description: How to Add Dynamic Parameters to a Provider Help Topic
---
# How to Add Dynamic Parameters to a Provider Help Topic

This section explains how to populate the **DYNAMIC PARAMETERS** section of a provider help topic.

*Dynamic parameters* are parameters of a cmdlet or function that are available only under specified
conditions.

The dynamic parameters that are documented in a provider help topic are the dynamic parameters that
the provider adds to the cmdlet or function when the cmdlet or function is used in the provider
drive.

Dynamic parameters can also be documented in custom cmdlet help for a provider. When writing both
provider help and custom cmdlet help for a provider, include the dynamic parameter documentation in
both documents.

If a provider does not implement any dynamic parameters, the provider help topic contains an empty
`DynamicParameters` element.

### To Add Dynamic Parameters

1. In the `<AssemblyName>.dll-help.xml` file, within the `providerHelp` element, add a
   `DynamicParameters` element. The `DynamicParameters` element should appear after the `Tasks`
   element and before the `RelatedLinks` element.

   For example:

    ```xml
    <providerHelp>
        <Tasks>
        </Tasks>
        <DynamicParameters>
        </DynamicParameters>
        <RelatedLinks>
        </RelatedLinks>
    </providerHelp>
    ```

   If the provider does not implement any dynamic parameters, the `DynamicParameters` element can be
   empty.

1. Within the `DynamicParameters` element, for each dynamic parameter, add a `DynamicParameter`
   element.

   For example:

    ```xml
    <DynamicParameters/>
        <DynamicParameter>
        </DynamicParameter>
    </DynamicParameters>
    ```

1. In each `DynamicParameter` element, add a `Name` and `CmdletSupported` element.

   - Name - Specifies the parameter name
   - CmdletSupported - Specifies the cmdlets in which the parameter is valid. Type a comma-separated
     list of cmdlet names.

   For example, the following XML documents the `Encoding` dynamic parameter that the Windows
   PowerShell FileSystem provider adds to the `Add-Content`, `Get-Content`, `Set-Content` cmdlets.

    ```xml
    <DynamicParameters/>
        <DynamicParameter>
            <Name> Encoding </Name>
            <CmdletSupported> Add-Content, Get-Content, Set-Content </CmdletSupported>
    </DynamicParameters>

    ```

1. In each `DynamicParameter` element, add a `Type` element. The `Type` element is a container for
   the `Name` element which contains the .NET type of the value of the dynamic parameter.

   For example, the following XML shows that the .NET type of the `Encoding` dynamic parameter is
   the [FileSystemCmdletProviderEncoding](/dotnet/api/microsoft.powershell.commands.filesystemcmdletproviderencoding)
   enumeration.

    ```xml
    <DynamicParameters/>
        <DynamicParameter>
            <Name> Encoding </Name>
            <CmdletSupported> Add-Content, Get-Content, Set-Content </CmdletSupported>
            <Type>
                <Name> Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding </Name>
            <Type>
    ...
    </DynamicParameters>
    ```

1. Add the `Description` element, which contains a brief description of the dynamic parameter. When
   composing the description, use the guidelines prescribed for all cmdlet parameters in
   [How to Add Parameter Information](./how-to-add-parameter-information.md).

   For example, the following XML includes the description of the `Encoding` dynamic parameter.

    ```xml
    <DynamicParameters/>
        <DynamicParameter>
            <Name> Encoding </Name>
            <CmdletSupported> Add-Content, Get-Content, Set-Content </CmdletSupported>
            <Type>
                <Name> Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding </Name>
            <Type>
            <Description> Specifies the encoding of the output file that contains the content. </Description>
    ...
    </DynamicParameters>
    ```

1. Add the `PossibleValues` element and its child elements. Together, these elements describe the
   values of the dynamic parameter. This element is designed for enumerated values. If the dynamic
   parameter does not take a value, such as is the case with a switch parameter, or the values
   cannot be enumerated, add an empty `PossibleValues` element.

   The following table lists and describes the `PossibleValues` element and its child elements.

   - PossibleValues - This element is a container. Its child elements are described below. Add one
     `PossibleValues` element to each provider help topic. The element can be empty.
   - PossibleValue - This element is a container. Its child elements are described below. Add one
     `PossibleValue` element for each value of the dynamic parameter.
   - Value - Specifies the value name.
   - Description - This element contains a `Para` element. The text in the `Para` element describes
     the value that is named in the `Value` element.

   For example, the following XML shows one `PossibleValue` element of the `Encoding` dynamic
   parameter.

    ```xml
    <DynamicParameters/>
        <DynamicParameter>
    ...
            <Description> Specifies the encoding of the output file that contains the content. </Description>
            <PossibleValues>
                <PossibleValue>
                    <Value> ASCII </Value>
                    <Description>
                        <para> Uses the encoding for the ASCII (7-bit) character set. </para>
                    </Description>
                </PossibleValue>
    ...
            </PossibleValues>
    </DynamicParameters>
    ```

## Example

The following example shows the `DynamicParameters` element of the `Encoding` dynamic parameter.

```xml
<DynamicParameters/>
    <DynamicParameter>
        <Name> Encoding </Name>
        <CmdletSupported> Add-Content, Get-Content, Set-Content </CmdletSupported>
        <Type>
            <Name> Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding </Name>
        <Type>
        <Description> Specifies the encoding of the output file that contains the content. </Description>
        <PossibleValues>
            <PossibleValue>
                <Value> ASCII </Value>
                <Description>
                    <para> Uses the encoding for the ASCII (7-bit) character set. </para>
                </Description>
            </PossibleValue>
            <PossibleValue>
                <Value> Unicode </Value>
                <Description>
                    <para> Encodes in UTF-16 format using the little-endian byte order. </para>
                </Description>
            </PossibleValue>
        </PossibleValues>
</DynamicParameters>
```
