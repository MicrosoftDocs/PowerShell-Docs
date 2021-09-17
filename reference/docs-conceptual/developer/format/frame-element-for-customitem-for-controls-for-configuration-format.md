---
description: Frame Element for CustomItem for Controls for Configuration
ms.date: 08/23/2021
ms.topic: reference
title: Frame Element for CustomItem for Controls for Configuration
---
# Frame Element for CustomItem for Controls for Configuration

Defines how the data is displayed, such as shifting the data to the left or right. This element is
used when defining a common control that can be used by all the views in the formatting file.

## Schema

- Configuration Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
- CustomItem Element
- Frame Element

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

The following sections describe attributes, child elements, and the parent element of the `Frame`
element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|`CustomItem Element`|Required Element|
|[FirstLineHanging Element for Frame for Controls for Configuration](./firstlinehanging-element-for-frame-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies how many characters the first line of data is shifted to the left.|
|[FirstLineIndent Element for Frame for Controls for Configuration](./firstlineindent-element-for-frame-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies how many characters the first line of data is shifted to the right.|
|[LeftIndent Element for Frame for Controls for Configuration](./leftindent-element-for-frame-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the left margin.|
|[RightIndent Element for Frame for Controls for Configuration](./rightindent-element-for-frame-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the right margin.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)|Defines what data is displayed by the control and how it is displayed.|

## Remarks

You cannot specify the [FirstLineHanging](./firstlinehanging-element-for-frame-for-controls-for-configuration-format.md) and the [FirstLineIndent](./firstlineindent-element-for-frame-for-controls-for-configuration-format.md) elements in the same `Frame` element.

## See Also

[FirstLineHanging Element for Frame for Controls for Configuration](./firstlinehanging-element-for-frame-for-controls-for-configuration-format.md)

[FirstLineIndent Element for Frame for Controls for Configuration](./firstlineindent-element-for-frame-for-controls-for-configuration-format.md)

[LeftIndent Element for Frame for Controls for Configuration](./leftindent-element-for-frame-for-controls-for-configuration-format.md)

[RightIndent Element for Frame for Controls for Configuration](./rightindent-element-for-frame-for-controls-for-configuration-format.md)

[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
