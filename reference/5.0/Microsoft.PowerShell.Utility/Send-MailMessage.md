---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821856
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Send-MailMessage
---

# Send-MailMessage

## SYNOPSIS
Sends an email message.

## SYNTAX

```
Send-MailMessage [-Attachments <String[]>] [-Bcc <String[]>] [[-Body] <String>] [-BodyAsHtml]
 [-Encoding <Encoding>] [-Cc <String[]>] [-DeliveryNotificationOption <DeliveryNotificationOptions>]
 -From <String> [[-SmtpServer] <String>] [-Priority <MailPriority>] [-Subject] <String> [-To] <String[]>
 [-Credential <PSCredential>] [-UseSsl] [-Port <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The **Send-MailMessage** cmdlet sends an email message from within Windows PowerShell.

## EXAMPLES

### Example 1: Send an email from one user to another
```
PS C:\> Send-MailMessage -To "User01 <user01@example.com>" -From "User02 <user02@example.com>" -Subject "Test mail"
```

This command sends an email message from User01 to User02.

The mail message has a subject, which is required, but it does not have a body, which is optional.
Also, because the *SmtpServer* parameter is not specified, **Send-MailMessage** uses the value of the $PSEmailServer preference variable for the SMTP server.

### Example 2: Send an attachment
```
PS C:\> Send-MailMessage -From "User01 <user01@example.com>" -To "User02 <user02@example.com>", "User03 <user03@example.com>" -Subject "Sending the Attachment" -Body "Forgot to send the attachment. Sending now." -Attachments "data.csv" -Priority High -dno onSuccess, onFailure -SmtpServer "smtp.fabrikam.com"
```

This command sends an email message with an attachment from User01 to two other users.

It specifies a priority value of High and requests a delivery notification by email when the email messages are delivered or when they fail.

### Example 3: Send email to a mailing list
```
PS C:\> Send-MailMessage -To "User01 <user01@example.com>" -From "ITGroup <itdept@example.com>" -Cc "User02 <user02@example.com>" -bcc "ITMgr <itmgr@example.com>" -Subject "Don't forget today's meeting!" -Credential domain01\admin01 -UseSsl
```

This command sends an email message from User01 to the ITGroup mailing list with a copy (Cc) to User02 and a blind carbon copy (Bcc) to the IT manager (ITMgr).

The command uses the credentials of a domain administrator and the *UseSsl* parameter.

## PARAMETERS

### -Attachments
Specifies the path and file names of files to be attached to the email message.
You can use this parameter or pipe the paths and file names to **Send-MailMessage**.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: PsPath

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Bcc
Specifies the email addresses that receive a copy of the mail but are not listed as recipients of the message.
Enter names (optional) and the email address, such as Name \<someone@example.com\>.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body
Specifies the body of the email message.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BodyAsHtml
Indicates that the value of the *Body* parameter contains HTML.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: BAH

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cc
Specifies the email addresses to which a carbon copy (CC) of the email message is sent.
Enter names (optional) and the email address, such as Name \<someone@example.com\>.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as User01 or Domain01\User01.
Or, enter a **PSCredential** object, such as one from the Get-Credential cmdlet.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeliveryNotificationOption
Specifies the delivery notification options for the email message.
You can specify multiple values.
None is the default value.
The alias for this parameter is **dno**.

The delivery notifications are sent in an email message to the address specified in the value of the *To* parameter.
The acceptable values for this parameter are:

- None.
No notification.
- OnSuccess.
Notify if the delivery is successful.
- OnFailure.
Notify if the delivery is unsuccessful.
- Delay.
Notify if the delivery is delayed.
- Never.
Never notify.

```yaml
Type: DeliveryNotificationOptions
Parameter Sets: (All)
Aliases: DNO
Accepted values: None, OnSuccess, OnFailure, Delay, Never

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
Specifies the encoding used for the body and subject.
The acceptable values for this parameter are:

- ASCII
- UTF8
- UTF7
- UTF32
- Unicode
- BigEndianUnicode
- Default
- OEM

ASCII is the default.

```yaml
Type: Encoding
Parameter Sets: (All)
Aliases: BE

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -From
Specifies the address from which the mail is sent.
Enter a name (optional) and email address, such as Name \<someone@example.com\>.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
Specifies an alternate port on the SMTP server.
The default value is 25, which is the default SMTP port.
This parameter is available in Windows PowerShell 3.0 and newer releases.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Priority
Specifies the priority of the email message.
The acceptable values for this parameter are:

- Normal
- High
- Low

Normal is the default.

```yaml
Type: MailPriority
Parameter Sets: (All)
Aliases:
Accepted values: Normal, Low, High

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SmtpServer
Specifies the name of the SMTP server that sends the email message.

The default value is the value of the $PSEmailServer preference variable.
If the preference variable is not set and this parameter is omitted, the command fails.

```yaml
Type: String
Parameter Sets: (All)
Aliases: ComputerName

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subject
Specifies the subject of the email message.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases: sub

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -To
Specifies the addresses to which the mail is sent.
Enter names (optional) and the email address, such as Name \<someone@example.com\>.
This parameter is required.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSsl
Indicates that the cmdlet uses the Secure Sockets Layer (SSL) protocol to establish a connection to the remote computer to send mail.
By default, SSL is not used.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe the path and file names of attachments to **Send-MailMessage**.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS