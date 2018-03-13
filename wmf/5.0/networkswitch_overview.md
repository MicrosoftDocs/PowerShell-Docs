---
ms.date:  2017-06-12
author:  JKeithB
ms.topic:  reference
keywords:  wmf,powershell,setup
---

# Network Switch Management with PowerShell

The **Get-NetworkSwitchEthernetPort** cmdlet now returns the following additional information with instances:

- IPAddress – the IP address associated with the port
- PortMode – the port mode: access, route, or trunk
- AccessVLAN – the ID of the VLAN associated with this port in access mode
- TrunkedVLANList – a list of IDs of VLANs associated with this port in trunk mode

## Fundamental network switch management with Windows PowerShell

The Network Switch cmdlets, introduced in WMF 5.0, enable you to apply switch, virtual LAN (VLAN), and basic Layer 2 network switch port configuration to Windows Server 2012 R2 logo-certified network switches. Microsoft remains committed to supporting the [Datacenter Abstraction](http://technet.microsoft.com/cloud/dal.aspx) Layer (DAL) vision, and to show value for our customers and partners in this space. Using these cmdlets you can perform:

- Global switch configuration, such as:
    - Set host name
    - Set switch banner
    - Persist configuration
    - Enable or disable feature

- VLAN configuration:
    - Create or remove VLAN
    - Enable or disable VLAN
    - Enumerate VLAN
    - Set friendly name to a VLAN

- Layer 2 port configuration:
    - Enumerate ports
    - Enable or disable ports
    - Set port modes and properties
    - Add or associate VLAN to Trunk or Access on the port

Start exploring by looking for all of the NetworkSwitch cmdlets!

```powershell
PS> Get-Command *-NetworkSwitch*

| CommandType | Name                                      | Source        |
|-------------|-------------------------------------------|---------------|
|             |                                           |               |
| Function    | Disable-NetworkSwitchEthernetPort         | NetworkSwitch |
| Function    | Disable-NetworkSwitchFeature              | NetworkSwitch |
| Function    | Disable-NetworkSwitchVlan                 | NetworkSwitch |
| Function    | Enable-NetworkSwitchEthernetPort          | NetworkSwitch |
| Function    | Enable-NetworkSwitchFeature               | NetworkSwitch |
| Function    | Enable-NetworkSwitchVlan                  | NetworkSwitch |
| Function    | Get-NetworkSwitchEthernetPort             | NetworkSwitch |
| Function    | Get-NetworkSwitchFeature                  | NetworkSwitch |
| Function    | Get-NetworkSwitchGlobalData               | NetworkSwitch |
| Function    | Get-NetworkSwitchVlan                     | NetworkSwitch |
| Function    | New-NetworkSwitchVlan                     | NetworkSwitch |
| Function    | Remove-NetworkSwitchEthernetPortIPAddress | NetworkSwitch |
| Function    | Remove-NetworkSwitchVlan                  | NetworkSwitch |
| Function    | Restore-NetworkSwitchConfiguration        | NetworkSwitch |
| Function    | Save-NetworkSwitchConfiguration           | NetworkSwitch |
| Function    | Set-NetworkSwitchEthernetPortIPAddress    | NetworkSwitch |
| Function    | Set-NetworkSwitchPortMode                 | NetworkSwitch |
| Function    | Set-NetworkSwitchPortProperty             | NetworkSwitch |
| Function    | Set-NetworkSwitchVlanProperty             | NetworkSwitch |
```

More information is available in Jeffrey Snover’s WMF 5.0 Preview announcement blog post: <http://blogs.technet.com/b/windowsserver/archive/2014/04/03/windows-management-framework-v5-preview.aspx>

