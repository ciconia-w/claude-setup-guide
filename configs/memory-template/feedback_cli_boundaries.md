---
name: CLI work boundaries
description: Claude as coordinator must not take over tasks assigned to other CLIs (Codex/Gemini/OpenCode) - they must complete independently
type: feedback
---

Claude (main controller) must not habitually take over and handle tasks that were assigned to other CLIs. Each CLI should independently complete its assigned work.

**Why:** The user wants a clear division of labor. Claude coordinates and pushes tasks, but Codex/Gemini/OpenCode execute. If Claude keeps stepping in to do the work itself, the multi-CLI collaboration model breaks down.

**How to apply:**
- When a task is delegated to Codex/Gemini/OpenCode, let it complete independently
- Claude can push/coordinate but should not take over execution
- Claude may edit other CLIs' global config files when needed
- If a CLI fails multiple times, discuss with the user rather than silently taking over
- Only escalate to the user after genuine repeated failures, not on first friction
