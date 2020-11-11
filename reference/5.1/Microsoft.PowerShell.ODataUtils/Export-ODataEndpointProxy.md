---
external help file: Microsoft.PowerShell.ODataUtils-help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.ODataUtils
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.odatautils/export-odataendpointproxy?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Export-ODataEndpointProxy
---
# Export-ODataEndpointProxy

## SYNOPSIS
Generates a module that contains cmdlets to manage an OData endpoint.

## SYNTAX

```
Export-ODataEndpointProxy [-Uri] <String> [-OutputModule] <String> [[-MetadataUri] <String>]
 [[-Credential] <PSCredential>] [[-CreateRequestMethod] <String>] [[-UpdateRequestMethod] <String>]
 [[-CmdletAdapter] <String>] [[-ResourceNameMapping] <Hashtable>] [-Force] [[-CustomData] <Hashtable>]
 [-AllowClobber] [-AllowUnsecureConnection] [[-Headers] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Export-ODataEndpointProxy` cmdlet uses the metadata of an OData endpoint to generate a module
that contains cmdlets you can use to manage that OData endpoint. The module is based on CDXML. After
this cmdlet generates the module, it saves that module to the path and file name specified by the
**OutputModule** parameter.

`Export-ODataEndpointProxy` generates cmdlets for create, read, update, and delete (CRUD)
operations, non-CRUD actions, and association manipulation.

`Export-ODataEndpointProxy` generates one CDXML file per endpoint resource. You can edit these CDXML
files after the module is generated. For example, if you want to change the noun or verb names of
the cmdlets to align with Windows PowerShell cmdlet naming guidelines, you can modify the file.

Every cmdlet in a generated module must include a **ConnectionURI** parameter in order to connect to
the endpoint that the module manages.

## EXAMPLES

### Example 1: Generate a module to manage a retail web service endpoint

```powershell
PS C:\> Export-ODataEndpointProxy -Uri 'http://services.odata.org/v3/(S(snyobsk1hhutkb2yulwldgf1))/odata/odata.svc' -MetadataUri 'http://services.odata.org/v3/(S(snyobsk1hhutkb2yulwldgf1))/odata/odata.svc/$metadata' -AllowUnsecureConnection -OutputModule 'C:\Users\user\GeneratedScript.psm1' -ResourceNameMapping @{Products = 'Merchandise'}
```

This command generates a module to manage a retail service endpoint. The command specifies the URI
of the endpoint and the URI of the endpoint metadata. The command also provides an output path and
script module name as the value of the **OutputModule** parameter. For the value of the
**ResourceNameMapping** parameter, the command provides a hashtable that maps the resource
collection name to the desired noun for the cmdlet set. In this example, Products is the resource
collection name and **Merchandise** is the noun. To allow connections to non-SSL sites, HTTP, as
opposed to HTTPS, add the **AllowUnsecureConnection** parameter.

## PARAMETERS

### -AllowClobber

Indicates that this cmdlet replaces an existing module.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AllowUnsecureConnection

Indicates that this module can connect to URIs that are not SSL-secured. The module can manage HTTP
sites in addition to HTTPS sites.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CmdletAdapter

Specifies the cmdlet adapter. The acceptable values for this parameter are: ODataAdapter and
NetworkControllerAdapter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: ODataAdapter, NetworkControllerAdapter, ODataV4Adapter

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CreateRequestMethod

Specifies the request method. The acceptable values for this parameter are: PUT, POST, and PATCH.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Put, Post, Patch

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has access to the OData endpoint. The default value is the current
user. If a remote computer runs Windows Vista or a later release of the Windows operating system,
the cmdlet prompts you for credentials.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CustomData

Specifies a hash table of custom data.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force

Indicates that this cmdlet overwrites an existing generated module of the same name in an existing
`Modules` folder.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Headers

Specifies the headers of the web request. Enter a hash table or dictionary.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MetadataUri

Specifies the URI of the metadata of the endpoint.

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

### -OutputModule

Specifies the path and module name to which this cmdlet saves the generated module of proxy
commands.

This cmdlet copies a binary module, module manifest, and formatting file, if applicable, to the
specified folder. If you specify only the name of the module, `Export-ODataEndpointProxy` saves the
module in the `$home\Documents\WindowsPowerShell\Modules` folder. If you specify a path, the cmdlet
creates the module folder in that path.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceNameMapping

Specifies a hashtable that contains mappings that let you customize the generated cmdlets. In this
hashtable, the resource collection name is the key. The desired cmdlet noun is the value.

For example, in the hash table `@{Products = 'Merchandise'}`, **Products** is the resource
collection name that serves as the key. **Merchandise** is the resulting cmdlet noun. The generated
cmdlet names might not align to Windows PowerShell cmdlet naming guidelines. You can modify the
resource CDXML file to change the cmdlet names after this cmdlet creates the module. For more
information, see
[Strongly Encouraged Development Guidelines](/powershell/scripting/developer/cmdlet/strongly-encouraged-development-guidelines).

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UpdateRequestMethod

Specifies the update request method. The acceptable values for this parameter are: PUT, POST, and
PATCH.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Put, Post, Patch

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Uri

Specifies the URI of the endpoint.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[OData Library](/previous-versions/dotnet/wcf-data-services/hh525392(v=vs.103))

[What is the OData Protocol?](https://www.odata.org/)

[Invoke-RestMethod](../Microsoft.PowerShell.Utility/Invoke-RestMethod.md)
