#!/bin/bash
set -euo pipefail
TARGET="${1:-}"
SRC="$(cd "$(dirname "$0")" && pwd)"
SKILL="$(basename "$SRC")"

if [ -z "$TARGET" ]; then
  echo "用法: bash install.sh <Agent 技能目录>"
  echo
  echo "示例:"
  echo "  bash install.sh ~/.agents/skills   # 通用 / workBuddy / Trae 等"
  echo "  bash install.sh ~/.codex/skills    # Codex"
  echo "  bash install.sh ~/.claude/skills   # Claude Code"
  exit 1
fi

mkdir -p "$TARGET/$SKILL"
rsync -a --exclude .git --exclude .gitignore "$SRC/" "$TARGET/$SKILL/"
echo "已安装到 $TARGET/$SKILL"
echo "重启对应 Agent 后即可调用该 skill。"
