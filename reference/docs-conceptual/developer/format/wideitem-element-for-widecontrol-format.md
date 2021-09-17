---
description: WideItem Element
ms.date: 08/25/2021
ms.topic: reference
title: WideItem Element
---
# WideItem Element for WideControl

Defines the property or script whose value is displayed.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- WideControl Element
- WideEntries Element
- WideEntry Element
- WideItem Element

## Syntax

```xml
<WideItem>
  <PropertyName>.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToExecute</ScriptBlock>
  <FormatString>FormatPattern</FormatString>
</WideItem>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`WideItem` element. The `FormatString` element is optional. However, you must specify a
`PropertyName` or `ScriptBlock` element, but you cannot specify both.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[FormatString Element for WideItem for WideControl](./formatstring-element-for-wideitem-for-widecontrol-format.md)|Optional element.<br /><br /> Specifies a format pattern that defines how the property or script value is displayed in the view.|
|[PropertyName Element for WideItem](./propertyname-element-for-wideitem-for-widecontrol-format.md)|Specifies the property of the object whose value is displayed in the wide view.|
|[ScriptBlock Element for WideItem](./scriptblock-element-for-wideitem-for-widecontrol-format.md)|Specifies the script whose value is displayed in the wide view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[WideEntry Element](./wideentry-element-for-widecontrol-format.md)|Provides a definition of the wide view.|

## Remarks

For more information about the components of a wide view, see [Wide View](./creating-a-wide-view.md).

## Example

The following example shows a `WideEntry` element that defines a single `WideItem` element. The
`WideItem` element defines the property or script whose value is displayed in the view.

```xml
<WideEntry>
  <WideItem>
    <PropertyName>ProcessName</PropertyName>
  </WideItem>
</WideEntry>
```

For a complete example of a wide view, see [Wide View (Basic)](./wide-view-basic.md).

## See Also

[FormatString Element for WideItem for WideControl](./formatstring-element-for-wideitem-for-widecontrol-format.md)

[PropertyName Element for WideItem](./propertyname-element-for-wideitem-for-widecontrol-format.md)

[ScriptBlock Element for WideItem](./scriptblock-element-for-wideitem-for-widecontrol-format.md)

[WideEntry Element](./wideentry-element-for-widecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
