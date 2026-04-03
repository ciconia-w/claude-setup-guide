# Troubleshooting Guide

## 1. tmpfs Space Exhaustion

**Symptom:**
```
cp: error writing '/run/user/1001/codex-linux-XXXX': No space left on device
```

**Cause:** Codex creates temp files in `/run/user/<uid>/` which fill up the tmpfs.

**Immediate Fix:**
```bash
rm -rf /run/user/$(id -u)/codex-linux-*
df -h /run/user/$(id -u)
```

**Temporary Expansion:**
```bash
sudo mount -o remount,size=2G /run/user/$(id -u)
```

**Permanent Fix (survives reboot):**
```bash
# Create systemd-logind override
sudo mkdir -p /etc/systemd/logind.conf.d
sudo tee /etc/systemd/logind.conf.d/99-runtime-directory-size.conf << 'EOF'
[Login]
RuntimeDirectorySize=2G
EOF
sudo systemctl restart systemd-logind
```

**If sudo requires password and you can't use it:**
```bash
# From WSL, use wsl.exe to run as root
wsl.exe -u root bash -c 'mkdir -p /etc/systemd/logind.conf.d && cat > /etc/systemd/logind.conf.d/99-runtime-directory-size.conf << EOF
[Login]
RuntimeDirectorySize=2G
EOF'
```

## 2. npm Global Install Permission Denied (EACCES)

**Symptom:**
```
npm error EACCES: permission denied, mkdir '/usr/local/lib/nodejs/.../node_modules/@package'
```

**Fix:** Use user-level prefix:
```bash
npm install -g --prefix ~/.local <package>
```

Ensure `~/.local/bin` is in PATH (add to `~/.bashrc` if not):
```bash
export PATH="$HOME/.local/bin:$PATH"
```

## 3. ~/.config or ~/.local/share Permission Denied

**Symptom:** CLI tools can't create config directories.

**Cause:** Directory owned by root instead of user.

**Fix:**
```bash
sudo chown -R $USER:$USER ~/.config
sudo chown -R $USER:$USER ~/.local/share
```

## 4. Codex Bubblewrap Warning

**Symptom:**
```
warning: Codex could not find system bubblewrap on PATH
```

**Impact:** None. Codex uses vendored bubblewrap automatically. Safe to ignore.

**Optional fix:**
```bash
sudo apt install bubblewrap
```

## 5. WSL sudo Password Forgotten

**Fix from Windows PowerShell:**
```powershell
wsl -u root passwd <username>
```

## 6. Passwordless sudo for mount

**For mount only (recommended):**
```bash
echo "$USER ALL=(ALL) NOPASSWD: /bin/mount" | sudo tee /etc/sudoers.d/$USER-mount
sudo chmod 440 /etc/sudoers.d/$USER-mount
```

**For all commands (less secure):**
```bash
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
sudo chmod 440 /etc/sudoers.d/$USER
```

## 7. lark-cli Config Not Saved

**Symptom:** `lark-cli auth status` shows "not configured" after browser auth.

**Cause:** The `lark-cli config init --new` process must stay running during browser auth. If it's killed before auth completes, config isn't saved.

**Fix:**
1. Check `~/.local/share` permissions (see #3)
2. Run `lark-cli config init --new` in a terminal
3. Keep it running, complete browser auth
4. Wait for "OK: config success" message before closing

## 8. OpenCode Old Version in PATH

**Symptom:** `opencode --version` shows old version after installing new one.

**Cause:** Old npm-installed version at `/usr/local/bin/opencode` takes precedence over new one at `~/.opencode/bin/opencode`.

**Fix:**
```bash
sudo rm /usr/local/bin/opencode
source ~/.bashrc
opencode --version  # Should show new version
```

## 9. gh CLI Authentication Lost

**Symptom:**
```
fatal: could not read Username for 'https://github.com'
```

**Fix:**
```bash
gh auth login
gh auth status  # Verify
```

If `~/.config/gh` has permission issues, use alternative config dir:
```bash
export GH_CONFIG_DIR=~/.cache/gh-config
gh auth login
```

## 10. opencli Browser Extension Not Connected

**Symptom:** `opencli doctor` shows "Extension: not connected"

**Cause:** Browser on Windows, daemon on WSL — network connectivity issue.

**Check:**
1. Open `http://localhost:19825/status` in Windows browser
2. If accessible, extension should auto-connect
3. If not, check WSL2 localhost forwarding and Windows firewall on port 19825
