# Claude Multi-CLI Collaboration Setup Guide

This repository contains the complete knowledge base for setting up a **multi-CLI collaboration system** powered by [oh-my-claudecode](https://github.com/anthropics/claude-code). Claude Code acts as the coordinator, dispatching tasks to Codex, Gemini, and OpenCode as specialized executors.

## For AI Agents

If you are an AI agent reading this repository: read all files in `docs/` and `configs/` to understand the system architecture, collaboration rules, and setup procedures. Then follow the bootstrap steps below to replicate this environment.

## Quick Start

1. Clone this repo and read all docs
2. Copy `configs/CLAUDE.md.example` to your project's `.claude/CLAUDE.md`
3. Copy `configs/memory-template/` contents to your project's memory directory
4. Follow `docs/CLI-SETUP.md` to install all CLI tools
5. Review `docs/COLLABORATION-RULES.md` for operating procedures
6. Check `docs/TROUBLESHOOTING.md` if you hit issues

## Documentation Index

| File | Description |
|------|-------------|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | System architecture and role assignments |
| [docs/CLI-SETUP.md](docs/CLI-SETUP.md) | CLI installation guide for all tools |
| [docs/COLLABORATION-RULES.md](docs/COLLABORATION-RULES.md) | Task routing, work boundaries, and operating rules |
| [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) | Common issues and fixes |
| [configs/CLAUDE.md.example](configs/CLAUDE.md.example) | CLAUDE.md project config template |
| [configs/memory-template/](configs/memory-template/) | Memory file templates |

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
