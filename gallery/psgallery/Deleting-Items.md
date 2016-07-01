## Deleting items

PowerShellGallery.com does not support permanent deletion of items, because that would break anyone who is depending on it remaining available.

Instead, PowerShellGallery.com supports a way to 'unlist' an item, which can be done in the item management page on the web site. When an item is unlisted, it no longer shows up in search and in any item listing, both on PowerShellGallery.com and using PowerShellGet commands. However, it remains downloadable by specifying its exact version, which is what allows the automated scripts to continue working.

If you run into an exceptional situation where you think one of your items must be deleted, this can be handled manually by the PowerShell Gallery team. e.g. if there is a copyright infringement issue, or potentially harmful content, that could be a valid reason to delete it. You should submit a support request through [PowerShell Gallery] (http://www.PowerShellGallery.com) in that case.