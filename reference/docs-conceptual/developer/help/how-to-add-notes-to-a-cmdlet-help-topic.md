---
title: How to Add Notes to a Cmdlet Help Topic
ms.date: 09/12/2016
---
# How to Add Notes to a Cmdlet Help Topic

This section describes how to add a **NOTES** section to a PowerShell cmdlet Help topic. The
**NOTES** section is used to explain details that do not fit easily into the other structured
sections, such as a more detailed explanation of a parameter. This content could include comments on
how the cmdlet works with a specific provider, some unique, yet important, uses of the cmdlet, or
ways to avoid possible error conditions.

There are no limits to the number of notes that you can add to a Notes section. For each note, add a
pair of `<maml:alert>` tags to the `<maml:alertset>` node. The content of each note is added within
a set of `<maml:para>` tags. Use blank `<maml:para>` tags for spacing.

The following XML shows an `<maml:alertset>` node with two notes. Notice that each note has an
optional `<maml:title>` tag (titles can be used to group any set of `<maml:alert>` tags), and that
each note has a blank line following the content for spacing.

```xml
<maml:alertSet>
  <maml:title>title for Note 1</maml:title>
  <maml:alert>
    <maml:para> Note 1</maml:para>
    <maml:para></maml:para>
  </maml:alert>
  <maml:title>title for Note 2</maml:title>
  <maml:alert>
    <maml:para> Note 1</maml:para>
    <maml:para></maml:para>
  </maml:alert>
</maml:alertSet>
```
