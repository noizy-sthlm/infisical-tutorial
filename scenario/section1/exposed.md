# Unprotected Secrets


## Our Scenario project
For our scenario, lets create a small Node project that we host on GitHub repository.

```bash
git config --global user.email "your@email.com"
git config --global user.name "Name"
```

Create an empty repo on Github and clone it. This is where you will host your Node application

```bash
git clone https://github.com/<>/<repo>.git
cd <repo>
```

Create a dummy app
```bash
npm init -y
npm pkg set type="module"
npm install express
```

in server.js
```
import express from "express";
const app = express();
const PORT = process.env.PORT || 3000;
const OUR_SECRET = process.env.SECRET || "No_Secret";
apt.get("/", (_req, res) => res.json({ok: true, secret: OUR_SECRET}));
app.listen(PORT, () => console.log(`listening on port ${PORT}`));
```

in .env
```bash
OUR_SECRET="super secret secret"
```

Push the secret
git add .
git commit -m "delibirate secrets leak"
git push origin main

## Secrets Scanning
GitHub action

We will start by creating a delibirate leak and see how to detect it with Secrets Scanning.