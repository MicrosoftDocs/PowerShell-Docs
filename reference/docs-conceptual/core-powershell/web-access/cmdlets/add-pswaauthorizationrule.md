---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  add pswaauthorizationrule
ms.technology:  powershell
schema:   2.0.0
---


#  Add-PswaAuthorizationRule

##  SYNOPSIS

Adds a new authorization rule to the Windows PowerShell® Web Access
authorization rule set.

## Syntax

###  UserGroupNameComputerGroupName
```
Add-PswaAuthorizationRule -ComputerGroupName <String> -ConfigurationName <String> -UserGroupName <String[]> [-Credential <PSCredential> ] [-Force] [-RuleName <String> ] [ <CommonParameters>]
```

###  UserGroupNameComputerName
```
Add-PswaAuthorizationRule -ComputerName <String> -ConfigurationName <String> -UserGroupName <String[]> [-Credential <PSCredential> ] [-Force] [-RuleName <String> ] [ <CommonParameters>]
```

###  UserNameComputerGroupName
```
Add-PswaAuthorizationRule [-UserName] <String[]> -ComputerGroupName <String> -ConfigurationName <String> [-Credential <PSCredential> ] [-Force] [-RuleName <String> ] [ <CommonParameters>]
```

###  UserNameComputerName
```
Add-PswaAuthorizationRule [-UserName] <String[]> [-ComputerName] <String> [-ConfigurationName] <String> [-Credential <PSCredential> ] [-Force] [-RuleName <String> ] [ <CommonParameters>]
```

## DESCRIPTION

The **Add-PswaAuthorizationRule** cmdlet adds a new authorization rule
to the Windows PowerShell® Web Access authorization rule set.

You must specify the users, computers, and Windows PowerShell endpoints
for this rule. You can specify both users and computers either by
individual user accounts and computer names, or by specifying groups.

For a computer that is joined to an Active Directory domain, the cmdlet
uses the security identifier (SID) of the computer to create the rule.
This allows you to use a short name, a fully qualified domain name
(FQDN), or an IP address for the **Computer Name** field on the sign-in
page.

For a computer that is not joined to an Active Directory domain, the
cmdlet creates the rule using the computer name provided by the
administrator. To successfully connect to this machine, the end user
must provide the computer name exactly as it appears in the rule.

If there are multiple computers with the same name on the network, then
short name can resolve to more than one computer. This can lead to
ambiguity when establishing a connection. For example, if a rule exists
for the workgroup computer named "*Server1*” and a new computer named
*server1.contoso.com* is joined to the network, validation using the
authorization rules succeeds and Windows PowerShell Web Access attempts
to establish a connection to the computer named “*Server1*”. It is not
guaranteed that the connection is established with the specified
workgroup computer; the attempt could be made on either the workgroup or
the domain computer named "*Server1*". To reduce ambiguity, it is
recommended that you use the FQDN for the destination computer whenever
possible to create an authorization rule.

The authorization rules evaluate the primary sign-in credential of the
Windows PowerShell Web Access users, not the alternate credentials (the
second set of credentials found in the **Optional connection settings**
section of the sign-in page). For an example of this, see Example 6.

## Parameters

### -ComputerGroupName&lt;String&gt;

Specifies the name of a computer group in Active Directory Domain
Services (AD DS) or local groups to which this rule grants access.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByPropertyName)                |
| Accept Wildcard Characters?          | false                                |

### -ComputerName&lt;String&gt;

Specifies the computer name to which this rule grants access.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByPropertyName)                |
| Accept Wildcard Characters?          | false                                |

### -ConfigurationName&lt;String&gt;

Specifies the name of the Windows PowerShell session configuration, also
known as runspace, to which this rule grants access.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByPropertyName)                |
| Accept Wildcard Characters?          | false                                |

### -Credential&lt;PSCredential&gt;

Specifies a **PSCredential** object for a user account that you want to
use to change Windows PowerShell Web Access authorization rules. If you
do not add this parameter, the cmdlet uses the currently logged-on user
account. To get a **PSCredential** object, which is required to add
authorization rules remotely, run the
[Get-Credential](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.security/Get-Credential) cmdlet.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -Force

