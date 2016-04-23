---
title: Scripting with Windows PowerShell
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c425d27a-bb41-4947-8d73-ba5480bc8ee0
---
# Scripting with Windows PowerShell
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://dduestorage.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>
      <token>wps_1</token> is a task-based command-line shell and scripting language designed especially for system administration. Built on the .NET Framework, <token>wps_2</token> helps IT professionals and power users control and automate the administration of the Windows operating system and applications that run on Windows.</para>
    <para>
      <token>wps_2</token> commands, called <newTerm>cmdlets</newTerm>, let you manage the computers from the command line. <token>wps_2</token> <newTerm>providers</newTerm> let you access data stores, such as the registry and certificate store, as easily as you access the file system. In addition, <token>wps_2</token> has a rich expression parser and a fully developed scripting language.</para>
    <para>
      <token>wps_2</token> includes the following features: </para>
    <list class="bullet">
      <listItem>
        <para>Cmdlets for performing common system administration tasks, such as managing the registry, services, processes, and event logs, and using Windows Management Instrumentation (WMI).</para>
      </listItem>
      <listItem>
        <para>A task-based scripting language and support for existing scripts and command-line tools.</para>
      </listItem>
      <listItem>
        <para>Consistent design. Because cmdlets and system data stores use common syntax and naming conventions, data can be shared easily and the output from one cmdlet can be used as the input to another cmdlet without reformatting or manipulation.</para>
      </listItem>
      <listItem>
        <para>Simplified, command-based navigation of the operating system, which lets users navigate the registry and other data stores by using the same techniques that they use to navigate the file system.</para>
      </listItem>
      <listItem>
        <para>Powerful object manipulation capabilities. Objects can be directly manipulated or sent to other tools or databases.</para>
      </listItem>
      <listItem>
        <para>Extensible interface. Independent software vendors and enterprise developers can build custom tools and utilities to administer their software. </para>
      </listItem>
    </list>
  </introduction>
  <section>
    <title>Content in this section</title>
    <content>
      <para>The following content is available in Scripting with Windows PowerShell.</para>
      <list class="bullet">
        <listItem>
          <para>
            <link xlink:href="cf06f1e5-3945-47e4-98be-412f5a1f43fe">Using Windows PowerShell</link>. Learn how to get started scripting and automating Windows environments by using <token>wps_2</token>. This section includes a user’s guide, information about features that are included with <token>wps_2</token> (such as <token>wps_2</token> Desired State Configuration), information about <token>wps_2</token> prerequisites and installation, and information about how to use <token>wps_2</token> Integrated Scripting Environment (ISE), a graphical editor for <token>wps_2</token>.</para>
        </listItem>
        <listItem>
          <para>
            <externalLink>
              <linkText>Windows PowerShell Core Module Reference</linkText>
              <linkUri>http://technet.microsoft.com/library/hh847741(v=wps.640).aspx</linkUri>
            </externalLink>. This section includes reference Help topics for all cmdlets in the core modules that are included as part of <token>wps_2</token>. The section also includes About topics that illustrate <token>wps_2</token> concepts and examples in greater detail.</para>
        </listItem>
        <listItem>
          <para>
            <externalLink>
              <linkText>Windows and Windows Server Automation with Windows PowerShell</linkText>
              <linkUri>https://technet.microsoft.com/en-us/library/mt156917.aspx</linkUri>
            </externalLink>. This section includes reference Help topics for all <token>wps_2</token> cmdlets that are available as part of Windows and Windows Server roles, role services, and features.</para>
        </listItem>
        <listItem>
          <para>
            <externalLink>
              <linkText>System Center Automation with Windows PowerShell</linkText>
              <linkUri>http://technet.microsoft.com/library/dn507037.aspx</linkUri>
            </externalLink>. This section includes reference Help topics for all System Center cmdlets that are available when you install System Center in your environment.</para>
        </listItem>
        <listItem>
          <para>
            <externalLink>
              <linkText>Microsoft Azure Pack for Windows Server Automation with Windows PowerShell</linkText>
              <linkUri>http://technet.microsoft.com/library/dn521028.aspx</linkUri>
            </externalLink>. This section includes reference Help topics for the cmdlets that are available when you install the Windows Azure Pack for Windows Server.</para>
        </listItem>
        <listItem>
          <para>
            <externalLink>
              <linkText>Previous Versions of Windows PowerShell Module Help</linkText>
              <linkUri>https://technet.microsoft.com/en-us/library/mt156946.aspx</linkUri>
            </externalLink>. This section includes cmdlet reference and About Help topics for <token>wps_2</token> 3.0 and earlier releases of <token>wps_2</token>.</para>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="b8217c5e-23e1-4a34-a1e6-9445724663ea">Identity and Access Automation with Windows PowerShell</link>. This section includes cmdlet reference topics for cmdlets included with Microsoft Identity Manager 2016 for Privileged Access Management (PAM).</para>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="9d788fed-6899-4297-b162-7de8f4e85658">Microsoft Identity Manager 2016</link>. This section includes cmdlet reference topics for Microsoft Identity Manager 2016.</para>
        </listItem>
        <listItem>
          <para>
            <externalLink>
              <linkText>Microsoft Desktop Optimization Pack Automation with Windows PowerShell</linkText>
              <linkUri>https://technet.microsoft.com/en-us/library/dn520245.aspx</linkUri>
            </externalLink>. This section includes cmdlet reference topics for Microsoft Desktop Optimization Pack (MDOP).</para>
        </listItem>
        <listItem>
          <para>
            <link xlink:href="c0d46809-7a8b-4ff4-a141-875f337d9bc9">SQL Server with Windows Powershell</link>. This section includes cmdlet reference topics for <token>pn_MS_SQL_Server</token> with <token>wps_2</token>.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section>
    <title>Related Resources</title>
    <content />
    <sections>
      <section>
        <title>Resources for Windows PowerShell users</title>
        <content>
          <para>In addition to the Help available at the command line, the following resources provide more information for users who want to run <token>wps_2</token>.</para>
          <list class="bullet">
            <listItem>
              <para>
                <externalLink>
                  <linkText>Windows PowerShell Team Blog</linkText>
                  <linkUri>http://blogs.msdn.com/b/powershell/</linkUri>
                </externalLink>. The best resource for learning directly from the <token>wps_2</token> product team.</para>
            </listItem>
            <listItem>
              <para>
                <externalLink>
                  <linkText>Windows PowerShell Customer Connection</linkText>
                  <linkUri>http://Connect.Microsoft.com/PowerShell</linkUri>
                </externalLink>. Make a suggestion, send feedback, or file a bug for the <token>wps_2</token> team. You can file a code bug, a documentation bug, or a localization (language translation) bug.</para>
            </listItem>
            <listItem>
              <para> <externalLink><linkText>The Hey, Scripting Guy! Blog</linkText><linkUri>http://www.scriptingguys.com/blog</linkUri></externalLink> publishes new content seven days a week, and is consistently ranked in the top five of all Microsoft blogs. The articles are scenario-driven, and written in an engaging and lively manner.</para>
            </listItem>
            <listItem>
              <para>
                <externalLink>
                  <linkText>The Learn PowerShell page</linkText>
                  <linkUri>http://www.scriptingguys.com/learnpowershell</linkUri>
                </externalLink> is the <token>wps_2</token> hub on the TechNet Script Center. This page hosts a series of beginner video sessions conducted by the Microsoft Scripting Guy Ed Wilson. It also contains <token>wps_2</token> quizzes, links to community content, and more.</para>
            </listItem>
            <listItem>
              <para>Have questions about using <token>wps_2</token>? Connect with hundreds of other people who have similar interests on the <externalLink><linkText>Official Scripting Guys forum</linkText><linkUri>http://social.technet.microsoft.com/Forums/ITCG/threads/</linkUri></externalLink>.</para>
            </listItem>
            <listItem>
              <para>
                <externalLink>
                  <linkText>The Microsoft Script Center</linkText>
                  <linkUri>http://technet.microsoft.com/ScriptCenter</linkUri>
                </externalLink>. A portal to many useful <token>wps_2</token> resources, including the <externalLink><linkText>Script Center Repository</linkText><linkUri>http://gallery.technet.microsoft.com/ScriptCenter/</linkUri></externalLink>. One of the best ways to learn scripting is to see examples in action. Search through thousands of <token>wps_2</token> scripts, all ready for you to evaluate and adapt to meet your needs.</para>
            </listItem>
            <listItem>
              <para>Get involved in the <token>wps_2</token> user community. See the <externalLink><linkText>Script Center Community page</linkText><linkUri>http://technet.microsoft.com/scriptcenter/hh182567.aspx</linkUri></externalLink> for locations of dozens of <token>wps_2</token> user groups – there is probably one near you. Also keep current with the community activities of the Microsoft Scripting Guy.</para>
            </listItem>
          </list>
        </content>
      </section>
      <section>
        <title>Other Windows PowerShell documentation for Microsoft technologies</title>
        <content>
          <para>The following links can help you find Windows PowerShell documentation that is not available as part of this section.</para>
          <list class="bullet">
            <listItem>
              <para>Find help about the Windows PowerShell cmdlets for Microsoft Dynamics CRM in the <externalLink><linkText>Microsoft Dynamics CRM PowerShell Reference</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=403369</linkUri></externalLink>. For more information about Microsoft Dynamics CRM, see <externalLink><linkText>Microsoft Dynamics CRM IT Pro Center</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=270870</linkUri></externalLink>.</para>
            </listItem>
            <listItem>
              <para>For information about how to use the Windows PowerShell-based Exchange Management Shell to manage Microsoft Exchange Server 2013, see <externalLink><linkText>Exchange Management Shell</linkText><linkUri>http://technet.microsoft.com/library/bb123778(v=exchg.150).aspx</linkUri></externalLink>. For more information about managing Exchange Server 2013, see <externalLink><linkText>Exchange Server 2013</linkText><linkUri>http://technet.microsoft.com/library/bb124558(v=exchg.150).aspx</linkUri></externalLink>.</para>
            </listItem>
          </list>
        </content>
      </section>
      <section>
        <title>Resources for Windows PowerShell Developers</title>
        <content>
          <para>The following resources provide resources to help developers create their own <token>wps_2</token> modules, functions, cmdlets, providers, and hosting applications. </para>
          <list class="bullet">
            <listItem>
              <para>
                <externalLink>
                  <linkText>Windows PowerShell SDK</linkText>
                  <linkUri>http://go.microsoft.com/fwlink/p/?LinkID=89595</linkUri>
                </externalLink>. Provides reference content. </para>
            </listItem>
            <listItem>
              <para>
                <externalLink>
                  <linkText>Windows PowerShell Programmer's Guide</linkText>
                  <linkUri>http://go.microsoft.com/fwlink/p/?LinkID=89596</linkUri>
                </externalLink>. Provides tutorials. Also contains information about fundamental <token>wps_2</token> concepts.</para>
            </listItem>
          </list>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics />
</developerConceptualDocument>