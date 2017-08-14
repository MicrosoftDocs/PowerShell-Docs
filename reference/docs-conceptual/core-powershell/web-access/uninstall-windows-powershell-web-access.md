---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  uninstall windows powershell web access
---

#  Uninstall Windows PowerShell Web Access

Updated: June 24, 2013

Applies To: Windows Server 2012 R2, Windows Server 2012

Follow steps in this topic to delete the Windows PowerShell Web Access website and application from the gateway server that is running either Windows Server 2012 R2 or Windows Server 2012. Before you begin, notify users of the web-based console that you are removing the website.

<a href="" id="BKMK_uninstall"></a>

------------------------------------------------------------------------

Before you uninstall Windows PowerShell Web Access from the gateway server, either run the `Uninstall-PswaWebApplication` cmdlet to remove the website and Windows PowerShell Web Access web applications, or use the IIS Manager procedure, [to delete the windows powershell web access website and web applications by using iis manager](#bkmk_delsite).

Uninstalling Windows PowerShell Web Access does not uninstall IIS or any other features that were installed automatically because Windows PowerShell Web Access requires them to run. The uninstallation process leaves features installed upon which Windows PowerShell Web Access was dependent; you can uninstall those features separately if needed.

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Recommended (quick) uninstallation</span></a>
<a href="/en-us/library/dn282396(v=ws.11).aspx#Anchor_1" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

Procedures in this section help you uninstall both the Windows PowerShell Web Access web application and the Windows PowerShell Web Access feature by using Windows PowerShell cmdlets.

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 1: Delete the web application</span></a>

------------------------------------------------------------------------

If you have specified your own, custom website name, add the `WebsiteName` parameter to your command, and specify the website name. If you have used a custom web application (not the default application, **pswa**, add the `WebApplicationName` parameter to your command, and specify the name of the web application.

#### To delete the website and web applications by using the Uninstall-PswaWebApplication cmdlet

1.  Do one of the following to open a Windows PowerShell session.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar.

    -   On the Windows **Start** screen, click **Windows PowerShell**.

2.  Type **Uninstall-PswaWebApplication**, and then press **Enter**.

3.  If you are using a test certificate, add the `DeleteTestCertificate` parameter to the cmdlet, as shown in the following example.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_28147344-ab2f-49e7-b1c2-6dbe649d4366'); "Copy to clipboard.")

        Uninstall-PswaWebApplication -DeleteTestCertificate

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 2: Uninstall Windows PowerShell Web Access</span></a>

------------------------------------------------------------------------

#### To uninstall Windows PowerShell Web Access by using Windows PowerShell cmdlets

1.  Do one of the following to open a Windows PowerShell session with elevated user rights. If a session is already open, go on to the next step.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.

    -   On the Windows **Start** screen, right-click **Windows PowerShell**, and then click **Run as Administrator**.

2.  Type the following, and then press **Enter**, where *computer_name* represents a remote server from which you want to remove Windows PowerShell Web Access. The `-Restart` parameter automatically restarts destination servers if required by the removal.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_7b534520-f292-471f-89e3-a1079c03e369'); "Copy to clipboard.")

        Uninstall-WindowsFeature -Name WindowsPowerShellWebAccess -ComputerName <computer_name> -Restart

    To remove roles and features from an offline VHD, you must add both the `-ComputerName` parameter and the `-VHD` parameter. The `-ComputerName` parameter contains the name of the server on which to mount the VHD, and the `-VHD` parameter contains the path to the VHD file on the specified server.

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_5d8f91ee-b91a-4653-b7df-e745187fd72d'); "Copy to clipboard.")

        Uninstall-WindowsFeature -Name WindowsPowerShellWebAccess -VHD <path> -ComputerName <computer_name> -Restart

3.  When removal is finished, verify that you removed Windows PowerShell Web Access by opening the **All Servers** page in Server Manager, selecting a server from which you removed the feature, and viewing the **Roles and Features** tile on the page for the selected server. You can also run the `Get-WindowsFeature` cmdlet targeted at the selected server (Get-WindowsFeature -ComputerName &lt;*computer_name*&gt;) to view a list of roles and features that are installed on the server.

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Custom uninstallation</span></a>
<a href="/en-us/library/dn282396(v=ws.11).aspx#Anchor_2" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

Procedures in this section help you uninstall both the Windows PowerShell Web Access web application and the Windows PowerShell Web Access feature by using the Remove Roles and Features Wizard in Server Manager, and the IIS Manager console.

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 1: Delete the web application</span></a>

------------------------------------------------------------------------

#### To delete the Windows PowerShell Web Access website and web applications by using IIS Manager

1.  Open the IIS Manager console by doing one of the following. If it is already open, go on to the next step.

    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar. On the **Tools** menu in Server Manager, click **Internet Information Services (IIS) Manager**.

    -   On the Windows **Start** screen, type any part of the name **Internet Information Services (IIS) Manager**. Click the shortcut when it is displayed in the **Apps** results.

2.  In the IIS Manager tree pane, select the website that is running the Windows PowerShell Web Access web application.

3.  In the **Actions** pane, under **Manage Website**, click **Stop**.

4.  In the tree pane, right-click the web application in the website that is running the Windows PowerShell Web Access web application, and then click **Remove**.

5.  In the tree pane, select **Application Pools**, select the Windows PowerShell Web Access application pool folder, click **Stop** in the **Actions** pane, and then click **Remove** in the content pane.

6.  Close IIS Manager.

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
    <td><p>The certificate is not deleted during uninstallation. If you created a self-signed certificate or used a test certificate and want to remove it, delete the certificate in IIS Manager.</p></td>
    </tr>
    </tbody>
    </table>

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Step 2: Uninstall Windows PowerShell Web Access</span></a>

------------------------------------------------------------------------

#### To uninstall Windows PowerShell Web Access by using the Remove Roles and Features Wizard

1.  If Server Manager is already open, go on to the next step. If Server Manager is not already open, open it by doing one of the following.

    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar.

    -   On the Windows **Start** screen, click **Server Manager**.

2.  On the **Manage** menu, click **Remove Roles and Features**.

3.  On the **Select destination server** page, select the server or offline VHD from which you want to remove the feature. To select an offline VHD, first select the server on which to mount the VHD, and then select the VHD file. After you have selected the destination server, click **Next**.

4.  Click **Next** again to skip to the **Remove features** page.

5.  Clear the check box for **Windows PowerShell Web Access**, and then click **Next**.

6.  On the **Confirm removal selections** page, click **Remove**.

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">See Also</span></a>
<a href="/en-us/library/dn282396(v=ws.11).aspx#Anchor_3" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

[Install and Use Windows PowerShell Web Access](https://technet.microsoft.com/en-us/library/hh831611(v=ws.11).aspx)
[IIS Manager 7.0 Help](https://technet.microsoft.com/library/cc732664.aspx)

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

