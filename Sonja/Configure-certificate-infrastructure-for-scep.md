---
title: Configure certificate infrastructure for SCEP |Microsoft Intune
description: Infrastructure for creating and deploying SCEP certificate profiles.
keywords:
author: nbigman
manager: angrobe
ms.date: 07/25/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 4ae137ae-34e5-4a45-950c-983de831270f


# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: kmyrup
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:
---
# Configure certificate infrastructure for SCEP
This topic describes what infrastructure you need in order to create and deploy SCEP certificate profiles.

### On-premises infrastructure

-    **Active Directory domain**: All servers listed in this section (except for the Web Application Proxy Server) must be joined to your Active Directory domain.

-  **Certification Authority** (CA): An Enterprise Certification Authority (CA) that runs on an Enterprise edition of Windows Server 2008 R2 or later. A Standalone CA is not supported. For instructions on how to set up a Certification Authority, see [Install the Certification Authority](http://technet.microsoft.com/library/jj125375.aspx).
    If your CA runs Windows Server 2008 R2, you must [install the hotfix from KB2483564](http://support.microsoft.com/kb/2483564/).
I
-  **NDES Server**: On a server that runs Windows Server 2012 R2 or later, you must setup up the Network Device Enrollment Service (NDES). Intune does not support using NDES when it runs on a server that also runs the Enterprise CA. See [Network Device Enrollment Service Guidance](http://technet.microsoft.com/library/hh831498.aspx) for instructions on how to configure Windows Server 2012 R2 to host the Network Device Enrollment Service. The NDES server must be domain joined to the domain that hosts the CA, and not be on the same server as the CA. More information about deploying the NDES server in a separate forest, isolated network or internal domain can be found in [Using a Policy Module with the Network Device Enrollment Service](https://technet.microsoft.com/en-us/library/dn473016.aspx).

-  **Microsoft Intune Certificate Connector**: You use the Intune admin console to download the **Certificate Connector** installer (**ndesconnectorssetup.exe**). Then you can run **ndesconnectorssetup.exe** on the computer where you want to install the Certificate Connector.
-  **Web Application Proxy Server** (optional): You can use a server that runs Windows Server 2012 R2  or later as a Web Application Proxy (WAP) server. This configuration:
    -  Allows devices to receive certificates using an Internet connection.
    -  Is a security recommendation when devices connect through the Internet to receive and renew certificates.

 > [!NOTE]           
> -    The server that hosts WAP [must install an update](http://blogs.technet.com/b/ems/archive/2014/12/11/hotfix-large-uri-request-in-web-application-proxy-on-windows-server-2012-r2.aspx) that enables support for the long URLs that are used by the Network Device Enrollment Service. This update is included with the [December 2014 update rollup](http://support.microsoft.com/kb/3013769), or individually from [KB3011135](http://support.microsoft.com/kb/3011135).
>-  Also, the server that hosts WAP must have a SSL certificate that matches the name being published to external clients as well as trust the SSL certificate that is used on the NDES server. These certificates enable the WAP server to terminate the SSL connection from clients, and create a new SSL connection to the NDES server.
    For information about certificates for WAP, see the **Plan certificates** section of [Planning to Publish Applications Using Web Application Proxy](https://technet.microsoft.com/library/dn383650.aspx). For general information about WAP servers, see [Working with Web Application Proxy](http://technet.microsoft.com/library/dn584113.aspx).|

### Network requirements

From the Internet to perimeter network, allow port 443 from all hosts/IP addressess on the internet to the NDES server.

From the perimeter network to trusted network, allow all ports and protocols needed for domain access on the domain-joined NDES server. The NDES server needs access to the certificate servers, DNS servers, Configuration Manager servers and domain controllers.

We recommend publishing the NDES server through a proxy, such as the [Azure AD application proxy](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-publish/), [Web Access Proxy](https://technet.microsoft.com/en-us/library/dn584107.aspx), or a third-party proxy.


### <a name="BKMK_CertsAndTemplates"></a>Certificates and Templates

|Object|Details|
|----------|-----------|
|**Certificate Template**|You configure this template on your issuing CA.|
|**Client authentication certificate**|Requested from your issuing CA or public CA, you install this certificate on the NDES Server.|
|**Server authentication certificate**|Requested from your issuing CA or public CA, you install and bind this SSL certificate in IIS on the NDES server.|
|**Trusted Root CA certificate**|You export this as a **.cer** file from the root CA or any device which trusts the root CA, and deploy it to devices by using the Trusted CA certificate profile.<br /><br />You use a single Trusted Root CA certificate per operating system platform, and associate it with each Trusted Root Certificate profile you create.<br /><br />You can use additional Trusted Root CA certificates when needed. For example, you might do this to provide a trust to a CA that signs the server authentication certificates for your Wi-Fi access points.|

### <a name="BKMK_Accounts"></a>Accounts

|Name|Details|
|--------|-----------|
|**NDES service account**|You specify a domain user account to use as the NDES Service account.|

## <a name="BKMK_ConfigureInfrastructure"></a>Configure your infrastructure
Before you can configure certificate profiles you must complete the following tasks, which require knowledge of Windows Server 2012 R2 and Active Directory Certificate Services (ADCS):

**Task 1**: Create an NDES service account

**Task 2**: Configure certificate templates on the certification authority

**Task 3**: Configure prerequisites on the NDES server

**Task 4**: Configure NDES for use with Intune

**Task 5**: Enable, install, and configure the Intune Certificate Connector

### Task 1 - Create an NDES service account

Create a domain user account to use as the NDES service account. You will specify this account when you configure templates on the issuing CA before you install and configure NDES. Make sure the user has the default rights, **Logon Localy**, **Logon as a Service** and **Logon as a batch job** rights. Some organizations have hardening policies that disable those rights.




### Task 2 - Configure certificate templates on the certification authority
In this task you will:

-   Configure a certificate template for NDES

-   Publish the certificate template for NDES

##### To configure the certification authority

1.  Log on as an enterprise administrator. 

2.  On the issuing CA, use the Certificate Templates snap-in to create a new custom template or copy an existing template and then edit an existing template (like the User template), for use with NDES.

    The template must have the following configurations:

    -   Specify a friendly **Template display name** for the template.

    -   On the **Subject Name** tab, select **Supply in the request**. (Security is enforced by the Intune policy module for NDES).

    -   On the **Extensions** tab, ensure the **Description of Application Policies** includes **Client Authentication**.

        > [!IMPORTANT]
        > For iOS and Mac OS X certificate templates, on the **Extensions** tab, edit **Key Usage** and ensure **Signature is proof of origin** is not selected.

    -   On the **Security** tab, add the NDES service account, and give it **Enroll** permissions to the template. Intune admins who will create SCEP profiles require **Read** rights so that they can browse to the template when creating SCEP profiles.
    
    > [!NOTE]
    > To revoke certificates the NDES service account needs *Issue and Manage Certificates* rights for each certificate template used by a certificate profile.

3.  Review the **Validity period** on the **General** tab of the template. By default, Intune uses the value configured in the template. However, you have the option to configure the CA to allow the requester to specify a different value, which you can then set from within the Intune Administrator console. If you want to always use the value in the template, skip the remainder of this step.

    > [!IMPORTANT]
    > The iOS and Mac OS X platforms always uses the value set in the template regardless of other configurations you make.

Here are screenshots of an example template configuration.

![Template, request handling tab](..\media\scep_ndes_request_handling.png) 

![Template, subject name tab](..\media\scep_ndes_subject_name.jpg) 

![Template, security tab](..\media\scep_ndes_security.jpg) 

![Template, extensions tab](..\media\scep_ndes_extensions.jpg) 

![Template, issuance requirements tab](..\media\scep_ndes_issuance_reqs.jpg) 

>   [!IMPORTANT]
    > For Application Policies (in the 4th screenshot), only add the application policies required. Confirm your choices with your security admins.
   


To configure the CA to allow the requester to specify the validity period, on the CA run the following commands:

   1.  **certutil -setreg Policy\EditFlags +EDITF_ATTRIBUTEENDDATE**
   2.  **net stop certsvc**

   3.  **net start certsvc**

4.  On the issuing CA, use the Certification Authority snap-in to publish the certificate template.

    1.  Select the **Certificate Templates** node, click **Action**-&gt; **New** &gt; **Certificate Template to Issue**, and then select the template you created in step 2.

    2.  Validate that the template published by viewing it under the **Certificate Templates** folder.


### Task 3 - Configure prerequisites on the NDES server
In this task you will:

-   Add NDES to a Windows Server and configure IIS to support NDES

-   Add the NDES Service account to the IIS_IUSR group

-   Set the SPN for the NDES Service account




   1.  On the server that will hosts NDES, you must log on as a an **Enterprise Administrator**, and then use the [Add Roles and Features Wizard](https://technet.microsoft.com/library/hh831809.aspx) to install NDES:

    1.  In the Wizard, select **Active Directory Certificate Services** to gain access to the AD CS Role Services. Select the **Network Device Enrollment Service**, uncheck **Certification Authority**, and then complete the wizard.

        > [!TIP]
        > On the **Installation progress** page of the wizard, do not click **Close**. Instead, click the link for **Configure Active Directory Certificate Services on the destination server**. This opens the **AD CS Configuration** wizard that you use for the next task. After AD CS Configuration opens, you can close the Add Roles and Features wizard.

    2.  When NDES is added to the server, the wizard also installs IIS. Ensure IIS has the following configurations:

        -   **Web Server** &gt; **Security** &gt; **Request Filtering**

        -   **Web Server** &gt; **Application Development** &gt; **ASP.NET 3.5**. Installing ASP.NET 3.5 will install .NET Framework 3.5. When installing .NET Framework 3.5, install both the core **.NET Framework 3.5** feature and **HTTP Activation**.

        -   **Web Server** &gt; **Application Development** &gt; **ASP.NET 4.5**. Installing ASP.NET 4.5 will install .NET Framework 4.5. When installing .NET Framework 4.5, install the core **.NET Framework 4.5** feature, **ASP.NET 4.5**, and the **WCF Services** &gt; **HTTP Activation** feature.

        -   **Management Tools** &gt; **IIS 6 Management Compatibility** &gt; **IIS 6 Metabase Compatibility**

        -   **Management Tools** &gt; **IIS 6 Management Compatibility** &gt; **IIS 6 WMI Compatibility**

  2.  On the server, add the NDES service account as a member of the **IIS_IUSR** group.

   3.  In an elevated command prompt, run the following command to set the SPN of the NDES Service account:

`**setspn -s http/&lt;DNS name of NDES Server&gt; &lt;Domain name&gt;\&lt;NDES Service account name&gt;**`

   For example, if your NDES Server is named **Server01**, your domain is **Contoso.com**, and the service account is **NDESService**, use:

`**setspn –s http/Server01.contoso.com contoso\NDESService**`

### Task 4 - Configure NDES for use with Intune
In this task you will:

-   Configure NDES for use with the issuing CA

-   Bind the server authentication (SSL) certificate in IIS

-   Configure Request Filtering in IIS

##### To configure NDES for use with Intune

1.  On the NDES Server, open the AD CS Configuration wizard and then make the following configurations.

    > [!TIP]
    > If you clicked the link in the previous task, this wizard is already open. Otherwise, open Server Manager to access the post-deployment configuration for Active Directory Certificate Services.

    -   On the **Role Services** Page, select the **Network Device Enrollment Service**.

    -   On the **Service Account for NDES** page, specify the NDES Service Account.

    -   On the **CA for NDES** page, click **Select**, and then select the issuing CA where you configured the certificate template.

    -   On the **Cryptography for NDES** page, set the key length to meet your company requirements.

    On the **Confirmation** page, click **Configure** to complete the wizard.

2.  After the wizard completes, edit the following registry key on the NDES Server:

    -   **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MSCEP\**

    To edit this key, identify the certificate template's **Purpose**, as found on its **Request Handling** tab, and then edit the corresponding entry in the registry by replacing the existing data with the name of the certificate template (not the display name of the template) that you specified in Task 1. The following table maps the certificate template purpose to the values in the registry:

    |Certificate template Purpose (On the Request Handling tab)|Registry value to edit|Value seen in the Intune admin console for the SCEP profile|
    |--------------------------------------------------------------|--------------------------|------------------------------------------------------------------------------------------------------------|
    |Signature|SignatureTemplate|Digital Signature|
    |Encryption|EncryptionTemplate|Key Encipherment|
    |Signature and encryption|GeneralPurposeTemplate|Key Encipherment<br /><br />Digital Signature|
    For example, if the Purpose of your certificate template is **Encryption**, then edit the **EncryptionTemplate** value to be the name of your certificate template.

3. The NDES server will receive very long URL’s (queries), which require that you add two registry entries:

    |Location|Value|Type|Data|
    |-------|-----|----|----|
    |HKLM\SYSTEM\CurrentControlSet\Services\HTTP\Parameters|MaxFieldLength|DWORD|65534 (decimal)|
    |HKLM\SYSTEM\CurrentControlSet\Services\HTTP\Parameters|MaxRequestBytes|DWORD|65534 (decimal)|


4. In IIS manager, choose **Default Web Site** -> **Request Filtering** -> **Edit Feature Setting**, and change the **Maximum URL length** and **Maximum query string** to *65534*, as shown.

    ![IIS max URL and query length](..\media\SCEP_IIS_max_URL.png) 

5.  Restart the server. Running **iisreset** on the server will not be sufficient to finalize these changes.
6. Browse to http://*FQDN*/certsrv/mscep/mscep.dll. You should see an NDES page similar to this:

    ![Test NDES](..\media\SCEP_NDES_URL.png) 

    If you get a **503 Service unavailable**, check the eventviewer. It's likely that the application pool is stopped due to a missing right for the NDES user. Those rights are described in Task 1.

##### To Install and bind certificates on the NDES Server

1.  On your NDES Server, request and install a **server authentication** certificate from your internal CA or public CA. You will then bind this SSL certificate in IIS.

    > [!TIP]
    > After you bind the SSL certificate in IIS, you will also install a client authentication certificate. This certificate can be issued by any CA that is trusted by the NDES Server. Although it is not a best practice, you can use the same certificate for both server and client authentication as long as the certificate has both Enhance Key Usages (EKU’s). Review the following steps for information about these authentication certificates.

    1.  After you obtain the server authentication certificate, open **IIS Manager**, select the **Default Web Site** in the **Connections** pane, and then click **Bindings** in the **Actions** pane.

    2.  Click **Add**, set **Type** to **https**, and then ensure the port is **443**. (Only port 443 is supported for standalone Intune.

    3.  For **SSL certificate**, specify the server authentication certificate.

        > [!NOTE]
        > If the NDES server uses both an external and internal name for a single network address, the server authentication certificate must have a **Subject Name** with an external public server name, and a **Subject Alternative Name** that includes the internal server name.

2.  On your NDES Server, request and install a **client authentication** certificate from your internal CA, or a public certificate authority. This can be the same certificate as the server authentication certificate if that certificate has both capabilities.

    The client authentication certificate must have the following properties:

    **Enhanced Key Usage** - This must include **Client Authentication**.

    **Subject Name** - This must be equal to the DNS name of the server where you are installing the certificate (the NDES Server).

##### To configure IIS Request Filtering

1.  On the NDES Server open **IIS Manager**, select the **Default Web Site** in the **Connections** pane, and then open **Request Filtering**.

2.  Click **Edit Feature Settings**, and then set the following:

    **query string (Bytes)** = **65534**

    **Maximum URL length (Bytes)** = **65534**

3.  Review the following registry key:

    **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HTTP\Parameters**

    Ensure the following values are set as DWORD entries:

    Name: **MaxFieldLength**, with a decimal value of **65534**

    Name: **MaxRequestBytes**, with a decimal value of **65534**

4.  Reboot the NDES server. The server is now ready to support the Certificate Connector.

### Task 5 - Enable, install, and configure the Intune Certificate Connector
In this task you will:

Enable support for NDES in Intune.

Download, install, and configure the Certificate Connector on the NDES Server.

##### To enable support for the Certificate Connector

1.  Open the [Intune administration console](https://manage.microsoft.com), click **Admin** &gt; **Certificate Connector**.

2.  Click **Configure On-Premises Certificate Connector**.

3.  Select **Enable Certificate Connector**, and then click **OK**.

##### To download, install and configure the Certificate Connector

1.  Open the [Intune administration console](https://manage.microsoft.com), and then click **Admin** &gt; **Mobile Device Management** &gt; **Certificate Connector** &gt; **Download Certificate Connector**.

2.  After the download completes, run the downloaded installer (**ndesconnectorssetup.exe**) on a Windows Server 2012 R2 server. The installer also installs the policy module for NDES and the CRP Web Service. (The CRP Web Service, CertificateRegistrationSvc, runs as an application in IIS.)

    > [!NOTE]
    > When you install NDES for standalone Intune, the CRP service automatically installs with the Certificate Connector. When you use Intune with Configuration Manager, you install the Certificate Registration Point as a separate site system role.

3.  When prompted for the client certificate for the Certificate Connector, click **Select**, and select the **client authentication** certificate you installed on your NDES Server in Task 3.

    After you select the client authentication certificate, you are returned to the **Client Certificate for Microsoft Intune Certificate Connector** surface. Although the certificate you selected is not shown, click **Next** to view the properties of that certificate. Then click **Next**, and then click **Install**.

4.  After the wizard completes, but before closing the wizard, click **Launch the Certificate Connector UI**.

    > [!TIP]
    > If you close the wizard before launching the Certificate Connector UI, you can reopen it by running the following command:
    >
    > **&lt;install_Path&gt;\NDESConnectorUI\NDESConnectorUI.exe**

5.  In the **Certificate Connector** UI:

    Click **Sign In** and enter your Intune service administrator credentials, or credentials for a tenant administrator with the global administration permission.

    If your organization uses a proxy server and the proxy is needed for the NDES server to access the Internet, click **Use proxy server** and then provide the proxy server name, port, and account credentials to connect.

    Select the **Advanced** tab, and then provide credentials for an account that has the **Issue and Manage Certificates** permission on your issuing Certificate Authority, and then click **Apply**.

    You can now close the Certificate Connector UI.

6.  Open a command prompt and type **services.msc**, and then press **Enter**, right-click the **Intune Connector Service**, and then click **Restart**.

To validate that the service is running, open a browser and enter the following URL, which should return a **403** error:

**http:// &lt;FQDN_of_your_NDES_server&gt;/certsrv/mscep/mscep.dll**

## Next steps
You are now ready to configure certificate profiles, as described in [Configure certificate profiles](Configure-Intune-certificate-profiles.md).
