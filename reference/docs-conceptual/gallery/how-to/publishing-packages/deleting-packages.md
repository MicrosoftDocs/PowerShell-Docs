---
ms.date:  06/12/2017
title:  How to delete packages from the PowerShell Gallery
description:  How to delete packages from the PowerShell Gallery
---
# Deleting Packages

The PowerShell Gallery does not support permanent deletion of packages, because that would break
anyone who is depending on it remaining available.

Instead, the PowerShell Gallery supports a way to 'unlist' a package, which can be done in the
package management page on the web site. When a package is unlisted, it no longer shows up in search
and in any package listing, both on the PowerShell Gallery and using PowerShellGet commands.
However, it remains downloadable by specifying its exact version, which is what allows the automated
scripts to continue working.

If you run into an exceptional situation where you think one of your packages must be deleted, this
can be handled manually by the PowerShell Gallery team. For example, if there is a copyright
infringement issue, or potentially harmful content, that could be a valid reason to delete it. You
should submit a support request through [PowerShell Gallery](https://www.PowerShellGallery.com) in
that case.
