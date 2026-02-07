#!/usr/bin/env bash
set -euo pipefail

# CI defaults — override via environment variables
CLAUDE_MODEL="${CLAUDE_MODEL:-claude-haiku-4-5-20251001}"
CLAUDE_MAX_TURNS="${CLAUDE_MAX_TURNS:-10}"
CLAUDE_MAX_BUDGET="${CLAUDE_MAX_BUDGET:-0.20}"
CLAUDE_VERBOSE="${CLAUDE_VERBOSE:-1}"
CLAUDE_OUTPUT_FORMAT="${CLAUDE_OUTPUT_FORMAT:-json}"

# test if CLAUDE_PROMPT is set, otherwise exit with an error
if [ -z "${CLAUDE_PROMPT:-}" ]; then
    echo "Error: CLAUDE_PROMPT environment variable is not set" >&2
    exit 1
fi

args=(
    --print
    --permission-mode "dontAsk"
    --model "$CLAUDE_MODEL"
    --max-turns "$CLAUDE_MAX_TURNS"
    --max-budget-usd "$CLAUDE_MAX_BUDGET"
    --output-format "$CLAUDE_OUTPUT_FORMAT"
)

if [ "$CLAUDE_VERBOSE" = "1" ]; then
    args+=(--verbose)
fi

exec claude "${args[@]}" "$CLAUDE_PROMPT"
