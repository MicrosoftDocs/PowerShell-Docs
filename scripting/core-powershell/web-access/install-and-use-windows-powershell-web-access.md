---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  install and use windows powershell web access
ms.technology:  powershell
---


#  Install and Use Windows PowerShell Web Access

Updated: November 5, 2013

Applies To: Windows Server 2012 R2, Windows Server 2012

Windows PowerShell® Web Access, first introduced in Windows Server® 2012, acts as a Windows PowerShell gateway, providing a web-based Windows PowerShell console that is targeted at a remote computer. It enables IT Pros to run Windows PowerShell commands and scripts from a Windows PowerShell console in a web browser, with no Windows PowerShell, remote management software, or browser plug-in installation necessary on the client device. All that is required to run the web-based Windows PowerShell console is a properly-configured Windows PowerShell Web Access gateway, and a client device browser that supports JavaScript® and accepts cookies.

Examples of client devices include laptops, non-work personal computers, borrowed computers, tablet computers, web kiosks, computers that are not running a Windows-based operating system, and cell phone browsers. IT Pros can perform critical management tasks on remote Windows-based servers from devices that have access to an Internet connection and a web browser.

After successful gateway setup and configuration, users can access a Windows PowerShell console by using a web browser. When users open the secured Windows PowerShell Web Access website, they can run a web-based Windows PowerShell console after successful authentication.

Windows PowerShell Web Access setup and configuration is a three-step process:

1.  Installing Windows PowerShell Web Access

2.  Configuring the gateway

3.  Configuring authorization rules that allow users access to the web-based Windows PowerShell console

