---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  about_Signing
ms.technology:  powershell
---

# About Signing
## about_Signing



# SHORT DESCRIPTION

Explains how to sign scripts so that they comply with the Windows
PowerShell execution policies.

# LONG DESCRIPTION

The Restricted execution policy does not permit any scripts to run.
The AllSigned and RemoteSigned execution policies prevent Windows
PowerShell from running scripts that do not have a digital signature.

This topic explains how to run selected scripts that are not signed,
even while the execution policy is RemoteSigned, and how to sign
scripts for your own use.

For more information about Windows PowerShell execution policies,
see about_Execution_Policy.

# TO PERMIT SIGNED SCRIPTS TO RUN

-------------------------------
When you start Windows PowerShell on a computer for the first time, the
Restricted execution policy (the default) is likely to be in effect.

The Restricted policy does not permit any scripts to run.

To find the effective execution policy on your computer, type:

Get-ExecutionPolicy

To run unsigned scripts that you write on your local computer and
signed scripts from other users, start Windows PowerShell with the
Run as Administrator option and then use the following command to
change the execution policy on the computer to RemoteSigned:

Set-ExecutionPolicy RemoteSigned

For more information, see the help topic for the
Set-ExecutionPolicy cmdlet.

# RUNNING UNSIGNED SCRIPTS (REMOTESIGNED EXECUTION POLICY)

--------------------------------------------------------
If your Windows PowerShell execution policy is RemoteSigned, Windows
PowerShell will not run unsigned scripts that are downloaded from the
Internet, including unsigned scripts you receive through e-mail and instant
messaging programs.

If you try to run a downloaded script, Windows PowerShell displays the
following error message:

The file <file-name> cannot be loaded. The file
<file-name> is not digitally signed. The script
will not execute on the system. Please see "Get-Help
about_Signing" for more details.

Before you run the script, review the code to be sure that you trust it.
Scripts have the same effect as any executable program.

To run an unsigned script, use the Unblock-File cmdlet or use the
Following procedure.

1. Save the script file on your computer.
2. Click Start, click My Computer, and locate the saved script file.
3. Right-click the script file, and then click Properties.
4. Click Unblock.

If a script that was downloaded from the Internet is digitally signed, but
you have not yet chosen to trust its publisher, Windows PowerShell displays
the following message:

Do you want to run software from this untrusted publisher?
The file <file-name> is published by CN=<publisher-name>. This
publisher is not trusted on your system. Only run scripts
from trusted publishers.

[V] Never run  [D] Do not run  [R] Run once  [A] Always run
[?] Help (default is "D"):

If you trust the publisher, select "Run once" or "Always run."
If you do not trust the publisher, select either "Never run" or
"Do not run." If you select "Never run" or "Always run," Windows
PowerShell will not prompt you again for this publisher.

# METHODS OF SIGNING SCRIPTS

--------------------------
You can sign the scripts that you write and the scripts that you obtain
from other sources. Before you sign any script, examine each command
to verify that it is safe to run.

For best practices about code signing, see "Code-Signing
Best Practices" at http://go.microsoft.com/fwlink/?LinkId=119096.

For more information about how to sign a script file, see
Set-AuthenticodeSignature.

The New-SelfSignedCertificate cmdlet, introduced in the PKI module
in Windows PowerShell 3.0, creates a self-signed certificate that is
Appropriate for testing. For more information, see the help
topic for the New-SelfSignedCertificate cmdlet.

To add a digital signature to a script, you must sign it with a code
signing certificate. Two types of certificates are suitable for signing
a script file:

-- Certificates that are created by a certification authority:

For a fee, a public certification authority verifies your
identity and gives you a code signing certificate.  When
you purchase your certificate from a reputable certification
authority, you are able to share your script with users
on other computers that are running Windows because those other
computers trust the certification authority.

-- Certificates that you create:

You can create a self-signed certificate for which
your computer is the authority that creates the certificate.
This certificate is free of charge and enables you to write,
sign, and run scripts on your computer. However, a script
signed by a self-signed certificate will not run on other
computers.

Typically, you would use a self-signed certificate only to sign
scripts that you write for your own use and to sign scripts that you get
from other sources that you have verified to be safe. It is not
appropriate for scripts that will be shared, even within an enterprise.

If you create a self-signed certificate, be sure to enable strong
private key protection on your certificate. This prevents malicious
programs from signing scripts on your behalf. The instructions are
included at the end of this topic.

# CREATE A SELF-SIGNED CERTIFICATE

--------------------------------
To create a self-signed certificate in use the New-SelfSignedCertificate
cmdlet in the PKI module. This module is introduced in Windows PowerShell
3.0 and is included in Windows 8 and Windows Server 2012. For more
information, see the help topic for the New-SelfSignedCertificate cmdlet.

To create a self-signed certificate in earlier versions of Windows, use
the Certificate Creation tool (MakeCert.exe). This  tool is included in
the Microsoft .NET Framework SDK (versions 1.1 and later) and in the
Microsoft Windows SDK.

For more information about the syntax and the parameter descriptions of the
MakeCert.exe tool, see "Certificate Creation Tool (MakeCert.exe)" in the
MSDN (Microsoft Developer Network) library at
http://go.microsoft.com/fwlink/?LinkId=119097.

