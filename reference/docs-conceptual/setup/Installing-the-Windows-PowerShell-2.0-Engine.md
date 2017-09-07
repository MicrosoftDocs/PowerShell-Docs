---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Installing the Windows PowerShell 2.0 Engine
ms.assetid:  82928f2b-f96a-4ae6-a0d0-6e7b181da308
---

# Installing the Windows PowerShell 2.0 Engine
This topic explains how to install the Windows PowerShell 2.0 Engine.

Windows PowerShell 3.0 is designed to be backwards compatible with Windows PowerShell 2.0. Cmdlets, providers, snap-ins, modules, and scripts written for Windows PowerShell 2.0 run unchanged in Windows PowerShell 3.0 and Windows PowerShell 4.0. However, due to a change in the runtime activation policy in Microsoft .NET Framework 4, Windows PowerShell host programs that were written for Windows PowerShell 2.0 and compiled with Common Language Runtime (CLR) 2.0 cannot run without modification in later releases of Windows PowerShell, which is compiled with CLR 4.0.

To maintain backward compatibility with commands and host programs that are affected by these changes, the Windows PowerShell 2.0, Windows PowerShell 3.0, and Windows PowerShell 4.0 engines are designed to run side-by-side. Also, the Windows PowerShell 2.0 Engine is included in Windows Server 2012 R2, Windows 8.1, Windows 8, Windows Server 2012, and Windows Management Framework 3.0. The Windows PowerShell 2.0 Engine is intended to be used only when an existing script or host program cannot run because it is incompatible with Windows PowerShell 3.0, Windows PowerShell 4.0, or Microsoft .NET Framework 4. Such cases are expected to be rare.

The Windows PowerShell 2.0 Engine is an optional feature of Windows Server 2012 R2, Windows 8.1, Windows® 8 and Windows Server® 2012. On earlier versions of Windows, when you install Windows Management Framework 3.0, the Windows PowerShell 3.0 installation completely replaces the Windows PowerShell 2.0 installation in the Windows PowerShell installation directory. However, the Windows PowerShell 2.0 Engine is retained.

For information about starting the Windows PowerShell 2.0 Engine, see [Starting the Windows PowerShell 2.0 Engine](Starting-the-Windows-PowerShell-2.0-Engine.md).

## On Windows 8.1 and Windows 8
On Windows 8.1 and Windows 8, the Windows PowerShell 2.0 Engine feature is turned on by default. However, to use it, you need to turn on the option for Microsoft .NET Framework 3.5, which it requires. This section also explains how to turn the Windows PowerShell 2.0 Engine feature on and off.

#### To turn on .NET Framework 3.5

1. On the **Start** screen, type **Windows Features**.

2. On the **Apps** bar, click **Settings**, and then click **Turn Windows features on or off**.

3. In the **Windows Features** box, click **.NET Framework 3.5 (includes .NET 2.0 and 3.0** to select it.

    When you select **.NET Framework 3.5 (includes .NET 2.0 and 3.0**, the box fills to indicate that only part of the feature is selected. However, this is sufficient for the Windows PowerShell 2.0 Engine.

#### To turn the Windows PowerShell 2.0 Engine on and off

1. On the **Start** screen, type **Windows Features**.

2. On the **Apps** bar, click **Settings**, and then click **Turn Windows features on or off**.

3. In the **Windows Features** box, expand the **Windows PowerShell 2.0** node, and click the **Windows PowerShell 2.0 Engine** box to select or clear it.

## On Windows Server 2012 R2 and Windows Server 2012
Use the following procedures to add the Windows PowerShell 2.0 Engine and Microsoft .NET Framework 3.5 features. The Windows PowerShell 2.0 Engine requires Microsoft .NET Framework 2.0.50727 at a minimum. This requirement is fulfilled by Microsoft .NET Framework 3.5.

#### To add the .NET Framework 3.5 feature

1. In **Server Manager**, from the **Manage** menu, select **Add Roles and Features**.

    Or in **Server Manager**, click **All Servers**, right-click a server name, and then select **Add Roles and Features**.

2. On the **Installation Type** page, select **Role-based or feature-based installation**.

3. On the **Features** page, expand the **.NET 3.5 Framework Features** node and select **.NET Framework 3.5 (includes .NET 2.0 and 3.0)**.

    The other options under that node are not required for the Windows PowerShell 2.0 Engine.

#### To add the Windows PowerShell 2.0 Engine feature

- In **Server Manager**, from the **Manage** menu, select **Add Roles and Features**.

    Or **Server Manager**, click **All Servers**, right-click a server name, and then select **Add Roles and Features**.

- On the **Installation Type** page, select **Role-based or feature-based installation**.

- On the **Features** page, expand the **Windows PowerShell (Installed)** node and select **Windows PowerShell 2.0 Engine**.

For information about starting the Windows PowerShell 2.0 Engine, see [Starting the Windows PowerShell 2.0 Engine](Starting-the-Windows-PowerShell-2.0-Engine.md).

## On Earlier Systems
The [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkID=293881) package that installs Windows PowerShell 4.0 on Windows 7, Windows Server 2008 R2, and Windows Server 2012, includes the Windows PowerShell 2.0 Engine. The Windows PowerShell 2.0 Engine is enabled and ready to use, if necessary, without additional installation, setup, or configuration.

The Windows Management Framework 3.0 package that installs Windows PowerShell 3.0 on Windows 7, Windows Server 2008 R2, and Windows Server 2008, includes the Windows PowerShell 2.0 Engine. The Windows PowerShell 2.0 Engine is enabled and ready to use, if necessary, without additional installation, setup, or configuration.

## See Also
- [Windows PowerShell System Requirements](Windows-PowerShell-System-Requirements.md)
- [Installing Windows PowerShell](Installing-Windows-PowerShell.md)
- [Starting Windows PowerShell](https://technet.microsoft.com/en-us/library/8ec8c2d7-8e7c-4722-a3d2-498fe5739a8e)
- [Starting the Windows PowerShell 2.0 Engine](Starting-the-Windows-PowerShell-2.0-Engine.md)