Forces the command to run without asking for user confirmation.\
In addition, it also prompts for confirmation when you enter a simple or
short computer name (such as a name that is not a domain name or is not
fully qualified). Confirmation is requested for security reasons, so
that you can use the simple name to add a computer only if the computer
is in a workgroup.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -RuleName&lt;String&gt;

Specifies the friendly name for this rule.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByPropertyName)                |
| Accept Wildcard Characters?          | false                                |

### -UserGroupName&lt;String\[\]&gt;

Specifies the name of one or more user groups in AD DS or local groups
to which this rule grants access.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByPropertyName)                |
| Accept Wildcard Characters?          | false                                |

### -UserName&lt;String\[\]&gt;

Specifies one or more users to which this rule grants access. The user
name can be a local user account on the gateway computer or a user in AD
DS.
The format is `domain\user` or `computer\user`.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | 1                                    |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByValue, ByPropertyName)       |
| Accept Wildcard Characters?          | false                                |

### &lt;CommonParameters&gt;

This cmdlet supports the common parameters:
-Verbose,
-Debug,
-ErrorAction,
-ErrorVariable,
-OutBuffer,
and -OutVariable.
For more information, see
[about_CommonParameters](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_commonparameters).

## INPUTS

###  String

This cmdlet accepts a string or an array of strings as input.

###  String\[\]

This cmdlet accepts a string or an array of strings as input.

##  Outputs

###   Microsoft.Management.PowerShellWebAccess.PswaAuthorizationRule

This cmdlet returns the an authorization rule object.

## EXAMPLES

### EXAMPLE 1

This example grants access to the session configuration *PSWAEndpoint*,
a restricted runspace, on *srv2* for users in the *SMAdmins* group.\
**Note**: The computer name must be a fully qualified domain name
(FQDN). Administrators define a restricted session configuration or
runspace, which is a limited range of cmdlets and tasks that end users
can run. Defining a restricted runspace can prevent users from accessing
other computers that are not in the allowed Windows PowerShell®
runspace, thus offering a more secure connection. For more information
on session configurations, see
[about_Session_Configurations](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_session_configurations)
or the [Install and Use Windows PowerShell Web Access](../install-and-use-windows-powershell-web-access.md).

```PowerShell
Add-PswaAuthorizationRule -ComputerName srv2.contoso.com -UserGroupName contoso\SMAdmins -ConfigurationName PSWAEndpoint
```

### EXAMPLE 2

This example grants access to the default Windows PowerShell session
configuration, `Microsoft.PowerShell`, on *srv2* for users in the users
named contoso\\user1, contoso\\user2, and contoso\\user3. This cmdlet
creates three rules (1 per person).

```PowerShell
Add-PswaAuthorizationRule –UserName contoso\user1, contoso\user2, contoso\user3 –ComputerName srv2.contoso.com -ConfigurationName Microsoft.PowerShell
```

### EXAMPLE 3

This example illustrates how to input user name values via the pipeline.

```
"contoso\user1","contoso\user2" | Add-pswaAuthorizationRule –ComputerName srv2.contoso.com –ConfigurationName Microsoft.PowerShell
```

### EXAMPLE 4

This example illustrates how all parameters take values from pipeline by
property name.

\
###   {#section .subHeading}

<div class="subSection">

<div id="code-snippet-5" class="codeSnippetContainer" xmlns="">

<div class="codeSnippetContainerTabs">

<div class="codeSnippetContainerTabSingle" dir="ltr">

[Windows PowerShell]()

</div>

</div>

<div class="codeSnippetContainerCodeContainer">

<div class="codeSnippetToolBar">

<div class="codeSnippetToolBarText">

[Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_b61200ba-32cd-4df3-80be-7d5cf0ff709f'); "Copy to clipboard.")

</div>

</div>

<div id="CodeSnippetContainerCode_b61200ba-32cd-4df3-80be-7d5cf0ff709f"
class="codeSnippetContainerCode" dir="ltr">

<div style="color:Black;">

    PS C:\> $o = New-Object -TypeName PSObject | Add-Member -Type NoteProperty -Name "UserName" -Value "contoso\user1" -PassThru | Add-Member -Type NoteProperty -Name "ComputerName" -Value "srv2.contoso.com" -PassThru | Add-Member -Type NoteProperty -Name "ConfigurationName" -Value "Microsoft.PowerShell" –PassThru

</div>

</div>

</div>

</div>

</div>

###   {#section-1 .subHeading}

<div class="subSection">

<div id="code-snippet-6" class="codeSnippetContainer" xmlns="">

<div class="codeSnippetContainerTabs">

<div class="codeSnippetContainerTabSingle" dir="ltr">

[Windows PowerShell]()

</div>

</div>

<div class="codeSnippetContainerCodeContainer">

<div class="codeSnippetToolBar">

<div class="codeSnippetToolBarText">

[Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_c76e1b6c-cb67-4223-a7d0-54ec6b63bbcb'); "Copy to clipboard.")

</div>

</div>

<div id="CodeSnippetContainerCode_c76e1b6c-cb67-4223-a7d0-54ec6b63bbcb"
class="codeSnippetContainerCode" dir="ltr">

<div style="color:Black;">

    PS C:\> $o | Add-PswaAuthorizationRule -UserName contoso\user1 -ConfigurationName Microsoft.PowerShell

</div>

</div>

</div>

</div>

</div>

</div>

### EXAMPLE 5 {#example-5 .subHeading}

<div class="subSection">

This example adds a rule to allow the local user named
*PswaServer\\ChrisLocal* access to the server named *srv1.contoso.com*.

This example illustrates a scenario where the gateway is in a workgroup
and the destination computer is in a domain. The authorization rule
applies to the local users on the gateway. On the Windows PowerShell Web
Access sign-in page, to successfully authenticate, the user must provide
a second set of credentials in the **Optional connection settings**
area. The gateway server uses the additional set of credentials to
authenticate the user on the destination computer, a server named
*srv1.contoso.com*.

\
<div id="code-snippet-7" class="codeSnippetContainer" xmlns="">

<div class="codeSnippetContainerTabs">

<div class="codeSnippetContainerTabSingle" dir="ltr">

[Windows PowerShell]()

</div>

</div>

<div class="codeSnippetContainerCodeContainer">

<div class="codeSnippetToolBar">

<div class="codeSnippetToolBarText">

[Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_7572cdeb-8835-49ed-9d8e-d3318eb639d3'); "Copy to clipboard.")

</div>

</div>

<div id="CodeSnippetContainerCode_7572cdeb-8835-49ed-9d8e-d3318eb639d3"
class="codeSnippetContainerCode" dir="ltr">

<div style="color:Black;">

    PS C:\> Add-PswaAuthorizationRule –UserName PswaServer\ChrisLocal –ComputerName srv1.contoso.com –ConfigurationName Microsoft.PowerShell

</div>

</div>

</div>

</div>

</div>

### EXAMPLE 6 {#example-6 .subHeading}

<div class="subSection">

This example allows all users access to all endpoints on all computers.
This essentially turns off authorization rules.\
**Note**: Use of the `*` wildcard character is not recommended for
security-sensitive deployments and should only be considered for test
environments or used in deployments where security can be relaxed.

\
<div id="code-snippet-8" class="codeSnippetContainer" xmlns="">

<div class="codeSnippetContainerTabs">

<div class="codeSnippetContainerTabSingle" dir="ltr">

[Windows PowerShell]()

</div>

</div>

<div class="codeSnippetContainerCodeContainer">

<div class="codeSnippetToolBar">

<div class="codeSnippetToolBarText">

[Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_9fb751ca-1e50-4411-a9a9-3343fe888076'); "Copy to clipboard.")

</div>

</div>

<div id="CodeSnippetContainerCode_9fb751ca-1e50-4411-a9a9-3343fe888076"
class="codeSnippetContainerCode" dir="ltr">

<div style="color:Black;">

    PS C:\> Add-PswaAuthorizationRule –UserName * -ComputerName * -ConfigurationName *

</div>

</div>

</div>

</div>

</div>

</div>

Related topics {#related-topics .heading}
--------------

<div id="seeAlsoNoToggle" class="section">

\
[Get-PswaAuthorizationRule](https://technet.microsoft.com/en-us/library/jj592891(v=wps.630).aspx)\
\
[Remove-PswaAuthorizationRule](https://technet.microsoft.com/en-us/library/jj592893(v=wps.630).aspx)\
\
[Test-PswaAuthorizationRule](https://technet.microsoft.com/en-us/library/jj592892(v=wps.630).aspx)\
\
[Install-PswaWebApplication](https://technet.microsoft.com/en-us/library/jj592894(v=wps.630).aspx)\
\
[Add-Member](http://go.microsoft.com/fwlink/p/?LinkId=113280)\
\
[New-Object](http://go.microsoft.com/fwlink/p/?LinkId=113355)\
\
[Get-Credential](http://go.microsoft.com/fwlink/?LinkID=293936)\
\

</div>

</div>

</div>

</div>

</div>

<div class="communityContentContainer" ms.cmpgrp="community">

<div id="CommunityContentHeader" class="communityContentHeader">

<div class="communityContentHeaderTitleContainer">

Community Additions
-------------------

[<span class="communityContentAddButton" title="Add"> ADD
</span>](https://technet.microsoft.com/en-us/library/community/add/jj592890(v=wps.630).aspx){.communityContentAddLink}

</div>

<div style="clear: both;">

</div>

</div>

<div id="CommunityComments"
data-url="/en-us/library/community/comments/jj592890(v=wps.630).aspx">

</div>

</div>

<div class="libraryMemberFilter">

<div class="filterContainer">

<span>Show:</span> Inherited Protected

</div>

</div>

</div>

<div id="rightNavigationMenu" ms.cmpgrp="right nav">

<div id="mobileButtons">

<div id="navigationButtons">

Print
Export (<span class="count">0</span>)

</div>

</div>

<div id="navMain">

<div id="closeNavigation">

[](){#closeButton .tocCloseSmall}

</div>

<div id="navigationButtons">

Print
Export (<span class="count">0</span>)
Share
<div id="socials" style="display: none">

</div>

</div>

<div id="indoc_toc" style="display: none" ms.cmpgrp="indoc toc">

<div id="indoc_title">

IN THIS ARTICLE

</div>

</div>

</div>

</div>

<div id="rightNavigationMenuThumbnail"
class="rightNavigationMenuThumbnail">

</div>

</div>

<div class="clear">

</div>

<div id="lib-footer">

<div id="standardRatingBefore" class="clear stdr-container-before">

</div>

<div id="standardRating" class="stdr-container" ms.pgarea="body">

<div class="stdr-close">

</div>

<div class="stdr-vote stdr-content">

<div class="stdr-content">

<span class="stdr-votetitle">Is this page helpful?</span>
Yes
No

</div>

</div>

<div class="stdr-feedback" style="display: none">

<div class="stdr-form">

<div class="stdr-fieldtitle">

Additional feedback?

</div>

<div>

<span class="stdr-count"><span class="stdr-charcnt">1500</span>
characters remaining</span>
<div class="stdr-buttons">

Submit
Skip this

</div>

</div>

<div class="clear">

</div>

</div>

</div>

<div class="stdr-thanks" style="display: none">

<div class="stdr-content">

<span class="stdr-thankyou">Thank you!</span> <span
class="stdr-appreciate">We appreciate your feedback.</span>

</div>

</div>

<div id="contentFeedbackQAContainer" style="display: none;">

</div>

</div>

<div id="standardRatingPlaceholder" style="display: none">

</div>

<div id="ux-footer" style="" dir="ltr" ms.pgarea="footer">

<div id="standardRatingBefore" class="clear stdr-container-before">

</div>

<div id="standardRating" class="stdr-container" ms.pgarea="body">

<div class="stdr-close">

</div>

<div class="stdr-vote stdr-content">

<div class="stdr-content">

<span class="stdr-votetitle">Is this page helpful?</span>
Yes
No

</div>

</div>

<div class="stdr-feedback" style="display: none">

<div class="stdr-form">

<div class="stdr-fieldtitle">

Additional feedback?

</div>

<div>

<span class="stdr-count"><span class="stdr-charcnt">1500</span>
characters remaining</span>
<div class="stdr-buttons">

Submit
Skip this

</div>

</div>

<div class="clear">

</div>

</div>

</div>

<div class="stdr-thanks" style="display: none">

<div class="stdr-content">

<span class="stdr-thankyou">Thank you!</span> <span
class="stdr-appreciate">We appreciate your feedback.</span>

</div>

</div>

<div id="contentFeedbackQAContainer" style="display: none;">

</div>

</div>

<div id="standardRatingPlaceholder" style="display: none">

</div>

<div id="Fragment_LeftLinks" data-fragmentname="LeftLinks"
xmlns="http://www.w3.org/1999/xhtml">

<div class="linkList">

#### Dev centers {#dev-centers .linkListTitle}

-   [Windows](https://dev.windows.com){#LeftLinks_2148_1 .windowsBlue}
-   [Office](http://dev.office.com){#LeftLinks_2148_3 .office}
-   [Visual
    Studio](https://msdn.microsoft.com/vstudio){#LeftLinks_2148_4
    .visualStudio}
-   [Microsoft
    Azure](http://azure.microsoft.com/en-us/documentation/){#LeftLinks_2148_12}
-   [More...](https://msdn.microsoft.com/developer-centers-msdn){#LeftLinks_2148_5}

</div>

</div>

<div id="rightLinks">

<div id="Fragment_CenterLinks2" data-fragmentname="CenterLinks2"
xmlns="http://www.w3.org/1999/xhtml">

<div class="linkList">

#### Top PowerShell Sites {#top-powershell-sites .linkListTitle}

-   [PowerShell
    Gallery](https://www.powershellgallery.com/){#CenterLinks2_15503_14}
-   [Announcements](https://technet.microsoft.com/en-us/powershell/ux/library/mt757324){#CenterLinks2_15503_15}
-   [Latest WMF Download](http://aka.ms/wmf){#CenterLinks2_15503_16}
-   [PowerShell on
    Github](https://github.com/powershell){#CenterLinks2_15503_17}

</div>

</div>

<div id="Fragment_CenterLinks3" data-fragmentname="CenterLinks3"
xmlns="http://www.w3.org/1999/xhtml">

<div class="linkList">

#### Related Microsoft Sites {#related-microsoft-sites .linkListTitle}

-   [Microsoft Operations Management
    Suite (OMS)](https://www.microsoft.com/oms){#CenterLinks3_15503_23}
-   [OMS
    Automation](https://www.microsoft.com/en-us/cloud-platform/automation-and-control){#CenterLinks3_15503_24}
-   [Windows Server
    Docs](https://msdn.microsoft.com/library/dn636873(v=vs.85).aspx){#CenterLinks3_15503_19}
-   [Office Deployment
    Scripts](https://github.com/OfficeDev/Office-IT-Pro-Deployment-Scripts){#CenterLinks3_15503_20}

</div>

</div>

<div id="Fragment_CenterLinks4" data-fragmentname="CenterLinks4"
xmlns="http://www.w3.org/1999/xhtml">

<div class="linkList">

#### Feedback {#feedback .linkListTitle}

-   [PowerShell
    UserVoice](https://windowsserver.uservoice.com/forums/301869-powershell){#CenterLinks4_15503_21}
-   [Windows Server
    UserVoice](https://windowsserver.uservoice.com/){#CenterLinks4_15503_22}

</div>

</div>

</div>

<span class="localeContainer"> </span>
[united states (english)](# "change your language")
<div id="Fragment_BottomLinks" data-fragmentname="BottomLinks"
xmlns="http://www.w3.org/1999/xhtml">

<div class="linkList">

-   [Newsletter](https://msdn.microsoft.com/newsletter.aspx){#BottomLinks_2148_7}
-   [Privacy &
    cookies](https://msdn.microsoft.com/dn529288){#BottomLinks_2148_8}
-   [Terms of
    use](https://msdn.microsoft.com/cc300389){#BottomLinks_2148_9}
-   [Trademarks](https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/){#BottomLinks_2148_10}

</div>

</div>

<span class="logoLegal"> <span class="logoSpan clip67x13" role="img"
tabindex="0" aria-label="microsoft logo">
![logo](https://i-technet.sec.s-msft.com/Areas/Centers/Themes/StandardDevCenter/Content/HeaderFooterSprite.png?v=636146814338182722){.logo}
</span> <span class="copyright">© 2016 Microsoft</span> </span>

</div>

</div>

<div class="footerPrintView">

<div class="footerCopyrightPrintView">

© 2016 Microsoft

</div>

</div>

Third party scripts and code linked to or referenced from this website
are licensed to you by the parties that own such code, not by Microsoft.
See ASP.NET Ajax CDN Terms of Use –
http://www.asp.net/ajaxlibrary/CDN.ashx. WebTrends view model not
available or IncludeLegacyWebTrendsScriptInGlobal feature flag is off
<div id="globalRequestVerification">

</div>

</div>

