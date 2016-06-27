---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294010
schema: 2.0.0
---

# Send-MailMessage
## SYNOPSIS
Sends an e-mail message.

## SYNTAX

```
Send-MailMessage [-Attachments <String[]>] [-Bcc <String[]>] [[-Body] <String>] [-BodyAsHtml]
 [-Encoding <Encoding>] [-Cc <String[]>] [-DeliveryNotificationOption <DeliveryNotificationOptions>]
 -From <String> [[-SmtpServer] <String>] [-Priority <MailPriority>] [-Subject] <String> [-To] <String[]>
 [-Credential <PSCredential>] [-UseSsl] [-Port <Int32>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The Send-MailMessage cmdlet sends an e-mail message from within Windows PowerShell.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>send-mailmessage -to "User01 <user01@example.com>" -from "User02 <user02@example.com>" -subject "Test mail"
```

This command sends an e-mail message from User01 to User02.

The mail message has a subject, which is required, but it does not have a body, which is optional.
Also, because the SmtpServer parameter is not specified, Send-MailMessage uses the value of the $PSEmailServer preference variable for the SMTP server.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>send-mailmessage -from "User01 <user01@example.com>" -to "User02 <user02@example.com>", "User03 <user03@example.com>" -subject "Sending the Attachment" -body "Forgot to send the attachment. Sending now." -Attachments "data.csv" -priority High -dno onSuccess, onFailure -smtpServer smtp.fabrikam.com
```

This command sends an e-mail message with an attachment from User01 to two other users.

It specifies a priority value of "High" and requests a delivery notification by e-mail when the e-mail messages are delivered or when they fail.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>send-mailmessage -to "User01 <user01@example.com>" -from "ITGroup <itdept@example.com>" -cc "User02 <user02@example.com>" -bcc "ITMgr <itmgr@example.com>" -subject "Don't forget today's meeting!" -credential domain01\admin01 -useSSL
```

This command sends an e-mail message from User01 to the ITGroup mailing list with a copy (CC) to User02 and a blind carbon copy (BCC) to the IT manager (ITMgr).

The command uses the credentials of a domain administrator and the UseSSL parameter.

## PARAMETERS

### -Attachments
Specifies the path and file names of files to be attached to the e-mail message.
You can use this parameter or pipe the paths and file names to Send-MailMessage.

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
Specifies the e-mail addresses that receive a copy of the mail but are not listed as recipients of the message.
Enter names (optional) and the e-mail address, such as "Name \<someone@example.com\>".

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
Specifies the body (content) of the e-mail message.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BodyAsHtml
Indicates that the value of the Body parameter contains HTML.

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
Specifies the e-mail addresses to which a carbon copy (CC) of the e-mail message is sent.
Enter names (optional) and the e-mail address, such as "Name \<someone@example.com\>".

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

Type a user name, such as "User01" or "Domain01\User01".
Or, enter a PSCredential object, such as one from the Get-Credential cmdlet.

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
Specifies the delivery notification options for the e-mail message.
You can specify multiple values.
"None" is the default value. 
The alias for this parameter is "dno".

The delivery notifications are sent in an e-mail message to the address specified in the value of the To parameter.

Valid values are:

-- None: No notification.
-- OnSuccess: Notify if the delivery is successful.
-- OnFailure: Notify if the delivery is unsuccessful.
-- Delay: Notify if the delivery is delayed.
-- Never: Never notify.

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
Valid values are ASCII, UTF8, UTF7, UTF32, Unicode, BigEndianUnicode, Default, and OEM.
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
Enter a name (optional) and e-mail address, such as "Name \<someone@example.com\>".
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

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
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
Specifies the priority of the e-mail message.
The valid values for this are Normal, High, and Low.
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
Specifies the name of the SMTP server that sends the e-mail message.

The default value is the value of the $PSEmailServer preference variable.
If the preference variable is not set and this parameter is omitted, the command fails.

```yaml
Type: String
Parameter Sets: (All)
Aliases: ComputerName

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subject
Specifies the subject of the e-mail message.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases: sub

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -To
Specifies the addresses to which the mail is sent.
Enter names (optional) and the e-mail address, such as "Name \<someone@example.com\>".
This parameter is required.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSsl
Uses the Secure Sockets Layer (SSL) protocol to establish a connection to the remote computer to send mail.
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

## INPUTS

### System.String
You can pipe the path and file names of attachments to Send-MailMessage.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

