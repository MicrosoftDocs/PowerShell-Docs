#### 1. Why is removing an item from PowerShell Gallery not exposed as an option?

The PowerShell Gallery does not support users permanently deleting their items. This enables others to take dependencies on your items without worrying about possible breaks in the future. For example, if the Pester module depends on the Azure module and the Azure module is removed from the gallery, then user can no longer uses the Pester module.

Instead of removing an item, however, you can unlist it instead.

#### 2. What does unlisting an item on PowerShell Gallery do?

Unlisting an item such as module or script on PowerShell Gallery will remove it from the Items tab. In addition, unlisted items will not be discoverable using the search bar. The only way to download an unlisted item is to specify the exact name and version of the item.
Because of this, the unlisting of an item will not break other modules or scripts that depend on it.

To unlist your item, visit the item details page and select 'Delete Item'. Uncheck the 'Listed' checkbox, and click Save.

#### 3. How can I remove an item?

If you experience a scenario where item deletion is necessary, contact the PowerShell Gallery Administrators.
Valid deletion scenarios are:
- Issues of copyright infringement.
- Item contains potentially harmful content.
- Item contains sensitive data.

To submit a Delete Item Request to the PowerShell Gallery Administrators, visit your item's detail page and select Contact Support.  


