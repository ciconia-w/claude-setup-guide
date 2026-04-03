# System Architecture

## Role Assignments

### Claude Code (Coordinator)
- Plans and coordinates all work
- Dispatches tasks to specialist CLIs via `omc ask <provider> "task"`
- Synthesizes results from multiple CLIs
- Does NOT execute implementation tasks directly
- May edit global config files for other CLIs
- Escalates to user only after genuine repeated failures

### Codex (Backend Executor)
- Backend development, bug fixing, debugging
- Refactoring, scripts, tests
- Code review
- System administration (installs, configs)
- Model: GPT-5.4 via `codex` CLI

### Gemini (Frontend Executor)
- Frontend development, UI polish
- Design ideas, visual review
- Copy writing, product-facing flows
- Model: Gemini via `gemini` CLI

### OpenCode (Utility Executor)
- Low-cost parallel validation checks
- Random testing, alternative implementations
- Extra opinions and second perspectives
- Model: configurable via `opencode` CLI

## Task Flow

```
1. User gives task to Claude
2. Claude analyzes task and selects appropriate CLI(s)
3. Claude dispatches via: omc ask <cli> "task description"
4. CLI executes independently (may run in background)
5. Claude receives result notification
6. Claude synthesizes and reports to user
```

## Parallel Execution

Multiple CLIs can run simultaneously:
```bash
# These run in parallel
omc ask codex "analyze backend code" &
omc ask gemini "review UI components" &
omc ask opencode "run validation tests" &
```

## Persistence

Task artifacts are stored under `.omc/artifacts/ask/` with naming convention:
```
<provider>-<task-slug>-<timestamp>.md
```

## Work Boundaries (Critical Rule)

Claude as coordinator must NEVER take over tasks assigned to other CLIs:
- Tasks delegated to Codex/Gemini/OpenCode must be completed by them independently
- Claude can push/coordinate but should not take over execution
- If a CLI fails multiple times, discuss with user rather than silently taking over
- Only escalate after genuine repeated failures, not on first friction
