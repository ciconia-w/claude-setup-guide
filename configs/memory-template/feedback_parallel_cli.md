---
name: 多CLI并行不要阻塞
description: 派发任务给 codex/gemini/opencode 时应后台运行，自己继续做其他工作
type: feedback
---

派发任务给其他 CLI（codex/gemini/opencode）时，不要同步等待结果阻塞。应该后台运行，空出来继续做其他事。

**Why:** 多模型协作的核心就是并行，同步等待浪费了主 agent 的时间。
**How to apply:** 使用 `run_in_background: true` 或 `&` 后台执行 `omc ask` 命令，同时继续处理用户的其他请求。
