# Infisical Tutorial - Secret Management in DevOps

An interactive [Killercoda](https://killercoda.com/) tutorial that teaches developers how to protect secrets using [Infisical](https://infisical.com/) and prevent one of the most common security vulnerabilities: hardcoded credentials in source code.

**Authors:** [Fauzan Helmi Sudaryanto](https://github.com/ujanjan) & [Amin Nouiser](https://github.com/noizy-sthlm)  
**Course:** [DD2482 DevOps Course at KTH](https://github.com/KTH/devops-course/pull/2827)

---

## 📚 Overview

DevOps is all about speed and automation, but this speed becomes a security risk when secrets aren't managed properly. This hands-on tutorial guides learners through:

1. **Identifying** security risks of hardcoded secrets in source code
2. **Detecting** exposed secrets using automated scanning tools
3. **Preventing** secret leaks with pre-commit hooks and CI/CD integration
4. **Storing** secrets securely using centralized secret management
5. **Managing** environment-specific secrets (dev, staging, production)

**Estimated Duration:** 45-60 minutes

---

## 🎯 Learning Outcomes

By completing this tutorial, learners will be able to:

- Understand what secrets are and why they need protection
- Recognize real-world examples of secret exposure incidents
- Use Infisical CLI for secret scanning and management
- Implement pre-commit hooks to prevent secret leaks
- Configure environment-specific secrets for different deployment stages
- Integrate secret management into CI/CD pipelines

---

## 📖 Tutorial Structure

### Introduction
- Overview of secrets in the DevOps lifecycle
- Real-world breach examples (Hugging Face, Snowflake, AWS)
- Prerequisites and setup instructions

### Section 1: Exposed Secrets
- Creating a vulnerable Node.js server with hardcoded credentials
- Understanding the risks of committing secrets to version control
- Simulating a security breach scenario

### Section 2: Secret Scanning
- Installing and configuring Infisical CLI
- Scanning repositories for exposed secrets
- Setting up pre-commit hooks to prevent future leaks
- Integrating secret scanning into CI/CD workflows

### Section 3: Managed Secrets
- Creating an Infisical project and storing secrets securely
- Configuring environment-specific secrets (development vs. production)
- Refactoring code to use environment variables
- Deploying secure applications with proper secret management

### Finish
- Summary of learned concepts
- Next steps and additional resources

---

## 🛠️ Technical Details

### Platform
- **Environment:** Killercoda interactive terminal
- **Base Image:** Ubuntu
- **Interface:** IDE layout with terminal access

### Prerequisites
Users need free accounts for:
- [GitHub](https://github.com)
- [Infisical](https://infisical.com)

### Files Structure
```
infisical-tutorial/
├── README.md                    # This file
├── EASTER_EGG_SETUP.md         # Easter egg documentation (archived)
├── scenario/
│   ├── index.json              # Killercoda scenario configuration
│   ├── intro.md                # Tutorial introduction
│   ├── foreground.sh           # Setup script (visible to users)
│   ├── background.sh           # Silent background setup + easter egg
│   ├── finish.md               # Completion message
│   ├── devops-loop.png         # DevOps lifecycle diagram
│   ├── section1/
│   │   └── exposed.md          # Section 1: Exposed Secrets
│   ├── section2/
│   │   ├── scanning.md         # Section 2: Secret Scanning
│   │   └── SecretScanning.png  # Scanning workflow diagram
│   └── section3/
│       ├── remedy.md           # Section 3: Managed Secrets
│       ├── CreateProject.png   # Infisical project creation
│       ├── CreateSecret.png    # Secret creation interface
│       ├── AddProductionKey.png # Production environment setup
│       └── SecretSet.png       # Secret configuration view
├── steps.md                    # (Empty - legacy file)
└── test-secret.js              # Test file for demonstrations
```

---

## 🥚 Easter Egg Feature

This tutorial includes a **hidden easter egg** that rewards curious learners who explore beyond the main tutorial path!

### How It Works

The easter egg runs **silently in the background** using Killercoda's `background.sh` script:

1. **Background Script (`background.sh`)**
   - Runs silently when the scenario starts (users don't see it)
   - Creates hidden template files in `/tmp/.easter-egg-templates/`
   - Sets up a monitoring process that watches for `server.js` creation

2. **Automatic Injection**
   - When users create `server.js` following tutorial instructions
   - The background monitor detects the file creation
   - Automatically injects the easter egg endpoint
   - Users discover the hidden `/2827` endpoint naturally (PR number reference!)

3. **Two Versions**

   **Section 1 - Vulnerable Server:**
   - Shows basic DevOps history fun fact
   - Hints that the endpoint will "evolve"

   **Section 3 - Secure Server:**
   - Environment-aware responses (different for dev/prod)
   - Shows different fun facts based on `INFISICAL_ENVIRONMENT`
   - Achievement message in production mode

### User Experience

✅ **What users see:**
- Normal tutorial flow
- Subtle hint about PR number in Section 1
- Hidden endpoint `/2827` with fun facts
- Environment-aware behavior in Section 3

❌ **What users DON'T see:**
- Background script execution
- Template file creation
- File replacement process
- Any setup code

### Benefits

1. **Clean tutorial**: No clutter from easter egg code
2. **Magical discovery**: Endpoint "just works" when users explore
3. **Educational**: Reinforces environment-specific behavior
4. **Rewarding**: Fun facts for curious learners
5. **Non-intrusive**: Doesn't distract from main lesson

### Testing the Easter Egg

To test locally:
```bash
# Run background script
bash scenario/background.sh &

# Create server.js using tutorial commands
# Check if /2827 endpoint exists
curl http://localhost:3000/2827

# Verify it responds differently in dev vs prod
INFISICAL_ENVIRONMENT=dev node server.js &
curl http://localhost:3000/2827

INFISICAL_ENVIRONMENT=prod node server.js &
curl http://localhost:3000/2827
```

### Maintenance

If you need to update the easter egg content:
1. Edit the templates in `scenario/background.sh`
2. Update the corresponding hints in the markdown files
3. Test in Killercoda environment

---

## 🚀 Deployment

This tutorial is designed to run on [Killercoda](https://killercoda.com/). To deploy:

1. Create a Killercoda account
2. Upload the `scenario/` directory contents
3. Configure the scenario using `index.json`
4. Test all sections thoroughly
5. Publish the scenario

---

## 🔗 Resources

- [Infisical Documentation](https://infisical.com/docs/documentation/getting-started/overview)
- [Killercoda Platform](https://killercoda.com/)
- [DD2482 DevOps Course](https://github.com/KTH/devops-course)
- [Original PR #2827](https://github.com/KTH/devops-course/pull/2827)

---

## 📝 License

This tutorial is created for educational purposes as part of the DD2482 DevOps course at KTH Royal Institute of Technology.

---

## 🙏 Acknowledgments

Special thanks to:
- The DD2482 DevOps course instructors and TAs
- [Infisical](https://infisical.com/) for providing excellent secret management tools
- [Killercoda](https://killercoda.com/) for the interactive tutorial platform
- All contributors and reviewers of PR #2827

---

**Happy Learning! 🎓**

_Remember: The best security practice is the one you actually implement. Start protecting your secrets today!_
