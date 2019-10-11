---
title: "Deploying a Management OData web service | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 4497b64c-7875-4047-bf77-07e04c098ffe
caps.latest.revision: 4
---
# Deploying a Management OData web service

After you have completed all of the steps necessary to create a Management OData web service, you must deploy it as a web application in IIS.

## Deploying the web service

Complete the following steps to deploy the Management OData web service.

1. Create a directory for you web application under your IIS `WWWRoot` directory.

2. Copy the MOF schema file, the XML schema file, the DLLs that export the [Microsoft.Management.Odata.Customauthorization](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization) and [System.Management.Automation.Remoting.Pssessionconfiguration](/dotnet/api/System.Management.Automation.Remoting.PSSessionConfiguration) interfaces, and the web.config file into the application directory.

3. Create a site ID.

4. Create and configure an app pool.

5. Configure authentication for the site.

6. Configure the firewall.

7. Start the site.

The following Windows PowerShell scripts demonstrate how to deploy a Management OData web service.

```powershell
# Test for presence of Microsoft.Samples.Management.OData.RoleBasedPlugins.dll
$assemblyName = ".\Microsoft.Samples.Management.OData.RoleBasedPlugins.dll"

$customPluginAssembly = $assemblyName
if (!(Test-Path $customPluginAssembly))
{
    $customPluginAssembly = "..\bin\Debug\$assemblyName"

    if (!(Test-Path $customPluginAssembly))
    {
        $customPluginAssembly = "..\bin\Release\$assemblyName"

        if (!(Test-Path $customPluginAssembly))
        {
            throw "ERROR: Custom plugin assembly $assemblyName not found. Please either put it in the current folder or build the sample (so that it can be picked from bin folder)";
        }
    }
}

# RBAC account provisioning message
Write-Host "RBAC authorizes only provisioned user accounts."
Write-Host "Default RBAC configuration shipped along with samples has been provisioned for two local user accounts: localNonAdmin and localAdmin."
Write-Host "Please create either of the two user accounts on your machine and access web service from either of them."
Write-Host "If you like to use your current account with the web service, please provision it in RBAC. You need to add your user name (and domain, if there is any) in the users section of RbacConfiguration.xml"

# Installing Management OData optional component
Write-Host "Installing Management OData Service..."
.\installModata.ps1

# Setting up web service endpoint
Write-Host "Setting up web service endpoint..."
.\SetupIISConfig.ps1 -site MODataSvc -path $env:HOMEDRIVE\inetpub\wwwroot\Modata -cfgfile .\Web.config -port 7000 -app MODataSvc -svc .\Microsoft.Management.Odata.svc -schema .\Schema.mof -dispatchXml .\Schema.xml -rbac .\RbacConfiguration.xml -customPluginAssembly $customPluginAssembly

Write-Host "Web Service endpoint is setup. The source root URI is http://localhost:7000/MODataSvc/Microsoft.Management.Odata.svc"
```

