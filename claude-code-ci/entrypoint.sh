#!/usr/bin/env bash
set -euo pipefail

# CI defaults — override via environment variables
CLAUDE_MAX_BUDGET="${CLAUDE_MAX_BUDGET:-0.20}"
CLAUDE_MAX_TURNS="${CLAUDE_MAX_TURNS:-10}"
CLAUDE_MODEL="${CLAUDE_MODEL:-claude-haiku-4-5-20251001}"
CLAUDE_OUTPUT_FORMAT="${CLAUDE_OUTPUT_FORMAT:-stream-json}"
CLAUDE_TOOLS="${CLAUDE_TOOLS:-default}"
CLAUDE_ALLOWED_TOOLS="${CLAUDE_ALLOWED_TOOLS:-}"
CLAUDE_VERBOSE="${CLAUDE_VERBOSE:-1}"

# test if CLAUDE_PROMPT is set, otherwise exit with an error
if [ -z "${CLAUDE_PROMPT:-}" ]; then
    echo "Error: CLAUDE_PROMPT environment variable is not set" >&2
    exit 1
fi

args=(
    --max-budget-usd "$CLAUDE_MAX_BUDGET"
    --max-turns "$CLAUDE_MAX_TURNS"
    --model "$CLAUDE_MODEL"
    --output-format "$CLAUDE_OUTPUT_FORMAT"
    --permission-mode "dontAsk"
    --print
    --tools "$CLAUDE_TOOLS"
)

if [ -n "$CLAUDE_ALLOWED_TOOLS" ]; then
  IFS=',' read -ra ALLOWED <<< "$CLAUDE_ALLOWED_TOOLS"
  for tool in "${ALLOWED[@]}"; do
    tool="$(echo "$tool" | xargs)"  # trim whitespace
    args+=(--allowedTools "$tool")
  done
fi

if [ "$CLAUDE_VERBOSE" = "1" ]; then
    args+=(--verbose)
fi

exec claude "${args[@]}" "$CLAUDE_PROMPT"
