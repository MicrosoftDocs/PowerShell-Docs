---
ms.date: 09/13/2016
ms.topic: reference
title: Frame Element for CustomItem for Controls for Configuration (Format)
description: Frame Element for CustomItem for Controls for Configuration (Format)
---
# Frame Element for CustomItem for Controls for Configuration (Format)

Defines how the data is displayed, such as shifting the data to the left or right. This element is used when defining a common control that can be used by all the views in the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)
Control Element for Controls for Configuration (Format)
CustomControl Element for Control for Configuration (Format)
CustomEntries Element for CustomControl for Configuration (Format)
CustomEntry Element for CustomControl for Controls for Configuration (Format)
CustomItem Element for CustomEntry for Controls for Configuration
Frame Element for CustomItem for Controls for Configuration (Format)

## Syntax

```xml
<Frame>
  <LeftIndent>NumberOfCharactersToShift</LeftIndent>
  <RightIndent>NumberOfCharactersToShift</RightIndent>
  <FirstLineHanging>NumberOfCharactersToShift</FirstLineHanging>
  <FirstLineIndent>NumberOfCharactersToShift</FirstLineIndent>
  <CustomItem>...</CustomItem>
</Frame>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `Frame` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|`CustomItem Element`|Required Element|
|[FirstLineHanging Element for Frame for Controls for Configuration (Format)](./firstlinehanging-element-for-frame-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies how many characters the first line of data is shifted to the left.|
|[FirstLineIndent Element for Frame for Controls for Configuration (Format)](./firstlineindent-element-for-frame-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies how many characters the first line of data is shifted to the right.|
|[LeftIndent Element for Frame for Controls for Configuration (Format)](./leftindent-element-for-frame-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the left margin.|
|[RightIndent Element for Frame for Controls for Configuration (Format)](./rightindent-element-for-frame-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the right margin.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)|Defines what data is displayed by the control and how it is displayed.|

## Remarks

You cannot specify the [FirstLineHanging](./firstlinehanging-element-for-frame-for-controls-for-configuration-format.md) and the [FirstLineIndent](./firstlineindent-element-for-frame-for-controls-for-configuration-format.md) elements in the same `Frame` element.

## See Also

[FirstLineHanging Element for Frame for Controls for Configuration (Format)](./firstlinehanging-element-for-frame-for-controls-for-configuration-format.md)

[FirstLineIndent Element for Frame for Controls for Configuration (Format)](./firstlineindent-element-for-frame-for-controls-for-configuration-format.md)

[LeftIndent Element for Frame for Controls for Configuration (Format)](./leftindent-element-for-frame-for-controls-for-configuration-format.md)

[RightIndent Element for Frame for Controls for Configuration (Format)](./rightindent-element-for-frame-for-controls-for-configuration-format.md)

[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
