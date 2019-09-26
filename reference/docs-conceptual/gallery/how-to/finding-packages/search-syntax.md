---
ms.date:  06/12/2017
contributor:  JKeithB
keywords:  gallery,powershell,cmdlet,psgallery
title:  Gallery Search Syntax
---
# Gallery Search Syntax

You can search the PowerShell Gallery using the [PowerShell Gallery's web site](https://www.powershellgallery.com/).
PowerShell Gallery web site offers a text searchbox where you can use words, phrases and keyword expressions to narrow down search results.

## Search by Keywords

    dsc azure sql

Search attempts to find relevant documents containing all 3 keywords, and return matching documents.

## Search using Phrases and keywords

    "azure sql" deployment

Entering a phrase between quotation marks ("") change the search to look for the particular phrase instead of separate keywords.
Matching documents should usually contain the exact phrase "azure sql", including variations on capitalization e.g.
"Azure SQL", and also usually contain the word 'deployment'.

## Filtering on fields

You can search for a specific package ID (or 'Id' or 'id'), or certain other fields by prefixing search terms with the field name.

Currently the searchable fields are 'Id', 'Version', 'Tags', 'Author', 'Owner', 'Functions', 'Cmdlets', 'DscResources' and 'PowerShellVersion'.

[What's the difference between ID and Title? ID is the name you use in the console. Title is what is shown at the top of the package page in search results.]

## Examples

    ID:PSReadline
    
finds packages with an ID containing "PSReadline".

    Id:"AzureRM.Profile"

is another way to find packages with "AzureRM.Profile" in their ID field.

The 'Id' filter is a substring match, so if you search for the following:

    Id:"azure"

This provides results that include AzureRM.Profile' and 'Azure.Storage'.

You can also search for multiple keywords in a single field. 

    id:azure tags:intellisense

And you can perform phrase searches using double quotes:

    id:"azure.storage"

To search all packages with DSC tag.

    Tags:DSC

To search all packages with the specified function.

    Functions:Get-TreeSize

To search all packages with the specified cmdlet.

    Cmdlets:Get-AzureRmEnvironment

To search all packages with the specified DSC Resource name.

    DscResources:xArchive

To search all packages with the specified PowerShellVersion

    PowerShellVersion:2.0

Finally, if you use a field we don't support, such as 'commands', we'll just ignore it and search all the fields. So the following query

    commands:blobs storage

Is interpreted exactly the same as this query:

    blobs storage