Before you install and configure Windows PowerShell Web Access, we recommend that you read this entire guide, which includes instructions about how to install, secure, and uninstall Windows PowerShell Web Access. The [Use the Web-based Windows PowerShell Console](https://technet.microsoft.com/en-us/library/hh831417(v=ws.11).aspx) topic describes how users sign in to the web-based console, and covers limitations and differences between the web-based Windows PowerShell console and the **powershell.exe** console. End users of the web-based console should read [Use the Web-based Windows PowerShell Console](https://technet.microsoft.com/en-us/library/hh831417(v=ws.11).aspx), but do not need to read the rest of this guide.

This topic does not provide in-depth Web Server (IIS) operations guidance; only those steps required to configure the Windows PowerShell Web Access gateway are described in this topic. For more information about configuring and securing websites in IIS, see the IIS documentation resources in the See Also section.

The following diagram shows how Windows PowerShell Web Access works.

<span><img src="https://i-technet.sec.s-msft.com/dynimg/IC564303.jpeg" title="Windows PowerShell Web Access diagram" alt="Windows PowerShell Web Access diagram" id="ee15fa8f-ce13-49e5-933d-514f6d60a2b1" /></span>

In this topic:

-   [Requirements for running Windows PowerShell Web Access](#BKMK_reqs)

-   [Browser and client device support](#BKMK_browser)

-   [Recommended (quick) deployment](#BKMK_recm)

-   [Custom deployment](#BKMK_custom)

-   [Configure a genuine certificate](#BKMK_configcert)

<a href="" id="BKMK_reqs"></a>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Requirements for running Windows PowerShell Web Access</span></a>
<a href="/en-us/library/hh831611(v=ws.11).aspx#Anchor_0" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

Windows PowerShell Web Access requires Web Server (IIS), .NET Framework 4.5, and Windows PowerShell 3.0 or Windows PowerShell 4.0 to be running on the server on which you want to run the gateway. You can install Windows PowerShell Web Access on a server that is running Windows Server 2012 R2 or Windows Server 2012 by using either the Add Roles and Features Wizard in Server Manager, or Windows PowerShell deployment cmdlets for Server Manager. When you install Windows PowerShell Web Access by using Server Manager or its deployment cmdlets, required roles and features are automatically added as part of the installation process.

Windows PowerShell Web Access allows remote users to access computers in your organization by using Windows PowerShell in a web browser. Although Windows PowerShell Web Access is a convenient and powerful management tool, the web-based access poses security risks, and should be configured as securely as possible. We recommend that administrators who configure the Windows PowerShell Web Access gateway use available security layers, both the cmdlet-based authorization rules included with Windows PowerShell Web Access, and security layers that are available in Web Server (IIS) and third-party applications. This documentation includes both unsecure examples that are only recommended for test environments, as well as examples that are recommended for secure deployments.

<a href="" id="BKMK_browser"></a>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Browser and client device support</span></a>
<a href="/en-us/library/hh831611(v=ws.11).aspx#Anchor_1" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

Windows PowerShell Web Access supports the following Internet browsers. Although mobile browsers are not officially supported, many may be able to run the web-based Windows PowerShell console. Other browsers that accept cookies, run JavaScript, and run HTTPS websites are expected to work, but are not officially tested.

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Supported desktop computer browsers</span></a>

------------------------------------------------------------------------

-   Windows® Internet Explorer® for Microsoft Windows® 8.0, 9.0, 10.0, and 11.0

-   Mozilla Firefox® 10.0.2

-   Google Chrome™ 17.0.963.56m for Windows

-   Apple Safari® 5.1.2 for Windows

-   Apple Safari 5.1.2 for Mac OS®

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Minimally-tested mobile devices or browsers</span></a>

------------------------------------------------------------------------

-   Windows Phone 7 and 7.5

-   Google Android WebKit 3.1 Browser Android 2.2.1 (Kernel 2.6)

-   Apple Safari for iPhone operating system 5.0.1

-   Apple Safari for iPad 2 operating system 5.0.1

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Browser requirements</span></a>

------------------------------------------------------------------------

To use the Windows PowerShell Web Access web-based console, browsers must do the following.

-   Allow cookies from the Windows PowerShell Web Access gateway website.

-   Be able to open and read HTTPS pages.

-   Open and run websites that use JavaScript.

<a href="" id="BKMK_recm"></a>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Recommended (quick) deployment</span></a>
<a href="/en-us/library/hh831611(v=ws.11).aspx#Anchor_2" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

You can install the Windows PowerShell Web Access gateway on a server that is running Windows Server 2012 R2 or Windows Server 2012 by using either Windows PowerShell cmdlets, or by using the Add Roles and Features Wizard that is opened from within Server Manager. For quick installation and configuration, use Windows PowerShell cmdlets, as described in this section.

-   [Step 1: Install Windows PowerShell Web Access](#BKMK_step1)

-   [Step 2: Configure the gateway](#BKMK_step2)

-   [Step 3: Configure a restrictive authorization rule](#BKMK_step3)

<a href="" id="BKMK_step1"></a>
###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 1: Install Windows PowerShell Web Access</span></a>

------------------------------------------------------------------------

#### To install Windows PowerShell Web Access by using Windows PowerShell cmdlets

1.  Do one of the following to open a Windows PowerShell session with elevated user rights.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.

    -   On the Windows **Start** screen, right-click **Windows PowerShell**, and then click **Run as Administrator**.

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><span><img src="https://i-technet.sec.s-msft.com/dynimg/IC101471.jpeg" title="System_CAPS_note" alt="System_CAPS_note" id="s-e6f6a65cf14f462597b64ac058dbe1d0-system-media-system-caps-note" /></span><span class="alertTitle">Note </span></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>In Windows PowerShell 3.0 and 4.0, there is no need to import the Server Manager cmdlet module into the Windows PowerShell session before running cmdlets that are part of the module. A module is automatically imported the first time you run a cmdlet that is part of the module. Also, Windows PowerShell cmdlets are not case-sensitive.</p></td>
    </tr>
    </tbody>
    </table>

2.  Type the following, and then press **Enter**, where *computer_name* represents a remote computer on which you want to install Windows PowerShell Web Access, if applicable. The <span class="code">Restart</span> parameter automatically restarts destination servers if required.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_374a9c21-4f6e-471e-b957-bb190a594533'); "Copy to clipboard.")

        Install-WindowsFeature -Name WindowsPowerShellWebAccess -ComputerName <computer_name> -IncludeManagementTools -Restart

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><span><img src="https://i-technet.sec.s-msft.com/dynimg/IC101471.jpeg" title="System_CAPS_note" alt="System_CAPS_note" id="s-e6f6a65cf14f462597b64ac058dbe1d0-system-media-system-caps-note" /></span><span class="alertTitle">Note </span></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>Installing Windows PowerShell Web Access by using Windows PowerShell cmdlets does not add Web Server (IIS) management tools by default. If you want to install the management tools on the same server as the Windows PowerShell Web Access gateway, add the <span class="code">IncludeManagementTools</span> parameter to the installation command (as provided in this step). If you are managing the Windows PowerShell Web Access website from a remote computer, install the IIS Manager snap-in by installing <a href="http://go.microsoft.com/fwlink/?LinkID=304145">Remote Server Administration Tools for Windows 8.1</a> or <a href="http://go.microsoft.com/fwlink/p/?LinkID=238560">Remote Server Administration Tools for Windows 8</a> on the computer from which you want to manage the gateway.</p></td>
    </tr>
    </tbody>
    </table>

    To install roles and features on an offline VHD, you must add both the <span class="code">ComputerName</span> parameter and the <span class="code">VHD</span> parameter. The <span class="code">ComputerName</span> parameter contains the name of the server on which to mount the VHD, and the <span class="code">VHD</span> parameter contains the path to the VHD file on the specified server.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_d841d509-347e-49d0-bf54-8d1f306bece6'); "Copy to clipboard.")

        Install-WindowsFeature -Name WindowsPowerShellWebAccess -VHD <path> -ComputerName <computer_name> -IncludeManagementTools -Restart

3.  When installation is complete, verify that Windows PowerShell Web Access was installed on destination servers by running the **Get-WindowsFeature** cmdlet on a destination server, in a Windows PowerShell console that has been opened with elevated user rights. You can also verify that Windows PowerShell Web Access was installed in the Server Manager console, by selecting a destination server on the **All Servers** page, and then viewing the **Roles and Features** tile for the selected server. You can also view the readme file for Windows PowerShell Web Access.

4.  After Windows PowerShell Web Access is installed, you are prompted to review the readme file, which contains basic, required setup instructions for the gateway. These setup instructions are also in the following section, [Step 2: Configure the gateway](#BKMK_step2). The path to the readme file is <span class="computerOutputInline">C:\\Windows\\Web\\PowerShellWebAccess\\wwwroot\\README.txt</span>.

<a href="" id="BKMK_step2"></a>
###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 2: Configure the gateway</span></a>

------------------------------------------------------------------------

The **Install-PswaWebApplication** cmdlet is a quick way to get Windows PowerShell Web Access configured. Although you can add the <span class="code">UseTestCertificate</span> parameter to the <span class="code">Install-PswaWebApplication</span> cmdlet to install a self-signed SSL certificate for test purposes, this is not secure; for a secure production environment, always use a valid SSL certificate that has been signed by a certification authority (CA). Administrators can replace the test certificate with a signed certificate of their choice by using the IIS Manager console.

You can complete Windows PowerShell Web Access web application configuration either by running the <span class="code">Install-PswaWebApplication</span> cmdlet or by performing GUI-based configuration steps in IIS Manager. By default, the cmdlet installs the web application, **pswa** (and an application pool for it, **pswa_pool**), in the **Default Web Site** container, as shown in IIS Manager; if desired, you can instruct the cmdlet to change the default site container of the web application. IIS Manager offers configuration options that are available for web applications, such as changing the port number or the Secure Sockets Layer (SSL) certificate.

<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><span><img src="https://i-technet.sec.s-msft.com/dynimg/IC17938.jpeg" title="System_CAPS_security" alt="System_CAPS_security" id="s-e6f6a65cf14f462597b64ac058dbe1d0-system-media-system-caps-security" /></span><span class="alertTitle"> Security Note </span></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>We strongly recommend that administrators configure the gateway to use a valid certificate that has been signed by a CA.</p></td>
</tr>
</tbody>
</table>

-   [To configure the Windows PowerShell Web Access gateway with a test certificate by using Install-PswaWebApplication](#BKMK_testcert)

-   [To configure the Windows PowerShell Web Access gateway with a genuine certificate by using Install-PswaWebApplication and IIS Manager](#BKMK_gencert)

#### To configure the Windows PowerShell Web Access gateway with a test certificate by using Install-PswaWebApplication

1.  Do one of the following to open a Windows PowerShell session.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar.

    -   On the Windows **Start** screen, click **Windows PowerShell**.

2.  Type the following, and then press **Enter**.

    **Install-PswaWebApplication -UseTestCertificate**

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><span><img src="https://i-technet.sec.s-msft.com/dynimg/IC17938.jpeg" title="System_CAPS_security" alt="System_CAPS_security" id="s-e6f6a65cf14f462597b64ac058dbe1d0-system-media-system-caps-security" /></span><span class="alertTitle"> Security Note </span></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>The <span class="code">UseTestCertificate</span> parameter should only be used in a private test environment. For a secure production environment, we recommend using a valid certificate that has been signed by a CA.</p></td>
    </tr>
    </tbody>
    </table>

    Running the cmdlet installs the Windows PowerShell Web Access web application within the IIS Default Web Site container. The cmdlet creates the infrastructure required to run Windows PowerShell Web Access on the default website, https://&lt;server_name&gt;/pswa. To install the web application in a different website, provide the website name by adding the <span class="code">WebSiteName</span> parameter. To change the name of the web application (the default is <span class="code">pswa</span>), add the <span class="code">WebApplicationName</span> parameter.

    The following settings are configured by running the cmdlet. You can change these manually in the IIS Manager console, if desired.

    -   Path: /pswa

    -   ApplicationPool: pswa_pool

    -   EnabledProtocols: http

    -   PhysicalPath: %*windir*%/Web/PowerShellWebAccess/wwwroot

    <span class="label">Example:</span> <span class="code">Install-PswaWebApplication -webApplicationName myWebApp -useTestCertificate</span>

    In this example, the resulting website for Windows PowerShell Web Access is https://&lt; *server_name*&gt;/myWebApp.

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><span><img src="https://i-technet.sec.s-msft.com/dynimg/IC101471.jpeg" title="System_CAPS_note" alt="System_CAPS_note" id="s-e6f6a65cf14f462597b64ac058dbe1d0-system-media-system-caps-note" /></span><span class="alertTitle">Note </span></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>You cannot sign in until users have been granted access to the website by adding authorization rules. For more information, see <a href="#BKMK_step3">Step 3: Configure a restrictive authorization rule</a> and <a href="https://technet.microsoft.com/en-us/library/dn282394(v=ws.11).aspx">Authorization Rules and Security Features of Windows PowerShell Web Access</a>.</p></td>
    </tr>
    </tbody>
    </table>

#### To configure the Windows PowerShell Web Access gateway with a genuine certificate by using Install-PswaWebApplication and IIS Manager

1.  Do one of the following to open a Windows PowerShell session.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar.

    -   On the Windows **Start** screen, click **Windows PowerShell**.

2.  Type the following, and then press **Enter**.

    **Install-PswaWebApplication**

    The following gateway settings are configured by running the cmdlet. You can change these manually in the IIS Manager console, if desired. You can also specify values for the <span class="code">WebsiteName</span> and <span class="code">WebApplicationName</span> parameters of the <span class="code">Install-PswaWebApplication</span> cmdlet.

    -   Path: /pswa

    -   ApplicationPool: pswa_pool

    -   EnabledProtocols: http

    -   PhysicalPath: %*windir*%/Web/PowerShellWebAccess/wwwroot

3.  Open the IIS Manager console by doing one of the following.

    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar. On the **Tools** menu in Server Manager, click **Internet Information Services (IIS) Manager**.

    -   On the Windows **Start** screen, click **Server Manager**.

4.  In the IIS Manager tree pane, expand the node for the server on which Windows PowerShell Web Access is installed until the **Sites** folder is visible. Expand the **Sites** folder.

5.  Select the website in which you have installed the Windows PowerShell Web Access web application. In the **Actions** pane, click **Bindings**.

6.  In the **Site Binding** dialog box, click **Add**.

7.  In the **Add Site Binding** dialog box, in the **Type** field, select **https**.

8.  In the **SSL certificate** field, select your signed certificate from the drop-down menu. Click **OK**. See [To configure an SSL certificate in IIS Manager](#BKMK_cert) in this topic for more information about how to obtain a certificate.

    The Windows PowerShell Web Access web application is now configured to use your signed SSL certificate. You can access Windows PowerShell Web Access by opening https://&lt;server_name&gt;/pswa in a browser window.

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><span><img src="https://i-technet.sec.s-msft.com/dynimg/IC101471.jpeg" title="System_CAPS_note" alt="System_CAPS_note" id="s-e6f6a65cf14f462597b64ac058dbe1d0-system-media-system-caps-note" /></span><span class="alertTitle">Note </span></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>You cannot sign in until users have been granted access to the website by adding authorization rules. For more information, see <a href="#BKMK_step3">Step 3: Configure a restrictive authorization rule</a> and <a href="https://technet.microsoft.com/en-us/library/dn282394(v=ws.11).aspx">Authorization Rules and Security Features of Windows PowerShell Web Access</a>.</p></td>
    </tr>
    </tbody>
    </table>

<a href="" id="BKMK_step3"></a>
###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 3: Configure a restrictive authorization rule</span></a>

------------------------------------------------------------------------

After Windows PowerShell Web Access is installed and the gateway is configured, users can open the sign-in page in a browser, but they cannot sign in until the Windows PowerShell Web Access administrator grants users access explicitly. Windows PowerShell Web Access access control is managed by using the set of Windows PowerShell cmdlets described in the following table. There is no comparable GUI for adding or managing authorization rules. For more detailed information about Windows PowerShell Web Access cmdlets, see the cmdlet reference topics, [Windows PowerShell Web Access Cmdlets](https://technet.microsoft.com/library/hh918342.aspx).

For more detail about Windows PowerShell Web Access authorization rules and security, see [Authorization Rules and Security Features of Windows PowerShell Web Access](https://technet.microsoft.com/en-us/library/dn282394(v=ws.11).aspx).

#### To add a restrictive authorization rule

1.  Do one of the following to open a Windows PowerShell session with elevated user rights.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.

    -   On the Windows **Start** screen, right-click **Windows PowerShell**, and then click **Run as Administrator**.

2.  <span class="label">Optional step for restricting user access by using session configurations:</span> Verify that session configurations that you want to use in your rules already exist. If they have not yet been created, use instructions for creating session configurations in [about_Session_Configuration_Files](https://msdn.microsoft.com/library/windows/desktop/hh847838.aspx) on MSDN.

3.  Type the following, and then press **Enter**.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_f9e7959b-75d0-4d63-8f8e-02334a8dd09d'); "Copy to clipboard.")

        Add-PswaAuthorizationRule -UserName <domain\user | computer\user> -ComputerName <computer_name> -ConfigurationName <session_configuration_name>

    This authorization rule allows a specific user access to one computer on the network to which they typically have access, with access to a specific session configuration that is scoped to the user’s typical scripting and cmdlet needs. In the following example, a user named <span class="code">JSmith</span> in the <span class="code">Contoso</span> domain is granted access to manage the computer <span class="code">Contoso_214</span>, and use a session configuration named <span class="code">NewAdminsOnly</span>.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_ebd5bc5e-ec5d-4955-a86a-63843e480e37'); "Copy to clipboard.")

        Add-PswaAuthorizationRule -UserName Contoso\JSmith -ComputerName Contoso_214 -ConfigurationName NewAdminsOnly

4.  Verify that the rule has been created by running either the **Get-PswaAuthorizationRule** cmdlet, or **Test-PswaAuthorizationRule -UserName &lt;domain\\user | computer\\user&gt; -ComputerName** &lt;computer_name&gt;. For example, **Test-PswaAuthorizationRule -UserName Contoso\\JSmith -ComputerName Contoso_214**.

After you have configured an authorization rule, you are ready for authorized users to sign in to the web-based console and begin using Windows PowerShell Web Access.

<a href="" id="BKMK_custom"></a>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Custom deployment</span></a>
<a href="/en-us/library/hh831611(v=ws.11).aspx#Anchor_3" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

You can install the Windows PowerShell Web Access gateway on a server that is running Windows Server 2012 R2 or Windows Server 2012 by using the Add Roles and Features Wizard in Server Manager. After Windows PowerShell Web Access is installed, you can customize the configuration of the gateway in IIS Manager.

<a href="" id="BKMK_custom1"></a>
###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 1: Install Windows PowerShell Web Access</span></a>

------------------------------------------------------------------------

#### To install Windows PowerShell Web Access by using the Add Roles and Features Wizard

1.  If Server Manager is already open, go on to the next step. If Server Manager is not already open, open it by doing one of the following.

    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar.

    -   On the Windows **Start** screen, click **Server Manager**.

2.  On the **Manage** menu, click **Add Roles and Features**.

3.  On the **Select installation type** page, select **Role-based or feature-based installation**. Click **Next**.

4.  On the **Select destination server** page, select a server from the server pool, or select an offline VHD. To select an offline VHD as your destination server, first select the server on which to mount the VHD, and then select the VHD file. For information about how to add servers to your server pool, see the Server Manager Help. After you have selected the destination server, click **Next**.

5.  On the **Select features** page of the wizard, expand **Windows PowerShell**, and then select **Windows PowerShell Web Access**.

6.  Note that you are prompted to add required features, such as .NET Framework 4.5, and role services of Web Server (IIS). Add required features and continue.

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><span><img src="https://i-technet.sec.s-msft.com/dynimg/IC101471.jpeg" title="System_CAPS_note" alt="System_CAPS_note" id="s-e6f6a65cf14f462597b64ac058dbe1d0-system-media-system-caps-note" /></span><span class="alertTitle">Note </span></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>Installing Windows PowerShell Web Access by using the Add Roles and Features Wizard also installs Web Server (IIS), including the IIS Manager snap-in. The snap-in and other IIS management tools are installed by default if you use Add Roles and Features Wizard. If you install Windows PowerShell Web Access by using Windows PowerShell cmdlets as described in the following procedure, management tools are not added by default.</p></td>
    </tr>
    </tbody>
    </table>

7.  On the **Confirm installation selections** page, if the feature files for Windows PowerShell Web Access are not stored on the destination server that you selected in step 4, click **Specify an alternate source path**, and provide the path to the feature files. Otherwise, click **Install**.

8.  After you click **Install**, the **Installation progress** page displays installation progress, results, and messages such as warnings, failures, or post-installation configuration steps that are required for Windows PowerShell Web Access. After Windows PowerShell Web Access is installed, you are prompted to review the readme file, which contains basic, required setup instructions for the gateway. These instructions are also included in this topic. The path to the readme file is <span class="computerOutputInline">C:\\Windows\\Web\\PowerShellWebAccess\\wwwroot\\README.txt</span>.

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 2: Configure the gateway</span></a>

------------------------------------------------------------------------

Instructions in this section are for installing the Windows PowerShell Web Access web application in a subdirectory—and not in the root directory—of your website. This procedure is the GUI-based equivalent of the actions performed by the <span class="code">Install-PswaWebApplication</span> cmdlet. This section also includes instructions for how to use IIS Manager to configure the Windows PowerShell Web Access gateway as a root website.

-   [To use IIS Manager to configure the gateway in an existing website](#BKMK_configman)

-   [To use IIS Manager to configure the gateway as a root website with a test certificate](#BKMK_configroot)

-   

#### To use IIS Manager to configure the gateway in an existing website

1.  Open the IIS Manager console by doing one of the following.

    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar. On the **Tools** menu in Server Manager, click **Internet Information Services (IIS) Manager**.

    -   On the Windows **Start** screen, type any part of the name **Internet Information Services (IIS) Manager**. Click the shortcut when it is displayed in the **Apps** results.

2.  Create a new application pool for Windows PowerShell Web Access. Expand the node of the gateway server in the IIS Manager tree pane, select **Application Pools**, and click **Add Application Pool** in the **Actions** pane.

3.  Add a new application pool with the name **pswa_pool**, or provide another name. Click **OK**.

4.  In the IIS Manager tree pane, expand the node for the server on which Windows PowerShell Web Access is installed until the **Sites** folder is visible. Select the **Sites** folder.

5.  Right-click the website (for example, **Default Web Site**) to which you would like to add the Windows PowerShell Web Access website, and then click **Add Application**.

6.  In the **Alias** field, type pswa, or provide another alias. The alias becomes the virtual directory name. For example, **pswa** in the following URL represents the alias specified in this step: https://&lt;server_name&gt;/pswa.

7.  In the **Application pool** field, select the application pool that you created in step 3.

8.  In the **Physical path** field, browse for the location of the application. You can use the default location, %windir%/Web/PowerShellWebAccess/wwwroot. Click **OK**.

9.  Follow the steps in the procedure [To configure an SSL certificate in IIS Manager](#BKMK_cert) in this topic.

10. <span class="label">Optional security step:</span> With the website selected in the tree pane, double-click **SSL Settings** in the content pane. Select **Require SSL**, and then in the **Actions** pane, click **Apply**. Optionally, in the **SSL Settings** pane, you can require that users connecting to the Windows PowerShell Web Access website have client certificates. Client certificates help to verify the identity of a client device user. For more information about how requiring client certificates can increase the security of Windows PowerShell Web Access, see [Authorization Rules and Security Features of Windows PowerShell Web Access](https://technet.microsoft.com/en-us/library/dn282394(v=ws.11).aspx) in this guide.

11. Open a browser session on a client device. For more information about supported browsers and devices, see [Browser and client device support](#BKMK_browser) in this topic.

12. Open the new Windows PowerShell Web Access website, https://&lt; *gateway_server_name*&gt;/pswa.

    The browser should display the Windows PowerShell Web Access console sign-in page.

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><span><img src="https://i-technet.sec.s-msft.com/dynimg/IC101471.jpeg" title="System_CAPS_note" alt="System_CAPS_note" id="s-e6f6a65cf14f462597b64ac058dbe1d0-system-media-system-caps-note" /></span><span class="alertTitle">Note </span></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>You cannot sign in until users have been granted access to the website by adding authorization rules.</p></td>
    </tr>
    </tbody>
    </table>

13. In a Windows PowerShell session that has been opened with elevated user rights (Run as Administrator), run the following script, in which *application_pool_name* represents the name of the application pool that you created in step 3, to give the application pool access rights to the authorization file.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_c1a80a93-8fcf-4beb-a025-5f81bfb8bdae'); "Copy to clipboard.")

        $applicationPoolName = "<application_pool_name>"
        $authorizationFile = "C:\windows\web\powershellwebaccess\data\AuthorizationRules.xml"
        c:\windows\system32\icacls.exe $authorizationFile /grant ('"' + "IIS AppPool\$applicationPoolName" + '":R') > $null

    To view existing access rights on the authorization file, run the following command:

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_ac2179c2-9548-4a17-8663-267fdd105380'); "Copy to clipboard.")

        c:\windows\system32\icacls.exe $authorizationFile

#### To use IIS Manager to configure the gateway as a root website with a test certificate

1.  Open the IIS Manager console by doing one of the following.

    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar. On the **Tools** menu in Server Manager, click **Internet Information Services (IIS) Manager**.

    -   On the Windows **Start** screen, type any part of the name **Internet Information Services (IIS) Manager**. Click the shortcut when it is displayed in the **Apps** results.

2.  In the IIS Manager tree pane, expand the node for the server on which Windows PowerShell Web Access is installed until the **Sites** folder is visible. Select the **Sites** folder.

3.  In the **Actions** pane, click **Add Website**.

4.  Type a name for the website, such as **Windows PowerShell Web Access**.

5.  An application pool is automatically created for the new website. To use a different application pool, click **Select** to select an application pool to associate with the new website. Select the alternate application pool in the **Select Application Pool** dialog box, and then click **OK**.

6.  In the **Physical path** text box, navigate to %*windir*%/Web/PowerShellWebAccess/wwwroot.

7.  In the **Type** field of the **Binding** area, select **https**.

8.  Assign a port number to the website that is not already in use by another site or application. To locate open ports, you can run the **netstat** command in a Command Prompt window. The default port number is 443.

    Change the default port if another website is already using 443, or if you have other security reasons for changing the port number. If another website that is running on your gateway server is using your selected port, a warning is displayed when you click **OK** in the **Add Website** dialog box. You must use an unused port to run Windows PowerShell Web Access.

9.  Optionally, if needed for your organization, specify a host name that makes sense to your organization and users, such as **www.contoso.com**. Click **OK**.

10. For a more secure production environment, we strongly recommend providing a valid certificate that has been signed by a CA. You must provide an SSL certificate, because users can only connect to Windows PowerShell Web Access through an HTTPS website. See [To configure an SSL certificate in IIS Manager](#BKMK_cert) in this topic for more information about how to obtain a certificate.

11. Click **OK** to close the **Add Website** dialog box.

12. In a Windows PowerShell session that has been opened with elevated user rights (Run as Administrator), run the following script, in which *application_pool_name* represents the name of the application pool that you created in step 4, to give the application pool access rights to the authorization file.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_35ae9944-ca44-4af7-9c96-616083b3e3db'); "Copy to clipboard.")

        $applicationPoolName = "<application_pool_name>"
        $authorizationFile = "C:\windows\web\powershellwebaccess\data\AuthorizationRules.xml"
        c:\windows\system32\icacls.exe $authorizationFile /grant ('"' + "IIS AppPool\$applicationPoolName" + '":R') > $null

    To view existing access rights on the authorization file, run the following command:

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_0eb6d70a-2807-498b-b088-fa5233ed68d5'); "Copy to clipboard.")

        c:\windows\system32\icacls.exe $authorizationFile

13. With the new website selected in the IIS Manager tree pane, click **Start** in the **Actions** pane to start the website.

14. Open a browser session on a client device. For more information about supported browsers and devices, see [Browser and client device support](#BKMK_browser) in this document.

15. Open the new Windows PowerShell Web Access website.

    Because the root website points to the Windows PowerShell Web Access folder, the browser should display the Windows PowerShell Web Access sign-in page when you open https://&lt; *gateway_server_name*&gt;. You should not need to add **/pswa** to the URL.

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><span><img src="https://i-technet.sec.s-msft.com/dynimg/IC101471.jpeg" title="System_CAPS_note" alt="System_CAPS_note" id="s-e6f6a65cf14f462597b64ac058dbe1d0-system-media-system-caps-note" /></span><span class="alertTitle">Note </span></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>You cannot sign in until users have been granted access to the website by adding authorization rules.</p></td>
    </tr>
    </tbody>
    </table>

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 3: Configure a restrictive authorization rule</span></a>

------------------------------------------------------------------------

After Windows PowerShell Web Access is installed and the gateway is configured, users can open the sign-in page in a browser, but they cannot sign in until the Windows PowerShell Web Access administrator grants users access explicitly. Windows PowerShell Web Access access control is managed by using the set of Windows PowerShell cmdlets described in the following table. There is no comparable GUI for adding or managing authorization rules. For more detailed information about Windows PowerShell Web Access cmdlets, see the cmdlet reference topics, [Windows PowerShell Web Access Cmdlets](https://technet.microsoft.com/library/hh918342.aspx).

For more detail about Windows PowerShell Web Access authorization rules and security, see [Authorization Rules and Security Features of Windows PowerShell Web Access](https://technet.microsoft.com/en-us/library/dn282394(v=ws.11).aspx).

#### To add a restrictive authorization rule

1.  Do one of the following to open a Windows PowerShell session with elevated user rights.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.

    -   On the Windows **Start** screen, right-click **Windows PowerShell**, and then click **Run as Administrator**.

2.  <span class="label">Optional step for restricting user access by using session configurations:</span> Verify that session configurations that you want to use in your rules already exist. If they have not yet been created, use instructions for creating session configurations in [about_Session_Configuration_Files](https://msdn.microsoft.com/library/windows/desktop/hh847838.aspx) on MSDN.

3.  Type the following, and then press **Enter**.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_4df22c91-f56f-4bb5-91e7-99f9b365ed5d'); "Copy to clipboard.")

        Add-PswaAuthorizationRule -UserName <domain\user | computer\user> -ComputerName <computer_name> -ConfigurationName <session_configuration_name>

    This authorization rule allows a specific user access to one computer on the network to which they typically have access, with access to a specific session configuration that is scoped to the user’s typical scripting and cmdlet needs. In the following example, a user named <span class="code">JSmith</span> in the <span class="code">Contoso</span> domain is granted access to manage the computer <span class="code">Contoso_214</span>, and use a session configuration named <span class="code">NewAdminsOnly</span>.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_efc3999a-2905-453f-86cd-014b41658ffc'); "Copy to clipboard.")

        Add-PswaAuthorizationRule -UserName Contoso\JSmith -ComputerName Contoso_214 -ConfigurationName NewAdminsOnly

4.  Verify that the rule has been created by running either the **Get-PswaAuthorizationRule** cmdlet, or **Test-PswaAuthorizationRule -UserName &lt;domain\\user | computer\\user&gt; -ComputerName** &lt;computer_name&gt;. For example, **Test-PswaAuthorizationRule -UserName Contoso\\JSmith -ComputerName Contoso_214**.

After you have configured an authorization rule, you are ready for authorized users to sign in to the web-based console and begin using Windows PowerShell Web Access.

<a href="" id="BKMK_configcert"></a>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Configure a genuine certificate</span></a>
<a href="/en-us/library/hh831611(v=ws.11).aspx#Anchor_4" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

For a secure production environment, always use a valid SSL certificate that has been signed by a certification authority (CA). The procedure in this section describes how to obtain and apply a valid SSL certificate from a CA.

### To configure an SSL certificate in IIS Manager

1.  In the IIS Manager tree pane, select the server on which Windows PowerShell Web Access is installed.

2.  In the content pane, double click **Server Certificates**.

3.  In the **Actions** pane, do one of the following. For more information about configuring server certificates in IIS, see [Configuring Server Certificates in IIS 7](https://technet.microsoft.com/library/cc732230.aspx).

    -   Click **Import** to import an existing, valid certificate from a location on your network.

    -   Click **Create Certificate Request** to request a certificate from a CA such as VeriSign™, Thawte, or GeoTrust®. The certificate's common name must match the host header in the request. For example, if the client browser requests http://www.contoso.com/, then the common name must also be http://www.contoso.com/. This is the most secure and recommended option for providing the Windows PowerShell Web Access gateway with a certificate.

    -   Click **Create a Self-Signed Certificate** to create a certificate that you can use immediately, and have signed later by a CA if desired. Specify a friendly name for the self-signed certificate, such as **Windows PowerShell Web Access**. This option is not considered secure, and is recommended only for a private test environment.

4.  After creating or obtaining a certificate, select the website to which the certificate is applied (for example, **Default Web Site**) in the IIS Manager tree pane, and then click **Bindings** in the **Actions** pane.

5.  In the **Add Site Binding** dialog box, add an **https** binding for the site, if one is not already displayed. If you are not using a self-signed certificate, specify the host name from step 3 of this procedure. If you are using a self-signed certificate, this step is not required.

6.  Select the certificate that you obtained or created in step 3 of this procedure, and then click **OK**.

<a href="" id="BKMK_using"></a>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Using the web-based Windows PowerShell console</span></a>
<a href="/en-us/library/hh831611(v=ws.11).aspx#Anchor_5" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

After Windows PowerShell Web Access is installed and the gateway configuration is finished as described in this topic, the Windows PowerShell web-based console is ready to use. For more information about getting started in the web-based console, see [Use the Web-based Windows PowerShell Console](https://technet.microsoft.com/en-us/library/hh831417(v=ws.11).aspx).

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">See Also</span></a>
<a href="/en-us/library/hh831611(v=ws.11).aspx#Anchor_6" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

[Internet Information Services (IIS) 7.0 Documentation](https://technet.microsoft.com/library/cc753433.aspx)
[IIS Manager 7.0 Help](https://technet.microsoft.com/library/cc732664.aspx)
[Configure Web Server Security (IIS 7)](https://technet.microsoft.com/library/cc731278.aspx)
[IPsec Deployment Resources](https://technet.microsoft.com/network/bb531150)

<span>Show:</span> Inherited Protected

<span class="stdr-votetitle">Was this page helpful?</span>
Yes
No

Additional feedback?

<span class="stdr-count"><span class="stdr-charcnt">1500</span> characters remaining</span>
Submit
Skip this

<span class="stdr-thankyou">Thank you!</span> <span class="stdr-appreciate">We appreciate your feedback.</span>

[Manage Your Profile](https://social.technet.microsoft.com/profile)

|

<a href="javascript:void(0)" id="SiteFeedbackLinkOpener"><span id="FeedbackButton" class="FeedbackButton clip20x21"> <img src="https://i-technet.sec.s-msft.com/Areas/Epx/Content/Images/ImageSprite.png?v=635975720914499532" alt="Site Feedback" id="feedBackImg" class="cl_footer_feedback_icon" /> </span> Site Feedback</a>
Site Feedback

<a href="javascript:void(0)" id="SiteFeedbackLinkCloser">x</a>

Tell us about your experience...

Did the page load quickly?

<span> Yes<span> </span></span> <span> No<span> </span></span>

Do you like the page design?

<span> Yes<span> </span></span> <span> No<span> </span></span>

Tell us more

-   [Flash Newsletter](https://technet.microsoft.com/cc543196.aspx)
-   |
-   [Contact Us](https://technet.microsoft.com/cc512759.aspx)
-   |
-   [Privacy Statement](https://privacy.microsoft.com/privacystatement)
-   |
-   [Terms of Use](https://technet.microsoft.com/cc300389.aspx)
-   |
-   [Trademarks](https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/)
-   |

© 2016 Microsoft

© 2016 Microsoft

Third party scripts and code linked to or referenced from this website are licensed to you by the parties that own such code, not by Microsoft. See ASP.NET Ajax CDN Terms of Use - http://www.asp.net/ajaxlibrary/CDN.ashx.
<img src="https://m.webtrends.com/dcsjwb9vb00000c932fd0rjc7_5p3t/njs.gif?dcsuri=/nojavascript&amp;WT.js=No" alt="DCSIMG" id="Img1" width="1" height="1" />

