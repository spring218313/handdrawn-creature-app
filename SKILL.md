---
name: handdrawn-creature-app
description: 快速复刻/定制「Who are you?」手绘生物生成应用（通用 Agent skill，适用于 Codex / Claude Code / workBuddy / Trae 等）。输入用户名 → 确定性生成一只铅笔手绘小生物（简笔线稿头 + 单色填色身体 + 小弧形手 + 棍子腿），带待机轻晃/跳跃/挥手动效和鼠标入画时脸部跟随。模板在 assets/template-index.html，单文件零依赖。触发词：手绘生物、用户名生成角色、Who are you、手绘头像应用、复刻这个生物应用。
---

# Hand-Drawn Creature App

从「Who are you?」项目沉淀的单文件应用模板：输入名字 → 哈希 → 确定性生成一只极简铅笔手绘生物。

## 安装 / Install

本 skill 遵循通用 Agent skill 目录格式（文件夹 + SKILL.md），可安装到任意 Agent 的技能目录：

```bash
# 方式一：一键脚本（在仓库目录内执行，目标目录自选）
bash install.sh ~/.agents/skills   # 通用 / workBuddy / Trae 等
bash install.sh ~/.codex/skills    # Codex
bash install.sh ~/.claude/skills   # Claude Code

# 方式二：直接克隆到技能目录
git clone https://github.com/Tree-oil/handdrawn-creature-app ~/.agents/skills/handdrawn-creature-app

# 方式三：手动复制本文件夹到任意 Agent 的技能目录
```

## 快速复刻

1. 把 assets/template-index.html 复制到目标目录（单文件，零依赖）。
2. 在目标目录启动本地服务：python3 -m http.server 8765 --bind 127.0.0.1，浏览器打开 http://127.0.0.1:8765/（直接 file:// 打开也可运行）。
3. 按下方「定制点」修改，刷新即可看效果。

## 定制点（都在 template-index.html 的 <script> 内）

### 生成规则

- hash(str) + mulberry32(seed) + pick/chance：名字 → 32 位哈希 → 伪随机数生成器 → 依次抽取特征。同名字永远同生物，改一个字符就完全不同。
- makeCreature('') 是固定默认角色（绿色、下垂大耳、草状发、点眼、微笑）。想换默认角色就改这段。

### 特征库

- BODY_COLORS：身体颜色数组（8 种），改这里换配色。
- EARS / HAIR / EYES / MOUTHS / ARMS / BROW：特征取值数组。新增特征 = 往数组加一项，并在对应 drawXxx 函数里补绘制分支。
- IRIS：瞳孔颜色。

### 动效

- render() 顶部的常量：sway（身体轻晃幅度/频率）、headTilt（头部轻晃 + 跟随鼠标的倾斜）、armIdle（待机手臂摆动）、hopY / jumpRaise（跳跃高度）、armWave（挥手幅度）。
- tick() 里 actionT 控制小动作间隔（跳跃约 45% / 挥手约 55%），mouseleave / mouseOnScreen 控制「鼠标离开后恢复待机」。
- 跟随幅度：drawFace 里 gx/gy 是脸部偏移，头随鼠标平移在 render() 的 head 变换里（gaze.x * 2.2）。

### 布局

- h1 标题、.inputWrap 输入框位置在 CSS 里改（bottom / top 百分比）。
- 角色整体缩放与居中在 render() 的 setTransform（sc / tx / ty）。

## 验证

- 浏览器打开后检查：控制台无报错、输入名字即时换角色、同一名字刷新后一致、鼠标入画脸部跟随、移出后恢复待机轻晃。
- 确定性可重复：同一名字两次生成应逐像素一致（抖动基于顶点序号，不随时间变化）。

## 示例输出

examples/live-default.png（默认角色）、examples/live-alex.png（名字 alex）。项目本体即本 skill 的来源，完整历史见 /Users/Code/Web/X-UI/who-are-you。
