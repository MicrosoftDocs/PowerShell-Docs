---
ms.date: 09/12/2016
ms.topic: reference
title: How to Add Related Links to a Cmdlet Help Topic
description: How to Add Related Links to a Cmdlet Help Topic
---
# How to Add Related Links to a Cmdlet Help Topic

This section describes how to add references to other content that is related to a PowerShell cmdlet
Help topic. Because these references appear in a command window, they do not link directly to the
referenced content.

In the cmdlet Help topics that are included in PowerShell, these links reference other cmdlets,
conceptual content (`about_`), and other documents and Help files that are not related to
PowerShell.

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
