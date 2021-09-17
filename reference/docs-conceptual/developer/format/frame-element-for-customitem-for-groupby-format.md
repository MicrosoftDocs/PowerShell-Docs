---
description: Frame Element for CustomItem for GroupBy
ms.date: 08/23/2021
ms.topic: reference
title: Frame Element for CustomItem for GroupBy
---
# Frame Element for CustomItem for GroupBy

Defines how the data is displayed, such as shifting the data to the left or right. This element is
used when defining how a new group of objects is displayed.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- GroupBy Element
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
|[FirstLineHanging Element for Frame for GroupBy](./firstlinehanging-element-for-frame-for-groupby-format.md)|Optional element.<br /><br /> Specifies how many characters the first line of data is shifted to the left.|
|[FirstLineIndent Element for Frame for GroupBy](./firstlineindent-element-for-frame-for-groupby-format.md)|Optional element.<br /><br /> Specifies how many characters the first line of data is shifted to the right.|
|[LeftIndent Element for Frame for GroupBy](./leftindent-element-for-frame-for-groupby-format.md)|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the left margin.|
|[RightIndent Element for Frame for GroupBy](./rightindent-element-for-frame-for-groupby-format.md)RightIndent Element|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the right margin.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for GroupBy](./customitem-element-for-customentry-for-groupby-format.md)|Defines what data is displayed by the control and how it is displayed.|

## Remarks

You cannot specify the [FirstLineHanging](./firstlinehanging-element-for-frame-for-groupby-format.md) and the [FirstLineIndent](./firstlineindent-element-for-frame-for-groupby-format.md) elements in the same `Frame` element.

## See Also

[FirstLineHanging Element for Frame for GroupBy](./firstlinehanging-element-for-frame-for-groupby-format.md)

[FirstLineIndent Element for Frame for GroupBy](./firstlineindent-element-for-frame-for-groupby-format.md)

[LeftIndent Element for Frame for GroupBy](./leftindent-element-for-frame-for-groupby-format.md)

[RightIndent Element for Frame for GroupBy](./rightindent-element-for-frame-for-groupby-format.md)

[CustomItem Element for CustomEntry for GroupBy](./customitem-element-for-customentry-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
