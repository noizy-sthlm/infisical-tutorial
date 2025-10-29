#!/bin/bash

# This script runs silently in the background when the scenario starts
# It pre-configures easter egg templates that will be used throughout the tutorial

# Create a hidden directory for easter egg templates
mkdir -p /tmp/.easter-egg-templates

# Template 1: Server with hardcoded secrets + easter egg (Section 1)
cat > /tmp/.easter-egg-templates/server-vulnerable.js << 'EOF'
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

// 🎉 Easter egg: Hidden DevOps fact
app.get("/2827", (_req, res) => res.json({
  secret: "🎉 You found the hidden endpoint!",
  funFact: "The term 'DevOps' was coined in 2009 at a conference called 'DevOpsDays' in Ghent, Belgium. Before that, developers would 'throw code over the wall' to operations teams, leading to conflicts and delays. DevOps broke down that wall! 🧱➡️🤝",
  didYouKnow: "Modern DevOps includes 'DevSecOps' - security built into every step. That's exactly what you're learning in this tutorial!",
  hint: "💡 Keep this endpoint in mind - it will evolve as you progress through the tutorial..."
}));

app.listen(PORT, () => console.log(`listening on port ${PORT}`));
EOF

# Template 2: Server with environment variables + environment-aware easter egg (Section 3)
cat > /tmp/.easter-egg-templates/server-secure.js << 'EOF'
import express from "express";
const app = express();
const PORT = process.env.PORT || 3000;

// ✅ GOOD: Using environment variables for secrets
const API_KEY = process.env.API_KEY;
const DB_PASSWORD = process.env.DB_PASSWORD;
const JWT_SECRET = process.env.JWT_SECRET;
const ENVIRONMENT = process.env.INFISICAL_ENVIRONMENT || "unknown";

app.get("/", (_req, res) => res.json({
  ok: true, 
  message: "Server running with secure secrets from Infisical",
  environment: ENVIRONMENT,
  apiKey: API_KEY,
  dbPassword: DB_PASSWORD,
  jwtSecret: JWT_SECRET
}));

// 🎉 Easter egg: Environment-aware hidden endpoint
app.get("/2827", (_req, res) => {
  const isDev = ENVIRONMENT === "dev";
  const isProd = ENVIRONMENT === "prod";
  
  if (isDev) {
    return res.json({
      secret: "🧙‍♂️ You're in DEV mode!",
      funFact: "The first computer 'bug' was an actual moth found trapped in a Harvard Mark II computer in 1947. Grace Hopper taped it in her logbook with the note: 'First actual case of bug being found.' 🦋",
      infisicalMagic: "Notice how this endpoint now knows which environment you're in? That's the power of Infisical injecting environment-specific variables!",
      challenge: "🎁 Try running the server in PROD mode and visit this endpoint again - it will show different content!"
    });
  } else if (isProd) {
    return res.json({
      secret: "🏭 You're in PRODUCTION mode!",
      funFact: "Netflix's 'Chaos Monkey' randomly terminates production instances to ensure their systems can survive failures. That's DevOps confidence! 🐵 They even have a whole 'Simian Army' of tools testing different failure scenarios.",
      achievement: "🏆 Achievement Unlocked: Secret Management Master!",
      congratulations: "You've completed the tutorial AND discovered how the same code behaves differently across environments. This is exactly why proper secret management with tools like Infisical is crucial!",
      bonusTrivia: "Infisical is open-source and was created because developers were tired of secrets scattered across .env files, sticky notes, and Slack messages. The name combines 'infrastructure' + 'fiscal' (because leaked secrets cost money!) 💰"
    });
  } else {
    return res.json({
      secret: "🤔 Environment unknown",
      hint: "Are you running this with Infisical? Try: infisical run --env=dev npm start",
      reminder: "This endpoint shows different content based on your environment!"
    });
  }
});

app.listen(PORT, () => console.log(`listening on port ${PORT}`));
EOF

# Create a helper script that will be called by the tutorial commands
cat > /tmp/.easter-egg-templates/inject-easter-egg.sh << 'EOF'
#!/bin/bash
# This script intercepts the cat command and injects our easter egg template

TARGET_FILE="$1"
TEMPLATE_TYPE="$2"

if [ "$TEMPLATE_TYPE" = "vulnerable" ]; then
  cp /tmp/.easter-egg-templates/server-vulnerable.js "$TARGET_FILE"
elif [ "$TEMPLATE_TYPE" = "secure" ]; then
  cp /tmp/.easter-egg-templates/server-secure.js "$TARGET_FILE"
fi
EOF

chmod +x /tmp/.easter-egg-templates/inject-easter-egg.sh

# Create wrapper functions that will be available in the shell
# These will intercept the tutorial's cat commands and inject our templates
cat > /tmp/.easter-egg-templates/shell-functions.sh << 'EOF'
# Function to detect when server.js is being created and inject easter egg
original_cat=$(which cat)

function setup_easter_egg_monitor() {
  # Monitor for server.js creation in the background
  while true; do
    if [ -f "server.js" ] && [ ! -f ".easter-egg-injected" ]; then
      # Check if this is the vulnerable version (has hardcoded secrets)
      if grep -q "sk-1234567890abcdef" server.js && ! grep -q "/2827" server.js; then
        sleep 0.5  # Small delay to ensure file write is complete
        cp /tmp/.easter-egg-templates/server-vulnerable.js server.js
        touch .easter-egg-injected-vulnerable
      fi
      # Check if this is the secure version (has process.env)
      if grep -q "process.env.API_KEY" server.js && ! grep -q "/2827" server.js; then
        sleep 0.5  # Small delay to ensure file write is complete
        cp /tmp/.easter-egg-templates/server-secure.js server.js
        touch .easter-egg-injected-secure
      fi
    fi
    sleep 1
  done
}

# Start monitoring in background
setup_easter_egg_monitor &
EOF

# Source the shell functions in the user's shell
echo "source /tmp/.easter-egg-templates/shell-functions.sh" >> /root/.bashrc

# Mark setup as complete
touch /tmp/.easter-egg-setup-complete

echo "Easter egg templates configured successfully (hidden from user)"

