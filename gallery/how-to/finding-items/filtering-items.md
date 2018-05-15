---
ms.date:  06/12/2017
contributor:  JKeithB
keywords:  gallery,powershell,cmdlet,psgallery
title:  Filtering search results
---
# Filtering search results

The [Items tab](https://www.powershellgallery.com/items) displays all available items in the PowerShell Gallery.

There are several ways to filter, sort, and search the items.
To see more details about a particular item, click the item.

## Filter By

The drop-down under "Filter By" allows users to filter the results by:
- Include Prerelease
- Stable Only

For information about "Prerelease" and "Stable", see [Prerelease Versioning Added to PowerShellGet and PowerShell Gallery](https://blogs.msdn.microsoft.com/powershell/2017/12/05/prerelease-versioning-added-to-powershellget-and-powershell-gallery/) in the PowerShell Team Blog.

The checkboxes under the drop-down allow users to filter the results by:
- Item Types
  - Module
  - Script
- Categories
  - Cmdlet
  - DSC Resource
  - Function
  - Role Capability
  - Workflow

To see only modules in the PowerShell Gallery, check Module in the Item Types.
Similarly, to see only scripts in the PowerShell Gallery, check Script in the Item Types.

> [!NOTE]
> Filters are inclusive.
> Example: An item containing both cmdlets and functions will appear if either Cmdlet or Function (or both) are checked.
> If neither are selected, the item will not appear.
> Similarly, if all categories are selected, only items containing one of those categories will appear.
> **Items that do not belong to any of those categories will not appear.**

## Sort By

The Sort By drop-down allows users to sort the results by:
- Popularity - Popularity is determined by Download Count
- A-Z - Alphabetically by item name
- Recent - Items appear in order of publish date

## Search Box

The Search Box allows users to search the items on keywords.
For more information, see [Gallery Search Syntax](search-syntax.md).