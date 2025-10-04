#!/bin/bash

# install nodejs
# https://deb.nodesource.com/
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs

# install npm
apt install npm -y

# Add GitHub CLI source
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt update

clear