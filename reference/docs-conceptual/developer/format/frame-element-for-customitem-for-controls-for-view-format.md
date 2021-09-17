---
description: Frame Element for CustomItem for Controls for View
ms.date: 08/23/2021
ms.topic: reference
title: Frame Element for CustomItem for Controls for View
---
# Frame Element for CustomItem for Controls for View

Defines how the data is displayed, such as shifting the data to the left or right. This element is
used when defining controls that can be used by a view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
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
|[FirstLineHanging Element of Frame of Controls of View](./firstlinehanging-element-for-frame-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies how many characters the first line is shifted to the left.|
|[FirstLineIndent Element of Frame of Controls of View](./firstlineindent-element-for-frame-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies how many characters the first line is shifted to the right.|
|[LeftIndent Element of Frame of Controls of View](./leftindent-element-for-frame-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the left margin.|
|[RightIndent Element of Frame of Controls of View](./rightindent-element-for-frame-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the right margin.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for Controls for View](./customitem-element-for-customentry-for-controls-for-view-format.md)|Defines what data is displayed by the control and how it is displayed.|

## Remarks

You cannot specify the [FirstLineHanging](./firstlinehanging-element-for-frame-for-controls-for-view-format.md) and the [FirstLineIndent](./firstlineindent-element-for-frame-for-controls-for-view-format.md) elements in the same `Frame` element.

## See Also

[FirstLineHanging Element of Frame of Controls of View](./firstlinehanging-element-for-frame-for-controls-for-view-format.md)

[FirstLineIndent Element of Frame of Controls of View](./firstlineindent-element-for-frame-for-controls-for-view-format.md)

[LeftIndent Element of Frame of Controls of View](./leftindent-element-for-frame-for-controls-for-view-format.md)

[RightIndent Element of Frame of Controls of View](./rightindent-element-for-frame-for-controls-for-view-format.md)

[CustomItem Element for CustomEntry for Controls for View](./customitem-element-for-customentry-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
