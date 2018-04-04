---
ms.date:  06/12/2017
author:  JKeithB
ms.topic:  reference
keywords:  wmf,powershell,setup
---

# Just Enough Administration (JEA)
Just Enough Administration is a new feature in WMF 5.0 that enables role-based administration through PowerShell remoting.  It extends the existing constrained endpoint infrastructure by allowing non-administrators to run specific commands, scripts and executables as an administrator.  This enables you to reduce the number of full administrators in your environment and improve your security.  JEA works for everything you manage through PowerShell; if you can manage something with PowerShell, JEA can help you do so more securely.  For a detailed look at Just Enough Administration, check out the [experience guide](http://aka.ms/JEA).

Unlike old constrained endpoints, JEA is both powerful and easy to configure.  User capabilities in JEA can be granularly controlled, down to restricting which parameter sets and values can be supplied to a specific command. The user’s actions are run in the context of a one-time virtual account that has the rights to perform the administrator actions.  The commands invoked by the user can be logged for security audits.

JEA works by allowing you to create specially-configured constrained endpoints.  These endpoints have a few important characteristics:

1. Users connecting to them “run as” a privileged Virtual Account that exists only for the duration of this remote session.  By default, this Virtual Account is a member of the built-in Administrators group, as well as a Domain Administrators on domain controllers (note: these permissions are configurable). By connecting as one user and running as a different, privileged user, you can allow non-privileged users to perform specific administrative tasks without giving them administrative rights on your systems.
2. The endpoint is locked down.  This means PowerShell runs in No Language mode.  Only specific commands, scripts, and executables are visible to the user.
3. Different users connecting are presented with a different set of capabilities based on group membership.  You can provide different roles different capabilities at the same endpoint.