---
title: about_Workflows
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f2897bdd-1b9d-4679-8b19-09840bd40a22
---
# about_Workflows
## TOPIC  
 about\_Workflows  
  
## SHORT DESCRIPTION  
 Provides a brief introduction to the [!INCLUDE[wps_1]()] Workflow feature.  
  
## LONG DESCRIPTION  
 [!INCLUDE[wps_2]()] Workflow brings the benefits of Windows Workflow Foundation to [!INCLUDE[wps_2]()] by enabling you to write and run workflows in [!INCLUDE[wps_2]()].  
  
 [!INCLUDE[wps_2]()] Workflow is introduced in [!INCLUDE[wps_2]()] 3.0.  
  
 For detailed information about [!INCLUDE[wps_2]()] Workflow, see "Introducing [!INCLUDE[wps_2]()] Workflow" in the TechNet Library at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=252592 and "Writing a [!INCLUDE[wps_2]()] Workflow" in the MSDN Library at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=246399.  
  
### ABOUT WORKFLOWS  
 Workflows are commands that consist of an ordered sequence of related activities. Typically, they run for an extended period of time, gathering data from and making changes to hundreds of computers, often in heterogeneous environments.  
  
 Workflows can be written in XAML, the language used in Windows Workflow Foundation, or in the [!INCLUDE[wps_2]()] language. Workflows are typically packaged in modules and include help topics.  
  
 Workflows are critical in an IT environment because they can survive reboots and recover automatically from common failures. You can disconnect and reconnect from sessions and computers running workflows without interrupting workflow processing, and suspend and resume workflows transparently without data loss. Each activity in a workflow can be logged and audited for reference. Workflow can run as jobs and can be scheduled by using the Scheduled Jobs feature of [!INCLUDE[wps_2]()].  
  
 The state and data in a workflow is saved or "persisted" at the beginning and end of the workflow and at points that you specify. Workflow persistence points work like database snapshots or program checkpoints to protect the workflow from the effects of interruptions and failures. In the case of a failure from which the workflow cannot recover, you can use the persisted data and resume from the last persistence point, instead of rerunning an extensive workflow from the beginning.  
  
### REQUIREMENTS AND CONFIGURATION  
 A [!INCLUDE[wps_2]()] Workflow configuration consists of the following elements.  
  
 A client computer, which runs the workflow.  
  
 A workflow session \(PSSession\) on the client computer or on a remote computer.  
  
 Managed nodes, the target computers that are affected by the workflow activities.  
  
 NOTE:  
  
 The workflow session is not required, but is recommended. PSSessions can take advantage of the robust recovery and Disconnected Sessions features of [!INCLUDE[wps_2]()] to recover disconnected workflow sessions.  
  
 Because the client computer and the computer on which the workflow session runs can be managed nodes, you can run a workflow on a single computer that fulfills all roles.  
  
 The client computer and the computer on which the workflow session runs must be running [!INCLUDE[wps_2]()] 3.0. All eligible systems are supported, including the Server Core installation options of Windows Server operating systems.  
  
 To run workflows that include cmdlets, the managed nodes must have [!INCLUDE[wps_2]()] 2.0 or later. Managed nodes do not require [!INCLUDE[wps_2]()] unless the workflow include cmdlets. You can run workflows that include Windows Management Instrumentation \(WMI\) and Common Information Model \(CIM\) commands on computers that do not have [!INCLUDE[wps_2]()].  
  
 For more information about system requirements and configuration, see "Introducing [!INCLUDE[wps_2]()] Workflow" in the TechNet Library at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=252592.  
  
### HOW TO GET WORKFLOWS  
 Workflows are typically packaged in modules. To import the module that includes a workflow, use any command in the module or use the Import\-Module cmdlets. Modules are imported automatically on first use of any command in the module.  
  
 To find the workflows in modules installed on your computer, use the CommandType parameter of the Get\-Command cmdlet.  
  
```  
PS C:\> Get-Command -CommandType Workflow  
```  
  
### HOW TO RUN WORKFLOWS  
 To run a workflow, use the following procedure.  
  
 1. On the client computer, start [!INCLUDE[wps_2]()] with the Run as administrator option.  
  
```  
PS C:\> Start-Process PowerShell -Verb RunAs  
```  
  
 This step is not required when the managed node is the local computer.  
  
 2. Enable [!INCLUDE[wps_2]()] remoting on the computer on which the workflow session runs and on managed nodes affected by workflows that include cmdlets.  
  
 You need to do this step only once on each participating computer.  
  
 This step is required only when running workflows that include cmdlets. You do not need to enable remoting on the client computer \(unless the workflows session runs on the client computer\) or on any managed nodes that are running [!INCLUDE[wps_2]()] 3.0.  
  
 To enable remoting, use the Enable\-PSRemoting cmdlet.  
  
```  
PS C:\> Enable-PSRemoting -Force  
```  
  
 You can also enable remoting by using the "Turn on Script Execution" Group Policy setting. For more information, see about\_Group\_Policy\_Settings \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=251696\) and about\_Execution\_Policies\(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135170\).  
  
 3. Create the workflow session. Use the New\-PSWorkflowSession or New\-PSSession cmdlets.  
  
 The New\-PSWorkflowSession cmdlet starts a session that uses the built\-in Microsoft.PowerShell.Workflow session configuration on the destination computer. This session configuration includes scripts, type and formatting files, and options that are designed for workflows.  
  
 On the local computer:  
  
