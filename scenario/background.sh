#!/bin/bash

# install nodejs
# https://deb.nodesource.com/
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs

# Add GitHub CLI source
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt update

# Install inotify-tools for file monitoring
apt install -y inotify-tools

clear

# ============================================
# EASTER EGG SETUP - Hidden from users
# ============================================

# Create hidden directory for easter egg templates
mkdir -p /tmp/.easter-egg-templates

# Template 1: Section 1 - Vulnerable server with basic easter egg
cat > /tmp/.easter-egg-templates/server-section1.js << 'TEMPLATE_EOF'
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
TEMPLATE_EOF

# Template 2: Section 3 - Secure server with environment-aware easter egg
cat > /tmp/.easter-egg-templates/server-section3.js << 'TEMPLATE_EOF'
import express from "express";
const app = express();
const PORT = process.env.PORT || 3000;

// ✅ GOOD: Using environment variables for secrets
const API_KEY = process.env.API_KEY;
const DB_PASSWORD = process.env.DB_PASSWORD;
const JWT_SECRET = process.env.JWT_SECRET;
const ENVIRONMENT = process.env.NODE_ENV || "unknown";

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
      hint: "Are you running this with Infisical? Try: NODE_ENV=dev infisical run --env=dev npm start",
      reminder: "This endpoint shows different content based on your environment!",
      debug: `Current NODE_ENV: ${ENVIRONMENT}`
    });
  }
});

app.listen(PORT, () => console.log(`listening on port ${PORT}`));
TEMPLATE_EOF

# Background monitoring script
cat > /tmp/.easter-egg-monitor.sh << 'MONITOR_EOF'
#!/bin/bash

# Track which files we've already processed
declare -A processed_files

# Function to inject easter egg into server.js
inject_easter_egg() {
    local server_file="$1"
    
    # Check if we've already processed this file
    if [[ -n "${processed_files[$server_file]}" ]]; then
        return
    fi
    
    # Check if file exists and doesn't already have the easter egg
    if [[ ! -f "$server_file" ]] || grep -q "/2827" "$server_file"; then
        return
    fi
    
    # Wait a moment to ensure file is fully written
    sleep 1
    
    # Create a backup
    cp "$server_file" "${server_file}.bak"
    
    # Determine which easter egg to inject based on file content
    if grep -q "process.env.API_KEY" "$server_file"; then
        # Section 3: Secure version with environment-aware easter egg
        # Use the template file and replace the entire server.js
        cp /tmp/.easter-egg-templates/server-section3.js "$server_file"
    else
        # Section 1: Vulnerable version with basic easter egg
        cp /tmp/.easter-egg-templates/server-section1.js "$server_file"
    fi
    
    # Mark this file as processed
    processed_files[$server_file]=1
    
    echo "Easter egg injected into $server_file"
}

# Initial check for existing server.js files
# Search in /root directory where users create tutorial repos
find /root -maxdepth 3 -name "server.js" -type f 2>/dev/null | while read -r server_file; do
    inject_easter_egg "$server_file"
done

# Monitor for server.js creation/modification using inotifywait
# Use monitor mode (-m) for continuous monitoring instead of one-time events
inotifywait -q -m -e close_write,moved_to,create -r --format '%w%f' /root 2>/dev/null | while read -r server_file; do
    # Normalize path (handle potential double slashes)
    server_file="${server_file//\/\///}"
    # Check if the event is for server.js (detect in any directory)
    if [[ "$server_file" == *"/server.js" ]]; then
        inject_easter_egg "$server_file"
    fi
done &

# Fallback: Periodic checks every 1 second (faster than 3 seconds for better responsiveness)
while true; do
    sleep 1
    find /root -maxdepth 3 -name "server.js" -type f 2>/dev/null | while read -r server_file; do
        inject_easter_egg "$server_file"
    done
done
MONITOR_EOF

chmod +x /tmp/.easter-egg-monitor.sh

# Start the monitoring script in the background
nohup /tmp/.easter-egg-monitor.sh > /tmp/easter-egg-monitor.log 2>&1 &