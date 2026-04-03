# CLI Installation Guide

## Prerequisites

- WSL2 Ubuntu (or native Linux)
- Node.js >= 20 (`node -v` to check)
- npm >= 10 (`npm -v` to check)
- Git configured with user name and email

## 1. GitHub CLI (gh)

```bash
# Install
sudo apt install gh

# Authenticate
gh auth login
# Choose: GitHub.com -> HTTPS -> Login with a web browser

# Verify
gh auth status
```

**All GitHub operations must use `gh` CLI.** Never use git remote URLs directly.

## 2. Codex CLI

```bash
# Install globally
npm i -g @openai/codex

# If EACCES error, use user prefix:
npm i -g --prefix ~/.local @openai/codex

# Verify
codex --version
```

**Configuration:**
- Requires OpenAI API key or compatible provider
- Sandbox mode: `danger-full-access` for full system access
- Approval mode: `never` for autonomous execution

## 3. OpenCode CLI

```bash
# Install via official script (installs to ~/.opencode/bin/)
curl -fsSL https://opencode.ai/install | bash

# Source shell config to update PATH
source ~/.bashrc

# Verify
opencode --version
```

**Note:** If an old version exists at `/usr/local/bin/opencode` (from npm), remove it:
```bash
sudo rm /usr/local/bin/opencode
```

## 4. OpenCLI

GitHub: https://github.com/jackwener/opencli

```bash
# Install via npm (user prefix to avoid EACCES)
npm install -g --prefix ~/.local @jackwener/opencli

# Verify
opencli --version
opencli doctor  # Check extension + daemon connectivity
```

**Browser Bridge Extension (required for browser commands):**
1. Download `opencli-extension.zip` from [Releases](https://github.com/jackwener/opencli/releases)
2. Unzip, open `chrome://extensions`, enable Developer Mode
3. Click "Load unpacked" and select the unzipped folder

**Note:** If running in WSL, the browser is on Windows. The daemon runs in WSL on port 19825. WSL2 localhost forwarding usually handles this automatically.

## 5. Lark CLI (lark-cli)

```bash
# Install
npm i -g @larksuite/cli

# If EACCES, use user prefix:
npm i -g --prefix ~/.local @larksuite/cli

# Initialize (requires browser authorization)
lark-cli config init --new
# This outputs a URL - open it in browser to complete setup
# The terminal process must stay running until auth completes

# Verify
lark-cli auth status
```

**Important:** `lark-cli config init --new` is a blocking process. It must remain running while you complete browser authorization. If it exits before auth completes, the config won't be saved.

## 6. oh-my-claudecode (omc)

Follow the [official installation guide](https://github.com/anthropics/claude-code) for oh-my-claudecode plugin setup.

The `omc ask` command is the primary interface for dispatching tasks:
```bash
omc ask codex "your task here"
omc ask gemini "your task here"
omc ask opencode "your task here"
```

## Post-Install Checklist

```bash
# Run all of these to verify
gh --version          # Should show 2.x
codex --version       # Should show 0.x
opencode --version    # Should show 1.x
opencli --version     # Should show 1.x
lark-cli auth status  # Should show appId and brand
```