```  
PS C:\> $ws = New-PSWorkflowSession  
```  
  
 On a remote computer:  
  
```  
PS C:\> $ws = New-PSWorkflowSession -ComputerName Server01 `  
        -Credential Domain01\Admin01  
```  
  
 Or, use the New\-PSSession cmdlet. Use the ConfigurationName parameter to specify the Microsoft.PowerShell.Workflow session configuration. This command is equivalent to using the New\-PSWorkflowSession cmdlet.  
  
 If you are a member of the Administrators group on the workflow session computer, you can also use the New\-PSWorkflowExecutionOption cmdlet to create custom option settings for the workflow session configuration and use the Set\-PSSessionConfiguration cmdlet to change the session configuration.  
  
```  
PS C:\> $sto = New-PSWorkflowExecutionOption -MaxConnectedSessions 150  
PS C:\> Invoke-Command -ComputerName Server01 `  
         {Set-PSSessionConfiguration Microsoft.PowerShell.Workflow `  
          -SessionTypeOption $Using:sto}  
PS C:\> $ws = New-PSWorkflowSession -ComputerName Server01 `  
        -Credential Domain01\Admin01            
```  
  
 4. Run the workflow in the workflow session. To specify the names of the managed nodes \(target computers\), use the PSComputerName workflow common parameter.  
  
 The following commands run the Test\-Workflow workflow.  
  
 Where the managed node is the computer that hosts:  
  
 The workflow session:  
  
```  
PS C:\> Invoke-Command -Session $ws {Test-Workflow}  
```  
  
 Where the managed nodes are remote computers.  
  
```  
PS C:\> Invoke-Command -Session $ws{  
           Test-Workflow -PSComputerName Server01, Server02 }  
```  
  
 The following commands run the Test\-Workflow workflow on hundreds of computers. The first command gets the computer names from a text files and saves them in the $Servers variable on the local computer.  
  
 The second command uses the Using scope modifier to indicate that the $Servers variable is defined in the local session.  
  
```  
PS C:\> $Servers = Get-Content Servers.txt  
PS C:\> Invoke-Command -Session $ws {Test-Workflow -PSComputerName $Using:Servers }  
```  
  
 For more information about the Using scope modifier, see about\_Remote\_Variables at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=252653  
  
### USING WORKFLOW COMMON PARAMETERS  
 The workflow common parameters are a set of parameters that [!INCLUDE[wps_2]()] adds automatically to all workflows. [!INCLUDE[wps_2]()] also adds the cmdlet common parameters to all workflows, even if the workflow do not use the CmdletBinding attribute.  
  
 For example, the following very simple workflow defines no parameters. However, when you run the workflow, it has both the CommonParameters and WorkflowCommonParameters.  
  
```  
PS C:\> workflow Test-Workflow {Get-Process}  
PS C:\> Get-Command Test-Workflow -Syntax  
```  
  
```  
Test-Workflow [<WorkflowCommonParameters>] [<CommonParameters>]  
```  
  
 The workflow common parameters include several parameters that are essential to running workflows. For example, the PSComputerName common parameter specifies the managed nodes that the workflow affects.  
  
```  
PS C:\> Invoke-Command -Session $ws `  
         {Test-Workflow -PSComputerName Server01, Server02}  
  
```  
  
 The PSPersist workflow common parameter determines when workflow data is persisted. It enables you to add persistence point between activities to workflows that do not define persistence points.  
  
```  
PS C:\> Invoke-Command -Session $ws `  
          {Test-Workflow -PSComputerName Server01, Server02 -PSPersist:$True}  
```  
  
 Other workflow common parameters let you specify the characteristics of the remote connection to the managed nodes. Their names and functionality are very similar to the parameters of remoting cmdlets, including Invoke\-Command.  
  
```  
PS C:\> Invoke-Command -Session $ws `  
         {Test-Workflow -PSComputerName Server01, Server02 -PSPort 443}  
```  
  
 Take care to distinguish the remoting parameters that define the connection for the workflow session from the PS\-prefixed workflow common parameters that define the connection to the managed nodes.  
  
```  
PS C:\> $ws = New-PSSession -ComputerName Server01 `  
        -ConfigurationName Microsoft.PowerShell.Workflow  
```  
  
```  
PS C:\> Invoke-Command -Session $ws `  
         {Test-Workflow -PSComputerName Server01, Server02 `  
        -PSConfigurationName Microsoft.PowerShell.Workflow}  
```  
  
 Some workflow common parameters are unique to workflows, such as the PSParameterCollection parameter that lets you specify different workflow common parameter values for different remote nodes.  
  
 For a list and description of the workflow common parameters, see about\_WorkflowCommonParameters at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=222527.  
  
## SEE ALSO  
 Invoke\-AsWorkflow  
  
 New\-PSSessionExecutionOption  
  
 New\-PSWorkflowSession  
  
 about\_WorkflowCommonParameters  
  
 "Getting Started with Windows PowerShell Workflow"  
  
 \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=252592\)  
  
 "Writing a Windows PowerShell Workflow"  
  
 \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=246399\)