---
title: FullyQuilifiedModuleName for 'using module'
author: jaimeo
contributor: vors
---

FullyQuilifiedModuleName for 'using module'
=========================

Now `using module` behaives the same way as other module-related constructions in PowerShell.

WMF 5.0 Problems
----------

* User doesn't have a way to specify module version in `using module`.
* If there are multiply versions of the module available on the system, user will get an error.

WMF 5.1
----------

* User can use `ModuleSpecification` [hashtable](https://msdn.microsoft.com/en-us/library/jj136290(v=vs.85).aspx). 
This hashtable has the same format as `Get-Module -FullyQualifiedName`

**Example:** `using module @{ModuleName = 'PSReadLine'; RequiredVersion = '1.1'}`

* If there are multiply versions of the module, powershell uses **same resolution logic** as `Import-Module` and doesn't error out.

* This makes `using module` alligned with `Import-Module` and `Import-DscResource`.
