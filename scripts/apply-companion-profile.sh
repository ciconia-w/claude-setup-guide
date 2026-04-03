#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE_PATH="${1:-$SCRIPT_DIR/../configs/companion-profile.json}"
TARGET_PATH="${2:-${HOME}/.claude.json}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_PATH="${TARGET_PATH}.bak.${TIMESTAMP}"

if [[ ! -f "$PROFILE_PATH" ]]; then
  echo "Profile file not found: $PROFILE_PATH" >&2
  exit 1
fi

python3 - "$PROFILE_PATH" "$TARGET_PATH" "$BACKUP_PATH" <<'PY'
import json
import shutil
import sys
from pathlib import Path

profile_path = Path(sys.argv[1])
target_path = Path(sys.argv[2])
backup_path = Path(sys.argv[3])

profile = json.loads(profile_path.read_text(encoding="utf-8"))

if target_path.exists():
    shutil.copy2(target_path, backup_path)
    current = json.loads(target_path.read_text(encoding="utf-8"))
else:
    current = {}

changed = []
if current.get("userID") != profile.get("userID"):
    changed.append("userID")
if current.get("companion") != profile.get("companion"):
    changed.append("companion")

current["userID"] = profile["userID"]
current["companion"] = profile["companion"]

target_path.write_text(json.dumps(current, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

print(f"Applied companion profile to {target_path}")
if backup_path.exists():
    print(f"Backup created at {backup_path}")
if changed:
    print("Changed keys: " + ", ".join(changed))
else:
    print("No effective changes were needed.")
PY
