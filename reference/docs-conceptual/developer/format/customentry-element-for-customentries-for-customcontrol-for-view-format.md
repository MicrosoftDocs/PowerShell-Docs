---
description: CustomEntry Element for CustomEntries for CustomControl for View
ms.date: 08/20/2021
ms.topic: reference
title: CustomEntry Element for CustomEntries for CustomControl for View
---
# CustomEntry Element for CustomEntries for CustomControl for View

Provides a definition of the custom control view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
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

The following sections describe attributes, child elements, and the parent element of the
`CustomEntry` element. You must specify the items displayed by the definition.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for CustomEntry for View](./entryselectedby-element-for-customentry-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Defines the .NET types that use the definition of the custom control view or the condition that must exist for this definition to be used.|
|[CustomItem Element for CustomEntry for View](./customitem-element-for-customentry-for-customcontrol-for-view-format.md)|Defines a control for the custom control definition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntries Element for CustomControl for View](./customentries-element-for-customcontrol-for-view-format.md)|Provides the definitions of the custom control view. The custom control view must specify one or more definitions.|

## Remarks

In most cases, only one definition is required for each custom control view, but it is possible to
have multiple definitions if you want to use the same view to display different .NET objects. In
those cases, you can provide a separate definition for each object or set of objects.

## See Also

[CustomControl Element for View](./customcontrol-element-for-view-format.md)

[CustomItem Element for CustomEntry for View](./customitem-element-for-customentry-for-customcontrol-for-view-format.md)

[EntrySelectedBy Element for CustomEntry for View](./entryselectedby-element-for-customentry-for-customcontrol-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