To use the MakeCert.exe tool to create a certificate, run the following
commands in an SDK Command Prompt window.

Note: The first command creates a local certification authority for
your computer. The second command generates a personal
certificate from the certification authority.

Note: You can copy or type the commands exactly as they appear.
No substitutions are necessary, although you can change the
certificate name.

makecert -n "CN=PowerShell Local Certificate Root" -a sha1 `
-eku 1.3.6.1.5.5.7.3.3 -r -sv root.pvk root.cer `
-ss Root -sr localMachine

makecert -pe -n "CN=PowerShell User" -ss MY -a sha1 `
-eku 1.3.6.1.5.5.7.3.3 -iv root.pvk -ic root.cer

The MakeCert.exe tool will prompt you for a private key password. The
password ensures that no one can use or access the certificate without
your consent. Create and enter a password that you can remember. You will
use this password later to retrieve the certificate.

To verify that the certificate was generated correctly, use the
following command to get the certificate in the certificate
store on the computer. (You will not find a certificate file in the
file system directory.)

At the Windows PowerShell prompt, type:

get-childitem cert:\CurrentUser\my -codesigning

This command uses the Windows PowerShell Certificate provider to view
information about the certificate.

If the certificate was created, the output shows the thumbprint
that identifies the certificate in a display that resembles the following:

Directory: Microsoft.PowerShell.Security\Certificate::CurrentUser\My

Thumbprint                                Subject
----------                                -------
4D4917CB140714BA5B81B96E0B18AAF2C4564FDF  CN=PowerShell User ]

# SIGN A SCRIPT

-------------

After you create a self-signed certificate, you can sign scripts. If you
use the AllSigned execution policy, signing a script permits you to run
the script on your computer.

The following sample script, Add-Signature.ps1, signs a script. However,
if you are using the AllSigned execution policy, you must sign the
Add-Signature.ps1 script before you run it.

To use this script, copy the following text into a text file, and
name it Add-Signature.ps1.

Note: Be sure that the script file does not have a .txt file name
extension. If your text editor appends ".txt", enclose the file name
in quotation marks: "add-signature.ps1".

## add-signature.ps1
## Signs a file
param([string] $file=$(throw "Please specify a filename."))
$cert = @(Get-ChildItem cert:\CurrentUser\My -codesigning)[0]
Set-AuthenticodeSignature $file $cert

To sign the Add-Signature.ps1 script file, type the following commands at
the Windows PowerShell command prompt:

$cert = @(Get-ChildItem cert:\CurrentUser\My -codesigning)[0]

Set-AuthenticodeSignature add-signature.ps1 $cert

After the script is signed, you can run it on the local computer.
However, the script will not run on computers on which the Windows
PowerShell execution policy requires a digital signature from a
trusted authority. If you try, Windows PowerShell displays the following
error message:

The file C:\remote_file.ps1 cannot be loaded. The signature of the
certificate cannot be verified.
At line:1 char:15
+ .\ remote_file.ps1 <<<<

If Windows PowerShell displays this message when you run a
script that you did not write, treat the file as you would treat any
unsigned script. Review the code to determine whether you can trust the
script.

# ENABLE STRONG PRIVATE KEY PROTECTION FOR YOUR CERTIFICATE

---------------------------------------------------------

If you have a private certificate on your computer, malicious
programs might be able to sign scripts on your behalf, which
authorizes Windows PowerShell to run them.

To prevent automated signing on your behalf, use Certificate
Manager (Certmgr.exe) to export your signing certificate to
a .pfx file. Certificate Manager is included in the Microsoft
.NET Framework SDK, the Microsoft Windows SDK, and in Internet
Explorer 5.0 and later versions.

To export the certificate:

1. Start Certificate Manager.

2. Select the certificate issued by PowerShell Local Certificate Root.

3. Click Export to start the Certificate Export Wizard.

4. Select "Yes, export the private key", and then click Next.

5. Select "Enable strong protection."

6. Type a password, and then type it again to confirm.

7. Type a file name that has the .pfx file name extension.

8. Click Finish.

To re-import the certificate:

1. Start Certificate Manager.

2. Click Import to start the Certificate Import Wizard.

3. Open to the location of the .pfx file that you created during the
export process.

4. On the Password page, select "Enable strong private key protection",
and then enter the password that you assigned during the export
process.

5. Select the Personal certificate store.

6. Click Finish.

# PREVENT THE SIGNATURE FROM EXPIRING

-----------------------------------
The digital signature in a script is valid until the signing certificate
expires or as long as a time stamp server can verify that the script was
signed while the signing certificate was valid.

Because most signing certificates are valid for one year only, using a
time stamp server ensures that users can use your script for many years
to come.

# SEE ALSO

[about_Execution_Policies](about_Execution_Policies.md)

[about_Profiles](about_Profiles.md)

Get-ExecutionPolicy

New-SelfSignedCertificate

Set-ExecutionPolicy

Set-AuthenticodeSignature

"Introduction to Code Signing" (http://go.microsoft.com/fwlink/?LinkId=106296)
