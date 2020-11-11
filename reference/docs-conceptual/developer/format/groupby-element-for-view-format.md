---
ms.date: 09/13/2016
ms.topic: reference
title: GroupBy Element for View (Format)
description: GroupBy Element for View (Format)
---
# GroupBy Element for View (Format)

Defines how a new group of objects is displayed. This element is used when defining a table, list, wide, or custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
GroupBy Element for View (Format)

## Syntax

```xml
<GroupBy>
  <PropertyName>.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate</ScriptBlock>
  <Label>TextToDisplay</Label>
  <CustomControl>...</CustomControl>
  <CustomControlName>NameOfControl</CustomControlName>
</GroupBy>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent elements.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[CustomControl Element for GroupBy (Format)](./customcontrol-element-for-groupby-format.md)|Optional element.<br /><br /> Defines the custom control that display new groups.|
|[CustomControlName Element for GroupBy (Format)](./customcontrolname-element-for-groupby-format.md)|Optional element.<br /><br /> Specifies the name of a control that is used to display the new group.|
|[Label Element for GroupBy (Format)](./label-element-for-groupby-format.md)|Optional element.<br /><br /> Specifies a label that is displayed when a new group is encountered.|
|[PropertyName Element for GroupBy (Format)](./propertyname-element-for-groupby-format.md)|Optional element.<br /><br /> Specifies the .NET property the starts a new group whenever its value changes.|
|[ScriptBlock Element for GroupBy (Format)](./scriptblock-element-for-groupby-format.md)|Optional element.<br /><br /> Specifies the script that starts a new group whenever its value changes.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[View Element (Format)](./view-element-format.md)|Defines a view that displays one or more .NET objects.|

## Remarks

When defining how a new group of objects is displayed, you must specify the property or script that will start the new group; however, you cannot specify both.

## See Also

[CustomControlName Element for GroupBy (Format)](./customcontrolname-element-for-groupby-format.md)

[Label Element for GroupBy (Format)](./label-element-for-groupby-format.md)

[PropertyName Element for GroupBy (Format)](./propertyname-element-for-groupby-format.md)

[ScriptBlock Element for GroupBy (Format)](./scriptblock-element-for-groupby-format.md)

[View Element (Format)](./view-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
