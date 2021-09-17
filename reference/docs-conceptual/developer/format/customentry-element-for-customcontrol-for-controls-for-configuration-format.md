---
description: CustomEntry Element for CustomControl for Controls for Configuration
ms.date: 08/20/2021
ms.topic: reference
title: CustomEntry Element for CustomControl for Controls for Configuration
---
# CustomEntry Element for CustomControl for Controls for Configuration

Provides a definition of the common control. This element is used when defining a common control
that can be used by all the views in the formatting file.

## Schema

- Configuration Element
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

The following sections describe attributes, child elements, and the parent element of the
`CustomEntry` element. You must specify the items displayed by the definition.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for CustomEntry for Controls for Configuration](./entryselectedby-element-for-customentry-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Defines the .NET types that use the definition of the common control or the condition that must exist for this control to be used.|
|[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)|Required element.<br /><br /> Defines what data is displayed by the control and how it is displayed.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntries Element for CustomControl for Configuration](./customentries-element-for-customcontrol-for-controls-for-configuration-format.md)|Provides the definitions of the common control.|

## Remarks

In most cases, only one definition is required for each common custom control, but it is possible to
have multiple definitions if you want to use the same control to display different .NET objects. In
those cases, you can provide a separate definition for each object or set of objects.

## See Also

[CustomEntries Element for CustomControl for Configuration](./customentries-element-for-customcontrol-for-controls-for-configuration-format.md)

[CustomItem Element for CustomEntry for Controls for Configuration](./customitem-element-for-customentry-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)
