# Secure Secrets Management with Infisical

Now that we've learned how to detect secrets, let's implement a proper solution for managing them securely. In this section, we'll replace our hardcoded secrets with Infisical's secure secret management system, allowing us to store secrets safely and access them at runtime.

## Setting Up Infisical Account

### Create Your Infisical Account

First, we need to create a free account with Infisical to access their secret management services:

1. **Visit Infisical**: Go to [infisical.com](https://infisical.com)
2. **Sign Up**: Create a free account to get started
   - We signed up using the **Europe data region**
   - This will give you access to Infisical's cloud-based secret management services

### Create Your First Project

Once you've created your account:

1. **Create a New Project**: 
   - Click "Create Project" or "New Project"
   - Name it `infisical-tutorial` (or any name you prefer)
   - Choose your preferred data region

2. **Set Up Environments**:
   - Create two environments: `dev` and `prod`
   - This allows us to have different secrets for development and production

## Adding Secrets to Infisical

Now let's add the secrets that will replace our hardcoded ones from Section 1.

### Add Development Environment Secrets

In your Infisical project, navigate to the **dev** environment and add these secrets:

```
API_KEY = "sk-1234567890abcdef-DEV"
DB_PASSWORD = "mypassword123-DEV"  
JWT_SECRET = "super-secret-jwt-key-DEV"
```

### Add Production Environment Secrets

Switch to the **prod** environment and add these secrets:

```
API_KEY = "sk-1234567890abcdef-PROD"
DB_PASSWORD = "mypassword123-PROD"
JWT_SECRET = "super-secret-jwt-key-PROD"
```

Now you notice that we have different keys set for different environment.

## Updating Our Application Code

Now let's modify our `server.js` file to use environment variables instead of hardcoded secrets.

### Replace Hardcoded Secrets

Let's update our server code to use environment variables:

```
cat > server.js << 'EOF'
import express from "express";
const app = express();
const PORT = process.env.PORT || 3000;

// ✅ GOOD: Using environment variables for secrets
const API_KEY = process.env.API_KEY;
const DB_PASSWORD = process.env.DB_PASSWORD;
const JWT_SECRET = process.env.JWT_SECRET;

app.get("/", (_req, res) => res.json({
  ok: true, 
  message: "Server running with secure secrets from Infisical",
  apiKey: API_KEY,
  dbPassword: DB_PASSWORD,
  jwtSecret: JWT_SECRET
}));

app.listen(PORT, () => console.log(`listening on port ${PORT}`));
EOF
```{{exec}}


## Setting Up Infisical CLI Integration

### Login to Infisical CLI

First, let's authenticate with Infisical using the CLI:

```
# Login to Infisical (opens browser for authentication)
infisical login
```{{exec}}

### Initialize Infisical in Your Project

Navigate to your project directory and initialize Infisical:

```
# Make sure we're in the tutorial directory, if not:
cd infisical-tutorial
```{{exec}}

```
# Initialize Infisical in the current directory
infisical init
```{{exec}}

This command will:
- Connect your local project to your Infisical project
- Create a `.infisical` configuration file
- Set up the project structure for secret management

## Testing Secure Secret Management

Now let's test our secure setup by running the application with different environments.

### Run with Development Environment

Let's start the application using the development environment secrets:

```
# Run the application with dev environment secrets
infisical run --env=dev npm start
```{{exec}}

You should see the application start and display the development secrets in the response.

### Test the Application

1. **Access the Application**: Use the Traffic Port Accessor (port 3000) as we did in Section 1
2. **Verify Secrets**: You should see a JSON response with the development environment secrets:
   ```json
   {
     "ok": true,
     "message": "Server running with secure secrets from Infisical",
     "apiKey": "sk-1234567890abcdef-DEV",
     "dbPassword": "mypassword123-DEV",
     "jwtSecret": "super-secret-jwt-key-DEV"
   }
   ```

Stop the server with `Ctrl+C` when you're done testing.

### Run with Production Environment

Now let's test with the production environment:

```
# Run the application with prod environment secrets
infisical run --env=prod npm start
```{{exec}}

Access the application again and verify that you now see the production secrets:
   ```json
   {
     "ok": true,
     "message": "Server running with secure secrets from Infisical",
     "apiKey": "sk-1234567890abcdef-PROD",
     "dbPassword": "mypassword123-PROD",
     "jwtSecret": "super-secret-jwt-key-PROD"
   }
   ```

## Committing Secure Code

Now let's commit our secure implementation:

```
# Stop the server if it's still running
# Ctrl+C if needed
```{{exec interrupt}}

```
# Add and commit the secure version
git add server.js
git commit -m "Replace hardcoded secrets with environment variables"
git push origin main
```{{exec}}

you can see that the-pre commit hook didnt trigger.
also, we successfully merged into main.

## Verifying Security Improvements

Let's run a final scan to confirm our secrets are no longer exposed:

```
# Run Infisical scan to verify no secrets are detected
infisical scan --verbose
```{{exec}}

You should see that no secrets are detected in the scan results, confirming that our application is now secure. HOORAY

## What We've Accomplished

We have successfully demonstrated how to:

- **Store secrets securely** in Infisical's cloud-based platform
- **Manage different environments** (dev/prod) with separate secret sets
- **Access secrets at runtime** using Infisical CLI
- **Eliminate hardcoded secrets** from our source code
- **Maintain security** while preserving functionality

---

