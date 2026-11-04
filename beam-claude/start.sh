#!/bin/bash
set -euo pipefail
mkdir -p "$HOME/.claude/projects" "$CLAUDE_CONFIG_DIR"
install -d -m 0700 /run/claude/secrets

# CLAUDE_CONFIG_DIR is in memory: logins and tokens never reach the PVC.
# Only these non-secret parts link to the PVC.
for name in projects settings.json CLAUDE.md keybindings.json agents skills plugins; do
  ln -sfn "$HOME/.claude/$name" "$CLAUDE_CONFIG_DIR/$name"
done
cd "$HOME"
exec claude daemon run
