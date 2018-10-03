---
title: "Configuration Element (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: d46df0cb-50b7-4b81-82ba-37186a7b7a7f
caps.latest.revision: 28
---
# Configuration Element (Format)

Represents the top-level element of a formatting file.

Configuration Element

## Syntax

```xml
<Configuration>
  <DefaultSettings>...</DefaultSettings>
  <SelectionSets>...</SelectionSets>
  <Controls>...</Controls>
  <ViewDefinitions>...</ViewDefinitions>
</Configuration>

```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `Configuration` element. This element must be the root element for each formatting file, and this element must contain at least one child element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[Controls Element for Configuration (Format)](./controls-element-for-configuration-format.md)|Optional element.<br /><br /> Defines the common controls that can be used by all views of the formatting file.|
|[DefaultSettings Element (Format)](./defaultsettings-element-format.md)|Optional element.<br /><br /> Defines common settings that apply to all the views of the formatting file.|
|[SelectionSets Element Format](./selectionsets-element-format.md)|Optional element.<br /><br /> Defines the common sets of .NET objects that can be used by all views of the formatting file.|
|[ViewDefinitions Element (Format)](./viewdefinitions-element-format.md)|Optional element.<br /><br /> Defines the views used to display objects.|

### Parent Elements

None.

## Remarks

Formatting files define how objects are displayed. In most cases, this root element contains a [ViewDefinitions](./viewdefinitions-element-format.md) element that defines the table, list, and wide views of the formatting file. In addition to the view definitions, the formatting file can define common selection sets, settings, and controls that those views can use.

## See Also

[Controls Element for Configuration (Format)](./controls-element-for-configuration-format.md)

[DefaultSettings Element (Format)](./defaultsettings-element-format.md)

[SelectionSets Element (Format)](./selectionsets-element-format.md)

[ViewDefinitions Element (Format)](./viewdefinitions-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
