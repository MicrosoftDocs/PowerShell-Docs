---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  troubleshooting access problems in windows powershell web access
---

#  Troubleshooting Access Problems in Windows PowerShell Web Access

Updated: June 24, 2013

Applies To: Windows Server 2012 R2, Windows Server 2012

<a href="" id="BKMK_trouble"></a>

------------------------------------------------------------------------

The following table identifies some common problems that users might experience when they are attempting to connect to a remote computer by using Windows PowerShell Web Access, and includes suggestions for resolving the problems.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Problem</p></th>
<th><p>Possible cause and solution</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Sign-in failure</p></td>
<td><p>Failure could occur because of any of the following.</p>
<ul>
<li><p>An authorization rule that allows the user access to the computer, or a specific session configuration on the remote computer, does not exist. Windows PowerShell Web Access security is restrictive; users must be granted explicit access to remote computers by using authorization rules. For more information about creating authorization rules, see <a href="https://technet.microsoft.com/en-us/library/dn282394(v=ws.11).aspx">Authorization Rules and Security Features of Windows PowerShell Web Access</a> in this guide.</p></li>
<li><p>The user does not have authorized access to the destination computer. This is determined by access control lists (ACLs). For more information, see “Signing in to Windows PowerShell Web Access” in <a href="https://technet.microsoft.com/en-us/library/hh831417(v=ws.11).aspx">Use the Web-based Windows PowerShell Console</a>, or the <a href="https://msdn.microsoft.com/library/windows/desktop/ee706585.aspx">Windows PowerShell Team Blog</a>.</p>
<ul>
<li><p>Windows PowerShell remote management might not be enabled on the destination computer. Verify that it is enabled on the computer to which the user is trying to connect. For more information, see “How to Configure Your Computer for Remoting” in <a href="https://technet.microsoft.com/library/dd315349.aspx">about_Remote_Requirements</a> in the Windows PowerShell About Help Topics.</p></li>
</ul></li>
</ul></td>
</tr>
<tr class="even">
<td><p>When users try to sign in to Windows PowerShell Web Access in an Internet Explorer window, they are shown an <strong>Internal Server Error</strong> page, or Internet Explorer stops responding. This issue is specific to Internet Explorer.</p></td>
<td><p>This can occur for users who have signed in with a domain name that contains Chinese characters, or if one or more Chinese characters are part of the gateway server name. To work around this issue, the user should <a href="http://ie.microsoft.com/testdrive/info/downloads/Default.html">install and run Internet Explorer 10</a>, and then perform the following steps.</p>
<ol>
<li><p>Change the Internet Explorer <strong>Document Mode</strong> setting to <strong>IE10 standards</strong>.</p>
<ol>
<li><p>Press <strong>F12</strong> to open the Developer Tools console.</p></li>
<li><p>In Internet Explorer 10, click <strong>Browser Mode</strong>, and then select <strong>Internet Explorer 10</strong>.</p></li>
<li><p>Click <strong>Document Mode</strong>, and then click <strong>IE10 standards</strong>.</p></li>
<li><p>Press <strong>F12</strong> again to close the Developer Tools console.</p></li>
</ol></li>
<li><p>Disable automatic proxy configuration.</p>
<ol>
<li><p>In Internet Explorer 10, click <strong>Tools</strong>, and then click <strong>Internet Options</strong>.</p></li>
<li><p>In the <strong>Internet Options</strong> dialog box, on the <strong>Connections</strong> tab, click <strong>LAN settings</strong>.</p></li>
<li><p>Clear the <strong>Automatically detect settings</strong> check box. Click <strong>OK</strong>, and then click <strong>OK</strong> again to close the <strong>Internet Options</strong> dialog box.</p></li>
</ol></li>
</ol></td>
</tr>
<tr class="odd">
<td><p>Cannot connect to a remote workgroup computer</p></td>
<td><p>If the destination computer is a member of a workgroup, use the following syntax to provide your user name and sign in to the computer: &lt;<em>workgroup_name</em>&gt;\&lt;<em>user_name</em>&gt;</p></td>
</tr>
<tr class="even">
<td><p>Cannot find Web Server (IIS) management tools, even though the role was installed</p></td>
<td><p>If you installed Windows PowerShell Web Access by using the `Install-WindowsFeature` cmdlet, management tools are not installed unless the `IncludeManagementTools` parameter is added to the cmdlet. For an example, see “To install Windows PowerShell Web Access by using Windows PowerShell cmdlets” in <a href="https://technet.microsoft.com/en-us/library/hh831611(v=ws.11).aspx">Install and Use Windows PowerShell Web Access</a>. You can add the IIS Manager console and other IIS management tools that you need by selecting the tools in an Add Roles and Features Wizard session that is targeted at the gateway server. The Add Roles and Features Wizard is opened from within Server Manager.</p></td>
</tr>
<tr class="odd">
<td><p>The Windows PowerShell Web Access website is not accessible</p></td>
<td><p>If Enhanced Security Configuration is enabled in Internet Explorer (IE ESC), you can add the Windows PowerShell Web Access website to the list of trusted sites, or disable IE ESC. You can disable IE ESC in the <strong>Properties</strong> tile on the <strong>Local Server</strong> page in Server Manager.</p></td>
</tr>
<tr class="even">
<td><p>The following error message is displayed while trying to connect when the gateway server is the destination computer, and is also in a workgroup: <strong>An authorization failure occurred. Verify that you are authorized to connect to the destination computer.</strong></p></td>
<td><p>When the gateway server is also the destination server, and it is in a workgroup, specify the user name, computer name, and user group name as shown in the following table. Do not use a dot (.) by itself to represent the computer name.</p>
<div>
<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Scenario</p></th>
<th><p>UserName Parameter</p></th>
<th><p>UserGroup Parameter</p></th>
<th><p>ComputerName Parameter</p></th>
<th><p>ComputerGroup Parameter</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Gateway server is in a domain</p></td>
<td><p><em>Server_name</em>\<em>user_name</em>, Localhost\<em>user_name</em>, or .\<em>user_name</em></p></td>
<td><p><em>Server_name</em>\<em>user_group</em>, Localhost\<em>user_group</em>, or .\<em>user_group</em></p></td>
<td><p>Fully qualified name of gateway server, or Localhost</p></td>
<td><p><em>Server_name</em>\<em>computer_group</em>, Localhost\<em>computer_group</em>, or .\<em>computer_group</em></p></td>
</tr>
<tr class="even">
<td><p>Gateway server is in a workgroup</p></td>
<td><p><em>Server_name</em>\<em>user_name</em>, Localhost\<em>user_name</em>, or .\<em>user_name</em></p></td>
<td><p><em>Server_name</em>\<em>user_group</em>, Localhost\<em>user_group</em> or .\<em>user_group</em></p></td>
<td><p>Server name</p></td>
<td><p><em>Server_name</em>\<em>computer_group</em>, Localhost\<em>computer_group</em> or .\<em>computer_group</em></p></td>
</tr>
</tbody>
</table>
</div>
<p>Sign in to a gateway server as target computer by using credentials formatted as one of the following.</p>
<ul>
<li><p><em>Server_name</em>\<em>user_name</em></p></li>
<li><p>Localhost\<em>user_name</em></p></li>
<li><p>.\<em>user_name</em></p></li>
</ul></td>
</tr>
<tr class="odd">
<td><p>A security identifier (SID) is displayed in an authorization rule instead of the syntax <em>user_name</em>/<em>computer_name</em> </p></td>
<td><p>Either the rule is no longer valid, or the Active Directory Domain Services query failed. An authorization rule is usually not valid in scenarios where the gateway server was at one time in a workgroup, but was later joined to a domain.</p></td>
</tr>
<tr class="even">
<td><p>Cannot sign in to a target computer that has been specified in authorization rules as an IPv6 address with a domain.</p></td>
<td><p>Authorization rules do not support an IPv6 address in form of a domain name. To specify a destination computer by using an IPv6 address, use the original IPv6 address (that contains colons) in the authorization rule. Both domain and numerical (with colons) IPv6 addresses are supported as the target computer name on the Windows PowerShell Web Access sign-in page, but not in authorization rules. For more information about IPv6 addresses, see <a href="https://technet.microsoft.com/library/cc781672.aspx">How IPv6 Works</a>.</p></td>
</tr>
</tbody>
</table>

<a href="javascript:void(0)" class="LW_CollapsibleArea_TitleAhref" title="Collapse"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">See Also</span></a>
<a href="/en-us/library/dn282395(v=ws.11).aspx#Anchor_1" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a>

------------------------------------------------------------------------

[Authorization Rules and Security Features of Windows PowerShell Web Access](https://technet.microsoft.com/en-us/library/dn282394(v=ws.11).aspx)
[Use the Web-based Windows PowerShell Console](https://technet.microsoft.com/en-us/library/hh831417(v=ws.11).aspx)
[about_Remote_Requirements](https://technet.microsoft.com/library/dd315349.aspx)

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

