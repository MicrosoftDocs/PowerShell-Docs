---
description: CustomControlName Element for GroupBy
ms.date: 09/13/2016
ms.topic: reference
title: CustomControlName Element for GroupBy
---
# CustomControlName Element for GroupBy

Specifies the name of a custom control that is used to display the new group. This element is used
when defining a table, list, wide or custom control view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- GroupBy Element
- CustomControlName Element

## Syntax

```xml
<CustomControlName>ControlName</CustomControlName>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent elements of the
`CustomControlName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[GroupBy Element for View](./groupby-element-for-view-format.md)|Defines how Windows PowerShell displays a new group of objects.|

## Text Value

Specify the name of the custom control that is used to display a new group.

## Remarks

You can create common controls that can be used by all the views of a formatting file, and you can
create view controls that can be used by a specific view. The following elements specify the names
of these custom controls:

- [Name Element for Control for Controls for Configuration](./name-element-for-control-for-controls-for-configuration-format.md)

- [Name Element for Control for Controls for View](./name-element-for-control-for-controls-for-view-format.md)

## See Also

[GroupBy Element for View](./groupby-element-for-view-format.md)

[Name Element for Control for Controls for Configuration](./name-element-for-control-for-controls-for-configuration-format.md)

[Name Element for Control for Controls for View](./name-element-for-control-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
