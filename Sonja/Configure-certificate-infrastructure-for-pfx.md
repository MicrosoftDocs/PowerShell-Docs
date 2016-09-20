---
title: Configure certificate infrastructure for PFX | Microsoft Intune
description: Create and deploy .PFX certificate profiles.
keywords:
author: nbigman
manager: angrobe
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 2c543a02-44a5-4964-8000-a45e3bf2cc69

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: vinaybha
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:


---
# Configure certificate infrastructure
This topic describes what you need in order to create and deploy .PFX certificate profiles.

To do any certificate-based authentication in your organization, you need an Enterprise Certification Authority.

To use .PFX Certificate profiles, in addition to the Enterprise Certification Authority, you  also need:

-   A computer that can communicate with the Certification Authority, or you can use the Certification Authority computer itself.

-  The Intune Certificate Connector, which runs on the computer that can communicate with the Certification Authority.

## On-premises infrastructure description


-    **Active Directory domain**: All servers listed in this section (except for the Web Application Proxy Server) must be joined to your Active Directory domain.

-  **Certification Authority**: An Enterprise Certification Authority (CA) that runs on an Enterprise edition of Windows Server 2008 R2 or later. A Standalone CA is not supported. For instructions on how to set up a Certification Authority, see [Install the Certification Authority](http://technet.microsoft.com/library/jj125375.aspx).
    If your CA runs Windows Server 2008 R2, you must [install the hotfix from KB2483564](http://support.microsoft.com/kb/2483564/).

-  **Computer that can communicate with Certification Authority**: Alternatively, use the Certification Authority computer itself.
-  **Microsoft Intune Certificate Connector**: You use the Intune admin console to download the **Certificate Connector** installer (**ndesconnectorssetup.exe**). Then you can run **ndesconnectorssetup.exe** on the computer where you want to install the Certificate Connector. For .PFX Certificate profiles, install the Certificate Connector on the computer that communicates with the Certification Authority.
-  **Web Application Proxy server** (optional): You can use a server that runs Windows Server 2012 R2 or later as a Web Application Proxy (WAP) server. This configuration:
    -  Allows devices to receive certificates using an Internet connection.
    -  Is a security recommendation when devices connect through the Internet to receive and renew certificates.

 > [!NOTE]           
> -    The server that hosts WAP [must install an update](http://blogs.technet.com/b/ems/archive/2014/12/11/hotfix-large-uri-request-in-web-application-proxy-on-windows-server-2012-r2.aspx) that enables support for the long URLs that are used by the Network Device Enrollment Service (NDES). This update is included with the [December 2014 update rollup](http://support.microsoft.com/kb/3013769), or individually from [KB3011135](http://support.microsoft.com/kb/3011135).
>-  Also, the server that hosts WAP must have an SSL certificate that matches the name being published to external clients as well as trust the SSL certificate that is used on the NDES server. These certificates enable the WAP server to terminate the SSL connection from clients, and create a new SSL connection to the NDES server.
    For information about certificates for WAP, see the **Plan certificates** section of [Planning to Publish Applications Using Web Application Proxy](https://technet.microsoft.com/library/dn383650.aspx). For general information about WAP servers, see [Working with Web Application Proxy](http://technet.microsoft.com/library/dn584113.aspx).|


### Certificates and Templates

|Object|Details|
|----------|-----------|
|**Certificate Template**|You configure this template on your issuing CA.|
|**Trusted Root CA certificate**|You export this as a **.cer** file from the issuing CA or any device which trusts the issuing CA, and deploy it to devices by using the Trusted CA certificate profile.<br /><br />You use a single Trusted Root CA certificate per operating system platform, and associate it with each Trusted Root Certificate profile you create.<br /><br />You can use additional Trusted Root CA certificates when needed. For example, you might do this to provide a trust to a CA that signs the server authentication certificates for your Wi-Fi access points.|


## Configure your infrastructure
Before you can configure certificate profiles, you must complete the following tasks. These tasks require knowledge of Windows Server 2012 R2 and Active Directory Certificate Services (ADCS):

- **Task 1** - Configure certificate templates on the certification authority.
- **Task 2** - Enable, install, and configure the Intune Certificate Connector.

### Task 1 - Configure certificate templates on the certification authority
In this task, you will publish the certificate template.

##### To configure the certification authority

1.  On the issuing CA, use the Certificate Templates snap-in to create a new custom template, or copy and edit an existing template (like the User template), for use with .PFX.

    The template must include the following:

    -   Specify a friendly **Template display name** for the template.

    -   On the **Subject Name** tab, select **Supply in the request**. (Security is enforced by the Intune policy module for NDES).

    -   On the **Extensions** tab, ensure the **Description of Application Policies** includes **Client Authentication**.

        > [!IMPORTANT]
        > For iOS and Mac OS X certificate templates, on the **Extensions** tab, edit **Key Usage** and ensure that **Signature is proof of origin** is not selected.

2.  Review the **Validity period** on the **General** tab of the template. By default, Intune uses the value configured in the template. However, you have the option to configure the CA to allow the requester to specify a different value, which you can then set from within the Intune Administrator console. If you want to always use the value in the template, skip the remainder of this step.

    > [!IMPORTANT]
    > The iOS and Mac OS X platforms always uses the value set in the template, regardless of other configurations you make.

    To configure the CA to allow the requester to specify the validity period, run the following commands on the CA:

    a.  **certutil -setreg Policy\EditFlags +EDITF_ATTRIBUTEENDDATE**

    b.  **net stop certsvc**

    c.  **net start certsvc**

3.  On the issuing CA, use the Certification Authority snap-in to publish the certificate template.

    a.  Select the **Certificate Templates** node, click **Action**-&gt; **New** &gt; **Certificate Template to Issue**, and then select the template you created in step 2.

    b.  Validate that the template published by viewing it under the **Certificate Templates** folder.

4.  On the CA computer, ensure that the computer that hosts the Intune Certificate Connector has enroll permission, so that it can access the template used in creating the .PFX profile. Set that permission on the **Security** tab of the CA computer properties.

### Task 2 - Enable, install, and configure the Intune Certificate Connector
In this task you will:

Download, install, and configure the Certificate Connector.

##### To enable support for the Certificate Connector

1.  Open the [Intune administration console](https://manage.microsoft.com), and choose **Admin** &gt; **Certificate Connector**.

2.  Choose **Configure On-Premises Certificate Connector**.

3.  Select **Enable Certificate Connector**, and then choose **OK**.

##### To download, install, and configure the Certificate Connector

1.  Open the [Intune administration console](https://manage.microsoft.com), and then choose **Admin** &gt; **Mobile Device Management** &gt; **Certificate Connector** &gt; **Download Certificate Connector**.

2.  After the download completes, run the downloaded installer (**ndesconnectorssetup.exe**).

  Run the installer on the computer that is able to connect with the Certification Authority. Choose the .PFX Distribution option, and then choose **Install**. When the installation has completed, continue by creating a certificate profile as described in [Configure certificate profiles](configure-intune-certificate-profiles.md).

   <!-- Not sure about step 3 below -->

3.  When prompted for the client certificate for the Certificate Connector, choose **Select**, and select the **client authentication** certificate you installed in Task 3.

    After you select the client authentication certificate, you are returned to the **Client Certificate for Microsoft Intune Certificate Connector** surface. Although the certificate you selected is not shown, choose **Next** to view the properties of that certificate. Then choose **Next**, and then **Install**.

4.  After the wizard completes, but before closing the wizard, click **Launch the Certificate Connector UI**.

    > [!TIP]
    > If you close the wizard before launching the Certificate Connector UI, you can reopen it by running the following command:
    >
    > **&lt;install_Path&gt;\NDESConnectorUI\NDESConnectorUI.exe**

5.  In the **Certificate Connector** UI:

    a. Choose **Sign In** and enter your Intune service administrator credentials, or credentials for a tenant administrator with the global administration permission.

  <!--  If your organization uses a proxy server and the proxy is needed for the NDES server to access the Internet, click **Use proxy server** and then provide the proxy server name, port, and account credentials to connect.-->

    b. Select the **Advanced** tab, and then provide credentials for an account that has the **Issue and Manage Certificates** permission on your issuing Certificate Authority.

    c. Choose **Apply**.

    You can now close the Certificate Connector UI.

6.  Open a command prompt and type **services.msc**. Then press **Enter**, right-click the **Intune Connector Service**, and choose **Restart**.

To validate that the service is running, open a browser and enter the following URL, which should return a **403** error:

**http:// &lt;FQDN_of_your_NDES_server&gt;/certsrv/mscep/mscep.dll**

### Next steps
You are now ready to set up certificate profiles, as described in [Configure certificate profiles](Configure-Intune-certificate-profiles.md).
