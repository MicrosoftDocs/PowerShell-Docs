---
description: How to add related links to a cmdlet help topic
ms.date: 07/10/2023
ms.topic: reference
title: How to add related links to a cmdlet help topic
---
# How to add related links to a cmdlet help topic

[!INCLUDE [use-platyps](../../../includes/use-platyps.md)]

This section describes how to add references to other content that's related to a PowerShell cmdlet
Help topic. Because these references appear in a command window, they don't link directly to the
referenced content.

In the cmdlet Help topics that are included in PowerShell, these links reference other cmdlets,
conceptual content (`about_`), and other documents and Help files that aren't related to PowerShell.

The following XML shows how to add a **RelatedLinks** node that contains two references to related
topics.

```xml
<maml:relatedLinks>
  <maml:navigationLink>
    <maml:linkText>Topic-name</maml:linkText>
  </maml:navigationLink>
  <maml:navigationLink>
    <maml:linkText>Topic-name</maml:linkText>
  </maml:navigationLink>
</ maml:relatedLinks >
```
