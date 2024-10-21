---
description: This article explains how to configure and use App Control to secure PowerShell.
ms.date: 10/21/2024
title: How to use App Control to secure PowerShell
---
# How to use App Control to secure PowerShell

This article describes how to set up a **App Control for Business** policy. You can configure the
policy to enforce or audit the policy's rule. In audit mode, PowerShell behavior doesn't change but
it logs Event ID 16387 messages to the `PowerShellCore/Analytic` event log. In enforcement mode,
PowerShell applies the policy's restrictions.

This article assumes you're using a test machine so that you can test PowerShell behavior under a
machine wide App Control policy before you deploy the policy in your environment.

## Create an App Control policy

An App Control policy is described in an XML file, which contains information about policy options,
files allowed, and signing certificates recognized by the policy. When the policy is applied, only
approved files are allowed to load and run. PowerShell either blocks unapproved script files from
running or runs them in `ConstrainedLanguage` mode, depending on policy options.

You create and manipulate App Control policy using the **ConfigCI** module, which is available on
all supported Windows versions. This Windows PowerShell module can be used in Windows PowerShell 5.1
or in PowerShell 7 through the **Windows Compatibility** layer. It's easier to use this module in
Windows PowerShell. The policy you create can be applied to any version of PowerShell.

## Steps to create an App Control policy

For testing, you just need to create a default policy and a self signed code signing certificate.

1. Create a default policy

   ```powershell
   New-CIPolicy -Level PcaCertificate -FilePath .\SystemCIPolicy.xml -UserPEs
   ```

   This command creates a default policy file called `SystemCIPolicy.xml` that allows all Microsoft
   code-signed files to run.

   > [!NOTE]
   > Running this command can take up to two hours because it must scan the entire test machine.

1. Disable Audit Mode in default policy

   A new policy is always created in `Audit` mode. To test policy enforcement, you need to disable
   Audit mode when you apply the policy. Edit the `SystemCIPolicy.xml` file using a text editor like
   `notepad.exe` or Visual Studio Code (VS Code). Comment out the `Audit mode` option.

   ```XML
   <!--
   <Rule>
     <Option>Enabled:Audit Mode</Option>
   </Rule>
   -->
   ```

1. Create a self-signed code signing certificate

   You need a code signing certificate to sign any test binaries or script files that you want to
   run on your test machine. The `New-SelfSignedCertificate` is provided by the **PKI** module. For
   best results, you should run this command in Windows PowerShell 5.1.

   ```powershell
   $newSelfSignedCertificateSplat = @{
       DnsName = $env:COMPUTERNAME
       CertStoreLocation = "Cert:\CurrentUser\My\"
       Type = 'CodeSigningCert'
   }
   $cert = New-SelfSignedCertificate @newSelfSignedCertificateSplat
   Export-Certificate -Cert $cert -FilePath c:\certs\signing.cer
   Import-Certificate -FilePath C:\certs\signing.cer -CertStoreLocation "Cert:\CurrentUser\Root\"
   $cert = Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert

   dir c:\bin\powershell\pwsh.exe | Set-AuthenticodeSignature -Certificate $cert
   ```

1. Add the code signing certificate to the policy

   Use the following command to add the new code signing certificate to the policy.

   ```powershell
   Add-SignerRule -FilePath .\SystemCIPolicy.xml -CertificatePath c:\certs\signing.cer -User
   ```

1. Convert the XML policy file to a policy enforcement binary file

   Finally, you need to convert the XML file to a binary file used by App Control to apply a policy.

   ```powershell
   ConvertFrom-CIPolicy -XmlFilePath .\SystemCIPolicy.xml -BinaryFilePath .\SIPolicy.p7b
   ```

1. Apply the App Control policy

   To apply the policy to your test machine, copy the `SIPolicy.p7b` file to the required system
   location, `C:\Windows\System32\CodeIntegrity`.

   > [!NOTE]
   > Some policies definition must be copied to a subfolder such as
   > `C:\Windows\System32\CodeIntegrity\CiPolicies`. For more information, see
   > [App Control Admin Tips & Known Issues][01].

1. Disable the App Control policy

   To disable the policy, rename the `SIPolicy.p7b` file. If you need to do more testing, you can
   change the name back to reenable the policy.

   ```powershell
   Rename-Item -Path .\SIPolicy.p7b -NewName .\SIPolicy.p7b.off
   ```

## Test using App Control policy auditing

PowerShell 7.4 added a new feature to support App Control policies in **Audit** mode. In audit mode,
PowerShell runs the untrusted scripts in `ConstrainedLanguage` mode without errors, but logs
messages to the event log instead. The log messages describe what restrictions would apply if the
policy were in **Enforce** mode.

### Viewing audit events

PowerShell logs audit events to the **PowerShellCore/Analytic** event log. The log isn't enabled by
default. To enable the log, open the **Windows Event Viewer**, right-click on the
**PowerShellCore/Analytic** log and select **Enable Log**.

Alternatively, you can run the following command from an elevated PowerShell session.

```powershell
wevtutil.exe sl PowerShellCore/Analytic /enabled:true /quiet
```

You can view the events in the Windows Event Viewer or use the `Get-WinEvent` cmdlet to retrieve the
events.

```powershell
Get-WinEvent -LogName PowerShellCore/Analytic -Oldest |
    Where-Object Id -eq 16387 | Format-List
```

```Output
TimeCreated  : 4/19/2023 10:11:07 AM
ProviderName : PowerShellCore
Id           : 16387
Message      : App Control Audit.

    Title: Method or Property Invocation
    Message: Method or Property 'WriteLine' on type 'System.Console' invocation will not
        be allowed in ConstrainedLanguage mode.
        At C:\scripts\Test1.ps1:3 char:1
        + [System.Console]::WriteLine("pwnd!")
        + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    FullyQualifiedId: MethodOrPropertyInvocationNotAllowed
```

The event message includes the script position where the restriction would be applied. This
information helps you understand where you need to change your script so that it runs under the App Control
policy.

> [!IMPORTANT]
> Once you have reviewed the audit events, you should disable the Analytic log. Analytic logs grow
> quickly and consume large amounts of disk space.

### Viewing audit events in the PowerShell debugger

If you set the `$DebugPreference` variable to `Break` for an interactive PowerShell session,
PowerShell breaks into the command-line script debugger at the current location in the script where
the audit event occurred. The breakpoint allows you to debug your code and inspect the current state
of the script in real time.

<!-- link references -->
[01]: /windows/security/application-security/application-control/app-control-for-business/operations/known-issues
