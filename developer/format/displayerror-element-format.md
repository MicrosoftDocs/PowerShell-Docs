---
title: "DisplayError Element (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 45c45800-a87d-456e-b07c-12d4d8c27c67
caps.latest.revision: 8
---
# DisplayError Element (Format)

Specifies that the string #ERR is displayed when an error occurs displaying a piece of data.

Configuration Element (Format)
DefaultSettings Element (Format)
DisplayError Element (Frmat)

## Syntax

```xml
<DisplayError/>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `DisplayError` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[DefaultSettings Element (Format)](./defaultsettings-element-format.md)|Defines common settings that apply to all the views of the formatting file.|

## Remarks

By default, when an error occurs while trying to display a piece of data, the location of the data is left blank. When this element is set to true, the #ERR string will be displayed.

## See Also

[DefaultSettings Element (Format)](./defaultsettings-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
