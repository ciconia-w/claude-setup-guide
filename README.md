# Claude Multi-CLI Collaboration Setup Guide

This repository contains the complete knowledge base for setting up a **multi-CLI collaboration system** powered by [oh-my-claudecode](https://github.com/anthropics/claude-code). Claude Code acts as the coordinator, dispatching tasks to Codex, Gemini, and OpenCode as specialized executors.

## For AI Agents

If you are an AI agent reading this repository: read all files in `docs/` and `configs/` to understand the system architecture, collaboration rules, setup procedures, and profile sync behavior. Then follow the bootstrap steps below to replicate this environment.

## Quick Start

1. Clone this repo and read all docs
2. Copy `configs/CLAUDE.md.example` to your project's `.claude/CLAUDE.md`
3. Copy `configs/memory-template/` contents to your project's memory directory
4. Follow `docs/CLI-SETUP.md` to install all CLI tools
5. Review `docs/COLLABORATION-RULES.md` for operating procedures
6. Optionally apply `configs/companion-profile.json` if you want the same Claude Code buddy on every machine
7. Check `docs/TROUBLESHOOTING.md` if you hit issues

## Documentation Index

| File | Description |
|------|-------------|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | System architecture and role assignments |
| [docs/CLI-SETUP.md](docs/CLI-SETUP.md) | CLI installation guide for all tools |
| [docs/COLLABORATION-RULES.md](docs/COLLABORATION-RULES.md) | Task routing, work boundaries, and operating rules |
| [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) | Common issues and fixes |
| [docs/PROFILE-SYNC.md](docs/PROFILE-SYNC.md) | Safe companion/profile sync across machines |
| [configs/CLAUDE.md.example](configs/CLAUDE.md.example) | CLAUDE.md project config template |
| [configs/memory-template/](configs/memory-template/) | Memory file templates |
| [configs/companion-profile.json](configs/companion-profile.json) | Public-safe buddy seed and companion metadata |
| [scripts/apply-companion-profile.ps1](scripts/apply-companion-profile.ps1) | Windows companion sync script |
| [scripts/apply-companion-profile.sh](scripts/apply-companion-profile.sh) | WSL/Linux companion sync script |

## Safe Profile Sync

This repo intentionally stores a **safe public companion profile** so a new machine can reproduce the same Claude Code buddy without copying private tokens around.

What is synced:

- `userID` used as Claude Code's deterministic buddy seed
- `companion.name`
- `companion.personality`
- `companion.hatchedAt`

What is **not** synced:

- API keys
- provider base URLs
- auth tokens
- local permission grants
- telemetry or machine-specific runtime state

Read [docs/PROFILE-SYNC.md](docs/PROFILE-SYNC.md) before applying the profile. The short version:

```powershell
# Windows
powershell -ExecutionPolicy Bypass -File .\scripts\apply-companion-profile.ps1
```

```bash
# WSL / Linux
bash ./scripts/apply-companion-profile.sh
```

## System Overview

```
User
 |
 v
Claude Code (Coordinator)
 |--- omc ask codex "task"  --> Codex (backend, debug, scripts, installs)
 |--- omc ask gemini "task" --> Gemini (frontend, UX, design)
 |--- omc ask opencode "task" -> OpenCode (validation, alternatives)
```

## Environment

- Primary: WSL2 Ubuntu on Windows
- All CLIs run from WSL
- Browser extensions (opencli) connect from Windows Chrome to WSL daemon
- GitHub operations exclusively via `gh` CLI

## License

MIT
