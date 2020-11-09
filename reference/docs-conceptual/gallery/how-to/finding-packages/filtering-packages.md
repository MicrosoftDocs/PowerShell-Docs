---
ms.date:  06/12/2017
title:  Filtering search results
description: This article describes the user interface used to filter content in the PowerShell Gallery.
---
# Filtering search results

The [Packages tab](https://www.powershellgallery.com/packages) displays all available packages in
the PowerShell Gallery.

There are several ways to filter, sort, and search the packages. To see more details about a
particular package, click the package.

## Filter By

The drop-down under "Filter By" allows users to filter the results by:

- Include Prerelease
- Stable Only

For information about "Prerelease" and "Stable", see
[Prerelease Versioning Added to PowerShellGet and PowerShell Gallery](https://devblogs.microsoft.com/powershell/prerelease-versioning-added-to-powershellget-and-powershell-gallery/)
in the PowerShell Team Blog.

The checkboxes under the drop-down allow users to filter the results by:

- Package Types
  - Module
  - Script
- Categories
  - Cmdlet
  - DSC Resource
  - Function
  - Role Capability
  - Workflow

To see only modules in the PowerShell Gallery, check Module in the Package Types. Similarly, to see
only scripts in the PowerShell Gallery, check Script in the Package Types.

> [!NOTE]
> Filters are inclusive. Example: A package containing both cmdlets and functions will appear if
> either Cmdlet or Function (or both) are checked. If neither are selected, the package will not
> appear. Similarly, if all categories are selected, only packages containing one of those
> categories will appear. **Packages that do not belong to any of those categories will not
> appear.**

## Sort By

The Sort By drop-down allows users to sort the results by:

- Popularity - Popularity is determined by Download Count
- A-Z - Alphabetically by package name
- Recent - Packages appear in order of publish date

## Search Box

The Search Box allows users to search the packages on keywords.
For more information, see [Gallery Search Syntax](search-syntax.md).
