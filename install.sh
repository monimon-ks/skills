#!/bin/bash
# Install Claude Code skills and agents into a project's .claude/ directory
# Usage: ./install.sh [target-project-path]
#   If no path given, installs to current directory's .claude/

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-.}"

# Resolve to absolute path
TARGET="$(cd "$TARGET" && pwd)"

echo "Installing Claude Code skills & agents into: $TARGET/.claude/"

# Create directories
mkdir -p "$TARGET/.claude/agents"
mkdir -p "$TARGET/.claude/skills"

# Copy agents
echo "Copying agents..."
cp -r "$SCRIPT_DIR/agents/"*.md "$TARGET/.claude/agents/"
AGENT_COUNT=$(ls "$SCRIPT_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
echo "  -> $AGENT_COUNT agents installed"

# Copy skills
echo "Copying skills..."
for skill_dir in "$SCRIPT_DIR/skills/"*/; do
  skill_name=$(basename "$skill_dir")
  mkdir -p "$TARGET/.claude/skills/$skill_name"
  cp -r "$skill_dir"* "$TARGET/.claude/skills/$skill_name/"
done
SKILL_COUNT=$(ls -d "$SCRIPT_DIR/skills/"*/ 2>/dev/null | wc -l | tr -d ' ')
echo "  -> $SKILL_COUNT skills installed"

echo ""
echo "Done! Installed $AGENT_COUNT agents and $SKILL_COUNT skills."
echo ""
echo "Available skills (trigger with /skill-name):"
for skill_dir in "$SCRIPT_DIR/skills/"*/; do
  echo "  /$(basename "$skill_dir")"
done
