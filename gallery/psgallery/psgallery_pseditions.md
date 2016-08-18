# Items with compatible PowerShell Editions
Starting with version 5.1, PowerShell is available in different editions which denote varying feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework and provides compatibility with scripts and modules targeting versions of PowerShell running on full footprint editions of Windows such as Server Core and Windows Desktop.
- **Core Edition:** Built on .NET Core and provides compatibility with scripts and modules targeting versions of PowerShell running on reduced footprint editions of Windows such as Nano Server and Windows IoT.

## PowerShell Gallery extracts supported PSEditions metadata and allows you to filters the items compatible for specific PowerShell Editions

If an item has compatible PSEditions specified, they will be listed as part of 'PowerShell Editions' in the item display page and also in items results.
![Item display page with PSEditions](Images/ItemDisplayPageWithPSEditions.PNG)

## Search for items in the gallery UI which works on PowerShellCore
Use Tags:"PSEdition_Desktop" and Tags:"PSEdition_Core" to filters the items on PowerShell Gallery.

### Use Tags:"PSEdition_Core" to search items compatible with PowerShell Core Edition.
![Search results for items compatible with Core PSEdition](Images/SearchResultsWithPSEditions.PNG)

### Use Tags:"PSEdition_Desktop" to search items compatible with PowerShell Desktop Edition.
![Search results for items compatible with Desktop PSEdition](Images/SearchResultsWithPSEdition_Desktop.PNG)

## More details on authoring and finding the items with compatible PowerShell Editions
### [Modules with PSEditions](../psget/module/modulewithpseditionsupport.md)
### [Scripts with PSEditions](../psget/script/scriptwithpseditionsupport.md)