---
description: Describes the Type accelerators available for .NET framework classes 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 05/01/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_type_accelerators?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Type_Accelerators
---
# About Type Accelerators

## SHORT DESRIPTION
Describes the Type accelerators available for .NET framework classes

## LONG DESCRIPTION

Type accelerators are aliases for .NET framework classes. They allow you to
access specific .NET framework classes without having to explicitly type the
entire class name. For example, you can shorten the **AliasAttribute**
class from `[System.Management.Automation.AliasAttribute]` to `[Alias]`.

> [!NOTE]
> All type accelerators still need to be wrapped in square brackets(`[]`).

## Available Type Accelerators

|        Accelerator          |                           Full Class Name                           |
|---------------------------- | ------------------------------------------------------------------- |
|adsi                         | System.DirectoryServices.DirectoryEntry                             |
|adsisearcher                 | System.DirectoryServices.DirectorySearcher                          |
|Alias                        | System.Management.Automation.AliasAttribute                         |
|AllowEmptyCollection         | System.Management.Automation.AllowEmptyCollectionAttribute          |
|AllowEmptyString             | System.Management.Automation.AllowEmptyStringAttribute              |
|AllowNull                    | System.Management.Automation.AllowNullAttribute                     |
|ArgumentCompleter            | System.Management.Automation.ArgumentCompleterAttribute             |
|ArgumentCompletions          | System.Management.Automation.ArgumentCompletionsAttribute           |
|array                        | System.Array                                                        |
|bigint                       | System.Numerics.BigInteger                                          |
|bool                         | System.Boolean                                                      |
|byte                         | System.Byte                                                         |
|char                         | System.Char                                                         |
|cimclass                     | Microsoft.Management.Infrastructure.CimClass                        |
|cimconverter                 | Microsoft.Management.Infrastructure.CimConverter                    |
|ciminstance                  | Microsoft.Management.Infrastructure.CimInstance                     |
|CimSession                   | Microsoft.Management.Infrastructure.CimSession                      |
|cimtype                      | Microsoft.Management.Infrastructure.CimType                         |
|CmdletBinding                | System.Management.Automation.CmdletBindingAttribute                 |
|cultureinfo                  | System.Globalization.CultureInfo                                    |
|datetime                     | System.DateTime                                                     |
|decimal                      | System.Decimal                                                      |
|double                       | System.Double                                                       |
|DscLocalConfigurationManager | System.Management.Automation.DscLocalConfigurationManagerAttribute  |
|DscProperty                  | System.Management.Automation.DscPropertyAttribute                   |
|DscResource                  | System.Management.Automation.DscResourceAttribute                   |
|ExperimentAction             | System.Management.Automation.ExperimentAction                       |
|Experimental                 | System.Management.Automation.ExperimentalAttribute                  |
|ExperimentalFeature          | System.Management.Automation.ExperimentalFeature                    |
|float                        | System.Single                                                       |
|guid                         | System.Guid                                                         |
|hashtable                    | System.Collections.Hashtable                                        |
|initialsessionstate          | System.Management.Automation.Runspaces.InitialSessionState          |
|int                          | System.Int32                                                        |
|int16                        | System.Int16                                                        |
|int32                        | System.Int32                                                        |
|int64                        | System.Int64                                                        |
|ipaddress                    | System.Net.IPAddress                                                |
|IPEndpoint                   | System.Net.IPEndPoint                                               |
|long                         | System.Int64                                                        |
|mailaddress                  | System.Net.Mail.MailAddress                                         |
|NullString                   | System.Management.Automation.Language.NullString                    |
|ObjectSecurity               | System.Security.AccessControl.ObjectSecurity                        |
|OutputType                   | System.Management.Automation.OutputTypeAttribute                    |
|Parameter                    | System.Management.Automation.ParameterAttribute                     |
|PhysicalAddress              | System.Net.NetworkInformation.PhysicalAddress                       |
|powershell                   | System.Management.Automation.PowerShell                             |
|psaliasproperty              | System.Management.Automation.PSAliasProperty                        |
|pscredential                 | System.Management.Automation.PSCredential                           |
|pscustomobject               | System.Management.Automation.PSObject                               |
|PSDefaultValue               | System.Management.Automation.PSDefaultValueAttribute                |
|pslistmodifier               | System.Management.Automation.PSListModifier                         |
|psmoduleinfo                 | System.Management.Automation.PSModuleInfo                           |
|psnoteproperty               | System.Management.Automation.PSNoteProperty                         |
|psobject                     | System.Management.Automation.PSObject                               |
|psprimitivedictionary        | System.Management.Automation.PSPrimitiveDictionary                  |
|pspropertyexpression         | Microsoft.PowerShell.Commands.PSPropertyExpression                  |
|psscriptmethod               | System.Management.Automation.PSScriptMethod                         |
|psscriptproperty             | System.Management.Automation.PSScriptProperty                       |
|PSTypeNameAttribute          | System.Management.Automation.PSTypeNameAttribute                    |
|psvariable                   | System.Management.Automation.PSVariable                             |
|psvariableproperty           | System.Management.Automation.PSVariableProperty                     |
|ref                          | System.Management.Automation.PSReference                            |
|regex                        | System.Text.RegularExpressions.Regex                                |
|runspace                     | System.Management.Automation.Runspaces.Runspace                     |
|runspacefactory              | System.Management.Automation.Runspaces.RunspaceFactory              |
|sbyte                        | System.SByte                                                        |
|scriptblock                  | System.Management.Automation.ScriptBlock                            |
|securestring                 | System.Security.SecureString                                        |
|semver                       | System.Management.Automation.SemanticVersion                        |
|short                        | System.Int16                                                        |
|single                       | System.Single                                                       |
|string                       | System.String                                                       |
|SupportsWildcards            | System.Management.Automation.SupportsWildcardsAttribute             |
|switch                       | System.Management.Automation.SwitchParameter                        |
|timespan                     | System.TimeSpan                                                     |
|type                         | System.Type                                                         |
|uint                         | System.UInt32                                                       |
|uint16                       | System.UInt16                                                       |
|uint32                       | System.UInt32                                                       |
|uint64                       | System.UInt64                                                       |
|ulong                        | System.UInt64                                                       |
|uri                          | System.Uri                                                          |
|ushort                       | System.UInt16                                                       |
|ValidateCount                | System.Management.Automation.ValidateCountAttribute                 |
|ValidateDrive                | System.Management.Automation.ValidateDriveAttribute                 |
|ValidateLength               | System.Management.Automation.ValidateLengthAttribute                |
|ValidateNotNull              | System.Management.Automation.ValidateNotNullAttribute               |
|ValidateNotNullOrEmpty       | System.Management.Automation.ValidateNotNullOrEmptyAttribute        |
|ValidatePattern              | System.Management.Automation.ValidatePatternAttribute               |
|ValidateRange                | System.Management.Automation.ValidateRangeAttribute                 |
|ValidateScript               | System.Management.Automation.ValidateScriptAttribute                |
|ValidateSet                  | System.Management.Automation.ValidateSetAttribute                   |
|ValidateTrustedData          | System.Management.Automation.ValidateTrustedDataAttribute           |
|ValidateUserDrive            | System.Management.Automation.ValidateUserDriveAttribute             |
|version                      | System.Version                                                      |
|void                         | System.Void                                                         |
|WildcardPattern              | System.Management.Automation.WildcardPattern                        |
|wmi                          | System.Management.ManagementObject                                  |
|wmiclass                     | System.Management.ManagementClass                                   |
|wmisearcher                  | System.Management.ManagementObjectSearcher                          |
|X500DistinguishedName        | System.Security.Cryptography.X509Certificates.X500DistinguishedName |
|X509Certificate              | System.Security.Cryptography.X509Certificates.X509Certificate       |
|xml                          | System.Xml.XmlDocument                                              |

