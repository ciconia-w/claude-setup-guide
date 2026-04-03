# Collaboration Rules

## Core Principle

**Claude coordinates. Other CLIs execute.**

Claude Code is the brain. Codex, Gemini, and OpenCode are the hands. Claude should never habitually take over tasks assigned to other CLIs.

## Task Routing

| Task Type | Assign To | Example |
|-----------|-----------|---------|
| Backend code, bug fixes | Codex | `omc ask codex "fix the auth middleware bug"` |
| System admin, installs | Codex | `omc ask codex "install opencli from github"` |
| Frontend, UI/UX | Gemini | `omc ask gemini "improve the login page design"` |
| Code review | Codex | `omc ask codex "review this PR for security issues"` |
| Cheap validation | OpenCode | `omc ask opencode "verify the test results"` |
| Multi-perspective | Parallel | Run multiple `omc ask` commands simultaneously |

## Dispatching Tasks

```bash
# Foreground (blocks until complete)
omc ask codex "task description"

# Background (returns immediately, notifies on completion)
# Use run_in_background when calling from Claude Code
```

## Work Boundaries

1. **Never take over** — If Codex is assigned a task, let Codex finish it
2. **Push, don't pull** — Claude can nudge/retry but not do the work itself
3. **Config editing allowed** — Claude may edit other CLIs' global config files
4. **Escalate after failures** — If a CLI fails 3+ times, discuss with user
5. **Don't silently switch** — Never quietly take over a failed CLI task

## GitHub Operations

**ALL GitHub operations MUST use `gh` CLI:**
```bash
gh repo create        # Create repository
gh pr create          # Create pull request
gh issue list         # List issues
gh repo clone         # Clone repository
gh api <endpoint>     # Direct API calls
```

Never use `git remote` URLs or raw HTTPS URLs for GitHub operations.

## Skill Management

1. Search: Use `find-skills` skill first
2. Vet: All installations go through `skill-vetter`
3. Create: Use `skill-creator` skill, never create manually

## Error Recovery

When a CLI task fails:
1. Check if it's a tmpfs issue (`No space left on device`) — clean and retry
2. Check if it's a permission issue — fix permissions and retry
3. If the same error repeats 3 times, stop and discuss with user
4. Never bypass safety checks or use destructive workarounds

## Parallel Workflows

For tasks that benefit from multiple perspectives:
```
Claude analyzes task
  |
  |-- omc ask codex "backend analysis"    (parallel)
  |-- omc ask gemini "frontend analysis"  (parallel)
  |-- omc ask opencode "alternative view" (parallel)
  |
Claude synthesizes all results
  |
  v
Report to user
```
