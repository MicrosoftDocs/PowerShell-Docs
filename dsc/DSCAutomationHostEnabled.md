
DSC uses <b>DSCAutomationHostEnabled</b>registry key under <b>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies</b> to automatically configure the machine at initial boot-up.
DSCAutomationHostEnabled supports three modes:

|  DSCAutomationHostEnabled Value  |  Description   | 
|---|---| 
0 | Disable configuring the machine at boot-up. |
1 | Enable configuring the machine at boot-up. |
2 | Enable configuring the machine only if DSC is in pending or current state. This is the default value. |


