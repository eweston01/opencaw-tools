#!/bin/bash

echo "--------------------------------"
echo "OpenClaw VM Setup for Zach"
echo "--------------------------------"

# Ensure .ssh directory exists
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

# Only add config if it doesn't exist
if ! grep -q "ZTW-VM-OpenClaw" ~/.ssh/config 2>/dev/null; then
cat <<CONFIG >> ~/.ssh/config

Host ZTW-VM-OpenClaw
    HostName vm-openclaw-ztw.swordfish-bigeye.ts.net
    User zach
    IdentityFile ~/.ssh/ztw_ed25519

CONFIG
fi

echo ""
echo "Checking for VS Code..."

if ! command -v code &> /dev/null
then
    echo "VS Code CLI not found."
    echo "If VS Code is installed, open it and run:"
    echo ""
    echo "Command Palette → 'Shell Command: Install \"code\" command in PATH'"
else
    echo "Installing VS Code Remote SSH extension..."
    code --install-extension ms-vscode-remote.remote-ssh || true
fi

echo ""
echo "--------------------------------"
echo "Setup Complete"
echo "--------------------------------"

echo ""
echo "Run this ONE command to authorize your key:"
echo ""

echo "ssh-copy-id -i ~/.ssh/ztw_ed25519.pub zach@vm-openclaw-ztw.swordfish-bigeye.ts.net"

echo ""
echo "If ssh-copy-id is not installed run instead:"
echo ""

echo "cat ~/.ssh/ztw_ed25519.pub | ssh zach@vm-openclaw-ztw.swordfish-bigeye.ts.net 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'"

echo ""
echo "After that open VS Code and connect to:"
echo ""
echo "ZTW-VM-OpenClaw"
echo ""
