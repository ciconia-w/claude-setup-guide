# Companion Profile Sync

This repo stores a **public-safe Claude Code companion profile** so the same buddy can be restored on a fresh machine.

## What This Syncs

- `userID` in `~/.claude.json`
- `companion.name`
- `companion.personality`
- `companion.hatchedAt`

Those values are enough to make Claude Code compute the same deterministic buddy appearance and keep the same name/personality.

## What This Does Not Sync

- `~/.claude/settings.json` with API keys or provider URLs
- `~/.claude/settings.local.json`
- local permission prompts
- session history, telemetry, cache, or machine-specific state

That split is deliberate. This repository is public. A good profile repo can store reproducible behavior, but it should not become a token graveyard.

## Public Repo Tradeoff

This profile publishes the Claude Code `userID` seed on purpose.

Why:

- Claude Code derives the buddy from deterministic account data
- writing only `companion.name` is not enough to preserve the visual buddy
- storing the seed is lower-maintenance than patching Claude binaries on every machine

What it is not:

- not an API key
- not a provider token
- not enough to log into anything by itself

If you do not want the buddy seed public, do not apply this profile.

## Apply On Windows

From the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\apply-companion-profile.ps1
```

The script:

1. Reads `configs/companion-profile.json`
2. Backs up `%USERPROFILE%\.claude.json`
3. Updates only `userID` and `companion`
4. Leaves all other local fields untouched

## Apply On WSL / Linux

From the repository root:

```bash
bash ./scripts/apply-companion-profile.sh
```

For dry-run style verification, point the script at a temp file:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\apply-companion-profile.ps1 -TargetPath "$env:TEMP\claude.json"
```

```bash
bash ./scripts/apply-companion-profile.sh ./configs/companion-profile.json /tmp/claude.json
```

The shell script does the same thing against `~/.claude.json`.

## Rollback

Both scripts write timestamped backups next to `~/.claude.json`.

Examples:

```text
~/.claude.json.bak.20260403-220501
%USERPROFILE%\.claude.json.bak.20260403-220501
```

Restore by copying the backup back over `~/.claude.json`.

## Recommended Use

- Use this on your own machines
- Run it after first-time Claude Code install
- Re-run it if you ever reset `~/.claude.json`

Do not expect this profile alone to recreate your full Claude setup. It is the **safe public piece** of the setup, not the secret local piece.