```powershell
###############################################################################
# Script to setup IIS endpoint
###############################################################################
param($site = $(throw " site is a required parameter."),
$path = $(throw " path is a required parameter."),
$cfgfile = $(throw " cfgfile is a required parameter."),
$port = $(throw " port is a required parameter."),
$app = $(throw " app is a required parameter."),
$svc = $(throw " WCF Web Service File is a required parameter."),
$schema = $(throw " schema is a required parameter."),
$dispatchXml = $(throw " Dispatch Xml is a required parameter."),
$rbac = $(throw " RBac Config file is a required parameter."),
$customPluginAssembly = $(throw " Custom plugin assembly."),
[switch]$silent = $false)

Function Log
{
    param($data = $(throw "data is a required parameter."))
    if (!($silent))
    {
        $data | Out-Host
    }
}

Function ParseCommandLine
{
param($site,
    $path,
    $cfgfile,
    $port,
    $app,
    $svc,
    $schema,
    $dispatchXml,
    $rbac,
    $customPluginAssembly)

    if (!(Test-Path $cfgfile))
    {
        Log "Web.Config file does not exist"
        exit -1
    }

    if (!(Test-Path $svc))
    {
        Log "WCF WebService File does not exist"
        exit -1
    }

    if (!(Test-Path $schema))
    {
        Log "Schema File does not exist"
        exit -1
    }

    if (!(Test-Path $dispatchXml))
    {
        Log "Dispatch Xml File does not exist"
        exit -1
    }

    if (!(Test-Path $rbac))
    {
        Log "RBAC Config File does not exist"
        exit -1
    }

    if (!(Test-Path $customPluginAssembly))
    {
        Log "Custom plugin assembly file does not exist"
        exit -1
    }

    IsIIsInstalled

    $appPool = "MOData"

    Log "Delete the App Pool if it exists."
    DeleteAppPool -apppool $appPool

    Log "Delete the site if it exists."
    ActionOneSite -site $site -siteaction delete
    BackUpIISConfig

    # Create physical path dir if required and copy required files
    if (!(Test-Path $path))
    {
        New-Item -ItemType container -Path $path
    }

    ValidateAndCopyFiles -path $path -cfgfile $cfgfile -svc $svc -schema $schema -dispatchXml $dispatchXml -rbac $rbac -customPluginAssembly $customPluginAssembly

    ActionAllSites stop
    DefaultAppPool stop
    DefaultAppPool start

    SetupWebSite -site $site -path $path -port $port -app $app -apppool $appPool
}

function IsIIsInstalled
{
    if ($script:SrvMgr -eq $null)
    {
        Log "Checking IIS requirements"

        $e = $null

        $WSRegKey = (Get-ItemProperty hklm:\SYSTEM\CurrentControlSet\Services\W3SVC -ErrorAction silentlycontinue -ErrorVariable e).ImagePath

        if ($WSRegKey -eq $null)
        {
            Log "ERROR: Cannot retrieve W3SVC key. IIS Web Services may not be installed"
            exit
        }
        else
        {
            Log "W3SVC key ................. OK"
        }

        $e = $null
        $e = [System.Reflection.Assembly]::LoadFrom( "$env:windir\system32\inetsrv\Microsoft.Web.Administration.dll" )

        $script:SrvMgr = New-Object Microsoft.Web.Administration.ServerManager -ErrorAction silentlycontinue -ErrorVariable e

        if ($script:SrvMgr -eq $null)
        {
            Log "ERROR: Cannot retrieve Microsoft.Web.Administration.ServerManager Object. IIS may not be installed"
            exit
        }
        else
        {
            Log "IIS ServerManager Object .. OK"
        }

        if ( (Get-Service w3svc).Status -ne "running")
        {
            Log "ERROR: service W3SVC is not running"
            exit
        }
        else
        {
            Log "W3SVC Service ............ OK"
        }
    }
}

Function SiteIsThere
{
    PARAM($SiteName)
    $retval = $false
    $sitelist = @(& $script:appcmd list site)
    $sitelist | ForEach-Object { if($_.Split('"')[1] -eq $sitename) {$retval = $true} }
    return $retval
}

Function ActionOneSite
{
    param($site,$siteaction)
    $type=$site.GetType()
    $temp = $null
    Log "Trying to $siteaction site $site"
    #check to see if we are getting in a site object or just a string...just need the name.
    if ($site.GetType() -eq [System.String])
    {
        $temp = $site
    }
    else
    {
        $temp = $site.Name
    }

    if (SiteIsThere $temp)
    {
        & $script:appcmd $siteaction site $temp
    }
}

Function DeleteAppPool
{
    param($apppool = $(throw " appool is a required parameter."))

    Log "Delete $apppool AppPool"
    & $script:appcmd delete apppool $apppool
}

Function ActionAllSites
{
    param($action)
    foreach ($site in $script:SrvMgr.sites)
    {
        ActionOneSite $site $action
    }
}

Function DefaultAppPool
{
    param($action)
    Log "Trying to $action the default app pool"
    $null = & $script:appcmd $action apppool /apppool.name:DefaultAppPool
}

Function BackUpIISConfig
{
    $dt = Get-Date
    $backupID = "MODataIISSetup_" + $dt.Year + "-" + $dt.Month + "-" + $dt.Day + "-" + $dt.Hour + "-" + $dt.Minute + "-" + $dt.Second
    Log "Backing up IIS configuration to $backupID"
    $null = & $script:appcmd add backup $backupID
}

Function GenerateSiteID
{
    return ($script:SrvMgr.Sites | ForEach-Object { $_.Id } | Measure-Object -Maximum).Maximum + 1
}

Function ValidateAndCopyFiles
{
    param ($path = $(throw "path is a required parameter."),
    $cfgfile = $(throw "cfgfile is a required parameter."),
    $svc = $(throw "svc is a required parameter."),
    $schema = $(throw "schema is a required parameter."),
    $dispatchXml = $(throw "dispatchXml is a required parameter."),
    $rbac = $(throw "rbac is a required parameter."),
    $customPluginAssembly = $(throw "Custom plugins assembly is a required parameter."))

    if (!(Test-Path $cfgfile))
    {
        throw "ERROR: $cfgfile does not exist"
    }

    if (!(Test-Path $svc))
    {
        throw "ERROR: $svc does not exist"
    }

    if (!(Test-Path $schema))
    {
        throw "ERROR: $schema does not exist"
    }

    if (!(Test-Path $dispatchXml))
    {
        throw "ERROR: $dispatchXml does not exist"
    }

    if (!(Test-Path $rbac))
    {
        throw "ERROR: $rbac does not exist"
    }

    if (!(Test-Path $path))
    {
        New-Item -ItemType container $path
    }
    Copy-Item $cfgfile (Join-Path $path "web.config")
    Copy-Item $svc $path
    Copy-Item $schema $path
    Copy-Item $dispatchXml $path
    Copy-Item $rbac (Join-Path $path "RbacConfiguration.xml")
    Copy-Item $customPluginAssembly $path
}

Function UnlockAuthSections
{
    Log "Unlocking auth sections"
    & $script:appcmd unlock config -section:access
    & $script:appcmd unlock config -section:anonymousAuthentication
    & $script:appcmd unlock config -section:basicAuthentication
    & $script:appcmd unlock config -section:windowsAuthentication
}

Function SetRequiredAuth
{
    param($effVdir)

    Log "Setting auth schemes on $effVdir"

    & $script:appcmd set config $effVdir /section:system.webServer/security/authentication/anonymousAuthentication /enabled:false /commit:apphost
    & $script:appcmd set config $effVdir /section:system.webServer/security/authentication/basicAuthentication /enabled:true /commit:apphost
    & $script:appcmd set config $effVdir /section:system.webServer/security/authentication/windowsAuthentication /enabled:true /commit:apphost
}

Function SetupWebSite
{
    param($site = $(throw "site is a required parameter."),
    $path = $(throw "path is a required parameter."),
    $port = $(throw "port is a required parameter."),
    $app = $(throw "app is a required parameter."),
    $apppool = $(throw "apppool is a required parameter."))

    $siteID = GenerateSiteID

    Log "Adding App Pool"
    & $script:appcmd add apppool /name:$apppool

    Log "Set App Pool Properties"
    & $script:appcmd set apppool /apppool.name:$apppool /managedRuntimeVersion:"v4.0"

    Log "Adding Site"
    & $script:appcmd add site /name:$site /id:$siteID /bindings:http://*:$port /physicalPath:$ENV:systemdrive\inetpub\wwwroot

    Log "Set Site Properties"
    & $script:appcmd set site /site.name:$site /[path=`'/`'].applicationPool:$apppool

    Log "Trying to delete application:$app."
    $null=& $script:appcmd delete app $site/$app

    Log "Adding application:$app."
    & $script:appcmd add app /site.name:$site /path:/$app /physicalPath:$path

    Log "Set application:$app."
    & $script:appcmd set app /app.name:$site/$app /applicationPool:$apppool

    $effVdir = "$site"

    UnlockAuthSections

    SetRequiredAuth $effVdir

    ActionOneSite -site $site -siteaction start

}

