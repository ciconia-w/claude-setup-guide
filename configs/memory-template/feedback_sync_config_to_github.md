---
name: 本地重要配置修改必须同步到 GitHub
description: 修改本地重要配置（CLAUDE.md、settings.json、skills、hooks等）后，必须同步更新 ciconia-w/claude-setup-guide 仓库
type: feedback
---

修改本地重要配置后，必须同步更新 GitHub 上的 ciconia-w/claude-setup-guide 仓库。

**Why:** 该仓库的作用是让用户在任何电脑上启动 Claude Code 都能获得最佳配置。本地改了不同步会导致其他机器用的还是旧配置。

**How to apply:**
- 当修改了以下类型的文件时触发同步：
  - CLAUDE.md（项目指令）
  - ~/.claude/ 下的 settings.json、hooks、skills
  - omc 相关配置
  - 任何影响 Claude Code 工作方式的配置
- 同步方式：用 `gh` CLI 将改动推送到 ciconia-w/claude-setup-guide
- 不需要每次小改都同步，但重要配置变更必须同步
- 同步时简要说明改了什么
