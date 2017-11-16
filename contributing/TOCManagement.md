# TOC Creation and Management

A **ToC** is used to define the Table of Contents (ToC) structure of a docset.
The ToC can be described using either Yaml or Markdown.

TOC files should only be modified by the PowerShell documentation team.
This is done to ensure that new topics appear in the appropriate place in our docset and that the TOC is structured according to our internal requirements.

## Yaml ToC

The recommended format for ToCs is Yaml.
The Yaml-based ToC format enables additional capabilities, such as auto-expansion of ToC nodes and automatic contextual ToC query string generation, which aren't available when using Markdown.


Let's look at how a simple ToC would be represented:

```yaml
- name: Tutorial
  href: tutorial.md
  items:
  - name: Step 1
    href: step-1.md
  - name: Step 2
    href: step-2.md
  - name: Step 3
    href: step-3.md
```

The Yaml document itself is a list of ToC elements, each of which minimally has a `name` and `href`. ToC nodes can also act as parents to other nodes. In this case, the child ToC nodes are represented by a list called `items`.

What follows is a larger example Yaml structure, which demonstrates more configuration options:

```yaml
- name: Dev Sandbox
  href: index.md
  displayName: Home
  pdf_name: foo
- name: Conceptual Pages
  href: ./conceptual/index.md
  expanded: true
  items:
  - name: Code Samples
    href: ./conceptual/code.md
  - name: Tables
    href: ./conceptual/tables.md
- name: Reference Pages
  items:
  - name: IDictionary
    href: ./reference/System.Collection.IDictionary.yml
  - name: String
    href: ./reference/System.String.yml
- name: Content Pages
  href: ./content/index.md
- name: Hub Pages
  items:
  - name: Card Gallery
    href: ./hubPage/cardGallery.md
- name: Landing Pages
  items:
  - name: Azure Architecture
    href: ./landingPage/azureCat.md
  - name: UWP
    href: ./landingPage/uwp.md
- name: Engineering Excellence
  items:
  - name: Environment Setup
    href: ./eeds/environment-setup.md
  - name: Template Docs
    href: ./eeds/docs/index.md
- name: Break Title Tests
  items:
  - name: System.Automation.String.Foo.Bar.Zip.Test()
    href: ./eeds/environment-setup.md
  - name: VMScaleSets-AzureRmDiagnosticsDscFixUp
    href: ./eeds/docs/index.md
```

Here's an explanation of all the properties available on a ToC node:

* `name` (required) - A string name that is displayed for the ToC node (may not contain a colon (:) ).

* `displayName` (optional) - An additional string value that doesn’t get displayed (yes, it's a very poor name).
  The `displayName` and `name` values can be used when doing ToC filtering.

* `href` (optional) - A string that represents the link that the ToC node navigates to.
  Remember, nodes can exist just to parent other nodes, so this is still an optional property.

* `items` (optional) - If a node has children, those are listed in the `items` array.
  The child nodes have the same available properties as listed above.

* `expanded` (optional) - A boolean property (true/false) that determines if the node should be expanded by default when the ToC is loaded.
  Only *one* root-level node can be expanded on load.
