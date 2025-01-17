---
description: Explains how to sign scripts so that they comply with the PowerShell execution policies.
Locale: en-US
ms.date: 01/07/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_signing?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Signing
---
# about_Signing

## Short description

Explains how to sign scripts so that they comply with the PowerShell execution
policies.

## Long description

> This information only applies to PowerShell running on Windows.

The Restricted execution policy doesn't permit any scripts to run. The
**AllSigned** and **RemoteSigned** execution policies prevent PowerShell from
running scripts that don't have a digital signature.

This topic explains how to run selected scripts that aren't signed, even while
the execution policy is **RemoteSigned**, and how to sign scripts for your own
use.

PowerShell checks the Authenticode signature of the following type types:

- `.ps1` script files
- `.psm1` module files
- `.psd1` module manifest and data files
- `.ps1xml` type and format XML files
- `.cdxml` CDXML script files
- `.xaml` XAML script files

For more information about PowerShell execution policies, see
[about_Execution_Policies][03].

## Permit the execution of signed scripts

When you start PowerShell on a computer for the first time, the **Restricted**
execution policy, which is the default, is likely to be in effect.

The **Restricted** policy prevents all scripts from running.

To find the effective execution policy on your computer, type:

```powershell
Get-ExecutionPolicy
```

The **RemoteSigned** policy allows you to run signed scripts or unsigned
scripts that you create locally. To configure this policy, start PowerShell
with the **Run as Administrator** option and then use the following command to
change the execution policy.

```powershell
Set-ExecutionPolicy RemoteSigned
```

For more information, see the help topic for the `Set-ExecutionPolicy` cmdlet.

To run a signed script, the script must have a digital signature from a trusted
publisher. The code signing certificate must be issued by a certification
must be issued by a certification authority that is trusted on the computer.
Self-signed certificates must be installed in the **Trusted Root Certificates**
store on the computer.

## Run unsigned scripts using the RemoteSigned policy

If your PowerShell execution policy is **RemoteSigned**, PowerShell won't run
unsigned scripts that are downloaded from the internet, including unsigned
scripts you receive through email and instant messaging programs.

If you try to run a downloaded script, PowerShell displays the following error
message:

```Output
The file <file-name> cannot be loaded. The file <file-name> is not
digitally signed. The script will not execute on the system. Please see
"Get-Help about_Signing" for more details.
```

Before you run the script, review the code to be sure that you trust it.
Scripts have the same effect as any executable program.

To run an unsigned script, use the `Unblock-File` cmdlet or use the following
procedure.

1. Save the script file on your computer.
1. Click **Start**, click **My Computer**, and locate the saved script file.
1. Right-click the script file, and then click **Properties**.
1. Click **Unblock**.

If a script that you downloaded from the internet is digitally signed, but you
haven't yet chosen to trust its publisher, PowerShell displays the following
message:

```Output
Do you want to run software from this untrusted publisher?
The file <file-name> is published by CN=<publisher-name>. This
publisher is not trusted on your system. Only run scripts
from trusted publishers.

[V] Never run  [D] Do not run  [R] Run once  [A] Always run
[?] Help (default is "D"):
```

If you trust the publisher, select **Run once** or **Always run**. If you don't
trust the publisher, select either **Never run** or **Do not run**. If you
select **Never run** or **Always run**, PowerShell won't prompt you again for
this publisher.

## Methods of signing scripts

You can sign the scripts that you write and the scripts that you get from other
sources. Before you sign any script, examine each command to verify that it's
safe to run.

For more information about how to sign a script file, see
[Set-AuthenticodeSignature][06].

The `New-SelfSignedCertificate` cmdlet, introduced in the PKI module in
PowerShell 3.0, creates a self-signed certificate that's appropriate for
testing. For more information, see the help topic for the
`New-SelfSignedCertificate` cmdlet.

To add a digital signature to a script, you must sign it with a code signing
certificate. Two types of certificates are suitable for signing a script file:

- Certificates that are created by a certification authority: For a fee, a
  public certification authority verifies your identity and gives you a code
  signing certificate. When you purchase your certificate from a reputable
  certification authority, you are able to share your script with users on
  other computers that are running Windows because those other computers trust
  the certification authority.

- Certificates that you create: You can create a self-signed certificate for
  which your computer is the authority that creates the certificate. This
  certificate is free of charge and enables you to write, sign, and run scripts
  on your computer. However, a script signed by a self-signed certificate will
  not run on other computers.

Self-signed certificate should only be used to sign scripts for testing
purposes.

It isn't appropriate for scripts that will be shared, even within an
enterprise.

If you create a self-signed certificate, be sure to enable strong private key
protection on your certificate. This prevents malicious programs from signing
scripts on your behalf. The instructions are included at the end of this
topic.

## Create a self-signed certificate

To create a self-signed certificate, use the [New-SelfSignedCertificate][08]
cmdlet in the PKI module. This module is introduced in PowerShell 3.0. For more
information, see the help topic for the `New-SelfSignedCertificate` cmdlet.

```powershell
$params = @{
    Subject = 'CN=PowerShell Code Signing Cert'
    Type = 'CodeSigning'
    CertStoreLocation = 'Cert:\CurrentUser\My'
    HashAlgorithm = 'sha256'
}
$cert = New-SelfSignedCertificate @params
```

### Using Makecert.exe

To create a self-signed certificate in earlier versions of Windows, use the
Certificate Creation tool `MakeCert.exe`. This tool is included in the
Microsoft .NET SDK (versions 1.1 and later) and in the Microsoft Windows SDK.

