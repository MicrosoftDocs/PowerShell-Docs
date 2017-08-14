---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  use the web based windows powershell console
---

#  Use the Web-based Windows PowerShell Console

Updated: June 24, 2013

Applies To: Windows Server 2012 R2, Windows Server 2012

Windows PowerShell® Web Access lets Windows PowerShell® users sign in to a Secure Sockets Layer (SSL)-secured website to use Windows PowerShell sessions, cmdlets, and scripts to manage a remote computer. Because the Windows PowerShell console runs in a web browser, it can be opened from a variety of client devices, including cell phones, tablet computers, public computing kiosks, laptop computers, or shared or borrowed computers. The web-based Windows PowerShell console is targeted at a remote computer that is specified by users as part of the sign-in process. This topic describes how to sign in to and start using the Windows PowerShell Web Access web-based console.

This topic does not describe how to use Windows PowerShell or run cmdlets or scripts. For information about how to use Windows PowerShell, and scripting resources, see the See Also section at the end of this topic.

In this topic:

-   [supported browsers and client devices](#bkmk_browser)

-   [signing in to windows powershell web access](#bkmk_sign)

-   [signing out and timing out](#bkmk_timeout)

-   [differences in the web-based windows powershell console](#bkmk_web)

<a href="" id="BKMK_browser"></a>
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

<a href="" id="BKMK_sign"></a>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Signing in to Windows PowerShell Web Access</span></a>
<a href="/en-us/library/hh831417(v=ws.11).aspx#Anchor_1" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

Your Windows PowerShell Web Access administrator should provide you with a URL that is the address of your organization’s Windows PowerShell Web Access gateway website. By default, this website address is https://&lt;server_name&gt;/pswa. Before you sign in to Windows PowerShell Web Access, be sure that you have the name or IP address of the remote computer that you want to manage. You must be an authorized user on the remote computer, and it must be configured to allow remote management. For more information about configuring your computer to allow remote management, see [Enable and Use Remote Commands in Windows PowerShell](https://technet.microsoft.com/magazine/ff700227.aspx). The simplest method of configuring your computer to allow remote management is to run the **Enable-PSRemoting -force** cmdlet on the computer, in a Windows PowerShell session that has been opened with elevated user rights (**Run as Administrator**).

### To sign in to Windows PowerShell Web Access

1.  Open the Windows PowerShell Web Access website in an Internet browser window or tab.

2.  On the Windows PowerShell Web Access sign-in page, provide your network user name, password, and the name of the computer that you want to manage (and on which you are an authorized user). If the Windows PowerShell Web Access administrator has instructed you to use a URI to a custom site or proxy server instead of a computer name, select **Connection URI** in the **Connection type** field, and then provide the URI.

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
    <td><ul>
    <li><p>If the destination computer is in a workgroup, use the following syntax to provide your user name and sign in to the computer:&lt;<em>workgroup_name</em>&gt;\&lt;<em>user_name</em>&gt;.</p></li>
    <li><p>If the destination computer is the gateway server, you can specify <strong>localhost</strong> in the <strong>Computer name</strong> field.</p></li>
    <li><p>If the destination computer is the gateway server, and the gateway server is in a workgroup, you can use <strong>localhost</strong> in the <strong>Computer name</strong> field, but do not use localhost\&lt;<em>user_name</em>&gt; in the <strong>User name</strong> field. You must use &lt;<em>workgroup name</em>&gt;\&lt;<em>user_name</em>&gt;.</p></li>
    </ul></td>
    </tr>
    </tbody>
    </table>

3.  The **Optional Connection Settings** section relates to the authorization requirements of the remote computer that you want to manage. For more information about the parameters that are equivalent to optional connection settings, see the [Enter-PSSession cmdlet Help](https://technet.microsoft.com/library/dd315384.aspx).

    Typically, the credentials you use to pass through the Windows PowerShell Web Access gateway are the same that are recognized by the remote computer that you want to manage. However, if you want to use different credentials to manage the remote computer that you specified in step 2, expand the **Optional Connection Settings** section, and provide the alternate credentials. Otherwise, skip to step 6.

4.  If the Windows PowerShell Web Access administrator has created a custom session configuration for Windows PowerShell Web Access users, type the name of the session configuration name in the **Configuration name** field. For more information about session configurations, see [about_Session_Configurations](https://technet.microsoft.com/library/dd819508.aspx) on the Microsoft website.

5.  Keep the **Authentication type** set to **Default** unless you have been instructed to do otherwise by the Windows PowerShell Web Access administrator.

6.  Click **Sign in**.

<a href="" id="BKMK_timeout"></a>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Signing out and timing out</span></a>
<a href="/en-us/library/hh831417(v=ws.11).aspx#Anchor_2" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

Any of the following signs you out of a web-based Windows PowerShell session.

-   Clicking **Sign out** in the lower right corner of the console. (Windows Server 2012 only)

-   Clicking **Save** or **Exit** in the lower right corner of the console (Windows Server 2012 R2 only). Clicking **Save** saves and closes your Windows PowerShell Web Access session; you can reconnect to the session later. When you sign in to Windows PowerShell Web Access again, Windows PowerShell Web Access displays a list of your saved sessions; you can either select and reconnect to a saved session, or start a new session. The maximum number of open sessions that users are allowed, both saved and active, is configured by the gateway administrator.

    Clicking **Exit** signs you out of the Windows PowerShell Web Access session without saving it.

-   Attempting to sign in to manage a different remote computer in the same browser session, or in a new tab of the same browser session. (This does not apply if the gateway server is running Windows Server 2012 R2; Windows PowerShell Web Access running on Windows Server 2012 R2 does allow multiple user sessions in new tabs in the same browser session.) For more information about how to use more than one active session on the same computer, see “Connecting to multiple target computers simultaneously” in the [limitations of the web-based console](#bkmk_limits) section of this topic.

-   20 minutes of inactivity in the session. The gateway administrator can customize the inactivity time-out period; for more information, see [session management](https://technet.microsoft.com/en-us/library/dn282394(v=ws.11).aspx#bkmk_sesmgmt).

    -   If you are disconnected from a session in the web-based console because of a network error or other unplanned shutdown or failure, and not because you have closed the session yourself, the Windows PowerShell Web Access session continues to run, connected to the target computer, until the time-out period on the client side lapses. By default, this time-out period is 20 minutes, and is configured by the gateway administrator. The session is disconnected after either the default 20 minutes, or after the time-out period specified by the gateway administrator, whichever is shorter.

        If the gateway server is running Windows Server 2012 R2, Windows PowerShell Web Access lets users reconnect to saved sessions at a later time, but you cannot see or reconnect to saved sessions until after the time-out period specified by the gateway administrator has lapsed.

-   Closing the browser window or tab.

-   Turning off the client device on which the browser is running, or disconnecting it from the network.

-   Running the **Exit** command in the web console. This command does not work if the session configuration to which you are connected to is configured to support [NoLanguage](https://msdn.microsoft.com/library/windows/desktop/system.management.automation.pslanguagemode.aspx) mode, or is in a restricted runspace.

If you want to sign in again, open the Windows PowerShell Web Access web page again, and sign in by following the steps in [to sign in to windows powershell web access](#bkmk_signin) in this topic.

<a href="" id="BKMK_web"></a>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Differences in the web-based Windows PowerShell console</span></a>
<a href="/en-us/library/hh831417(v=ws.11).aspx#Anchor_3" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

After signing in to Windows PowerShell Web Access, a web-based Windows PowerShell console opens in your browser window or tab. Because the console is connected to the remote computer that you specified during the sign-in process, only those Windows PowerShell cmdlets or scripts that are available on the remote computer can be used in the console. This section describes other limitations of Windows PowerShell Web Access consoles, and differences between Windows PowerShell Web Access consoles and the installed **PowerShell.exe** console.

###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Functional disparity with PowerShell.exe</span></a>

------------------------------------------------------------------------

The majority of Windows PowerShell host functionality is available in the Windows PowerShell Web Access web-based console, but there are some features that are not available.

-   <span class="label">Nested progress displays.</span>  Windows PowerShell Web Access displays a progress GUI for cmdlets that report progress, but only top-level progress information is displayed.

-   <span class="label">Input color modification.</span>  The input color (both foreground and background) cannot be changed. The style of output, warning, verbose, and error messages can all be changed by running a script.

-   <span class="label">PSHostRawUserInterface.</span>  Windows PowerShell Web Access is implemented over Windows PowerShell remote management, and uses a remote runspace. Windows PowerShell Web Access does not implement some methods in this interface; for example, any command that writes to the Windows console. Commands such as **PowerTab** do not work in Windows PowerShell Web Access.

-   <span class="label">Function keys.</span>  Windows PowerShell Web Access does not support some function keys, in many cases because the commands are reserved by the browser.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Unsupported Function Key</p></th>
<th><p>Action</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Ctrl+C</p></td>
<td><p>In Windows PowerShell Web Access, <strong>Ctrl+C</strong> is used by the browser to copy content. The console offers a <strong>Cancel</strong> button, and users can also use <strong>Ctrl+Q</strong> to cancel commands.</p></td>
</tr>
<tr class="even">
<td><p>Alt-space, e, l</p></td>
<td><p>Scroll through the screen buffer</p></td>
</tr>
<tr class="odd">
<td><p>Alt+Space, e, f</p></td>
<td><p>Search for text in the screen buffer</p></td>
</tr>
<tr class="even">
<td><p>Alt+Space, e, k</p></td>
<td><p>Select text to be copied from the screen buffer</p></td>
</tr>
<tr class="odd">
<td><p>Alt+Space, e, p</p></td>
<td><p>Paste clipboard contents into the Windows PowerShell console</p></td>
</tr>
<tr class="even">
<td><p>Alt+Space, c</p></td>
<td><p>Close the Windows PowerShell console</p></td>
</tr>
<tr class="odd">
<td><p>Ctrl+Break</p></td>
<td><p>Force the Windows PowerShell window to close</p></td>
</tr>
<tr class="even">
<td><p>Ctrl+Home</p></td>
<td><p>Deletes from the beginning of the current command line</p></td>
</tr>
<tr class="odd">
<td><p>Ctrl+End</p></td>
<td><p>Deletes to end of the command line</p></td>
</tr>
<tr class="even">
<td><p>F1</p></td>
<td><p>Move cursor one character to the right on your command line</p></td>
</tr>
<tr class="odd">
<td><p>F2</p></td>
<td><p>Creates a new command by copying your last command up to the character that you type</p></td>
</tr>
<tr class="even">
<td><p>F3</p></td>
<td><p>Complete the command line with content from your last command line</p></td>
</tr>
<tr class="odd">
<td><p>F4</p></td>
<td><p>Deletes characters from cursor position</p></td>
</tr>
<tr class="even">
<td><p>F5</p></td>
<td><p>Scan backward through your command history. To access commands in the command history in Windows PowerShell Web Access, click the <strong>History</strong> scroll buttons in the web-based console.</p></td>
</tr>
<tr class="odd">
<td><p>F7</p></td>
<td><p>Interactively select a command from your command history</p></td>
</tr>
<tr class="even">
<td><p>F8</p></td>
<td><p>Scan history displaying commands that match current text</p></td>
</tr>
<tr class="odd">
<td><p>F9</p></td>
<td><p>Run a specific numbered command from history</p></td>
</tr>
<tr class="even">
<td><p>Page Up</p></td>
<td><p>Run the first command in the history</p></td>
</tr>
<tr class="odd">
<td><p>Page Down</p></td>
<td><p>Run the last command in the history</p></td>
</tr>
<tr class="even">
<td><p>Alt+F7</p></td>
<td><p>Clear the command history list</p></td>
</tr>
</tbody>
</table>

<a href="" id="BKMK_limits"></a>
###

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Limitations of the web-based console</span></a>

------------------------------------------------------------------------

-   <span class="label">Double-hop.</span>   You can encounter the double-hop (or connecting to a second computer from the first connection) limitation if you try to create or work on a new session by using Windows PowerShell Web Access. Windows PowerShell Web Access uses a remote runspace, and currently, **PowerShell.exe** does not support establishing a remote connection to a second computer from a remote runspace. If you attempt to connect to a second remote computer from an existing connection by using the **Enter-PSSession** cmdlet, for example, you can get various errors, such as “Cannot get network resources.”

    To avoid double-hop errors, your administrator should configure CredSSP authentication in your organization’s network environment. For more information about configuring CredSSP authentication, see [CredSSP for second-hop remoting](http://blogs.msdn.com/b/powershell/archive/2008/06/05/credssp-for-second-hop-remoting-part-i-domain-account.aspx) on the Microsoft website. You can also provide explicit credentials when you want to manage a second remote computer; implicit credentials are unlikely to allow the second hop.

-   Windows PowerShell Web Access uses and has the same limitations as a remote Windows PowerShell session. Commands that directly call Windows console APIs, such as those for console-based editors or text-based menu programs, do not work because the commands do not read or write to standard input, output, and error pipes. Therefore, commands that launch an executable file, such as **notepad.exe**, or display a GUI, such as `OpenGridView` or `ogv`, do not work. Your experience is affected by this behavior; to you, it appears that Windows PowerShell Web Access is not responding to your command.

-   Tab completion does not work in a session configuration with a restricted runspace or one that is in **NoLanguage** mode. Although administrators can configure a session to support tab completion, it is discouraged for security reasons, because it can expose the following information to unauthorized users.

    -   Internal file system paths

    -   Shared folders on internal computers

    -   Variables in the runspace

    -   Loaded types or.NET Framework namespaces

    -   Environment variables

-   Users who are signed in to a **NoLanguage** session configuration or a restricted runspace in Windows PowerShell Web Access cannot run the **Exit** command to end the session. To sign out, users should click **Sign Out** on the console page.

-   <span class="label">Connecting to multiple target computers simultaneously.</span>   If the gateway server is running Windows Server 2012, Windows PowerShell Web Access allows only one remote computer connection per browser session; it does not allow users to sign in once, and connect to multiple remote computers by using separate browser tabs. When you open a new tab or new browser window, Windows PowerShell Web Access prompts you to disconnect your current session and start a new session, so that you can connect to the new (or the same) remote computer. If two or more separate sessions to different remote computers are desired, however, a feature in Internet Explorer lets you create a new session. To start a new browser session in Internet Explorer, press **ALT**, open the **File** menu, and then select **New Session**. Then, open the Windows PowerShell Web Access website in the new session, and sign in to access another remote computer.

    When the Windows PowerShell Web Access gateway is running on Windows Server 2012 R2, users can open multiple connections to remote computers in different browser tabs. If you want to open more than one connection to a remote computer by using the web-based Windows PowerShell console, check with your Windows PowerShell Web Access gateway administrator to see if this feature is supported by the gateway server.

-   <span class="label">Persistent Windows PowerShell sessions (Reconnection).</span>   After you time out of the Windows PowerShell Web Access gateway, the remote connection between the gateway and the target computer is closed. This stops any cmdlets or scripts that are currently in process. You are encouraged to use the Windows PowerShell **-Job** infrastructure when you are performing long-running tasks, so that you can start jobs, disconnect from the computer, reconnect later, and have jobs persist. Another benefit of using **-Job** cmdlets is that you can start them by using Windows PowerShell Web Access, sign out, and then reconnect later, either by running Windows PowerShell Web Access or another host (such as Windows PowerShell® Integrated Scripting Environment (ISE)).

-   <span class="label">Console resizing.</span>   The **PowerShell.exe** console window can be resized in the following three ways.

    -   Drag and adjust the console window size with a mouse

    -   Change the height and width properties by using a GUI for console properties

    -   Changing the height and width of console windows with a cmdlet

        The console window for Windows PowerShell Web Access can be configured by using the cmdlets as follows. In the following example, a user changes the width of Windows PowerShell Web Access console to **20**.

        [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_778d5e55-9195-4bd7-b313-d1fbca7876e4'); "Copy to clipboard.")

            $newSize = $Host.UI.RawUI.WindowSize
            $newSize.Width = $newSize.Width - 20

            $oldSize = $Host.UI.RawUI.WindowSize

            $Host.UI.RawUI.WindowSize = $newSize

        You can change the height of the console in a similar manner.

        Additional examples for customizing the console view are available in the [Windows PowerShell Team Blog](http://blogs.msdn.com/b/powershell/).

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">See Also</span></a>
<a href="/en-us/library/hh831417(v=ws.11).aspx#Anchor_4" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

[Windows PowerShell Cmdlet Reference](https://technet.microsoft.com/library/ee407531(ws.10).aspx)
[Windows PowerShell on Microsoft TechNet](https://technet.microsoft.com/library/bb978526.aspx)
[TechNet Script Center Repository](http://gallery.technet.microsoft.com/scriptcenter)
[Script Center - Hey, Scripting Guy!](https://technet.microsoft.com/scriptcenter)
[Windows PowerShell Team Blog](http://blogs.msdn.com/b/powershell/)

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

