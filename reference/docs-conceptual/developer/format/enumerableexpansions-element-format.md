---
description: EnumerableExpansions Element
ms.date: 08/23/2021
ms.topic: reference
title: EnumerableExpansions Element
---
# EnumerableExpansions Element

Defines how .NET collection objects are expanded when they are displayed in a view.

## Schema

- Configuration Element
- DefaultSettings Element
- EnumerableExpansions Element

## Syntax

```xml
<EnumerableExpansions>
  <EnumerableExpansion>...</EnumerableExpansion>
</EnumerableExpansions>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`EnumerableExpansions` element. There is no limit to the number of child elements that you can use.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[EnumerableExpansion Element](./enumerableexpansion-element-format.md)|Optional element.<br /><br /> Defines the specific .NET collection objects that are expanded when they are displayed in a view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[DefaultSettings Element](./defaultsettings-element-format.md)|Defines common settings that apply to all the views of the formatting file.|

## Remarks

This element is used to define how collection objects and the objects in the collection are
displayed. In this case, a collection object refers to any object that supports the
**System.Collections.ICollection** interface.

## See Also

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
