---
description: HelpInfo XML Sample File
ms.date: 07/10/2023
ms.topic: reference
title: HelpInfo XML Sample File
---
# HelpInfo XML Sample File

This topic displays a sample of a well-formed Updatable Help Information file, commonly known as
"HelpInfo XML file." In this sample file, the UI culture elements are arranged in alphabetical order
by UI culture name. Alphabetical ordering is a best practice, but it's not required.

## HelpInfo XML Sample File

```xml
<?xml version="1.0" encoding="utf-8"?>
<HelpInfo xmlns="http://schemas.microsoft.com/powershell/help/2010/05">
   <HelpContentURI>https://go.microsoft.com/fwlink/?LinkID=141553</HelpContentURI>
   <SupportedUICultures>
    <UICulture>
      <UICultureName>de-DE</UICultureName>
      <UICultureVersion>2.15.0.10</UICultureVersion>
    </UICulture>
    <UICulture>
      <UICultureName>en-US</UICultureName>
      <UICultureVersion>3.2.0.7</UICultureVersion>
    </UICulture>
    <UICulture>
      <UICultureName>it-IT</UICultureName>
      <UICultureVersion>1.1.0.5</UICultureVersion>
    </UICulture>
    <UICulture>
      <UICultureName>ja-JP</UICultureName>
      <UICultureVersion>3.2.0.4</UICultureVersion>
    </UICulture>
   </SupportedUICultures>
</HelpInfo>
```

[!INCLUDE [use-platyps](../../../includes/use-platyps.md)]
