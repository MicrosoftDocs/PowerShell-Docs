---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 05/11/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Send-MailMessage
---
# Send-MailMessage

## SYNOPSIS
Sends an email message.

## SYNTAX

### All

```
Send-MailMessage [-Attachments <String[]>] [-Bcc <String[]>] [[-Body] <String>] [-BodyAsHtml]
 [-Encoding <Encoding>] [-Cc <String[]>] [-DeliveryNotificationOption <DeliveryNotificationOptions>]
 -From <String> [[-SmtpServer] <String>] [-Priority <MailPriority>] [-ReplyTo <String[]>]
 [[-Subject] <String>] [-To] <String[]> [-Credential <PSCredential>] [-UseSsl] [-Port <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Send-MailMessage` cmdlet sends an email message from within PowerShell.

You must specify a Simple Mail Transfer Protocol (SMTP) server or the `Send-MailMessage` command
fails. Use the **SmtpServer** parameter or set the `$PSEmailServer` variable to a valid SMTP server.
The value assigned to `$PSEmailServer` is the default SMTP setting for PowerShell. For more
information, see [about_Preference_Variables](../Microsoft.PowerShell.Core/About/about_Preference_Variables.md).

> [!WARNING]
> The `Send-MailMessage` cmdlet is obsolete. This cmdlet does not guarantee secure connections to
> SMTP servers. While there is no immediate replacement available in PowerShell, we recommend you do
> not use `Send-MailMessage`. For more information, see
> [Platform Compatibility note DE0005](https://aka.ms/SendMailMessage).

## EXAMPLES

### Example 1: Send an email from one person to another person

This example sends an email message from one person to another person.

The **From**, **To**, and **Subject** parameters are required by `Send-MailMessage`. This example
uses the default `$PSEmailServer` variable for the SMTP server, so the **SmtpServer** parameter is
not needed.

```powershell
Send-MailMessage -From 'User01 <user01@fabrikam.com>' -To 'User02 <user02@fabrikam.com>' -Subject 'Test mail'
```

The `Send-MailMessage` cmdlet uses the **From** parameter to specify the message's sender. The
**To** parameter specifies the message's recipient. The **Subject** parameter uses the text string
**Test mail** as the message because the optional **Body** parameter is not included.

### Example 2: Send an attachment

This example sends an email message with an attachment.

```powershell
Send-MailMessage -From 'User01 <user01@fabrikam.com>' -To 'User02 <user02@fabrikam.com>', 'User03 <user03@fabrikam.com>' -Subject 'Sending the Attachment' -Body "Forgot to send the attachment. Sending now." -Attachments .\data.csv -Priority High -DeliveryNotificationOption OnSuccess, OnFailure -SmtpServer 'smtp.fabrikam.com'
```

The `Send-MailMessage` cmdlet uses the **From** parameter to specify the message's sender. The
**To** parameter specifies the message's recipients. The **Subject** parameter describes the content
of the message. The **Body** parameter is the content of the message.

The **Attachments** parameter specifies the file in the current directory that is attached to the
email message. The **Priority** parameter sets the message to **High** priority. The
**-DeliveryNotificationOption** parameter specifies two values, **OnSuccess** and **OnFailure**. The
sender will receive email notifications to confirm the success or failure of the message delivery.
The **SmtpServer** parameter sets the SMTP server to **smtp.fabrikam.com**.

### Example 3: Send email to a mailing list

This example sends an email message to a mailing list.

```powershell
Send-MailMessage -From 'User01 <user01@fabrikam.com>' -To 'ITGroup <itdept@fabrikam.com>' -Cc 'User02 <user02@fabrikam.com>' -Bcc 'ITMgr <itmgr@fabrikam.com>' -Subject "Don't forget today's meeting!" -Credential domain01\admin01 -UseSsl
```

The `Send-MailMessage` cmdlet uses the **From** parameter to specify the message's sender. The
**To** parameter specifies the message's recipients. The **Cc** parameter sends a copy of the
message to the specified recipient. The **Bcc** parameter sends a blind copy of the message. A blind
copy is an email address that is hidden from the other recipients. The **Subject** parameter is the
message because the optional **Body** parameter is not included.

The **Credential** parameter specifies a domain administrator's credentials are used to send the
message. The **UseSsl** parameter specifies that Secure Socket Layer (SSL) creates a secure
connection.

## PARAMETERS

### -Attachments

Specifies the path and file names of files to be attached to the email message. You can use this
parameter or pipe the paths and file names to `Send-MailMessage`.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: PsPath

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Bcc

Specifies the email addresses that receive a copy of the mail but are not listed as recipients of
the message. Enter names (optional) and the email address, such as `Name <someone@fabrikam.com>`.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Body

Specifies the content of the email message.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BodyAsHtml

Specifies that the value of the **Body** parameter contains HTML.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: BAH

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Cc

Specifies the email addresses to which a carbon copy (CC) of the email message is sent. Enter names
(optional) and the email address, such as `Name <someone@fabrikam.com>`.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to perform this action. The default is the current
user.

Type a user name, such as **User01** or **Domain01\User01**. Or, enter a **PSCredential** object,
such as one from the `Get-Credential` cmdlet.

Credentials are stored in a [PSCredential](/dotnet/api/system.management.automation.pscredential)
object and the password is stored as a [SecureString](/dotnet/api/system.security.securestring).

> [!NOTE]
> For more information about **SecureString** data protection, see
> [How secure is SecureString?](/dotnet/api/system.security.securestring#how-secure-is-securestring).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DeliveryNotificationOption

Specifies the delivery notification options for the email message. You can specify multiple values.
None is the default value. The alias for this parameter is **DNO**.

The delivery notifications are sent to the address in the **From** parameter.

The acceptable values for this parameter are as follows:

- `None`: No notification.
- `OnSuccess`: Notify if the delivery is successful.
- `OnFailure`: Notify if the delivery is unsuccessful.
- `Delay`: Notify if the delivery is delayed.
- `Never`: Never notify.

```yaml
Type: System.Net.Mail.DeliveryNotificationOptions
Parameter Sets: (All)
Aliases: DNO
Accepted values: None, OnSuccess, OnFailure, Delay, Never

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Encoding

Specifies the type of encoding for the target file. The default value is `utf8NoBOM`.

The acceptable values for this parameter are as follows:

- `ascii`: Uses the encoding for the ASCII (7-bit) character set.
- `bigendianunicode`: Encodes in UTF-16 format using the big-endian byte order.
- `bigendianutf32`: Encodes in UTF-32 format using the big-endian byte order.
- `oem`: Uses the default encoding for MS-DOS and console programs.
- `unicode`: Encodes in UTF-16 format using the little-endian byte order.
- `utf7`: Encodes in UTF-7 format.
- `utf8`: Encodes in UTF-8 format.
- `utf8BOM`: Encodes in UTF-8 format with Byte Order Mark (BOM)
- `utf8NoBOM`: Encodes in UTF-8 format without Byte Order Mark (BOM)
- `utf32`: Encodes in UTF-32 format.

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric IDs of registered code
pages (like `-Encoding 1251`) or string names of registered code pages (like
`-Encoding "windows-1251"`). For more information, see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage?view=netcore-2.2).

```yaml
Type: System.Text.Encoding
Parameter Sets: (All)
Aliases: BE
Accepted values: ASCII, BigEndianUnicode, BigEndianUTF32, OEM, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32

Required: False
Position: Named
Default value: UTF8NoBOM
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -From

The **From** parameter is required. This parameter specifies the sender's email address. Enter a
name (optional) and email address, such as `Name <someone@fabrikam.com>`.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Port

Specifies an alternate port on the SMTP server. The default value is 25, which is the default SMTP
port.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 25
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Priority

Specifies the priority of the email message. Normal is the default. The acceptable values for this
parameter are Normal, High, and Low.

```yaml
Type: System.Net.Mail.MailPriority
Parameter Sets: (All)
Aliases:
Accepted values: Normal, High, Low

Required: False
Position: Named
Default value: Normal
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ReplyTo

Specifies additional email addresses (other than the From address) to use to reply to this message.
Enter names (optional) and the email address, such as `Name <someone@fabrikam.com>`.

This parameter was introduced in PowerShell 6.2.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SmtpServer

Specifies the name of the SMTP server that sends the email message.

The default value is the value of the `$PSEmailServer` preference variable. If the preference
variable is not set and this parameter is not used, the `Send-MailMessage` command fails.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ComputerName

Required: False
Position: 3
Default value: $PSEmailServer
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Subject

The **Subject** parameter isn't required. This parameter specifies the subject of the email message.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: sub

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -To

The **To** parameter is required. This parameter specifies the recipient's email address. If there
are multiple recipients, separate their addresses with a comma (`,`). Enter names (optional) and the
email address, such as `Name <someone@fabrikam.com>`.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseSsl

The Secure Sockets Layer (SSL) protocol is used to establish a secure connection to the remote
computer to send mail. By default, SSL is not used.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe the path and file names of attachments to `Send-MailMessage`.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[about_Preference_Variables](../Microsoft.PowerShell.Core/About/about_Preference_Variables.md)

[Get-Credential](../Microsoft.PowerShell.Security/Get-Credential.md)

