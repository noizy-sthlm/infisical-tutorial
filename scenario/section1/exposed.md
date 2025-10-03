# Unprotected Secrets


## Our Scenario Project
For our scenario, let's create a small Node project that demonstrates a common security mistake: hardcoded secrets in source code. This is something that happens in real development scenarios and can lead to serious security vulnerabilities.

## Quick Setup with GitHub CLI

We will create a repository on GitHub for the tutorial using GitHub CLI. _Note: You can also use another method that you are more familiar with._

Below is the installation of GitHub CLI that you can follow directly on KillerCoda using Ubuntu. Please open this [installation guide](https://github.com/cli/cli#installation) for other OS.

```
# Install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
```{{exec}}

```
sudo apt update
sudo apt install gh -y
```{{exec}}

```
# Login to GitHub (opens browser for authentication)
gh auth login --web
```{{exec}}

```
# Create and clone repository in one command
gh repo create infisical-tutorial --public --clone
```{{exec}}

```
# Open tutorial folder
cd infisical-tutorial
```{{exec}}

## Create the Node.js Application

First, make sure that `npm´ is installed. For this Killercoda tutorial, follow below.

```
# It will take some time for the installation
apt install npm
```{{exec}}

Now let's create a simple Express.js application that will demonstrate the security vulnerability. 

```
npm init -y
npm pkg set type="module"
npm install express
```{{exec}}

## Add Vulnerable Code

Let's create a server file ´server.js´ with hardcoded secrets to demonstrate the security issue:

```
cat > server.js << 'EOF'
import express from "express";
const app = express();
const PORT = process.env.PORT || 3000;

// ❌ BAD: Hardcoded secrets in source code
const API_KEY = "sk-1234567890abcdef";
const DB_PASSWORD = "mypassword123";
const JWT_SECRET = "super-secret-jwt-key";

app.get("/", (_req, res) => res.json({
  ok: true, 
  message: "Server running with hardcoded secrets",
  hasApiKey: !!API_KEY,
  hasDbPassword: !!DB_PASSWORD
}));

app.listen(PORT, () => console.log(`listening on port ${PORT}`));
EOF
```{{exec}}

## Commit the Vulnerable Code

Now let's commit this vulnerable code to our repository:

```
git add .
git commit -m "deliberate secrets leak"
git push origin main
```{{exec}}

## What's Next?

We've successfully created a repository with hardcoded secrets. In the next section, we'll learn how to detect these secrets using Infisical's scanning capabilities.