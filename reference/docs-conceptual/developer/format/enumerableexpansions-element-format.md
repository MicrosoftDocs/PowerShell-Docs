---
ms.date: 09/13/2016
ms.topic: reference
title: EnumerableExpansions Element (Format)
description: EnumerableExpansions Element (Format)
---
# EnumerableExpansions Element (Format)

Defines how .NET collection objects are expanded when they are displayed in a view.

Configuration Element (Format)
DefaultSettings Element (Format)
EnumerableExpansions Element (Format)

## Syntax

```xml
<EnumerableExpansions>
  <EnumerableExpansion>...</EnumerableExpansion>
</EnumerableExpansions>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `EnumerableExpansions` element. There is no limit to the number of child elements that you can use.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[EnumerableExpansion Element (Format)](./enumerableexpansion-element-format.md)|Optional element.<br /><br /> Defines the specific .NET collection objects that are expanded when they are displayed in a view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[DefaultSettings Element (Format)](./defaultsettings-element-format.md)|Defines common settings that apply to all the views of the formatting file.|

## Remarks

This element is used to define how collection objects and the objects in the collection are displayed. In this case, a collection object refers to any object that supports the  **System.Collections.ICollection** interface.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