For more information about the syntax and the parameter descriptions of the
`MakeCert.exe` tool, see [Certificate Creation Tool (MakeCert.exe)][01].

To use the `MakeCert.exe` tool to create a certificate, run the following
commands in an SDK Command Prompt window.

> [!NOTE]
> The first command creates a local certification authority for your computer.
> The second command generates a personal certificate from the certification
> authority. You can copy or type the commands exactly as they appear. No
> substitutions are necessary, although you can change the certificate name.

```powershell
makecert -n "CN=PowerShell Local Certificate Root" -a sha256 `
-eku 1.3.6.1.5.5.7.3.3 -r -sv root.pvk root.cer `
-ss Root -sr localMachine

makecert -pe -n "CN=PowerShell User" -ss MY -a sha256 `
-eku 1.3.6.1.5.5.7.3.3 -iv root.pvk -ic root.cer
```

The `MakeCert.exe` tool prompts you for a private key password. The password
ensures that no one can use or access the certificate without your consent.
Create and enter a password that you can remember. You'll use this password
later to retrieve the certificate.

To verify that the certificate generated correctly, use the following command
to get the certificate in the certificate store on the computer. You won't find
a certificate file in the file system directory.

At the PowerShell prompt, type:

```powershell
Get-ChildItem cert:\CurrentUser\my -CodeSigning
```

This command uses the PowerShell Certificate provider to view information
about the certificate.

If the certificate was created, the output shows the **thumbprint** that
identifies the certificate in a display that resembles the following:

```Output
Directory: Microsoft.PowerShell.Security\Certificate::CurrentUser\My

Thumbprint                                Subject
----------                                -------
4D4917CB140714BA5B81B96E0B18AAF2C4564FDF  CN=PowerShell User ]
```

## Sign a script

After you create a self-signed certificate, you can sign scripts. If you use
the **AllSigned** execution policy, signing a script permits you to run the
script on your computer.

The following sample script, `Add-Signature.ps1`, signs a script. However, if
you are using the **AllSigned** execution policy, you must sign the
`Add-Signature.ps1` script before you run it.

> [!IMPORTANT]
> Before PowerShell 7.2, the script must be saved using ASCII or UTF8NoBOM
> encoding. PowerShell 7.2 and higher supports signed scripts for any encoding
> format.

To use this script, copy the following text into a text file, and name it
`Add-Signature.ps1`.

```powershell
## Signs a file
[cmdletbinding()]
param(
    [Parameter(Mandatory=$true)]
    [string] $File
)

$cert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert |
    Select-Object -First 1

Set-AuthenticodeSignature -FilePath $File -Certificate $cert
```

To sign the `Add-Signature.ps1` script file, type the following commands at the
PowerShell command prompt:

```powershell
$cert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert |
    Select-Object -First 1

Set-AuthenticodeSignature add-signature.ps1 $cert
```

After you sign the script, you can run it on the local computer. However, the
script won't run on computers where the PowerShell execution policy requires a
digital signature from a trusted authority. If you try, PowerShell displays the
following error message:

```Output
The file C:\remote_file.ps1 cannot be loaded. The signature of the
certificate cannot be verified.
At line:1 char:15
+ .\ remote_file.ps1 <<<<
```

If PowerShell displays this message when you run a script that you didn't
write, treat the file as you would treat any unsigned script. Review the code
to determine whether you can trust the script.

## Enable strong protection for your private key

If you have a private key and certificate on your computer, malicious programs
might be able to sign scripts on your behalf, which authorizes PowerShell to
run them.

To prevent automated signing on your behalf, use Certificate Manager
`Certmgr.exe` to export your signing key and certificate to a `.pfx` file.
Certificate Manager is included in the Microsoft .NET SDK, the Microsoft
Windows SDK, and in Internet Explorer.

To export the certificate:

1. Start Certificate Manager.
1. Select the certificate issued by PowerShell Local Certificate Root.
1. Click **Export** to start the Certificate Export Wizard.
1. Select **Yes, export the private key**, and then click **Next**.
1. Select **Enable strong protection**.
1. Type a password, and then type it again to confirm.
1. Type a filename that has the `.pfx` filename extension.
1. Click **Finish**.

To re-import the certificate:

1. Start Certificate Manager.
1. Click **Import** to start the Certificate Import Wizard.
1. Open to the location of the `.pfx` file that you created during the export
   process.
1. On the Password page, select **Enable strong private key protection**, and
   then enter the password that you assigned during the export process.
1. Select the **Personal** certificate store.
1. Click **Finish**.

## Prevent the signature from expiring

The digital signature in a script is valid until the signing certificate
expires or as long as a timestamp server can verify that the script was signed
while the signing certificate was valid.

Because most signing certificates are valid for one year only, using a time
stamp server ensures that users can use your script for many years to come.

## See also

- [about_Execution_Policies][03]
- [about_Profiles][04]
- [Set-AuthenticodeSignature][06]
- [Get-ExecutionPolicy][05]
- [Set-ExecutionPolicy][07]
- [Introduction to Code Signing][02]

<!-- link references -->
[01]: /previous-versions/dotnet/netframework-2.0/bfsktky3(v=vs.80)
[02]: /previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms537361(v=vs.85)
[03]: about_Execution_Policies.md
[04]: about_Profiles.md
[05]: xref:Microsoft.PowerShell.Security.Get-ExecutionPolicy
[06]: xref:Microsoft.PowerShell.Security.Set-AuthenticodeSignature
[07]: xref:Microsoft.PowerShell.Security.Set-ExecutionPolicy
[08]: xref:pki.New-SelfSignedCertificate
