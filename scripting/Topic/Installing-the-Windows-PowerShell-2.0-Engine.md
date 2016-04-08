---
title: Installing the Windows PowerShell 2.0 Engine
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 82928f2b-f96a-4ae6-a0d0-6e7b181da308
---
# Installing the Windows PowerShell 2.0 Engine
This topic explains how to install the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine.

[!INCLUDE[psversion3](../Token/psversion3_md.md)] is designed to be backwards compatible with [!INCLUDE[psversion2](../Token/psversion2_md.md)]. Cmdlets, providers, snap\-ins, modules, and scripts written for [!INCLUDE[psversion2](../Token/psversion2_md.md)] run unchanged in [!INCLUDE[psversion3](../Token/psversion3_md.md)] and [!INCLUDE[psversion4](../Token/psversion4_md.md)]. However, due to a change in the runtime activation policy in Microsoft .NET Framework 4, Windows PowerShell host programs that were written for [!INCLUDE[psversion2](../Token/psversion2_md.md)] and compiled with Common Language Runtime (CLR) 2.0 cannot run without modification in later releases of [!INCLUDE[wps_2](../Token/wps_2_md.md)], which is compiled with CLR 4.0.

To maintain backward compatibility with commands and host programs that are affected by these changes, the [!INCLUDE[psversion2](../Token/psversion2_md.md)], [!INCLUDE[psversion3](../Token/psversion3_md.md)], and [!INCLUDE[psversion4](../Token/psversion4_md.md)] engines are designed to run side\-by\-side. Also, the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine is included in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)]. The [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine is intended to be used only when an existing script or host program cannot run because it is incompatible with [!INCLUDE[psversion3](../Token/psversion3_md.md)], [!INCLUDE[psversion4](../Token/psversion4_md.md)], or Microsoft .NET Framework 4. Such cases are expected to be rare.

The [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine is an optional feature of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] and [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. On earlier versions of Windows, when you install [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)], the [!INCLUDE[psversion3](../Token/psversion3_md.md)] installation completely replaces the [!INCLUDE[psversion2](../Token/psversion2_md.md)] installation in the [!INCLUDE[wps_2](../Token/wps_2_md.md)] installation directory. However, the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine is retained.

For information about starting the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine, see [Starting the Windows PowerShell 2.0 Engine](../Topic/Starting-the-Windows-PowerShell-2.0-Engine.md).

## On [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]
On [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine feature is turned on by default. However, to use it, you need to turn on the option for Microsoft .NET Framework 3.5, which it requires. This section also explains how to turn the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine feature on and off.

#### To turn on .NET Framework 3.5

1.  On the **Start** screen, type **Windows Features**.

2.  On the **Apps** bar, click **Settings**, and then click **Turn Windows features on or off**.

3.  In the **Windows Features** box, click **.NET Framework 3.5 (includes .NET 2.0 and 3.0** to select it.

    When you select **.NET Framework 3.5 (includes .NET 2.0 and 3.0**, the box fills to indicate that only part of the feature is selected. However, this is sufficient for the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine.

#### To turn the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine on and off

1.  On the **Start** screen, type **Windows Features**.

2.  On the **Apps** bar, click **Settings**, and then click **Turn Windows features on or off**.

3.  In the **Windows Features** box, expand the **[!INCLUDE[psversion2](../Token/psversion2_md.md)]** node, and click the **[!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine** box to select or clear it.

## On [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]
Use the following procedures to add the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine and Microsoft .NET Framework 3.5 features. The [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine requires Microsoft .NET Framework 2.0.50727 at a minimum. This requirement is fulfilled by Microsoft .NET Framework 3.5.

#### To add the .NET Framework 3.5 feature

1.  In **Server Manager**, from the **Manage** menu, select **Add Roles and Features**.

    Or in **Server Manager**, click **All Servers**, right\-click a server name, and then select **Add Roles and Features**.

2.  On the **Installation Type** page, select **Role\-based or feature\-based installation**.

3.  On the **Features** page, expand the **.NET 3.5 Framework Features** node and select **.NET Framework 3.5 (includes .NET 2.0 and 3.0)**.

    The other options under that node are not required for the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine.

#### To add the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine feature

-   In **Server Manager**, from the **Manage** menu, select **Add Roles and Features**.

    Or **Server Manager**, click **All Servers**, right\-click a server name, and then select **Add Roles and Features**.

-   On the **Installation Type** page, select **Role\-based or feature\-based installation**.

-   On the **Features** page, expand the **[!INCLUDE[mshshort](../Token/mshshort_md.md)] (Installed)** node and select **[!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine**.

For information about starting the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine, see [Starting the Windows PowerShell 2.0 Engine](../Topic/Starting-the-Windows-PowerShell-2.0-Engine.md).

## On Earlier Systems
The [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkID=293881) package that installs [!INCLUDE[psversion4](../Token/psversion4_md.md)] on [!INCLUDE[win7_client_secondref](../Token/win7_client_secondref_md.md)], [!INCLUDE[win7_server_secondref](../Token/win7_server_secondref_md.md)], and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], includes the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine. The [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine is enabled and ready to use, if necessary, without additional installation, setup, or configuration.

The [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)] package that installs [!INCLUDE[psversion3](../Token/psversion3_md.md)] on [!INCLUDE[win7_client_secondref](../Token/win7_client_secondref_md.md)], [!INCLUDE[win7_server_secondref](../Token/win7_server_secondref_md.md)], and [!INCLUDE[lserver](../Token/lserver_md.md)], includes the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine. The [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine is enabled and ready to use, if necessary, without additional installation, setup, or configuration.

## See Also
[Windows PowerShell System Requirements](../Topic/Windows-PowerShell-System-Requirements.md)
[Installing Windows PowerShell](../Topic/Installing-Windows-PowerShell.md)
[Starting Windows PowerShell [ps]](https://technet.microsoft.com/en-us/library/8ec8c2d7-8e7c-4722-a3d2-498fe5739a8e)
[Starting the Windows PowerShell 2.0 Engine](../Topic/Starting-the-Windows-PowerShell-2.0-Engine.md)

