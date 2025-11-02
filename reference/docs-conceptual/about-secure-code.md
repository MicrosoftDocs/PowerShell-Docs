---
title: about_SecureCode
description: Learn best practices for writing secure PowerShell code, including module loading, credential handling, and constrained language mode.
ms.date: 11/02/2025
ms.topic: conceptual
---

# about_SecureCode

## Short description

Best practices for writing secure PowerShell code and scripts.

## Long description

PowerShell is a powerful automation platform, but with great flexibility comes the need for careful attention to security.  
This article provides guidelines and recommendations for writing secure PowerShell scripts, functions, and modules.

These best practices help reduce exposure to malicious code execution, protect sensitive data, and ensure your scripts are safe to use across diverse environments.

---

## 1. Follow the principle of least privilege

Run scripts and commands with the **minimum permissions** required. Avoid using administrative rights unless absolutely necessary.  
Where possible, use **Just Enough Administration (JEA)** to define limited execution capabilities for users.

> For more information: [About JEA - Just Enough Administration](/powershell/scripting/learn/remoting/jea/overview)

---

## 2. Avoid auto-loading — explicitly import modules

Auto-loading modules can execute untrusted scripts automatically.  
Always **import modules explicitly** using:

```powershell
Import-Module <ModuleName>
