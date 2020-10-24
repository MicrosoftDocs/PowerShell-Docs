---
ms.date:  06/12/2017
title:  Gallery Search Syntax
description: This article describes the user interface used to search for content in the PowerShell Gallery.
---
# Gallery Search Syntax

You can search the PowerShell Gallery using the
[PowerShell Gallery's web site](https://www.powershellgallery.com/). PowerShell Gallery web site
offers a text searchbox where you can use words, phrases and keyword expressions to narrow down
search results.

## Search by Keywords

```Syntax
dsc azure sql
```

Search attempts to find relevant documents containing all 3 keywords, and return matching documents.

## Search using Phrases and keywords

```Syntax
"azure sql" deployment
```

Entering a phrase between quotation marks ("") change the search to look for the particular phrase
instead of separate keywords. Matching documents should usually contain the exact phrase "azure
sql", including variations on capitalization e.g. "Azure SQL", and also usually contain the word
'deployment'.

## Filtering on fields

You can search for a specific package ID (or 'Id' or 'id'), or certain other fields by prefixing
search terms with the field name.

Currently the searchable fields are 'Id', 'Version', 'Tags', 'Author', 'Owner', 'Functions',
'Cmdlets', 'DscResources' and 'PowerShellVersion'.

- ID is the name you use in the console.
- Title is what is shown at the top of the package page in search results.

## Examples

```Syntax
ID:PSReadline
```

finds packages with an ID containing "PSReadline".

```Syntax
Id:"AzureRM.Profile"
```

is another way to find packages with "AzureRM.Profile" in their ID field.

The 'Id' filter is a substring match, so if you search for the following:

```Syntax
Id:"azure"
```

This provides results that include AzureRM.Profile' and 'Azure.Storage'.

You can also search for multiple keywords in a single field.

```Syntax
id:azure tags:intellisense
```

And you can perform phrase searches using double quotes:

```Syntax
id:"azure.storage"
```

To search all packages with DSC tag.

```Syntax
Tags:DSC
```

To search all packages with the specified function.

```Syntax
Functions:Get-TreeSize
```

To search all packages with the specified cmdlet.

```Syntax
Cmdlets:Get-AzureRmEnvironment
```

To search all packages with the specified DSC Resource name.

```Syntax
DscResources:xArchive
```

To search all packages with the specified PowerShellVersion

```Syntax
PowerShellVersion:2.0
```

Finally, if you use a field we don't support, such as 'commands', we'll just ignore it and search
all the fields. So the following query

```Syntax
commands:blobs storage
```

Is interpreted exactly the same as this query:

```Syntax
blobs storage
```
