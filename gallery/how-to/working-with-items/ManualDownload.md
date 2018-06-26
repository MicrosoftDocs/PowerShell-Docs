---
ms.date:  06/26/18
contributor:  JKeithB
keywords:  gallery,powershell,psgallery
title:  Manual item download 
---
# Manual item download and installation

The Powershell Gallery Preview supports downloading an item from the website directly, without using the PowerShellGet cmdlets. This provides users the ability to acquire items from the PowerShell Gallery as a NuGet package. 

__Note:__ This process is very manual. Unlike using the PowerShellGet cmdlets, this approach will not install the item, and will not download dependencies. 

A NuGet package works with NuGet-based repositories like the PowerShell Gallery. The package is in a zip format, with extra content added to store data about the contents of the package (for example the author, version, item type, licenseURI, projectURI, etc.). 

## Using manual download to acquire an item

Each item page has a link for Manual Download, as shown here:

![Manual Download](../../Images/ManualItemDownload.png)

To download the item manually, click on the text titled: "Download the raw nupkg file". Depending on the browser you are using, you may be able to choose the target folder where the nupkg file is placed. A copy of the item will be placed in the download folder for your browser, with the name <item name>.<item version>.nupkg. 

__Note:__ Some browsers, notably Internet Explorer, will automatically rename the nupkg file to .zip during the download. This is part of the NuGet specification. As a result, the downloaded file may be named .nupkg or .zip. 

Users who wish to expand the item can rename the nupkg file to .zip (if needed), then extract the contents to a local folder. 

A NuGet package includes the following NuGet-specific elements that are not part of the original package:

* A folder named "_rels". This contains a .rels file, which lists the dependencies for the item. 
* A folder named "package". This folder contains the NuGet-specific data associated with the item.
* A file named "[content_types].xml". This describes how extensions such as PowerShellGet work with NuGet.
* A file named "<itemname>.nuspec". This contains the bulk of the metadata associated with the item.

## Installing PowerShell items from a NuGet package

The most direct approach is to remove the elements that are part of the NuGet package structure, leaving a folder that contains the PowerShell code from the package author. The steps are:

* Extract the contents of the NuGet package 
* Delete the Nuget-specific folders and files listed above. What will remain is what the author originally published using PowerShellGet. 
* Rename the folder. The default folder name for the item will generally be <item name>.<version>, and the version section will include "-prerelease" if the item is tagged as a prerelease. Rename the folder to be just the item name. For example, "azurerm.storage.5.0.4-preview" would become "azurerm.storage". 
* If the item you downloaded is a module, you can copy the folder to your PSModulePath. If the item is a script, you will want to copy just the script file to your PSModulePath.

As stated in the note above, using manual download does not include dependencies needed to use the item. The dependencies are included in the .rels file, in the rels folder. This file is in xml format, and contains the list of dependencies that would be installed by PowerShellGet. 

