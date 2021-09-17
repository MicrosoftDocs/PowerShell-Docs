---
description: CustomEntry Element for CustomEntries for Controls for View
ms.date: 08/20/2021
ms.topic: reference
title: CustomEntry Element for CustomEntries for Controls for View
---
# CustomEntry Element for CustomEntries for Controls for View

Provides a definition of the control. This element is used when defining controls that can be used
by a view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element

## Syntax

```xml
<CustomEntry>
  <EntrySelectedBy>...</EntrySelectedBy>
  <CustomItem>...</CustomItem>
</CustomEntry>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent elements of the
`CustomEntry` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for CustomEntry for Controls for View](./entryselectedby-element-for-customentry-for-controls-for-view-format.md)|Optional element.<br /><br /> Defines the .NET types that use this control definition or the condition that must exist for this definition to be used.|
|[CustomItem Element for CustomEntry for Controls for View](./customitem-element-for-customentry-for-controls-for-view-format.md)|Required element.<br /><br /> Defines how the control displays the data.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntries Element for CustomControl for View](./customentries-element-for-customcontrol-for-view-format.md)|Provides the definitions for the control.|

## Remarks

## See Also

[CustomEntries Element for CustomControl for View](./customentries-element-for-customcontrol-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