Function CreateFirewallRule
{
param($firewallPort)

    Log "Disable Inbound Firewall Notification"
    & $script:netsh advfirewall set currentprofile settings inboundusernotification disable

    Log "Add Firewall Rule for port $firewallPort"
    & $script:netsh advfirewall firewall add rule name=MOData_IIS_Port dir=in action=allow protocol=TCP localport=$firewallPort
}

$script:wshShell = New-Object -ComObject wscript.shell
$script:appcmd = "$env:windir\system32\inetsrv\appcmd.exe"
$script:SrvMgr = $null
$script:netsh ="$env:windir\system32\netsh.exe"

Log ("Setting up test site at http://$ENV:COMPUTERNAME."+$ENV:USERDNSDOMAIN+":$port")
ParseCommandLine -site $site -path $path -cfgfile $cfgfile -port $port -app $app -svc $svc -schema $schema -dispatchXml $dispatchXml -rbac $rbac -customPluginAssembly $customPluginAssembly

CreateFirewallRule $port

ActionAllSites start

Start-Sleep 10
```

## See Also

[Implementing Custom Authorization for a Management OData web service](./implementing-custom-authorization-for-a-management-odata-web-service.md)

[Implementing SessionConfiguration for a Management OData web service](./implementing-sessionconfiguration-for-a-management-odata-web-service.md)

[Authoring the MOF schema file for a Management OData web service](./authoring-the-mof-schema-file-for-a-management-odata-web-service.md)

[Authoring the XML schema file for a Management OData web service](./authoring-the-xml-schema-file-for-a-management-odata-web-service.md)

[Authoring the Web.config file for a Management OData web service](./authoring-the-web-config-file-for-a-management-odata-web-service.md)

[Creating a Management OData Web Service](./creating-a-management-odata-web-service.md)