---
description: CustomItem Element for CustomEntry for Controls for Configuration
ms.date: 08/20/2021
ms.topic: reference
title: CustomItem Element for CustomEntry for Controls for Configuration
---
# CustomItem Element for CustomEntry for Controls for Configuration

Defines what data is displayed by the control and how it is displayed. This element is used when
defining a common control that can be used by all the views in the formatting file.

## Schema

- Configuration Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
- CustomItem Element

## Syntax

```xml
<CustomItem>
  <ExpressionBinding>...</ExpressionBinding>
  <NewLine/>
  <Text>TextToDisplay</Text>
  <Frame>...</Frame>
</CustomItem>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`CustomItem` element. For more information, see Remarks.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[ExpressionBinding Element for CustomItem for Controls for Configuration](./expressionbinding-element-for-customitem-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Defines the data that is displayed by the control.|
|[Frame Element for CustomItem for Controls for Configuration](./frame-element-for-customitem-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Defines how the data is displayed, such as shifting the data to the left or right.|
|[NewLine Element for CustomItem for Controls for Configuration](./newline-element-for-customitem-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Adds a blank line to the display of the control.|
|[Text Element for CustomItem for Controls for Configuration](./text-element-for-customitem-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Adds text, such as parentheses or brackets, to the display of the control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomControl for Controls for Configuration](./customentry-element-for-customcontrol-for-controls-for-configuration-format.md)|Provides a definition of the control.|

## Remarks

When specifying the child elements of the `CustomItem` element, keep the following in mind:

- The child elements must be added in the following sequence: `ExpressionBinding`, `NewLine`,
  `Text`, and `Frame`.
- There is no maximum limit to the number of sequences that you can specify.
- In each sequence, there is no maximum limit to the number of `ExpressionBinding` elements that you
  can use.

## See Also

[ExpressionBinding Element for CustomItem for Controls for Configuration](./expressionbinding-element-for-customitem-for-controls-for-configuration-format.md)

[Frame Element for CustomItem for Controls for Configuration](./frame-element-for-customitem-for-controls-for-configuration-format.md)

[NewLine Element for CustomItem for Controls for Configuration](./newline-element-for-customitem-for-controls-for-configuration-format.md)

[Text Element for CustomItem for Controls for Configuration](./text-element-for-customitem-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
