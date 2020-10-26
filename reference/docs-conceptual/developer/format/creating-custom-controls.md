---
ms.date: 09/13/2016
ms.topic: reference
title: Creating Custom Controls
description: Creating Custom Controls
---
# Creating Custom Controls

Custom controls are the most flexible components of a formatting file. Unlike table, list, and wide views that define a formal structure of data, such as a table of data, custom controls allow you to define how an individual piece of data is displayed. You can define a common set of custom controls that are available to all the views of the formatting file, you can define custom controls that are available to a specific view, or you can define a set of controls that are available to a group of objects.

## Custom Control Example

The following example shows a custom control that is defined in the Certificates.Format.ps1xml file. This custom control is used to separate the [System.Management.Automation.Signature](/dotnet/api/System.Management.Automation.Signature) objects displayed in a table view.

```xml
<Controls>
  <Control>
    <Name>SignatureTypes-GroupingFormat</Name>
    <CustomControl>
      <CustomEntries>
        <CustomEntry>
          <CustomItem>
            <Frame>
              <LeftIndent>4</LeftIndent>
              <CustomItem>
                <Text AssemblyName="System.Management.Automation" BaseName="FileSystemProviderStrings"
                  ResourceId="DirectoryDisplayGrouping"/>
                <ExpressionBinding>
                  <ScriptBlock>split-path $_.Path</ScriptBlock>
                </ExpressionBinding>
                <NewLine/>
              </CustomItem>
            </Frame>
          </CustomItem>
        </CustomEntry>
      </CustomEntries>
    </CustomControl>
  </Control>
</Controls>

```

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
