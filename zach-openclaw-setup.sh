#!/bin/bash

echo "--------------------------------"
echo "OpenClaw VM Setup for Zach"
echo "--------------------------------"

# Ensure SSH folder exists
mkdir -p ~/.ssh

echo ""
echo "Checking for SSH key..."

if [ ! -f ~/.ssh/ztw_ed25519 ]; then
    echo "Creating SSH key..."
    ssh-keygen -t ed25519 -f ~/.ssh/ztw_ed25519 -N ""
else
    echo "SSH key already exists"
fi

echo ""
echo "Configuring SSH connection..."

# Add config if it doesn't exist
if ! grep -q "ZTW-VM-OpenClaw" ~/.ssh/config 2>/dev/null; then
cat <<EOF >> ~/.ssh/config

Host ZTW-VM-OpenClaw
    HostName vm-openclaw-ztw.swordfish-bigeye.ts.net
    User zach
    IdentityFile ~/.ssh/ztw_ed25519

EOF
fi

echo ""
echo "Installing SSH key on server..."
echo "You may be asked for your VM password once."

cat ~/.ssh/ztw_ed25519.pub | ssh zach@vm-openclaw-ztw.swordfish-bigeye.ts.net 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys'

echo ""
echo "Checking for VS Code..."

if ! command -v code &> /dev/null
then
    echo "VS Code CLI not found."
    echo "Open VS Code and run:"
    echo "Command Palette → Shell Command: Install 'code' command in PATH"
else
    echo "Installing VS Code Remote SSH extension..."
    code --install-extension ms-vscode-remote.remote-ssh
fi

echo ""
echo "--------------------------------"
echo "Setup Complete"
echo "--------------------------------"

echo ""
echo "Open VS Code and connect to:"
echo ""
echo "ZTW-VM-OpenClaw"
echo ""
