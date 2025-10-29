# Unprotected Secrets

## Our Scenario Project
For our scenario, let's create a small Node project that demonstrates a common security mistake: hardcoded secrets in source code. This is something that happens in real development scenarios and can lead to serious security vulnerabilities.

## Why This Happens

Hardcoded secrets are the #1 cause of credential leaks. Here's the typical path:

1. Developer adds a secret for "quick testing"
2. Forgets to remove it before committing
3. Pushes to GitHub 
4. Automated bots scan public repos 24/7
5. Attackers find and use credentials within hours

**The DevOps connection**: Rapid deployment cycles mean less time for security reviews. One shortcut can expose your entire infrastructure.

Let's see how easy it is to make this mistake...

## Quick Setup with GitHub CLI

We will create a new repository on GitHub for the tutorial. 

_Note: In this tutorial, we will use GitHub CLI. But you can also use another method that you are more familiar with._

Below is the installation of GitHub CLI that you can follow directly on KillerCoda. Please open this [installation guide](https://github.com/cli/cli#installation) for other OS.

```
# Install GitHub CLI
apt install gh -y
```{{exec}}

```
# Login to GitHub (opens browser for authentication)
gh auth login --web
```{{exec}}

After successful authentication, let's create the repository for the tutorial.

```
# Create and clone repository in one command
gh repo create infisical-tutorial --public --clone
```{{exec}}

Now we will use the new repository for this tutorial. Let's open it.

```
# Open tutorial folder
cd infisical-tutorial
```{{exec}}

## Create the Node.js Application

First, make sure that `npm` is installed.

```
# It will take some time to install
apt install npm -y
```{{exec}}

Now let's create a simple Express.js application that will demonstrate the security vulnerability. 

```
npm init -y
npm pkg set type="module"
npm install express
```{{exec}}

## Add Vulnerable Code

Let's create a **new** server file `server.js` with hardcoded secrets to demonstrate the security issue:

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
  apiKey: API_KEY,
  dbPassword: DB_PASSWORD,
  jwtSecret: JWT_SECRET
}));

app.listen(PORT, () => console.log(`listening on port ${PORT}`));
EOF
```{{exec}}

## Test the Vulnerable Application

Let's run our application to see the hardcoded secrets in action:

```bash
npm start
```{{exec}}

The server should now be running on [(port 3000)]({{TRAFFIC_HOST1_3000}}).

You should see the json object with our secrets.

Ctrl+C in the terminal kills the process.

## Commit the Vulnerable Code

First, let's configure git with our identity (required for commits):

```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```{{exec interrupt}}

Now let's switch to `main` branch:

```bash
git checkout -b main
```{{exec}}

Also, let's include `node_modules` folder in `.gitignore` to have a clean version commit.

```bash
echo "node_modules/" > .gitignore
```{{exec}}

Finally, let's commit this vulnerable code to our repository:

```bash
git add .
git commit -m "deliberate secrets leak"
git push -u origin main
```{{exec}}

## What's Next?

We've successfully created a repository with hardcoded secrets and demonstrated that the application works. In the next section, we'll learn how to detect these secrets using Infisical's scanning capabilities.