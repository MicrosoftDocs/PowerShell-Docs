---
description: Describes the Type accelerators available for .NET framework classes
Locale: en-US
ms.date: 08/30/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_type_accelerators?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Type_Accelerators
---
# about_Type_Accelerators

## SHORT DESCRIPTION

Describes the Type accelerators available for .NET framework classes

## Long description

Type accelerators are aliases for .NET framework classes. They allow you to
access specific .NET framework classes without having to explicitly type the
entire class name. For example, you can shorten the **AliasAttribute**
class from `[System.Management.Automation.AliasAttribute]` to `[Alias]`.

> [!NOTE]
> All type accelerators still need to be wrapped in square brackets(`[]`).

## Available Type Accelerators

|         Accelerator          |                                                                 Full Class Name                                                                 |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| adsi                         | [System.DirectoryServices.DirectoryEntry](xref:System.DirectoryServices.DirectoryEntry)                                                         |
| adsisearcher                 | [System.DirectoryServices.DirectorySearcher](xref:System.DirectoryServices.DirectorySearcher)                                                   |
| Alias                        | [System.Management.Automation.AliasAttribute](xref:System.Management.Automation.AliasAttribute)                                                 |
| AllowEmptyCollection         | [System.Management.Automation.AllowEmptyCollectionAttribute](xref:System.Management.Automation.AllowEmptyCollectionAttribute)                   |
| AllowEmptyString             | [System.Management.Automation.AllowEmptyStringAttribute](xref:System.Management.Automation.AllowEmptyStringAttribute)                           |
| AllowNull                    | [System.Management.Automation.AllowNullAttribute](xref:System.Management.Automation.AllowNullAttribute)                                         |
| ArgumentCompleter            | [System.Management.Automation.ArgumentCompleterAttribute](xref:System.Management.Automation.ArgumentCompleterAttribute)                         |
| ArgumentCompletions          | [System.Management.Automation.ArgumentCompletionsAttribute](xref:System.Management.Automation.ArgumentCompletionsAttribute)                     |
| array                        | [System.Array](xref:System.Array)                                                                                                               |
| bigint                       | [System.Numerics.BigInteger](xref:System.Numerics.BigInteger)                                                                                   |
| bool                         | [System.Boolean](xref:System.Boolean)                                                                                                           |
| byte                         | [System.Byte](xref:System.Byte)                                                                                                                 |
| char                         | [System.Char](xref:System.Char)                                                                                                                 |
| cimclass                     | [Microsoft.Management.Infrastructure.CimClass](xref:Microsoft.Management.Infrastructure.CimClass)                                               |
| cimconverter                 | [Microsoft.Management.Infrastructure.CimConverter](xref:Microsoft.Management.Infrastructure.CimConverter)                                       |
| ciminstance                  | [Microsoft.Management.Infrastructure.CimInstance](xref:Microsoft.Management.Infrastructure.CimInstance)                                         |
| CimSession                   | [Microsoft.Management.Infrastructure.CimSession](xref:Microsoft.Management.Infrastructure.CimSession)                                           |
| cimtype                      | [Microsoft.Management.Infrastructure.CimType](xref:Microsoft.Management.Infrastructure.CimType)                                                 |
| CmdletBinding                | [System.Management.Automation.CmdletBindingAttribute](xref:System.Management.Automation.CmdletBindingAttribute)                                 |
| cultureinfo                  | [System.Globalization.CultureInfo](xref:System.Globalization.CultureInfo)                                                                       |
| datetime                     | [System.DateTime](xref:System.DateTime)                                                                                                         |
| decimal                      | [System.Decimal](xref:System.Decimal)                                                                                                           |
| double                       | [System.Double](xref:System.Double)                                                                                                             |
| DscLocalConfigurationManager | [System.Management.Automation.DscLocalConfigurationManagerAttribute](xref:System.Management.Automation.DscLocalConfigurationManagerAttribute)   |
| DscProperty                  | [System.Management.Automation.DscPropertyAttribute](xref:System.Management.Automation.DscPropertyAttribute)                                     |
| DscResource                  | [System.Management.Automation.DscResourceAttribute](xref:System.Management.Automation.DscResourceAttribute)                                     |
| ExperimentAction             | [System.Management.Automation.ExperimentAction](xref:System.Management.Automation.ExperimentAction)                                             |
| Experimental                 | [System.Management.Automation.ExperimentalAttribute](xref:System.Management.Automation.ExperimentalAttribute)                                   |
| ExperimentalFeature          | [System.Management.Automation.ExperimentalFeature](xref:System.Management.Automation.ExperimentalFeature)                                       |
| float                        | [System.Single](xref:System.Single)                                                                                                             |
| guid                         | [System.Guid](xref:System.Guid)                                                                                                                 |
| hashtable                    | [System.Collections.Hashtable](xref:System.Collections.Hashtable)                                                                               |
| initialsessionstate          | [System.Management.Automation.Runspaces.InitialSessionState](xref:System.Management.Automation.Runspaces.InitialSessionState)                   |
| int                          | [System.Int32](xref:System.Int32)                                                                                                               |
| int16                        | [System.Int16](xref:System.Int16)                                                                                                               |
| int32                        | [System.Int32](xref:System.Int32)                                                                                                               |
| int64                        | [System.Int64](xref:System.Int64)                                                                                                               |
| ipaddress                    | [System.Net.IPAddress](xref:System.Net.IPAddress)                                                                                               |
| IPEndpoint                   | [System.Net.IPEndPoint](xref:System.Net.IPEndPoint)                                                                                             |
| long                         | [System.Int64](xref:System.Int64)                                                                                                               |
| mailaddress                  | [System.Net.Mail.MailAddress](xref:System.Net.Mail.MailAddress)                                                                                 |
| NullString                   | [System.Management.Automation.Language.NullString](xref:System.Management.Automation.Language.NullString)                                       |
| ObjectSecurity               | [System.Security.AccessControl.ObjectSecurity](xref:System.Security.AccessControl.ObjectSecurity)                                               |
| ordered                      | [System.Collections.Specialized.OrderedDictionary](xref:System.Collections.Specialized.OrderedDictionary)                                       |
| OutputType                   | [System.Management.Automation.OutputTypeAttribute](xref:System.Management.Automation.OutputTypeAttribute)                                       |
| Parameter                    | [System.Management.Automation.ParameterAttribute](xref:System.Management.Automation.ParameterAttribute)                                         |
| PhysicalAddress              | [System.Net.NetworkInformation.PhysicalAddress](xref:System.Net.NetworkInformation.PhysicalAddress)                                             |
| powershell                   | [System.Management.Automation.PowerShell](xref:System.Management.Automation.PowerShell)                                                         |
| psaliasproperty              | [System.Management.Automation.PSAliasProperty](xref:System.Management.Automation.PSAliasProperty)                                               |
| pscredential                 | [System.Management.Automation.PSCredential](xref:System.Management.Automation.PSCredential)                                                     |
| pscustomobject               | [System.Management.Automation.PSObject](xref:System.Management.Automation.PSObject)                                                             |
| PSDefaultValue               | [System.Management.Automation.PSDefaultValueAttribute](xref:System.Management.Automation.PSDefaultValueAttribute)                               |
| pslistmodifier               | [System.Management.Automation.PSListModifier](xref:System.Management.Automation.PSListModifier)                                                 |
| psmoduleinfo                 | [System.Management.Automation.PSModuleInfo](xref:System.Management.Automation.PSModuleInfo)                                                     |
| psnoteproperty               | [System.Management.Automation.PSNoteProperty](xref:System.Management.Automation.PSNoteProperty)                                                 |
| psobject                     | [System.Management.Automation.PSObject](xref:System.Management.Automation.PSObject)                                                             |
| psprimitivedictionary        | [System.Management.Automation.PSPrimitiveDictionary](xref:System.Management.Automation.PSPrimitiveDictionary)                                   |
| pspropertyexpression         | [Microsoft.PowerShell.Commands.PSPropertyExpression](xref:Microsoft.PowerShell.Commands.PSPropertyExpression)                                   |
| psscriptmethod               | [System.Management.Automation.PSScriptMethod](xref:System.Management.Automation.PSScriptMethod)                                                 |
| psscriptproperty             | [System.Management.Automation.PSScriptProperty](xref:System.Management.Automation.PSScriptProperty)                                             |
| PSTypeNameAttribute          | [System.Management.Automation.PSTypeNameAttribute](xref:System.Management.Automation.PSTypeNameAttribute)                                       |
| psvariable                   | [System.Management.Automation.PSVariable](xref:System.Management.Automation.PSVariable)                                                         |
| psvariableproperty           | [System.Management.Automation.PSVariableProperty](xref:System.Management.Automation.PSVariableProperty)                                         |
| ref                          | [System.Management.Automation.PSReference](xref:System.Management.Automation.PSReference)                                                       |
| regex                        | [System.Text.RegularExpressions.Regex](xref:System.Text.RegularExpressions.Regex)                                                               |
| runspace                     | [System.Management.Automation.Runspaces.Runspace](xref:System.Management.Automation.Runspaces.Runspace)                                         |
| runspacefactory              | [System.Management.Automation.Runspaces.RunspaceFactory](xref:System.Management.Automation.Runspaces.RunspaceFactory)                           |
| sbyte                        | [System.SByte](xref:System.SByte)                                                                                                               |
| scriptblock                  | [System.Management.Automation.ScriptBlock](xref:System.Management.Automation.ScriptBlock)                                                       |
| securestring                 | [System.Security.SecureString](xref:System.Security.SecureString)                                                                               |
| semver                       | [System.Management.Automation.SemanticVersion](xref:System.Management.Automation.SemanticVersion)                                               |
| short                        | [System.Int16](xref:System.Int16)                                                                                                               |
| single                       | [System.Single](xref:System.Single)                                                                                                             |
| string                       | [System.String](xref:System.String)                                                                                                             |
| SupportsWildcards            | [System.Management.Automation.SupportsWildcardsAttribute](xref:System.Management.Automation.SupportsWildcardsAttribute)                         |
| switch                       | [System.Management.Automation.SwitchParameter](xref:System.Management.Automation.SwitchParameter)                                               |
| timespan                     | [System.TimeSpan](xref:System.TimeSpan)                                                                                                         |
| type                         | [System.Type](xref:System.Type)                                                                                                                 |
| uint                         | [System.UInt32](xref:System.UInt32)                                                                                                             |
| uint16                       | [System.UInt16](xref:System.UInt16)                                                                                                             |
| uint32                       | [System.UInt32](xref:System.UInt32)                                                                                                             |
| uint64                       | [System.UInt64](xref:System.UInt64)                                                                                                             |
| ulong                        | [System.UInt64](xref:System.UInt64)                                                                                                             |
| uri                          | [System.Uri](xref:System.Uri)                                                                                                                   |
| ushort                       | [System.UInt16](xref:System.UInt16)                                                                                                             |
| ValidateCount                | [System.Management.Automation.ValidateCountAttribute](xref:System.Management.Automation.ValidateCountAttribute)                                 |
| ValidateDrive                | [System.Management.Automation.ValidateDriveAttribute](xref:System.Management.Automation.ValidateDriveAttribute)                                 |
| ValidateLength               | [System.Management.Automation.ValidateLengthAttribute](xref:System.Management.Automation.ValidateLengthAttribute)                               |
| ValidateNotNull              | [System.Management.Automation.ValidateNotNullAttribute](xref:System.Management.Automation.ValidateNotNullAttribute)                             |
| ValidateNotNullOrEmpty       | [System.Management.Automation.ValidateNotNullOrEmptyAttribute](xref:System.Management.Automation.ValidateNotNullOrEmptyAttribute)               |
| ValidatePattern              | [System.Management.Automation.ValidatePatternAttribute](xref:System.Management.Automation.ValidatePatternAttribute)                             |
| ValidateRange                | [System.Management.Automation.ValidateRangeAttribute](xref:System.Management.Automation.ValidateRangeAttribute)                                 |
| ValidateScript               | [System.Management.Automation.ValidateScriptAttribute](xref:System.Management.Automation.ValidateScriptAttribute)                               |
| ValidateSet                  | [System.Management.Automation.ValidateSetAttribute](xref:System.Management.Automation.ValidateSetAttribute)                                     |
| ValidateTrustedData          | [System.Management.Automation.ValidateTrustedDataAttribute](xref:System.Management.Automation.ValidateTrustedDataAttribute)                     |
| ValidateUserDrive            | [System.Management.Automation.ValidateUserDriveAttribute](xref:System.Management.Automation.ValidateUserDriveAttribute)                         |
| version                      | [System.Version](xref:System.Version)                                                                                                           |
| void                         | [System.Void](xref:System.Void)                                                                                                                 |
| WildcardPattern              | [System.Management.Automation.WildcardPattern](xref:System.Management.Automation.WildcardPattern)                                               |
| wmi                          | [System.Management.ManagementObject](xref:System.Management.ManagementObject)                                                                   |
| wmiclass                     | [System.Management.ManagementClass](xref:System.Management.ManagementClass)                                                                     |
| wmisearcher                  | [System.Management.ManagementObjectSearcher](xref:System.Management.ManagementObjectSearcher)                                                   |
| X500DistinguishedName        | [System.Security.Cryptography.X509Certificates.X500DistinguishedName](xref:System.Security.Cryptography.X509Certificates.X500DistinguishedName) |
| X509Certificate              | [System.Security.Cryptography.X509Certificates.X509Certificate](xref:System.Security.Cryptography.X509Certificates.X509Certificate)             |
| xml                          | [System.Xml.XmlDocument](xref:System.Xml.XmlDocument)                                                                                           |
