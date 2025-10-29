# Manage Secrets with Infisical

#### Authored by: [Fauzan Helmi Sudaryanto](https://github.com/ujanjan) & [Amin Nouiser](https://github.com/noizy-sthlm) 

In this tutorial, you will learn why and how [secrets](https://en.wikipedia.org/wiki/Key_(cryptography)) can be protected with [Infisical](https://infisical.com/). Hardcoded secrets in source code are one of the most common security vulnerabilities in DevOps, often leading to data breaches and compromised systems.

## 🚨 Why This Matters for DevOps

DevOps is all about speed and automation. But without proper secret management, this becomes a security risk. Secrets are everywhere in the DevOps loop:

<img src="./devops-loop.png" style="width: 350px">

- **Build**: API keys and database credentials in your code
- **Test**: Secrets needed for automated testing
- **Deploy**: CI/CD pipelines need credentials to push to production
- **Operate**: Services communicate using tokens and keys

**The problem** One exposed secret can compromise your entire pipeline.

### Real Examples

- **[Hugging Face (2024)](https://huggingface.co/blog/space-secrets-disclosure)**: Attackers accessed their Spaces platform and stole API tokens, forcing a mass revocation of user credentials.
- **[Snowflake (2024)](https://cloudsecurityalliance.org/blog/2025/05/07/unpacking-the-2024-snowflake-data-breach)**: Stolen credentials compromised **160+ organizations** including Ticketmaster and Santander.
- **[AWS Credential Leak (2024)](https://www.techradar.com/pro/security/aws-customers-hit-by-major-cyberattack-which-then-stored-stolen-credentials-in-plain-sight)**: Misconfigured cloud instances exposed credentials and source code that attackers stored in plain sight.

Over **10 million secrets leak on GitHub every year**. Bots find and exploit them in **under 4 minutes**.

### What You'll Learn

This tutorial covers secret management across the DevOps lifecycle:

- **Build**: Detect hardcoded secrets before they're committed
- **Test**: Set up automated scanning in CI/CD
- **Deploy**: Inject secrets securely at runtime
- **Operate**: Manage different secrets for dev, staging, and production



## 🎓 Learning Outcomes

By the end of this tutorial, you will be able to:

1. **Identify** security risks of hardcoded secrets in source code
2. **Scan** for exposed secrets using automated tools in local and CI/CD workflows
3. **Prevent** secret leaks with pre-commit hooks and GitHub Actions
4. **Store** secrets securely using centralized secret management
5. **Manage** environment-specific secrets (dev, staging, production)

## Prerequisites

You'll need free accounts for [GitHub](https://github.com) and [Infisical](https://infisical.com). We'll guide you through the setup.

Let's start!

---

_This tutorial is made for [DD2482 DevOps course](https://github.com/KTH/devops-course/pull/2827)._
