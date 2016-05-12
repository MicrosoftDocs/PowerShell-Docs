---
title:  Installing the Windows PowerShell SDK
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  c3636b45-61aa-4720-85f0-58312c4fc8f9
---

# Installing the Windows PowerShell SDK
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://dduestorage.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>The following topic describes how to install the PowerShell SDK on different versions of Windows.</para>
  </introduction>
  <section>
    <title>Installing Windows PowerShell 3.0 SDK for Windows 8 and Windows Server 2012</title>
    <content>
      <para>Windows PowerShell 3.0 is automatically installed with Windows 8 and Windows Server 2012. In addition, you can download and install the reference assemblies for Windows PowerShell 3.0 as part of the Windows 8 SDK. These assemblies allow you to write cmdlets, providers, and host programs for Windows PowerShell 3.0. When you install the Windows SDK for Windows 8, the Windows PowerShell assemblies are automatically installed in the reference assembly folder, in \Program Files (x86)\Reference Assemblies\Microsoft\WindowsPowerShell\3.0. For more information, see the <externalLink><linkText>Windows 8 SDK download site</linkText><linkUri>http://msdn.microsoft.com/windows/hardware/hh852363.aspx</linkUri></externalLink>. Windows PowerShell code samples are also available on the Development Center. For more information, see the Desktop code sample page on the <externalLink><linkText>Dev center site</linkText><linkUri>http://code.msdn.microsoft.com/windowsdesktop/</linkUri></externalLink>. </para>
      <para>In addition, Windows PowerShell 3.0 is backwards-compatible with the Windows PowerShell 2.0 SDK, which includes a number of code samples. For more information on how to download the Windows PowerShell 2.0 SDK, see below. (Note that while the 2.0 code samples are compatible with Windows 8 and Windows PowerShell 3.0, you cannot install Windows PowerShell 2.0 on a Windows 8 platform.) </para>
    </content>
  </section>
  <section>
    <title>Installing Windows PowerShell 3.0 SDK for Windows 7 and Windows Server 2008 R2</title>
    <content>
      <para>Windows 7 and Windows Server 2008 R2 automatically have PowerShell 2.0 installed. In addition, you can install PowerShell 3.0 on these systems. (For more information, see <link xlink:href="6fbb0409-5a54-48ec-95e6-7f8b7d8c4969">Installing Windows PowerShell</link>.). As described above, you can also install the Windows 8 SDK on Windows 7 and Windows Server 2008 R2.</para>
    </content>
  </section>
  <section>
    <title>Installing Windows PowerShell 2.0 SDK for Windows 7, Vista, XP, Server 2003, and Server 2008</title>
    <content>
      <para>The <token>mshshort</token> 2.0 SDK provides the reference assemblies needed to write cmdlets, providers, and hosting applications, and it provides C# sample code that can be used as the starting point when you begin writing code. </para>
      <para>To install this SDK, see <externalLink><linkText>Windows PowerShell 2.0 SDK</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=184611</linkUri></externalLink>.</para>
    </content>
    <sections>
      <section>
        <title>Reference assemblies</title>
        <content>
          <para>Reference assemblies are installed in the following location by default: <codeInline>c:\Program Files\Reference Assemblies\Microsoft\WindowsPowerShell\V1.0</codeInline>.</para>
          <alert class="note">
            <para>Code that is compiled against the Windows PowerShell 2.0 assemblies cannot be loaded into Windows PowerShell 1.0 installations. However, code that is compiled against the Windows PowerShell 1.0 assemblies can be loaded into Windows PowerShell 2.0 installations.</para>
          </alert>
        </content>
      </section>
      <section>
        <title>Samples</title>
        <content>
          <para>Code samples are installed in the following location by default: <codeInline>C:\Program Files\Microsoft SDKs\Windows\v7.0\Samples\sysmgmt\WindowsPowerShell\</codeInline>.</para>
          <para>The following sections provide a brief description of what each sample does.</para>
        </content>
        <sections>
          <section>
            <title>Cmdlet samples</title>
            <content>
              <definitionTable>
                <definedTerm>GetProcessSample01</definedTerm>
                <definition>
                  <para>Shows how to write a simple cmdlet that gets all the processes on the local computer.</para>
                </definition>
                <definedTerm>GetProcessSample02</definedTerm>
                <definition>
                  <para>Shows how to add parameters to the cmdlet. The cmdlet takes one or more process names and returns the matching processes.</para>
                </definition>
                <definedTerm>GetProcessSample03</definedTerm>
                <definition>
                  <para>Shows how to add parameters that accept input from the pipeline.</para>
                </definition>
                <definedTerm>GetProcessSample04</definedTerm>
                <definition>
                  <para>Shows how to handle nonterminating errors.</para>
                </definition>
                <definedTerm>GetProcessSample05</definedTerm>
                <definition>
                  <para>Shows how to display a list of specified processes.</para>
                </definition>
                <definedTerm>SelectObject</definedTerm>
                <definition>
                  <para>Shows how to write a filter to select only certain objects. </para>
                </definition>
                <definedTerm>SelectString</definedTerm>
                <definition>
                  <para>Shows how to search files for specified patterns.</para>
                </definition>
                <definedTerm>StopProcessSample01</definedTerm>
                <definition>
                  <para>Shows how to implement a <parameterReference>PassThru</parameterReference> parameter, and how to request user feedback by calls to the <codeEntityReference>Overload:System.Management.Automation.Cmdlet.ShouldProcess</codeEntityReference> and <codeEntityReference>Overload:System.Management.Automation.Cmdlet.ShouldContinue</codeEntityReference> methods. Users specify the <parameterReference>PassThru</parameterReference> parameter when they want to force the cmdlet to return an object, </para>
                </definition>
                <definedTerm>StopProcessSample02</definedTerm>
                <definition>
                  <para>Shows how to stop a specific process.</para>
                </definition>
                <definedTerm>StopProcessSample03</definedTerm>
                <definition>
                  <para>Shows how to declare aliases for parameters and how to support wildcards.</para>
                </definition>
                <definedTerm>StopProcessSample04</definedTerm>
                <definition>
                  <para>Shows how to declare parameter sets, the object that the cmdlet takes as input, and how to specify the default parameter set to use.</para>
                </definition>
              </definitionTable>
            </content>
          </section>
          <section>
            <title>Remoting samples</title>
            <content>
              <definitionTable>
                <definedTerm>RemoteRunspace01</definedTerm>
                <definition>
                  <para>Shows how to create a remote runspace that is used to establish a remote connection.</para>
                </definition>
                <definedTerm>RemoteRunspacePool01</definedTerm>
                <definition>
                  <para>Shows how to construct a remote runspace pool and how to run multiple commands concurrently by using this pool.</para>
                </definition>
                <definedTerm>Serialization01</definedTerm>
                <definition>
                  <para>Shows how to look at an existing .NET class and make sure that information from selected public properties of this class is preserved across serialization/deserialization.</para>
                </definition>
                <definedTerm>Serialization02</definedTerm>
                <definition>
                  <para>Shows how to look at an existing .NET class and make sure that information from instance of this class is preserved across serialization/deserialization when the information is not available in public properties of the class.</para>
                </definition>
                <definedTerm>Serialization03</definedTerm>
                <definition>
                  <para>Shows how to look at an existing .NET class and make sure that instances of this class and of derived classes are deserialized (rehydrated) into live .NET objects.</para>
                </definition>
              </definitionTable>
            </content>
          </section>
          <section>
            <title>Event samples</title>
            <content>
              <definitionTable>
                <definedTerm>Event01</definedTerm>
                <definition>
                  <para>Shows how to create a cmdlet for event registration by deriving from ObjectEventRegistrationBase.</para>
                </definition>
                <definedTerm>Event02</definedTerm>
                <definition>
                  <para>Shows how to shows how to receive notifications of <token>mshshort</token> events that are generated on remote computers. It uses the PSEventReceived event exposed through the <codeEntityReference>T:System.Management.Automation.Runspaces.Runspace</codeEntityReference> class.</para>
                </definition>
              </definitionTable>
            </content>
          </section>
          <section>
            <title>Hosting application samples</title>
            <content>
              <definitionTable>
                <definedTerm>Runspace01</definedTerm>
                <definition>
                  <para>Shows how to use the <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> class to run the <externalLink><linkText>Get-Process</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=113324</linkUri></externalLink> cmdlet synchronously. The <externalLink><linkText>Get-Process</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=113324</linkUri></externalLink> cmdlet returns <codeEntityReference>T:System.Diagnostics.Process</codeEntityReference> objects for each process running on the local computer.</para>
                </definition>
                <definedTerm>Runspace02</definedTerm>
                <definition>
                  <para>Shows how to use the <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> class to run the <externalLink><linkText>Get-Process</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=113324</linkUri></externalLink> and <externalLink><linkText>Sort-Object</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkID=113403</linkUri></externalLink> cmdlets synchronously. The <externalLink><linkText>Get-Process</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=113324</linkUri></externalLink> cmdlet returns <codeEntityReference>T:System.Diagnostics.Process</codeEntityReference> objects for each process running on the local computer, and the Sort-Object sorts the objects based on their <codeEntityReference>P:System.Diagnostics.Process.Id</codeEntityReference> property. The results of these commands is displayed by using a <codeEntityReference>T:System.Windows.Forms.DataGridView</codeEntityReference> control.</para>
                </definition>
                <definedTerm>Runspace03</definedTerm>
                <definition>
                  <para>Shows how to use the <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> class to run a script synchronously, and how to handle non-terminating errors. The script receives a list of process names and then retrieves those processes. The results of the script, including any non-terminating errors that were generated when running the script, are displayed in a console window.</para>
                </definition>
                <definedTerm>Runspace04</definedTerm>
                <definition>
                  <para>Shows how to use the <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> class to run commands, and how to catch terminating errors that are thrown when running the commands. Two commands are run, and the last command is passed a parameter argument that is not valid. As a result, no objects are returned and a terminating error is thrown.</para>
                </definition>
                <definedTerm>Runspace05</definedTerm>
                <definition>
                  <para>Shows how to add a snap-in to an <codeEntityReference>T:System.Management.Automation.Runspaces.InitialSessionState</codeEntityReference> object so that the cmdlet of the snap-in is available when the runspace is opened. The snap-in provides a Get-Proc cmdlet (defined by the <legacyLink xlink:href="7b48bf80-cbf0-4cb1-8d5b-3b8d06196598">GetProcessSample01 Sample</legacyLink>) that is run synchronously by using a <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> object.</para>
                </definition>
                <definedTerm>Runspace06</definedTerm>
                <definition>
                  <para>Shows how to add a module to an <codeEntityReference>T:System.Management.Automation.Runspaces.InitialSessionState</codeEntityReference> object so that the module is loaded when the runspace is opened. The module provides a Get-Proc cmdlet (defined by the <legacyLink xlink:href="481f557d-3344-4d33-b2da-4736a0165181">GetProcessSample02 Sample</legacyLink>) that is run synchronously by using a <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> object.</para>
                </definition>
                <definedTerm>Runspace07</definedTerm>
                <definition>
                  <para>Shows how to create a runspace, and then use that runspace to run two cmdlets synchronously by using a <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> object.</para>
                </definition>
                <definedTerm>Runspace08</definedTerm>
                <definition>
                  <para>Shows how to add commands and arguments to the pipeline of a <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> object and how to run the commands synchronously.</para>
                </definition>
                <definedTerm>Runspace09</definedTerm>
                <definition>
                  <para>Shows how to add a script to the pipeline of a <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> object and how to run the script asynchronously. Events are used to handle the output of the script.</para>
                </definition>
                <definedTerm>Runspace10</definedTerm>
                <definition>
                  <para>Shows how to create a default initial session state, how to add a cmdlet to the <codeEntityReference>T:System.Management.Automation.Runspaces.InitialSessionState</codeEntityReference>, how to create a runspace that uses the initial session state, and how to run the command by using a <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> object.</para>
                </definition>
                <definedTerm>Runspace11</definedTerm>
                <definition>
                  <para>Shows how to use the <codeEntityReference>T:System.Management.Automation.ProxyCommand</codeEntityReference> class to create a proxy command that calls an existing cmdlet, but restricts the set of available parameters. The proxy command is then added to an initial session state that is used to create a constrained runspace. This means that the user can access the functionality of the cmdlet only through the proxy command.</para>
                </definition>
                <definedTerm>PowerShell01</definedTerm>
                <definition>
                  <para>Shows how to create a constrained runspace using an <codeEntityReference>T:System.Management.Automation.Runspaces.InitialSessionState</codeEntityReference> object.</para>
                </definition>
                <definedTerm>PowerShell02</definedTerm>
                <definition>
                  <para>Shows how to use a runspace pool to run multiple commands concurrently.</para>
                </definition>
              </definitionTable>
            </content>
          </section>
          <section>
            <title>Host samples</title>
            <content>
              <definitionTable>
                <definedTerm>Host01</definedTerm>
                <definition>
                  <para>Shows how to implement a host application that uses a custom host. In this sample a runspace is created that uses the custom host, and then the <codeEntityReference>T:System.Management.Automation.PowerShell</codeEntityReference> API is used to run a script that calls “exit.” The host application then looks at the output of the script and prints out the results.</para>
                </definition>
                <definedTerm>Host02</definedTerm>
                <definition>
                  <para>Shows how to write a host application that uses the <token>mshshort</token> runtime along with a custom host implementation. The host application sets the host culture to German, runs the <externalLink><linkText>Get-Process</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=113324</linkUri></externalLink> cmdlet and displays the results as you would see them by using pwrsh.exe, and then prints out the current data and time in German.</para>
                </definition>
                <definedTerm>Host03</definedTerm>
                <definition>
                  <para>Shows how to build an interactive console-based host application that reads commands from the command line, executes the commands, and then displays the results to the console.</para>
                </definition>
                <definedTerm>Host04</definedTerm>
                <definition>
                  <para>Shows how to build an interactive console-based host application that reads commands from the command line, executes the commands, and then displays the results to the console. This host application also supports displaying prompts that allow the user to specify multiple choices.</para>
                </definition>
                <definedTerm>Host05</definedTerm>
                <definition>
                  <para>Shows how to build an interactive console-based host application that reads commands from the command line, executes the commands, and then displays the results to the console. This host application also supports calls to remote computers by using the <externalLink><linkText>Enter-PsSession</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=135210</linkUri></externalLink> and <externalLink><linkText>Exit-PsSession</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=135212</linkUri></externalLink> cmdlets.</para>
                </definition>
                <definedTerm>Host06</definedTerm>
                <definition>
                  <para>Shows how to build an interactive console-based host application that reads commands from the command line, executes the commands, and then displays the results to the console. In addition, this sample uses the Tokenizer APIs to specify the color of the text that is entered by the user.</para>
                </definition>
              </definitionTable>
            </content>
          </section>
          <section>
            <title>Provider samples</title>
            <content>
              <definitionTable>
                <definedTerm>AccessDBProviderSample01</definedTerm>
                <definition>
                  <para>Shows how to declare a provider class that derives directly from the <codeEntityReference>T:System.Management.Automation.Provider.CmdletProvider</codeEntityReference> class. It is included here only for completeness.</para>
                </definition>
                <definedTerm>AccessDBProviderSample02</definedTerm>
                <definition>
                  <para>Shows how to overwrite the <codeEntityReference>M:System.Management.Automation.Provider.DriveCmdletProvider.NewDrive(System.Management.Automation.PSDriveInfo)</codeEntityReference> and <codeEntityReference>M:System.Management.Automation.Provider.DriveCmdletProvider.RemoveDrive(System.Management.Automation.PSDriveInfo)</codeEntityReference> methods to support calls to the New-PSDrive and Remove-PSDrive cmdlets. The provider class in this sample derives from the <codeEntityReference>T:System.Management.Automation.Provider.DriveCmdletProvider</codeEntityReference> class.</para>
                </definition>
                <definedTerm>AccessDBProviderSample03</definedTerm>
                <definition>
                  <para>Shows how to overwrite the <codeEntityReference>M:System.Management.Automation.Provider.ItemCmdletProvider.GetItem(System.String)</codeEntityReference> and <codeEntityReference>M:System.Management.Automation.Provider.ItemCmdletProvider.SetItem(System.String,System.Object)</codeEntityReference> methods to support calls to the Get-Item and Set-Item cmdlets. The provider class in this sample derives from the <codeEntityReference>T:System.Management.Automation.Provider.ItemCmdletProvider</codeEntityReference> class.</para>
                </definition>
                <definedTerm>AccessDBProviderSample04</definedTerm>
                <definition>
                  <para>Shows how to overwrite container methods to support calls to the Copy-Item, Get-ChildItem, New-Item, and Remove-Item cmdlets. These methods should be implemented when the data store contains items that are containers. A container is a group of child items under a common parent item. The provider class in this sample derives from the <codeEntityReference>T:System.Management.Automation.Provider.ItemCmdletProvider</codeEntityReference> class.</para>
                </definition>
                <definedTerm>AccessDBProviderSample05</definedTerm>
                <definition>
                  <para>Shows how to overwrite container methods to support calls to the Move-Item and Join-Path cmdlets. These methods should be implemented when the user needs to move items within a container and if the data store contains nested containers. The provider class in this sample derives from the <codeEntityReference>T:System.Management.Automation.Provider.NavigationCmdletProvider</codeEntityReference> class.</para>
                </definition>
                <definedTerm>AccessDBProviderSample06</definedTerm>
                <definition>
                  <para>Shows how to overwrite content methods to support calls to the Clear-Content, Get-Content, and Set-Content cmdlets. These methods should be implemented when the user needs to manage the content of the items in the data store. The provider class in this sample derives from the <codeEntityReference>T:System.Management.Automation.Provider.NavigationCmdletProvider</codeEntityReference> class, and it implements the <codeEntityReference>T:System.Management.Automation.Provider.IContentCmdletProvider</codeEntityReference> interface.</para>
                </definition>
              </definitionTable>
            </content>
          </section>
        </sections>
      </section>
    </sections>
  </section>
  <relatedTopics />
</developerConceptualDocument>

