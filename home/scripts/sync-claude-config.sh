#!/bin/bash
set -euo pipefail

# Copies the portable Claude Code config tracked in this repo (skills,
# commands, output-styles, preference settings) into ~/.claude on this
# machine. Safe to re-run any time to pick up updates.

REPO_CLAUDE="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.claude" && pwd)"
TARGET_CLAUDE="$HOME/.claude"

mkdir -p "$TARGET_CLAUDE"

echo "Syncing skills, commands and output-styles into $TARGET_CLAUDE ..."
mkdir -p "$TARGET_CLAUDE/skills" "$TARGET_CLAUDE/commands" "$TARGET_CLAUDE/output-styles"
cp -r "$REPO_CLAUDE/skills/." "$TARGET_CLAUDE/skills/"
cp -r "$REPO_CLAUDE/commands/." "$TARGET_CLAUDE/commands/"
cp -r "$REPO_CLAUDE/output-styles/." "$TARGET_CLAUDE/output-styles/"

echo "Merging settings.json ..."
if command -v jq >/dev/null 2>&1 && [ -f "$TARGET_CLAUDE/settings.json" ]; then
  # merge repo settings on top of any existing local settings.json,
  # keeping machine-specific keys (e.g. autoMode) that aren't in the repo file
  jq -s '.[0] * .[1]' "$TARGET_CLAUDE/settings.json" "$REPO_CLAUDE/settings.json" \
    > "$TARGET_CLAUDE/settings.json.new"
  mv "$TARGET_CLAUDE/settings.json.new" "$TARGET_CLAUDE/settings.json"
else
  cp "$REPO_CLAUDE/settings.json" "$TARGET_CLAUDE/settings.json"
fi

echo "Claude config synced."
