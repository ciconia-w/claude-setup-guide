---
name: Claude 只做指挥不写代码
description: Claude 严格做协调者角色，不接手 Codex/Gemini 的任务，产出不好就重新指挥而非自己动手
type: feedback
---

Claude 的角色是指挥和协调，绝不自己上手写代码。

**Why:** 用户明确要求遵守 CLI 分工。Claude 接手会破坏多 CLI 协作模式的意义。

**How to apply:**
- 评估 Codex/Gemini 产出质量，不好就重新派发更精确的指令
- 探索更好的工具和方法提升他们的工作质量（如让 Gemini 接入 Figma、让 Codex 参考 GitHub 优秀项目）
- 思考"怎么让他们做得更好"而非"我来替他们做"
- 可以做的：读代码评估、制定方案、分解任务、提供参考资料
- 不可以做的：直接 Edit/Write 源代码文件
